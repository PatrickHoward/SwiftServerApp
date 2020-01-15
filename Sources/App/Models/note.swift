import FluentSQLite;
import Vapor;

final class Note: Model {
    var id: Int?
    var title: String
    var presenter: String
    var notes: String
    var rating: Int

    init( title: String, presenter: String, notes: String, rating: Int){
        self.title = title
        self.presenter = presenter
        self.notes = notes
        self.rating = rating
    }
}

extension Note: SQLiteModel {}
extension Note: Migration {}
extension Note: Content {}
extension Note: Parameter {}