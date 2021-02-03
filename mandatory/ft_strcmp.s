; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_strcmp.s                                        :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2021/02/03 02:23:12 by smun              #+#    #+#             ;
;   Updated: 2021/02/03 03:40:02 by smun             ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

			global	_ft_strcmp

			section	.text
;	int					ft_strcmp(const char *s1, const char *s2)
;	{
;		unsigned char	c1; // al
;		unsigned char	c2; // dl
;		int				tmp; // rax
;
;		while (1)
;		{
;			c1 = (unsigned char)*s1;
;			c2 = (unsigned char)*s2;
;			if (c1 == 0 && c2 == 0)
;			{
;				tmp = 0;
;				break ;
;			}
;			if (c1 != c2)
;			{
;				if ((unsigned char)c1 < (unsigned char)c2)
;					tmp = 1;
;				else
;					tmp = -1;
;				break ;
;			}
;			s1++;
;			s2++;
;		}
;		return (tmp);
;	}
;
;	int					ft_strcmp(const char *s1, const char *s2)
;	{
;		unsigned char	c1; // al
;		unsigned char	c2; // dl
;		int				tmp; // rax
;
;	_loop:
;		c1 = (unsigned char)*s1;
;		c2 = (unsigned char)*s2;
;		if (c1)
;			goto _compare;
;		if (c2)
;			goto _compare;
;		tmp = 0;
;		goto _return;
;	_compare:
;		c1 -= c2;
;		if ($c1 < $c2)
;			goto _neg;
;		if (c1 != 0)
;			goto _pos;
;		s1++;
;		s2++;
;		goto _loop;
;	_pos:
;		tmp = 1;
;		goto _return;
;	_neg:
;		tmp = -1;
;	_return:
;		return (tmp);
;	}
;
_ft_strcmp:
_loop:		mov		al, [rdi]		; c1 = (unsigned char)*s1;
			mov		dl, [rsi]		; c2 = (unsigned char)*s2;
			test	al, al			; if (c1)
			jne		_compare		; goto _compare;
			test	dl, dl			; if (c2)
			jne		_compare		; goto _compare;
			mov		rax, 0			; tmp = 0;
			jmp		_return			; goto _return;
_compare:	sub		al, dl			; c1 -= c2;
			jc		_neg			; if ($c1 < $c2) goto _neg;
			test	al, al			; if (c1 != 0)
			jne		_pos			; goto _pos;
			inc		rdi				; s1++;
			inc		rsi				; s2++;
			jmp		_loop			; goto _loop;
_pos:		mov		rax, 1			; tmp = 1;
			jmp		_return			; goto _return;
_neg:		mov		rax, -1			; tmp = -1;
_return:	ret						; return (tmp);
