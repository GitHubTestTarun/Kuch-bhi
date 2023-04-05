public class AccountQueable implements Queueable{
	
    private List<Account> accountsList;
    private Id ParentAccountId;
    
    public AccountQueable(List<Account> accounts, Id ids) {
        
        	this.accountsList = accounts;
        	this.ParentAccountId = ids;
    }
    
    public void execute(QueueableContext Qcontext) {
        	
        for(Account account : accountsList) {
            account.ParentId = ParentAccountId;
        }
        update accountsList;
    }
    public static List<Account> valueofi() {
        List<Account> accounts = new List<Account>();
        for(integer i=1; i<=20; i++) {
            accounts.add(new Account(Name = 'DON001'));
        }
        return accounts;
    }
}