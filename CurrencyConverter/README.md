#Requirements:

##4 currencies are supported: BYN, EUR, RUB, USD. Exchange rates are static, hard code.


For example:<br>
 - BYN/EUR = 2.0<br>
 - EUR/BYN = 1.99<br>
 - RUB/EUR = 10.0<br>
 - EUR/RUB = 9.09<br>

##On the application launch screen, display the application name, author name and version.

###There are 2 screens: number input screen, currency selection screen.


The first screen contains 2 fields for entering the numeric value of the currency.
Each field contains the entered number with two decimal places, the flag of the corresponding country, the currency code and a button to go to the currency selection screen.
For example, if a user enters a numeric value for the currency BYN, the value in EUR is updated when each new character (number) is entered.
Also, the user can enter the EUR value to get back to BYN.
The currency selection screen contains a list of available currencies.
For each currency, the flag of the corresponding country and the currency code are displayed.<br>

Design at the discretion of the candidate.<br>

 * Optional 0: Add a filter search to the 2nd screen.<br>
 * Optional 1: Use a local JSON file instead of static hard code courses.
 * Optional 2: Dark Mode, Landscape mode.
 * Optional 3: Instead of static hard code values, use an API that provides course values.
