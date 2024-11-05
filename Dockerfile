# Usa una imagen base oficial de Python
FROM python:3.11

# Crea un usuario no root
RUN useradd -m myuser

# Establece el directorio de trabajo
WORKDIR /app

# Cambia a ese usuario
USER myuser

# Copia solo el archivo de requerimientos primero para aprovechar el cacheo de capas
COPY requirements.txt .

# Cambia los permisos de lectura para el archivo de requerimientos
RUN chmod 444 requirements.txt

# Instala las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto del código
COPY --chown=myuser:myuser .manage.py .
RUN chmod 444 manage.py

# Cambia los permisos del directorio de trabajo para que no se pueda escribir
RUN chmod -R a-w /app

# Expon el puerto (si es necesario)
EXPOSE 8000

# Comando para ejecutar el servidor de Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

