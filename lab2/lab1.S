.global lab1
.syntax unified
#define A0 #3
#define A1 #4
#define A2 #5
#define A3 #6

// (a&b)>> + c!

lab1:
    push {lr}
    mov r0, A0
    mov r1, A1
    mov r2, A2
    mov r3, A3

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
