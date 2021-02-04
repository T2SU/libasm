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
;		len = $1;
;		$2 = malloc(len + 1);
;		if (!$2)
;			return (0);
;		buf = $2;
;		return (ft_strcpy(buf, src));
;	}
;
_ft_strdup:	push	rcx					; [ 8] char *src;
			push	rbx					; [10] char *buf;
			mov		rcx, rdi			; [18] src = s1;
			call	_ft_strlen			; [18] ft_strlen(s1);
			mov		rdi, rax			; [18]
			inc		rdi					; [18]
			sub		rsp, 8				; [18]
			call	_malloc				; [20] malloc(len + 1)
			add		rsp, 8				; [20]
			test	rax, rax			; [18] if (!$?)
			je		_return				; [18] goto _return;
			mov		rbx, rax			; [18] buf = $?;
			mov		rdi, rax			; [18]
			mov		rsi, rcx			; [18]
			call	_ft_strcpy			; [18] ft_strcpy(buf, src);
_return:	mov		rax, rbx			; [18]
			pop		rbx					; [10]
			pop		rcx					; [ 8]
			ret							; [ 8]
