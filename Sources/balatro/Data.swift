import Foundation

public final class Data {
    private let seed: String
    private var data: [Int64] = Array(repeating: 0, count: 13)

    init(seed: String) {
        self.seed = seed
    }

    init(seed: String, data: [Int64]) {
        self.seed = seed
        self.data = data
    }

    init(run: Run) {
        self.seed = run.seed
        self.data = Array(repeating: 0, count: 13)

        for ante in run.antes {
            for joker in ante.jokers() {
                turnOn(item: joker)
            }

            turnOn(item: ante.voucher)
            turnOn(item: ante.boss)

            for tag in ante.tags {
                turnOn(item: tag)
            }

            for tarot in ante.tarots() {
                turnOn(item: tarot)
            }

            for planet in ante.planets() {
                turnOn(item: planet)
            }

            for value in ante.legendaryJokers() {
                turnOn(item: value)
            }

            for spectral in ante.spectrals() {
                turnOn(item: spectral)
            }
        }
    }

    var getSeed: String {
        return seed
    }

    func contains(_ items: [Item]) -> Bool {
        for item in items {
            if !isOn(item: item) {
                return false
            }
        }
        return true
    }

    func write(to d: inout Foundation.Data) {
        d.append(contentsOf: seed.data(using: .ascii)!)

        for i in 0..<13 {
            var value = data[i]
            d.append(Foundation.Data(bytes: &value, count: 8))
        }
    }

    private func turnOn(item: Item) {
        data[item.y] = data[item.y] | (1 << item.ordinal)
    }

    private func isOn(item: Item) -> Bool {
        return (data[item.y] & (1 << item.ordinal)) != 0
    }
}
