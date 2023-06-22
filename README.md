<p align="center">
      <img src="Resources/Images/Lingua.png" width="400" max-width="90%" alt="Lingua" />
</p>
<p align="center">
    <a href="https://www.swift.org" alt="Swift">
        <img src="https://img.shields.io/badge/Swift-5.7-orange.svg" />
    </a>
    <a href="./LICENSE" alt="License">
        <img src="https://img.shields.io/badge/Licence-MIT-green.svg" />
    </a>
    <a href="https://github.com/poviolabs/Lingua/actions/workflows/tests.yml" alt="Tests Status">
        <img src="https://github.com/poviolabs/Lingua/actions/workflows/tests.yml/badge.svg" />
    </a>
</p>

# Lingua

Lingua is a tool designed to streamline the localization process for iOS and Android platforms.
It provides a unified solution for generating localization files from a single source, Google Sheets.

There are several benefits of using the tool:

- Unified translation system for iOS and Android platforms

- Seamless integration with project workflows for automatic translation imports

- Minimized risk of typo errors in localization usage

- Enhanced productivity through intelligent auto-completion and semantic clarity

- Safeguard against referencing non-existent translations

## Installation

Currently we support the tool to be installed via Homebrew

```shell
$ brew tap poviolabs/lingua https://github.com/poviolabs/lingua
$ brew install lingua
```

## 1. Setup Google Sheet

In order to setup Google sheet, we need to complete two steps. First one is to create a sheet with predefined structure, and the second one is to obtain api key and sheet id.

### a. Sheet Document

We have prepared a tamplate for sheet structure for you. What you have to do is to open the link below and make a copy `File > Make a copy`

[Lingua - Google Sheets](https://docs.google.com/spreadsheets/d/1GpaPpO4JMleZPd8paSW4qPBQxjImm2xD8yJhvZOP-8w)

### b. Obtain the sheet id

The sheet id can easly be accessed from the url after you have create a copy of the document tamplate.

`https://docs.google.com/spreadsheets/d/` ***`1GpaPpO4JMleZPd8paSW4qPBQxjImm2xD8yJhvZOP-8w`***

### c. Obtain the API key

Here are the steps to enable the Google Sheets API and create an API key:

1. Go to the [https://console.cloud.google.com/](https://console.cloud.google.com/).

2. If you haven't already, create a new project or select an existing one.

3. In the left sidebar, click on "APIs & Services," then "Dashboard."

4. Click on "+ ENABLE APIS AND SERVICES" at the top of the page.

5. In the search bar, type "Google Sheets API" and select it from the list.

6. Click on "ENABLE" to enable the Google Sheets API for your project.

7. After the API is enabled, go back to the "APIs & Services" > "Dashboard" page.

8. Click on "CREATE CREDENTIALS" at the top of the page.

9. In the "Which API are you using?" dropdown, select "Google Sheets API."

10. In the "Where will you be calling the API from?" dropdown, select "Other non-UI (e.g., cron job, daemon)."

11. In the "What data will you be accessing?" section, select "Public data."

12. Click on "What credentials do I need?"

13. You'll be presented with an API key. Click on "Copy" to copy the key to your clipboard. Store this key securely, as you'll need it to access the Google Sheets API in your application.

Make sure to replace the existing API key in your application with the newly generated one. Also, ensure that the Google Sheet you're trying to access has its sharing settings configured to allow access to anyone with the link. You can do this by clicking on "Share" in the upper right corner of the Google Sheet and selecting "Anyone with the link."

## 2. Configuration file

The Lingua tool allows users to manage localization data in Google Sheets, and generate output files that can be used in iOS and Android projects. Users can define keys and translations in Google Sheets, and specify different translations for different platforms, such as iOS and Android. To achieve this is needed to create a Google Sheet, get the sheet id and api key.

Create a configuration file as a starting point to adapt as your needs, `lingua_config.json` or any other `.json` file.

Then in the configuration file created you need to provide these data, like below:

```json
{
   "localization": {
        "apiKey": "<google_api_key>",
        "sheetId": "<google_spreadsheet_id>",
        "outputDirectory": "/path/to/Resources/Localization"
    }
}
```

### Output directory

The output directory property should be the path where you want the tool to create localization files. 

* For iOS it can be any directory on your project. After you run the command, for the first time, you have to **`Add files to 'YourProject'`** in Xcode.

* For Android, since the translation are placed in a specific project directory, the output directory it should look something like this: **`path/YourProject/app/src/main/res `**

## iOS specific

Since iOS does not have a built in feature to access the localization safely, we have made this possible using Lingua tool. In the configuration file you have to provide the path where the default language strings are stored and where the Swift file you want to be created. With that the tool will create **Lingua.swift** with an enumeration to easily access localizations in your app.

```json
{
   "localization": {
        "apiKey": "<google_api_key>",
        "sheetId": "<google_spreadsheet_id>",
        "outputDirectory": "/path/to/Resources/Localization",
        "swiftCode": {
           "stringsDirectory": "/path/to/Resources/Localization/en.lproj",
           "outputSwiftCodeFileDirectory": "/path/to/Resources/Localization"
        }
    }
}
```

## Usage

Now you can run the tool in terminal, switch to your project directory and run:

**iOS**

```shell
$ lingua ios /path/to/lingua_config.json
```

**Android**

```shell
$ lingua android /path/to/lingua_config.json
```
