from __future__ import annotations
from typing import NamedTuple, Optional
from cheathelper import get_cheatsheet


class BuscadorData(NamedTuple):
    comando_buscado : Optional[str] = ''
    resultado_comando : Optional[str] = ''

    def reset_date(self):
        self.comando_buscado = ''
        self.resultado_comando = ''



class BuscadorModel:


    def build_data(self) -> BuscadorData:
        return BuscadorData()

    @staticmethod
    def get_result(search : BuscadorData.comando_buscado):
        return get_cheatsheet(search.get_text())
