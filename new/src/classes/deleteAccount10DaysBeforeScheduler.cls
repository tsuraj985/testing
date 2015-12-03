global class deleteAccount10DaysBeforeScheduler implements Schedulable {
    global void execute(SchedulableContext SC){
        deleteAccount10DaysBefore del = new deleteAccount10DaysBefore();
        Database.executeBatch(del);
    }
}