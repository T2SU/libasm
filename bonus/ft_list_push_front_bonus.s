;
;  ft_list_push_front_bonus.s
;    Created by smun<smun@student.42seoul.kr>
;

						struc	t_list
							.data	resq 1
							.next	resq 1
						endstruc

						global	_ft_list_push_front
						extern	_malloc
						section	.text
;	void		ft_list_push_front(t_list **begin_list, void *data)
;		t_list	**begin_list	// [rbp-8h]
;		void	*data			// [rbp-10h]
_ft_list_push_front:	push	rbp
						mov		rbp, rsp
						sub		rsp, 10h
						mov		[rbp-8h], rdi				; begin_list
						mov		[rbp-10h], rsi				; data
						test	rdi, rdi
						je		_return
						mov		rdi, t_list_size			; malloc(sizeof(t_list))
						call	_malloc
						test	rax, rax
						je		_return
						mov		rdi, rax
						mov		rax, [rbp-10h]
						mov		[rdi + t_list.data], rax	; lst->data = data
						mov		rax, [rbp-8h]
						mov		rax, [rax]
						mov		[rdi + t_list.next], rax	; lst->next = *begin_list
						mov		rax, [rbp-8h]
						mov		[rax], rdi					; *begin_list = lst
_return:				mov		rsp, rbp
						pop		rbp
						ret


