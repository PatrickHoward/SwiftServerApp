import Fluent
import Vapor

struct NotesController : RouteCollection {
    func boot(router: Router) throws {
        let notesRoutes = router.grouped("notes")
        notesRoutes.get(use: getAllHandler)
        notesRoutes.get(Note.parameter, use: getHandler)
        notesRoutes.delete(Note.parameter, use: deleteHandler)
        notesRoutes.post(Note.parameter, use: createHandler)
//        notesRoutes.post(Note.parameter, use: updateHandler)
    }

    func createHandler (req: Request) throws -> Future<Note> {
        return try req.content.decode(Note.self).flatMap(to: Note.self) {note in
            return note.save(on: req)
        }
    }

    func getAllHandler( req: Request) throws -> Future<[Note]> {
        return Note.query(on: req).all()
    }

    func getHandler(req: Request) throws -> Future<Note> {
        return try req.parameters.next(Note.self)
    }

    //func updateHandler(req: Request) throws -> Future<Note> {
    //    return try flatMap(to: Note.self, req.parameters.next(Note.self),
    //        req.content.decode(Note.self)) { note, updatedNote in
    //        note.title = updatedNote.title
    //        note.presenter = updatedNote.presenter
    //        note.notes = updatedNote.notes
    //        note.rating = updatedNote.rating
    //        }
    //}

    func deleteHandler(req: Request) throws -> Future<HTTPStatus> {
        return try req.content.decode(Note.self).delete(on: req).transform(to: .noContent)
    }
}