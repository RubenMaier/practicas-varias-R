#############
# VIDEO 2.1 #
#############

# asi se escribe un comentario

# si selecciono toda la suma y preciono CTRL+ENTER en la consola de abajo me muestra el resultado
4 + 8

# idem que antes, en este caso con un exponente
4^2

# asi asginamos valores a variables (tambien debemos ejecutarlo con CTRL+ENTER para que se lleve a cabo
# la asginaci?n porque sino en el siguiente paso nos va a tirar error cuando queramos ver su valor)
x <- 86

# asi llamamos a la variable (para ver el valor, igual que antes CTRL+ENTER selecionando la linea)
x

# aplicando todo lo que vimos hasta ahora, seleciona y ejecuta todo el bloque:
oficina <- 7
platzi <- 1
transporte <- 1.5
tiempo_al_dia <- oficina + platzi + transporte
tiempo_al_dia

#############
# VIDEO 2.2 #
#############

# Tipos de datos y estructuras de datasets
# usamos un datasets de "mtcars" y lo instalamos en la consola con el siguiente comando:
# install.packages("mtcars")
# tambien una vez escrito esto en la consola lo ejecutamos selecionandolo y precionando CTRL+ENTER
# como no est? mas habilitado... lo vamos a tener que sacar del github de la profe


# STR significa ESTRUCTURA, y as? vinculamos los datos a nuestra hoja de R. Notese que cuando ejecutamos
# en la consola nos muestra todos los datos y la definici?n del tipo de dato que son
# tener en cuenta que si no conocemos el dataset podemos preguntarle en la consola tipiando:
# ?mtscars
# e inmediatamente nos mostrara en la solapa help a tu derecha una biblioteca con informaci?n de la libreria
str(mtcars)

# verifiquemos el tipo de estructura de una variable, por ejemplo la de "vs"
# nos va a decir integer, pero si analizamos el dato, solo vale 1 o 0, entonces es booleano o logica
class(mtcars$vs)

# por lo tanto debemos convertir la variable a una estructura mas adecuada
# eso se hace asignandole a la variable el valor convertido con as.logical(tabla$variable)
mtcars$vs = as.logical(mtcars$vs)
class(mtcars$vs)

#############
# VIDEO 2.3 #
#############

# veamos la estructura de nuestro dataset economia naranja (orangeec)
str(orangeec)

# summary: nos muestra el resumen de un dataset
# nos sale una tabla con valores estadisticos que pueden ser util como el "mean" que es la "media"
summary(orangeec)
summary(mtcars)

# paso de libras a kilos la variable "wt" del dataset mtcars
wt <- (mtcars$wt * 1000)/2
wt

# y ahora hacemos lo mismo pero cambiandolo en el dataset posta
# para eso transformo esa variable del dataset, en todo el dataset, y me almaceno ese cambio
# en una nueva variable
str(mtcars)
mtcars.new <- transform(mtcars, wt= wt*1000/2)
mtcars.new
summary(mtcars.new)

# para modificar wt directamente en el modelo de datos puedo usar el siguiente codigo
# mtcars$wt = (mtcars$wt*1000)/2

#############
# VIDEO 2.4 #
#############

#veamos como se crean vectores y como se opera con ellos
tiempo_platzi <- c(25,5,10,15,10)
tiempo_lecturas <- c(30,10,5,10,15)
tiempo_aprendizaje <- tiempo_platzi + tiempo_lecturas
tiempo_aprendizaje

# ahora vectores pero con caracteres
dias_aprendizaje <- c("Lunes", "Martes", "Miercoles", "Jueves", "Viernes")

# ahora vecotres boleanos o logicos
dias_que_estuvimos_mas_de_20_min <- c(TRUE, FALSE, FALSE, TRUE, TRUE)
dias_que_estuvimos_mas_de_20_min

# ?cuanto tiempo adicional tenemos cada dia para nuestro aprendizaje?
total_tiempo_platzi <- sum(tiempo_platzi)
total_tiempo_platzi
total_tiempo_lecturas <- sum(tiempo_lecturas)
total_tiempo_lecturas
total_tiempo_adicional <- total_tiempo_platzi + total_tiempo_lecturas
total_tiempo_adicional

# no responde a la pregunta, nos da un total, yo quiero para cada d?a, entonces, necesito trabajar con matrices
# matriz de fila X columna
# creamos la matriz cruda
matriz_tiempo <- matrix(c(tiempo_platzi, tiempo_lecturas), nrow=2, byrow=TRUE)
# creamos los nombres para las filas y las columnas
dias <- dias_aprendizaje
actividad <- c("tiempo platzi", "tiempo lecturas")
# le asignamos los nombres de fila y columna a la matriz
colnames(matriz_tiempo) <- dias
rownames(matriz_tiempo) <- actividad
# la observamos
matriz_tiempo
# respondamos d?a por d?a los resultados. Esto se logra sumando todas las filas de una misma columna
colSums(matriz_tiempo)

