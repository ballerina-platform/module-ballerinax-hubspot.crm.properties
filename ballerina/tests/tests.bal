
import ballerina/oauth2;
import ballerina/test;


// import ballerina/time;




configurable string serviceUrl = "https://api.hubapi.com";
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;

OAuth2RefreshTokenGrantConfig auth = {
       clientId: clientId,
       clientSecret: clientSecret,
       refreshToken: refreshToken,
       credentialBearer: oauth2:POST_BODY_BEARER // this line should be added in to when you are going to create auth object.
   };

final string testObjectType = "contacts";
final string testPropertyName = "city";
// final string testGroupName = "test_group";

ConnectionConfig config = {auth: auth};

final Client hubspot = check new Client(config, serviceUrl);

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetAllProperty() returns error? {

    CollectionResponsePropertyNoPaging response = check hubspot->/crm/v3/properties/[testObjectType].get();
    test:assertTrue(response?.results.length() > 0, msg = "Expected non-empty results for successful property group deletion");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testPostProperty() returns error? {

    Property response = check hubspot->/crm/v3/properties/[testObjectType].post(payload = {
  "hidden": false,
  "displayOrder": 2,
  "description": "string",
  "label": "My Contact Property",
  "type": "bool",
  "formField": true,
  "groupName": "contactinformation",
  "referencedObjectType": "string",
  "name": "string",
  "options": [
    {
      "label": "Option A",
      "value": "A",
      "hidden": false,
      "description": "Choice number one",
      "displayOrder": 1
    },
    {
      "label": "Option B",
      "value": "B",
      "hidden": false,
      "description": "Choice number two",
      "displayOrder": 2
    }
  ],
  "calculationFormula": "string",
  "hasUniqueValue": false,
  "fieldType": "select",
  "externalOptions": true
});
    test:assertTrue(response.length()>0, msg = "Expected response came"  );


}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testgetAProperty() returns error?{
  Property response = check hubspot->/crm/v3/properties/[testObjectType]/[testPropertyName].get();
  test:assertTrue(response.length()>0);
}