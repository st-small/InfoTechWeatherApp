# InfoTechWeatherApp
Выполнение приложения согласно техническому заданию 
1. Створити додаток використовуючи UIKit.
2. Архітектура - MVP, MVVM, Clean Architecture на ваш розсуд.
3. UI з використанням стандартних елементів.
4. Додаток повинен отримати список міст з json файлу (city_list). Список міст
 відобразити у таблиці.
5. В лівій частині комірки відображаємо зображення
 (https://infotech.gov.ua/storage/img/Temp3.png) для парних і друге зображення
 (https://infotech.gov.ua/storage/img/Temp1.png) для не парних комірок, а з правої
 назву міста. Зображення отримуємо запитом і кешуємо его.
6. На екрані списку міст реалізуємо пошук за містом з фільтрацією цього ж
 списку.
7. За натиском на місто відбувається перехід до детального екрану з
 відображенням погоди у даному місті (запит до сервісу OpenWeather). У
 верхній частині відображаємо карту з точкою координат міста (карта займає
 третину висоти екрану). У нижній частині відображаємо такі дані:
- Опис;
- Поточна температура повітря;
- Мін., макс. температура повітря;
- Вологість повітря;
- Швидкість вітру.
Також, створити на даному екрані, паралакс ефект (схожий як у стандартному додатку Apple TV, відео з демонстрацією додається).

## Краткое описание
Данное приложение состоит из двух экранов:
1. Отображение списка городов по заготовленному перечню файла `city_list.json`, реализован поиск по городам.
2. Детальный просмотр выбранного населенного пункта для отображения карты с его расположением и минимальной информацией о текущей погоде.

Приложение работает с нативным модулем `CoreLocation` для получения геопозиции пользователя и определения города и страны.

Приложение работает с сетью:
Запрос на получение прогноза погоды средствами сервиса "openweathermap"

* Приложение полностью написано без использования сторибордов (все реализовано в ксибах).
* В приложении нет ни одной зависимости (cocoapods, carthage, spm).
* Работа с сетью реализована исключительно нативными средствами (с использованием `async/await`).
* В приложении реализована адаптация под разные размеры экранов (от 4 до 6 дюймов). 
* Реализованы индикаторы загрузки для понимания процесса пользователем (`SpinnerViewController`).
* Использованы расширения для кастомизации настроек: UIImage, Alert.
* Реализован кастомный NavigationController.

## Архитектура

Приложение разделено на модули (в данном случае, это модуль списка городов и модуль детального просмотра). Каждый модуль состоит из: 

### Assembly
Элемент, который отвечает за создание модуля, подготовку модели, подготовку вью, связывание их, имеет публичное свойство 'view', которое отдается вызывающему модулю, для правильной подготовки и показу модуля.

### Model (ViewModel)
Может включать в себя логику интерактора, презентера, вью модели и пр. (если таковые не представлены в проекте или выбран сокращенный архитектурный подход). Основной задачей модели является подготовка данных, работа с ними, передача данных о вью.

### View (ViewController)
Является классическим элементом отображения данных и работе с действиями пользователя. Имея связь с моделью, динамически реагирует на изменения модели, обновляя свое состояние, обращается к модели если контекст (действия пользователя) требуют обновления (изменения) данных.