#############
# VIDEO 2.5 #
#############

# aprendamos mas agregando una actividad nueva como oir un podcast cada día, es decir, nueva fila
# debemos usar rbind que nos a?ade un nuevo vector como fila a nuestra matriz
matriz_final <- rbind(matriz_tiempo, c(10,15,30,5,0))
colSums(matriz_final)

# si queremos ver solo un elemento especifico, le decimos la fila y la columna
matriz_final[1,5]

#### desafio, agregar una nueva columna, ejemplo, los sabados ####
# notese que en ves de usar rbind, debo usar cbind (donde r es row y c es column)
matriz_super_final <- cbind(matriz_final, c(10,15, 0))
matriz_super_final

#############
# VIDEO 2.5 #
#############

# comparadores para buscar datos
# ?? !? < <= > >= !
# | = 0
# %in% = significa que algo est? en el dataset
# exploremos el dataset de mtcars

# busquemos los autos que tengan menos de 6 cilindros 
# (ojo la coma al final indica que busque en todo el dataset/observaciones/filas)
mtcars[mtcars$cyl < 6,]

# que paises tienen un PBI mayor o igual a 15000 en todos los paises?
orangeec[orangeec$GDP.PC>=15000,]

# que paises tienen un aporte a su PBI a travez de la economia naranja (economias creativas) 
# menor o igual al 2% del PBI de ese pais
orangeec[orangeec$Creat.Ind...GDP<=2,]

# hagamos subsettings
# paises que tienen mas de un 80% de su poblaccion con acceso a internet y ademas mas del 4,5%
# de su PBI está destinado en educación
neworangeec <- subset(orangeec, Internet.penetration...population > 80
                      & Education.invest...GDP >= 4.5)
neworangeec

# ahora queremos saber el porcentaje de PBI que aportan por economía naranja aquellos
# paises que tienen mas de un 80% de su poblaccion con acceso a internet y ademas mas del 4,5%
# de su PBI está destinado en educación
neworangeec <- subset(orangeec, Internet.penetration...population > 80
                                 & Education.invest...GDP >= 4.5,
                      select = Creat.Ind...GDP)
neworangeec

# instalamos el paquete "plyr" por consola con el comando:
# install.packages("plyr")
# library(plyr)
rename(orangeec, c("Creat.Ind...GDP" = "AporteEcNja"))
                   
#############
# VIDEO 2.5 #
#############

nivel_curso <- c("Basico", "Intermedio", "Avanzado")
nivel_curso

# nos muestra los primeros 6 datos del dataset
head(mtcars)

# nos muestra los ultimos 6 datos del dataset
tail(mtcars)

# instalo el siguiente paquete:
# install.packages("dplyr")
# library(dplyr)
# los textos son fct = factor, y los numericos son dbl = double
glimpse(orangeec)

# listas, almacenamos cualquier tipo de estructura
new_vector <- 1:8
new_matriz <- matrix(1:9, ncol=3)
dataframe <- mtcars[1:4,] 
new_vector
new_matriz
dataframe
new_lista <- list(new_vector, new_matriz, dataframe)
new_lista

#################
# VIDEO 3.1-2-3 #
#################

# grafico de barras -> ordenado por tamaÃ±o de barra de mayor a menor
# histograma -> sigue el patron del eje
# grafica de disperción o scatter plot -> solo numeros en cada eje y los puntos no se pueden unir
# grafica de lineas -> idem que antes pero sin las restricciones
# box plot -> rectangulo compuesto por 1/4, 1/2 y 3/4, con minimo y maximo extendidos por una linea

#############
# VIDEO 3.4 #
#############

# grafica de dispercion
# primeros parametros son los valores de los puntos
# segundos parametros son los nombres del eje
# tercer parametro es el titulo de la grafica de dispercion
plot(mtcars$mpg ~ mtcars$cyl,
     xlab="cilindros", ylab="millas por galon",
     main="relacion cilindos y millas por galon")

plot(mtcars$mpg ~ mtcars$hp,
     xlab="caballos de fuerza", ylab="millas por galon",
     main="relacion caballos de fuerza y millas por galon")

plot(orangeec$Unemployment ~ orangeec$Education.invest...GDP,
     xlab="Inversion en educacion (% del PBI)", 
     ylab="Desempleo",
     main="relacion inversion en educacion y desempleo")

plot(orangeec$GDP.PC ~ orangeec$Creat.Ind...GDP,
     xlab="Aporte economia naranja al PIB(%)", 
     ylab="PIB per capita",
     main="relacion economia naranja y PIB per capita")

#############
# VIDEO 3.5 #
#############

# histogramas

