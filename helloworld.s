			global	_hello
			section	.text
_hello:		mov		rax, 0x02000004
			mov		rdi, 1
			mov		rsi, message
			mov		rdx, 13
			syscall
			mov		rax, 0x02000001
			xor		rdi, rdi
			syscall

			section	.data
message:	db		"Hello world!!", 0xA
