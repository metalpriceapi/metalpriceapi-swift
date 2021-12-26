import Foundation

enum HttpMethodType: String {
    case GET
}

public class MetalpriceAPIService {
    // MARK: - Properties
    private let session: URLSession
    private let baseUrl: String
    private (set) var apiKey: String?
    
    // MARK: - Constructors
    public init(apiKey key: String) {
        if key.isEmpty {
            fatalError("API key required.")
        }
        session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
        baseUrl = "https://api.metalpriceapi.com/v1"
        apiKey = key
    }
    
    // MARK: - Public methods (Closure based)

    public func fetchSymbols(completion: @escaping (SymbolsResult?) -> Void) {
        let urlQueryitems = createQueryItems(items: [
            "api_key": apiKey,
        ])
        guard let url = createUrl(endpoint: "/symbols", urlQueryItems: urlQueryitems) else { return }
        let request = createUrlRequest(url: url, httpMethodType: .GET)
        let task = createRequestAndDecodeUrlSessionDataTask(urlRequest: request, completion: completion)
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    public func fetchLive(base: String? = nil, currencies: [String]? = nil, completion: @escaping (LiveResult?) -> Void) {
        let urlQueryitems = createQueryItems(items: [
            "api_key": apiKey,
            "base": base,
            "currencies": (currencies ?? []).joined(separator: ",")
        ])
        guard let url = createUrl(endpoint: "/latest", urlQueryItems: urlQueryitems) else { return }
        let request = createUrlRequest(url: url, httpMethodType: .GET)
        let task = createRequestAndDecodeUrlSessionDataTask(urlRequest: request, completion: completion)
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    public func fetchHistorical(date: String, base: String? = nil, currencies: [String]? = nil, completion: @escaping (HistoricalResult?) -> Void) {
        let urlQueryitems = createQueryItems(items: [
            "api_key": apiKey,
            "base": base,
            "currencies": (currencies ?? []).joined(separator: ",")
        ])
        guard let url = createUrl(endpoint: "/\(date)", urlQueryItems: urlQueryitems) else { return }
        let request = createUrlRequest(url: url, httpMethodType: .GET)
        let task = createRequestAndDecodeUrlSessionDataTask(urlRequest: request, completion: completion)
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    public func convert(fromCurrency: String? = nil, toCurrency: String, amount: Double, date: String? = nil, completion: @escaping (ConvertResult?) -> Void) {
        let urlQueryitems = createQueryItems(items: [
            "api_key": apiKey,
            "from": fromCurrency,
            "to": toCurrency,
            "amount": String(amount),
            "date": date
        ])
        guard let url = createUrl(endpoint: "/convert", urlQueryItems: urlQueryitems) else { return }
        let request = createUrlRequest(url: url, httpMethodType: .GET)
        let task = createRequestAndDecodeUrlSessionDataTask(urlRequest: request, completion: completion)
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    public func timeframe(startDate: String, endDate: String, base: String? = nil, currencies: [String]? = nil, completion: @escaping (TimeframeResult?) -> Void) {
        let urlQueryitems = createQueryItems(items: [
            "api_key": apiKey,
            "start_date": startDate,
            "end_date": endDate,
            "base": base,
            "currencies": (currencies ?? []).joined(separator: ",")
        ])
        guard let url = createUrl(endpoint: "/timeframe", urlQueryItems: urlQueryitems) else { return }
        let request = createUrlRequest(url: url, httpMethodType: .GET)
        let task = createRequestAndDecodeUrlSessionDataTask(urlRequest: request, completion: completion)
        
        task.resume()
        session.finishTasksAndInvalidate()
    }

    public func change(startDate: String, endDate: String, base: String? = nil, currencies: [String]? = nil, completion: @escaping (ChangeResult?) -> Void) {
        let urlQueryitems = createQueryItems(items: [
            "api_key": apiKey,
            "start_date": startDate,
            "end_date": endDate,
            "base": base,
            "currencies": (currencies ?? []).joined(separator: ",")
        ])
        guard let url = createUrl(endpoint: "/change", urlQueryItems: urlQueryitems) else { return }
        let request = createUrlRequest(url: url, httpMethodType: .GET)
        let task = createRequestAndDecodeUrlSessionDataTask(urlRequest: request, completion: completion)
        
        task.resume()
        session.finishTasksAndInvalidate()
    }

    // MARK: - Private methods
    
    private func createQueryItems(items: [String: String?]) -> [URLQueryItem] {
        var output: [URLQueryItem] = []
        items.forEach { item in
            if let value = item.value, value != "" {
                output.append(URLQueryItem(name: item.key, value: value))
            }
        }
        return output
    }
    
    private func createUrl(endpoint: String, urlQueryItems: [URLQueryItem]?) -> URL? {
        var components = URLComponents(string: baseUrl)
        components?.path.append(endpoint)
        components?.queryItems = urlQueryItems
        return components?.url
    }
    
    private func createUrlRequest(url: URL, httpMethodType: HttpMethodType) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethodType.rawValue
        return urlRequest
    }
    
    private func createRequestAndDecodeUrlSessionDataTask<T: Decodable>(urlRequest: URLRequest, completion closure: @escaping (T?) -> Void) -> URLSessionDataTask {
        return session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Handle response
                guard let data = data else {
                    closure(nil)
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let data = try decoder.decode(T.self, from: data)
                    // Success
                    closure(data)
                } catch let error {
                    // Decoding error
                    print("Unable to decode. Error is: \(error)")
                    closure(nil)
                }
            } else {
                // Failure
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL request failed with code:\(statusCode) and error:\(error!.localizedDescription)")
                closure(nil)
            }
        }
    }
    
}
