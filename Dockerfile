# Usa una imagen base oficial de Python
FROM python:3.9-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia solo el archivo de requerimientos primero para aprovechar el cacheo de capas
COPY requirements.txt .

# Instala las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto del código, excluyendo los archivos especificados en .dockerignore
COPY manage.py .

# Expone el puerto en el que corre la aplicación
EXPOSE 8000

# Comando para ejecutar el servidor de Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
