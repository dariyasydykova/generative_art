# load packages needed to run this code
library(ggplot2)
library(dplyr)
library(tidyr)
library(cowplot)
library(gganimate)

# code used from this page on stackoverflow:
# https://stackoverflow.com/questions/8082429/plot-a-heart-in-r
# I cleaned it up

# make a data frame for background colors
df_background <- data.frame(
  xmin = -20, ymin = -20, xmax = 20, ymax = 20, x = 0, y = 0,
  fill = c("#ffaaaa", "#e37070", "#c7004c", "#8f1537"),
  state = c(1, 2, 3, 4)
)

# generate coordinates for a heart
df <- data.frame(t = seq(0, 2 * pi, by = 0.01))

heart <-
  df %>%
  mutate(
    x = 16 * sin(t)^3,
    y = 13 * cos(t) - 5 * cos(2 * t) - 2 * cos(3 * t) - cos(4 * t)
  )

p_heart <- 
  ggplot() +
  geom_rect(
     data = df_background,
     ggplot2::aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill = fill, group = 1, x = 1, y = 1),
     color = NA
  ) +
  geom_polygon(
    data = heart,
    ggplot2::aes(
      x = x,
      y = y,
    ),
    fill = "white",
    alpha = 0.5
  ) +
  transition_states(state, transition_length = 5, state_length = 0) +
  scale_fill_identity() +
  scale_y_continuous(limits = c(-20, 20)) +
  scale_x_continuous(limits = c(-20, 20)) +
  coord_fixed(expand = FALSE) +
#  annotate("text", label = "Dearest Eric,\nHappy Valentine's Day!\nYou fill my life with so much joy, laughter,\nkindness, adventures, and love!\nI love you from the bottom of my heart, and\nI'm very happy to have you.\nYour beet,\nDariya", x = 0, y = -2, color = "white", size = 6) +
  theme_void() 

# animate
animate(p_heart, 
        device = "png",
        width = 600, 
        height = 600)

# save as gif
anim_save("heart.gif")
