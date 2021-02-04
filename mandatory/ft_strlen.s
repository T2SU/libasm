; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_strlen.s                                        :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2021/02/03 00:09:16 by smun              #+#    #+#             ;
;   Updated: 2021/02/03 01:32:26 by smun             ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

			global	_ft_strlen

			section	.text
;	size_t		ft_strlen(const char *s)
;	{
;		size_t	size; // rcx
;		char	chr;  // rax
;
;		size = 0;
;		while ((chr = *s))
;			size++;
;		return (size);
;	}
;
;	size_t		ft_strlen(const char *s)
;	{
;		size_t	size; // rcx
;		char	chr;  // rax
;
;		size = 0;
;	_loop:
;		chr = *s;
;		if (!chr)
;			goto _return;
;		size++;
;		s++;
;		goto _loop;
;	_return:
;		return (size);
;	}
;
_ft_strlen:	push	rcx				; size_t size;
			xor		rcx, rcx		; size = 0;
_loop:		mov		al, [rdi]		; chr = *s;
			test	al, al			; if (!chr)
			je		_return			; goto _return;
			inc		rcx				; size++;
			inc		rdi				; s++;
			jmp		_loop			; goto _loop;
_return:	mov		rax, rcx		; return (size);
			pop		rcx
			ret
