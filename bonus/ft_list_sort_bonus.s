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
;		t_list	*main;			// [rbp-8]
;		t_list	*sub;			// [rbp-10h]
;		t_list	**begin_list;	// [rbp-18h]
;		void	*cmp;			// [rbp-20h]
;		dummy					// [rbp-28h] (for stack 16 bytes aligned)
;
;	if (!_begin_list)
;		goto _return;
;	$rdx = *_begin_list;
;	if (!$rdx)
;		goto _return;
;	begin_list = _begin_list;
;	cmp = _cmp;
;	main = $rdx;
;loop:
;	$rdx = $rdx->next;
;	if (!$rdx)
;		goto _return;
;	$rax = *begin_list;
;	sub = $rax;
;sub_loop:
;	$rsi = main;
;	if ($rax == $rsi)
;		goto end_sub_loop;
;	$rdi = $rax->data;
;	$rsi = $rax->next->data;
;	$rax = cmp($rdi, $rsi);
;	if ($rax <= 0)
;		goto end_swap;
;	swap(sub, sub->next);
;end_swap:
;	$rax = sub->next;
;	sub = $rax;
;	goto sub_loop;
;end_sub_loop:
;	$rax = main->next;
;	main = $rax;
;	goto loop;
;_return:
;	return ;
;
_ft_list_sort:	push	rbp
				mov		rbp, rsp
				sub		rsp, 28h
				push	rdx
				test	rdi, rdi					; if (!begin_list)
				je		_return
				mov		rdx, [rdi]
				test	rdx, rdx					; if (!(*begin_list))
				je		_return
				mov		[rbp-18h], rdi				; begin_list
				mov		[rbp-20h], rsi				; cmp
				mov		[rbp-8], rdx				; main = *begin_list
loop:			mov		rdx, [rdx + t_list.next]
				test	rdx, rdx					; if (main->next)
				je		_return
				mov		rax, [rbp-18h]				; begin_list
				mov		rax, [rax]					; rax = *begin_list
				mov		[rbp-10h], rax				; sub = *begin_list
sub_loop:		mov		rsi, [rbp-8]				; rsi = main
				cmp		rax, rsi					; if (sub != main)		; rax = sub, rsi = main
				je		end_sub_loop
				mov		rdi, [rax + t_list.data]	; rdi = sub->data
				mov		rsi, [rax + t_list.next]	; rsi = sub->next
				mov		rsi, [rsi + t_list.data]	; rsi = rsi->data
				mov		rdx, [rbp-20h]				; cmp
				call	rdx							; cmp(sub->data, sub->next->data)
				cmp		eax, 0
				jle		end_swap
				mov		rdi, [rbp-10h]				; rdi = sub
				mov		rsi, [rdi + t_list.next]	; rsi = sub->next
				call	swap						; swap(sub, sub->next)
end_swap:		mov		rax, [rbp-10h]
				mov		rax, [rax + t_list.next]
				mov		[rbp-10h], rax				; sub = sub->next
				jmp		sub_loop
end_sub_loop:	mov		rdx, [rbp-8]
				mov		rdx, [rdx + t_list.next]
				mov		[rbp-8], rdx				; main = main->next
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
