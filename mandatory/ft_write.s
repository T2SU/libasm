; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_write.s                                         :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2021/02/02 22:30:18 by smun              #+#    #+#             ;
;   Updated: 2021/02/03 01:59:34 by smun             ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

			global	_ft_write
			extern	___error

			section	.text
;	ssize_t		ft_write(int fildes, void *buf, size_t nbyte)
;	{
;		int		*errptr; // rdi
;		ssize_t	ret;     // rdx
;
;		ret = syscall[0x2000004](fileds, buf, nbyte);
;		if ((__rflags & 1) == 0) // syscall was successful?
;			goto _return;
;		errptr = __error();
;		*errptr = (int)ret;
;		ret = -1;
;	_return:
;		return (ret);
;	}
;
_ft_write:	push	rdx					; ssize_t ret;
			mov		rax, 0x2000004		; read syscall number: ((2 << 24) | 0x4)
			syscall
			jnc		_return				; jmp to _return if carry flag is 0
			mov		rdx, rax			; ret = $?
			call	___error			; __error();
			mov		rdi, rax			; errptr = $?
			mov		rax, rdx
			mov		dword [rdi], eax	; *errptr = (int)ret;
			mov		rax, -1				; ret = -1;
_return:	pop		rdx
			ret
