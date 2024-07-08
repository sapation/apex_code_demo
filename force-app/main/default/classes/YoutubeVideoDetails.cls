global class YoutubeVideoDetails {

    webservice static void details(String videoId, String recId) {
        String Api_key = Youtube_API_Setting__c.getInstance('Youtube API Key').Value__c;
        String Endpoint = Youtube_API_Setting__c.getInstance('Youtube Endpoint').Value__c;
        
        Endpoint = Endpoint.replace('{API_KEY}', Api_key);
        Endpoint = Endpoint.replace('{VIDEO_ID}', videoId);

        Http http = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();

        req.setEndpoint(Endpoint);
        req.setMethod('GET');
        res = http.send(req);
        System.debug(res);
        JsonParser json = (JsonParser)JSON.deserialize(res.getBody(), JsonParser.class);
        System.debug(json);

        Youtube_Video_Detail__c ytd = new Youtube_Video_Detail__c();
        ytd.Id = recId;
        ytd.Number_of_View_Counts__c = json.items[0].statistics.viewCount;
        ytd.Number_of_Comments__c = json.items[0].statistics.commentCount;
        ytd.Number_of_Likes__c = json.items[0].statistics.likeCount;
        ytd.Number_of_Dislikes__c = json.items[0].statistics.dislikeCount;

        update ytd;
    }

    public class JsonParser {
        public String kind;
        public String etag;
        public List<Items> items;
        public PageInfo pageInfo;
    }

    public class PageInfo {
		public Integer totalResults;
		public Integer resultsPerPage;
	}

	public class Items {
		public String kind;
		public String etag;
		public String id;
		public Statistics statistics;
	}

	public class Statistics {
		public String viewCount;
		public String likeCount;
		public String dislikeCount;
		public String favoriteCount;
		public String commentCount;
	}
}
//Calling the clas with demo parameters
// YoutubeVideoDetails.details('ICU2pFiTato', 'a00d2000002Cjcb');