10 evensum = 0
20 oddsum = 0
30 result = 0
40 open "00-input.txt" for reading as #1
50 while not eof(#1)
60 line input #1 a$
70 a=val(a$)
80 if (mod(a,2)=0) then
90 evensum = evensum + a
100 else
110 oddsum = oddsum + a
120 fi
130 wend
140 close #1
150 result = oddsum - evensum
160 print "Your result is ",str$(result)
170 open "00-solution.txt" for reading as #2
180 input #2 b$
190 print "The correct answer is ",b$
200 close #2
210 b=val(b$)
220 if (result = b) then
230 print "Your code is an example of excellence!"
240 else
250 print "You are a noob!"
260 fi