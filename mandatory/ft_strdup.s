; ************************************************************************** ;
;                                                                            ;
;                                                        :::      ::::::::   ;
;   ft_strdup.s                                        :+:      :+:    :+:   ;
;                                                    +:+ +:+         +:+     ;
;   By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+        ;
;                                                +#+#+#+#+#+   +#+           ;
;   Created: 2021/02/03 11:56:48 by smun              #+#    #+#             ;
;   Updated: 2021/02/03 15:48:21 by smun             ###   ########.fr       ;
;                                                                            ;
; ************************************************************************** ;

			global	_ft_strdup
			extern	_malloc
			section	.text
;	char				*ft_strdup(const char *s1)
;	{
;		char			*buf;
;		size_t			len;
;		size_t			i;
;
;		len = 0;
;		while (s1[len])
;			len++;
;		buf = malloc(len + 1);
;		if (buf == 0)
;			return (0);
;		i = 0;
;		while (i < len)
;		{
;			buf[i] = s1[i];
;			i++;
;		}
;		buf[i] = '\0';
;		return (buf);
;	}
;
;	char				*ft_strdup(const char *s1)
;	{
;		char			*src; // [rbp-8]
;		char			*buf; // [rbp-10h]
;		size_t			len; // [rbp-18h]
;		char			*srcbuf; // rsi
;		char			*dstbuf; // rdi
;		size_t			i; // rcx
;
;		i = 0;
;		while (s1[i])
;			i++;
;		src = srcbuf;
;		len = i;
;		i++;
;		buf = malloc(i);
;		if (buf == 0)
;			return (0);
;		dstbuf = buf;
;		srcbuf = src;
;		i = 0;
;		while (i < len)
;		{
;			*dstbuf = *srcbuf;
;			dstbuf++;
;			srcbuf++;
;			i++;
;		}
;		*dstbuf = '\0';
;		return (buf);
;	}
;
;	char				*ft_strdup(const char *s1)
;	{
;		char			*src; // [rbp-8]
;		char			*buf; // [rbp-10h]
;		size_t			len; // [rbp-18h]
;		char			*srcbuf; // rsi
;		char			*dstbuf; // rdi
;		size_t			i; // rcx
;		char			chr; // al
;
;		i = 0;
;	loop_len:
;		srcbuf = s1 + i;
;		chr = *srcbuf;
;		if (!chr)
;			goto break_len;
;		i++;
;		goto loop_len;
;	break_len:
;		src = s1;
;		len = i;
;		i++;
;		malloc((unsigned int)i);
;		if (!$?)
;			goto _return;
;		buf = $?;
;		dstbuf = $?;
;		srcbuf = src;
;		i = 0;
;	loop_cpy:
;		if (i >= len)
;			goto break_cpy;
;		chr = *srcbuf;
;		*dstbuf = chr;
;		srcbuf++;
;		dstbuf++;
;		i++;
;		goto loop_cpy;
;	break_cpy:
;		*dstbuf = 0;
;	_return:
;		return (buf);
;	}
;
_ft_strdup:	push	rbp					; stack frame
			mov		rbp, rsp
			sub		rsp, 18h			; char *src, *buf; size_t len;
			push	rcx					; size_t i;
			mov		rcx, 0				; i = 0;
loop_len:	lea		rsi, [rdi + rcx]	; srcbuf = s1 + i;
			mov		al, [rsi]			; chr = *srcbuf;
			test	al, al				; if (!chr)
			je		break_len			; goto break_len;
			inc		rcx					; i++;
			jmp		loop_len			; goto loop_len;
break_len:	mov		[rbp-8], rdi		; src = s1;
			mov		[rbp-18h], rcx		; len = i;
			inc		rcx;				; i++;
			mov		edi, ecx			; malloc((unsigned int)i);
			call	_malloc
			test	rax, rax			; if (!$?)
			je		_return				; goto _return;
			mov		[rbp-10h], rax		; buf = $?;
			mov		rdi, rax			; dstbuf = $?;
			mov		rsi, [rbp-8]		; srcbuf = src;
			mov		rcx, 0				; i = 0;
loop_cpy:	cmp		rcx, [rbp-18h]		; if (i >= len)
			jge		break_cpy			; goto break_cpy;
			mov		al, [rsi]			; chr = *srcbuf;
			mov		byte [rdi], al		; *dstbuf = chr;
			inc		rsi					; srcbuf++;
			inc		rdi					; dstbuf++;
			inc		rcx					; i++;
			jmp		loop_cpy			; goto loop_cpy;
break_cpy:	mov		byte [rdi], 0		; *dstbuf = 0;
			mov		rax, [rbp-10h]		; return (src);
_return:	pop		rcx
			mov		rsp, rbp
			pop		rbp
			ret
