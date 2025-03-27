FROM nginx:1.27.0
# CMD ["echo", "Hello from command file"]
ENTRYPOINT [ "echo", "Hello from ENTRYPOINT" ]
