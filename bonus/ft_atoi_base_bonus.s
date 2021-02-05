;
;  ft_atoi_base_bonus.s
;    Created by smun<smun@student.42seoul.kr>
;

						global	_ft_atoi_base
						extern	_ft_strlen
						section	.text

; static char		*ft_memchr(char *s, int chr, int len)
_ft_memchr:				mov		al, sil
						mov		rcx, rdx
						cld
						repnz	scasb
						je		ft_memchr_found
						xor		rax, rax
						ret
ft_memchr_found:		dec		rdi
						mov		rax, rdi
						ret

; static int		is_valid_base(char *base)
;	t_uint64		len;	// [rbp-8]
;	char			*_base;	// [rbp-10h]
;	long			i;		// rbx
_is_valid_base:			push	rbp
						mov		rbp, rsp
						sub		rsp, 10h
						push	rbx
						mov		[rbp-10h], rdi
						call	_ft_strlen			; ft_strlen(base)
						cmp		rax, 1				; len <= 1
						jle		is_valid_base_error
						mov		[rbp-8], rax
						xor		rbx, rbx			; i = 0
is_valid_base_loop:		cmp		rbx, [rbp-8]		; i < len
						jge		is_valid_base_ok
						lea		rdi, [rel s_sign]
						mov		rsi, [rbp-10h]
						lea		rsi, [rsi + rbx]
						movzx	rsi, byte [rsi]
						mov		rdx, 2
						call	_ft_memchr			; ft_memchr("+-", *(base + i), 2)
						test	rax, rax
						jne		is_valid_base_error
						lea		rdi, [rel s_space]
						mov		rsi, [rbp-10h]
						lea		rsi, [rsi + rbx]
						movzx	rsi, byte [rsi]
						mov		rdx, 6
						call	_ft_memchr			; ft_memchr("\t\n\v\f\r ", *(base + i), 6)
						test	rax, rax
						jne		is_valid_base_error
						cmp		rbx, 1				; i > 0
						jle		is_valid_base_next
						mov		rdi, [rbp-10h]
						lea		rsi, [rdi + rbx]
						movzx	rsi, byte [rsi]
						mov		rdx, rbx
						call	_ft_memchr			; ft_memchr(base, *(base + i), i)
						test	rax, rax
						jne		is_valid_base_error
is_valid_base_next:		inc		rbx					; i++
						jmp		is_valid_base_loop
is_valid_base_error:	xor		rax, rax			; return (0)
						jmp		is_valid_base_return
is_valid_base_ok:		mov		rax, 1				; return (1)
is_valid_base_return:	pop		rbx
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
;	char			*_str;	// rbx
_ft_atoi_base:			push	rbp
						mov		rbp, rsp
						sub		rsp, 10h
						push	rbx
						mov		[rbp-10h], rsi
						mov		rbx, rdi
						mov		rdi, rsi
						call	_is_valid_base
						test	rax, rax
						je		ft_atoi_base_error
space_loop:				lea		rdi, [rel s_space]
						movzx	rsi, byte [rbx]
						mov		rdx, 6
						call	_ft_memchr			; ft_memchr("\t\n\v\f\r ", *str, 6)
						test	rax, rax
						je		space_end
						inc		rbx
						jmp		space_loop
space_end:				mov		rdx, 1
sign_loop:				mov		al, byte [rbx]
						cmp		al, 2Bh				; *str == '+'
						je		sign_next
						cmp		al, 2Dh				; *str == '-'
						jne		sign_end
						neg		rdx					; neg = -neg
sign_next:				inc		rbx					; str++
						jmp		sign_loop
sign_end:				mov		[rbp-8], rdx
						mov		rdi, [rbp-10h]
						call	_ft_strlen			; ft_strlen(base)
						mov		rdx, rax
						mov		rdi, rbx
						mov		rsi, [rbp-10h]
						call	_cvt_by_base		; cvt_by_base(str, base, blen)
						mov		rdx, [rbp-8]
						imul	rdx					; * neg
						jmp		ft_atoi_base_return ; return ($?);
ft_atoi_base_error:		xor		rax, rax			; return (0);
ft_atoi_base_return:	pop		rbx
						mov		rsp, rbp
						pop		rbp
						ret

						section	.data
s_sign:					db		"+-", 0x0
s_space:				db		0x9, 0xA, 0xB, 0xC, 0xD, 0x20, 0x0
