library(ggplot2)
library(dplyr)

# --- 1. DATA ENTRY ---
s1 <- c(21.45377027, 16.57696716, 19.79551511, 22.06938602, 20.61887273, 17.70585979, 28.74612535, 20.62571719, 18.38100261, 19.51710592, 18.42543439, 13.09077742, 19.39311815, 14.11143168, 22.74059708, 21.77679126, 22.87676059, 17.86225908, 18.27024017, 20.63841348, 20.65038108, 28.87418638, 18.49014336, 20.58774293)
s2 <- c(16.81163256, 17.03464778, 21.55400705, 20.63570284, 15.48824866, 16.74535453, 19.14873664, 19.91236283, 20.27609595, 22.09716152, 24.04866520, 23.47648987, 17.65393535, 21.29476177, 20.18621752, 18.57852985, 15.28095298, 19.24368589, 18.98005591, 16.54914442, 17.03023002, 21.24478785, 20.75253182, 21.57413335, 12.83909492, 20.57645618, 21.92165042, 25.01754495, 19.54609907, 15.54577549, 24.44110848, 17.35674882, 18.72774350, 20.22043770, 19.99554643, 19.13958752, 21.32141417, 13.93766467, 20.33269498, 17.70217542)
s3 <- c(17.22956040, 18.86286086, 22.10660916, 20.34317271, 42.31264902, 25.82057630, 18.41410500, 20.34649474, 21.94089558, 21.29394188, 22.39554295, 22.39805575, 26.69307004, 19.87572175, 16.73891421, 16.08649209, 22.16448119, 20.84136740, 18.98891486, 18.50224649, 20.09286905, 21.60340814, 17.61338842, 20.24100120, 20.19028432, 10.97335752, 18.59875957, 19.29275480, 22.92002637, 20.80147600, 18.81468756, 18.02019679, 24.10008547, 21.61994415, 16.89897105, 13.81548718, 20.99336878, 21.77275475, 8.604239269, 19.06038127)
s4 <- c(19.18042957, 21.71749159, 19.61666344, 20.18745098, 21.53050232, 22.60367901, 17.70727123, 19.35960763, 17.65533026, 19.66025139, 20.11814431, 17.21345483, 20.98031838, 19.42862772, 20.36132827, 23.59698890, 22.39250108, 18.05151908, 19.07515691, 21.94474962, 21.05117270, 19.17068217, 18.69252997, 17.03938965, 18.99127504, 19.49766143, 19.76623147, 13.52209911, 18.28579352, 16.01600564, 19.45806974, 18.20009987, 19.83141585, 18.26836958, 25.21039150, 20.78515056, 17.71514366, 18.07806687, 20.42799296, 17.54121270, 18.45097379, 16.07049517, 17.92631321, 10.10545318, 20.87275078, 18.75027245, 21.63503257, 19.10120528, 20.24056563, 22.46659423, 30.25166202, 23.13016797, 21.88475387, 16.61331268, 21.55655809, 22.53305695, 15.59695619, 22.46639549, 20.61231564, 20.51396194, 21.09527901, 19.21820254, 16.74839347, 20.20443547, 17.75537656, 12.49402231, 23.82436168, 21.68249133, 19.59085990, 20.81836417, 18.81271648, 36.08617414, 17.06610654, 18.99292203, 23.04653855, 21.22061044, 17.66255430, 18.85750736, 19.22753070, 20.20421543)

# --- 2. RANKED OUTLIER FUNCTION ---
run_ranked_outliers <- function(data_vec, label, count) {
  # Initial Mean and SD of the whole set
  full_mean <- mean(data_vec)
  
  # Calculate absolute distance from mean for every point
  dist_from_mean <- abs(data_vec - full_mean)
  
  # Determine the cutoff distance for the Nth furthest point
  cutoff <- sort(dist_from_mean, decreasing = TRUE)[count]
  
  results <- data.frame(
    Index = 1:length(data_vec),
    Value = data_vec,
    # Flag only the points that are at or beyond the Nth furthest distance
    Status = ifelse(dist_from_mean >= cutoff, "Outlier", "Included"),
    Sample = label
  )
  
  # Final statistics based on the "Included" points
  clean_data <- results$Value[results$Status == "Included"]
  results$FinalMean <- mean(clean_data)
  results$FinalSD <- sd(clean_data)
  results$Status <- factor(results$Status, levels = c("Included", "Outlier"))
  
  return(results)
}

# --- 3. APPLY EXACT COUNTS ---
final_df <- bind_rows(
  run_ranked_outliers(s1, "S1 (Fixed 4)", 4),
  run_ranked_outliers(s2, "S2 (Fixed 6)", 6),
  run_ranked_outliers(s3, "S3 (Fixed 6)", 6),
  run_ranked_outliers(s4, "S4 (Fixed 8)", 8)
)

# --- 4. PLOTTING ---
dev.new() 

print(
  ggplot(final_df, aes(x = Index, y = Value)) +
    geom_point(aes(color = Status, shape = Status), size = 3) +
    geom_hline(aes(yintercept = FinalMean, color = "Final Mean"), linewidth = 1) +
    geom_hline(aes(yintercept = FinalMean + (3 * FinalSD), color = "3SD Boundary"), linetype = "dashed") +
    geom_hline(aes(yintercept = FinalMean - (3 * FinalSD), color = "3SD Boundary"), linetype = "dashed") +
    facet_wrap(~Sample, scales = "free") +
    scale_color_manual(values = c(
      "Included" = "black",
      "Outlier" = "red",
      "Final Mean" = "blue",
      "3SD Boundary" = "darkgreen"
    )) + 
    scale_shape_manual(values = c("Included" = 1, "Outlier" = 4)) +
    labs(
      title = "Ranked Outlier Selection",
      subtitle = "Exactly the most distant points flagged as Red Xs"
    ) +
    theme_minimal() +
    theme(legend.position = "bottom")
)

p <- ggplot(final_df, aes(x = Index, y = Value)) +
  geom_point(aes(color = Status, shape = Status), size = 3) +
  geom_hline(aes(yintercept = FinalMean, color = "Final Mean"), linewidth = 1) +
  geom_hline(aes(yintercept = FinalMean + (3 * FinalSD), color = "3SD Boundary"), linetype = "dashed") +
  geom_hline(aes(yintercept = FinalMean - (3 * FinalSD), color = "3SD Boundary"), linetype = "dashed") +
  facet_wrap(~Sample, scales = "free") +
  scale_color_manual(values = c(
    "Included" = "black",
    "Outlier" = "red",
    "Final Mean" = "blue",
    "3SD Boundary" = "darkgreen"
  )) + 
  scale_shape_manual(values = c("Included" = 1, "Outlier" = 4)) +
  theme_minimal()

ggsave("ranked_outliers.png", p, width = 10, height = 6, dpi = 300)



# Verification in console
table(final_df$Sample, final_df$Status)

