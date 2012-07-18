	.file	"main.c"
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__CCP__ = 0x34
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	INT2_init
	.type	INT2_init, @function
INT2_init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cbi 55-32,2
	in r24,91-32
	ori r24,lo8(32)
	out 91-32,r24
/* #APP */
 ;  151 "main.c" 1
	sei
 ;  0 "" 2
/* epilogue start */
/* #NOAPP */
	ret
	.size	INT2_init, .-INT2_init
.global	__vector_3
	.type	__vector_3, @function
__vector_3:
	push __zero_reg__
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r18
	push r19
	push r20
	push r24
	push r25
	push r26
	push r27
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 10 */
.L__stack_usage = 10
	sts RC5_DATA+1,__zero_reg__
	sts RC5_DATA,__zero_reg__
	ldi r24,lo8(21336)
	ldi r25,hi8(21336)
	out 74+1-32,r25
	out 74-32,r24
	 ldi r24,lo8(1049)
    ldi r25,hi8(1049)
    1:sbiw r24,1
    brne 1b
	rjmp .
	nop
	out 76+1-32,__zero_reg__
	out 76-32,__zero_reg__
	ldi r19,lo8(0)
	ldi r24,lo8(0)
	ldi r25,hi8(0)
.L10:
	in __tmp_reg__,88-32
	sbrs __tmp_reg__,4
	rjmp .L10
	in r18,88-32
	ori r18,lo8(16)
	out 88-32,r18
	lsl r24
	rol r25
	sts RC5_DATA+1,r25
	sts RC5_DATA,r24
	sbic 54-32,2
	rjmp .L12
.L4:
	subi r19,lo8(-(1))
	cpi r19,lo8(13)
	brne .L10
	movw r18,r24
	andi r18,lo8(-1280)
	andi r19,hi8(-1280)
	ldi r20,hi8(768)
	cpi r18,lo8(768)
	cpc r19,r20
	breq .L6
	lds r24,OCR1A_ADJUST
	lds r25,OCR1A_ADJUST+1
	out 74+1-32,r25
	out 74-32,r24
.L2:
/* epilogue start */
	pop r27
	pop r26
	pop r25
	pop r24
	pop r20
	pop r19
	pop r18
	pop r0
	out __SREG__,r0
	pop r0
	pop __zero_reg__
	reti
.L12:
	 ldi r26,lo8(40)
    1:dec r26
    brne 1b
	sbis 54-32,2
	rjmp .L4
	 ldi r27,lo8(40)
    1:dec r27
    brne 1b
	sbis 54-32,2
	rjmp .L4
	adiw r24,1
	sts RC5_DATA+1,r25
	sts RC5_DATA,r24
	rjmp .L4
.L6:
	sbi 56-32,0
	andi r24,lo8(63)
	andi r25,hi8(63)
	sts RC5_DATA+1,r25
	sts RC5_DATA,r24
	ldi r24,lo8(1)
	sts RC5_FLAG,r24
	lds r24,OCR1A_ADJUST
	lds r25,OCR1A_ADJUST+1
	out 74+1-32,r25
	out 74-32,r24
	in r24,89-32
	ori r24,lo8(16)
	out 89-32,r24
	 ldi r24,lo8(1199999)
    ldi r25,hi8(1199999)
    ldi r26,hlo8(1199999)
    1:subi r24,1
    sbci r25,0
    sbci r26,0
    brne 1b
	rjmp .
	nop
	cbi 56-32,0
	in r24,90-32
	ori r24,lo8(32)
	out 90-32,r24
	rjmp .L2
	.size	__vector_3, .-__vector_3
.global	__vector_7
	.type	__vector_7, @function
__vector_7:
	push __zero_reg__
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r18
	push r24
	push r25
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 8 */
.L__stack_usage = 8
	tst r4
	breq .L14
	mov r18,r5
	cpi r18,lo8(1)
	breq .L30
	movw r24,r2
	movw r30,r2
	subi r30,lo8(-(mmc_buf1))
	sbci r31,hi8(-(mmc_buf1))
	ld r18,Z
	out 92-32,r18
	adiw r24,1
	movw r30,r24
	subi r30,lo8(-(mmc_buf1))
	sbci r31,hi8(-(mmc_buf1))
	ld r18,Z
	out 67-32,r18
	adiw r24,1
	movw r2,r24
	ldi r18,hi8(512)
	cpi r24,lo8(512)
	cpc r25,r18
	brne .L13
.L33:
	mov r24,r5
	tst r5
	brne .L31
	ldi r25,lo8(1)
	sts BUF1_EMPTY,r25
.L23:
	ldi r25,lo8(1)
	mov r5,r24
	eor r5,r25
	clr r2
	clr r3
	rjmp .L13
.L14:
	mov r24,r5
	cpi r24,lo8(1)
	breq .L32
	movw r24,r2
	movw r30,r2
	subi r30,lo8(-(mmc_buf1))
	sbci r31,hi8(-(mmc_buf1))
.L24:
	ld r18,Z
	out 67-32,r18
	in r18,67-32
	out 92-32,r18
	adiw r24,1
	movw r2,r24
.L29:
	ldi r18,hi8(512)
	cpi r24,lo8(512)
	cpc r25,r18
	breq .L33
.L13:
/* epilogue start */
	pop r31
	pop r30
	pop r25
	pop r24
	pop r18
	pop r0
	out __SREG__,r0
	pop r0
	pop __zero_reg__
	reti
.L31:
	ldi r25,lo8(1)
	sts BUF0_EMPTY,r25
	rjmp .L23
.L30:
	movw r24,r2
	movw r30,r2
	subi r30,lo8(-(mmc_buf0))
	sbci r31,hi8(-(mmc_buf0))
	ld r18,Z
	out 92-32,r18
	adiw r24,1
	movw r30,r24
	subi r30,lo8(-(mmc_buf0))
	sbci r31,hi8(-(mmc_buf0))
	ld r18,Z
	out 67-32,r18
	adiw r24,1
	movw r2,r24
	rjmp .L29
