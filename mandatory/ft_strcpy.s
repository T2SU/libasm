; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_strcpy.s                                        :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2021/02/03 01:04:32 by smun              #+#    #+#             ;
;   Updated: 2021/02/05 13:25:54 by smun             ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

			global	_ft_strcpy
			extern	_ft_strlen
			section	.text
_ft_strcpy:	push	rbp
			mov		rbp, rsp
			sub		rsp, 10h
			test	rsi, rsi		; if (!src)
			je		_return			; goto _return;
			mov		[rbp-8], rdi	; dst
			mov		[rbp-10h], rsi	; src
			mov		rdi, rsi
			call	_ft_strlen
			mov		rcx, rax
			mov		rdi, [rbp-8]
			mov		rsi, [rbp-10h]
			cld
			rep		movsb			; copy rcx bytes from rsi to rdi.
									;  rdi++;  rsi++;  rcx--;
			mov		byte [rdi], 0	; NULL termination
			mov		rax, [rbp-8]	; return (dst)
_return:	mov		rsp, rbp
			pop		rbp
			ret
