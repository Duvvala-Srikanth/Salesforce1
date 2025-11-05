public class AccountController {
    @AuraEnabled(cacheable=true)
	public static Account getAccountbyId(String accountId){
    	return [Select id,Name,AnnualRevenue, Industry from Account where id=:accountId];
    }
}