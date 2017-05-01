
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  buildAttacker <- reactive({
    attacker <-  list(sp_count = input$attackStrength, 
                      leader_attack_modifier = input$attackLeaders,
                      special_action = input$attackSpecialCard, 
                      is_demoralized = input$attackDemoralized, 
                      naval_support = input$attackNavalSupport, 
                      leader_defense_modifier = 0,
                      attack_across_mountain = FALSE,
                      attack_across_river = FALSE,
                      fortification_modifier = 0,
                      is_foraging = FALSE)
  })
  
  buildDefender <- reactive({
    defender <-  list(sp_count = input$defenseStrength, 
                      leader_attack_modifier = 0,
                      special_action = FALSE, 
                      is_demoralized = FALSE, 
                      naval_support = input$defenseNavalSupport, 
                      leader_defense_modifier = input$defenseLeaders,
                      attack_across_mountain = input$defenseMountain,
                      attack_across_river = input$defenseRiver,
                      fortification_modifier = input$defenseFortifications,
                      is_foraging = input$defenseForaging)
  })
  
  output$battleOutcome <- renderPlot({
    attacker <- buildAttacker()
    defender <- buildDefender()
    
    results <<- getBattleStatistics(attacker, defender)
    
    plotBattleOutcome(results$battle_stats)

  })
  
  output$battleLosses <- renderPlot({
    attacker <- buildAttacker()
    defender <- buildDefender()
#     
#     results <- getBattleStatistics(attacker, defender)
    
    plotBattleLosses(results$attacker_losses, results$defender_losses)
    
  })
  
})
