# Data values 
x <- c(101.2, 90.0, 99.0, 102.0, 103.0, 100.2, 89.0, 98.1, 101.5, 102.0)
n <- length(x)

# Mean and sample standard deviation (as in paper)
xm <- mean(x)
sigma <- sd(x)

# R values from Peirce's table for n = 10
R_values <- c(
  "1_doubtful" = 1.878,
  "2_doubtful" = 1.570,
  "3_doubtful" = 1.380
)

# Function to compute outliers for a given R
peirce_outliers <- function(x, xm, sigma, R) {
  deviation <- abs(x - xm)
  max_dev <- sigma * R
  deviation > max_dev # Boolean Value
}

# Identify outliers for each case
out_1 <- peirce_outliers(x, xm, sigma, R_values[1])
out_2 <- peirce_outliers(x, xm, sigma, R_values[2])
out_3 <- peirce_outliers(x, xm, sigma, R_values[3])

# Plots
plot_peirce <- function(x, xm, sigma, R, outliers, title) {
  max_dev <- sigma * R
  plot(
    x,
    pch = 16,
    col = ifelse(outliers, "red", "black"),
    ylab = "Pressure (kPa)",
    xlab = "Measurement Index",
    main = title
  )
  abline(h = xm, lwd = 2, lty = 2)
  abline(h = xm + max_dev, lty = 3)
  abline(h = xm - max_dev, lty = 3)
}

plot_peirce(
  x, xm, sigma, R_values[1], out_1,
  "Peirce Criterion\n1 Doubtful Observation"
)
plot_peirce(
  x, xm, sigma, R_values[2], out_2,
  "Peirce Criterion\n2 Doubtful Observations"
)
plot_peirce(
  x, xm, sigma, R_values[3], out_3,
  "Peirce Criterion\n3 Doubtful Observations"
)

