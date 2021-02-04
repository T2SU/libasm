/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   mainb.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/04 00:03:58 by smun              #+#    #+#             */
/*   Updated: 2021/02/04 20:43:48 by smun             ###   ########.fr       */
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

static void		do_test_ft_atoi_base(char *str, char *base)
{
	printf("[ %10s] %d\n", "c piscine", ft_atoi_base_c(str, base));
	printf("[ %10s] %d\n", "libasm", ft_atoi_base(str, base));
	printf("\n");
}

static void		test_ft_atoi_base(void)
{
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

static void		prepare_test_ft_list_remove_if(t_list **lst)
{
	*lst = NULL;
	ft_list_push_front_c(lst, strdup("Lorem"));
	ft_list_push_front_c(lst, strdup("lorem"));
	ft_list_push_front_c(lst, strdup("ipsum"));
	ft_list_push_front_c(lst, strdup("Lorem"));
	ft_list_push_front_c(lst, strdup("dolor"));
	ft_list_push_front_c(lst, strdup("sit"));
	ft_list_push_front_c(lst, strdup("amet"));
	ft_list_push_front_c(lst, strdup("Lorem"));
	ft_list_push_front_c(lst, strdup("consectetur"));
	ft_list_push_front_c(lst, strdup("adipiscing"));
	ft_list_push_front_c(lst, strdup("Lorem"));
	ft_list_push_front_c(lst, strdup("elit"));
	ft_list_push_front_c(lst, strdup("Aliquam"));
	ft_list_push_front_c(lst, strdup(""));
	ft_list_push_front_c(lst, strdup("Lorem"));
	ft_list_push_front_c(lst, strdup("lacinia"));
	ft_list_push_front_c(lst, strdup("massa"));
	ft_list_push_front_c(lst, strdup("Lorem"));
	ft_list_push_front_c(lst, strdup(""));
	ft_list_push_front_c(lst, strdup("dapibus"));
	ft_list_push_front_c(lst, strdup("Lorem"));
	ft_list_push_front_c(lst, strdup("porta"));
	ft_list_push_front_c(lst, strdup("erat"));
	ft_list_push_front_c(lst, strdup("sit"));
	ft_list_push_front_c(lst, strdup("Lorem"));
	ft_list_push_front_c(lst, strdup("Lorem"));
	ft_list_push_front_c(lst, strdup("Lorem"));
}

static void		do_ft_list_remove_if(const char *t, void (*func_remove_if)())
{
	t_list		*lst;

	prepare_test_ft_list_remove_if(&lst);
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
		else if (!ft_strcmp(input, "5"))
			test_ft_list_remove_if();
	}
	ft_write(1, "Bye~\n", 5);
	return (0);
}
