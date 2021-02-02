/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/02 16:50:19 by smun              #+#    #+#             */
/*   Updated: 2021/02/02 23:30:47 by smun             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_H
# define LIBASM_H

typedef long			ssize_t;
typedef unsigned long	size_t;

ssize_t					ft_read(int fildes, void *buf, size_t nbyte);
ssize_t					ft_write(int fildes, void *buf, size_t nbyte);

#endif
