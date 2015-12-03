public with sharing class deleteCronJobs{
    public deleteCronJobs(){    
    }
    List<CronTrigger> crons;
    
    public List<CronTrigger> getAllJobs() {
        crons = [SELECT CronJobDetail.Name,OwnerId,StartTime,EndTime FROM CronTrigger];
        return crons;
    }
    
    
    public String asgn{get; set;}
    
    CronTrigger cron = new CronTrigger();
    
    public void deleteJob() {
        Id cronId = apexpages.currentpage().getParameters().get('Id');
        cron = [SELECT CronJobDetail.Id, OwnerId FROM CronTrigger WHERE CronJobDetail.Id =: cronId];
        System.debug('>>>>>>>>>>>>>>>>>>>' + cron);
        System.abortJob(cron.Id);
        
    }
}