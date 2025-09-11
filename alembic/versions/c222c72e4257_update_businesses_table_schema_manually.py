"""Update businesses table schema manually

Revision ID: c222c72e4257
Revises: 9a7e46a6f835
Create Date: 2025-09-10 15:50:54.834893

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'c222c72e4257'
down_revision: Union[str, Sequence[str], None] = '43bd1dd48756'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.add_column('businesses', sa.Column('capital_needed', sa.Float(), nullable=True))

def downgrade() -> None:
    op.drop_column('businesses', 'capital_needed')
