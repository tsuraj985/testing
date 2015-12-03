global class deleteAccount10DaysBefore implements Database.Batchable<SObject>{
    global Database.queryLocator start(Database.BatchableContext BC){
        string query = 'SELECT CreatedDate FROM Account WHERE CreatedDate <= Date.Today()-10';
        return Database.getqueryLocator(query);
    }
    global void execute (Database.BatchableContext BC, List<Account> AccountList){
        delete AccountList;
    }
    global void finish (Database.BatchableContext BC){
    }
}