import UIKit
import Supabase

final class TimeLineViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://avbixzkokqfspnjokdqn.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF2Yml4emtva3Fmc3Buam9rZHFuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTYzNDgzODIsImV4cCI6MjAzMTkyNDM4Mn0.TXEw4zB64f2jJqnICxx2hhSAVvtvnZpg7b9pPhGdtqM")
    
    var urls = [URL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
        Task {
            let movies = try! await client.storage.from("movie").list(path: nil, options: nil)
            
            for movie in movies {
                let url = try client.storage.from("movie").getPublicURL(path: movie.name)
                urls.append(url)
            }
            
            collectionView.reloadData()
        }
        
    }
    
    func upload(_ url: URL) {
        Task {
            do {
                let data = try Data(contentsOf: url)
                let response = try await client.storage.from("movie")
                    .upload(path: UUID().uuidString, file: data, options: FileOptions(
                        cacheControl: "3600",
                        contentType: "video/mp4",
                        upsert: false))
                print("upload complete \(response.fullPath)")
                
            } catch {
                print(error)
            }
        }
    }
    
}

extension TimeLineViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeLineCell", for: indexPath) as! TimeLineCell
        
        cell.imageView.image = UIImage(movieUrl: urls[indexPath.row])
        
        return cell
    }
    
}

class TimeLineCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
}

struct TimeLine: Decodable {
    let id: Int
    let pass: String
    let created_at: String
}
