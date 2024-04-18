   10 REM Company Database Program
   20 DIM employees$(100), emails$(100), phones$(100), salaries(100)
   30 DIM customers$(100), customerEmails$(100), customerPhones$(100), numPurchases(100), purchaseItems$(100, 100), purchaseQuantities(100, 100), purchaseCosts#(100, 100)

   50 FOR i = 1 TO 100
   60   FOR j = 1 TO 100
   70     purchaseItems$(i, j) = ""
   80     purchaseQuantities(i, j) = 0
   90     purchaseCosts#(i, j) = 0
  100   NEXT j
  110 NEXT i

  120 numEmployees = 0
  121 numCustomers = 0

  122 REM Main program
  123 INPUT "Company Name: " company$

  124 PROC_loadData(numEmployees, numCustomers, company$, employees$(), emails$(), phones$(), salaries(), customers$(), customerEmails$(), customerPhones$(), numPurchases(), purchaseItems$(), purchaseQuantities(), purchaseCosts#())

  133 REPEAT
        REM PRINT numEmployees
  140   PRINT "    MAIN MENU"
  150   PRINT "1.) Employees"
  160   PRINT "2.) Sales"
  170   PRINT "3.) Quit"
  180   PRINT
  190   PRINT "Choice";
  200   INPUT choice

  210   IF choice = 1 THEN
  220     REM Employees menu
  230     REPEAT
  240       IF numEmployees > 0 THEN
  250         FOR i = 1 TO numEmployees
  260           PRINT employees$(i) + " <" + emails$(i) + ">  Phone: " + phones$(i) + " Salary: $" + STR$(salaries(i))
  270         NEXT i
  280       ELSE
  290         GOTO 310
  300       ENDIF

  310       INPUT "(A)dd Employee, or (M)ain Menu? " subChoice$
  330       IF subChoice$ = "A" OR subChoice$ = "a" THEN
  340         REM Add Employee
  350         IF numEmployees < 100 THEN
  360           numEmployees = numEmployees + 1
  370           INPUT "Name: " employees$(numEmployees)
  390           INPUT "Email: " emails$(numEmployees)
  410           INPUT "Phone: " phones$(numEmployees)
  430           INPUT "Salary: " salaries(numEmployees)
  450           REM PRINT "Employee added."
  451           GOTO 210
  460         ELSE
  470           PRINT "Maximum number of employees reached."
  480           GOTO 310
  481         ENDIF
  490       ELSEIF subChoice$ <> "M" AND subChoice$ <> "m" THEN
  500           PRINT "Invalid choice. Please try again."
  510           GOTO 310
  511         ENDIF
  520       UNTIL subChoice$ = "M" OR subChoice$ = "m"
  530       GOTO 133
  540     ENDIF
  590   ELSEIF choice = 2 THEN
  600       REM Sales menu
  610       REPEAT
  620         INPUT "(A)dd Customer, Enter a (S)ale, (V)iew Customer, or (M)ain Menu? " subChoice$
  640         IF subChoice$ = "A" OR subChoice$ = "a" THEN
  650           REM Add Customer
  660           numCustomers = numCustomers + 1
  670           REM PRINT "Enter customer details:"
  680           INPUT "Name: " customers$(numCustomers)
  700           INPUT "Email: " customerEmails$(numCustomers)
  720           INPUT "Phone: " customerPhones$(numCustomers)
  740           REM PRINT "Customer added successfully."
  741           GOTO 620
  750         ELSEIF subChoice$ = "S" OR subChoice$ = "s" THEN
  760             REM Sale Entry
  770             IF numCustomers = 0 THEN
  780               PRINT "Error: No Customers."
  790               GOTO 620
  800             ENDIF

  810             REM PRINT "Customers:"
  820             FOR i = 1 TO numCustomers
  830               PRINT i; ".) "; customers$(i)
  840             NEXT i

  850             PRINT "Choice";
  860             INPUT customerChoice
  870             IF customerChoice >= 1 AND customerChoice <= numCustomers THEN
  880               customer = customerChoice
  890               numPurchases(customer) = numPurchases(customer) + 1
  900               INPUT "Item: "purchaseItems$(customer, numPurchases(customer))
  920               INPUT "Quantity: "purchaseQuantities(customer, numPurchases(customer))
  940               INPUT "Cost: "purchaseCosts#(customer, numPurchases(customer))
  960               REM PRINT "Sale entered successfully."
  961               GOTO 620
  970             ELSE
  980               PRINT "Invalid choice. Sale not entered."
  981               GOTO 620
  990             ENDIF
 1000           ELSEIF subChoice$ = "V" OR subChoice$ = "v" THEN
 1010               REM View Customer
 1020               IF numCustomers = 0 THEN
 1030                 PRINT "Error: No Customers."
 1040                 GOTO 620
 1050               ENDIF

 1070               FOR i = 1 TO numCustomers
 1080                 PRINT i; ".) "; customers$(i)
 1090               NEXT i

 1100               PRINT "Choice";
 1110               INPUT customerChoice
 1120               IF customerChoice >= 1 AND customerChoice <= numCustomers THEN
 1130                 customer = customerChoice
                      REM @%=&20208
 1140                 PRINT customers$(customer), "<" + customerEmails$(customer) + ">  Phone: " + customerPhones$(customer)
 1141                 PRINT
 1150                 PRINT "Order History"
 1160                 PRINT "Item                   Price   Quantity   Total"
 1170                 FOR purchase = 1 TO numPurchases(customer)
 1180                   PRINT purchaseItems$(customer, purchase); SPC(23 - LEN(purchaseItems$(customer, purchase)));
 1190                   PRINT STR$(purchaseCosts#(customer, purchase)); SPC(8 - LEN(STR$(purchaseCosts#(customer, purchase))));
 1200                   PRINT STR$(purchaseQuantities(customer, purchase)); SPC(11 - LEN(STR$(purchaseQuantities(customer, purchase))));
 1210                   PRINT STR$((purchaseQuantities(customer, purchase) * purchaseCosts#(customer, purchase)))
 1220                 NEXT purchase
 1221                 PRINT
 1221                 GOTO 620
 1230               ELSE
 1240                 PRINT "Invalid choice. Cannot view customer."
 1241                 GOTO 620
 1250               ENDIF
 1260             ELSEIF subChoice$ <> "M" AND subChoice$ <> "m" THEN
 1270                 PRINT "Invalid choice. Please try again."
 1271                 GOTO 620
 1280               ENDIF
 1290             UNTIL subChoice$ = "M" OR subChoice$ = "m"
 1291             GOTO 133
 1300           ENDIF
 1310         ENDIF
 1311       ENDIF
 1320     ELSEIF choice = 3 THEN PROC_saveData(company$, employees$(), emails$(), phones$(), salaries(), customers$(), customerEmails$(), customerPhones$(), numPurchases(), purchaseItems$(), purchaseQuantities(), purchaseCosts#())
 1330       QUIT
 1340     ENDIF
 1350   ENDIF
 1360 ENDIF

 1370 REM Function to load data from company$.dat file
 1380 DEF PROC_loadData(RETURN numEmployees, RETURN numCustomers, RETURN company$, employees$(), emails$(), phones$(), salaries(), customers$(), customerEmails$(), customerPhones$(), numPurchases(), purchaseItems$(), purchaseQuantities(), purchaseCosts#())
 1400 file = OPENUP(company$+".dat")
 1410 IF file <> 0 THEN
        CLOSE#file
 1420   file = OPENIN(company$ + ".dat")
 1430   numEmployees = VAL(GET$#file)
 1440   FOR i = 1 TO numEmployees
 1450     employees$(i) = GET$#file
 1460     emails$(i) = GET$#file
 1470     phones$(i) = GET$#file
 1480     salaries(i) = VAL(GET$#file)
 1490   NEXT i
 1500   numCustomers = VAL(GET$#file)
 1510   FOR i = 1 TO numCustomers
 1520     customers$(i) = GET$#file
 1530     customerEmails$(i) = GET$#file
 1540     customerPhones$(i) = GET$#file
 1550     numPurchases(i) = VAL(GET$#file)
 1560     FOR j = 1 TO numPurchases(i)
 1570       purchaseItems$(i, j) = GET$#file
 1580       purchaseQuantities(i,j) = VAL(GET$#file)
 1590       purchaseCosts#(i, j) = VAL(GET$#file)
 1600     NEXT j
 1610   NEXT i
 1630 ELSE
 1640   REM PRINT "File not found. Creating a new one."
 1650   file = OPENOUT(company$+".dat")
 1660 ENDIF
 1670 CLOSE#file
 1680 ENDPROC

 1690 REM Function to save data to company$.dat file
 1700 DEF PROC_saveData(RETURN company$, employees$(), emails$(), phones$(), salaries(), customers$(), customerEmails$(), customerPhones$(), numPurchases(), purchaseItems$(), purchaseQuantities(), purchaseCosts#())
 1720 file = OPENOUT(company$+".dat")
 1730 REM OPENOUT company$ + ".dat" AS file
 1740 PRINT# file, STR$(numEmployees)
 1750 FOR i = 1 TO numEmployees
 1760   PRINT#file, employees$(i)
 1770   PRINT#file, emails$(i)
 1780   PRINT#file, phones$(i)
 1790   PRINT#file, STR$(salaries(i))
 1800 NEXT i
 1810 PRINT#file, STR$(numCustomers)
 1820 FOR i = 1 TO numCustomers
 1830   PRINT#file, customers$(i)
 1840   PRINT#file, customerEmails$(i)
 1850   PRINT#file, customerPhones$(i)
 1860   PRINT#file, STR$(numPurchases(i))
 1870   FOR j = 1 TO numPurchases(i)
 1880     PRINT#file, purchaseItems$(i, j)
 1890     PRINT#file, STR$(purchaseQuantities(i, j))
 1900     PRINT#file, STR$(purchaseCosts#(i, j))
 1910   NEXT j
 1920 NEXT i
 1930 PRINT "File saved sucessfully. Goodbye..."
 1940 CLOSE#file
 1950 ENDPROC