.L32:
	movw r24,r2
	movw r30,r2
	subi r30,lo8(-(mmc_buf0))
	sbci r31,hi8(-(mmc_buf0))
	rjmp .L24
	.size	__vector_7, .-__vector_7
.global	timer1_init
	.type	timer1_init, @function
timer1_init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,78-32
	ori r24,lo8(9)
	out 78-32,r24
	out 76+1-32,__zero_reg__
	out 76-32,__zero_reg__
	ldi r24,lo8(10000)
	ldi r25,hi8(10000)
	out 74+1-32,r25
	out 74-32,r24
	in r24,89-32
	ori r24,lo8(16)
	out 89-32,r24
/* epilogue start */
	ret
	.size	timer1_init, .-timer1_init
.global	command
	.type	command, @function
command:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r25,lo8(-1)
	out 47-32,r25
.L36:
	sbis 46-32,7
	rjmp .L36
	ori r24,lo8(64)
	out 47-32,r24
.L37:
	sbis 46-32,7
	rjmp .L37
	mov r24,r23
	clr r25
	clr r26
	clr r27
	out 47-32,r24
.L38:
	sbis 46-32,7
	rjmp .L38
	movw r24,r22
	clr r26
	clr r27
	out 47-32,r24
.L39:
	sbis 46-32,7
	rjmp .L39
	clr r27
	mov r26,r23
	mov r25,r22
	mov r24,r21
	out 47-32,r24
.L40:
	sbis 46-32,7
	rjmp .L40
	out 47-32,r20
.L41:
	sbis 46-32,7
	rjmp .L41
	out 47-32,r18
.L42:
	sbis 46-32,7
	rjmp .L42
	ldi r24,lo8(-1)
	out 47-32,r24
.L43:
	sbis 46-32,7
	rjmp .L43
	in r24,47-32
/* epilogue start */
	ret
	.size	command, .-command
.global	mmc_read_sector
	.type	mmc_read_sector, @function
mmc_read_sector:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r20,r22
	movw r22,r24
	ldi r26,9
1:	lsl r20
	rol r21
	rol r22
	rol r23
	dec r26
	brne 1b
	ldi r24,lo8(17)
	ldi r18,lo8(-1)
	call command
	ldi r25,lo8(-1)
.L54:
	out 47-32,r25
.L53:
	sbis 46-32,7
	rjmp .L53
	in r24,47-32
	tst r24
	brne .L54
	ldi r25,lo8(-1)
.L61:
	out 47-32,r25
.L55:
	sbis 46-32,7
	rjmp .L55
	in r24,47-32
	cpi r24,lo8(-2)
	brne .L61
	ldi r30,lo8(mmc_buf)
	ldi r31,hi8(mmc_buf)
	ldi r25,lo8(-1)
.L58:
	out 47-32,r25
.L57:
	sbis 46-32,7
	rjmp .L57
	in r24,47-32
	st Z+,r24
	ldi r24,hi8(mmc_buf+512)
	cpi r30,lo8(mmc_buf+512)
	cpc r31,r24
	brne .L58
	ldi r24,lo8(-1)
	out 47-32,r24
.L59:
	sbis 46-32,7
	rjmp .L59
	ldi r24,lo8(-1)
	out 47-32,r24
.L60:
	sbis 46-32,7
	rjmp .L60
/* epilogue start */
	ret
	.size	mmc_read_sector, .-mmc_read_sector
.global	scan_root_dir
	.type	scan_root_dir, @function
scan_root_dir:
	push r8
	push r9
	push r10
	push r11
	push r12
	push r13
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 11 */
.L__stack_usage = 11
	movw r10,r24
	movw r8,r22
	mov r15,r20
	cpi r20,lo8(1)
	brne .+2
	rjmp .L90
	lds r24,base_count.1643
	lds r25,base_count.1643+1
	sbiw r24,32
	sts base_count.1643+1,r25
	sts base_count.1643,r24
	ldi r30,hi8(-32)
	cpi r24,lo8(-32)
	cpc r25,r30
	brne .+2
	rjmp .L74
	lds r12,sect_plus.1644
	lds r13,sect_plus.1644+1
.L75:
	sbrc r13,7
	rjmp .L76
	lds r28,base_count.1643
	lds r29,base_count.1643+1
.L89:
	lds r22,dir_start
	lds r23,dir_start+1
	add r22,r12
	adc r23,r13
	ldi r24,lo8(0)
	ldi r25,hi8(0)
	call mmc_read_sector
	rjmp .L77
.L93:
	adiw r28,32
	sts base_count.1643+1,r29
	sts base_count.1643,r28
.L84:
	lds r28,base_count.1643
	lds r29,base_count.1643+1
.L77:
	ldi r31,hi8(512)
	cpi r28,lo8(512)
	cpc r29,r31
	brge .L91
	movw r16,r28
	subi r16,lo8(-(mmc_buf))
	sbci r17,hi8(-(mmc_buf))
	movw r30,r16
	ld r24,Z
	tst r24
	breq .L79
	lds r25,mmc_buf+1
	tst r25
	breq .L80
	ldd r25,Z+2
	tst r25
	breq .L80
	cpi r24,lo8(-27)
	breq .L80
	ldd r24,Z+11
	andi r24,lo8(30)
	brne .L80
	movw r24,r28
	subi r24,lo8(-(mmc_buf+8))
	sbci r25,hi8(-(mmc_buf+8))
	movw r22,r10
	ldi r20,lo8(3)
	ldi r21,hi8(3)
	call strncmp
	sbiw r24,0
	brne .+2
	rjmp .L92
.L80:
	tst r15
	brne .L93
	sbiw r28,32
	sts base_count.1643+1,r29
	sts base_count.1643,r28
	rjmp .L84
