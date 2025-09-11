"""add createdAt and updatedAt to businesses

Revision ID: e48c7bc4bcbe
Revises: c222c72e4257
Create Date: 2025-09-11 13:34:20.314848

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision: str = 'e48c7bc4bcbe'
down_revision: Union[str, Sequence[str], None] = 'c222c72e4257'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None

def upgrade() -> None:
    """Upgrade schema."""
    op.add_column('businesses', sa.Column('createdAt', sa.DateTime(), nullable=False, server_default=sa.func.now()))
    op.add_column('businesses', sa.Column('updatedAt', sa.DateTime(), nullable=False, server_default=sa.func.now()))

def downgrade() -> None:
    """Downgrade schema."""
    op.drop_column('businesses', 'updatedAt')
    op.drop_column('businesses', 'createdAt')
