library(ggplot2)

df = read.csv("finalResults.csv")
df$adjusted_income = df$adjusted_income/10000000

ggplot(df,aes(x=df$year,y=df$adjusted_income,color=factor(decile), group=factor(decile)))+geom_point()+geom_line()+
  labs(x='Year',y='Income')+
  geom_rect(aes(xmin = 84, xmax = 92, ymin = -Inf, ymax = Inf)
            , fill = "white", alpha = 0.01)


  