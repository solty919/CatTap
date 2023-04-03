import Foundation

extension DateFormatter {
    
    public enum FormatType: String {
        /// yyyy/MM.dd HH:mm:ss
        case full = "yyyy/MM/dd HH:mm:ss"
        /// yyyyMMdd
        case yyyyMMdd_none = "yyyyMMdd"
        /// yyyy/MM/dd
        case yyyyMMdd_slash = "yyyy/MM/dd"
        /// yyyyMMddHHmmss
        case yyyyMMddHHmmss_none = "yyyyMMddHHmmss"
        /// yyMM
        case yyMM = "yyMM"
        /// yyMMdd
        case yyMMdd = "yyMMdd"
        /// yy.MM.dd
        case yyMMdd_dot = "yy.MM.dd"
    }
    
    public convenience init(_ formatType: FormatType) {
        self.init()
        self.locale = Locale(identifier: "en_US_POSIX")
        self.timeZone = TimeZone(identifier: "Asia/Tokyo")
        self.dateFormat = formatType.rawValue
    }
    
    public convenience init(_ dateFormat: String) {
        self.init()
        self.locale = Locale(identifier: "en_US_POSIX")
        self.timeZone = TimeZone(identifier: "Asia/Tokyo")
        self.dateFormat = dateFormat
    }
    
    /// ミリ秒6桁付きのiso8601フォーマット e.g. 2019-08-22T09:30:15.000000
    public static let iso8601Full: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        return formatter
    }()
}