.L91:
	lds r24,read_end.1642
	sts base_count.1643+1,__zero_reg__
	sts base_count.1643,__zero_reg__
	sec
	adc r12,__zero_reg__
	adc r13,__zero_reg__
	sts sect_plus.1644+1,r13
	sts sect_plus.1644,r12
	tst r24
	brne .L79
	ldi r28,lo8(0)
	ldi r29,hi8(0)
	rjmp .L89
.L79:
	ldi r24,lo8(-32)
	ldi r25,hi8(-32)
	sts base_count.1643+1,r25
	sts base_count.1643,r24
	sts sect_plus.1644+1,__zero_reg__
	sts sect_plus.1644,__zero_reg__
	sts read_end.1642,__zero_reg__
	ldi r18,lo8(0)
	ldi r19,hi8(0)
.L82:
	movw r24,r18
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	pop r8
	ret
.L90:
	lds r28,base_count.1643
	lds r29,base_count.1643+1
	adiw r28,32
	sts base_count.1643+1,r29
	sts base_count.1643,r28
	ldi r18,hi8(512)
	cpi r28,lo8(512)
	cpc r29,r18
	breq .L72
	lds r12,sect_plus.1644
	lds r13,sect_plus.1644+1
	rjmp .L89
.L76:
	sts sect_plus.1644+1,__zero_reg__
	sts sect_plus.1644,__zero_reg__
	sts base_count.1643+1,__zero_reg__
	sts base_count.1643,__zero_reg__
	ldi r28,lo8(0)
	ldi r29,hi8(0)
	clr r12
	clr r13
	rjmp .L89
.L74:
	ldi r24,lo8(480)
	ldi r25,hi8(480)
	sts base_count.1643+1,r25
	sts base_count.1643,r24
	lds r12,sect_plus.1644
	lds r13,sect_plus.1644+1
	sec
	sbc r12,__zero_reg__
	sbc r13,__zero_reg__
	sts sect_plus.1644+1,r13
	sts sect_plus.1644,r12
	rjmp .L75
.L92:
	movw r26,r16
	movw r30,r8
	ldi r24,lo8(0)
	ldi r25,hi8(0)
.L81:
	ld r18,X+
	st Z+,r18
	adiw r24,1
	cpi r24,11
	cpc r25,__zero_reg__
	brne .L81
	movw r30,r8
	std Z+11,__zero_reg__
	movw r30,r16
	ldd r19,Z+27
	ldi r18,lo8(0)
	ldd r24,Z+26
	add r18,r24
	adc r19,__zero_reg__
	sts STARTING_CLUSTER+1,r19
	sts STARTING_CLUSTER,r18
	rjmp .L82
.L72:
	sts base_count.1643+1,__zero_reg__
	sts base_count.1643,__zero_reg__
	lds r12,sect_plus.1644
	lds r13,sect_plus.1644+1
	sec
	adc r12,__zero_reg__
	adc r13,__zero_reg__
	sts sect_plus.1644+1,r13
	sts sect_plus.1644,r12
	ldi r28,lo8(0)
	ldi r29,hi8(0)
	rjmp .L89
	.size	scan_root_dir, .-scan_root_dir
.global	find_next_cluster
	.type	find_next_cluster, @function
find_next_cluster:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	lds r18,return_cluster.1602
	lds r19,return_cluster.1602+1
	subi r18,lo8(-(1))
	sbci r19,hi8(-(1))
	cp r18,r24
	cpc r19,r25
	brne .L95
	lds r20,cluster_index_in_buff.1601
	lds r21,cluster_index_in_buff.1601+1
	subi r20,lo8(-(1))
	sbci r21,hi8(-(1))
	sts cluster_index_in_buff.1601+1,r21
	sts cluster_index_in_buff.1601,r20
	cp r20,__zero_reg__
	cpc r21,__zero_reg__
	brne .L96
.L95:
	movw r28,r24
	andi r29,hi8(255)
	lsl r28
	rol r29
	sts cluster_index_in_buff.1601+1,r29
	sts cluster_index_in_buff.1601,r28
	mov r22,r25
	clr r23
	lds r24,fat_start
	lds r25,fat_start+1
	add r22,r24
	adc r23,r25
	ldi r24,lo8(0)
	ldi r25,hi8(0)
	call mmc_read_sector
	subi r28,lo8(-(mmc_buf))
	sbci r29,hi8(-(mmc_buf))
	ldd r25,Y+1
	ldi r24,lo8(0)
	ld r18,Y
	add r24,r18
	adc r25,__zero_reg__
	sts return_cluster.1602+1,r25
	sts return_cluster.1602,r24
/* epilogue start */
	pop r29
	pop r28
	ret
.L96:
	sts return_cluster.1602+1,r19
	sts return_cluster.1602,r18
	movw r24,r18
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	find_next_cluster, .-find_next_cluster
.global	forward_seconds
	.type	forward_seconds, @function
forward_seconds:
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 6 */
.L__stack_usage = 6
	movw r28,r24
/* #APP */
 ;  136 "main.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	lds r18,bitrate
	lds r19,bitrate+1
	lds r20,bitrate+2
	lds r21,bitrate+3
	ldi r26,9
1:	lsr r21
	ror r20
	ror r19
	ror r18
	dec r26
	brne 1b
	movw r24,r20
	movw r22,r18
	lsl r22
	rol r23
	rol r24
	rol r25
	lsl r22
	rol r23
	rol r24
	rol r25
	lsl r22
	rol r23
	rol r24
	rol r25
	lsl r22
	rol r23
	rol r24
	rol r25
	sub r22,r18
	sbc r23,r19
	sbc r24,r20
	sbc r25,r21
	lds r18,sect_per_clust
	ldi r19,lo8(0)
	ldi r20,lo8(0)
	ldi r21,hi8(0)
	call __udivmodsi4
	movw r14,r18
	movw r16,r20
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	cpc r20,__zero_reg__
	cpc r21,__zero_reg__
	brne .L100
	rjmp .L98
