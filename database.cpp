#include "database.h"

Database::Database(QObject *parent) : QObject(parent)
{

}

Database::~Database()
{

}


void Database::connectToDataBase()
{

    if(!QFile("/Users/philippogorodnikov/base_project/" DATABASE_NAME).exists()){
        qDebug() << "Файла БД нет!";
    } else {
        this->openDataBase();
    }
}



bool Database::openDataBase()
{

    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setHostName(DATABASE_HOSTNAME);
    db.setDatabaseName("/Users/philippogorodnikov/base_project/" DATABASE_NAME);
    if(db.open()){
        return true;
    } else {
        return false;
    }
}


void Database::closeDataBase()
{
    db.close();
}



bool Database::insertIntoTable(const QString &title, const QString &descr, const QString &date)
{
    QSqlQuery query;

    query.prepare("INSERT INTO " TABLE " (title, descr, date) "
                  "VALUES (:Title, :Descr, :Date)");
    query.bindValue(":Title", title);
    query.bindValue(":Descr", descr);
    query.bindValue(":Date", date);

    // После чего выполняется запросом методом exec()
    if(!query.exec()){
        qDebug() << "error insert into " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;

}

bool Database::updateRecord(const QString &id, const QString &title, const QString &descr, const QString &date)
{
    QSqlQuery query;

    query.prepare("UPDATE Notes SET title = '"+ title +"', descr = '"+ descr +"', date = '"+ date +"' WHERE id = " + id);
    /*query.bindValue(":Title", title);
    query.bindValue(":Descr", descr);
    query.bindValue(":Date", date);
    query.bindValue(":Id", id);*/
    // После чего выполняется запросом методом exec()
    if(!query.exec()){
        qDebug() << "error update " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;

}


/* Метод для удаления записи из таблицы
 * */
bool Database::removeRecord(const int id)
{
    // Удаление строки из базы данных будет производитсья с помощью SQL-запроса
    QSqlQuery query;

    // Удаление производим по id записи, который передается в качестве аргумента функции
    query.prepare("DELETE FROM " TABLE " WHERE id= :ID ;");
    query.bindValue(":ID", id);

    // Выполняем удаление
    if(!query.exec()){
        qDebug() << "error delete row " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}
