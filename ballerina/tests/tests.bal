
import ballerina/oauth2;
import ballerina/test;
import ballerina/io;
import ballerina/http;

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

final string testObjectType = "Contact";
final string testPropertyName = "city";
final string testGroupName = "contactinformation";

ConnectionConfig config = {auth: auth};

final Client hubspot = check new Client(config, serviceUrl);


// Core

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetAllProperty() returns error? {

    CollectionResponsePropertyNoPaging response = check hubspot->/crm/v3/properties/[testObjectType].get();
    test:assertTrue(response?.results.length() > 0, msg = "Expected non-empty results for successful property group deletion");
}

@test:Config {
    groups: ["mock_tests"]
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
        "hasUniqueValue": false,
        "fieldType": "select",
        "externalOptions": true
      });
  io:println(response);
  test:assertTrue(response.length()>0, msg = "Expected response came"  );
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testgetAProperty() returns error?{ 
  Property response = check hubspot->/crm/v3/properties/[testObjectType]/[testPropertyName].get();
  test:assertTrue(response.length()>0);
}

@test:Config {
  groups: ["mock_tests"]
}
isolated function testupdateAProperty() returns error?{ 
  Property response = check hubspot->/crm/v3/properties/[testObjectType]/[testPropertyName].patch(payload = {
    "hidden": false,
    "displayOrder": 2,
    "description": "string",
    "label": "My Contact Property",
    "type": "enumeration",
    "formField": true,
    "groupName": "contactinformation",
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
    "hasUniqueValue": false,
    "fieldType": "select",
    "externalOptions": true
});
  test:assertTrue(response.length()>0);
}


@test:Config {
    groups: ["mock_tests"]
}
isolated function testArchiveProperty() returns error?{ 
  http:Response response = check hubspot->/crm/v3/properties/[testObjectType]/[testPropertyName].delete();
  test:assertTrue(response.statusCode == 204);
}



// Group

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetGroupProperty() returns error?{ 
  PropertyGroup response = check hubspot->/crm/v3/properties/[testObjectType]/groups/[testGroupName]();
  test:assertTrue(response.length()>0);
}

// @test:Config {
//     groups: ["live_tests", "mock_tests"]
// }
// isolated function testGetAllGroupProperty() returns error?{ 
//   CollectionResponsePropertyGroupNoPaging response = check hubspot->/crm/v3/properties/[testObjectType]/groups;
//   io:println(response);
//   test:assertTrue(response.length()>0);
// }

@test:Config {
    before: testDeletePropertyGroup,
    groups: ["live_tests", "mock_tests"]
}
isolated function testCreatePropertyGroup() returns error?{ 
  PropertyGroup response = check hubspot->/crm/v3/properties/[testObjectType]/groups.post(
    payload = { "name": "propertygrouptest1",
                "displayOrder": -1,
                "label": "My Property Group testyo"});
  test:assertTrue(response.length()>0);
}

@test:Config {
    before: testCreatePropertyGroup,
    groups: ["live_tests", "mock_tests"]
}
isolated function testUpdatePropertyGroup() returns error?{ 
  PropertyGroup response = check hubspot->/crm/v3/properties/[testObjectType]/groups/["propertygrouptest1"].patch(
    payload = { "displayOrder": -1,
                "label": "updated property group yo"}
  );
  io:println(response);
  test:assertTrue(response.length()>0);
}

@test:Config {
    before: testUpdatePropertyGroup,
    groups: ["live_tests", "mock_tests"]
}
isolated function testDeletePropertyGroup() returns error?{ 
  http:Response response = check hubspot->/crm/v3/properties/[testObjectType]/groups/["propertygrouptest1"].delete();
  test:assertTrue(response.statusCode==204);
}






// batch


@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testgetPropertyBatch() returns error?{ 
  BatchResponseProperty response = check hubspot->/crm/v3/properties/[testObjectType]/batch/read.post(
    payload = {archived: false, inputs: [{"name":testPropertyName}]});
  test:assertTrue(response.results.length()>0);
}


@test:Config {
    groups: ["mock_tests"]
}
isolated function testCreateBatchProperty() returns error?{ 
  BatchResponseProperty response = check hubspot->/crm/v3/properties/[testObjectType]/batch/create.post(
    payload = {inputs: [{
      "hidden": false,
      "displayOrder": 2,
      "description": "string",
      "label": "My Contact Property",
      "type": "enumeration",
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
    }]}
  );
  test:assertTrue(response.results.length()>0);
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testArchivePropertyBatch() returns error?{ 
  http:Response response = check hubspot->/crm/v3/properties/[testObjectType]/batch/archive.post(
    payload = {inputs: [{
      "name": testPropertyName
    }]}
  );
  io:println(response.statusCode);
  test:assertTrue(response.statusCode==204);
}
