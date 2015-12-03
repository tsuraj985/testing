trigger countNoOfProductsSold on Opportunity(after update) {  
    Set<Id> OpportunityIdSet= new Set<Id>();
    Map <Id,Product2> productsToBeUpdated = new Map <Id,Product2>();
    for(Opportunity tempOpp : trigger.new) {
        if(Trigger.oldMap.get(tempOpp.Id ).StageName!='Closed Won' &&  tempOpp.StageName=='Closed Won'){
        OpportunityIdSet.add(tempOpp.Id);
        }
    }
    list<OpportunityLineItem> oli=[
                    SELECT Name,Product2Id,Quantity , Product2.Number_of_Products_Sold__c
                    FROM OpportunityLineItem 
                    WHERE OpportunityId =:OpportunityIdSet];
    for(OpportunityLineItem OpLiIt : oli){
        System.debug('>>>>>'+OpLiIt);
        Product2 productFromMap = productsToBeUpdated.get(OpLiIt.Product2Id);
        
        if (productFromMap ==NULL) {
            if(OpLiIt.Product2.Number_of_Products_Sold__c == NULL) {
                OpLiIt.Product2.Number_of_Products_Sold__c = 0;
            }
            productsToBeUpdated.put(
            OpLiIt.Product2Id, // KEY is Product ID
            new Product2(      // VALUE is the Product itself
                    ID=OpLiIt.Product2Id, 
                    Number_of_Products_Sold__c = OpLiIt.Product2.Number_of_Products_Sold__c+OpLiIt.Quantity));
        } else {
            Product2 temP = productsToBeUpdated.get(OpLiIt.Product2Id);
            temP.Number_of_Products_Sold__c += OpLiIt.Quantity;
            productsToBeUpdated.remove(OpLiIt.Product2Id);
            productsToBeUpdated.put(temP.Id,temP);
        }
    }
    if (productsToBeUpdated.values() != NULL) {
        Update  productsToBeUpdated.values();
    }
}