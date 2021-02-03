;
;  ft_atoi_base_bonus.s
;    Created by smun<smun@student.42seoul.kr>
;

						global	_ft_atoi_base
						extern	_ft_strlen
						section	.text

; static char		*get_strnchr(char *s, int chr, int len)
_get_strnchr:
get_strnchr_loop:		mov		al, byte [rdi]
						test	al, al
						je		get_strnchr_not_found
						test	rdx, rdx
						je		get_strnchr_not_found
						dec		rdx
						movzx	eax, al
						cmp		eax, esi
						je		get_strnchr_found
						inc		rdi
						jmp		get_strnchr_loop
get_strnchr_found:		mov		rax, rdi
						ret
get_strnchr_not_found:	xor		rax, rax
						ret

; static int		is_valid_base(char *base)
;	t_uint64		len;	// [rbp-8]
;	char			*_base;	// [rbp-10h]
_is_valid_base:			push	rbp
						mov		rbp, rsp
						sub		rsp, 10h
						push	rcx
						mov		[rbp-10h], rdi
						call	_ft_strlen
						cmp		rax, 1
						jle		is_valid_base_error
						mov		[rbp-8], rax
						mov		rcx, 0
is_valid_base_loop:		cmp		rcx, [rbp-8]
						jge		is_valid_base_ok
						lea		rdi, [rel is_valid_base_sign]
						mov		rsi, [rbp-10h]
						lea		rsi, [rsi + rcx]
						mov		rdx, 2
						call	_get_strnchr
						test	rax, rax
						je		is_valid_base_error
						cmp		rcx, 1
						jle		is_valid_base_next
						mov		rdi, [rbp-10h]
						lea		rsi, [rdi + rcx]
						mov		rdx, rcx
						call	_get_strnchr
						test	rax, rax
						jne		is_valid_base_error
is_valid_base_next:		inc		rcx
						jmp		is_valid_base_loop
is_valid_base_error:	xor		rax, rax
						jmp		is_valid_base_return
is_valid_base_ok:		mov		rax, 1
is_valid_base_return:	pop		rcx
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
cvt_by_base_loop:		mov		al, byte [rsi]
						test	al, al
						je		cvt_by_base_return
						mov		rdi, [rbp-20h]
						movzx	rsi, al
						mov		rdx, [rbp-28h]
						call	_get_strnchr
						test	rax, rax
						je		cvt_by_base_return
						mov		rdx, [rbp-20h]
						sub		rax, rdx
						mov		[rbp-30h], rax
						mov		rax, [rbp-8]
						mov		rdx, [rbp-28h]
						imul	rdx
						mov		rdx, [rbp-30h]
						add		rax, rdx
						mov		rsi, [rbp-18h]
						inc		rsi
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
						mov		rcx, rdi
						mov		[rbp-10h], rsi
						mov		rdi, rsi
						call	_is_valid_base
						test	rax, rax
						je		ft_atoi_base_error
space_loop:				lea		rdi, [rel ft_atoi_base_space]
						movzx	rsi, byte [rcx]
						mov		rdx, 6
						call	_get_strnchr
						test	rax, rax
						je		space_end
						inc		rcx
						jmp		space_loop
space_end:				mov		rdx, 1
sign_loop:				mov		al, byte [rcx]
						cmp		al, 2Bh ; '+'
						je		sign_next
						cmp		al, 2Dh ; '-'
						jne		space_end
						neg		rdx
sign_next:				inc		rcx
						jmp		sign_loop
sign_end:				mov		[rbp-8], rdx
						mov		rdi, [rbp-10h]
						call	_ft_strlen
						mov		rdx, rax
						mov		rdi, rcx
						mov		rsi, [rbp-10h]
						call	_cvt_by_base
						mov		rdx, [rbp-8]
						imul	rdx
						jmp		ft_atoi_base_return
ft_atoi_base_error:		xor		rax, rax
ft_atoi_base_return:	pop		rcx
						mov		rsp, rbp
						pop		rbp
						ret

						section	.data
is_valid_base_sign:		db		"+-", 0x0
ft_atoi_base_space:		db		"\t\n\v\f\r ", 0x0
