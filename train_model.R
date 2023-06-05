# "~/HU_ILC_DS2/DataScience2/vrije_opdracht/training_data/kaggle_3m/train_data"

train_model <- function(train_dir, model_path) {
  # Load required packages
  library(keras)
  
  # Set image size and batch size
  img_size <- c(256, 256)
  batch_size <- 32
  
  # Create data generator for training data
  train_datagen <- image_data_generator(rescale = 1/255)
  train_data <- flow_images_from_directory(train_dir,
                                           target_size = img_size,
                                           batch_size = batch_size,
                                           class_mode = "binary",
                                           seed = 123,
                                           generator = train_datagen)
  
  # Define the model architecture
  model <- keras_model_sequential() %>%
    layer_conv_2d(filters = 32, kernel_size = c(3, 3), activation = "relu", input_shape = c(256, 256, 3)) %>%
    layer_max_pooling_2d(pool_size = c(2, 2)) %>%
    layer_dropout(0.25) %>%
    layer_conv_2d(filters = 64, kernel_size = c(3, 3), activation = "relu") %>%
    layer_max_pooling_2d(pool_size = c(2, 2)) %>%
    layer_dropout(0.25) %>%
    layer_conv_2d(filters = 128, kernel_size = c(3, 3), activation = "relu") %>%
    layer_max_pooling_2d(pool_size = c(2, 2)) %>%
    layer_dropout(0.25) %>%
    layer_flatten() %>%
    layer_dense(units = 512, activation = "relu") %>%
    layer_dropout(0.5) %>%
    layer_dense(units = 1, activation = "sigmoid")
  
  # Compile the model
  model %>% compile(
    optimizer = optimizer_rmsprop(lr = 0.0001, decay = 1e-6),
    loss = "binary_crossentropy",
    metrics = c("accuracy")
  )
  
  # Train the model
  history <- model %>% fit(
    train_data,
    steps_per_epoch = as.integer(ceil(train_data$n / batch_size)),
    epochs = 10
  )
  
  # Save the model
  save_model_hdf5(model, model_path)
  
  # Return the model history
  return(history)
}


train_model("~/HU_ILC_DS2/DataScience2/vrije_opdracht/training_data/kaggle_3m/train_data", "~/HU_ILC_DS2/DataScience2/vrije_opdracht/getraind_model")
