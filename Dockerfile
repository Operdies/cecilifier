FROM mcr.microsoft.com/dotnet/sdk:6.0.100-preview.7-alpine3.13-amd64 as build
COPY . /app/
WORKDIR /app
RUN dotnet restore
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/sdk:6.0.100-preview.7-alpine3.13-amd64 as runtime
WORKDIR /app
COPY --from=build /app/out/ ./
COPY --from=build /app/Cecilifier.Web/wwwroot/lib/node_modules/codemirror/ wwwroot/lib/node_modules/codemirror/
ENTRYPOINT ["dotnet", "Cecilifier.Web.dll"]

#sudo docker build . -t cecilifier/6.0
#sudo docker run -d -p 5000:5000 cecilifier/6.0