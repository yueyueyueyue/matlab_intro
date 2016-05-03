windProfile := proc(k,c)
  local X, h, f;
begin
  
X := stats::weibullRandom(k, c): data := [X() $ i = 1..1000]:
h := plot::Histogram2d(data, Cells = [15],Area = 1, Color = RGB::Blue):
f := plot::Function2d(stats::weibullPDF(k, c), x = 0..34, 
                      LineWidth = 1*unit::mm, Color = RGB::Black):
plot(h, f, AxesTitles = ["Wind speed (m/s)", " "],
                      Header = "Distribution of wind speeds")
  
end_proc: 