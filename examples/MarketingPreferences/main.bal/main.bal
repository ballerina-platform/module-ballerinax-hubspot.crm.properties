import ballerina/io;
import ballerina/oauth2;
import ballerinax/hubspot.crm.properties as hsproperties;
import ballerina/http;

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

hsproperties:ConnectionConfig config = {auth: auth};

final hsproperties:Client hubspot = check new (config, serviceUrl);

public function main() returns error? {
    // Step 1: Create a property group for marketing preferences
    hsproperties:PropertyGroup response = check hubspot->/[testObjectType]/groups/marketing_preferences();
    if response.length()>0{
        io:println(response.name);
        http:Response deleteResponse = check hubspot->/[testObjectType]/groups/marketing_preferences.delete();
        io:println(deleteResponse);
    }
    hsproperties:PropertyGroupCreate propertyGroupInput = {
        name: "marketing_preference_property_group",
        displayOrder: 1,
        label: "Marketing Preferences"
    };
    hsproperties:PropertyGroup groupResponse = check hubspot->/Contact/groups.post(payload = propertyGroupInput);
    io:println("Property group created: ", groupResponse);

    // Step 2: Create an Email Subscription property
    hsproperties:PropertyCreate emailSubscriptionProperty = {
        "name": "email_subscription_property",
        "label": "mail Subscription",
        "groupName": "marketing_preferences",
        "type": "enumeration",
        "fieldType": "checkbox",
        "description": "Track email subscription status",
        options: [
            {
                label: "Subscribed",
                value: "subscribed",
                hidden: false,
                description: "Subscribed users",
                displayOrder: 1
            },
            {
                label: "Unsubscribed",
                value: "unsubscribed",
                hidden: false,
                description: "Unsubscribed users",
                displayOrder: 2
            }
        ],
        "hidden": false,
        "formField": true,
        "displayOrder": 1
    };
    hsproperties:Property emailResponse = check hubspot->/Contact.post(payload = emailSubscriptionProperty);
    io:println("Property created: ", emailResponse);

    // Step 3: Create an SMS Subscription property
    hsproperties:PropertyCreate smsSubscriptionProperty = {
        "name": "sms_subscription_property",
        "label": "sms Subscription",
        "groupName": "marketing_preferences",
        "type": "enumeration",
        "fieldType": "checkbox",
        "description": "Track SMS subscription status",
        "options": [
            {
                "label": "Subscribed",
                "value": "subscribed",
                "hidden": false,
                "description": "Subscribed users",
                "displayOrder": 1
            },
            {
                "label": "Unsubscribed",
                "value": "unsubscribed",
                "hidden": false,
                "description": "Unsubscribed users",
                "displayOrder": 2
            }
        ],
        "hidden": false,
        "formField": true,
        "displayOrder": 2
    };
    hsproperties:Property smsResponse = check hubspot->/Contact.post(payload = smsSubscriptionProperty);
    io:println("Property created: ", smsResponse);

    // Step 4: Create a Preferred Contact Time property
    hsproperties:PropertyCreate contactTimeProperty = {
        "name": "preferred_contact_time_property",
        "label": "Preferred Contact Time",
        "groupName": "marketing_preferences",
        "type": "enumeration",
        "fieldType": "radio",
        "description": "Track customer's preferred contact time",
        "options": [
            {
                "label": "Morning",
                "value": "morning",
                "hidden": false,
                "description": "Preferred contact time: Morning",
                "displayOrder": 1
            },
            {
                "label": "Afternoon",
                "value": "afternoon",
                "hidden": false,
                "description": "Preferred contact time: Afternoon",
                "displayOrder": 2
            },
            {
                "label": "Evening",
                "value": "evening",
                "hidden": false,
                "description": "Preferred contact time: Evening",
                "displayOrder": 3
            }
        ],
        "hidden": false,
        "formField": true,
        "displayOrder": 3
    };
    hsproperties:Property contactTimeResponse = check hubspot->/Contact.post(payload = contactTimeProperty);
    io:println("Property created: ", contactTimeResponse);

    // Step 5: Update Email Subscription property to include a new "Paused" status
    hsproperties:PropertyUpdate emailUpdate = {
        options: [
            {label: "Subscribed", value: "subscribed", displayOrder: 1, hidden: false},
            {label: "Unsubscribed", value: "unsubscribed", displayOrder: 2, hidden: false},
            {label: "Paused", value: "paused", displayOrder: 3, hidden: false}
        ]
    };
    hsproperties:Property updatedProperty = check hubspot->/Contact/email_subscription.patch(payload = emailUpdate);
    io:println("Property updated: ", updatedProperty);
}
