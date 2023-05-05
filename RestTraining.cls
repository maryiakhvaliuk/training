@RestResource(urlMapping='/checkFile/*')
global class CheckFileService {

    @HttpGet
    global static String doGet() {
        return 'Use POST method to check for file existence';
    }
    @HttpPost
    global static Boolean doPost() {
        // Get the request body as a JSON string
        RestRequest req = RestContext.request;
        String requestBody = req.requestBody.toString();

        // Deserialize the JSON into an Apex object
        CheckFileRequest checkFileRequest = (CheckFileRequest)JSON.deserialize(requestBody, CheckFileRequest.class);

        // Get the access token from the request
        String accessToken = checkFileRequest.accessToken;

        // Get the file ID and folder ID from the request
        String fileId = checkFileRequest.fileId;
        String folderId = checkFileRequest.folderId;

        // Construct the Google Drive API endpoint URL
        String apiUrl = 'https://www.googleapis.com/drive/v3/files?q=' + 'trashed = false and "' + folderId + '" in parents and name = "' + fileId + '"';

        // Create a new HTTP request to the Google Drive API endpoint
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(apiUrl);
        request.setHeader('Authorization', 'Bearer ' + accessToken);
        request.setMethod('GET');

        // Send the HTTP request and get the response
        HttpResponse response = http.send(request);

        // Parse the response JSON to check if the file exists
        CheckFileResponse checkFileResponse = (CheckFileResponse)JSON.deserialize(response.getBody(), CheckFileResponse.class);

        return (checkFileResponse.files.size() > 0);
    }

    // Inner class to represent the request body JSON
    global class CheckFileRequest {
        public String accessToken;
        public String fileId;
        public String folderId;
    }

    // Inner class to represent the Google Drive API response JSON
    global class CheckFileResponse {
        public List<GoogleDriveFile> files;
    }

    // Inner class to represent a Google Drive file
    global class GoogleDriveFile {
        public String id;
        public String name;
    }
}
