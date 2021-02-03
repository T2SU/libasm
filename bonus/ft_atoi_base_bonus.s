;
;  ft_atoi_base_bonus.s
;    Created by smun<smun@student.42seoul.kr>
;

						global	_ft_atoi_base
						extern	_ft_strlen
						section	.text

; static char		*get_strnchr(char *s, int chr, int len)
_get_strnchr:
get_strnchr_loop:		mov		al, rdi
						test	al, al
						je		get_strnchr_not_found
						test	rdx, rdx
						je		get_strnchr_not_found
						dec		rdx
						cmp		al, esi
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
						lea		rdi, [rel _is_valid_base_sign]
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
;	int				blen;	// [rbp-28h]
_cvt_by_base:			push	rbp
						mov		rbp, rsp
						sub		rsp, 28h
						mov		[rbp-8], 0
						mov		[rbp-18h], rdi
						mov		[rbp-20h], rsi
						mov		[rbp-28h], rdx
cvt_by_base_loop:		lea		rsi, [rbp-18h]
						mov		al, byte [rsi]
						test	al, al
						je		cvt_by_base_return

cvt_by_base_return:		mov		rax, [rbp-8]
						mov		rsp, rbp
						pop		rbp
						ret

_ft_atoi_base:

						section	.data
is_valid_base_sign:		db		"+-", 0x0