.L102:
	sec
	sbc r14,__zero_reg__
	sbc r15,__zero_reg__
	sbc r16,__zero_reg__
	sbc r17,__zero_reg__
	cp r14,__zero_reg__
	cpc r15,__zero_reg__
	cpc r16,__zero_reg__
	cpc r17,__zero_reg__
	breq .L98
.L100:
	movw r24,r28
	call find_next_cluster
	movw r28,r24
	ldi r24,hi8(-1)
	cpi r28,lo8(-1)
	cpc r29,r24
	brne .L102
.L98:
/* #APP */
 ;  144 "main.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	ret
	.size	forward_seconds, .-forward_seconds
.global	mmc_read_double_buffer
	.type	mmc_read_double_buffer, @function
mmc_read_double_buffer:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	movw r16,r22
	movw r18,r24
	mov r29,r20
	mov r28,r21
	ldi r27,9
1:	lsl r16
	rol r17
	rol r18
	rol r19
	dec r27
	brne 1b
	ldi r24,lo8(17)
	movw r22,r18
	movw r20,r16
	ldi r18,lo8(-1)
	call command
	ldi r25,lo8(-1)
.L105:
	out 47-32,r25
.L104:
	sbis 46-32,7
	rjmp .L104
	in r24,47-32
	tst r24
	brne .L105
	ldi r25,lo8(-1)
.L112:
	out 47-32,r25
.L106:
	sbis 46-32,7
	rjmp .L106
	in r24,47-32
	cpi r24,lo8(-2)
	brne .L112
	movw r24,r28
	mov r30,r25
	mov r31,r28
	ldi r24,lo8(0)
	ldi r25,hi8(0)
	ldi r19,lo8(-1)
.L109:
	out 47-32,r19
.L108:
	sbis 46-32,7
	rjmp .L108
	in r18,47-32
	st Z+,r18
	adiw r24,1
	ldi r18,hi8(512)
	cpi r24,lo8(512)
	cpc r25,r18
	brne .L109
	ldi r24,lo8(-1)
	out 47-32,r24
.L110:
	sbis 46-32,7
	rjmp .L110
	ldi r24,lo8(-1)
	out 47-32,r24
.L111:
	sbis 46-32,7
	rjmp .L111
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
	.size	mmc_read_double_buffer, .-mmc_read_double_buffer
.global	play_cluster
	.type	play_cluster, @function
play_cluster:
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 7 */
.L__stack_usage = 7
	lds r13,sect_per_clust
	lds r28,data_start
	lds r29,data_start+1
	tst r13
	brne .+2
	rjmp .L121
	sbiw r24,2
	movw r22,r24
	ldi r24,lo8(0)
	ldi r25,hi8(0)
	mov r18,r13
	ldi r19,lo8(0)
	ldi r20,lo8(0)
	ldi r21,hi8(0)
	call __mulsi3
	movw r14,r22
	movw r16,r24
	movw r24,r28
	ldi r26,lo8(0)
	ldi r27,hi8(0)
	add r14,r24
	adc r15,r25
	adc r16,r26
	adc r17,r27
	ldi r28,lo8(0)
	ldi r29,hi8(0)
	rjmp .L130
.L131:
	lds r24,BUF0_EMPTY
	tst r24
	brne .L123
.L130:
	lds r24,BUF1_EMPTY
	tst r24
	breq .L131
.L123:
	lds r24,BUF0_EMPTY
	tst r24
	brne .L132
	lds r24,BUF1_EMPTY
	tst r24
	brne .L133
.L126:
	adiw r28,1
	mov r24,r13
	ldi r25,lo8(0)
	cp r28,r24
	cpc r29,r25
	brge .L121
.L134:
	sec
	adc r14,__zero_reg__
	adc r15,__zero_reg__
	adc r16,__zero_reg__
	adc r17,__zero_reg__
	rjmp .L130
.L132:
	movw r24,r16
	movw r22,r14
	ldi r20,lo8(mmc_buf0)
	ldi r21,hi8(mmc_buf0)
	call mmc_read_double_buffer
	sts BUF0_EMPTY,__zero_reg__
	lds r13,sect_per_clust
	adiw r28,1
	mov r24,r13
	ldi r25,lo8(0)
	cp r28,r24
	cpc r29,r25
	brlt .L134
.L121:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	ret
.L133:
	movw r24,r16
	movw r22,r14
	ldi r20,lo8(mmc_buf1)
	ldi r21,hi8(mmc_buf1)
	call mmc_read_double_buffer
	sts BUF1_EMPTY,__zero_reg__
	lds r13,sect_per_clust
	rjmp .L126
	.size	play_cluster, .-play_cluster
.global	spi_read
	.type	spi_read, @function
spi_read:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(-1)
	out 47-32,r24
.L136:
	sbis 46-32,7
	rjmp .L136
	in r24,47-32
/* epilogue start */
	ret
	.size	spi_read, .-spi_read
.global	spi_write
	.type	spi_write, @function
spi_write:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	out 47-32,r24
.L139:
	sbis 46-32,7
	rjmp .L139
/* epilogue start */
	ret
	.size	spi_write, .-spi_write
.global	spi_init
	.type	spi_init, @function
spi_init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,55-32
	ori r24,lo8(-80)
	out 55-32,r24
	ldi r24,lo8(94)
	out 45-32,r24
	ldi r24,lo8(1)
	out 46-32,r24
/* epilogue start */
	ret
	.size	spi_init, .-spi_init
.global	LCD_STROBE
	.type	LCD_STROBE, @function
LCD_STROBE:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbi 50-32,5
	 ldi r24,lo8(4)
    1:dec r24
    brne 1b
	cbi 50-32,5
/* epilogue start */
	ret
	.size	LCD_STROBE, .-LCD_STROBE
.global	data
	.type	data, @function
