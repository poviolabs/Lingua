import Foundation

struct GoogleSheetDataLoader: SheetDataLoader {
  private let fetcher: GoogleSheetsFetchable
  private let sheetDataDecoder: SheetDataDecoder
  
  init(fetcher: GoogleSheetsFetchable,
       sheetDataDecoder: SheetDataDecoder = LocalizationSheetDataDecoder()) {
    self.fetcher = fetcher
    self.sheetDataDecoder = sheetDataDecoder
  }
  
  func loadSheets() async throws -> [LocalizationSheet] {
    let sheetMetadata = try await fetcher.fetchSheetNames()
    var sections = [LocalizationSheet]()
    
    for sheet in sheetMetadata.sheets {
      let sheetName = sheet.properties.title
      let sheetDataResponse = try await fetcher.fetchSheetData(sheetName: sheetName)
      let section = sheetDataDecoder.decode(sheetData: sheetDataResponse, sheetName: sheetName)
      sections.append(section)
    }
    
    return sections
  }
}

extension GoogleSheetDataLoader {
  static func make(with config: AssetGenConfig.Localization) -> GoogleSheetDataLoader {
    let config = GoogleSheetsAPIConfig(apiKey: config.apiKey, sheetId: config.sheetId)
    let requestBuilder = URLRequestBuilder(baseURLString: config.baseUrl)
    let requestExecutor = APIRequestExecutor(requestBuilder: requestBuilder)
    let fetcher = GoogleSheetsFetcher(config: config, requestExecutor: requestExecutor)
    let dataLoader = GoogleSheetDataLoader(fetcher: fetcher)
    return dataLoader
  }
}
