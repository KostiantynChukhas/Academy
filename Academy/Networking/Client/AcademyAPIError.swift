
import Foundation

extension AcademyAPIError: DecodableResponse {}

struct AcademyAPIError: Codable, LocalizedError {
    static let unknown = AcademyAPIError(
        status: 999,
        error: 999,
        message: "Sorry, something failed",
        request: "",
        details: "",
        object: "",
        type: "",
        value: ""
    )

    static let parsingError: AcademyAPIError = .init(
        status: 888,
        error: 888,
        message: "Failed to parse data from server",
        request: "",
        details: "",
        object: "",
        type: "",
        value: ""
    )

    let status: Int
    let error: Int?
    let message: String
    let request: String?
    let details: String?
    let object: String?
    let type: String?
    let value: String?

    var localizedDescription: String {
        return message
    }
    
    var errorDescription: String? {
        return message
    }
}