data:
	push r29
	push r28
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 3 */
.L__stack_usage = 3
	sbi 50-32,6
	 ldi r25,lo8(-56)
    1:dec r25
    brne 1b
	mov r25,r24
	swap r25
	andi r25,lo8(15)
	out 53-32,r25
	std Y+1,r24
	call LCD_STROBE
	ldd r24,Y+1
	out 53-32,r24
	call LCD_STROBE
/* epilogue start */
	pop __tmp_reg__
	pop r28
	pop r29
	ret
	.size	data, .-data
.global	cmd
	.type	cmd, @function
cmd:
	push r29
	push r28
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 3 */
.L__stack_usage = 3
	cbi 50-32,6
	 ldi r25,lo8(-56)
    1:dec r25
    brne 1b
	mov r25,r24
	swap r25
	andi r25,lo8(15)
	out 53-32,r25
	std Y+1,r24
	call LCD_STROBE
	ldd r24,Y+1
	out 53-32,r24
	call LCD_STROBE
/* epilogue start */
	pop __tmp_reg__
	pop r28
	pop r29
	ret
	.size	cmd, .-cmd
.global	print_num
	.type	print_num, @function
print_num:
	push r6
	push r7
	push r8
	push r9
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r29
	push r28
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,18
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 18 */
/* stack size = 31 */
.L__stack_usage = 31
	movw r14,r22
	movw r16,r24
	cpi r20,lo8(1)
	brne .+2
	rjmp .L153
	ldi r24,lo8(-64)
	call cmd
.L147:
	cp r14,__zero_reg__
	cpc r15,__zero_reg__
	cpc r16,__zero_reg__
	cpc r17,__zero_reg__
	breq .L145
	movw r24,r28
	adiw r24,1
	std Y+18,r25
	std Y+17,r24
	movw r12,r24
	ldi r24,lo8(10)
	mov r6,r24
	mov r7,__zero_reg__
	mov r8,__zero_reg__
	mov r9,__zero_reg__
.L149:
	movw r24,r16
	movw r22,r14
	movw r20,r8
	movw r18,r6
	call __udivmodsi4
	subi r22,lo8(-(48))
	movw r30,r12
	st Z+,r22
	movw r12,r30
	mov r11,r30
	ldd r31,Y+17
	sub r11,r31
	movw r14,r18
	movw r16,r20
	cp r14,__zero_reg__
	cpc r15,__zero_reg__
	cpc r16,__zero_reg__
	cpc r17,__zero_reg__
	brne .L149
	tst r11
	breq .L145
	mov r14,r11
	clr r15
	sbrc r14,7
	com r15
	ldi r24,lo8(1)
	ldi r25,hi8(1)
	add r24,r28
	adc r25,r29
	add r14,r24
	adc r15,r25
.L150:
	dec r11
	sec
	sbc r14,__zero_reg__
	sbc r15,__zero_reg__
	movw r30,r14
	ld r24,Z
	call data
	tst r11
	brne .L150
.L145:
/* epilogue start */
	adiw r28,18
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r28
	pop r29
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r9
	pop r8
	pop r7
	pop r6
	ret
.L153:
	ldi r24,lo8(-128)
	call cmd
	rjmp .L147
	.size	print_num, .-print_num
.global	check_bitrate_and_stereo
	.type	check_bitrate_and_stereo, @function
check_bitrate_and_stereo:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r22,r24
	subi r22,lo8(-(-2))
	sbci r23,hi8(-(-2))
	ldi r24,lo8(0)
	ldi r25,hi8(0)
	lds r18,sect_per_clust
	ldi r19,lo8(0)
	ldi r20,lo8(0)
	ldi r21,hi8(0)
	call __mulsi3
	lds r18,data_start
	lds r19,data_start+1
	ldi r20,lo8(0)
	ldi r21,hi8(0)
	add r22,r18
	adc r23,r19
	adc r24,r20
	adc r25,r21
	call mmc_read_sector
	lds r24,mmc_buf+34
	cpi r24,lo8(8)
	breq .L159
	ldi r24,lo8(1)
	ret
.L159:
	lds r22,bitrate
	lds r23,bitrate+1
	lds r24,bitrate+2
	lds r25,bitrate+3
	ldi r30,lo8(mmc_buf+32)
	ldi r31,hi8(mmc_buf+32)
.L156:
	mov r25,r24
	mov r24,r23
	mov r23,r22
	clr r22
	ld r18,-Z
	ldi r19,lo8(0)
	ldi r20,lo8(0)
	ldi r21,hi8(0)
	or r22,r18
	or r23,r19
	or r24,r20
	or r25,r21
	ldi r18,hi8(mmc_buf+28)
	cpi r30,lo8(mmc_buf+28)
	cpc r31,r18
	brne .L156
	sts bitrate,r22
	sts bitrate+1,r23
	sts bitrate+2,r24
	sts bitrate+3,r25
	lds r18,mmc_buf+22
	mov r4,r18
	dec r4
	ldi r20,lo8(2)
	call print_num
	mov r22,r4
	clr r23
	sbrc r22,7
	com r23
	subi r22,lo8(-(1))
	sbci r23,hi8(-(1))
	clr r24
	sbrc r23,7
	com r24
	mov r25,r24
	ldi r18,lo8(12000000)
	ldi r19,hi8(12000000)
	ldi r20,hlo8(12000000)
	ldi r21,hhi8(12000000)
	call __mulsi3
	lds r18,bitrate
	lds r19,bitrate+1
	lds r20,bitrate+2
	lds r21,bitrate+3
	call __udivmodsi4
	sts OCR1A_BACKUP,r18
	sts OCR1A_BACKUP+1,r19
	sts OCR1A_BACKUP+2,r20
	sts OCR1A_BACKUP+3,r21
	sts OCR1A_ADJUST+1,r19
	sts OCR1A_ADJUST,r18
	out 74+1-32,r19
	out 74-32,r18
	ldi r24,lo8(0)
	ret
	.size	check_bitrate_and_stereo, .-check_bitrate_and_stereo
.global	clear
	.type	clear, @function
