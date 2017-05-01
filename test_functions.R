testTable1 <- function()
{
  die_roll <- 4
  
  attacker <- list(sp_count = 3, 
                   is_demoralized = FALSE, 
                   special_action = FALSE, 
                   naval_support = FALSE, 
                   leader_attack_modifier = 1,
                   leader_defense_modifier = 1,
                   attack_across_mountain = FALSE,
                   attack_across_river = FALSE,
                   fortification_modifier = 0,
                   is_foraging = FALSE)
  
  defender <- list(sp_count = 3, 
                   is_demoralized = FALSE, 
                   special_action = FALSE, 
                   naval_support = FALSE, 
                   leader_attack_modifier = 1,
                   leader_defense_modifier = 1,
                   attack_across_mountain = FALSE,
                   attack_across_river = FALSE,
                   fortification_modifier = 0,
                   is_foraging = FALSE)
  
  for (i in 1:6)
  {
    attacker$die_roll <- round(runif(1, 1, 6))
    defender$die_roll <- round(runif(1, 1, 6))
    
    result <- resolveBattle(attacker, defender)
    
    print(paste("Attacker (", result$attacker$sp_count, "SP )", "Die roll:", result$attacker$die_roll, "+", result$attacker$drm, "=>", result$attacker$result))
    print(paste("Defender (", result$defender$sp_count, "SP )", "Die roll:", result$defender$die_roll, "+", result$defender$drm, "=>", result$defender$result))
    print("")
  }
  
}

testTable2 <- function()
{
  die_roll <- 4
  
  attacker <- list(sp_count = 8, 
                   is_demoralized = FALSE, 
                   special_action = FALSE, 
                   naval_support = FALSE, 
                   leader_attack_modifier = 1,
                   leader_defense_modifier = 1,
                   attack_across_mountain = FALSE,
                   attack_across_river = FALSE,
                   fortification_modifier = 0,
                   is_foraging = FALSE)
  
  defender <- list(sp_count = 8, 
                   is_demoralized = FALSE, 
                   special_action = FALSE, 
                   naval_support = FALSE, 
                   leader_attack_modifier = 1,
                   leader_defense_modifier = 1,
                   attack_across_mountain = FALSE,
                   attack_across_river = FALSE,
                   fortification_modifier = 0,
                   is_foraging = FALSE)
  
  for (i in 1:6)
  {
    attacker$die_roll <- round(runif(1, 1, 6)) + round(runif(1, 1, 6))
    defender$die_roll <- round(runif(1, 1, 6)) + round(runif(1, 1, 6))
    
    result <- resolveBattle(attacker, defender)
    
    print(paste("Attacker (", result$attacker$sp_count, "SP )", "Die roll:", result$attacker$die_roll, "+", result$attacker$drm, "=>", result$attacker$result))
    print(paste("Defender (", result$defender$sp_count, "SP )", "Die roll:", result$defender$die_roll, "+", result$defender$drm, "=>", result$defender$result))
    print("")
  }
  
}


testTable3 <- function()
{
  die_roll <- 4
  
  attacker <- list(sp_count = 13, 
                   is_demoralized = FALSE, 
                   special_action = FALSE, 
                   naval_support = FALSE, 
                   leader_attack_modifier = 1,
                   leader_defense_modifier = 1,
                   attack_across_mountain = FALSE,
                   attack_across_river = FALSE,
                   fortification_modifier = 0,
                   is_foraging = FALSE)
  
  defender <- list(sp_count = 10, 
                   is_demoralized = FALSE, 
                   special_action = FALSE, 
                   naval_support = FALSE, 
                   leader_attack_modifier = 1,
                   leader_defense_modifier = 4,
                   attack_across_mountain = FALSE,
                   attack_across_river = FALSE,
                   fortification_modifier = 2,
                   is_foraging = FALSE)
  
  for (i in 1:6)
  {
    attacker$die_roll <- round(runif(1, 1, 6)) + round(runif(1, 1, 6)) + round(runif(1, 1, 6))
    defender$die_roll <- round(runif(1, 1, 6)) + round(runif(1, 1, 6)) + round(runif(1, 1, 6))
    
    result <- resolveBattle(attacker, defender)
    
    print(paste("Attacker (", result$attacker$sp_count, "SP )", "Die roll:", result$attacker$die_roll, "+", result$attacker$drm, "=>", result$attacker$result))
    print(paste("Defender (", result$defender$sp_count, "SP )", "Die roll:", result$defender$die_roll, "+", result$defender$drm, "=>", result$defender$result))
    print("")
  }
  
}

testBattleStats <- function()
{
  attacker <- list(sp_count = 13, 
                   is_demoralized = FALSE, 
                   special_action = FALSE, 
                   naval_support = FALSE, 
                   leader_attack_modifier = 1,
                   leader_defense_modifier = 1,
                   attack_across_mountain = FALSE,
                   attack_across_river = FALSE,
                   fortification_modifier = 0,
                   is_foraging = FALSE)
  
  defender <- list(sp_count = 10, 
                   is_demoralized = FALSE, 
                   special_action = FALSE, 
                   naval_support = FALSE, 
                   leader_attack_modifier = 1,
                   leader_defense_modifier = 4,
                   attack_across_mountain = FALSE,
                   attack_across_river = FALSE,
                   fortification_modifier = 2,
                   is_foraging = FALSE)
  
  results <- getBattleStatistics(attacker, defender)
  
  battle_stats <- results$battle_stats
  attacker_losses <- results$attacker_losses
  defender_losses <- results$defender_losses
}