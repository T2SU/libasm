/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/02/03 17:30:35 by smun              #+#    #+#             */
/*   Updated: 2021/02/04 22:50:10 by smun             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <libasm_bonus.h>
#include <stdlib.h>

void		ft_list_push_front_c(t_list **begin_list, void *data)
{
	t_list	*lst;

	if (!begin_list)
		return ;
	if (!(lst = malloc(sizeof(t_list))))
		return ;
	lst->data = data;
	lst->next = *begin_list;
	*begin_list = lst;
}

int			ft_list_size_c(t_list *begin_list)
{
	int		i;

	i = 0;
	while (begin_list)
	{
		i++;
		begin_list = begin_list->next;
	}
	return (i);
}

static void	swap_c(t_list *a, t_list *b)
{
	void	*data;

	data = a->data;
	a->data = b->data;
	b->data = data;
}

void		ft_list_sort_c(t_list **begin_list, int (*cmp)())
{
	t_list	*lst;

	if (begin_list == NULL || !(lst = *begin_list))
		return ;
	while (lst->next)
	{
		if (cmp(lst->data, lst->next->data) > 0)
		{
			swap_c(lst, lst->next);
			lst = *begin_list;
		}
		else
			lst = lst->next;
	}
}

void		ft_list_remove_if_c(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
{
	t_list	*prev;
	t_list	*lst;
	t_list	*tmp;

	if (begin_list == NULL || !(lst = *begin_list))
		return ;
	prev = NULL;
	while (lst)
	{
		if (!cmp(lst->data, data_ref))
		{
			if (prev)
				prev->next = lst->next;
			else
				*begin_list = lst->next;
			tmp = lst;
			lst = lst->next;
			free_fct(tmp->data);
			free(tmp);
		}
		else
		{
			prev = lst;
			lst = lst->next;
		}
	}
}
