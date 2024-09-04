## Assumptions and Decisions

API Usage: The app uses the OpenWeatherMap API to fetch weather data.

State Management: The project uses the Provider package for state management.

Favorite Locations: Users can save favorite locations locally using shared_preferences.

DarkMode: User can switch to Light Mode or Dark Mode

## Project Structure
```
- `lib/`: Contains the Dart code for the application.
  - `models/`: Definitions of data models.
  - `constants/`: Contains API Keys
  - `view/`: UI screens and widgets.
  - `providers/`: State management for the application.
  - `services/`: Services for external API communication.
  - `utils/`: Common Helpers.
- `assets/`: Images and other assets used by the application.
```
## API Usage

The app uses the OpenWeatherMap API to fetch current weather and forecast data:

- **Current Weather API**: Used to get real-time weather data.
- **Forecast API**: Used to retrieve a 5-day weather forecast.(Since the free version was not giving 7-day forecast)

API keys are stored in `lib/constants.api_keys.dart` and must be set before building the project.

## Assumptions

- The app assumes all users have an active internet connection for real-time data fetching.
- Weather data is considered accurate as provided by the OpenWeatherMap API.

## Decisions

- **Provider for State Management**: Chosen for its simplicity and effectiveness in managing app state.
- **SharedPreferences for Local Storage**: Used for storing favorite locations due to its ease of use and integration in Flutter apps.
