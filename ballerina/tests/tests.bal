// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/oauth2;
import ballerina/test;

boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
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
final Client hubSpotProperties = check new ({auth}, serviceUrl);

// Core

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetAllProperty() returns error? {

    CollectionResponsePropertyNoPaging response = check hubSpotProperties->/[testObjectType].get();
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
    Property response = check hubSpotProperties->/[testObjectType].post(payload = propertyCreateInput);
    test:assertTrue(response.length() > 0, msg = "Expected response came");

}

@test:Config {
    dependsOn: [testPostProperty],
    groups: ["live_tests", "mock_tests"]
}
isolated function testgetAProperty() returns error? {
    Property response = check hubSpotProperties->/[testObjectType]/[testPropertyName].get();
    test:assertTrue(response.length() > 0);
}

@test:Config {
    dependsOn: [testgetAProperty],
    groups: ["live_tests", "mock_tests"]
}
isolated function testupdateAProperty() returns error? {
    Property response = check hubSpotProperties->/[testObjectType]/[testPropertyName].patch(payload = {
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
    http:Response response = check hubSpotProperties->/[testObjectType]/[testPropertyName].delete();
    test:assertTrue(response.statusCode == 204);
}

// Group

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetGroupProperty() returns error? {
    PropertyGroup response = check hubSpotProperties->/[testObjectType]/groups/[testGroupName]();
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
    PropertyGroup response = check hubSpotProperties->/[testObjectType]/groups.post(payload = propertyGroupInput);
    test:assertTrue(response.length() > 0 && response.name == testPropertyGroupName);
}

@test:Config {
    dependsOn: [testCreatePropertyGroup],
    groups: ["live_tests", "mock_tests"]
}
isolated function testUpdatePropertyGroup() returns error? {
    PropertyGroupUpdate propertyGroupUpdateInput = {"displayOrder": -1, "label": "updated property group yo"};
    PropertyGroup response = check hubSpotProperties->/[testObjectType]/groups/[testPropertyGroupName].patch(
        payload = propertyGroupUpdateInput
    );
    test:assertTrue(response.length() > 0);
}

@test:Config {
    dependsOn: [testUpdatePropertyGroup],
    groups: ["live_tests", "mock_tests"]
}
isolated function testDeletePropertyGroup() returns error? {
    http:Response response = check hubSpotProperties->/[testObjectType]/groups/[testPropertyGroupName].delete();
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
    BatchResponseProperty response = check hubSpotProperties->/[testObjectType]/batch/create.post(payload = batchInputPropertyCreate);
    test:assertTrue(response.results.length() > 0);
}

@test:Config {
    dependsOn: [testCreateBatchProperty],
    groups: ["live_tests", "mock_tests"]
}
isolated function testgetPropertyBatch() returns error? {
    BatchReadInputPropertyName batchReadInputPropertyName = {archived: false, inputs: [{"name": testBatchPropertyName1}, {"name": testBatchPropertyName2}]};
    BatchResponseProperty response = check hubSpotProperties->/[testObjectType]/batch/read.post(payload = batchReadInputPropertyName);
    test:assertTrue(response.results.length() > 0);
}

@test:Config {
    dependsOn: [testgetPropertyBatch],
    groups: ["live_tests", "mock_tests"]
}
isolated function testArchivePropertyBatch() returns error? {
    BatchInputPropertyName batchInputPropertyName = {inputs: [{"name": testBatchPropertyName1}, {"name": testBatchPropertyName2}]};
    http:Response response = check hubSpotProperties->/[testObjectType]/batch/archive.post(payload = batchInputPropertyName);
    test:assertTrue(response.statusCode == 204);
}
