class Solution {

    struct Point: Hashable {
        let x: Int
        let y: Int
    }

    func minAreaRect(_ points: [[Int]]) -> Int {
        if points.count < 4 {
            return 0
        }
        var area = Int.max
        var pairSet = Set<Point>()

        for point in points {
            pairSet.insert(Point(x: point[0], y: point[1]))
        }

        for (i, _) in points.enumerated() {
            for j in (i + 1)..<points.count {
                let point1 = Point(x: points[i][0], y: points[i][1])
                let point2 = Point(x: points[j][0], y: points[j][1])
                // Check diagonal case
                if point1.x != point2.x && point1.y != point2.y {
                    let point3 = Point(x: point1.x, y: point2.y)
                    let point4 = Point(x: point2.x, y: point1.y)

                    if pairSet.contains(point3) && pairSet.contains(point4) {
                        area = min(area, (abs(point1.x - point2.x) * abs(point1.y - point2.y)))
                    }
                }
            }
        } 
        return area == Int.max ? 0 : area
    }
}

let solution = Solution()

// Тест 1: Пустой массив точек
let test1 = solution.minAreaRect([]) // Ожидаемый результат: 0

// Тест 2: Массив точек с менее чем 4 точками
let test2 = solution.minAreaRect([[1, 1], [2, 2]]) // Ожидаемый результат: 0

// Тест 3: Прямоугольник с минимальной площадью
let test3 = solution.minAreaRect([[1, 1], [1, 2], [2, 2], [2, 3], [2, 1], [0,0], [1, 3]]) // Ожидаемый результат: 1

// Тест 4: Прямоугольник с отрицательными координатами
let test4 = solution.minAreaRect([[-1, -1], [-1, -2], [-2, -2], [-2, -1]]) // Ожидаемый результат: 1

// Тест 5: Прямоугольник с большей площадью
let test5 = solution.minAreaRect([[0, 0], [0, 3], [4, 0], [4, 3], [12, 70]]) // Ожидаемый результат: 12

// Вывод результатов
print("Test 1: \(test1)")
print("Test 2: \(test2)")
print("Test 3: \(test3)")
print("Test 4: \(test4)")
print("Test 5: \(test5)")

