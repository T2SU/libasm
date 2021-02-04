/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_atoi_base.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/03 17:30:35 by smun              #+#    #+#             */
/*   Updated: 2021/02/05 00:47:29 by smun             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <libasm_bonus.h>

/*
**  Could be replaced by `ft_strlen`
*/

static int		get_strlen(const char *s)
{
	int			len;

	len = 0;
	while (*(s++))
		len++;
	return (len);
}

static char		*ft_memchr(char *s, int chr, int len)
{
	while (*s && len--)
	{
		if (*s == chr)
			return (s);
		s++;
	}
	return (0);
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
		if (ft_memchr("+-", base[i], 2))
			return (0);
		if (ft_memchr("\t\n\v\f\r ", base[i], 6))
			return (0);
		if (i > 0)
			if (ft_memchr(&base[0], base[i], i))
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
		pos = ft_memchr(base, *str, blen);
		if (!pos)
			break ;
		i = (int)(pos - base);
		nbr = nbr * blen + i;
		str++;
	}
	return (nbr);
}

int				ft_atoi_base_c(char *str, char *base)
{
	int			blen;
	int			neg;

	if (!is_valid_base(base))
		return (0);
	while (ft_memchr("\t\n\v\f\r ", *str, 6))
		str++;
	neg = 1;
	while (*str == '-' || *str == '+')
		if (*(str++) == '-')
			neg = -neg;
	blen = get_strlen(base);
	return ((cvt_by_base(str, base, blen)) * neg);
}
