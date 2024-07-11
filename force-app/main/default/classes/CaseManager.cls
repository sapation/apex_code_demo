// Declaring a REST Service using annotations
//and exposing all the endpoint for consumption

@RestResource(urlMapping='/Cases/*')
global with sharing class CaseManager {

    @HttpGet
    global static Case getCaseById() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);

        Case result = [SELECT CaseNumber,Subject,Status,Origin,Priority
                        FROM Case
                        WHERE Id = :caseId];
        return result;
    }

    @HttpPost
    global static Id createCase(String subject, String status,
        String origin, String priority) {
        Case thisCase = new Case(
            Subject=subject,
            Status=status,
            Origin=origin,
            Priority=priority);
        insert thisCase;
        return thisCase.id;
     }

    @HttpPut
    global static Id upsertCase(String subject, String status,
        String origin, String priority, String id) {
        Case thisCase = new Case(
                Id=id,
                Subject=subject,
                Status=status,
                Origin=origin,
                Priority=priority);
        upsert thisCase;
        return thisCase.id;
    }

    @HttpPatch
    global static Id updateCase() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Case thisCase = [SELECT Id FROM Case WHERE Id = :caseId];
        Map<String,Object> params = (Map<String,Object>)JSON.deserializeUntyped(request.requestBody.toString());
        for (String fieldName : params.keySet()) {
            thisCase.put(fieldName, params.get(fieldName));
        }
        update thisCase;
        return thisCase.id;
    }

    @HttpDelete
    global static void deleteCase() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Case thisCase = [SELECT Id FROM Case WHERE Id = :caseId];
        delete thisCase;
    }

}

//Invoking the get endpoint
///services/apexrest/Cases/500d200000288lz