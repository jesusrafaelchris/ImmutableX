import Foundation

extension Optional {
    /// Return wrapped value if exists or throws ``AppError`` otherwise
    func orThrowIfNil() throws -> Wrapped {
        if let wrapped = self {
            return wrapped
        } else {
            throw AppError.nullValue
        }
    }
}
