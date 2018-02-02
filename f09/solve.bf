** BF(688) **
* convert input strings to answers for each line
* ex: "aegj" to "286/435/971"
**
* loop for each line with 1 char read ahead
,+[
 * setup the initial state ( 1 to 9 )
 >>>>>>+++++++++[-
  [->>+<<]
  <+[->+>+<<]
 >>>]
 <[-]<[<<]<<<<
 * each char
 [
  * divmod by 3
  -[>[->>>]<[>++>+>]<<<-]
  >+>----[
   * except NL: switch
   >++++[-<------->]<-[-[-[-<
     * case jkl
     * move to the left of 321
     [-[->>+<<]>>]>>
     * rotate ( vertical )
     >[->+<]<++[->>[->>>>>>+<<<<<<]>>>>>[-<<<<<<+>>>>>>]<<<<<<<[->>>>>>+<<<<<<]>>>>>>]>>[-<+>]
     * move back
     <[<<]<<<
    >]<[
     * case ghi
     * move to the right of 963
     [-[->>>>>>+<<<<<<]>>>>>>]>>>>
     * rotate ( horizontal reverse )
     <[-<+>]>++[-<<[-<<+>>]<[->>+<<]>>>[-<<+>>]<<]<<[->+<]
     * move back
     <[<<]<<<
   ]>]<[
     * case def
     * move to the right of 789
     ---[+[+>>-<<]>>]>>>>>>>>>>>>>>>>>>
     * rotate ( vertical reverse )
     <[-<+>]>++[-<<[-<<<<<<+>>>>>>]<<<<<[->>>>>>+<<<<<<]>>>>>>>[-<<<<<<+>>>>>>]<<<<<<]<<[->+<]
     * move back
     <[<<]<<<
   ]>]<[
     * case abc
     * move to the left of 147
     * rotate ( horizontal )
     ---[+[+>>>>>>-<<<<<<]>>>>>>]>>>>
     >[->+<]<++[->>[->>+<<]>[-<<+>>]<<<[->>+<<]>>]>>[-<+>]
     * move back
     <[<<]<<<
   ]
   * read ahead the next char
   <,+>>
  ]
  <[-]
 <]
 * print and clear *
 ->>>>>+++[-
  [->>>>>>+<<<<<<]
  <+++[-
   >++++++[->++++++++<]>.[-]<<[->>+<<]
  >>]
  >[
   <++++++[-<++++++++>]
   <-.
  >]
  <[[-]>]
 >]
 +[-<+]
 ++++++++++.
,+]
