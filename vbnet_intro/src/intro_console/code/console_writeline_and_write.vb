Module Module1
    Sub Main()
        Console.WriteLine("Console.WriteLine results")
        Console.WriteLine("=========================")
        Console.WriteLine("Item 1")
        Console.WriteLine(2.345)
        Console.WriteLine("Item " & 3)
        Console.WriteLine("Item {0}", 4)
        Console.WriteLine()
        Console.WriteLine()
        Console.WriteLine("Console.Write results")
        Console.WriteLine("=====================")

        Console.Write("Item 1")
        Console.Write(2.345)
        Console.Write("Item " & 3)
        Console.Write("Item {0}", 4)

        Console.ReadLine()
    End Sub
End Module
