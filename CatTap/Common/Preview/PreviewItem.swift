import Foundation
import QuickLook

final class PreviewItem: NSObject, QLPreviewItem {
     
     var previewItemURL: URL?
     var previewItemTitle: String?
     
     init(url: URL?, title: String?) {
         previewItemURL = url
         previewItemTitle = title
     }
}
