import Foundation

actor CacheService {
    static let shared = CacheService()

    private var cache: [String: CacheEntry] = [:]

    private init() {}

    struct CacheEntry {
        let data: Data
        let timestamp: Date
        let expirationInterval: TimeInterval
    }

    func set(_ data: Data, forKey key: String, expirationInterval: TimeInterval = 3600) {
        cache[key] = CacheEntry(
            data: data,
            timestamp: Date(),
            expirationInterval: expirationInterval
        )
    }

    func get(forKey key: String) -> Data? {
        guard let entry = cache[key] else { return nil }

        if Date().timeIntervalSince(entry.timestamp) > entry.expirationInterval {
            cache.removeValue(forKey: key)
            return nil
        }

        return entry.data
    }

    func remove(forKey key: String) {
        cache.removeValue(forKey: key)
    }

    func clearAll() {
        cache.removeAll()
    }

    func clearExpired() {
        let now = Date()
        cache = cache.filter { _, entry in
            now.timeIntervalSince(entry.timestamp) <= entry.expirationInterval
        }
    }

    func setObject<T: Codable>(_ object: T, forKey key: String, expirationInterval: TimeInterval = 3600) throws {
        let data = try JSONEncoder().encode(object)
        set(data, forKey: key, expirationInterval: expirationInterval)
    }

    func getObject<T: Codable>(forKey key: String, type: T.Type) throws -> T? {
        guard let data = get(forKey: key) else { return nil }
        return try JSONDecoder().decode(type, from: data)
    }
}
