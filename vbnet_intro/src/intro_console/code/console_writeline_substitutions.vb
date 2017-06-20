Module Module1
    Sub Main()
        ' {0} is "David", {1} is "Peter".
        Console.WriteLine("{0} and {1} are good friends.",
                          "David", "Peter")
        ' {1} is used multiple times.
        Console.WriteLine("{1} * {1} = {0}", 9 * 9, 9)
        Console.ReadLine()
    End Sub
End Module
