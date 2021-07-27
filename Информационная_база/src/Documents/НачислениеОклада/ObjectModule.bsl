
Процедура ОбработкаПроведения(Отказ, Режим)
	//{{__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!

	// регистр ЗаработнаяПлата
	Движения.ЗаработнаяПлата.Записывать = Истина;
	Движение = Движения.ЗаработнаяПлата.Добавить();
	Движение.Сторно = Ложь;
	Движение.ВидРасчета = ПланыВидовРасчета.Начисления.Оклад;
	Движение.ПериодДействияНачало = НачалоМесяца(Дата);
	Движение.ПериодДействияКонец = КонецМесяца(Дата);
	Движение.ПериодРегистрации = Дата;
	Движение.Сотрудник = Сотрудник;
	Движение.РасчетныеДанные = Сумма;
	
	Движения.Записать();
	
		//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЗаработнаяПлатаДанныеГрафика.РабочийДеньПериодДействия КАК Норма,
		|	ЗаработнаяПлатаДанныеГрафика.РабочийДеньФактическийПериодДействия КАК Факт,
		|	ЗаработнаяПлатаДанныеГрафика.РасчетныеДанные КАК РасчетныеДанные
		|ИЗ
		|	РегистрРасчета.ЗаработнаяПлата.ДанныеГрафика(Регистратор = &Регистратор) КАК ЗаработнаяПлатаДанныеГрафика";
	
	Запрос.УстановитьПараметр("Регистратор",Ссылка);
	
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если НЕ РезультатЗапроса.Пустой() Тогда
		
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		ВыборкаДетальныеЗаписи.Следующий();	
		Оклад = ВыборкаДетальныеЗаписи.РасчетныеДанные * ВыборкаДетальныеЗаписи.Факт / ВыборкаДетальныеЗаписи.Норма;
		Движение.Сумма = Оклад;
		Движения.ЗаработнаяПлата.Записать();
		
	КонецЕсли;
	
		
	//}}КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА


	//}}__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
КонецПроцедуры
