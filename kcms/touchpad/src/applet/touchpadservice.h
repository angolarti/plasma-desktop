/*
 * Copyright (C) 2013 Alexander Mezin <mezin.alexander@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */
#ifndef TOUCHPADSERVICE_H
#define TOUCHPADSERVICE_H

#include <Plasma/Service>

class OrgKdeTouchpadInterface;

class TouchpadService : public Plasma::Service
{
    Q_OBJECT
public:
    TouchpadService(OrgKdeTouchpadInterface *daemon, const QString &destination,
                    QObject *parent = 0);
    ~TouchpadService();

protected:
    Plasma::ServiceJob *createJob(const QString &operation,
                                  QMap<QString, QVariant> &parameters) Q_DECL_OVERRIDE;

private:
    OrgKdeTouchpadInterface *m_daemon;
    QString m_destination;
};

#endif // TOUCHPADSERVICE_H
