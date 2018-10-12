from sqlalchemy import Column, BigInteger, String
from . import Base





class temp(Base):
    __tablename__ = "lingshi"
    id = Column(BigInteger(),
                autoincrement=True,
                primary_key=True,
                index=True
                )
    name = Column(String(length=10),
                  nullable=False,
                  unique=False,
                  index=False
                  )

    def __repr__(self):
        return '<Temp %r>' % self.name
