public with sharing class callOutPractice {
    @future(callout=true)
    public static void callOutEx(){
    http ht=new http();
    httpRequest req=new httprequest();
    req.setEndpoint('https://jsonplaceholder.typicode.com/posts/1');
    req.setMethod('GET');
    HttpResponse resht =ht.send(req);
    System.debug(resht.getBody());
    }
}