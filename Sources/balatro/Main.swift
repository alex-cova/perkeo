import Foundation


@main
struct Main {
    static func main() {
        print(Balatro().performAnalysis(seed: "ALEX").toJson())
    }
}