;
;  ft_list_size_bonus.s
;    Created by smun<smun@student.42seoul.kr>
;

						struc	t_list
							.data	resq 1
							.next	resq 1
						endstruc

						global	_ft_list_size
						extern	_malloc
						section	.text
;	int			ft_list_size(t_list *begin_list)
;		long	i;		// rax
_ft_list_size:			xor		rax, rax					; i = 0;
loop:					test	rdi, rdi					; if (begin_list)
						je		_return
						inc		rax							; i++;
						mov		rdi, [rdi + t_list.next]	; begin_list = begin_list->next
						jmp		loop
_return:				ret
