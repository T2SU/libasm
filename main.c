/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/02 16:51:22 by smun              #+#    #+#             */
/*   Updated: 2021/02/03 00:07:00 by smun             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <libasm.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>

int				print_error(const char *type, ssize_t ret)
{
	printf("[%10s] ret = %zd | errno = %d\n", type, ret, errno);
	return (1);
}

int				main(void)
{
	ssize_t		ret;
	char		buf[512];
	int			fd_origin;
	int			fd_target;

	if ((fd_origin = open("lorem.txt", O_RDONLY | O_SHLOCK)) < 0)
		return (print_error("open1", fd_origin));
	if ((fd_target = open("lorem_copy_libc.txt", O_WRONLY | O_TRUNC | O_CREAT | O_EXLOCK, 0644)) < 0)
		return (print_error("open2", fd_target));
	while ((ret = read(fd_origin, buf, 512)) > 0)
	{
		ret = write(fd_target, buf, ret);
		print_error("libc", ret);
	}

	if ((fd_origin = open("lorem.txt", O_RDONLY | O_SHLOCK)) < 0)
		return (print_error("open1", fd_origin));
	if ((fd_target = open("lorem_copy_libasm.txt", O_WRONLY | O_TRUNC | O_CREAT | O_EXLOCK, 0644)) < 0)
		return (print_error("open2", fd_target));
	while ((ret = ft_read(fd_origin, buf, 512)) > 0)
	{
		ret = ft_write(fd_target, buf, ret);
		print_error("libasm", ret);
	}

	return (0);
}
