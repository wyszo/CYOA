import Foundation

protocol RemoteFileDownloaderProtocol {
    func downloadRemoteFileSynchronous(url: URL) -> String?
    func downloadRemoteFileAsync(url: URL, completion: @escaping (String?) -> ())
}

final class RemoteFileDownloader: RemoteFileDownloaderProtocol {
    
    let ioWriter: IOWriter
    var task: URLSessionDataTask?
    private var asyncResult: String?
    
    init(ioWriter: IOWriter) {
        self.ioWriter = ioWriter
    }
    
    func downloadRemoteFileSynchronous(url: URL) -> String? {
        let semaphore = DispatchSemaphore(value: 0)
        
        downloadRemoteFileAsync(url: url) { [weak self] result in
            self?.asyncResult = result
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .now() + 20)
        
        return self.asyncResult
    }
    
    func downloadRemoteFileAsync(url: URL, completion: @escaping (String?) -> ()) {
        
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
