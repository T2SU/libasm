; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_strlen.s                                        :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2021/02/03 00:09:16 by smun              #+#    #+#             ;
;   Updated: 2021/02/03 00:19:54 by smun             ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

			global	_ft_strlen

			section	.text
;	size_t	ft_strlen(const char *s)
;	{
;		size_t	size; // rcx
;		char	chr; // rax
;
;		size = 0;
;		while (1)
;		{
;			chr = *s;
;			if (!chr)
;				break ;
;			size++;
;		}
;		return (size);
;	}
_ft_strlen:	push	rcx
			mov		rcx, 0
_loop:		mov		al, [rdi]
			test	al, al
			je		_return
			inc		rcx
			inc		rdi
			jmp		_loop
_return:
			mov		rax, rcx
			pop		rcx
			ret
