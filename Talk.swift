import Foundation
import SwiftData

@Model
class Talk{
    var prompt: String
    var respons: String
    var date: Date
    
    init (prompt: String, respons: String) {
        self.prompt = prompt
        self.respons = respons
        self.date = Date.now
    }
}
