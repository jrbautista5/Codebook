#server

function(input, output){
  dat <- reactive({
    test <- LA[LA$Year == input$Year,]
    test
  })
  output$plot <- renderPlot(ggplot(dat(), aes(x = input$Year, y = value, color = variable)) +
                              geom_boxplot() + xlab("Year") + ylab("$"))
  output$top_earner <- renderTable(dat() %>% 
                                     filter(Year == input$Year, variable == input$PayType) %>% 
                                     rename("Pay" = value) %>%
                                     arrange(desc(Pay)) %>%
                                     select(Record.Number, Department.Title, Job.Class.Title, Pay) %>%
                                     top_n(input$n))
  output$top_Dpt <- renderTable(dat() %>%
                                  filter(Year == input$Year, variable == input$PayType) %>%
                                  group_by(Department.Title) %>%
                                  summarise(Mean_Pay = mean(value), 
                                            Median_Pay = median(value)) %>%
                                  arrange_at(vars(input$method), desc) %>%
                                  select_at(c("Department.Title", input$method)) %>%
                                  top_n(input$n))
  output$topCost_Dpt <- renderTable(dat () %>%
                                        filter(Year == input$Year, variable == input$PayType) %>%
                                        group_by(Department.Title) %>%
                                        summarise(Total_Cost = sum(value)) %>%
                                        arrange_at(vars(Total_Cost), desc) %>%
                                        select(Department.Title, Total_Cost) %>%
                                        top_n(input$n))
  output$MedPOT <- renderPlot(LA %>%
                                  group_by(as.factor(Year), variable) %>%
                                  mutate(Med_Year = median(value)) %>%
                                  ungroup() %>%
                                  ggplot(aes(x = as.factor(Year), y = Med_Year, 
                                             group = variable, colour = variable)) +
                                  geom_line() + geom_point()
                              )
}
