/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_atoi_base.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/03 17:30:35 by smun              #+#    #+#             */
/*   Updated: 2021/02/04 01:32:08 by smun             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <string.h>
#include <libasm.h>
#include <unistd.h>

static char		*get_strnchr(char *s, int chr, int len)
{
	while (*s && len--)
	{
		if (*s == chr)
			return (s);
		s++;
	}
	return (0);
}

static int		get_strlen(const char *s)
{
	int			len;

	len = 0;
	while (*(s++))
		len++;
	return (len);
}

static int		is_valid_base(char *base)
{
	int			len;
	int			i;

	len = get_strlen(base);
	if (len <= 1)
		return (0);
	i = 0;
	while (i < len)
	{
		if (get_strnchr("+-", base[i], 2))
			return (0);
		if (i > 0)
			if (get_strnchr(base, base[i], i - 1))
				return (0);
		i++;
	}
	return (1);
}

static int		cvt_by_base(char *str, char *base, int blen)
{
	int			nbr;
	char		*pos;
	int			i;

	nbr = 0;
	while (*str)
	{
		pos = get_strnchr(base, *str, blen);
		if (!pos)
			break ;
		i = (int)(pos - base);
		nbr = nbr * blen + i;
		str++;
	}
	return (nbr);
}

static int		ft_atoi_base_c(char *str, char *base)
{
	int			blen;
	int			neg;

	if (!is_valid_base(base))
		return (0);
	while (get_strnchr("\t\n\v\f\r ", *str, 6))
		str++;
	neg = 1;
	while (*str == '-' || *str == '+')
		if (*(str++) == '-')
			neg = -neg;
	blen = get_strlen(base);
	return ((cvt_by_base(str, base, blen)) * neg);
}

static void		do_test(char *str, char *base)
{
	printf("[ %10s] %d\n", "c piscine", ft_atoi_base_c("1234567890", "0123456789"));
	printf("[ %10s] %d\n", "libasm", ft_atoi_base("1234567890", "0123456789"));
	printf("\n");
}

int			main(void)
{
	do_test("1234567890", "0123456789");
	do_test("10000000000000000", "01");
	do_test("5F5E100", "0123456789ABCDEF");
	do_test("104133633034", "0123456");
	do_test("-13344221014043", "01234");
	do_test("5EHL50J", "0123456789ABCDEFGHIJKLMNOPQ");

	do_test("!@#$%^&*()", ")!@#$%^&*(");
	do_test("IOOOOOOOOOOOOOOOO", "OI");
	do_test("<C<B\"\'\'", "\'\"\?>.<,QWERT ABC");
	do_test("Qa QRRtRRaR ", "aQqR Tt");
	do_test("-_{{}}||_=_}=}{", "=_|{}");
	do_test("D'wyDZr", "ZXCS DF12345;:'\"qwertyas@#$");
	do_test("^$G$M", "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#$%^&*()_= ");
	do_test("!", "!@#$");

	do_test("123456", "1234563");
	do_test("1234", "12345-64");
	do_test("1234", "12345678+");
	do_test("", "1");
	do_test("12345", "");
	do_test("12345", "a12356a7");
	do_test("     \t\v\f     +---------++-1235aaa776644", "a123567");
	do_test("     \n\r\t     +---------++-1235aaa7766"  , "a123567");
	do_test("            +----8----++-1235aaa7766", "a123567");
	return (0);
}
