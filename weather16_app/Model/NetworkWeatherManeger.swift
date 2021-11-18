//
//  NetworkWeatherManeger.swift
//  weather16_app
//
//  Created by user on 10.11.2021.
//

import Foundation

//struct NetworkWeatherManeger {
//    func updateWeatherInfo(){
//        let session = URLSession.shared
//        let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=5d660d04041a48beb80213202210911&q=London&days=1")!
//        let task = session.dataTask(with: url) { (data, responce, error) in
//
//            guard let data = data else {
//                print(String(describing: error))
//                return
//            }
//            print(String(data: data, encoding: .utf8)!)
//    //            guard error == nil else {
//    //                print("DAtaTAAsk ErroR \(error?.localizedDescription)")
//    //                return
//    //            }
//    //            do{
//    //                self.weatherData = try JSONDecoder().decode(WeatherData.self, from: data!)
//    //                print(self.weatherData)
//    //                DispatchQueue.main.async {
//    //                    self.updateView()
//    //                }
//    //            } catch {
//    //                print(error.localizedDescription)
//    //            }
//        }
//        task.resume()
//    }
//}
class NetworkWeatherManeger {
    func updateWeatherInfo( urlString: String, complitionHandler: @escaping (Result<Instruction, Error>) -> Void){
        //func getAllPosts( _ complitionHandler: @escaping ([ArticlesResponseModel]) -> Void){
            if let url = URL(string: urlString ) {
                URLSession.shared.dataTask(with: url) { (data, responsse, error) in
                    DispatchQueue.main.async {
                    if let error = error {
                        print("error in request")
                        complitionHandler(.failure(error))
                        return
                    }
                        guard let responseData = data else { return }
                        do{
                           let posts = try JSONDecoder().decode(Instruction.self, from: responseData)
                            complitionHandler(.success(posts))
                         //   print(posts ?? "/.../")

//                            let posts = try? JSONSerialization.jsonObject(with: responseData, options: [])
                            //print(posts ?? "/.../")
                          //  complitionHandler(.success(posts))
                        } catch let error {
                            print("error", error)
                            complitionHandler(.failure(error))
                            }
                    }
                }.resume()
            }
        }
    func fetchWeather(latitude: Double, longitude: Double, complitionHandler: @escaping (Weather) -> Void) {
        let urlString = "http://api.weatherapi.com/v1/forecast.json?key=5d660d04041a48beb80213202210911&q=\(latitude),\(longitude)&days=1"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, responsse, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    print(String(describing: error))
                    return
            }
            if let weather = self.parseJSOn(withData: data) {
               // print(weather)
                complitionHandler(weather)
            }
         }
        
        }.resume()
    }
    func parseJSOn(withData data: Data) -> Weather? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(Instruction.self, from: data)
            guard let weather = Weather(instruction: weatherData) else {
                return nil
            }
            return weather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
