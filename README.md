# Хавронич Евгений Алексеевич, БПИ226
---
## Вариант 35
### Условие:
Разработать программу, определяющую корень уравнения x<sup>4</sup>−x<sup>3</sup>−2.5 = 0 **методом хорд** с точностью от 0,001 до 0,00000001 в диапазоне [1;2]. Если диапазон некорректен, то подобрать корректный диапазон.
### Программы:
[Программы на ассемблере с комментариями размещены здесь](Files/RISKFILES)

Требование перед запуском программ: Должны быть поставлены следующие настройки во вкладке settings, так как используются глобальные метки:

![](Files/Settings.png)
## Программа была написана на оценку 10.

### Требования на 10:
- Программа разбита на несколько единиц компиляции. Программа состоит из 3 единиц компиляции: основная программа в [WithTheInput.asm](Files/RISKFILES/WithTheInput.asm), подпрограмма [FuncFile.asm](Files/RISKFILES/FuncFile.asm) и библиотека макросов [macrolib.s](Files/RISKFILES/macrolib.s).
- Подпрограмма вывода составляет унифицированный модуль, используемый повторно как в программе, осуществляющей ввод исходных данных ([WithTheInput.asm](Files/RISKFILES/WithTheInput.asm)), так и в программе, осуществляющей тестовое покрытие ([TestProgram.asm](Files/RISKFILES/TestProgram.asm)). Так как в тестовой программе требуется ввод лишь точности с типом double, а RISK-V предусматривает загрузку чисел данного типа только через метки .data, то подпрограмма ввода разработана только для программы с вводом через клавиатуру. В тестовой же программе мы ограничились лишь загрузкой данных из секции .data в регистр.
- Макросы выделены в отдельную автономную библиотеку [macrolib.s](Files/RISKFILES/macrolib.s).

### Требования на 9:
- Добавлено в программу использование макросов для реализации ввода и вывода данных. Используется библиотека [macrolib.s](Files/RISKFILES/macrolib.s), из неё применяются read_double, print_double, F, RetX, IsCorrectInterv, print_str и newline.
- Обернул в макросы уже ранее разработанные подпрограммы read_double, print_double, F, RetX, IsCorrectInterv и добавил к другим макросам в библиотеку [macrolib.s](Files/RISKFILES/macrolib.s). За счёт обёртывания макросами подпрограмм, убрал из них сохранение ra регистра на стек.
- Все макросы поддерживают повторное использование с различными массивами и другими параметрами.

### Требования на 8:
- Разработанные подпрограммы поддерживают многократное использование с различными наборами исходных данных, включая возможность подключения различных исходных и результирующих массивов( в нашем случае – чисел).
- Реализовано автоматизированное тестирование за счет создания
дополнительной тестовой программы [TestProgram.asm](Files/RISKFILES/TestProgram.asm) , осуществляющей прогон подпрограмм с различными тестовыми данными (вместо ввода данных). От пользователя требуется проверить, установлены ли правильные настройки, описанные в самом начале, и запустить файл – выходные данные будут выведены в консоль после выполнения тестов. Осуществлён прогон тестов, обеспечивающих покрытие различных ситуаций. Результаты выполнения тестовой программы представлены в таблице ниже.
<table>
    <tr>
        <th>№ теста</th>
        <th>Какую ситуацию проверяет</th>
        <th>Введённая точность</th>
        <th>Полученный X </th>
    </tr>
    <tr>
        <td>1</td>
        <td>Точность равна правой границе диапозона</td>
        <td>0.001</td>
        <td>1.6048396218292138</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Точность чуть меньше правой границы диапозона</td>
        <td>0.0009</td>
        <td>1.6048396218292138</td>
    </tr>
    <tr>
        <td>3</td>
        <td>Произвольная точность из нужного диапозона</td>
        <td>0.000005</td>
        <td>1.6048428005867157</td>
    </tr>
    <tr>
        <td>4</td>
        <td>Точонсть чуть больше левой границы диапозона</td>
        <td>0.00000002</td>
        <td>1.6048428005867157</td>
    </tr>
    <tr>
        <td>5</td>
        <td>Точность равна правой границе диапозона</td>
        <td>0.00000001</td>
        <td>1.6048427993525602</td>
    </tr>
    <tr>
        <td>6</td>
        <td>Точность меньше правой границы диапозона</td>
        <td>0.000000009</td>
        <td>Accuracy should be in the range of 0.001 to 0.00000001</td>
    </tr>
</table>

