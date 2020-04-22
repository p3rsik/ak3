.syntax unified
.cpu cortex-m4
//.fpu softvfp
.thumb
#define A0 #3 // a
#define A1 #4 // b
#define A2 #5 // c

// (a&b)>> + c!

.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
    .word __stack_start 
    .word __kernel_reset__+1
    .size vtable_kernel, .-vtable_kernel

.section .rodata
    data: .asciz "kernel started!\n"
    final: .asciz "Value in register #0: "
.section .text
__kernel_reset__:
    ldr r0, =data
    bl dbgput_line
    
    // calculate 
    bl lab1
resume: 
    mov r3, r0
    ldr r0, =final
    bl dbgput
    mov r0, r3
    bl dbgput_num
    
    end:
    b end

lab1:
    push {lr}
    mov r0, A2
    mov r1, A0
    mov r2, A1

    bl calc
    pop {pc}

calc:
    push {r4, r5, lr}
    mov r4, r0
    rev r0, r0
    and r1, r2
    lsr r0, 1
    adds r0, r1
    // calculate fact here
    mov r5, r0
    mov r0, r4
    bl fact
    add r0, r1
    pop {r4, r5, pc}

fact:
    push {r4}
    subs r0, #1
    .loop:
    mul r4, r0
    subs r0, #1
    bne .loop
    mov r0, r4
    pop {r4}
    bx lr
    
