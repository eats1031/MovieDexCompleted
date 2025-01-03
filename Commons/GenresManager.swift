import Foundation

actor GlobalGenresManager {
    // Singleton
    static let shared = GlobalGenresManager()

    // Servicio para obtener los géneros
    private let genresService = GenresService()

    // Caché de géneros
    private var genresCache: [Int: Genre]?
    
    private var _isFetching = false
    
    var isFetching: Bool {
        return self._isFetching
    }

    /// Obtiene los géneros almacenados en caché.
    func getCachedGenres() -> [Int: Genre]? {
        return self.genresCache
    }

    /// Obtiene los géneros, usando caché si es posible.
    func fetchGlobalGenres() async throws -> [Int: Genre] {
        // Si ya tenemos géneros cacheados, los retornamos.
        if let cachedGenres = self.genresCache {
            return cachedGenres
        }

        // Llamada a la API y procesamiento de los datos
        self._isFetching = true;
        let fetchedGenres = try await genresService.fetchGenres()
        self._isFetching = false;
        let genres = fetchedGenres.map { Genre(dto: $0) }
        let genresDictionary = Dictionary(
            uniqueKeysWithValues: genres.map { ($0.id, $0) }
        )

        // Actualizamos el caché
        self.genresCache = genresDictionary

        return genresDictionary
    }

    /// Limpia el caché global.
    func clearCache() {
        self.genresCache = nil
    }
}
