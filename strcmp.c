/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strcmp.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/03 00:22:57 by smun              #+#    #+#             */
/*   Updated: 2021/02/03 03:40:52 by smun             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <string.h>
#include <libasm.h>
#include <unistd.h>

int			main(void)
{
	ssize_t	sz;
	char	buf1[512];
	char	buf2[512];
	int		cmp;

	write(STDOUT_FILENO, "First Text: ", 12);
	if ((sz = read(STDIN_FILENO, buf1, 512)) > 0)
		buf1[sz] = '\0';
	write(STDOUT_FILENO, "Second Text: ", 13);
	if ((sz = read(STDIN_FILENO, buf2, 512)) > 0)
		buf2[sz] = '\0';
	cmp = strcmp(buf1, buf2);
	if (cmp < 0) cmp = -1;
	if (cmp > 0) cmp = 1;
	printf("[ %-10s] [%10s ]: %08X\n", "libc", "strcmp", cmp);
	cmp = ft_strcmp(buf1, buf2);
	printf("[ %-10s] [%10s ]: %08X\n", "libasm", "ft_strcmp", cmp);
	return (0);
}
