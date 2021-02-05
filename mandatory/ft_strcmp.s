; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_strcmp.s                                        :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2021/02/03 02:23:12 by smun              #+#    #+#             ;
;   Updated: 2021/02/05 14:40:02 by smun             ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

			global	_ft_strcmp
			extern	_ft_strlen
			section	.text
_ft_strcmp:	push	rdi				; backup s1
			push	rsi				; backup s2
			call	_ft_strlen		; get s1's string length
			inc		rax				; include NULL character
			mov		rcx, rax		; max repeat counter (rcx)
			pop		rsi				; restore s2
			pop		rdi				; restore s1
			cld						; clear direction flag (to forward)
			repe	cmpsb			; repeat while byte[$rsi] == byte[$rdi] and rcx != 0
			dec		rdi
			dec		rsi
			movzx	rax, byte [rdi]
			movzx	rdx, byte [rsi]
			sub		rax, rdx		; *s1 - *s2
_return:	ret
