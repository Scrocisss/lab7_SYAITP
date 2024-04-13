#include "listmodel.h"
#include "database.h"
#include <QSortFilterProxyModel>
#include <QRegularExpression>

ListModel::ListModel(QObject *parent) :
    QSqlQueryModel(parent)
{
    this->updateModel();
    this->setHeaderData(0, Qt::Horizontal, tr("Name"));
}





QVariant ListModel::data(const QModelIndex & index, int role) const {

    // Определяем номер колонки, адрес так сказать, по номеру роли
    int columnId = role - Qt::UserRole - 1;
    // Создаём индекс с помощью новоиспечённого ID колонки
    QModelIndex modelIndex = this->index(index.row(), columnId);




    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}


QHash<int, QByteArray> ListModel::roleNames() const {

    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[TitleRole] = "title";
    roles[DescrRole] = "descr";
    roles[DateRole] = "date";
    return roles;
}


void ListModel::updateModel()
{
    // Обновление производится SQL-запросом к базе данных
    this->setQuery("SELECT id, title, descr, date FROM " TABLE);
}


int ListModel::getId(int row)
{
    return this->data(this->index(row, 0), IdRole).toInt();
}
