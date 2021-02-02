; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_write.s                                         :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2021/02/02 22:30:18 by smun              #+#    #+#             ;
;   Updated: 2021/02/02 23:44:08 by smun             ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

			global	_ft_write
			extern	___error

			section	.text
; ssize_t	ft_write(int fildes, void *buf, size_t nbyte)
_ft_write:	push	rdi
			mov		rax, 0x2000004	; write syscall number: ((2 << 24) | 0x4)
			syscall
			jnc		_return			; jmp to _return if carry flag is 0
			mov		rdi, rax
			call	___error
			mov		[rax], rdi
			mov		rax, -1
_return:	pop		rdi
			ret
