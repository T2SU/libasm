/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   mainb.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/04 00:03:58 by smun              #+#    #+#             */
/*   Updated: 2021/02/04 03:35:10 by smun             ###   ########.fr       */
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
	do_test_ft_atoi_base("104133633034", "0123456");
	do_test_ft_atoi_base("-13344221014043", "01234");
	do_test_ft_atoi_base("5EHL50J", "0123456789ABCDEFGHIJKLMNOPQ");

	do_test_ft_atoi_base("!@#$%^&*()", ")!@#$%^&*(");
	do_test_ft_atoi_base("IOOOOOOOOOOOOOOOO", "OI");
	do_test_ft_atoi_base("<C<B\"\'\'", "\'\"\?>.<,QWERT ABC");
	do_test_ft_atoi_base("Qa QRRtRRaR ", "aQqR Tt");
	do_test_ft_atoi_base("-_{{}}||_=_}=}{", "=_|{}");
	do_test_ft_atoi_base("D'wyDZr", "ZXCS DF12345;:'\"qwertyas@#$");
	do_test_ft_atoi_base("^$G$M", "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#$%^&*()_= ");
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

int				main(void)
{
	char		input[16];
	ssize_t		r;

	GREEN;
	ft_write(1, "==== Test List ====\n", 20);
	WHITE;
	ft_write(1, " 1:  ft_atoi_base\n", 18);
	ft_write(1, "\n", 1);
	YELLOW;
	ft_write(1, " X:  Quit\n", 10);
	GRAY;
	while (1)
	{
		ft_write(1, "Select a new test: ", 19);
		r = ft_read(STDIN_FILENO, input, 16);
		if (r <= 0)
			break ;
		input[r - 1] = '\0';
		if (!ft_strcmp(input, "X"))
			break ;
		else if (!ft_strcmp(input, "1"))
			test_ft_atoi_base();
	}
	ft_write(1, "Bye~\n", 5);
	return (0);
}
