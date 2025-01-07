import ballerina/http;
import ballerina/oauth2;
import ballerina/test;

configurable boolean isLive = true;
configurable string serviceUrl = isLive ? "https://api.hubapi.com/crm/v3/properties" : "http://localhost:9090";
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
final string testPropertyName = "test_property111";
final string testPropertyGroupName = "test_propertygroup001";
final string testGroupName = "contactinformation";
final string testBatchPropertyName1 = "test_bproperty001";
final string testBatchPropertyName2 = "test_bproperty002";

ConnectionConfig config = {auth: auth};

final Client hubspot = check new Client(config, serviceUrl);

// Core

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetAllProperty() returns error? {

    CollectionResponsePropertyNoPaging response = check hubspot->/[testObjectType].get();
    test:assertTrue(response?.results.length() > 0, msg = "Expected non-empty results for successful property group deletion");
}

@test:Config {

    groups: ["live_tests", "mock_tests"]
}
isolated function testPostProperty() returns error? {
    PropertyCreate propertyCreateInput = {
        "name": testPropertyName,
        "label": testPropertyName,
        "groupName": "contactinformation",
        "type": "string",
        "fieldType": "text",
        "description": "A simple test property for contacts",
        "hidden": false,
        "formField": true,
        "displayOrder": 1
    };
    Property response = check hubspot->/[testObjectType].post(payload = propertyCreateInput);
    test:assertTrue(response.length() > 0, msg = "Expected response came");

}

@test:Config {
    dependsOn: [testPostProperty],
    groups: ["live_tests", "mock_tests"]
}
isolated function testgetAProperty() returns error? {
    Property response = check hubspot->/[testObjectType]/[testPropertyName].get();
    test:assertTrue(response.length() > 0);
}

@test:Config {
    dependsOn: [testgetAProperty],
    groups: ["live_tests", "mock_tests"]
}
isolated function testupdateAProperty() returns error? {
    Property response = check hubspot->/[testObjectType]/[testPropertyName].patch(payload = {
        "hidden": false,
        "displayOrder": 2,
        "description": "Updated Description",
        "label": "My Contact Property",
        "type": "string",
        "formField": true,
        "groupName": "contactinformation",
        "name": testPropertyName
    });
    test:assertTrue(response.length() > 0);
}

@test:Config {
    dependsOn: [testupdateAProperty],
    groups: ["live_tests", "mock_tests"]
}
isolated function testArchiveProperty() returns error? {
    http:Response response = check hubspot->/[testObjectType]/[testPropertyName].delete();
    test:assertTrue(response.statusCode == 204);
}

// Group

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetGroupProperty() returns error? {
    PropertyGroup response = check hubspot->/[testObjectType]/groups/[testGroupName]();
    test:assertTrue(response.length() > 0);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testCreatePropertyGroup() returns error? {
    PropertyGroupCreate propertyGroupInput = {
        "name": testPropertyGroupName,
        "displayOrder": -1,
        "label": "My Property Group testyo"
    };
    PropertyGroup response = check hubspot->/[testObjectType]/groups.post(payload = propertyGroupInput);
    test:assertTrue(response.length() > 0 && response.name == testPropertyGroupName);
}

@test:Config {
    dependsOn: [testCreatePropertyGroup],
    groups: ["live_tests", "mock_tests"]
}
isolated function testUpdatePropertyGroup() returns error? {
    PropertyGroupUpdate propertyGroupUpdateInput = {"displayOrder": -1, "label": "updated property group yo"};
    PropertyGroup response = check hubspot->/[testObjectType]/groups/[testPropertyGroupName].patch(
        payload = propertyGroupUpdateInput
    );
    test:assertTrue(response.length() > 0);
}

@test:Config {
    dependsOn: [testUpdatePropertyGroup],
    groups: ["live_tests", "mock_tests"]
}
isolated function testDeletePropertyGroup() returns error? {
    http:Response response = check hubspot->/[testObjectType]/groups/[testPropertyGroupName].delete();
    test:assertTrue(response.statusCode == 204);
}

// batch

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testCreateBatchProperty() returns error? {
    BatchInputPropertyCreate batchInputPropertyCreate = {
        inputs: [
            {
                "name": testBatchPropertyName1,
                "label": testBatchPropertyName1,
                "groupName": "contactinformation",
                "type": "string",
                "fieldType": "text",
                "description": "A simple test property for contacts",
                "hidden": false,
                "formField": true,
                "displayOrder": 1
            },
            {
                "name": testBatchPropertyName2,
                "label": testBatchPropertyName2,
                "groupName": "contactinformation",
                "type": "string",
                "fieldType": "text",
                "description": "A simple test property for contacts",
                "hidden": false,
                "formField": true,
                "displayOrder": 1
            }
        ]
    };
    BatchResponseProperty response = check hubspot->/[testObjectType]/batch/create.post(payload = batchInputPropertyCreate);
    test:assertTrue(response.results.length() > 0);
}

@test:Config {
    dependsOn: [testCreateBatchProperty],
    groups: ["live_tests", "mock_tests"]
}
isolated function testgetPropertyBatch() returns error? {
    BatchReadInputPropertyName batchReadInputPropertyName = {archived: false, inputs: [{"name": testBatchPropertyName1}, {"name": testBatchPropertyName2}]};
    BatchResponseProperty response = check hubspot->/[testObjectType]/batch/read.post(payload = batchReadInputPropertyName);
    test:assertTrue(response.results.length() > 0);
}

@test:Config {
    dependsOn: [testgetPropertyBatch],
    groups: ["live_tests", "mock_tests"]
}
isolated function testArchivePropertyBatch() returns error? {
    BatchInputPropertyName batchInputPropertyName = {inputs: [{"name": testBatchPropertyName1}, {"name": testBatchPropertyName2}]};
    http:Response response = check hubspot->/[testObjectType]/batch/archive.post(payload = batchInputPropertyName);
    test:assertTrue(response.statusCode == 204);
}
