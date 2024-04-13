#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlDatabase>
#include <QFile>
#include <QDate>
#include <QDebug>

#define DATABASE_HOSTNAME   "NameDataBase"
#define DATABASE_NAME       "database.db"

#define TABLE                   "Notes"


class Database : public QObject
{
    Q_OBJECT
public:
    explicit Database(QObject *parent = 0);
    ~Database();
    void connectToDataBase();
private:
    QSqlDatabase    db;
private:
    bool openDataBase();
    void closeDataBase();
public slots:
    bool insertIntoTable(const QString &title, const QString &descr, const QString &date); // Добавление записей в таблицу
    bool updateRecord(const QString &id, const QString &title, const QString &descr, const QString &date);
    bool removeRecord(const int id); // Удаление записи из таблицы по её id
};
#endif // DATABASE_H
