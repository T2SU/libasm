; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_strlen.s                                        :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2021/02/03 00:09:16 by smun              #+#    #+#             ;
;   Updated: 2021/02/05 12:17:26 by smun             ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

			global	_ft_strlen

			section	.text
_ft_strlen:	cld				; clear direction flag (forward)
			mov		al, 0	; byte to compare
			mov		rcx, -1	; init rcx to -1
			repnz	scasb	; repeat while byte[rdi] == al && rcx != 0
							; rdi++; rcx--;
			not		rcx		; ~$rcx
			dec		rcx		; --rcx
			mov		rax, rcx
			ret
