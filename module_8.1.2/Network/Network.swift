import SwiftUI
import Combine
import Foundation

class Network: ObservableObject {
    @Published var user: Datas? = nil
    
    func loadData() {
        guard let url = URL(string: "https://api.github.com/users/Sanjar-As") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, _ in
            guard let data = data else {  return  }
            let decoder = JSONDecoder()
            
            do {
                let response = try decoder.decode(Datas.self, from: data)
                
                DispatchQueue.main.async {
                    self.user = response
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }.resume()
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private let url: URL
    private var cancellable: AnyCancellable?
    
    init(url: URL) {
        self.url = url
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
