; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_read.s                                          :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2021/02/02 23:45:03 by smun              #+#    #+#             ;
;   Updated: 2021/02/03 01:39:06 by smun             ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

			global	_ft_read
			extern	___error

			section	.text
;	ssize_t		ft_read(int fildes, void *buf, size_t nbyte)
;	{
;		int		*errptr; // rdi
;		ssize_t	ret;     // [rbp]
;
;		ret = syscall[0x2000003](fileds, buf, nbyte);
;		if ((__rflags & 1) == 0) // syscall was successful?
;			goto _return;
;		errptr = __error();
;		*errptr = (int)ret;
;		ret = -1;
;	_return:
;		return (ret);
;	}
;
_ft_read:	push	rbp
			mov		rbp, rsp
			sub		rsp, 8				; ssize_t ret;
			mov		rax, 0x2000003		; read syscall number: ((2 << 24) | 0x3)
			syscall
			jnc		_return				; jmp to _return if carry flag is 0
			mov		[rbp], rax			; ret = $?
			call	___error			; __error();
			mov		rdi, rax			; errptr = $?
			mov		rax, [rbp]
			mov		dword [rdi], eax	; *errptr = (int)ret;
			mov		rax, -1				; ret = -1;
_return:	mov		rsp, rbp
			pop		rbp
			ret
