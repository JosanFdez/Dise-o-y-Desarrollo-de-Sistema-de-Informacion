# Diseno-y-Desarrollo-de-Sistema-de-Informacion
En este repositorio se encuentra la gestión de un sistema de información para el desarrollo de un comercio, concretamente para una licoreria

Sistema de Información de Licorería: "La Botella Infinita"

# Proyecto: Práctica de Inteligencia de Negocio - "Análisis Predictivo mediante Clasificación"

## Descripción General

Este proyecto tiene como objetivo aplicar diferentes algoritmos de aprendizaje automático para resolver problemas de clasificación en tres casos específicos:

1. **Predicción de aprobación de créditos:** Determinar si un crédito será aprobado o no basado en datos demográficos y financieros de los solicitantes.
2. **Predicción de una segunda cita:** Identificar si los participantes de citas rápidas decidirán tener una segunda cita.
3. **Predicción del tipo de enfermedad eritemato-escamosa:** Diagnosticar enfermedades basadas en características clínicas e histopatológicas.

Cada problema aborda un conjunto de datos específico y aplica algoritmos de clasificación avanzados para encontrar patrones y generar predicciones precisas.

---

## Problemas Resueltos

### Problema 1: Predicción de Aprobación de Créditos

- **Objetivo:** Predecir si un crédito será aprobado o no.
- **Conjunto de Datos:** 32,581 instancias con 12 variables.
- **Tratamiento de Datos:**
  - Imputación de valores faltantes (mediana, moda y media).
  - Eliminación de valores anómalos.
  - Ajuste de desbalanceo de clases.
- **Algoritmos Utilizados:**
  - Árbol de Decisión
  - Random Forest
  - K-Nearest Neighbors (k-NN)
  - Stochastic Gradient Descent (SGD)
  - Naive Bayes
- **Resultados:** Random Forest obtuvo el mejor desempeño con un AUC de 0.937 y F1-Score de 0.827.

### Problema 2: Predicción de una Segunda Cita

- **Objetivo:** Predecir si habrá una segunda cita entre participantes de citas rápidas.
- **Conjunto de Datos:** 8,378 instancias con 121 variables.
- **Tratamiento de Datos:**
  - Imputación de valores faltantes.
  - Escalado de variables sensibles a la escala (min-max normalization).
  - Ajuste de desbalanceo de clases.
- **Algoritmos Utilizados:**
  - Árbol de Decisión
  - Random Forest
  - Gradient Boosted Trees
  - K-Nearest Neighbors (k-NN)
  - Stochastic Gradient Descent (SGD)
  - Naive Bayes
- **Resultados:** Gradient Boosted Trees demostró ser el más efectivo para este problema.

### Problema 3: Predicción del Tipo de Enfermedad Eritemato-Escamosa

- **Objetivo:** Diagnosticar el tipo de enfermedad basándose en 34 características (12 clínicas y 22 histopatológicas).
- **Conjunto de Datos:** Incluye 6 clases de enfermedades.
- **Tratamiento de Datos:**
  - Normalización de variables.
  - Análisis de relevancia de atributos.
  - Reducción de dimensionalidad en pruebas.
- **Algoritmos Utilizados:**
  - Random Forest
  - Naive Bayes
  - SGD
  - Árbol de Decisión
  - k-NN
- **Resultados:** Random Forest proporcionó la mejor clasificación, demostrando alta capacidad predictiva y robustez.

---

## Tecnologías y Herramientas Utilizadas

- **KNIME Analytics Platform:** Para el preprocesamiento y la aplicación de algoritmos de clasificación.
- **Lenguaje de Programación:** Soporte para Python y R en análisis adicionales.
- **Documentación:** Secciones detalladas en el PDF sobre configuración, flujos de trabajo y resultados obtenidos.

---

## Requisitos del Sistema

- **Software:**
  - KNIME 4.6 o superior.
  - Python 3.x (para extensiones opcionales).
- **Hardware:**
  - Procesador con al menos 4 núcleos.
  - 8 GB de RAM (16 GB recomendados para grandes volúmenes de datos).

---

## Contribuciones

Contribuciones son bienvenidas. Para colaborar:
1. Crea un fork del repositorio.
2. Realiza tus modificaciones.
3. Envía un pull request detallando los cambios.

---

## Licencia

Este proyecto está licenciado bajo la [MIT License](LICENSE).

---

Si necesitas más detalles sobre los flujos de trabajo o los resultados, consulta el documento principal o contáctame directamente.


