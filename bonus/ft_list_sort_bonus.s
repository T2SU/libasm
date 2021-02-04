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
;		t_list	*lst2;			// [rbp-10h]
;		t_list	**begin_list;	// [rbp-18h]
;		void	*cmp;			// [rbp-20h]
;
_ft_list_sort:	push	rbp
				mov		rbp, rsp
				sub		rsp, 20h
				test	rdi, rdi					; if (!begin_list)
				je		_return
				mov		rdx, [rdi]					; $rdx = *begin_list
				test	rdx, rdx					; if (!$rdx)
				je		_return
				mov		[rbp-18h], rdi				; begin_list
				mov		[rbp-20h], rsi				; cmp
				mov		[rbp-8], rdx				; lst = $rdx
loop:			test	rdx, rdx
				je		_return
				mov		rcx, [rbp-18h]				; $rcx = begin_list
				mov		rcx, [rcx]					; $rcx = *rcx
				mov		[rbp-10h], rcx				; lst2 = $rcx
sub_loop:		mov		rax, [rcx + t_list.next]	; lst2->next
				test	rax, rax
				je		sub_loop_end
				mov		rdi, [rcx + t_list.data]	; $rdi = lst2->data
				mov		rsi, [rcx + t_list.next]	; $rsi = lst2->next
				mov		rsi, [rsi + t_list.data]	; $rsi = $rsi->data
				mov		rax, [rbp-20h]				; cmp
				call	rax							; cmp(lst2->data, lst2->next->data)
				cmp		eax, 0
				jle		sub_loop_next
				mov		rdi, [rbp-10h]				; $rdi = lst2
				mov		rsi, [rdi + t_list.next]	; $rsi = lst2->next
				call	swap						; swap(lst2, lst2->next)
sub_loop_next:	mov		rcx, [rbp-10h]
				mov		rcx, [rcx + t_list.next]
				mov		[rbp-10h], rcx
				jmp		sub_loop
sub_loop_end:	mov		rdx, [rbp-8]
				mov		rdx, [rdx + t_list.next]
				mov		[rbp-8], rdx
				jmp		loop
_return:		mov		rsp, rbp
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
