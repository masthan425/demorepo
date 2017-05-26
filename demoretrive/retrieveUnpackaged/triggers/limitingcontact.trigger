trigger limitingcontact on Contact (before insert) {
	List<ID> ids=new List<ID>();
    for(contact a:trigger.new){
        ids.add(a.accountId);
    }
    List<Account> acc=[select id,(select id from contacts) from account];
    for(Account b:acc){
        for(contact c:trigger.new){
            if(c.accountId==b.id){
        		if(b.contacts.size()>=1){
            	c.adderror('already a contact has been assigned to this account');
            
        		}
            }
        }
    }
}