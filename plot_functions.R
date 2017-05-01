plotBattleOutcome <- function(battle_stats)
{
  battle_outcome <- melt(battle_stats) %>%
    mutate(variable = revalue(variable, replace = c("attacker_win_pct" = "Attacker Wins",
                                                    "defender_win_pct" = "Defender Wins",
                                                    "tie_pct" = "Tied Battle"))) %>%
    mutate(variable = reorder(variable, value))
  
  p <- ggplot(data = battle_outcome, aes(x = value, y = variable))
  p <- p + geom_point()
  p <- p + geom_text(aes(label=percent(value)), vjust=1.5, colour="red")  
  p <- p + scale_x_continuous(labels = percent)
  p <- p + xlab("Probability (%)")
  p <- p + ylab("Battle Outcome")
  
  p
}

plotBattleLosses <- function(attacker_losses, defender_losses)
{
  losses <- rbind(attacker_losses, defender_losses) %>%
    melt(id = c("name", "sp_losses")) %>%
    filter(variable == "loss_probability")
  
  p <- ggplot(data = losses, aes(x = sp_losses, y = value, fill = name))
  p <- p + geom_bar(stat = "identity", position = "dodge")
  p <- p + geom_text(aes(label=percent(value)), vjust=1.5, colour="black", position=position_dodge(.9), size=4)  
  p <- p + scale_y_continuous(labels = percent)
  p <- p + xlab("Strength Points Lost")
  p <- p + ylab("Probability (%)")
  
  p
  
}