//  * Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
//  *
//  * WSO2 LLC. licenses this file to you under the Apache License,
//  * Version 2.0 (the "License"); you may not use this file except
//  * in compliance with the License.
//  * You may obtain a copy of the License at
//  *
//  *    http://www.apache.org/licenses/LICENSE-2.0
//  *
//  * Unless required by applicable law or agreed to in writing,
//  * software distributed under the License is distributed on an
//  * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  * KIND, either express or implied. See the License for the
//  * specific language governing permissions and limitations
//  * under the License.

import ballerina/test;

@test:Config {
    groups: ["utils_tests"]
}
isolated function testGetDeepObjectStyleRequest() {
    record {} anyRecord = {"key1": "value1", "key2": 2};
    string result = getDeepObjectStyleRequest("parent", anyRecord);
    test:assertEquals(result, "parent[key1]=value1&parent[key2]=2", msg = "Expected serialized deep object style request");
}

@test:Config {
    groups: ["utils_tests"]
}
isolated function testGetFormStyleRequest() {
    record {} anyRecord = {"key1": "value1", "key2": 2};
    string result = getFormStyleRequest("parent", anyRecord, true);
    test:assertEquals(result, "key1=value1&key2=2", msg = "Expected serialized form style request with explode");

    result = getFormStyleRequest("parent", anyRecord, false);
    test:assertEquals(result, "key1,value1,key2,2", msg = "Expected serialized form style request without explode");
}

@test:Config {
    groups: ["utils_tests"]
}
isolated function testGetSerializedArray() {
    anydata[] anyArray = ["value1", "value2"];
    string result = getSerializedArray("arrayName", anyArray, "form", true);
    test:assertEquals(result, "arrayName=value1&arrayName=value2", msg = "Expected serialized array with form style and explode");

    result = getSerializedArray("arrayName", anyArray, "form", false);
    test:assertEquals(result, "arrayName=value1&arrayName=value2", msg = "Expected serialized array with form style and no explode");

    result = getSerializedArray("arrayName", anyArray, "spaceDelimited", false);
    test:assertEquals(result, "arrayName=value1&arrayName=value2", msg = "Expected serialized array with space delimited style and no explode");

    result = getSerializedArray("arrayName", anyArray, "pipeDelimited", false);
    test:assertEquals(result, "arrayName=value1&arrayName=value2", msg = "Expected serialized array with pipe delimited style and no explode");

    result = getSerializedArray("arrayName", anyArray, "deepObject", true);
    test:assertEquals(result, "arrayName=value1&arrayName=value2", msg = "Expected serialized array with deep object style");
}

@test:Config {
    groups: ["utils_tests"]
}
isolated function testGetSerializedRecordArray() {
    record {}[] value = [{"key1": "value1"}, {"key2": "value2"}];
    string result = getSerializedRecordArray("parent", value, "form", true);
    test:assertEquals(result, "key1=value1,key2=value2", msg = "Expected serialized record array with form style and explode");

    result = getSerializedRecordArray("parent", value, "form", false);
    test:assertEquals(result, "parent=key1,value1,key2,value2", msg = "Expected serialized record array with form style and no explode");
}

@test:Config {
    groups: ["utils_tests"]
}
isolated function testGetEncodedUri() {
    string result = getEncodedUri("value with spaces");
    test:assertEquals(result, "value%20with%20spaces", msg = "Expected encoded URI");

    result = getEncodedUri("value/with/slash");
    test:assertEquals(result, "value%2Fwith%2Fslash", msg = "Expected encoded URI with slash");
}

@test:Config {
    groups: ["utils_tests"]
}
isolated function testGetPathForQueryParam() {
    map<anydata> queryParam = {"key1": "value1", "key2": "value2"};
    string|error result = getPathForQueryParam(queryParam);
    test:assertEquals(result, "?key1=value1&key2=value2", msg = "Expected query path with query parameters");
}

@test:Config {
    groups: ["utils_tests"]
}
isolated function testGetMapForHeaders() {
    // Test with SimpleBasicType array
    map<anydata> headerParam1 = {"header1": "value1", "header2": [1, 2]};
    map<string|string[]> result1 = getMapForHeaders(headerParam1);
    test:assertEquals(result1, {"header1": "value1", "header2": "[1,2]"}, msg = "Expected header map with SimpleBasicType array");

    // Test with string value
    map<anydata> headerParam2 = {"header1": "value1", "header2": "value2"};
    map<string|string[]> result2 = getMapForHeaders(headerParam2);
    test:assertEquals(result2, {"header1": "value1", "header2": "value2"}, msg = "Expected header map with string value");

    // Test with int value
    map<anydata> headerParam3 = {"header1": "value1", "header2": 123};
    map<string|string[]> result3 = getMapForHeaders(headerParam3);
    test:assertEquals(result3, {"header1": "value1", "header2": "123"}, msg = "Expected header map with int value");

    // Test with boolean value
    map<anydata> headerParam4 = {"header1": "value1", "header2": true};
    map<string|string[]> result4 = getMapForHeaders(headerParam4);
    test:assertEquals(result4, {"header1": "value1", "header2": "true"}, msg = "Expected header map with boolean value");

    // Test with float value
    map<anydata> headerParam5 = {"header1": "value1", "header2": 12.34};
    map<string|string[]> result5 = getMapForHeaders(headerParam5);
    test:assertEquals(result5, {"header1": "value1", "header2": "12.34"}, msg = "Expected header map with float value");
}
