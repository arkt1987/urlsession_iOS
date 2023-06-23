//
//  ViewController.swift
//  testApp
//
//  Created by SAIL on 26/05/23.
//

import UIKit

class ViewController: UIViewController {
        
    var login: LoginModel?
    
    var reloadView: (()-> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("My single ton class \(Constant.baseUrl)")
        print("My single ton class rawvalue \(Constant.baseUrl.rawValue)")
        //const.staticUrl
    }
    
    
    func createNewAlertview() {
        // create the alert
                let alert = UIAlertController(title: "My Title", message: "This is my message.", preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
    }
    
    
    func setupPostMethod(){
//        guard let uid = "self.txtUID.text" //else { return }
//        guard let title = "self.txtTitle.text" //else { return }
//        guard let body = "self.txtBody.text" //else { return }
        
        let uid = "self.txtUID.text"
        let title = "self.txtUID.text"
      
        
        if let url = URL(string: Constant.baseUrl.rawValue){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let parameters: [String : Any] = [
                "bioid": "17691",
                "password": "pass123",
            ]
            
            request.httpBody = parameters.percentEncoded()
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    if error == nil{
                        print(error?.localizedDescription ?? "Unknown Error")
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse{
                    guard (200 ... 299) ~= response.statusCode else {
                        print("Status code :- \(response.statusCode)")
                        print(response)
                        
                        return
                    }
                }
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    self.login = json as! LoginModel
                }catch let error{
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
        
   
}

extension Dictionary {
    func percentEncoded() -> Data? {
        map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}
