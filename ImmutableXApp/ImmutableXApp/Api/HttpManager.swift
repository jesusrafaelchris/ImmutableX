import Foundation

struct MintNFTStruct {
    var address: String
    var tokenID: String
}

final class HttpManager {
    
    static var shared = HttpManager()
    
    func mintNFT() {
        let json: [String: Any] = [
            "address": "0xEdDfb2e6D08ef057A0586dB556F5b5c04a99507c",
            "tokenID": "201"
        ]

        print(json)
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        let url = URL(string: "http://10.2.0.188:3000/mint")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }

        task.resume()
     }
}
