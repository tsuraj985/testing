global class AutoFillCountschedulable implements Schedulable{
    global void execute (SchedulableContext SC){
        AutoFillCountFromBatch countF = new AutoFillCountFromBatch();
        Database.executeBatch(countF);
    }
}