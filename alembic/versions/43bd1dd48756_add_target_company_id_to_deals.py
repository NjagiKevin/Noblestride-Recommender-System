"""add target_company_id to deals

Revision ID: 43bd1dd48756
Revises: 
Create Date: 2025-09-07 12:35:58.863756

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '43bd1dd48756'
down_revision: Union[str, Sequence[str], None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    op.add_column('deals', sa.Column('target_company_id', sa.Integer(), nullable=True))
    op.create_foreign_key(
        'fk_deals_target_company_id_users',
        'deals', 'users',
        ['target_company_id'], ['id'],
        onupdate='CASCADE',
        ondelete='CASCADE'
    )


def downgrade() -> None:
    """Downgrade schema."""
    op.drop_constraint('fk_deals_target_company_id_users', 'deals', type_='foreignkey')
    op.drop_column('deals', 'target_company_id')