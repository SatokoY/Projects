Sub wall_street()

' Set an initial variable for holding ticker
Dim ticker_name As String

' Set an initial variable for holding the total stock volume per ticker_name
Dim total_stock_volume As Double
total_stock_volume = 0

' Keep track of the location for each ticker_name in the summary table
Dim summary_table_row As Integer
summary_table_row = 2

' Loop through all ticker volume
For i = 2 To 797711

    ' Check if we are still with in the same ticker name, if it is not..
    If Cells(i, 1).Value <> Cells(i + 1, 1).Value Then
    
        ' Set the ticker name
        ticker_name = Cells(i, 1)
        
        ' Add to the total stock volume
        total_stock_volume = total_stock_volume + Cells(i, 7).Value
        
        ' Print the ticker name in the summary table
        Range("I" & summary_table_row).Value = ticker_name
        
        ' Print the total stock volume to the summary table
        Range("J" & summary_table_row).Value = total_stock_volume
        
        ' Add one to the summary table row
        summary_table_row = summary_table_row + 1
        
        ' Reset the total stock volume
        total_stock_volume = 0
        
    ' If the cell folowing a row is the same ticker..
    Else
    
         ' Add to the total stock volume
         total_stock_volume = total_stock_volume + Cells(i, 7)
         
    End If
    
Next i

End Sub


