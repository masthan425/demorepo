trigger SubscriptionTriggerHandler on Subscription__c (after insert) {
    if(trigger.isAfter){
         Integer totalAmount = BigDealAlertInSubscription.totalSubscriptionAmount();
    //validating the total amount is divisable by 15
   // if((math.Mod(totalAmount,500) == 0 && (math.log10(totalAmount/500)).longValue() == (math.log10(totalAmount)))){
   if((math.log10(totalAmount/50)).longValue() == (math.log10(totalAmount/50))){
        BigDealAlertInSubscription.BigAlertEmail(totalAmount);
    } 
    }
// BigDealAlertInSubscription.tokenInsert(trigger.new[0].Id);
}