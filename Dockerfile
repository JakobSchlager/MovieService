FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app
COPY ["MovieService/MovieService/MovieService.csproj", "MovieService/MovieService/"]
RUN dotnet restore MovieService/MovieService/MovieService.csproj
COPY . .
WORKDIR "/app/MovieService/MovieService/"
RUN dotnet build MovieService.csproj -c Release -o /out

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS runtime
WORKDIR /app
COPY --from=build /out ./
ENTRYPOINT ["dotnet", "MovieService.dll"]