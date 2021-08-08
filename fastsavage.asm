         mload m16.fpe
         copy  e16.fpe

         mcopy 13/orcainclude/m16.orca
         mcopy 13/ainclude/m16.misctool

dummy    private
         end

mc68881  gequ  0                        DP location with FP slot address

fpe_base gequ  $C0C0                    base address of FPE in slot 4

loopcnt  gequ  25000                    number of loops iterations

fast_savage start
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

         regregr r10t0,fp3              fp3 := 1.0
         regregr r10t0,fp4              fp4 := 1.0

         ldx   #loopcnt-1

loop     regreg fmul,fp3,fp3
         regreg fsqrt,fp3,fp3
         regreg flogn,fp3,fp3
         regreg fetox,fp3,fp3
         regreg fatan,fp3,fp3
         regreg ftan,fp3,fp3
         regreg fadd,fp4,fp3

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

result   ds    10
format   dc    c'result = %f, time = %lu ticks (%f seconds)',i1'10',i1'0'
tick1    ds    4
tick2    ds    4
sixty    dc    i2'60'
seconds  ds    10
         end
