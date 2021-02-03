;
;  ft_atoi_base_bonus.s
;    Created by smun<smun@student.42seoul.kr>
;

						global	_ft_atoi_base
						section	.text

; static char		*get_strnchr(char *s, int chr, int len)
_get_strnchr:
_get_strnchr_loop:		mov		al, rdi
						test	al, al
						je		_not_found
						test	rdx, rdx
						je		_not_found
						dec		rdx
						cmp		al, esi
						je		_found
						inc		rdi
						jmp		_loop
_get_strnchr_found:		mov		rax, rdi
						ret
_get_strnchr_not_found:	xor		rax, rax
						ret

; static int		get_strlen(const char *s)
_get_strlen:			push	rcx
						mov		rcx, 0
_get_strlen_loop:		mov		al, [rdi]
						test	al, al
						je		_return
						inc		rcx
						inc		rdi
						jmp		_loop
_get_strlen_return:		mov		rax, rcx
						pop		rcx
						ret

; static int		is_valid_base(char *base)
;	t_uint64		len;	// [rbp-8]
;	t_uint64		i;		// [rbp-10h]
;	char			*_base;	// [rbp-18h]
_is_valid_base:			push	rbp
						mov		rbp, rsp
						sub		rsp, 18h
						push	rcx
						call	_get_strlen
						cmp		rax, 1
						jle		_is_valid_base_error
						mov		[rbp-8], rax
						mov		[rbp-18h], rdi
						mov		rcx, 0
_is_valid_base_loop:	cmp		rcx, [rbp-8]
						jge		_is_valid_base_ok
						lea		rdi, [rel _is_valid_base_sign]
						mov		rsi, [rbp-18h]
						lea		rsi, [rsi + rcx]
						mov		rdx, 2
						call	_get_strnchr
						test	rax, rax
						je		_is_valid_base_error
						; :52


_is_valid_base_error:	xor		rax, rax
						jmp		_is_valid_base_return
_is_valid_base_ok:		mov		rax, 1
_is_valid_base_return:	pop		rcx
						mov		rsp, rbp
						pop		rbp
						ret
						int3
_is_valid_base_sign:	db		"+-", 0x0


_ft_atoi_base:
