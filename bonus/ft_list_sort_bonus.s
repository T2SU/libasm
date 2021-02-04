;
;  ft_list_sort_bonus.s
;    Created by smun<smun@student.42seoul.kr>
;

				struc	t_list
					.data	resq 1
					.next	resq 1
				endstruc

				global	_ft_list_sort
				section	.text
;	void		ft_list_sort(t_list **_begin_list, int (*_cmp)())
;		t_list	*lst;			// [rbp-8]
;		t_list	**begin_list;	// [rbp-10h]
;		void	*cmp;			// [rbp-18h]
;
_ft_list_sort:	push	rbp
				mov		rbp, rsp
				sub		rsp, 18h
				push	rdx
				test	rdi, rdi					; if (!begin_list)
				je		_return
				mov		rdx, [rdi]					; $rdx = *begin_list
				test	rdx, rdx					; if (!$rdx)
				je		_return
				mov		[rbp-10h], rdi				; begin_list
				mov		[rbp-18h], rsi				; cmp
loop:			mov		[rbp-8], rdx				; lst = $rdx
				mov		rax, [rdx + t_list.next]
				test	rax, rax					; if (lst->next)
				je		_return
				mov		rdi, [rdx + t_list.data]	; $rdi = lst->data
				mov		rsi, [rdx + t_list.next]	; $rsi = lst->next
				mov		rsi, [rsi + t_list.data]	; $rsi = $rsi->data
				mov		rax, [rbp-18h]				; cmp
				call	rax							; cmp(lst->data, lst->next->data)
				cmp		eax, 0
				jle		find_next
				mov		rdi, [rbp-8]				; $rdi = lst
				mov		rsi, [rdi + t_list.next]	; $rsi = lst->next
				call	swap						; swap(lst, lst->next)
				mov		rdx, [rbp-10h]				; $rdx = begin_list
				mov		rdx, [rdx]					; $rdx = *$rdx
				jmp		loop
find_next:		mov		rdx, [rbp-8]
				mov		rdx, [rdx + t_list.next]
				jmp		loop
_return:		pop		rdx
				mov		rsp, rbp
				pop		rbp
				ret

;	static void	swap(t_list *a, t_list *b)
swap:			push	rdx
				lea		rdi, [rdi + t_list.data]	; ptr_a = &a->data
				lea		rsi, [rsi + t_list.data]	; ptr_b = &b->data
				mov		rdx, [rdi]					; tmp_a = *ptr_a
				mov		rax, [rsi]					; tmp_b = *ptr_b
				mov		[rdi], rax					; *ptr_a = tmp_b
				mov		[rsi], rdx					; *ptr_b = tmp_a
				pop		rdx
				ret
