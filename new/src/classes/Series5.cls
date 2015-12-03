public with sharing class Series5

{

public integer display(integer userinput)

{

integer i = 522;

system.debug(i);

for(integer a=1 ; a<=userInput ; a++)

{

if(math.mod(a,2)==0)

{

i=i-10;

}

else

{

i=i-20;

}

system.debug(i);

}

return i;

}
}