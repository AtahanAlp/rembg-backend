FROM python:3.12

# Create the directory where rembg expects the model
RUN mkdir -p /root/.u2net/

# download this https://github.com/danielgatis/rembg/releases/download/v0.0.0/u2net.onnx
# copy model to avoid unnecessary download
COPY u2net.onnx /root/.u2net/u2net.onnx

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5100

# Use Gunicorn as the production server
CMD ["gunicorn", "-b", "0.0.0.0:5100", "-w", "1", "app:app"]