# [Marketing Preference Management](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.properties/tree/8dfd490047721c5e72f0a8d995636860769e3c82/examples/marketing-preference)

This example shows how to use the HubSpot CRM Properties API to batch-create properties related to marketing preferences for contacts. It covers creating a property group and adding multiple subscription-related properties like "email subscription," "SMS subscription," and "preferred contact time" in one batch request. The program also demonstrates how to update properties, ensuring that marketing preferences are organized efficiently for better customer engagement and communication strategies.

## Prerequisites

1. Generate HubSpot credentials to authenticate the connector as described in the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.properties/blob/8dfd490047721c5e72f0a8d995636860769e3c82/ballerina/Package.md#setup-guide).

2. For each example, create a `Config.toml` file the related configuration. Here's an example of how your `Config.toml` file should look:

    ```toml
    clientId = <Client Id>
    clientSecret = <Client Secret>
    refreshToken = <Refresh Token>
    ```

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
