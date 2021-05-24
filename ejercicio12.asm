	.include"m8535def.inc"
	.def aux = r16
	.def aux2 = r17
	.def auxH = r18
	.def auxL = r19
	.def cont =r20
	.def cont2 =r22
	.def aux3 = r21

reset:
	rjmp main
	.org $009
	rjmp onda
	.org $012
	rjmp onda ;vector INT2
main:
	ldi aux,low(RAMEND)
	out spl,aux
	ldi aux,high(RAMEND)
	out sph,aux
	rcall config_io
fin:
	nop
	nop
	rjmp fin
config_io:
	ldi cont,0
	ser aux
	out ddra,aux
	out portb,aux
	ldi aux,1; 0000 0001
	out timsk,aux; toie0
	ldi aux2,101
	out tcnt0,aux2
	ldi aux,$20; 0010 0000
	out gicr,aux
	sei
	ret
onda:
	nop
	nop
	ldi aux,2
	out tccr0,aux
	out tcnt0,aux2
	in aux,pina
	com aux
	out porta,aux
	inc cont
	cpi cont,240
	breq contar
	reti

contar:
	clr cont
	inc cont2
	cpi cont2,10
	breq stop
	reti

stop:
	nop
	ldi aux3, 0
	out tccr0,aux3
	clr cont2
	reti
	
