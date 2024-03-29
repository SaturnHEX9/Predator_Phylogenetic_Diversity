
make_fig_2 <- function(pd, .mytheme, .one_point){
  .mytheme <- .mytheme + theme(axis.title.y = ggplot2::element_blank())
  # presence ----------------------------------------------------------------
  topy <- c(4, 16)
  boty <- c(0, 14)
  
  pred_present <- pd %>%
    select(treatment, total.surv) %>%
    group_by(treatment) %>%
    summarise(trtmeans = mean(total.surv)) %>%
    mutate(ispred = ifelse(treatment == "control", "Absent", "Present")) %>%
    group_by(ispred) %>%
    mutate(presence_mean = mean(trtmeans))
  
  pred_present_plot <- pred_present %>%
    mutate(plotcode = "(a)") %>%
    ggplot(aes(x = ispred, y = trtmeans)) + 
    .one_point + 
    geom_point(aes(y = presence_mean), fill = "#00A08A", shape = 21, colour = "black", size = 5) + 
    #   geom_point(aes(y = total.surv), fill = NA, shape = 21, colour = "black", size = 5,
    #              data = subset(pred_present, treatment == "control")) + 
    xlab("Predator presence") + 
    facet_grid(~ plotcode) +
    .mytheme + 
    coord_cartesian(ylim = topy)
  
  
  # number ------------------------------------------------------------------
  
  
  pred_number <- pred_present %>% 
    filter(ispred == "Present") %>%
    mutate(npred = ifelse(grepl(" \\+ ", treatment), "Two", "One")) 
  
  pred_number_plot <- pred_number %>%
    mutate(plotcode = "(b)") %>%
    ggplot(aes(x = npred, y = trtmeans)) +
    .one_point + 
    stat_summary(fun.y = mean, fill = "#00A08A", shape = 21, size = 5, geom = "point") +
    xlab("Predator number") + 
    facet_grid(~ plotcode) +
    .mytheme + 
    coord_cartesian(ylim = topy)
  
  
  # identity ----------------------------------------------------------------
  
  releveler <- data_frame(treatment = c("andro", 
                                        "tabanid", 
                                        "elong + andro", 
                                        "control", 
                                        "leech", 
                                        "elong + leech", 
                                        "elong", 
                                        "elong + tab"),
                          newlevels = c(
                            "La", 
                            "Tabanid", 
                            "low", 
                            "control", 
                            "Leech",
                            "high",
                            "Le",
                            "medium"))
  
  
  
  preds <- pd %>%
    select(treatment, total.surv) %>%
    left_join(releveler) %>%
    mutate(treatment = factor(newlevels, 
                              levels = c("La","Le","Tabanid","Leech",
                                         "low", "medium", "high"))) %>%
    filter(treatment != "control") %>% 
    mutate(npred = ifelse(grepl("low|medium|high", treatment),
                          "Two species combination", "Monoculture"))
  
  pred_identity <- preds %>%
    filter(npred == "Monoculture")
  
  x_cat <- list("Leptagrion \n andromache", "Leptagion \n elongatum", "Tabanid", "Leech")
  
  pred_identity_plot <- pred_identity %>%
    mutate(plotcode = "(c)") %>%
    ggplot(aes(x = treatment, y = total.surv)) +
    .one_point + 
    stat_summary(fun.y = mean, fill = "#00A08A", shape = 21, size = 5, geom = "point") + 
    scale_x_discrete(labels = x_cat)+
    xlab("Predator identity") +
    facet_grid(~ plotcode) +
    .mytheme + 
    coord_cartesian(ylim = boty)
  
  
  # Combinations ------------------------------------------------------------
  
  
  pred_combo <- preds %>%
    filter(npred == "Two species combination")
  
  
  pred_combo_plot <- pred_combo %>%
    mutate(plotcode = "(d)") %>%
    ggplot(aes(x = treatment, y = total.surv)) +
    .one_point + 
    stat_summary(fun.y = mean, fill = "#00A08A", shape = 21, size = 5, geom = "point") +
    xlab("Phylogenetic diversity") +
    facet_grid(~ plotcode) + 
    scale_x_discrete(labels = list("Low", "Medium", "High")) +
    .mytheme + 
    coord_cartesian(ylim = boty)
  
  
  # png("../Figures/FIG_2.png", height = 500, width = 500)
  grid.arrange(pred_present_plot, pred_number_plot, pred_identity_plot, pred_combo_plot,
               ncol=2,
               left = "Mean prey survival")

  # textGrob is not available in gridExtras as of mid-2015. 
  # see http://r.789695.n4.nabble.com/Problem-with-gridExtra-td4711572.html
  #             left = textGrob("Mean prey survival", rot = 90, vjust = 1))

  # dev.off()
}
