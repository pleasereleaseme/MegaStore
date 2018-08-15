FROM microsoft/dotnet:2.1-runtime AS base
WORKDIR /app

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY MegaStore.SaveSaleHandler/MegaStore.SaveSaleHandler.csproj MegaStore.SaveSaleHandler/
COPY MegaStore.Helper/MegaStore.Helper.csproj MegaStore.Helper/
RUN dotnet restore MegaStore.SaveSaleHandler.csproj
COPY . .
WORKDIR /src/MegaStore.SaveSaleHandler
RUN dotnet build MegaStore.SaveSaleHandler.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish MegaStore.SaveSaleHandler.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "MegaStore.SaveSaleHandler.dll"]
