#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

#include "database.h"
#include "listmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/base_project/Main.qml"_qs);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);


    // Подключаемся к базе данных
    Database database;
    database.connectToDataBase();

    // Объявляем и инициализируем модель данных


    //ListModel *model = new ListModel();
    qmlRegisterType<ListModel>("ListModel", 0, 1, "ListModel");

    // Обеспечиваем доступ к модели и классу для работы с базой данных из QML
    //model->data();
    //engine.rootContext()->setContextProperty("myModel", model);
    engine.rootContext()->setContextProperty("sqlitedatabase", &database);

    engine.load(url);

    return app.exec();
}
