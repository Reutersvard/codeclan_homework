# Helper function to select plot type -------------------------------------
# Could be extended with more plot types.


geom_selector <- function(df, geom) {
  if (geom == "Bar chart") {
    return(
      ggplot(df, aes(year, total_sales, fill = developer)) + 
        geom_col(position = "dodge")
    )
  } else {
    return(
    ggplot(df, aes(year, total_sales, colour = developer)) + 
      geom_line() +
      geom_point()
    )
  }
}
