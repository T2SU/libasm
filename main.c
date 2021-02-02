/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/02 16:51:22 by smun              #+#    #+#             */
/*   Updated: 2021/02/02 22:46:08 by smun             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <helloworld.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>

int		main(void)
{
	//int ret = hello(3);
	int ret = write(3, "Hello world!!\n", 14);
	printf("ret = %d\nerrno = %d\n", ret, errno);
	return (0);
}