clear:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(1)
	call cmd
	 ldi r24,lo8(14999)
    ldi r25,hi8(14999)
    1:sbiw r24,1
    brne 1b
	rjmp .
	nop
/* epilogue start */
	ret
	.size	clear, .-clear
.global	lcd_init
	.type	lcd_init, @function
lcd_init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(15)
	out 52-32,r24
	in r24,49-32
	ori r24,lo8(96)
	out 49-32,r24
	 ldi r24,lo8(-20537)
    ldi r25,hi8(-20537)
    1:sbiw r24,1
    brne 1b
	rjmp .
	nop
	ldi r24,lo8(48)
	call cmd
	 ldi r24,lo8(2999)
    ldi r25,hi8(2999)
    1:sbiw r24,1
    brne 1b
	rjmp .
	nop
	ldi r24,lo8(48)
	call cmd
	 ldi r24,lo8(299)
    ldi r25,hi8(299)
    1:sbiw r24,1
    brne 1b
	rjmp .
	nop
	ldi r24,lo8(48)
	call cmd
	ldi r24,lo8(40)
	call cmd
	ldi r24,lo8(40)
	call cmd
	ldi r24,lo8(12)
	call cmd
	call clear
	ldi r24,lo8(6)
	call cmd
/* epilogue start */
	ret
	.size	lcd_init, .-lcd_init
.global	string
	.type	string, @function
string:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24
	cpi r22,lo8(1)
	breq .L168
	ldi r24,lo8(-64)
	call cmd
.L164:
	ld r24,Y
	tst r24
	breq .L162
	adiw r28,1
.L166:
	call data
	ld r24,Y+
	tst r24
	brne .L166
.L162:
/* epilogue start */
	pop r29
	pop r28
	ret
.L168:
	ldi r24,lo8(-128)
	call cmd
	rjmp .L164
	.size	string, .-string
	.data
.LC0:
	.string	"CARD ERROR-CMD0 "
.LC1:
	.string	"CARD ERROR-CMD1 "
.LC2:
	.string	"CARD ERROR-CMD16"
.LC3:
	.string	"MMC INITIALIZED!"
	.text
.global	mmc_init
	.type	mmc_init, @function
mmc_init:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	sbi 56-32,4
	ldi r24,lo8(50)
	ldi r25,hi8(50)
	ldi r18,lo8(-1)
.L171:
	out 47-32,r18
.L170:
	sbis 46-32,7
	rjmp .L170
	sbiw r24,1
	brne .L171
	cbi 56-32,4
	 ldi r24,lo8(2999)
    ldi r25,hi8(2999)
    1:sbiw r24,1
    brne 1b
	rjmp .
	nop
	ldi r24,lo8(0)
	ldi r20,lo8(0)
	ldi r21,hi8(0)
	movw r22,r20
	ldi r18,lo8(-107)
	call command
	sts count+1,__zero_reg__
	sts count,__zero_reg__
	ldi r18,lo8(-1)
.L172:
	out 47-32,r18
.L173:
	sbis 46-32,7
	rjmp .L173
	in r24,47-32
	cpi r24,lo8(1)
	breq .L174
	lds r24,count
	lds r25,count+1
	ldi r26,hi8(1000)
	cpi r24,lo8(1000)
	cpc r25,r26
	brsh .L176
	adiw r24,1
	sts count+1,r25
	sts count,r24
	rjmp .L172
.L174:
	lds r24,count
	lds r25,count+1
	ldi r27,hi8(1000)
	cpi r24,lo8(1000)
	cpc r25,r27
	brsh .L176
	ldi r24,lo8(1)
	ldi r20,lo8(0)
	ldi r21,hi8(0)
	movw r22,r20
	ldi r18,lo8(-1)
	call command
	sts count+1,__zero_reg__
	sts count,__zero_reg__
	ldi r24,lo8(0)
	ldi r25,hi8(0)
	ldi r28,lo8(-1)
.L179:
	out 47-32,r28
.L180:
	sbis 46-32,7
	rjmp .L180
	in r18,47-32
	tst r18
	breq .L181
	ldi r26,hi8(1000)
	cpi r24,lo8(1000)
	cpc r25,r26
	brlo .+2
	rjmp .L183
	ldi r24,lo8(1)
	ldi r20,lo8(0)
	ldi r21,hi8(0)
	movw r22,r20
	ldi r18,lo8(-1)
	call command
	lds r24,count
	lds r25,count+1
	adiw r24,1
	sts count+1,r25
	sts count,r24
	rjmp .L179
.L176:
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
.L196:
	ldi r22,lo8(1)
	call string
	 ldi r24,lo8(1199999)
    ldi r25,hi8(1199999)
    ldi r26,hlo8(1199999)
    1:subi r24,1
    sbci r25,0
    sbci r26,0
    brne 1b
	rjmp .
	nop
	ldi r24,lo8(1)
.L178:
/* epilogue start */
	pop r28
	ret
.L181:
	ldi r27,hi8(1000)
	cpi r24,lo8(1000)
	cpc r25,r27
	brsh .L183
	ldi r24,lo8(16)
	ldi r20,lo8(512)
	ldi r21,hi8(512)
	ldi r22,hlo8(512)
	ldi r23,hhi8(512)
	ldi r18,lo8(-1)
	call command
	sts count+1,__zero_reg__
	sts count,__zero_reg__
	ldi r18,lo8(-1)
.L185:
	out 47-32,r18
.L186:
	sbis 46-32,7
	rjmp .L186
	in r24,47-32
	tst r24
	breq .L187
	lds r24,count
	lds r25,count+1
	ldi r26,hi8(1000)
	cpi r24,lo8(1000)
	cpc r25,r26
	brsh .L189
	adiw r24,1
	sts count+1,r25
	sts count,r24
	rjmp .L185
