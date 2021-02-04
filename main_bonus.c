/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_bonus.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/04 00:03:58 by smun              #+#    #+#             */
/*   Updated: 2021/02/05 02:56:44 by smun             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <libasm_bonus.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <stdlib.h>

#define GRAY	write(1, "\x1b[0m", 4)
#define YELLOW	write(1, "\x1b[33m", 5)
#define GREEN	write(1, "\x1b[32m", 5)
#define WHITE	write(1, "\x1b[37m", 5)

static int		ft_strlen_c(const char *s)
{
	int			len;

	len = 0;
	while (*(s++))
		len++;
	return (len);
}

static char		*ft_memchr_c(char *s, int chr, int len)
{
	while (*s && len--)
	{
		if (*s == chr)
			return (s);
		s++;
	}
	return (0);
}

static int		is_valid_base_c(char *base)
{
	int			len;
	int			i;

	len = ft_strlen_c(base);
	if (len <= 1)
		return (0);
	i = 0;
	while (i < len)
	{
		if (ft_memchr_c("+-", base[i], 2))
			return (0);
		if (ft_memchr_c("\t\n\v\f\r ", base[i], 6))
			return (0);
		if (i > 0)
			if (ft_memchr_c(&base[0], base[i], i))
				return (0);
		i++;
	}
	return (1);
}

static int		cvt_by_base_c(char *str, char *base, int blen)
{
	int			nbr;
	char		*pos;
	int			i;

	nbr = 0;
	while (*str)
	{
		pos = ft_memchr_c(base, *str, blen);
		if (!pos)
			break ;
		i = (int)(pos - base);
		nbr = nbr * blen + i;
		str++;
	}
	return (nbr);
}


void		ft_list_push_front_c(t_list **begin_list, void *data)
{
	t_list	*lst;

	if (!begin_list)
		return ;
	if (!(lst = malloc(sizeof(t_list))))
		return ;
	lst->data = data;
	lst->next = *begin_list;
	*begin_list = lst;
}

int			ft_list_size_c(t_list *begin_list)
{
	int		i;

	i = 0;
	while (begin_list)
	{
		i++;
		begin_list = begin_list->next;
	}
	return (i);
}

static void	swap_c(t_list *a, t_list *b)
{
	void	*data;

	data = a->data;
	a->data = b->data;
	b->data = data;
}

void		ft_list_sort_c(t_list **begin_list, int (*cmp)())
{
	t_list	*lst;
	t_list	*lst2;

	if (begin_list == NULL || !(lst = *begin_list))
		return ;
	while (lst)
	{
		lst2 = *begin_list;
		while (lst2->next)
		{
			if (cmp(lst2->data, lst2->next->data) > 0)
				swap_c(lst2, lst2->next);
			lst2 = lst2->next;
		}
		lst = lst->next;
	}
}

void		ft_list_remove_if_c(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
{
	t_list	*prev;
	t_list	*lst;
	t_list	*tmp;

	if (begin_list == NULL || !(lst = *begin_list))
		return ;
	prev = NULL;
	while (lst)
	{
		if (!cmp(lst->data, data_ref))
		{
			if (prev)
				prev->next = lst->next;
			else
				*begin_list = lst->next;
			tmp = lst;
			lst = lst->next;
			free_fct(tmp->data);
			free(tmp);
		}
		else
		{
			prev = lst;
			lst = lst->next;
		}
	}
}

int				ft_atoi_base_c(char *str, char *base)
{
	int			blen;
	int			neg;

	if (!is_valid_base_c(base))
		return (0);
	while (ft_memchr_c("\t\n\v\f\r ", *str, 6))
		str++;
	neg = 1;
	while (*str == '-' || *str == '+')
		if (*(str++) == '-')
			neg = -neg;
	blen = ft_strlen_c(base);
	return ((cvt_by_base_c(str, base, blen)) * neg);
}

static void		do_test_ft_atoi_base(char *str, char *base)
{
	printf("[ %10s] %d\n", "c piscine", ft_atoi_base_c(str, base));
	printf("[ %10s] %d\n", "libasm", ft_atoi_base(str, base));
	printf("\n");
}

static void		test_ft_atoi_base(void)
{
	do_test_ft_atoi_base("10", "011");
	do_test_ft_atoi_base("10111", "\t541");
	do_test_ft_atoi_base("10111", "98\n541");
	do_test_ft_atoi_base("10111", "54 1");
	do_test_ft_atoi_base("1234567890", "0123456789");
	do_test_ft_atoi_base("10000000000000000", "01");
	do_test_ft_atoi_base("5F5E100", "0123456789ABCDEF");
	do_test_ft_atoi_base("104134211161", "0123456");
	do_test_ft_atoi_base("-13344223434043", "01234");
	do_test_ft_atoi_base("5EHNCKA", "0123456789ABCDEFGHIJKLMNOPQ");

	do_test_ft_atoi_base("!@#$%^&*()", ")!@#$%^&*(");
	do_test_ft_atoi_base("IOOOOOOOOOOOOOOOO", "OI");
	do_test_ft_atoi_base("<C<B\"\'\'", "\'\"\?>.<,QWERT ABC");

	do_test_ft_atoi_base("Qa QR qQQQtQ", "aQqR Tt");
	do_test_ft_atoi_base("-_{{}}||{}{}=}{", "=_|{}");
	do_test_ft_atoi_base("D'ws;t4", "ZXCS DF12345;:'\"qwertyas@#$");
	do_test_ft_atoi_base("^$O$M", "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#$%^&*()_= ");

	do_test_ft_atoi_base("!", "!@#$");

	do_test_ft_atoi_base("123456", "1234563");
	do_test_ft_atoi_base("1234", "12345-64");
	do_test_ft_atoi_base("1234", "12345678+");
	do_test_ft_atoi_base("", "1");
	do_test_ft_atoi_base("12345", "");
	do_test_ft_atoi_base("12345", "a12356a7");

	do_test_ft_atoi_base("     \t\v\f     +---------++-1235aaa776644", "a123567");
	do_test_ft_atoi_base("     \n\r\t     +---------++-1235aaa7766"  , "a123567");
	do_test_ft_atoi_base("            +----8----++-1235aaa7766", "a123567");
}

static void		print_list(t_list *lst, const char *t, const char *find)
{
	int			i;
	int			loremcnt;

	i = 0;
	loremcnt = 0;
	while (lst)
	{
		printf("[ %10s %3d. ]: %-12s\x1b[33m", t, ++i, (const char*)lst->data);
		if (find && !strcmp(lst->data, find))
			printf(" (Found %d %s)", ++loremcnt, find);
		printf("\x1b[0m\n");
		lst = lst->next;
	}
}

static void		ft_list_clear(t_list **begin_list, void(*free_fct)(void *))
{
	t_list		*tmp;
	t_list		*lst;

	if (!begin_list || !(lst = *begin_list))
		return ;
	while (lst)
	{
		tmp = lst;
		lst = lst->next;
		free_fct(tmp->data);
		free(tmp);
	}
	*begin_list = NULL;
}

static void		my_free(void *data)
{
	printf("t_list elem freed successfully: %s\n", (const char*)data);
	free(data);
}

static void		do_ft_list_remove_if(const char *t, void (*func_remove_if)())
{
	t_list		*lst;

	lst = NULL;
	ft_list_push_front_c(&lst, strdup("Lorem"));
	ft_list_push_front_c(&lst, strdup("lorem"));
	ft_list_push_front_c(&lst, strdup("ipsum"));
	ft_list_push_front_c(&lst, strdup("Lorem"));
	ft_list_push_front_c(&lst, strdup("dolor"));
	ft_list_push_front_c(&lst, strdup("sit"));
	ft_list_push_front_c(&lst, strdup("amet"));
	ft_list_push_front_c(&lst, strdup("Lorem"));
	ft_list_push_front_c(&lst, strdup("consectetur"));
	ft_list_push_front_c(&lst, strdup("adipiscing"));
	ft_list_push_front_c(&lst, strdup("Lorem"));
	ft_list_push_front_c(&lst, strdup("elit"));
	ft_list_push_front_c(&lst, strdup("Aliquam"));
	ft_list_push_front_c(&lst, strdup(""));
	ft_list_push_front_c(&lst, strdup("Lorem"));
	ft_list_push_front_c(&lst, strdup("lacinia"));
	ft_list_push_front_c(&lst, strdup("massa"));
	ft_list_push_front_c(&lst, strdup("Lorem"));
	ft_list_push_front_c(&lst, strdup(""));
	ft_list_push_front_c(&lst, strdup("dapibus"));
	ft_list_push_front_c(&lst, strdup("Lorem"));
	ft_list_push_front_c(&lst, strdup("porta"));
	ft_list_push_front_c(&lst, strdup("erat"));
	ft_list_push_front_c(&lst, strdup("sit"));
	ft_list_push_front_c(&lst, strdup("Lorem"));
	ft_list_push_front_c(&lst, strdup("Lorem"));
	ft_list_push_front_c(&lst, strdup("Lorem"));
	print_list(lst, t, "Lorem");
	printf("-------------------------------\n");
	func_remove_if(&lst, "Lorem", &strcmp, &my_free);
	print_list(lst, t, "Lorem");
	ft_list_clear(&lst, &free);
}

static void		test_ft_list_remove_if(void)
{

	GREEN;
	printf("To display a C Piscine's function's result, Press an enter key!");
	getchar();
	GRAY;
	do_ft_list_remove_if("c piscine", &ft_list_remove_if_c);
	WHITE;
#ifndef ASAN
	printf("\n\n === [[ MemoryLeak Tesk (leaks) ]] ===\n\n");
	system("leaks mainb");
#endif
	GREEN;

	printf("To test LIBASM's function, Press an enter key!");
	getchar();
	GRAY;
	do_ft_list_remove_if("libasm", &ft_list_remove_if);
	WHITE;
#ifndef ASAN
	printf("\n\n === [[ MemoryLeak Tesk (leaks) ]] ===\n\n");
	system("leaks mainb");
#endif
	GREEN;
}

static void		do_ft_list_push_front(const char *t, void (*func_push_front)())
{
	t_list		*lst;

	lst = NULL;
	func_push_front(&lst, strdup(""));
	func_push_front(&lst, strdup("lorem"));
	func_push_front(&lst, strdup("ipsum"));
	func_push_front(&lst, strdup("dolor"));
	func_push_front(&lst, strdup("sit"));
	func_push_front(&lst, strdup("amet"));
	func_push_front(&lst, strdup(""));
	func_push_front(&lst, strdup(""));
	func_push_front(&lst, strdup(""));
	print_list(lst, t, NULL);
	ft_list_clear(&lst, &my_free);
}

static void		test_ft_list_push_front(void)
{
	GREEN;
	printf("To display a C Piscine's function's result, Press an enter key!");
	getchar();
	GRAY;
	do_ft_list_push_front("c piscine", &ft_list_push_front_c);
	GREEN;

	printf("To test LIBASM's function, Press an enter key!");
	getchar();
	GRAY;
	do_ft_list_push_front("libasm", &ft_list_push_front);
	GREEN;
}

static void		do_ft_list_size(const char *t, int (*func_list_size)())
{
	char		buf[32];
	t_list		*lst;
	int			i;

	lst = NULL;
	printf("[ %10s ]: count %5d.\x1b[33m", t, func_list_size(lst));
	printf("\x1b[0m\n");
	i = 0;
	while (i < 32768)
	{
		sprintf(buf, "lorem-%d", i++);
		ft_list_push_front_c(&lst, strdup(buf));
	}
	printf("[ %10s ]: count %5d.\x1b[33m", t, func_list_size(lst));
	printf("\x1b[0m\n");
	ft_list_clear(&lst, &free);
	printf("[ %10s ]: count %5d.\x1b[33m", t, func_list_size(lst));
	printf("\x1b[0m\n");
}

static void		test_ft_list_size(void)
{
	GREEN;
	printf("To display a C Piscine's function's result, Press an enter key!");
	getchar();
	GRAY;
	do_ft_list_size("c piscine", &ft_list_size_c);
	GREEN;

	printf("To test LIBASM's function, Press an enter key!");
	getchar();
	GRAY;
	do_ft_list_size("libasm", &ft_list_size);
	GREEN;
}

static void		do_ft_list_sort(const char *t, void (*func_list_sort)(), int (*cmp)())
{
	t_list		*lst;

	lst = NULL;
	ft_list_push_front_c(&lst, strdup("N4ZS"));
	ft_list_push_front_c(&lst, strdup("VE"));
	ft_list_push_front_c(&lst, strdup("GTIurC0teHoJ"));
	ft_list_push_front_c(&lst, strdup("B1JKR"));
	ft_list_push_front_c(&lst, strdup("JtDHW"));
	ft_list_push_front_c(&lst, strdup("NDmFi"));
	ft_list_push_front_c(&lst, strdup("PM"));
	ft_list_push_front_c(&lst, strdup("A"));
	ft_list_push_front_c(&lst, strdup("d"));
	ft_list_push_front_c(&lst, strdup("oE"));
	ft_list_push_front_c(&lst, strdup("oU"));
	ft_list_push_front_c(&lst, strdup("FNb1"));
	ft_list_push_front_c(&lst, strdup("sMCryRJPSOu6"));
	ft_list_push_front_c(&lst, strdup("GiJl9"));
	ft_list_push_front_c(&lst, strdup("R"));
	ft_list_push_front_c(&lst, strdup("h6kV4"));
	ft_list_push_front_c(&lst, strdup("aMoCh29W8B"));
	ft_list_push_front_c(&lst, strdup(""));
	ft_list_push_front_c(&lst, strdup(" "));
	ft_list_push_front_c(&lst, strdup("  "));
	ft_list_push_front_c(&lst, strdup(""));
	ft_list_push_front_c(&lst, strdup("VihSZbMNyY"));
	ft_list_push_front_c(&lst, strdup("rXGUhQt"));
	func_list_sort(&lst, cmp);
	print_list(lst, t, NULL);
	ft_list_clear(&lst, &free);
}

static int		r_strcmp(char *s1, char *s2)
{
	return strcmp(s1, s2);
}

static int		compare_len(char *s1, char *s2)
{
	return strlen(s1) - strlen(s2);
}

static void		test_ft_list_sort(void)
{
	GREEN;
	printf("To display a C Piscine's function's result, Press an enter key!");
	getchar();
	GRAY;
	do_ft_list_sort("c piscine", &ft_list_sort_c, &r_strcmp);
	do_ft_list_sort("c piscine", &ft_list_sort_c, &compare_len);
	GREEN;

	printf("To test LIBASM's function, Press an enter key!");
	getchar();
	GRAY;
	do_ft_list_sort("libasm", &ft_list_sort, &r_strcmp);
	do_ft_list_sort("libasm", &ft_list_sort, &compare_len);
	GREEN;
}

int				main(void)
{
	char		input[16];
	ssize_t		r;

	while (1)
	{
		GREEN;
		ft_write(1, "==== Test List ====\n", 20);
		WHITE;
		ft_write(1, " 1:  ft_atoi_base\n", 18);
		ft_write(1, " 2:  ft_list_push_front\n", 24);
		ft_write(1, " 3:  ft_list_size\n", 18);
		ft_write(1, " 4:  ft_list_sort\n", 18);
		ft_write(1, " 5:  ft_list_remove_if\n", 23);
		ft_write(1, "\n", 1);
		YELLOW;
		ft_write(1, " X:  Quit\n", 10);
		GRAY;
		ft_write(1, "Select a new test: ", 19);
		r = ft_read(STDIN_FILENO, input, 16);
		if (r <= 0)
			break ;
		input[r - 1] = '\0';
		if (!ft_strcmp(input, "X"))
			break ;
		else if (!ft_strcmp(input, "1"))
			test_ft_atoi_base();
		else if (!ft_strcmp(input, "2"))
			test_ft_list_push_front();
		else if (!ft_strcmp(input, "3"))
			test_ft_list_size();
		else if (!ft_strcmp(input, "4"))
			test_ft_list_sort();
		else if (!ft_strcmp(input, "5"))
			test_ft_list_remove_if();
	}
	ft_write(1, "Bye~\n", 5);
	return (0);
}
