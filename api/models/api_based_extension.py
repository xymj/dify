import enum

from sqlalchemy import func

from .engine import db
from .types import StringUUID


class APIBasedExtensionPoint(enum.Enum):
    APP_EXTERNAL_DATA_TOOL_QUERY = "app.external_data_tool.query"
    PING = "ping"
    APP_MODERATION_INPUT = "app.moderation.input"
    APP_MODERATION_OUTPUT = "app.moderation.output"


class APIBasedExtension(db.Model):  # type: ignore[name-defined]
    __tablename__ = "api_based_extensions"
    __table_args__ = (
        db.PrimaryKeyConstraint("id", name="api_based_extension_pkey"),
        db.Index("api_based_extension_tenant_idx", "tenant_id"),
    )
    # ID
    id = db.Column(StringUUID, server_default=db.text("uuid_generate_v4()"))
    # 租户ID
    tenant_id = db.Column(StringUUID, nullable=False)
    # 名称
    name = db.Column(db.String(255), nullable=False)
    # API端点
    api_endpoint = db.Column(db.String(255), nullable=False)
    # API密钥
    api_key = db.Column(db.Text, nullable=False)
    # 创建时间
    created_at = db.Column(db.DateTime, nullable=False, server_default=func.current_timestamp())
