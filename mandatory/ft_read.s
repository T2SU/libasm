; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_read.s                                          :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2021/02/02 23:45:03 by smun              #+#    #+#             ;
;   Updated: 2021/02/02 23:56:17 by smun             ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

			global	_ft_read
			extern	___error

			section	.text
; ssize_t	ft_read(int fildes, void *buf, size_t nbyte)
_ft_read:	push	rdi
			mov		rax, 0x2000003	; read syscall number: ((2 << 24) | 0x3)
			syscall
			jnc		_return			; jmp to _return if carry flag is 0
			mov		rdi, rax
			call	___error
			mov		[rax], rdi
			mov		rax, -1
_return:	pop		rdi
			ret
