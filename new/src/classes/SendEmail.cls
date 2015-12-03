global class SendEmail implements Database.Batchable<sObject>{
    global User sysADM = [SELECT Email, Profile.Name FROM User WHERE Profile.Name =:'System Administrator']; 
    global Database.queryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([SELECT LastName, Status, Phone,Company, CreatedDate FROM Lead WHERE Phone =: '' AND CreatedDate >=: system.Today()-1]);
    }
    global void execute(Database.BatchableContext BC, List<Lead> LeadList){
         messaging.singleEmailMessage mail = new messaging.singleEmailMessage();
        list<string> stList = new list <string>();
        stList.add(sysADM.Email);
        mail.setToAddresses(stList);
        mail.setSubject('List of leads from yesterday where phone number is not there.');
        string htmBody = '<div style="border:2px border-radius:15px;">Dear Admin,<br/>'
        +'These are the <strong>Leads</strong>not having <border>Phone Numbers</border> in them and are created yesterday.<br/><br/>'
        +'<table border=1><tr><th>Last Name</th><th>Company</th></tr>';
        
        for (Lead L : LeadList){
            htmBody = htmBody +'<tr><td>' + L.LastName + '</td>'
            +'<td> ' + L.Company +' </td>'
            +'<td> ' + L.Status +' </td></tr>';
        }
        
        htmBody = htmBody +'</table>';
        mail.setHtmlBody(htmBody);
        List<Messaging.SendEmailResult> results = Messaging.sendEmail(new Messaging.Email[] {mail});
        
        System.debug('List>>>>>' +LeadList);
    }
    global void finish(Database.BatchableContext BC){
        system.debug('List>>>>' +Bc);
    
       
       

    }
}