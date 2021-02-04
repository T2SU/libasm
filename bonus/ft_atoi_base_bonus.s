;
;  ft_atoi_base_bonus.s
;    Created by smun<smun@student.42seoul.kr>
;

						global	_ft_atoi_base
						extern	_ft_strlen
						section	.text

; static char		*ft_memchr(char *s, int chr, int len)
_ft_memchr:				mov		al, byte [rdi]		; *s
						test	al, al
						je		ft_memchr_not_found
						test	rdx, rdx			; len
						je		ft_memchr_not_found
						dec		rdx					; len--
						movzx	eax, al
						cmp		eax, esi			; *s == chr
						je		ft_memchr_found
						inc		rdi					; s++
						jmp		_ft_memchr
ft_memchr_found:		mov		rax, rdi			; return (s)
						ret
ft_memchr_not_found:	xor		rax, rax			; return (0)
						ret

; static int		is_valid_base(char *base)
;	t_uint64		len;	// [rbp-8]
;	char			*_base;	// [rbp-10h]
_is_valid_base:			push	rbp
						mov		rbp, rsp
						sub		rsp, 10h
						push	rcx
						push	rdx
						push	rsi
						mov		[rbp-10h], rdi
						call	_ft_strlen			; ft_strlen(base)
						cmp		rax, 1				; len <= 1
						jle		is_valid_base_error
						mov		[rbp-8], rax
						xor		rcx, rcx			; i = 0
is_valid_base_loop:		cmp		rcx, [rbp-8]		; i < len
						jge		is_valid_base_ok
						lea		rdi, [rel s_sign]
						mov		rsi, [rbp-10h]
						lea		rsi, [rsi + rcx]
						movzx	rsi, byte [rsi]
						mov		rdx, 2
						call	_ft_memchr			; ft_memchr("+-", *(base + i), 2)
						test	rax, rax
						jne		is_valid_base_error
						cmp		rcx, 1				; i > 0
						jle		is_valid_base_next
						mov		rdi, [rbp-10h]
						lea		rsi, [rdi + rcx]
						movzx	rsi, byte [rsi]
						mov		rdx, rcx
						dec		rdx
						call	_ft_memchr			; ft_memchr(base, *(base + i), i - 1)
						test	rax, rax
						jne		is_valid_base_error
is_valid_base_next:		inc		rcx					; i++
						jmp		is_valid_base_loop
is_valid_base_error:	xor		rax, rax			; return (0)
						jmp		is_valid_base_return
is_valid_base_ok:		mov		rax, 1				; return (1)
is_valid_base_return:	pop		rsi
						pop		rdx
						pop		rcx
						mov		rsp, rbp
						pop		rbp
						ret

; static int		cvt_by_base(char *str, char *base, int blen)
;	t_int64			nbr;	// [rbp-8]
;	char			*pos;	// [rbp-10h]
;	char			*_str;	// [rbp-18h]
;	char			*_base;	// [rbp-20h]
;	t_int64			blen;	// [rbp-28h]
;	t_int64			i;		// [rbp-30h]
_cvt_by_base:			push	rbp
						mov		rbp, rsp
						sub		rsp, 30h
						mov		qword [rbp-8], 0
						mov		[rbp-18h], rdi
						mov		[rbp-20h], rsi
						mov		[rbp-28h], rdx
						mov		rsi, [rbp-18h]
cvt_by_base_loop:		mov		al, byte [rsi]		; *str
						test	al, al
						je		cvt_by_base_return
						mov		rdi, [rbp-20h]
						movzx	rsi, al
						mov		rdx, [rbp-28h]
						call	_ft_memchr			; ft_memchr(base, *str, blen)
						test	rax, rax
						je		cvt_by_base_return
						mov		rdx, [rbp-20h]
						sub		rax, rdx			; pos - base
						mov		[rbp-30h], rax
						mov		rax, [rbp-8]
						mov		rdx, [rbp-28h]
						imul	rdx					; nbr = nbr * blen
						mov		rdx, [rbp-30h]
						add		rax, rdx			; nbr = nbr + i
						mov		[rbp-8], rax
						mov		rsi, [rbp-18h]
						inc		rsi					; str++
						mov		[rbp-18h], rsi
						jmp		cvt_by_base_loop
cvt_by_base_return:		mov		rax, [rbp-8]
						mov		rsp, rbp
						pop		rbp
						ret

; int				ft_atoi_base(char *str, char *base)
;	int64_t			neg;	// [rbp-8]
;	char			*_base;	// [rbp-10h]
;	char			*_str;	// rcx
_ft_atoi_base:			push	rbp
						mov		rbp, rsp
						sub		rsp, 10h
						push	rcx
						push	rdx
						mov		rcx, rdi
						mov		[rbp-10h], rsi
						mov		rdi, rsi
						call	_is_valid_base
						test	rax, rax
						je		ft_atoi_base_error
space_loop:				lea		rdi, [rel s_space]
						movzx	rsi, byte [rcx]
						mov		rdx, 6
						call	_ft_memchr			; ft_memchr("\t\n\v\f\r ", *str, 6)
						test	rax, rax
						je		space_end
						inc		rcx
						jmp		space_loop
space_end:				mov		rdx, 1
sign_loop:				mov		al, byte [rcx]
						cmp		al, 2Bh				; *str == '+'
						je		sign_next
						cmp		al, 2Dh				; *str == '-'
						jne		sign_end
						neg		rdx					; neg = -neg
sign_next:				inc		rcx					; str++
						jmp		sign_loop
sign_end:				mov		[rbp-8], rdx
						mov		rdi, [rbp-10h]
						call	_ft_strlen			; ft_strlen(base)
						mov		rdx, rax
						mov		rdi, rcx
						mov		rsi, [rbp-10h]
						call	_cvt_by_base		; cvt_by_base(str, base, blen)
						mov		rdx, [rbp-8]
						imul	rdx					; * neg
						jmp		ft_atoi_base_return ; return ($?);
ft_atoi_base_error:		xor		rax, rax			; return (0);
ft_atoi_base_return:	pop		rdx
						pop		rcx
						mov		rsp, rbp
						pop		rbp
						ret

						section	.data
s_sign:					db		"+-", 0x0
s_space:				db		0x9, 0xA, 0xB, 0xC, 0xD, 0x20, 0x0
