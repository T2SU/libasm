;
;  ft_list_remove_if_bonus.s
;    Created by smun<smun@student.42seoul.kr>
;

						global	_ft_list_remove_if
						extern	_free
						section	.text
;	void		ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
;		t_list	*prev;			// [rbp-8]
;		t_list	*tmp;			// [rbp-10h]
;		t_list	*lst;			// [rbp-18h]
;		t_list	**begin_list	// [rbp-20h]
;		void	*data_ref		// [rbp-28h]
;		void	*cmp			// [rbp-30h]
;		void	*free_fct		// [rbp-38h]
;		dummy					// [rbp-40h] (for stack 16bytes aligned)
_ft_list_remove_if:		push	rbp
						mov		rbp, rsp
						sub		rsp, 40h
						test	rdi, rdi
						je		_return
						mov		rax, [rdi]
						test	rax, rax
						je		_return
						mov		qword [rbp-8], 0	; prev = NULL
						mov		[rbp-18h], rax		; lst = *begin_list
						mov		[rbp-20h], rdi		; begin_list
						mov		[rbp-28h], rsi		; data_ref
						mov		[rbp-30h], rdx		; cmp
						mov		[rbp-38h], rcx		; free_fct
loop:					test	rax, rax			; if (lst)
						je		_return
						mov		rdi, [rax + 0]		; lst->data
						mov		rsi, [rbp-28h]		; data_ref
						mov		rdx, [rbp-30h]
						call	rdx					; cmp(lst->data, data_ref)
						test	rax, rax
						jne		cmp_not_equal
cmp_equal:				mov		rdx, [rbp-18h]		; rdx = lst
						mov		rdx, [rdx + 8]		; rdx = lst->next
						mov		rax, [rbp-8]		; rax = prev
						test	rax, rax
						je		prev_is_null
						mov		[rax + 8], rdx		; prev->next = rdx (lst->next)
						jmp		do_free
prev_is_null:			mov		rax, [rbp-20h]		; rax = begin_list
						mov		[rax], rdx			; *begin_list = rdx (lst->next)
do_free:				mov		rax, [rbp-18h]		; rax = lst
						mov		[rbp-10h], rax		; tmp = rax (lst)
						mov		rdx, [rax + 8]		; rdx = tmp->next
						mov		[rbp-18h], rdx		; lst = lst->next
						mov		rax, [rax + 0]		; rax = tmp->data
						mov		rdi, rax
						mov		rdx, [rbp-38h]
						call	rdx					; free_fct(tmp->data)
						mov		rdi, [rbp-10h]		; tmp
						call	_free				; free(tmp)
						mov		rax, [rbp-18h]
						jmp		loop
cmp_not_equal:			mov		rax, [rbp-18h]
						mov		[rbp-8], rax		; prev = lst
						mov		rax, [rax + 8]		; lst = lst->next
						mov		[rbp-18h], rax
						jmp		loop
_return:				mov		rsp, rbp
						pop		rbp
						ret
