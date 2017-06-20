Module Module1

    Sub Main()
        Console.Write("Enter the base of the triangle: ")
        Dim base As Double = Console.ReadLine()

        Console.Write("Enter the height of the triangle: ")
        Dim height As Double = Console.ReadLine()

        Console.WriteLine("The area of the triangle is {0}.",
                          base * height / 2)

        Console.ReadLine()
    End Sub

End Module
