/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strdup.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/03 00:22:57 by smun              #+#    #+#             */
/*   Updated: 2021/02/03 15:28:57 by smun             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <string.h>
#include <libasm.h>
#include <unistd.h>
#include <stdlib.h>

int			main(void)
{
	size_t	len;
	ssize_t	sz;
	char	buf[512];
	char	*copied_libc;
	char	*copied_libasm;
	int		cmp;

	write(STDOUT_FILENO, "Text to duplicate: ", 19);
	if ((sz = read(STDIN_FILENO, buf, 512)) > 0)
	{
		buf[sz] = '\0';
		copied_libc = strdup(buf);
		len = strlen(copied_libc);
		printf("[ %-10s] [%10s ]: %zu\n", "libc", "strlen", len);
		copied_libasm = ft_strdup(buf);
		len = strlen(copied_libasm);
		printf("[ %-10s] [%10s ]: %zu\n", "libasm", "ft_strlen", len);
		cmp = strcmp(copied_libc, copied_libasm);
		printf("[ %-24s]: %d\n", "comparision", cmp);
		free(copied_libc);
		free(copied_libasm);
	}
	return (0);
}
