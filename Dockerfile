# Use the official Jupyter Notebook base image
FROM jupyter/base-notebook:latest

# Switch to root user to install PostgreSQL client
USER root

# Install PostgreSQL client
RUN apt-get update && apt-get install -y postgresql-client

# Switch back to the notebook user
USER $NB_UID

# Install psycopg2-binary
RUN pip install psycopg2-binary

# Expose the default Jupyter Notebook port
EXPOSE 8888

# Start Jupyter Notebook
CMD ["start-notebook.sh"]
