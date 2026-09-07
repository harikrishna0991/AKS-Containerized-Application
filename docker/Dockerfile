FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

COPY application/CrudApi/CrudApi.csproj application/CrudApi/

RUN dotnet restore application/CrudApi/CrudApi.csproj

COPY application/CrudApi/ application/CrudApi/

WORKDIR /src/application/CrudApi

RUN dotnet publish CrudApi.csproj \
    -c Release \
    -o /app/publish \
    --no-restore


FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final

WORKDIR /app

ENV ASPNETCORE_URLS=http://+:8080

EXPOSE 8080

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "CrudApi.dll"]