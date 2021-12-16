import Foundation
import CoreData

class PersistableService {
    
    // Public properties
    
    static let shared = PersistableService()
    
    // MARK: - Init properties
    
    private init() {
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "_07_011_2021")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    lazy var backgroundContext: NSManagedObjectContext = persistentContainer.newBackgroundContext()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Save entities to Core Data
    
    func saveWord(word: Word) -> WordEntity {
        let wordEntity = WordEntity(context: viewContext)
        wordEntity.title = word.title
        wordEntity.phonetics = convertPhoneticsArrayToSet(phonetics: word.phonetics ?? [])
        wordEntity.meanings = convertMeaningsArrayToSet(meanings: word.meanings ?? [])
        do {
            try viewContext.save()
        } catch let error {
            print("Error: \(error)")
        }
        return wordEntity
    }
    
    func savePhonetics(phonetics: Phonetics) -> PhoneticsEntity {
        let phoneticsEntity = PhoneticsEntity(context: viewContext)
        phoneticsEntity.audio = phonetics.audio
        phoneticsEntity.text = phonetics.text
        do {
            try viewContext.save()
        } catch let error {
            print("Error: \(error)")
        }
        return phoneticsEntity
    }
    
    func saveMeaning(meaning: Meaning) -> MeaningEntity {
        let meaningEntity = MeaningEntity(context: viewContext)
        meaningEntity.partOfSpeech = meaning.partOfSpeech
        meaningEntity.definitions = convertDefinitionsArrayToSet(definitions: meaning.definitions ?? [])
        do {
            try viewContext.save()
        } catch let error {
            print("Error: \(error)")
        }
        return meaningEntity
    }
    
    func saveDefinition(definition: Definition) -> DefinitionEntity {
        let definitionEntity = DefinitionEntity(context: viewContext)
        definitionEntity.definition = definition.definition
        definitionEntity.example = definition.example
        do {
            try viewContext.save()
        } catch let error {
            print("Error: \(error)")
        }
        return definitionEntity
    }
    
    // MARK: - Convertation arrays to NSSets
    
    func convertPhoneticsArrayToSet(phonetics: [Phonetics]) -> NSSet {
        var phoneticsSet: [PhoneticsEntity] = []
        for currentPhonetics in phonetics {
            let temporaryPhonetics = savePhonetics(phonetics: currentPhonetics)
            phoneticsSet.append(temporaryPhonetics)
        }
        return NSSet(array: phoneticsSet)
    }
    
    func convertMeaningsArrayToSet(meanings: [Meaning]) -> NSSet {
        var meaningsSet: [MeaningEntity] = []
        for currentMeaning in meanings {
            let temporaryMeaning = saveMeaning(meaning: currentMeaning)
            meaningsSet.append(temporaryMeaning)
        }
        return NSSet(array: meaningsSet)
    }
    
    func convertDefinitionsArrayToSet(definitions: [Definition]) -> NSSet {
        var definitionsSet: [DefinitionEntity] = []
        for currentDefinition in definitions {
            let temporaryDefinition = saveDefinition(definition: currentDefinition)
            definitionsSet.append(temporaryDefinition)
        }
        return NSSet(array: definitionsSet)
    }
    
    // MARK: - Operations with essenses
    
    func getWords() -> [Word] {
        let fetchRequest = WordEntity.fetchRequest()
        var words: [Word] = []
        do {
            let wordsEntity = try viewContext.fetch(fetchRequest)
            for wordEntity in wordsEntity {
                words.append(Word(title: wordEntity.title ?? "", phonetics: convertPhoneticsSetToArray(phoneticsSet: wordEntity.phonetics ?? []), meanings: convertMeaningsSetToArray(meaningsSet: wordEntity.meanings ?? [])))
            }
        } catch {
            print(error)
        }
        return words
    }
    
    
    func deleteWord(word: Word) {
        let fetchRequest = WordEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", word.title)
        do {
            let wordsEntity = try viewContext.fetch(fetchRequest)
            guard let wordEntity = wordsEntity.first else {
                return
            }
            viewContext.delete(wordEntity)
            try viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    func isContainsWord(word: Word) -> Bool {
        let fetchRequest = WordEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", word.title)
        do {
            let wordEntity = try viewContext.fetch(fetchRequest)
            if (wordEntity.isEmpty) {
                return false
            } else {
                return true
            }
        } catch {
            print(error)
        }
        return false
    }
    
    // MARK: - Convertation NSSets to arrays
    
    func convertPhoneticsSetToArray(phoneticsSet: NSSet) -> [Phonetics] {
        var phoneticsArray: [Phonetics] = []
        guard let phoneticsSet = phoneticsSet.allObjects as? [PhoneticsEntity] else {
            return []
        }
        for phonetics in phoneticsSet {
            phoneticsArray.append(Phonetics(audio: phonetics.audio, text: phonetics.text))
        }
        return phoneticsArray
    }
    
    func convertMeaningsSetToArray(meaningsSet: NSSet) -> [Meaning] {
        var meaningsArray: [Meaning] = []
        guard let meaningsSet = meaningsSet.allObjects as? [MeaningEntity] else {
            return []
        }
        for meaning in meaningsSet {
            meaningsArray.append(Meaning(partOfSpeech: meaning.partOfSpeech, definitions: convertDefinitionsSetToArray(definitionsSet: meaning.definitions ?? [])))
        }
        return meaningsArray
    }
    
    func convertDefinitionsSetToArray(definitionsSet: NSSet) -> [Definition] {
        var definitionsArray: [Definition] = []
        guard let definitionsSet = definitionsSet.allObjects as? [DefinitionEntity] else {
            return []
        }
        for definition in definitionsSet {
            definitionsArray.append(Definition(definition: definition.definition, example: definition.example, synonyms: definition.synonyms))
        }
        return definitionsArray
    }
}
