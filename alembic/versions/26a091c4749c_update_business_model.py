"""Update business model

Revision ID: 26a091c4749c
Revises: e48c7bc4bcbe
Create Date: 2025-09-11 12:22:53.570006

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision: str = '26a091c4749c'
down_revision: Union[str, Sequence[str], None] = 'e48c7bc4bcbe'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""

    # --- Businesses updates ---
    op.add_column('businesses', sa.Column('sector_id', postgresql.UUID(as_uuid=True), nullable=True))
    op.add_column('businesses', sa.Column('subsector_id', postgresql.UUID(as_uuid=True), nullable=True))

    op.alter_column('businesses', 'legal_name',
               existing_type=sa.VARCHAR(),
               nullable=False)

    op.alter_column('businesses', 'description',
               existing_type=sa.VARCHAR(),
               type_=sa.Text(),
               existing_nullable=True)

    # Foreign keys
    op.create_foreign_key(None, 'businesses', 'sectors', ['sector_id'], ['sector_id'])
    op.create_foreign_key(None, 'businesses', 'subsectors', ['subsector_id'], ['subsector_id'])


def downgrade() -> None:
    """Downgrade schema."""

    # Remove FKs
    op.drop_constraint(None, 'businesses', type_='foreignkey')
    op.drop_constraint(None, 'businesses', type_='foreignkey')

    # Drop added columns
    op.drop_column('businesses', 'subsector_id')
    op.drop_column('businesses', 'sector_id')

    # Revert description
    op.alter_column('businesses', 'description',
               existing_type=sa.Text(),
               type_=sa.VARCHAR(),
               existing_nullable=True)

    # Make legal_name nullable again
    op.alter_column('businesses', 'legal_name',
               existing_type=sa.VARCHAR(),
               nullable=True)