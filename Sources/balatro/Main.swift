import Foundation

func asyncSearch() async -> String? {
    let run = Balatro()
        .configureForSpeed(selections: [LegendaryJoker.Perkeo])
        .performAnalysis(seed: Balatro.generateRandomString(), maxDepth: 1)

    if run.contains(LegendaryJoker.Perkeo) && run.contains(LegendaryJoker.Triboulet) {
        return run.seed
    }

    return nil
}

@main
struct Main {
    static func main() async {
        var results = Set<String>()

        let startMillis = Date().timeIntervalSince1970

        await withTaskGroup(of: String?.self) { group in
            for _ in 0..<1_000_000 {
                group.addTask {
                    await asyncSearch()
                }
            }

            for await result in group {
                if let result = result {
                    results.insert(result)
                }
            }
        }

        let endMillis = Date().timeIntervalSince1970
        print("Time taken: \(endMillis - startMillis) seconds")

        print(results)

    }
}
