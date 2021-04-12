import Foundation

class DateHelper {
    
    /// Transforms Date String (yyyy-MM-dd) to String (MMMM dd, yyyy)
    /// For example : 2020-11-10 to November 10, 2020
    /// - parameter dateString: yyyy-MM-dd
    
    static func transformDate(dateString: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let startDate = dateFormatter.date(from: dateString) else { return "" }
 
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        
        return dateFormatter.string(from: startDate)
        
    }
    
    
}
