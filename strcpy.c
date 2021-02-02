/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strcpy.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/03 00:22:57 by smun              #+#    #+#             */
/*   Updated: 2021/02/03 01:53:32 by smun             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <string.h>
#include <libasm.h>
#include <unistd.h>

int			main(void)
{
	ssize_t	sz;
	char	buf[512];
	char	buf_libc[512];
	char	buf_libasm[512];
	char	*dest;

	if ((sz = read(STDIN_FILENO, buf, 512)) > 0)
	{
		buf[sz] = '\0';
		dest = strcpy(buf_libc, buf);
		printf("[ %-10s] [%10s ]: %s\n", "libc", "strcpy", dest);
		dest = ft_strcpy(buf_libasm, buf);
		printf("[ %-10s] [%10s ]: %s\n", "libasm", "ft_strcpy", dest);
	}
	return (0);
}
