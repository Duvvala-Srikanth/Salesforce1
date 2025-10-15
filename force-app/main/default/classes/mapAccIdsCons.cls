// using map print all the related contacts to the account
public class mapAccIdsCons {
    public static void accRelatedCons(){
        list<Account> acclist=[select id from Account];
        list<Contact> conList =[select id, AccountId from Contact where AccountId In:accList];
        Map<Id,list<Contact>> accConMap=new Map<Id,List<Contact>>();
        for (contact con:conList){
            if(accConMap.ContainsKey(con.AccountId)){
                accConMap.get(Con.AccountId).add(con);
            }
            else{
                accConMap.put(Con.AccountId,new list<Contact>{con});
            }
        }
        System.debug(accConMap);
       /* for(ID accId: accConMap.keyset()){
            System.debug('Account Id :'+ accId +'=> Contact IDs :'+ accConMap.get(accId));
        }*/
    }
    
    
    
    
    
    public static void simpleAccCons(){
        list<Account> accList=[select id,Name, (select id,Name from Contacts) from Account];
        Map<Id,list<Contact>> accConMap=new Map<Id,list<Contact>>();
        for (Account acc:accList){
            if (acc.Contacts!=Null && !acc.contacts.isEmpty()){
                accConMap.put(acc.Id, acc.Contacts);
            }
        }
        system.debug(accConMap);
        for(ID accId: accConMap.keyset()){
            System.debug('Account Id :'+ accId +'= Contact IDs :'+ accConMap.get(accId));
        }
    }
    
    
    
    
    public static void simpleAccOpps(){
        list<Account> accList=[select id,Name, (select id,Name from Opportunities) from Account];
        Map<Id,list<Opportunity>> accOppMap=new Map<Id,list<Opportunity>>();
        for (Account acc:accList){
            if (acc.Opportunities!=Null && !acc.Opportunities.isEmpty()){
                accOppMap.put(acc.Id, acc.Opportunities);
                }
            }
        for(ID accId: accOppMap.keyset()){
            System.debug('Account Id :'+ accId +'=> Opportunity IDs :'+ accOppMap.get(accId));
        }
    }
}