install.packages("e1071")
install.packages("imager")
install.packages("tools")
install.packages("tiff")
install.packages("EBImage")
install.packages("magick")


library(e1071)
library(imager)
library(tools)
library(readr)
library(tiff)
library(magick)

train_model <- function(data_path) {
  # Lees de data in vanuit de mappen
  image_data <- data.frame()
  for (patient_folder in list.files(data_path)) {
    patient_path <- file.path(data_path, patient_folder)
    image_files <- list.files(patient_path, pattern = "*.tif", full.names = TRUE)
    
    # Lees de afbeeldingen en de masks in
    images <- list()
    masks <- list()
    for (image_file in image_files) {
      file_name <- basename(image_file)
      mask_file <- gsub("\\.tif$", "_mask.tif", file_name)
      
      image <- tiff::readTIFF(image_file)
      mask <- tiff::readTIFF(file.path(patient_path, mask_file))
      
      images[[file_name]] <- as.raster(image) %>% 
        colormap("gray") %>% 
        image_convert() %>% 
        image_scale("256x256") %>% 
        image_data("matrix")
      
      masks[[file_name]] <- as.raster(mask) %>% 
        magick::colormap("gray") %>% 
        magick::image_convert() %>% 
        magick::image_scale("256x256") %>% 
        magick::image_data("matrix")
    }
    
    # Voeg de afbeeldingen en de masks toe aan de data
    patient_data <- data.frame(
      image = unlist(images),
      mask = unlist(masks),
      patient_id = patient_folder
    )
    image_data <- rbind(image_data, patient_data)
  }
  
  # Maak het trainings- en testingsdataframe
  set.seed(123)
  index <- sample(nrow(image_data), size = 0.8 * nrow(image_data))
  train_data <- image_data[index, ]
  test_data <- image_data[-index, ]
  
  # Train het machine learning-model
  model <- svm(mask ~ ., data = train_data, kernel = "linear")
  
  # Voorspel de mask voor de test data
  predicted_mask <- predict(model, newdata = test_data)
  
  # Bereken de accuraatheid
  accuracy <- sum(predicted_mask == test_data$mask) / nrow(test_data)
  
  # Return het model en de accuraatheid
  return(list(model = model, accuracy = accuracy))
}

train_model(data_path = "~/HU_ILC_DS2/DataScience2/vrije_opdracht/training_data/kaggle_3m/train_data")





classify_tumor(patient_path = "~/HU_ILC_DS2/DataScience2/vrije_opdracht/training_data/kaggle_3m/train_data")

detect_tumor(image_folder = "~/HU_ILC_DS2/DataScience2/vrije_opdracht/training_data/kaggle_3m/TCGA_CS_4914_19960909", 
             annotations_file = "vrije_opdracht/training_data/kaggle_3m/data.csv")
