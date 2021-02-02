; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_write.s                                         :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2021/02/02 22:30:18 by smun              #+#    #+#             ;
;   Updated: 2021/02/03 01:40:51 by smun             ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

			global	_ft_write
			extern	___error

			section	.text
;	ssize_t		ft_write(int fildes, void *buf, size_t nbyte)
;	{
;		int		*errptr; // rdi
;
;
_ft_write:	mov		rax, 0x2000004	; write syscall number: ((2 << 24) | 0x4)
			syscall
			jnc		_return			; jmp to _return if carry flag is 0
			mov		rcx, rax
			call	___error
			mov		[rax], rcx
			mov		rax, -1
_return:	ret
