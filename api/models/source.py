import json

from sqlalchemy import func
from sqlalchemy.dialects.postgresql import JSONB

from models.base import Base

from .engine import db
from .types import StringUUID


class DataSourceOauthBinding(db.Model):  # type: ignore[name-defined]
    __tablename__ = "data_source_oauth_bindings"
    __table_args__ = (
        db.PrimaryKeyConstraint("id", name="source_binding_pkey"),
        db.Index("source_binding_tenant_id_idx", "tenant_id"),
        db.Index("source_info_idx", "source_info", postgresql_using="gin"),
    )
    # 这些字段帮助应用程序管理和访问不同的数据源，并确保在不同租户间的隔离。
    # ID
    id = db.Column(StringUUID, server_default=db.text("uuid_generate_v4()"))
    # 租户ID，标识数据源所属的租户。
    tenant_id = db.Column(StringUUID, nullable=False)
    # 访问令牌，用于访问数据源。
    access_token = db.Column(db.String(255), nullable=False)
    # 提供商，数据源提供商名称。
    provider = db.Column(db.String(255), nullable=False)
    # 源信息，包含数据源信息的 JSONB字段。
    source_info = db.Column(JSONB, nullable=False)
    # 创建时间
    created_at = db.Column(db.DateTime, nullable=False, server_default=func.current_timestamp())
    # 更新时间
    updated_at = db.Column(db.DateTime, nullable=False, server_default=func.current_timestamp())
    # 是否禁用
    disabled = db.Column(db.Boolean, nullable=True, server_default=db.text("false"))


class DataSourceApiKeyAuthBinding(Base):
    __tablename__ = "data_source_api_key_auth_bindings"
    __table_args__ = (
        db.PrimaryKeyConstraint("id", name="data_source_api_key_auth_binding_pkey"),
        db.Index("data_source_api_key_auth_binding_tenant_id_idx", "tenant_id"),
        db.Index("data_source_api_key_auth_binding_provider_idx", "provider"),
    )

    id = db.Column(StringUUID, server_default=db.text("uuid_generate_v4()"))
    tenant_id = db.Column(StringUUID, nullable=False)
    category = db.Column(db.String(255), nullable=False)
    provider = db.Column(db.String(255), nullable=False)
    credentials = db.Column(db.Text, nullable=True)  # JSON
    created_at = db.Column(db.DateTime, nullable=False, server_default=func.current_timestamp())
    updated_at = db.Column(db.DateTime, nullable=False, server_default=func.current_timestamp())
    disabled = db.Column(db.Boolean, nullable=True, server_default=db.text("false"))

    def to_dict(self):
        return {
            "id": self.id,
            "tenant_id": self.tenant_id,
            "category": self.category,
            "provider": self.provider,
            "credentials": json.loads(self.credentials),
            "created_at": self.created_at.timestamp(),
            "updated_at": self.updated_at.timestamp(),
            "disabled": self.disabled,
        }
