# Tumor Classificatie AI Model

Dit AI-model is ontworpen om tumoren te classificeren op basis van invoerbeelden. Het maakt gebruik van deep learning-technieken om de kenmerken van tumorfoto's te analyseren en voorspellingen te doen over hun classificatie.

__Aan de slag__

_Installatie_

- Kloon de repository naar uw lokale machine.
- Bereid uw tumorfoto voor op classificatie. Zorg ervoor dat deze in een ondersteund formaat is. 
- Voer het script classify_tumor.py uit en geef het pad naar de tumorfoto op als argument:

Tumor_prediction(image_path = "pad/naar/afbeelding", model_path = "pad/naar/getraind/model")

- Het AI-model zal de afbeelding verwerken en een classificatievoorspelling geven, waarbij wordt aangegeven of de tumor aanwezig is of niet.


__Modeltraining__ 

Als u geïnteresseerd bent in het trainen van uw eigen tumorclassificatiemodel, volg dan deze stappen:
- Bereid uw dataset van tumorfoto's voor. Zorg ervoor dat de dataset correct is gelabeld met overeenkomstige klassen (bijv. tumor, niet-tumor).
- Voer het script train_model.py uit en geef het pad naar uw dataset op als argument:

train_model("pad/naar/waar/getraind/model/moet/kom")

- Het script zal de dataset voorbewerken, opdelen in trainings- en validatiesets en het model trainen met behulp van deep learning-technieken.
- Nadat de training is voltooid, wordt het model opgeslagen als een .h5-bestand en is het klaar voor latere classificatie.

__Licentie__
Dit project is gelicentieerd onder de MIT-licentie.

__Contact__
Voor de dataset en/of het getrainde model kunt u contact opnemen met [nonne.hodes@gmail.com].
