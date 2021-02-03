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
			extern	_ft_strlen
			extern	_ft_strcpy
			section	.text
;	char				*ft_strdup(const char *s1)
;	{
;		char			*buf;
;		size_t			len;
;
;		len = ft_strlen(s1);
;		buf = malloc(len + 1);
;		if (buf == 0)
;			return (0);
;		return (ft_strcpy(buf, s1));
;	}
;
;	char				*ft_strdup(const char *s1)
;	{
;		char			*src; // [rbp-8]
;		char			*buf; // [rbp-10h]
;		size_t			len; // [rbp-18h]
;
;		src = s1;
;		$1 = ft_strlen(s1);
;		if (!$1)
;			return (0);
;		len = $1;
;		$2 = malloc(len + 1);
;		if (!$2)
;			return (0);
;		buf = $2;
;		return (ft_strcpy(buf, src));
;	}
;
_ft_strdup:	push	rbp					; stack frame
			mov		rbp, rsp
			sub		rsp, 20h			; char *src, *buf; size_t len;
			mov		[rbp-8], rdi		; src = s1;
			call	_ft_strlen			; ft_strlen(s1);
			test	rax, rax			; if (!$?)
			je		_return				; goto _return;
			mov		[rbp-18h], rax		; len = $?;
			mov		rdi, rax
			inc		rdi
			call	_malloc				; malloc(len + 1)
			test	rax, rax			; if (!$?)
			je		_return				; goto _return;
			mov		[rbp-10h], rax		; buf = $?;
			mov		rdi, rax
			mov		rsi, [rbp-8]
			call	_ft_strcpy			; ft_strcpy(buf, src);
_return:	pop		rcx
			mov		rsp, rbp
			pop		rbp
			ret
