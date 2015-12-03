public with sharing class UnitPlacesOfDecimalNumber {
    public void showNumbers(Decimal originalNumber) {
        Decimal num = originalNumber;
        
        //To Seperate Integer Part and Decimal Part of the number.(Like 293.065 -> 293 and .065)
        Integer intPartOfNumber = (Integer) num;
        Decimal decPartOfNumber = num - intPartOfNumber;
        
        List<Integer> intNumbersList = new List<Integer>();
        
        //To get List of Integer Part.(Like 293 -> 3, 9, 2)
        Integer n = 1;
        while(intPartOfNumber > 0) {
            n = math.mod(intPartOfNumber, 10);
            intPartOfNumber = intPartOfNumber/10;
            intNumbersList.add(n);
        }
        
        //To get List of Decimal Parts.(Like .065 -> 0, 6, 5)
        List<Integer> decimalNumberList = new List<Integer>();
        Decimal decPart = 1;
        while(decPartOfNumber > 0) {
            decPart = decPartOfNumber * 10;
            intPartOfNumber = (Integer) decPart;
            decPartOfNumber = decPart - intPartOfNumber;
            decimalNumberList.add(intPartOfNumber);
        }
        
        
        //To Print Int Part of the number with unit places.(Like 293 -> 200, 90, 3)
        for(Integer i = intNumbersList.size(); i >= 1; i--) {
            System.debug((Integer) intNumbersList.get(i-1) * math.pow(10, i-1));
        }

        
        //To Print Decimal Part of the number with unit places.(Like .065 -> .000, .060, .005)
        for(Integer i = 0; i < decimalNumberList.size(); i++) {
            System.debug(decimalNumberList.get(i) * math.pow(10, -(i+1)));
        }
    }   
}