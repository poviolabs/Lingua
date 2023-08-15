import Foundation

public struct GoogleSheetDataLoaderFactory {
  public static func make(with config: Config.Localization) -> SheetDataLoader {
    let config = GoogleSheetsAPIConfig(apiKey: config.apiKey, sheetId: config.sheetId)
    let requestBuilder = URLRequestBuilder(baseURLString: config.baseUrl)
    let requestExecutor = APIRequestExecutor(requestBuilder: requestBuilder,
                                             errorHandler: GoogleSheetsErrorHandler())
    let fetcher = GoogleSheetsFetcher(config: config, requestExecutor: requestExecutor)
    let dataLoader = GoogleSheetDataLoader(fetcher: fetcher)
    return dataLoader
  }
}
