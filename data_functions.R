resolveBattle <- function(attacker, defender)
{
  attacker$drm <- getAttackerDieRollModifier(attacker)
  attacker$is_foraging <- FALSE
  
  defender$drm <- getDefenderDieRollModifier(defender)
  
  attacker$result <- getResult(attacker)
  defender$result <- getResult(defender)
  
  list(attacker = attacker, defender = defender)
}

getResult <- function(force_props)
{
  if (force_props$sp_count <= 6)
    result <- getResult_1(force_props)
  
  if (force_props$sp_count %in% c(7:12))
    result <- getResult_2(force_props)
  
  if (force_props$sp_count >= 13)
    result <- getResult_3(force_props)
  
  result
}

getResult_1 <- function(force_props)
{
  column <- ifelse(force_props$sp_count == 6, force_props$sp_count, force_props$sp_count + 1)
  column <- ifelse(force_props$is_foraging, column - 1, column)
  
  row <- force_props$die_roll + force_props$drm
  row <- cut(row, breaks = c(-100, 1, 2, 3, 4, 5, 6, 7, 100))
  row <- as.numeric(row)

  result <- crt.1[row, column]
}

getResult_2 <- function(force_props)
{
  column <- ifelse(force_props$sp_count <= 8, 1, 2)
  column <- ifelse(force_props$is_foraging, column - 1, column)
  
  row <- force_props$die_roll + force_props$drm
  row <- cut(row, breaks = c(-100, 3, 5, 7, 8, 10, 12, 14, 100))
  row <- as.numeric(row)
  
  result <- crt.2[row, column]
}

getResult_3 <- function(force_props)
{
  column <- ifelse(force_props$sp_count <= 16, 1, 2)
  
  row <- force_props$die_roll + force_props$drm
  row <- cut(row, breaks = c(-100, 5, 8, 10, 12, 15, 18, 21, 100))
  row <- as.numeric(row)
  
  result <- crt.3[row, column]
}

getAttackerDieRollModifier <- function(attacker)
{
  attacker_drm <- 0
  
  if (attacker$is_demoralized)
    attacker_drm <- attacker_drm -2
  
  if (attacker$special_action)
    attacker_drm <- attacker_drm +2
  
  if (attacker$naval_support)
    attacker_drm <- attacker_drm +1
  
  attacker_drm <- attacker_drm + attacker$leader_attack_modifier
}

getDefenderDieRollModifier <- function(defender)
{
  defender_drm <- 0
  mountain_defense <- 0
  river_defense <- 0
  fortification_defense <- 0
  
  if (defender$attack_across_mountain)
    mountain_defense <- 1
  
  if (defender$attack_across_river)
    river_defense <- 1
  
  fortification_defense <- defender$fortification_modifier
  
  if (defender$naval_support)
    defender_drm <- defender_drm +1
  
  defender_drm <- defender_drm + defender$leader_defense_modifier + max(c(mountain_defense, river_defense, fortification_defense))
}

getBattleStatistics <- function(attacker, defender)
{
  cat("Building battle statistics")
  n <- 2000
  battle_results <- data.frame(attacker_die_roll = numeric(n),
                               defender_die_roll = numeric(n),
                               attacker_result = numeric(n),
                               defender_result = numeric(n),
                               attacker_losses = numeric(n),
                               defender_losses = numeric(n),
                               outcome = character(n), stringsAsFactors = FALSE)
  
  for (i in 1:n)
  {
    attacker$die_roll <- getRandomDieRoll(attacker)
    defender$die_roll <- getRandomDieRoll(defender)
    
    result <- resolveBattle(attacker, defender)
    
    battle_results[i, c(1:7)] <- c(result$attacker$die_roll,
                                   result$defender$die_roll,
                                   result$attacker$result,
                                   result$defender$result,
                                   trunc(result$defender$result),
                                   trunc(result$attacker$result),
                                   ifelse(result$attacker$result > result$defender$result, "attacker", 
                                          ifelse(result$defender$result > result$attacker$result, "defender",
                                                 "tie")))
  }
  
  battle_stats <- data.frame(attacker_win_pct = nrow(filter(battle_results, outcome == "attacker"))/nrow(battle_results),
                             defender_win_pct = nrow(filter(battle_results, outcome == "defender"))/nrow(battle_results),
                             tie_pct = nrow(filter(battle_results, outcome == "tie"))/nrow(battle_results))
  
  attacker_losses <- group_by(battle_results, attacker_losses) %>%
    summarise(loss_frequency = n()) %>%
    mutate(loss_probability = loss_frequency/nrow(battle_results),
           name = "Attacker") %>%
    rename(sp_losses = attacker_losses)
  
  defender_losses <- group_by(battle_results, defender_losses) %>%
    summarise(loss_frequency = n()) %>%
    mutate(loss_probability = loss_frequency/nrow(battle_results),
           name = "Defender") %>%
    rename(sp_losses = defender_losses)
  
  result <- list(battle_stats = battle_stats, attacker_losses = attacker_losses, defender_losses = defender_losses)
}

getRandomDieRoll <- function(force_props)
{
  if (force_props$sp_count <= 6)
    die_roll <- round(runif(1, 1, 6))
  
  if (force_props$sp_count %in% c(7:12))
    die_roll <- round(runif(1, 1, 6)) + round(runif(1, 1, 6))
  
  if (force_props$sp_count >= 13)
    die_roll <- round(runif(1, 1, 6)) + round(runif(1, 1, 6)) + round(runif(1, 1, 6))
  
  die_roll
}

