global class SendEmailSchedulable implements schedulable{
    global void execute(schedulableContext SC){
        SendEmail SE = new SendEmail();
        Database.executeBatch(SE);
    }
}