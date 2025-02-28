import Testing
import balatro


@Test func example() async throws {
    let json = Balatro().performAnalysis(seed: "ALEX").toJson()
    print(json)    
}
