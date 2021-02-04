/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm_bonus.h                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/02 16:50:19 by smun              #+#    #+#             */
/*   Updated: 2021/02/04 20:39:25 by smun             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_BONUS_H
# define LIBASM_BONUS_H
# include "libasm.h"

typedef struct		s_list
{
	void			*data;
	struct s_list	*next;
}					t_list;

int					ft_atoi_base(char *str, char *base);
void				ft_list_push_front(t_list **begin_list, void *data);
int					ft_list_size(t_list *begin_list);
void				ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

/*
**  == C Functions for comparison
*/

int					ft_atoi_base_c(char *str, char *base);
void				ft_list_push_front_c(t_list **begin_list, void *data);
int					ft_list_size_c(t_list *begin_list);
void				ft_list_sort_c(t_list **begin_list, int (*cmp)());
void				ft_list_remove_if_c(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

#endif
