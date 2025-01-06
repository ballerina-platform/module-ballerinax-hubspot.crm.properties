import ballerina/io;
import ballerina/oauth2;
import ballerina/http;
import ballerinax/hubspot.crm.properties as hsproperties;

configurable string serviceUrl = "https://api.hubapi.com/crm/v3/properties";
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;


hsproperties:OAuth2RefreshTokenGrantConfig auth = {
    clientId: clientId,
    clientSecret: clientSecret,
    refreshToken: refreshToken,
    credentialBearer: oauth2:POST_BODY_BEARER
};
 

final string testObjectType = "Contact";
final string testPropertyName = "city";

hsproperties:ConnectionConfig config = {auth: auth};

final hsproperties:Client hubspot = check new (config, serviceUrl);

public function main() returns error? {
    hsproperties:Property property = check hubspot->/[testObjectType]/[testPropertyName].get();
    if property.length() > 0 {
        io:println("Property retrieved successfully");
    } else {
        io:println("Property not found.");
    }

    hsproperties:CollectionResponsePropertyNoPaging propertyCollection = check hubspot->/[testObjectType].get();
    if propertyCollection.results.length() > 0 {
        io:println("Property groups retrieved successfully");
    } else {
        io:println("Property groups not found.");
    }

    hsproperties:PropertyGroupCreate propertyGroupInput = { 
        "name": "propertygrouptest1",
        "displayOrder": -1,
        "label": "My Property Group testyo"
    };

    http:Response propertyGroupDeleteResponse = check hubspot->/[testObjectType]/groups/["propertygrouptest1"].delete();
    if propertyGroupDeleteResponse.statusCode == 204 {
        io:println("Property group deleted successfully.");
    } else {
        io:println("Failed to delete property group.");
    }

    hsproperties:PropertyGroup propertyGroupCreateResponse = check hubspot->/[testObjectType]/groups.post(payload = propertyGroupInput);
    if propertyGroupCreateResponse.length() > 0 && propertyGroupCreateResponse.name == "propertygrouptest1" {
        io:println("Property group created successfully: ", propertyGroupCreateResponse);
    } else {
        io:println("Failed to create property group.");
    }


}