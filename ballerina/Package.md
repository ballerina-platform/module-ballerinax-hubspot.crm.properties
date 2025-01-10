## Overview

[HubSpot ](https://www.hubspot.com/) is an AI-powered customer relationship management (CRM) platform. 

The `ballerinax/module-ballerinax-hubspot.crm.properties` connector offers APIs to connect and interact with the [Hubspot Properties API](https://developers.hubspot.com/docs/guides/api/crm/properties) endpoints, specifically based on the [HubSpot REST API](https://developers.hubspot.com/docs/reference/api/overview).

## Setup guide

To use the HubSpot Properties connector, you must have access to the HubSpot API through a HubSpot developer account and a HubSpot App under it. Therefore, you need to register for a developer account at HubSpot if you don't have one already.

### Step 1: Create/Login to a HubSpot Developer Account

If you have an account already, go to the [HubSpot developer portal](https://app.hubspot.com/)

If you don't have a HubSpot Developer Account you can sign up to a free account [here](https://developers.hubspot.com/get-started)

### Step 2 (Optional): Create a [Developer Test Account](https://developers.hubspot.com/beta-docs/getting-started/account-types#developer-test-accounts) under your account

Within app developer accounts, you can create developer test accounts to test apps and integrations without affecting any real HubSpot data.

**Note: These accounts are only for development and testing purposes. In production you should not use Developer Test Accounts.**

1. Go to Test Account section from the left sidebar.  
   ![Hubspot developer portal](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.properties/main//docs/resources/test_acc_1.png)

2. Click Create developer test account.  
   ![Hubspot developer testacc](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.properties/main//docs/resources/test_acc_2.png)

3. In the dialogue box, give a name to your test account and click create.  
   ![Hubspot developer testacc3](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.properties/main/docs/resources/test_acc_3.png)

### Step 3: Create a HubSpot App under your account.

1. In your developer account, navigate to the "Apps" section. Click on "Create App"  
   ![Hubspot app creation 1](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.properties/main/docs/resources/create_app_1.png)

2. Provide the necessary details, including the app name and description.

### Step 4: Configure the Authentication Flow

1. Move to the Auth Tab.  
   ![Hubspot app creation 2](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.properties/main/docs/resources/create_app_2.png)

2. In the Scopes section, add necessary scopes for your app using the "Add new scope" button.  
   ![Hubspot set scope](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.properties/main/docs/resources/set_scope.png)

3. Add your Redirect URI in the relevant section. You can also use localhost addresses for local development purposes. Click Create App.  
   ![Hubspot create app final](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.properties/main/docs/resources/create_app_final.png)

### Step 5: Get your Client ID and Client Secret

- Navigate to the Auth section of your app. Make sure to save the provided Client ID and Client Secret.  
  ![Hubspot get credentials](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-hubspot.crm.properties/main/docs/resources/get_credentials.png)

### Step 6: Setup Authentication Flow

Before proceeding with the Quickstart, ensure you have obtained the Access Token using the following steps:

1. Create an authorization URL using the following format:

   ```
   https://app.hubspot.com/oauth/authorize?client_id=<YOUR_CLIENT_ID>&scope=<YOUR_SCOPES>&redirect_uri=<YOUR_REDIRECT_URI>
   ```

   Replace the `<YOUR_CLIENT_ID>`, `<YOUR_REDIRECT_URI>` and `<YOUR_SCOPES>` with your specific value.

2. Paste it in the browser and select your developer test account to intall the app when prompted.
3. A code will be displayed in the browser. Copy the code.

   ```
   Received code: na1-129d-860c-xxxx-xxxx-xxxxxxxxxxxx
   ```

4. Run the following ballerina program or curl command. Replace the `<YOUR_CLIENT_ID>`, `<YOUR_REDIRECT_URI`> and `<YOUR_CLIENT_SECRET>` with your specific value. Use the code you received in the above step 3 as the `<CODE>`.

   - Ballerina Program

   ```ballerina
      import ballerina/http;
      import ballerina/io;

      configurable string clientId = ?;
      configurable string clientSecret = ?;
      configurable string redirectUri = ?;
      configurable string code = ?;

      public function main() returns error? {
         http:Client hubspotClient = check new ("https://api.hubapi.com");

         // Construct the form-urlencoded payload
         string payload = string `grant_type=authorization_code&code=${code}&redirect_uri=${redirectUri}&client_id=${clientId}&client_secret=${clientSecret}`;

         http:Request tokenRequest = new;
         tokenRequest.setPayload(payload);
         tokenRequest.setHeader("Content-Type", "application/x-www-form-urlencoded");

         // Send POST request to fetch the access token
         http:Response tokenResponse = check hubspotClient->post("/oauth/v1/token", tokenRequest);

         // Parse and print the response
         json responseJson = check tokenResponse.getJsonPayload();
         io:println("Access and Refresh Token Response: ", responseJson);
      }
   ```

   - Linux/macOS

     ```bash
     curl --request POST \
     --url https://api.hubapi.com/oauth/v1/token \
     --header 'content-type: application/x-www-form-urlencoded' \
     --data 'grant_type=authorization_code&code=<CODE>&redirect_uri=<YOUR_REDIRECT_URI>&client_id=<YOUR_CLIENT_ID>&client_secret=<YOUR_CLIENT_SECRET>'
     ```

   - Windows

     ```bash
     curl --request POST ^
     --url https://api.hubapi.com/oauth/v1/token ^
     --header 'content-type: application/x-www-form-urlencoded' ^
     --data 'grant_type=authorization_code&code=<CODE>&redirect_uri=<YOUR_REDIRECT_URI>&client_id=<YOUR_CLIENT_ID>&client_secret=<YOUR_CLIENT_SECRET>'
     ```

   This command will return the access token necessary for API calls.

   ```json
   {
     "token_type": "bearer",
     "refresh_token": "<Refresh Token>",
     "access_token": "<Access Token>",
     "expires_in": 1800
   }
   ```

5. Store the access token securely for use in your application.

## Quickstart

To use the `HubSpot Properties connector` in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

Import the `hubspot.properties` module and `oauth2` module.

```ballerina
import ballerinax/hubspot.properties as hsproperties;
import ballerina/oauth2;
```
### Step 2: Instantiate a new connector

1. Instantiate a `hsproperties:ConnectionConfig` with the obtained credentials and initialize the connector with it.

    ```ballerina 
    configurable string clientId = ?;
    configurable string clientSecret = ?;
    configurable string refreshToken = ?;

    final hsproperties:ConnectionConfig config = {
        auth : {
            clientId,
            clientSecret,
            refreshToken,
            credentialBearer: oauth2:POST_BODY_BEARER
        }
    };

    final hsproperties:Client hsproperties = check new (config);
    ```

2. Create a `Config.toml` file and, configure the obtained credentials in the above steps as follows:

   ```toml
    clientId = <Client Id>
    clientSecret = <Client Secret>
    refreshToken = <Refresh Token>
   ```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations. A sample usecase is shown below.

#### Create a Property Group

```ballerina
public function main() returns error? {
    hsproperties:PropertyGroupCreate propertyGroupInput = {
        "name": "examplePropertyGroup",
        "displayOrder": -1,
        "label": "This is an example Property Group"
    };

    hsproperties:PropertyGroup response = check hubSpotProperties->/[testObjectType]/groups.post(payload = propertyGroupInput);
}
```

#### Run the Ballerina application

```bash
bal run
```

## Examples

The `Ballerina HubSpot CRM Properties Connector` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.properties/tree/8dfd490047721c5e72f0a8d995636860769e3c82/examples), covering the following use cases:

1. [Customer Behavior Handling](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.properties/tree/main/examples/customer-behavior)
2. [Marketing Preference Management](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.properties/tree/main/examples/marketing-preference)
