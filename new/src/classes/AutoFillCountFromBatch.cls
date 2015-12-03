global class AutoFillCountFromBatch implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext BC){
        string query = 'SELECT Id,Name,(SELECT Id FROM Contacts) FROM Account';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List <Account> AccountList){
        List<Account> accList = new List<Account>();
        for (Account acc : AccountList){
            acc.Count__c = acc.Contacts.Size();
            accList.add(acc);
        }
        system.debug('****accList >>>>> ' + accList);
        update accList;
    }
    global void finish(Database.BatchableContext BC){
        system.debug('>>>>>>>>>>finish' + BC);
    }
}