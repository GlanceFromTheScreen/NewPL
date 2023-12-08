package main

import (
	"fmt"
	"log"
	"os"
	"github.com/gonum/matrix/mat64"
)

func main() {
	// Ввод размерности СЛАУ
	var size int
	fmt.Print("Введите размерность СЛАУ: ")
	fmt.Scan(&size)

	// Ввод матрицы A
	fmt.Println("Введите матрицу A:")
	A := inputMatrix(size, size)

	// Ввод вектора b
	fmt.Println("Введите вектор b:")
	b := inputMatrix(size, 1)

	// Решение СЛАУ
	x := solveLinearSystem(A, b)

	// Вывод ответа в файл
	writeMatrixToFile("out.txt", x)
}

// Функция для ввода матрицы с заданным размером
func inputMatrix(rows, cols int) *mat64.Dense {
	data := make([]float64, rows*cols)
	fmt.Printf("Введите %d элементов матрицы построчно:\n", rows*cols)
	for i := range data {
		fmt.Printf("Элемент %d: ", i+1)
		fmt.Scan(&data[i])
	}
	return mat64.NewDense(rows, cols, data)
}

// Функция для решения СЛАУ
func solveLinearSystem(A, b *mat64.Dense) *mat64.Dense {
	var solution mat64.Dense
	err := solution.Solve(A, b)
	if err != nil {
		log.Fatal("Ошибка при решении СЛАУ:", err)
	}
	return &solution
}

// Функция для записи матрицы в файл
func writeMatrixToFile(filename string, matrix *mat64.Dense) {
	file, err := os.Create(filename)
	if err != nil {
		log.Fatal("Ошибка при создании файла:", err)
	}
	defer file.Close()

	// Форматируем матрицу и записываем в файл
	fmt.Fprintf(file, "%v", mat64.Formatted(matrix, mat64.Prefix(""), mat64.Squeeze()))
	fmt.Printf("%v", mat64.Formatted(matrix, mat64.Prefix(""), mat64.Squeeze()))
	fmt.Println("Решение успешно записано в файл", filename)
}
