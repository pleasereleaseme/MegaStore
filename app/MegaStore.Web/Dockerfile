FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY ["MegaStore.Web/MegaStore.Web.csproj", "MegaStore.Web/"]
RUN dotnet restore "MegaStore.Web/MegaStore.Web.csproj"
COPY . .
WORKDIR "/src/MegaStore.Web"
RUN dotnet build "MegaStore.Web.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "MegaStore.Web.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "MegaStore.Web.dll"]
