import Foundation

protocol RemoteFileDownloaderProtocol {
    func downloadRemoteFile(url: URL, completion: @escaping (String?) -> ())
}

final class RemoteFileDownloader: RemoteFileDownloaderProtocol {
    
    let ioWriter: IOWriter
    var task: URLSessionDataTask?
    
    init(ioWriter: IOWriter) {
        self.ioWriter = ioWriter
    }
    
    func downloadRemoteFile(url: URL, completion: @escaping (String?) -> ()) {
        
        task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            if let data = data {
                if let string = String(data: data, encoding: .utf8) {
                    completion(string)
                } else {
                    self?.ioWriter.print("Error converting downloaded data from url: \(url)")
                    completion(nil)
                }
            }
            if let error = error {
                self?.ioWriter.print("Error fetching data from url: \(url)")
                self?.ioWriter.print(error.localizedDescription)
                completion(nil)
            }
        }
        task?.resume()
    }
}

// [ ] move this out of here
fileprivate func urlFrom(remotePath: String) -> URL? {
    guard let url = URL(string: remotePath) else {
        return nil
    }
    return url
}
