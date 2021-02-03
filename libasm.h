/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/02 16:50:19 by smun              #+#    #+#             */
/*   Updated: 2021/02/03 12:43:41 by smun             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_H
# define LIBASM_H

typedef long			ssize_t;
typedef unsigned long	size_t;

ssize_t					ft_read(int fildes, void *buf, size_t nbyte);
ssize_t					ft_write(int fildes, void *buf, size_t nbyte);
size_t					ft_strlen(const char *s);
char					*ft_strcpy(char *dst, const char *src);
int						ft_strcmp(const char *s1, const char *s2);
char					*ft_strdup(const char *s1);

#endif
