trigger updateOpportunityStage on Campaign (after update) {
    set<Id> listIds = new set<Id>();
    set<id> ownerIdSet = new set<Id>();   
    for(Campaign camp : trigger.new){
        if(trigger.oldMap.get(camp.Id).Status!='Completed' && camp.Status == 'Completed'){
            listIds.add(camp.Id);
            ownerIdSet.add(camp.OwnerId);
        }
    }
    list<Opportunity> oppList = [
    SELECT Name,CampaignId, StageName,Campaign.Status,HasOpportunityLineItem,Amount 
    FROM Opportunity 
    WHERE CampaignId=:listIds];
    Integer OppClosedWon = 0;
    Integer OppClosedLost = 0;
    Double TotalAmountWon = 0;
    
    for(Opportunity opp : oppList){
        if(opp.Campaign.Status=='Completed' && opp.HasOpportunityLineItem==true){
            opp.StageName = 'Closed Won';
            OppClosedWon++;
            TotalAmountWon += opp.Amount;
        } 
    else{
            opp.StageName = 'Closed Lost';
            OppClosedlost++;
    }
    }
    system.debug('details' +oppList);
    update oppList;
    
      
    List<User> u = [
       SELECT Email,FirstName,LastName 
       FROM User
       WHERE Id IN:ownerIdSet];
            
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            List<String> toAddresses = new List<String>();
            String userEmail;
            String FName;
            String LName;
            for (User mails : u){
                userEmail = mails.Email;
                FName = mails.FirstName;
                LName = mails.LastName;
                toAddresses.add(userEmail);
            }
    email.setToAddresses(toAddresses);
    email.setSenderDisplayName('Trigger Testing Email');
    email.setSubject('Campaign Details');
    Integer TotalNumberOfOpportunitiesInCampaign = OppClosedWon + OppClosedlost;
    email.setHtmlBody('<style>th, td</style>'
            + 'Dear '+FName +' '+Lname+',<br/><br/>'
            + 'Changes made in Campaign SObject due to completion:<br/>'
            +'<table>'
            +'<tr>'
            +'<th>Number of Opportunities won</th>'
            +'<td>'+ OppClosedWon + '</td>'
            +'</tr>'
            +'<tr>'
            +'<th>Number of Opportunities Lost</th>'
            +'<td>'+ OppClosedlost +'</td>'
            +'</tr>'
            +'<tr>'
            +'<th>Total Number of Opportunities</th>'
            +'<td>'+TotalNumberOfOpportunitiesInCampaign+'</td>'
            +'</tr>'
            +'<th>Amount Won</th>'
            +'<td>$'+ TotalAmountWon +'</td>'
            +'</tr>'
            +'</table><br/><br/>'
            +'<hr />'
            +'Regards<br/>Analog Force<br/>');
     list<Messaging.SendEmailResult> results = Messaging.sendEmail (new Messaging.Email[] {email});
     if(!results.get(0).isSuccess()) {
                System.debug('Failed mail ' + results.get(0).getErrors()[0].getMessage());
            } else {
                System.debug('Email Sent!');
            }
}