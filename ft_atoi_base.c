/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_atoi_base.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/03 17:30:35 by smun              #+#    #+#             */
/*   Updated: 2021/02/04 02:51:34 by smun             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <libasm_bonus.h>

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

int				ft_atoi_base_c(char *str, char *base)
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