.L183:
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	rjmp .L196
.L187:
	lds r24,count
	lds r25,count+1
	ldi r27,hi8(1000)
	cpi r24,lo8(1000)
	cpc r25,r27
	brsh .L189
	ldi r24,lo8(.LC3)
	ldi r25,hi8(.LC3)
	ldi r22,lo8(1)
	call string
	 ldi r24,lo8(1199999)
    ldi r25,hi8(1199999)
    ldi r26,hlo8(1199999)
    1:subi r24,1
    sbci r25,0
    sbci r26,0
    brne 1b
	rjmp .
	nop
	cbi 45-32,1
	ldi r24,lo8(0)
	rjmp .L178
.L189:
	ldi r24,lo8(.LC2)
	ldi r25,hi8(.LC2)
	rjmp .L196
	.size	mmc_init, .-mmc_init
	.data
.LC4:
	.string	"FAT16 DETECTED"
.LC5:
	.string	"NOT A FAT16"
	.text
.global	fat16_init
	.type	fat16_init, @function
fat16_init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r22,lo8(0)
	ldi r23,hi8(0)
	movw r24,r22
	call mmc_read_sector
	call clear
	ldi r24,lo8(-128)
	call cmd
	lds r24,mmc_buf+54
	cpi r24,lo8(70)
	brne .L198
	lds r24,mmc_buf+57
	cpi r24,lo8(49)
	breq .L200
.L198:
	ldi r24,lo8(.LC5)
	ldi r25,hi8(.LC5)
	ldi r22,lo8(1)
	call string
.L199:
	rjmp .L199
.L200:
	lds r24,mmc_buf+58
	cpi r24,lo8(54)
	brne .L198
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
	ldi r22,lo8(1)
	call string
	 ldi r24,lo8(1199999)
    ldi r25,hi8(1199999)
    ldi r26,hlo8(1199999)
    1:subi r24,1
    sbci r25,0
    sbci r26,0
    brne 1b
	rjmp .
	nop
	lds r24,mmc_buf+14
	ldi r25,lo8(0)
	sts fat_start+1,r25
	sts fat_start,r24
	lds r19,mmc_buf+23
	ldi r18,lo8(0)
	lds r20,mmc_buf+22
	add r18,r20
	adc r19,__zero_reg__
	lsl r18
	rol r19
	add r18,r24
	adc r19,r25
	sts dir_start+1,r19
	sts dir_start,r18
	lds r25,mmc_buf+18
	ldi r24,lo8(0)
	lds r20,mmc_buf+17
	add r24,r20
	adc r25,__zero_reg__
	ldi r22,lo8(16)
	ldi r23,hi8(16)
	call __divmodhi4
	add r22,r18
	adc r23,r19
	sts data_start+1,r23
	sts data_start,r22
	lds r24,mmc_buf+13
	sts sect_per_clust,r24
/* epilogue start */
	ret
	.size	fat16_init, .-fat16_init
.global	pwm_init
	.type	pwm_init, @function
pwm_init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,83-32
	ori r24,lo8(105)
	out 83-32,r24
	in r24,69-32
	ori r24,lo8(105)
	out 69-32,r24
	sbi 55-32,3
	sbi 49-32,7
/* epilogue start */
	ret
	.size	pwm_init, .-pwm_init
	.data
.LC6:
	.string	"WAV"
	.text
.global	main
	.type	main, @function
main:
	push r7
	push r8
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r29
	push r28
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,13
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 13 */
/* stack size = 26 */
.L__stack_usage = 26
	 ldi r24,lo8(119999)
    ldi r25,hi8(119999)
    ldi r26,hlo8(119999)
    1:subi r24,1
    sbci r25,0
    sbci r26,0
    brne 1b
	rjmp .
	nop
	in r24,55-32
	ori r24,lo8(-80)
	out 55-32,r24
	ldi r24,lo8(94)
	out 45-32,r24
	ldi r24,lo8(1)
	out 46-32,r24
	call lcd_init
	sbi 56-32,2
.L203:
	call mmc_init
	tst r24
	brne .L203
	call pwm_init
	call fat16_init
	in r24,78-32
	ori r24,lo8(9)
	out 78-32,r24
	out 76+1-32,__zero_reg__
	out 76-32,__zero_reg__
	ldi r24,lo8(10000)
	ldi r25,hi8(10000)
	out 74+1-32,r25
	out 74-32,r24
	in r24,89-32
	ori r24,lo8(16)
	out 89-32,r24
	cbi 55-32,2
	in r24,91-32
	ori r24,lo8(32)
	out 91-32,r24
/* #APP */
 ;  151 "main.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	sbi 55-32,0
	movw r14,r28
	sec
	adc r14,__zero_reg__
	adc r15,__zero_reg__
	ldi r20,lo8(1)
	clr r7
	inc r7
.L230:
	ldi r24,lo8(.LC6)
	ldi r25,hi8(.LC6)
	movw r22,r14
	call scan_root_dir
	movw r16,r24
	sbiw r24,0
	brne .L233
.L218:
	ldi r20,lo8(1)
	ldi r24,lo8(.LC6)
	ldi r25,hi8(.LC6)
	movw r22,r14
	call scan_root_dir
	movw r16,r24
	sbiw r24,0
	breq .L218
.L233:
	ldi r24,lo8(-128)
	call cmd
	call clear
	movw r24,r14
	ldi r22,lo8(1)
	call string
	movw r24,r16
	call check_bitrate_and_stereo
	tst r24
	brne .L218
	clr r5
	sts BUF0_EMPTY,r7
	clr r2
	clr r3
/* #APP */
 ;  107 "main.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
.L229:
	ldi r24,hi8(-1)
	cpi r16,lo8(-1)
	cpc r17,r24
	brne .L225
	rjmp .L222
.L209:
	ldi r25,hi8(-1)
	cpi r16,lo8(-1)
	cpc r17,r25
	brne .+2
	rjmp .L222
