from datetime import UTC, datetime

from celery import states  # type: ignore

from models.base import Base

from .engine import db


class CeleryTask(Base):
    """Task result/status."""

    __tablename__ = "celery_taskmeta"
    # 该表 celery_taskmeta 用于记录 Celery 任务的结果和状态。具体字段如下：
    # ID，自增主键，唯一标识任务记录。
    id = db.Column(db.Integer, db.Sequence("task_id_sequence"), primary_key=True, autoincrement=True)
    # 任务ID，任务的唯一标识符。
    task_id = db.Column(db.String(155), unique=True)
    # 状态，任务状态，默认值为 PENDING。
    status = db.Column(db.String(50), default=states.PENDING)
    # 结果，任务结果，使用PickleType 存储。
    # db.PickleType 是 SQLAlchemy 提供的一种自定义列类型，用于存储复杂的 Python 对象。
        # 具体来说，PickleType 利用 Python 的 pickle 模块将对象序列化为二进制格式，从而能够将对象存储在数据库中。
        # 序列化复杂对象:
            # 将复杂的 Python 对象（如列表、字典、自定义类实例）序列化为字符串或二进制数据，以便存储在数据库的列中。
        # 反序列化:
            # 从数据库中读取数据时，自动将存储的二进制数据反序列化回 Python 对象。
        # 简化存储过程:
            # 通过自动序列化和反序列化，PickleType 提供了一种简单的方式来存储和检索 Python 对象，
            # 而无需手动处理序列化逻辑。
    result = db.Column(db.PickleType, nullable=True)
    # 完成日期，任务完成时间，默认当前 UTC 时间，更新时也会记录当前 UTC 时间。
    date_done = db.Column(
        db.DateTime,
        default=lambda: datetime.now(UTC).replace(tzinfo=None),
        onupdate=lambda: datetime.now(UTC).replace(tzinfo=None),
        nullable=True,
    )
    # 回溯，任务出错时的回溯信息。
    traceback = db.Column(db.Text, nullable=True)
    # 名称，任务名称。
    name = db.Column(db.String(155), nullable=True)
    # 参数，任务的参数，以二进制形式存储。
    args = db.Column(db.LargeBinary, nullable=True)
    # 关键字参效，任务的关键字参数，以二进制形式存储。
    kwargs = db.Column(db.LargeBinary, nullable=True)
    # 工作者，执行任务的节点
    worker = db.Column(db.String(155), nullable=True)
    # 重试次数，任务重试次数。
    retries = db.Column(db.Integer, nullable=True)
    # 队列，任务所在的队列。
    queue = db.Column(db.String(155), nullable=True)


class CeleryTaskSet(Base):
    """TaskSet result."""

    __tablename__ = "celery_tasksetmeta"
    # 该表 celery_tasksetmeta 用于管理和跟踪 Celery 异步任务的执行状态和结果。
    # ID，自增主键，唯一标识任务集记录
    id = db.Column(db.Integer, db.Sequence("taskset_id_sequence"), autoincrement=True, primary_key=True)
    # 任务集ID， 任务集的唯一标识符
    taskset_id = db.Column(db.String(155), unique=True)
    # 结果，任务集结果，使用 PickleType 存储。
    result = db.Column(db.PickleType, nullable=True)
    # 完成日期，任务集完成时间，默认当前 UTC 时间。
    date_done = db.Column(db.DateTime, default=lambda: datetime.now(UTC).replace(tzinfo=None), nullable=True)
