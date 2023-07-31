# Example-App: Lingua Integration for iOS

Welcome to our demo app! This example showcases the integration of the Lingua tool for iOS projects.

## Project Structure

We have a dedicated `scripts` directory in which the necessary files for the Lingua integration are added. It includes:

1. `lingua_config.json`: Contains the necessary configurations for Lingua.
2. Shell script for local usage of Lingua.

## Environment Configuration

To enable localization using Lingua, you need to create a `.env` file with the required variables. Here's an example of how it should look:

```shell
GOOGLE_API_KEY=your_api_key
GOOGLE_SPREADSHEET_ID=your_spreadsheet_id
```

Make sure to replace `your_api_key` and `your_spreadsheet_id` with your actual Google API key and Google Spreadsheet ID respectively.

## Running the Script

Post environment configuration, navigate to the `scripts` directory and execute the following command to import new translations:

```shell
./localization.sh
```

Remember to run this script each time you want to import new translations.

This demonstration aids in understanding the process of integrating Lingua into your iOS projects.
