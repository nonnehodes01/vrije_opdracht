# "~/HU_ILC_DS2/DataScience2/vrije_opdracht/training_data/kaggle_3m/train_data"

install.packages("keras")
library(keras)

train_model <- function(train_dir, model_path) {
  library(keras)
  
  # Set up data generators
  train_datagen <- image_data_generator(rescale = 1/255)
  train_generator <- flow_images_from_directory(
    train_dir, 
    train_datagen, 
    target_size = c(150, 150), 
    batch_size = 32, 
    class_mode = "categorical"
  )
  
  # Define the model architecture
  model <- keras_model_sequential()
  model %>%
    layer_conv_2d(filters = 32, kernel_size = c(3, 3), activation = "relu", input_shape = c(150, 150, 3)) %>%
    layer_max_pooling_2d(pool_size = c(2, 2)) %>%
    layer_conv_2d(filters = 64, kernel_size = c(3, 3), activation = "relu") %>%
    layer_max_pooling_2d(pool_size = c(2, 2)) %>%
    layer_conv_2d(filters = 128, kernel_size = c(3, 3), activation = "relu") %>%
    layer_max_pooling_2d(pool_size = c(2, 2)) %>%
    layer_conv_2d(filters = 128, kernel_size = c(3, 3), activation = "relu") %>%
    layer_max_pooling_2d(pool_size = c(2, 2)) %>%
    layer_flatten() %>%
    layer_dense(units = 512, activation = "relu") %>%
    layer_dense(units = 108, activation = "softmax")
  
  # Compile the model
  model %>% compile(
    loss = "categorical_crossentropy",
    optimizer = optimizer_rmsprop(lr = 1e-4),
    metrics = "acc"
  )
  
  # Train the model
  model %>% fit_generator(
    train_generator, 
    steps_per_epoch = 100, 
    epochs = 30
  )
  
  # Save the model
  save_model_hdf5(model, model_path)
}


train_model("~/HU_ILC_DS2/DataScience2/vrije_opdracht/training_data/kaggle_3m/train_data", "~/HU_ILC_DS2/DataScience2/vrije_opdracht/getraind_model/AI_model.h5")


