public class OrgtoOrgNC {
    public static void createAccountInTargetOrg(){
        List<map<String,String>> accounts=new List<map<String,String>>();
        accounts.add(new map<String,String>{'Name'=>'SriIntegration1' ,'Phone'=>'6305818567'});
        accounts.add(new map<String,String>{'Name'=>'SriIntegration2' ,'Phone'=>'8340934764'});
        for (map<String,String>accmaps: accounts){
            String reqBody=JSON.serialize(accmaps);
            Httprequest req=new httprequest();
            req.setEndPoint('callout:toOtherOrg/services/data/v64.0/sobjects/Account/');
            req.setheader('Content-Type','application/Json');
            req.setMethod('POST');
            req.setBody(reqBody);
            httpresponse response=new http().send(req);
            if (response.getstatusCode()==201){
                System.debug('Post method Success');
                System.debug(response.getBody());
            }
            else{
                System.debug('Failed'+ response.getStatus());
                System.debug(response.getBody());
            }
        }
        
    }
}