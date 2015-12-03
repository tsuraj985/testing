global class newOppFromBatchClass implements Database.Batchable<SObject> {
    global final string query = 'SELECT Id FROM Opportunity LIMIT 1';
    
    global Database.queryLocator start(Database.BatchableContext BC) {
        return Database.getqueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, list<Opportunity> OpportunityList){
        list <Opportunity> oppList = new List <Opportunity>();
        
        for (integer i=0;i<5;i++){
            Opportunity opp = new Opportunity();
            opp.Name = 'TestOpp' +i;
            opp.CloseDate = Date.Today() +5;
            opp.StageName = 'Prospecting';
            
        oppList.add(opp);
        }
        insert oppList;
    }
    global void finish(Database.BatchableContext BC) {
    }     
}