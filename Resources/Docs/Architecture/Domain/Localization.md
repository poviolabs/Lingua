# Localization Domain

**Entities**:

- `LocalizationSheet`: Represents a localization sheet containing translation entries for the app.
- `LocalizationEntry`: Represents an entry with properties: section, key, plural and translations
- `PluralCategory`: Represents language plural categories defined by CLDR
- `AssetGenConfig`: Represents an app configuration needed to perform localization
- `LocalizationPlatform`: Represents localization platforms that will be supported by the app. 

**Use Cases**:

- `SheetDataLoader`: A protocol that defines the contract for loading sheet data.
- `LocalizedContentGenerating`: A protocol that defines the contract creating the localization plural/nonPlural content.
- `LocalizedOutputGenerating`: A protocol that defines the contract for generating the output content for given platform.

**Diagram**:

<img title="" src="./Images/localization_domain.png" alt="">
