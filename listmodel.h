#ifndef LISTMODEL_H
#define LISTMODEL_H

#include <QObject>
#include <QSqlQueryModel>
#include <QSortFilterProxyModel>
#include <QAbstractItemModel>

class ListModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    enum Roles {
        IdRole = Qt::UserRole + 1,      // id
        TitleRole,                      // заголовок
        DescrRole,                      // описание
        DateRole                         // дата
    };

    explicit ListModel(QObject *parent = 0);

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const override;
protected:

    QHash<int, QByteArray> roleNames() const override;

public slots:
    void updateModel();
    int getId(int row);
};

#endif // LISTMODEL_H
