public with sharing class Series

{

public integer display(integer userInput)

{

integer i = 1;

system.debug(i);

for(integer a=1 ; a<=userInput ; a++)

{

if(math.mod(a,2)==0)

{

i=i*2;

}

else

{

i=i*4;

}

system.debug(i);

}

return i;

}

}