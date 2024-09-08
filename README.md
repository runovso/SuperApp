#  SuperApp
Тестовое задание для второго этапа отбора на стажировку в компанию VK
## Описание
Приложение для iPhone/iPad. В приложении присутствуют несколько мини-приложений, которые отображаются в различных форматах списка и могут быть запущены во весь экран.
>⚠️ Важно: для работы погодного API ([OpenWeather](https://openweathermap.org/current "Перейти к документации")) требуется VPN 🤷‍♂️
## Функционал
#### Мини-приложения:
- Текущая геолокация
- Погода
#### Модульность:
- Каждое мини-приложение оформлено как отдельный SPM-пакет
#### Режимы отображения:
- Восемь ячеек на экране, взаимодействие с приложениями отключено
- Две ячейки на экране, пользователь может взаимодействовать с приложением
#### Адаптивность:
- Приложение смотрится одинаково хорошо на iPhone и iPad
- На планшетах поддерживается ландшафтный режим
- В ландшафтном режиме ячейки таблицы следуют readableContentGuide для лучшей читаемости и внешнего вида
- Поддерживается светлая и тёмная темы
## Стек
- iOS 14+
- Swift 5
- UIkit, без сторибордов
- Swift Package Manager
- CoreLocation
- MapKit
- GCD
- URLSession
- Figma для иконки
## Notes
- По заданию ячейки должны занимать 100% ширины экрана, но в моём исполнении на iPad в горизонтальной ориентации ячейка привязывается к readableContentGuide у contentView. Сделал так, потому что в режиме отображения ячейки в полэкрана она слишком сильно растягивалась.
