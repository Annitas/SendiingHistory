import Foundation

enum NetworkError: Error {
    case httpError(statusCode: Int)
    case notFound
    case noData
    case decodingError
    case encodingError
    case unauthorized
}

class NetworkUtils {
    static let GET: String = "GET"
    
    static func ensureStatusCodeIs200(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.httpError(statusCode: -1)
        }
        // swiftlint:disable force_unwrapping
        print("network request \(response.url!.absoluteString) status code \((response as? HTTPURLResponse)!.statusCode)")
        // swiftlint:enable force_unwrapping
        guard (200...299).contains(httpResponse.statusCode) else {
            if httpResponse.statusCode == 404 {
                throw NetworkError.notFound
            } else if httpResponse.statusCode == 401 {
                throw NetworkError.unauthorized
            } else {
                throw NetworkError.httpError(statusCode: httpResponse.statusCode)
            }
        }
    }
}

enum NetworkService {
    static let baseURL = URL(string: "https://rickandmortyapi.com/api")
    
    case getMovies
}

extension NetworkService {
    var path: String {
        switch self {
        case .getMovies:
            return "/character"
        }
    }
    
    var method: String {
        switch self {
        case .getMovies:
            return NetworkUtils.GET
        }
    }
    
    var headers: [String: String]? {
        switch self {
            //        case .addUser:
            //            return ["Content-Type": "application/json"]
        default:
            return nil
        }
    }
    
    var body: Data? {
        return nil
    }
    
    private func encode<T: Encodable>(_ value: T) -> Data? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return try? encoder.encode(value)
    }

    static func request<T: Decodable> (type: NetworkService, responseType: T.Type) async throws -> T {
        let urlRequest = buildRequest(type: type)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        try NetworkUtils.ensureStatusCodeIs200(response: response)
        let json = try? JSONSerialization.jsonObject(with: data)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    static func request(type: NetworkService) async throws {
        let urlRequest = buildRequest(type: type)
        
        let (_, response) = try await URLSession.shared.data(for: urlRequest)
        
        try NetworkUtils.ensureStatusCodeIs200(response: response)
    }
    
    private static func buildRequest(type: NetworkService) -> URLRequest {
        guard let resourceURL = baseURL?.appendingPathComponent(type.path) else {
            fatalError("Failed to convert baseURL to a URL")
        }
        
        var urlRequest = URLRequest(url: resourceURL)
        urlRequest.httpMethod = type.method
        
        if let headers = type.headers {
            for (key, value) in headers {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body = type.body {
            urlRequest.httpBody = body
        }
        
        return urlRequest
    }
}

struct GetMoviesResponse: Codable {
    let results: [MovieApi]
}
struct MovieApi: Codable {
    var name: String
}
