         mload m16.fpe
         copy  e16.fpe

         mcopy 13/orcainclude/m16.orca
         mcopy 13/ainclude/m16.misctool

dummy    private
         end

mc68881  gequ  0                        DP location with FP slot address

fpe_base gequ  $C0C0                    base address of FPE in slot 4

loopcnt  gequ  10000                    number of loop iterations

;         list  on
;         gen   on

fast_float start
         phk
         plb

         jsl   SystemEnvironmentInit
         jsl   SysIOStartup

         pha
         pha
         _GetTick
         pl4   tick1

         lda   #fpe_base
         sta   mc68881
         stz   mc68881+2

         regregr rpi,fp4                fp4 := a (pi)
         memregx fmove,fp5,const_b      fp5 := b

         ldx   #loopcnt

loop     anop
         regreg fmove,fp4,fp3           fp3 := a
         regreg fmul,fp5,fp3            fp3 := a * b
         regreg fdiv,fp4,fp3            fp3 := fp3 / a
         regreg fmove,fp4,fp3           fp3 := a
         regreg fmul,fp5,fp3            fp3 := a * b
         regreg fdiv,fp4,fp3            fp3 := fp3 / a
         regreg fmove,fp4,fp3           fp3 := a
         regreg fmul,fp5,fp3            fp3 := a * b
         regreg fdiv,fp4,fp3            fp3 := fp3 / a
         regreg fmove,fp4,fp3           fp3 := a
         regreg fmul,fp5,fp3            fp3 := a * b
         regreg fdiv,fp4,fp3            fp3 := fp3 / a
         regreg fmove,fp4,fp3           fp3 := a
         regreg fmul,fp5,fp3            fp3 := a * b
         regreg fdiv,fp4,fp3            fp3 := fp3 / a
         regreg fmove,fp4,fp3           fp3 := a
         regreg fmul,fp5,fp3            fp3 := a * b
         regreg fdiv,fp4,fp3            fp3 := fp3 / a
         regreg fmove,fp4,fp3           fp3 := a
         regreg fmul,fp5,fp3            fp3 := a * b
         regreg fdiv,fp4,fp3            fp3 := fp3 / a

         dex
         beq   done
         brl   loop
done     anop

         regmemx fmove,fp3,result

         pha
         pha
         _GetTick
         pl4   tick2
         sub4  tick2,tick1

         memregl fmove,fp5,tick2
         memregw fmove,fp6,sixty
         regreg fdiv,fp6,fp5
         regmemx fmove,fp5,seconds

         lda   seconds+8
         pha
         lda   seconds+6
         pha
         lda   seconds+4
         pha
         lda   seconds+2
         pha
         lda   seconds
         pha
         ph4   tick2
         lda   result+8
         pha
         lda   result+6
         pha
         lda   result+4
         pha
         lda   result+2
         pha
         lda   result
         pha
         ph4   #format
         case  on
         jsl   printf
         case  off

         jsl   SysIOShutDown
         rtl

const_b  dc    e'1.7839032e4'
result   ds    10
format   dc    c'result = %f, time = %lu ticks (%f seconds)',i1'10',i1'0'
tick1    ds    4
tick2    ds    4
sixty    dc    i2'60'
seconds  ds    10
         end
