library(magick)
library(imager)
library(tensorflow)

Tumor_prediction <- function(image_path, model_path) {
  # Read image from .tif file using magick
  img <- image_read(image_path)
  # Resize image to 150x150
  img_resized <- image_resize(img, "150x150")
  # Convert image to a matrix and normalize pixel values to range [0, 1]
  img_mat <- as.numeric(image_data(img_resized))
  img_mat_norm <- (img_mat - min(img_mat)) / (max(img_mat) - min(img_mat))
  # Reshape matrix to match input shape of the model
  img_reshaped <- array_reshape(img_mat_norm, c(1, 150, 150, 3))
  
  # Load the model
  require(keras)
  model <- load_model_hdf5(model_path)
  
  # Make predictions using the model
  predictions <- predict(model, img_reshaped, verbose = 0)
  
  # Check if there is tumor or not and return the result
  if (mean(predictions > 0.5) > 0.5) {
    return("Tumor vorming gedetecteerd")
  } else {
    return("Geen tumorvorming gedetecteerd")
  }
  
  # Return the predicted class
  return(predicted_class)
}



Tumor_prediction(image_path = "~/HU_ILC_DS2/DataScience2/vrije_opdracht/training_data/kaggle_3m/test_data/TCGA_HT_A61B_19991127/TCGA_HT_A61B_19991127_43.tif", model_path = "~/HU_ILC_DS2/DataScience2/vrije_opdracht/getraind_model/AI_model.h5")
