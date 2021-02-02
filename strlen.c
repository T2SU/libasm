/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strlen.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/03 00:22:57 by smun              #+#    #+#             */
/*   Updated: 2021/02/03 00:51:42 by smun             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <string.h>
#include <libasm.h>
#include <unistd.h>

int			main(void)
{
	size_t	len;
	ssize_t	sz;
	char	buf[512];

	if ((sz = read(STDIN_FILENO, buf, 512) > 0))
	{
		len = strlen(buf);
		printf("[ %-10s] [%10s ]: %zu\n", "libc", "strlen", len);
		len = ft_strlen(buf);
		printf("[ %-10s] [%10s ]: %zu\n", "libasm", "ft_strlen", len);
	}

	return (0);
}