.L225:
	movw r24,r16
	call play_cluster
	movw r24,r16
	call find_next_cluster
	movw r16,r24
	in r24,48-32
	andi r24,lo8(12)
	breq .L207
	sbic 48-32,3
	rjmp .L222
	sbic 48-32,2
	rjmp .L223
.L207:
	lds r24,RC5_FLAG
	tst r24
	breq .L209
	mov r9,r16
	mov r8,r17
	sts RC5_FLAG,__zero_reg__
	lds r12,RC5_DATA
	lds r13,RC5_DATA+1
	movw r10,r12
	ldi r25,lo8(32)
	cp r12,r25
	cpc r13,__zero_reg__
	breq .L222
	ldi r26,lo8(33)
	cp r12,r26
	cpc r13,__zero_reg__
	brne .+2
	rjmp .L223
	ldi r27,lo8(1)
	cp r12,r27
	cpc r13,__zero_reg__
	brne .+2
	rjmp .L234
.L210:
	ldi r24,lo8(3)
	cp r12,r24
	cpc r13,__zero_reg__
	brne .+2
	rjmp .L235
.L211:
	ldi r25,lo8(2)
	cp r12,r25
	cpc r13,__zero_reg__
	breq .L236
	ldi r26,lo8(6)
	cp r12,r26
	cpc r13,__zero_reg__
	breq .L237
.L213:
	ldi r27,lo8(5)
	cp r10,r27
	cpc r11,__zero_reg__
	breq .+2
	rjmp .L229
	lds r16,STARTING_CLUSTER
	lds r17,STARTING_CLUSTER+1
	ldi r24,hi8(-1)
	cpi r16,lo8(-1)
	cpc r17,r24
	breq .+2
	rjmp .L225
.L222:
	ldi r20,lo8(1)
.L208:
/* #APP */
 ;  126 "main.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	std Y+13,r20
	call clear
	 ldi r24,lo8(239999)
    ldi r25,hi8(239999)
    ldi r26,hlo8(239999)
    1:subi r24,1
    sbci r25,0
    sbci r26,0
    brne 1b
	rjmp .
	nop
	ldd r20,Y+13
	rjmp .L230
.L236:
	lds r24,OCR1A_BACKUP
	lds r25,OCR1A_BACKUP+1
	sts OCR1A_ADJUST+1,r25
	sts OCR1A_ADJUST,r24
	out 74+1-32,r25
	out 74-32,r24
	ldi r21,lo8(2)
	mov r10,r21
	mov r11,__zero_reg__
	ldi r26,lo8(6)
	cp r12,r26
	cpc r13,__zero_reg__
	brne .L213
.L237:
	mov r24,r9
	mov r25,r8
	call forward_seconds
	movw r16,r24
	lds r10,RC5_DATA
	lds r11,RC5_DATA+1
	rjmp .L213
.L235:
	lds r22,OCR1A_BACKUP
	lds r23,OCR1A_BACKUP+1
	lds r24,OCR1A_BACKUP+2
	lds r25,OCR1A_BACKUP+3
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,hlo8(20)
	ldi r21,hhi8(20)
	call __udivmodsi4
	lds r24,OCR1A_ADJUST
	lds r25,OCR1A_ADJUST+1
	sub r24,r18
	sbc r25,r19
	sts OCR1A_ADJUST+1,r25
	sts OCR1A_ADJUST,r24
	out 74+1-32,r25
	out 74-32,r24
	ldi r22,lo8(3)
	mov r10,r22
	mov r11,__zero_reg__
	rjmp .L211
.L234:
	lds r22,OCR1A_BACKUP
	lds r23,OCR1A_BACKUP+1
	lds r24,OCR1A_BACKUP+2
	lds r25,OCR1A_BACKUP+3
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,hlo8(20)
	ldi r21,hhi8(20)
	call __udivmodsi4
	lds r24,OCR1A_ADJUST
	lds r25,OCR1A_ADJUST+1
	add r24,r18
	adc r25,r19
	sts OCR1A_ADJUST+1,r25
	sts OCR1A_ADJUST,r24
	out 74+1-32,r25
	out 74-32,r24
	rjmp .L210
.L223:
	ldi r20,lo8(0)
	rjmp .L208
	.size	main, .-main
.global	pull_up_enable
	.type	pull_up_enable, @function
pull_up_enable:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbi 56-32,2
/* epilogue start */
	ret
	.size	pull_up_enable, .-pull_up_enable
.global	init_RC5_valid_indicator_LED
	.type	init_RC5_valid_indicator_LED, @function
init_RC5_valid_indicator_LED:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbi 55-32,0
/* epilogue start */
	ret
	.size	init_RC5_valid_indicator_LED, .-init_RC5_valid_indicator_LED
.global	arg
.global	arg
	.section .bss
	.type	arg, @object
	.size	arg, 4
arg:
	.skip 4,0
.global	BUF0_EMPTY
.global	BUF0_EMPTY
	.type	BUF0_EMPTY, @object
	.size	BUF0_EMPTY, 1
BUF0_EMPTY:
	.skip 1,0
	.comm readdata,1,1
	.comm count,2,1
	.comm mmc_buf,512,1
	.comm mmc_buf0,512,1
	.comm mmc_buf1,512,1
	.comm fat_start,2,1
	.comm dir_start,2,1
	.comm data_start,2,1
	.comm sect_per_clust,1,1
	.comm BUF1_EMPTY,1,1
	.comm OCR1A_BACKUP,4,1
	.comm bitrate,4,1
	.comm RC5_DATA,2,1
	.comm RC5_FLAG,1,1
	.comm OCR1A_ADJUST,2,1
	.comm STARTING_CLUSTER,2,1
	.lcomm sect_plus.1644,2
	.data
	.type	base_count.1643, @object
	.size	base_count.1643, 2
base_count.1643:
	.word	-32
	.lcomm read_end.1642,1
	.lcomm return_cluster.1602,2
	.lcomm cluster_index_in_buff.1601,2
.global __do_copy_data
.global __do_clear_bss
