import Foundation

struct GoogleSheetsAPIConfig {
  let apiKey: String
  let sheetId: String
  let baseUrl: String = "https://sheets.googleapis.com/v4/spreadsheets"
}
