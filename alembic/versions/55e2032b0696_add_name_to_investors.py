"""add name to investors

Revision ID: 55e2032b0696
Revises: e48c7bc4bcbe
Create Date: 2025-09-16 10:00:00.000000

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '55e2032b0696'
down_revision = 'e48c7bc4bcbe'
branch_labels = None
depends_on = None


def upgrade():
    op.add_column('investors', sa.Column('name', sa.String(length=255), nullable=False, server_default='Default Name'))


def downgrade():
    op.drop_column('investors', 'name')
