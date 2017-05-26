trigger TrasactionLogTriggerHandler on Payment_Trasaction_log__c (after insert) {
     List<Messaging.SingleEmailMessage> totalEmail = new List<Messaging.SingleEmailMessage>();
    List<ID> accountIds = new List<ID>();    
    for(Payment_Trasaction_log__c trasactionLog: trigger.new){
        accountIds.add(trasactionLog.Account__c);
    }
    Map<Id,Account> accountMap = new Map<Id,Account>([Select id,Email__c from Account where Id In :accountIds]);
    for(Payment_Trasaction_log__c paymenttrasactionLog: trigger.new){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {accountMap.get(paymenttrasactionLog.Account__c).Email__c};
            mail.setToAddresses(toAddresses);
        mail.setSenderDisplayName('Transaction Failed');
        mail.setSubject('Donar Trasaction was failed in the moth of '+ datetime.now().format('MMMMM'));
        mail.setBccSender(false);
        mail.setUseSignature(false);
        mail.setPlainTextBody('this is notifiactio belongs tofailure of trasaction with response code'+paymenttrasactionLog.Gateway_Response_Code__c);
        totalEmail.add(mail);
    }
    
    
    Messaging.sendEmail( totalEmail );
}