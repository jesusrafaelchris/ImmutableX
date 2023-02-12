import Foundation

struct MintNFTStruct {
    var address: String
    var tokenID: String
}

final class HttpManager {
    
    static var shared = HttpManager()
    
    func mintNFT() {
        // create post request
        let url = URL(string: "http://10.2.0.188:3000/mint?tokenID=201&address=0xEdDfb2e6D08ef057A0586dB556F5b5c04a99507c")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                print(response)
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }

        task.resume()
     }
}
