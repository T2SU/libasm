; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_strcpy.s                                        :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2021/02/03 01:04:32 by smun              #+#    #+#             ;
;   Updated: 2021/02/03 01:37:54 by smun             ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

			global	_ft_strcpy

			section	.text
;	char		*ft_strcpy(char *dst, const char *src)
;	{
;		char	chr;   // al
;		char	*dest; // [ebp]
;
;		dest = dst;
;		if (src)
;		{
;			while (1)
;			{
;				chr = *src;
;				*dst = chr;
;				if (!chr)
;					break;
;			}
;		}
;		return (dest);
;	}
;
;	char		*ft_strcpy(char *dst, const char *src)
;	{
;		char	chr;   // al
;		char	*dest; // [ebp]
;
;		dest = dst;
;		if (!src)
;			goto _return;
;	_loop:
;		chr = *src;
;		*dst = chr;
;		if (!chr)
;			goto _return;
;		dst++;
;		src++;
;		goto _loop;
;	_return:
;		return (dest);
;	}
_ft_strcpy:	push	rbp				; stack frame
			mov		rbp, rsp
			sub		rsp, 8			; char	*dest;
			mov		[rbp], rdi		; dest = dst;
			test	rsi, rsi		; if (!src)
			je		_return			; goto _return;
_loop:		mov		al, [rsi]		; chr = *src;
			mov		byte [rdi], al	; *dst = chr;
			test	al, al			; if (!chr)
			je		_return			; goto _return;
			inc		rdi				; dst++;
			inc		rsi				; src++;
			jmp		_loop			; goto _loop;
_return:	mov		rax, [rbp]		; return (dest);
			mov		rsp, rbp
			pop		rbp				; restore stack frame
			ret
