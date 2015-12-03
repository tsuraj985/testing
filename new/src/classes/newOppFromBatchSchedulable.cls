global class newOppFromBatchSchedulable implements schedulable{
    global void execute(schedulableContext SC){
        newOppFromBatchClass n = new newOppFromBatchClass();
        Database.executeBatch(n);
    }
}