# instalo ggplot2, con:
# install.packages("ggplot2")
# library(ggplot2)
# bin = binwidth = ancho de cada barra
qplot(mtcars$hp,
      geom="histogram", # la geometria
      xlab="caballos de fuerza",
      main="Carros segun caballos de fuerza")

ggplot(mtcars, 
          aes(x=hp) # aes hace referencia a estetica
       ) + 
  geom_histogram() +
  labs(x="caballos de fuerza", 
       y="cantidad de carros",
       title="caballos de fuerza en carros seleccionados") +
  theme(legend.position = "none") + #posicion de la leyenda
  theme(panel.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

# vamos a cambiarle el ancho a las barras, a 30 opciones por barra
ggplot(mtcars, aes(x=hp)) + 
  geom_histogram(binwidth = 30) +
  labs(x="caballos de fuerza", 
       y="cantidad de carros",
       title="caballos de fuerza en carros seleccionados") +
  theme(legend.position = "none") +
  theme(panel.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

ggplot() +
  geom_histogram(data=mtcars,
                 aes(x=hp),
                 fill="blue", # barritas de color azul
                 color="red", # y un contorno rojo
                 binwidth = 20)  +
  labs(x="caballos de fuerza", 
       y="cantidad de carros",
       title="caballos de fuerza en carros seleccionados") +
  xlim(c(80,280)) + # ajustamos el eje x con un limite y lo defino por un contenedor
  theme(legend.position = "none") +
  theme(panel.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

#############
# VIDEO 3.6 #
#############

# seguimos con histogramas pero estudiando el dataset de economia naranja

ggplot() +
  geom_histogram(data=orangeec,
                 aes(x=GDP.PC), # queremos ver la variable PIB PER CAPITA
                 fill="blue", # barritas de color azul
                 color="red", # y un contorno rojo
                 binwidth = 2000)  + # ancho de banda de a 2000 dolares
  labs(x="pib per cápita", 
       y="cantidad de paises",
       title="PIB per capita en apises de latam") +
  theme(legend.position = "none") +
  theme(panel.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
# Aporte de 20.000 dolares solo 2 paises aportan 
  
# ¿como está distribuido el aporte de la economía naranja al PIB en cada país?
ggplot() +
  geom_histogram(data=orangeec,
                 aes(x=Creat.Ind...GDP), # queremos ver la variable PIB PER CAPITA
                 fill="blue", # barritas de color azul
                 color="red", # y un contorno rojo
                 binwidth = 1)  + # porque el valor está dado en porcentaje (vamos de 1% por barra)
  labs(x="aporte economía naranja al pib(%)", 
       y="cantidad de paises",
       title="Contribución economía naranja al PIB en paises de latam") +
  theme(legend.position = "none") +
  theme(panel.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
# 1 pais que aporta el 6% y otro el 7% al PIB

# distribucción de frecuencias en cuanto a la penetración de internet
ggplot() +
  geom_histogram(data=orangeec,
                 aes(x=Internet.penetration...population), # queremos ver la variable PIB PER CAPITA
                 fill="red", # barritas de color azul
                 color="yellow", # y un contorno rojo
                 binwidth = 5)  + # valor en porcentaje (vamos de a 5% por barra)
  labs(x="penetración de internet como (%) de la población", 
       y="cantidad de paises",
       title="penetración de internet en paises de latam") +
  theme(legend.position = "none") +
  theme(panel.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
# el 60% de un pais tiene acceso a internet
# paises con pentración del 80% hay 2
# no hay paises con un 55% de penetración de internet

# idem pero con todas las barras/labels porcentuadas
ggplot() +
  geom_histogram(data=orangeec,
                 aes(x=Internet.penetration...population), # queremos ver la variable PIB PER CAPITA
                 fill="red", # barritas de color azul
                 color="yellow", # y un contorno rojo
                 binwidth = 5)  + # valor en porcentaje (vamos de a 5% por barra)
  labs(x="penetración de internet como (%) de la población", 
       y="cantidad de paises",
       title="penetración de internet en paises de latam") +
  xlim(30,100) + # numeramos del 30% al 100% 
  ylim(0,4) + # ponemos en el eje Y valores del 0 al 4
  scale_x_continuous(breaks = seq(30,100,by=5)) + # le colocamos valores a cada barras (que van del 30% al 100%) cada 5%
  theme(legend.position = "none") +
  theme(panel.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())


#############
# VIDEO 3.7 #
#############

# trabajamos con graficos tipo box-plot
# las variables en un box-plot deben ser: categorica en X, numerica en Y

# no requiere paquetes con:
boxplot(mtcars$hp,
        ylab="caballos de fuerza",
        main="caballos de fuerza en carros mtcars")

# vemos que hay un minimo por encima de 50 caballos de fuerza
# hay un maximo un por encima de 250 caballos de fuerza
# hay un out layer, alejado de la mayoria... Si miramos en la base es el Maserati de 335 caballos de fuerza

# usamos el paquete ggplot que tiene mas funcionalidades
ggplot(mtcars,
       aes(x=as.factor(cyl), # convierto el valor de x que es numerico a categorico para que no tire error y nos muestre 3 box-plot y no 1 solo
           y=hp,
           fill=cyl)) + # las cajitas queremos que se nos rellene con la información de los cilindros
  geom_boxplot() + 
  labs(x="cilindros",
       y="caballos de fuerza",
       title="caballos de fuerza según cilindros en mtcars") +
  theme(legend.position = "none") +
  theme(panel.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())


# notece que el boxplot de 4 cilindros esta muy oscuro y no se visualiza bien la mediana, cambiemos eso:
ggplot(mtcars,
       aes(x=as.factor(cyl), # convierto el valor de x que es numerico a categorico para que no tire error y nos muestre 3 box-plot y no 1 solo
           y=hp,
           fill=cyl)) + # las cajitas queremos que se nos rellene con la información de los cilindros
  geom_boxplot(alpha=0.6) + # alpha me vuelve medio transparente todo los boxplot
  labs(x="cilindros",
       y="caballos de fuerza",
       title="caballos de fuerza según cilindros en mtcars") +
  theme(legend.position = "none") +
  theme(panel.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
# cajas alargadas nos incinuan datos desviados
# cajas chatas nos incinuan datos homogeneos (ceranos al promedio)

# probemos ahora para los tipos de caja que eran de tipo 1 o 0
# de paso convertimos a true o false
mtcars$am = as.logical(mtcars$am)

# con true o false no queda muy lindo, lo ideal es que diga "automatico" o "manual" segun la caja que tenga...
mtcars$am <- factor(mtcars$am, 
                    levels=c(TRUE, FALSE), #lavels son los valores propios del dataset
                    labels=c("Manual", "Automatico")) #labels son los valores que quiero que queden etiquetados

# y finalmente lo vemos como...
ggplot(mtcars,
       aes(x=am, y=mpg,
           fill=am)) +
  geom_boxplot() +
  labs(x="tipo de caja",
       y="millas por galón",
       title="millas por galón según tipo de caja (mtcars)") +
  theme(legend.position = "none") +
  theme(panel.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

#############
# VIDEO 3.7 #
#############

# en el dataset de economia naranja la unica variable categorica es la de "nombre de pais"
# el resto es toda numérica, entonces no podriamos hacer ningun cruce entre campos numéricos

# hagamos una clasificacion de paises segun el PIB, que grupos de paises están por encima de un promedio y cual por debajo
# mean nos calcula el promedio de una variable
economia <- mean(orangeec$GDP.PC)
economia

# hacemos uso del paquete "dplyr" para lo siguiente:
orangeec <- orangeec %>% # al mismo dataset que lo vamos a pasar a...
  mutate(economia_fuerte = ifelse(GDP.PC < economia, # el dataset va a mutar y se va a agrandar
                                  "Por debajo del promedio",
                                  "sobre el promedio de pib per capita"))
# si observamos el dataset, ahora notaremos que añadimos una variable nueva que es de tipo categorica
# esta va a tener el resultado de la mutación que hicimos antes

ggplot(orangeec, aes(x=economia_fuerte, 
                     y=Creat.Ind...GDP, 
                     fill=economia_fuerte)) +
  geom_boxplot(alpha=0.4) +
  labs(x="tipo de pais",
       y="aporte economia naranja al pib",
       title="aporte economia naranja en pib paises latam con alto y bajo pib per capita") +
  theme(legend.position = "none") +
  theme(panel.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

# penetracion de internet en estos dos tipos de paises:
ggplot(orangeec, aes(x=economia_fuerte, 
                     y=Internet.penetration...population, 
                     fill=economia_fuerte)) +
  geom_boxplot(alpha=0.4) +
  labs(x="tipo de pais",
       y="penetración de internet(%)",
       title="penetración de internet en paises latam con aalto y bajo pib per cápita") +
  theme(legend.position = "none") +
  theme(panel.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

# quartil uno (Q1) (25% de los datos)
# Q2 o mediana (el 50% de los datos)
# Q3 (75% de los datos)
# Rango intercuartílico RIC (Q3-Q1)
# Se consideran atípicos(outliers) los valores inferiores a (Q1-1.5·RIC) o superiores a (Q3+1.5·RIC)
# Se pueden considerar valores extremadamente atípicos aquellos que exceden (Q1- 3·RIC) o (Q3+3·RIC)

#############
# VIDEO 3.8 #
#############

# grafica de disperción
# usamos ggplot

ggplot(mtcars,
       aes(hp, mpg)) # primero x=hp y despues y=mpg















































































