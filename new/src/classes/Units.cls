public with sharing class Units

{

public void show(integer n)

{

integer val=1;

while(n>0){

integer temp=math.mod(n,10);

n=n/10;

temp=temp*val;

system.debug('temp is'+temp);

val=val*10;

}

}

}