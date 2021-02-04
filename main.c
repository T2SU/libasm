/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/04 00:03:58 by smun              #+#    #+#             */
/*   Updated: 2021/02/04 19:51:59 by smun             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <libasm.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <stdlib.h>

#define BUFFER	8192
#define GRAY	write(1, "\x1b[0m", 4)
#define YELLOW	write(1, "\x1b[33m", 5)
#define GREEN	write(1, "\x1b[32m", 5)
#define WHITE	write(1, "\x1b[37m", 5)

static void		test_strlen(void)
{
	size_t		len;
	ssize_t		sz;
	char		buf[BUFFER];

	write(1, "Please type any string: ", 24);
	if ((sz = read(STDIN_FILENO, buf, BUFFER)) > 0)
	{
		buf[sz - 1] = '\0';
		len = strlen(buf);
		printf("[ %-10s] [%10s ]: %zu\n", "libc", "strlen", len);
		len = ft_strlen(buf);
		printf("[ %-10s] [%10s ]: %zu\n", "libasm", "ft_strlen", len);
	}
}

static void		test_strdup(void)
{
	size_t		len;
	ssize_t		sz;
	char		buf[BUFFER];
	char		*copied_libc;
	char		*copied_libasm;
	int			cmp;

	write(STDOUT_FILENO, "Text to duplicate: ", 19);
	if ((sz = read(STDIN_FILENO, buf, BUFFER)) > 0)
	{
		buf[sz - 1] = '\0';
		copied_libc = strdup(buf);
		len = strlen(copied_libc);
		printf("[ %-10s] [%10s ]: %s(len=%zu)\n", "libc", "strlen", copied_libc, len);
		copied_libasm = ft_strdup(buf);
		len = strlen(copied_libasm);
		printf("[ %-10s] [%10s ]: %s(len=%zu)\n", "libasm", "ft_strlen", copied_libasm, len);
		cmp = strcmp(copied_libc, copied_libasm);
		if (cmp < 0) cmp = -1;
		if (cmp > 0) cmp = 1;
		printf("[ %-24s]: %d\n", "comparision (strcmp)", cmp);
		free(copied_libc);
		free(copied_libasm);
	}
}

static void		test_strcpy(void)
{
	ssize_t		sz;
	char		buf[BUFFER];
	char		buf_libc[BUFFER];
	char		buf_libasm[BUFFER];
	char		*dest;

	write(STDOUT_FILENO, "Text to copy: ", 14);
	if ((sz = read(STDIN_FILENO, buf, BUFFER)) > 0)
	{
		buf[sz - 1] = '\0';
		dest = strcpy(buf_libc, buf);
		printf("[ %-10s] [%10s ]: %s(len=%zu)\n", "libc", "strcpy", dest, strlen(dest));
		dest = ft_strcpy(buf_libasm, buf);
		printf("[ %-10s] [%10s ]: %s(len=%zu)\n", "libasm", "ft_strcpy", dest, strlen(dest));
	}
}

static void		test_strcmp(void)
{
	ssize_t		sz;
	char		buf1[BUFFER];
	char		buf2[BUFFER];
	int			cmp;

	write(STDOUT_FILENO, "First Text: ", 12);
	if ((sz = read(STDIN_FILENO, buf1, BUFFER)) > 0)
		buf1[sz - 1] = '\0';
	write(STDOUT_FILENO, "Second Text: ", 13);
	if ((sz = read(STDIN_FILENO, buf2, BUFFER)) > 0)
		buf2[sz - 1] = '\0';
	cmp = strcmp(buf1, buf2);
	if (cmp < 0) cmp = -1;
	if (cmp > 0) cmp = 1;
	printf("[ %-10s] [%10s ]: %08X\n", "libc", "strcmp", cmp);
	cmp = ft_strcmp(buf1, buf2);
	printf("[ %-10s] [%10s ]: %08X\n", "libasm", "ft_strcmp", cmp);
}

static void		print_error(const char *type, ssize_t ret)
{
	printf("[%10s] ret = %zd | errno = %d\n", type, ret, errno);
	if (errno)
		perror("main");
}

static void		test_read_write(void)
{
	ssize_t		ret;
	char		buf[BUFFER];
	int			fd_origin;
	int			fd_target;

	if ((fd_origin = open("lorem.txt", O_RDONLY | O_SHLOCK)) < 0)
		print_error("open1", fd_origin);
	if ((fd_target = open("lorem_copy_libc.txt", O_WRONLY | O_TRUNC | O_CREAT | O_EXLOCK, 0644)) < 0)
		print_error("open2", fd_target);
	while ((ret = read(fd_origin, buf, BUFFER)) > 0)
	{
		ret = write(fd_target, buf, ret);
		print_error("libc", ret);
	}

	if ((fd_origin = open("lorem.txt", O_RDONLY | O_SHLOCK)) < 0)
		print_error("open1", fd_origin);
	if ((fd_target = open("lorem_copy_libasm.txt", O_WRONLY | O_TRUNC | O_CREAT | O_EXLOCK, 0644)) < 0)
		print_error("open2", fd_target);
	while ((ret = ft_read(fd_origin, buf, BUFFER)) > 0)
	{
		ret = ft_write(fd_target, buf, ret);
		print_error("libasm", ret);
	}
}

static void		test_read_write_exception(void)
{
	ssize_t		ret;
	char		buf[BUFFER];

	ret = read(8, buf, BUFFER);
	print_error("libc", ret);
	ret = ft_read(8, buf, BUFFER);
	print_error("libasm", ret);
	printf("\n\n");

	write(1, "Please type any string: ", 24);
	ret = read(0, NULL, BUFFER);
	print_error("libc", ret);
	ret = ft_read(0, NULL, BUFFER);
	print_error("libasm", ret);
	printf("\n\n");

	ret = read(0, buf, 0);
	print_error("libc", ret);
	ret = ft_read(0, buf, 0);
	print_error("libasm", ret);
	printf("\n\n");

	strcpy(buf, "Lorem ipsum dolor sit amet");

	ret = write(11, buf, BUFFER);
	print_error("libc", ret);
	ret = ft_write(11, buf, BUFFER);
	print_error("libasm", ret);
	printf("\n\n");

	ret = write(0, buf, BUFFER);
	print_error("libc", ret);
	ret = ft_write(0, buf, BUFFER);
	print_error("libasm", ret);
	printf("\n\n");

	ret = write(1, NULL, BUFFER);
	print_error("libc", ret);
	ret = ft_write(1, NULL, BUFFER);
	print_error("libasm", ret);
	printf("\n\n");

	ret = write(1, NULL, 0);
	print_error("libc", ret);
	ret = ft_write(1, NULL, 0);
	print_error("libasm", ret);
	printf("\n");
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
		ft_write(1, " 1:  ft_strlen\n", 15);
		ft_write(1, " 2:  ft_strcpy\n", 15);
		ft_write(1, " 3:  ft_strcmp\n", 15);
		ft_write(1, " 4:  ft_write, ft_read\n", 23);
		ft_write(1, " 5:  ft_write, ft_read exception\n", 33);
		ft_write(1, " 6:  ft_strdup\n", 15);
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
			test_strlen();
		else if (!ft_strcmp(input, "2"))
			test_strcpy();
		else if (!ft_strcmp(input, "3"))
			test_strcmp();
		else if (!ft_strcmp(input, "4"))
			test_read_write();
		else if (!ft_strcmp(input, "5"))
			test_read_write_exception();
		else if (!ft_strcmp(input, "6"))
			test_strdup();
	}
	ft_write(1, "Bye~\n", 5);
	return (0);
}
