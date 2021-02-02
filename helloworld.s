			global	_hello
			global	_world
			extern	_printf
			section	.text
_hello:
			push	rsi
			push	rdx
			mov		rax, 0x02000004
			lea		rsi, [rel message]
			;mov		rsi, message
			mov		rdx, 14
			syscall
			pop rdx
			pop rsi
			ret

_world:		push	rdi
			lea		rdi, [rel message]
			call	_printf
			pop		rdi
			ret

			section	.data
message:	db		"Hello world!!", 0xA, 0x0
