# ==============================================================================
# Dockerfile para Prospector C&D (Flask)
# ==============================================================================

FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Copiamos primero requirements.txt para aprovechar el caché de Docker
# (ver explicación completa en el Dockerfile de Como-arroz, mismo principio)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# La app corre en el puerto 5000 (confirmado en tu README: "disponible en
# http://127.0.0.1:5000/"), a diferencia de Como-arroz que usa 8000 (Django)
EXPOSE 5000

# app.py ya usa Application Factory de Flask; asumimos que corre con
# app.run() internamente escuchando en 0.0.0.0 para que Docker pueda
# exponerlo — si tu app.py tiene app.run(debug=True) sin host="0.0.0.0",
# avísame para ajustarlo, porque si no, no será alcanzable desde fuera
# del contenedor aunque el contenedor esté corriendo bien.
CMD ["python", "app.py"]