- Для дополнительной проверки корректности вычислений осуществлены аналогичные тестовые прогоны с использованием существующих библиотек и языка программирования высокого
уровня C++ (см. [Code.cpp](Files/CppCode/Code.cpp)). Для этого была взята реализация данного метода, описанная на его странице в [WikiPedia](https://ru.wikipedia.org/wiki/%D0%9C%D0%B5%D1%82%D0%BE%D0%B4_%D1%85%D0%BE%D1%80%D0%B4#%D0%A0%D0%B5%D0%B0%D0%BB%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D1%8F).

Результаты выполнения тестовой программы на языке С++, разность выводимых значений в сравнении с тестовой программой на RISK-V и корректность результатов тестовой программы представлены в таблице ниже.

<table>
    <tr>
        <th>№ теста</th>
        <th>Какую ситуацию проверяет</th>
        <th>Введённая точность</th>
        <th>Полученный X в C++ файле </th>
        <th>Полученный X в RISK-V файле </th>
        <th>Разность значений в сравнении с результатом аналогичного теста в программе RISK-V </th>
        <th>Удовлетворяет ли разность значений заданной точности (должна получиться меньше заданной точности) </th>
    </tr>
    <tr>
        <td>1</td>
        <td>Точность равна правой границе диапозона</td>
        <td>0.001</td>
        <td>1.6048503172221644</td>
        <td>1.6048396218292138</td>
        <td>0.0000106953929506</td>
        <td>Да</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Точность чуть меньше правой границы диапозона</td>
        <td>0.0009</td>
        <td>1.6048503172221644</td>
        <td>1.6048396218292138</td>
        <td>0.0000106953929506</td>
        <td>Да</td>
    </tr>
    <tr>
        <td>3</td>
        <td>Произвольная точность из нужного диапозона</td>
        <td>0.000005</td>
        <td>1.6048427993525115</td>
        <td>1.6048428005867157</td>
        <td>0.0000000012342042</td>
        <td>Да</td>
    </tr>
    <tr>
        <td>4</td>
        <td>Точонсть чуть больше левой границы диапозона</td>
        <td>0.00000002</td>
        <td>1.6048427993525115</td>
        <td>1.6048428005867157</td>
        <td>0.0000000012342042</td>
        <td>Да</td>
    </tr>
    <tr>
        <td>5</td>
        <td>Точность равна правой границе диапозона</td>
        <td>0.00000001</td>
        <td>1.6048427993525115</td>
        <td>1.6048427993525602</td>
        <td>0.0000000000000487</td>
        <td>Да</td>
    </tr>
    <tr>
        <td>6</td>
        <td>Точность меньше правой границы диапозона</td>
        <td>0.000000009</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
    </tr>
</table>

### Требования на 6-7:
- В программе использовались подпрограммы с передачей
аргументов через параметры. Часть из них при необходимости отображалась после передачи на стек. 
    - В print_double передавался 1 параметр. 
    - В read_double параметров не передавалось.
    - В IsCorrectInterv передавался 1 параметр, сохраняемый на стеке.
    - В F передавался 1 параметр.
    - В RetX все 3 передаваемых параметра сохранялись на стек.
    - В FindX передаётся 1 параметр, который сохраняется на стек.
    - Во всех подпрограммах на стеке сразу же сохранялся ra, а позже возвращался.
- Внутри подпрограмм используются локальные переменные, которые при компиляции отображауются на стек или находятся во временных регистрах.
    - В RetX сохраняются на стеке две локальные переменные (значения функций), а также изменённые параметры. Остальные переменные, которые хранят промежуточные вычисления, хранятся во временных регистрах.
    - в print_double локальных переменных нет, использовался лишь передаваемый параметр.
    - В read_double локальных переменных нет.
    - В IsCorrectInterv 2 локальные переменные находятся во временных регистрах (границы допустимого диапозона точности).
    - в F локальные переменные – это промежуточные вычисления, которые хранятся во временных регистрах.
    - в FindX 2 локальные переменные сохраняются на стек.
- В местах вызова функции в файле [WithTheInput.asm](Files/RISKFILES/WithTheInput.asm) , где пользователь сам вводит с консоли данные, добавлены комментарии, описывающие передачу фактических параметров и перенос возвращаемого результата. Также отмечены, какая переменная или результат какого выражения соответствует тому или иному фактическому параметру.

### Требования на 4-5:
- Приведено решение задачи на ассемблере. Для запуска программы необходимо проверить настройки, описанные в начале отчёта, открыть и запустить файл [WithTheInput.asm](Files/RISKFILES/WithTheInput.asm). После чего ввести десятичное число через точку (пример:0.0001) и нажать enter.
- Ввод данных осуществляется с клавиатуры. Вводимые данные представляют из себя double число, определяющее, с какой точностью будет вычислен корень уравнения x<sup>4</sup>−x<sup>3</sup>−2.5 = 0 **методом хорд**
- Вывод данных осуществляется на дисплей. Выводимыми данными является double число – корень уравнения x<sup>4</sup>−x<sup>3</sup>−2.5 = 0, полученного **методом хорд**.
- В программе присутствуют комментарии, поясняющие сложные моменты в коде.

## Общий алгоритм программы.
1. Вызов макроса **read_double**. В качестве аргумента получаем регистр, куда будет передано double число. В этом макросе происходит вызов ввода double числа.
2. Вызов подпрограммы **FindX**. В неё передаётся double число в качестве параметрав в fa0, который мы получили ранее. Если число попадает в нужный нам диапозон, то по завершению работы, подпрограмма вернёт в fa0 корень уравнения, если число не попадает в нужный нам диапозон, то подпрограмма выводит строчку о непопадании в диапозон и делает вызов завершения программы.
    1. Вызов **IsCorrectInterv**. Аргументы аналогичны тем, что передавались в FindX. Если число попадает в отрезок 0,001 до 0,00000001, то макрос успешно завершает свою работу и выполнение программы продолжается дальше. Если не попадает, то программа завершается и выводится сообщение о причине завершения программы.
    2. Вызов **RetX**. Первый аргумент аналогичен передававшимся в последних двух описанных функциях, также передаётся регистр, в котором размещена левая граница искомого корня;регистр, в котором размещена правая граница искомого корня, и регистр, куда должен быть передан корень уравнения. Так как границы у нас предопределены и не изменяются (1 и 2), то проверку на корректность границ мы не делаем.
3. Вызов **ArrayFromElemLessSum**. Аргументы: сумма элементов на чётных индексах массива А, размер массива А, указатель на массив А, указатель на массив B, регистр, куда запишется размер заполненного массива B. В данном макросе происходит запись элементов массива А в массив B, которые меньше переданной в качестве первого аргумента суммы. Из макроса в последний параметр записывается размер заполненного массива.
7. вызов newline, print_str и print_double – эти макросы формируют вывод нашего корня.

### Описание метода решения задачи (нахождения корня уравнения методом хорд)

Пусть x<sub>1</sub>,x<sub>2</sub> — абсциссы концов хорды, f(x)=0 — уравнение функции, решаемое методом секущих. Найдём коэффициенты k и b из системы уравнений

![](Files/descr/1.png)

Вычтем из первого уравнения второе:

![](Files/descr/2.png)

затем найдём коэффициенты k и b:

![](Files/descr/3.png)

тогда

![](Files/descr/4.png)

Уравнение принимает вид

![](Files/descr/5.png)

Таким образом, теперь можем найти первое приближение к корню, полученное методом секущих:

![](Files/descr/6.png)

Теперь возьмём координаты x<sub>2</sub> и x<sub>3</sub> и повторим все проделанные операции, найдя новое приближение к корню. Таким образом, итерационная формула метода секущих имеет вид:

![](Files/descr/7.png)

Данную формулу мы и будем использовать для итерационного алгоритма нахождения корня:
x<sub>i</sub>-ым будет являться a; x<sub>i + 1</sub>-ым будет являться b.
Как только разница между a и b становится меньше нужной нам точности, то возвращаем b – то есть x<sub>i + 1</sub>.
### Таблица прогона полного тестового покрытия

<table>
    <tr>
        <th>№ теста</th>
        <th>Какую ситуацию проверяет</th>
        <th>Введённая точность</th>
        <th>Полученный X </th>
    </tr>
    <tr>
        <td>1</td>
        <td>Точность равна правой границе диапозона</td>
        <td>0.001</td>
        <td>1.6048396218292138</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Точность чуть меньше правой границы диапозона</td>
        <td>0.0009</td>
        <td>1.6048396218292138</td>
    </tr>
    <tr>
        <td>3</td>
        <td>Произвольная точность из нужного диапозона</td>
        <td>0.000005</td>
        <td>1.6048428005867157</td>
    </tr>
    <tr>
        <td>4</td>
        <td>Точонсть чуть больше левой границы диапозона</td>
        <td>0.00000002</td>
        <td>1.6048428005867157</td>
    </tr>
    <tr>
        <td>5</td>
        <td>Точность равна правой границе диапозона</td>
        <td>0.00000001</td>
        <td>1.6048427993525602</td>
    </tr>
    <tr>
        <td>6</td>
        <td>Точность меньше правой границы диапозона</td>
        <td>0.000000009</td>
        <td>Accuracy should be in the range of 0.001 to 0.00000001</td>
    </tr>
    <tr>
        <td>7</td>
        <td>Точность больше левой границы диапозона</td>
        <td>0.002</td>
        <td>Accuracy should be in the range from 0.001 to 0.00000001</td>
    </tr>
</table>


![](https://i.pinimg.com/564x/2c/34/a7/2c34a7356f7f07f5f867dfe8af1a4758.jpg)