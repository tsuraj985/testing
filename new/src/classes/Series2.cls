public class Series2
{
    public void SeriesShow(integer n)
    {
        double a = 1.0;
        for(integer i =1;i<=n;i++)
        {
            if(math.mod(i,2)==0)
            {
                a=a+(math.pow(10,-i));
            }
        else
            {
                a=a+(3*math.pow(10,-i));
            }
            system.debug(a);
        }
    }
}