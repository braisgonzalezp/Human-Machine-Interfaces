import webbrowser
import subprocess
import cheathelper


import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk


class View():

    def __init__(self):

        #================================VENTANA PRINCIPAL================================
        self.window = Gtk.ApplicationWindow(
            title="Cheat.sh Searcher",
            default_height=500,
            default_width=1000,
        )
        self.window.connect("destroy", Gtk.main_quit)


        # ================================Creación de Boxes================================
        self.box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)                #BOX PRINCIPAL
        self.boxSecundario = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL)    #BOX PARA EL MENU BAR
        self.boxBusqueda = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)        #BOX PARTE IZQUIERDA
        self.boxRespuesta = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)       #BOX PARTE DERECHA
        self.boxBarraBusqueda = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL) #BOX PARA LA BUSQUEDA JUNTO CON EL SPINNER
        self.boxScrollWinL = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)      #BOX PARA LOS BUSQUEDA DE COMANDOS MANUAL
        self.boxImagen = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL)        #BOX PARA LA IMAGEN
        self.boxScrollWinR = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)      #BOX PARA LA RESPUESTA DE LA BÚSQUEDA
        self.boxComandos = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)        #BOX PARA LOS COMANDOS ENCONTRADOS DEL SCROLLED WINDOW


        # ================================Barra de Búsqueda===============================
        self.barraBusqueda = Gtk.SearchEntry()
        self.barraBusqueda.connect("activate", self.buscarComando)
        self.lista = []

        # ================================Nombre de la APP================================
        self.imagen = Gtk.Image()
        self.imagen.set_from_file("/home/raul/2223-p_desktop-equipo-27/Cheat.png")


        # ================================Separators===============================
        self.separator1 = Gtk.Separator()
        self.separator2 = Gtk.Separator()
        self.separator1.set_orientation(Gtk.Orientation.HORIZONTAL)
        self.separator2.set_orientation(Gtk.Orientation.VERTICAL)


        # ================================Scroll Bar===============================
        self.scrollBar = Gtk.Scrollbar(orientation=Gtk.Orientation.VERTICAL)


        # ================================Spinner===============================
        self.spinner = Gtk.Spinner()


        # ==================================Menu=================================
        self.menuBar = Gtk.MenuBar()
        file_menu = Gtk.Menu()
        help_menu = Gtk.Menu()
        ver_menu = Gtk.Menu()
        file_menu_dropdown = Gtk.MenuItem("Archivo")
        help_menu_dropdown = Gtk.MenuItem("Ayuda")
        ver_menu_dropdown = Gtk.MenuItem("Ver")

        # File menu items
        file_new = Gtk.MenuItem("Nueva ventana")
        file_close = Gtk.MenuItem("Cerrar")

        # Help menu items
        help_new = Gtk.MenuItem("Ver Ayuda")
        help_comm = Gtk.MenuItem("Enviar comentarios")
        help_about = Gtk.MenuItem("Acerca de Cheat.sh")

        # Ver menu items
        ver_claro = Gtk.MenuItem("Light Mode")
        ver_oscuro = Gtk.MenuItem("Dark Mode")

        # Dropdowns
        file_menu_dropdown.set_submenu(file_menu)
        help_menu_dropdown.set_submenu(help_menu)
        ver_menu_dropdown.set_submenu(ver_menu)

        # Add menu items
        file_menu.append(file_new)
        file_menu.append(file_close)

        # Add menu items
        help_menu.append(help_new)
        help_menu.append(help_comm)
        help_menu.append(help_about)

        # Add menu items
        ver_menu.append(ver_claro)
        ver_menu.append(ver_oscuro)

        # Add to main menu bar
        self.menuBar.append(file_menu_dropdown)
        self.menuBar.append(ver_menu_dropdown)
        self.menuBar.append(help_menu_dropdown)

        # Funcionalidades
        help_new.connect("activate", self.verAyuda)
        help_comm.connect("activate", self.enviarComentarios)
        help_about.connect("activate", self.acercaDe)
        file_new.connect("activate", self.abrirNuevo)
        file_close.connect("activate", self.cerrarApp)
        ver_claro.connect("activate", self.modoClaro)
        ver_oscuro.connect("activate", self.modoOscuro)

        # ================================Scrolled Window Búsqueda===============================
        self.scrolledWindow = Gtk.ScrolledWindow()
        self.scrolledWindow.add(self.boxScrollWinL)

        # ================================Scrolled Window Respuesta===============================
        self.scrolledWindow2 = Gtk.ScrolledWindow()
        self.scrolledWindow2.add(self.boxComandos)

        # ================================Message Dialog===============================
        self.messageDialog = Gtk.MessageDialog()
        button = self.messageDialog.add_button("_OK", Gtk.ResponseType.CLOSE)
        button.connect("clicked", self.eliminarVentana)

        # ================================Buttons===============================
        self.buton1 = Gtk.Button(label="pwd")
        self.buton2 = Gtk.Button(label="cd")
        self.buton3 = Gtk.Button(label="ls")
        self.buton4 = Gtk.Button(label="cat")
        self.buton5 = Gtk.Button(label="cp")
        self.buton6 = Gtk.Button(label="mv")
        self.buton7 = Gtk.Button(label="mkdir")
        self.buton8 = Gtk.Button(label="rmdir")
        self.buton9 = Gtk.Button(label="rm")
        self.buton10 = Gtk.Button(label="touch")
        self.buton11 = Gtk.Button(label="locate")
        self.buton12 = Gtk.Button(label="find")
        self.buton13 = Gtk.Button(label="grep")
        self.buton14 = Gtk.Button(label="sudo")
        self.buton15 = Gtk.Button(label="df")
        self.buton16 = Gtk.Button(label="du")
        self.buton17 = Gtk.Button(label="head")
        self.buton18 = Gtk.Button(label="tail")
        self.buton19 = Gtk.Button(label="diff")
        self.buton20 = Gtk.Button(label="tar")
        self.buton21 = Gtk.Button(label="chmod")
        self.buton22 = Gtk.Button(label="chown")
        self.buton23 = Gtk.Button(label="jobs")
        self.buton24 = Gtk.Button(label="kill")
        self.buton25 = Gtk.Button(label="ping")
        self.buton26 = Gtk.Button(label="wget")
        self.buton27 = Gtk.Button(label="uname")
        self.buton28 = Gtk.Button(label="top")
        self.buton29 = Gtk.Button(label="history")
        self.buton30 = Gtk.Button(label="man")
        self.buton31 = Gtk.Button(label="echo")
        self.buton32 = Gtk.Button(label="zip")
        self.buton33 = Gtk.Button(label="hostname")
        self.buton34 = Gtk.Button(label="useradd")
        arraylist = [self.buton1, self.buton2, self.buton3, self.buton4, self.buton5, self.buton7, self.buton8,
                     self.buton9, self.buton10, self.buton11, self.buton12, self.buton13, self.buton14,
                     self.buton15, self.buton16, self.buton17, self.buton18, self.buton19, self.buton20,
                     self.buton21, self.buton22, self.buton23, self.buton24, self.buton25, self.buton26,
                     self.buton27, self.buton28, self.buton29, self.buton30, self.buton31, self.buton32,
                     self.buton33, self.buton34]

        # ================================Creación del diseño===============================

        # Creación del Box de los posibles comandos (Izquierda)

        for buton in arraylist:
            buton.connect("clicked", self.butonComando)
            self.boxScrollWinL.pack_start(buton, expand=False, fill=False, padding=0)


        #Creación del Box de la barra de busqueda
        self.boxBarraBusqueda.pack_start(self.barraBusqueda, expand=False, fill=True, padding=10)
        self.boxBarraBusqueda.pack_start(self.spinner, expand=False, fill=False, padding=10)


        # Creación del Box de la información del comando encontrado (Derecha)
        self.boxScrollWinR.pack_start(self.scrolledWindow2, expand=True, fill=True, padding=10)


        #Parte izquierda
        self.boxBusqueda.pack_start(self.boxBarraBusqueda, expand=False, fill=False, padding=10)
        self.boxBusqueda.pack_start(self.separator2, expand=False, fill=False, padding=10)
        self.boxBusqueda.pack_start(self.scrolledWindow, expand=True, fill=True, padding=10)


        #Parte derecha
        self.boxRespuesta.pack_start(self.imagen, expand=False, fill=False, padding=10)
        self.boxRespuesta.pack_start(self.boxScrollWinR, expand=True, fill=True, padding=10)


        #Box secundario
        self.boxSecundario.pack_start(self.boxBusqueda, expand=False, fill=True, padding=10)
        self.boxSecundario.pack_start(self.separator1, expand=False, fill=True, padding=10)
        self.boxSecundario.pack_start(self.boxRespuesta, expand=True, fill=True, padding=10)


        #Box principal
        self.box.pack_start(self.menuBar, expand=False, fill=True, padding=0)
        self.box.pack_start(self.boxSecundario, expand=True, fill=True, padding=10)
        self.window.add(self.box)

    # ================================Funcionalidades Menu===============================
    #Menu Archivo

    def abrirNuevo(self, widget):
        subprocess.call("python3 view.py", shell=True)

    def cerrarApp(self, widget):
        Gtk.main_quit()


    #Menu Ayuda
    def verAyuda(self, widget):
        webbrowser.open(
            "https://www.google.com/search?q=ayuda+cheat.sh&oq=ayuda+cheat.sh&aqs=chrome..69i57j33i160l3.2746j0j7&client=ubuntu&sourceid=chrome&ie=UTF-8")

    def enviarComentarios(self, widget):
        webbrowser.open("https://twitter.com/intent/follow?original_referer=https%3A%2F%2Fcheat.sh%2F&ref_src=twsrc%5Etfw%7Ctwcamp%5Ebuttonembed%7Ctwterm%5Efollow%7Ctwgr%5Eigor_chubin&region=follow_link&screen_name=igor_chubin")

    def acercaDe(self, widget):
        webbrowser.open("https://cheat.sh/")

    def modoOscuro(self, widget):
        settings = Gtk.Settings.get_default()
        settings.set_property("gtk-application-prefer-dark-theme", True)

    def modoClaro(self, widget):
        settings = Gtk.Settings.get_default()
        settings.set_property("gtk-application-prefer-dark-theme", False)


    # ================================Funcionalidades SearchBar===============================

    def buscarComando(self, widget):
        self.spinner.start()
        comando = self.barraBusqueda.get_text() #Comando encontrado
        self.escribirComandos(comando)
        self.spinner.stop()


    # ================================Funcionalidades Buttons===============================

    def butonComando(self, widget):
        self.spinner.start()
        comando = widget.get_label()  # Comando encontrado
        self.escribirComandos(comando)
        self.spinner.stop()


    # ================================Funcionalidades Comandos Encontrados===============================

    def escribirComandos(self, comando: str) -> None:

        self.eliminarWidgets()
        texto = cheathelper.get_cheatsheet(comando)
        if not texto:               #EN CASO DE QUE NO SE ENCUENTRE NINGÚN COMANDO
            comandoSugerido = cheathelper.aux(comando)
            label1 = Gtk.Label(
                label=comandoSugerido,
                halign=Gtk.Align.START
            )
            self.lista.append(label1)
            self.boxComandos.pack_start(label1, expand=False, fill=False, padding=10)
        elif texto[0][0] == "*/":   #EN CASO DE ERROR
            texto = cheathelper.aux(comando)
            self.messageDialog.set_title("ERROR 404 NOT FOUND")
            self.messageDialog.format_secondary_text(texto)
            self.messageDialog.run()

        elif texto == "NoRed":      #EN CASO DE NO TENER CONEXIÓN AL SERVIDOR
            self.messageDialog.set_title("ERROR: SIN CONEXIÓN A INTERNET")
            self.messageDialog.format_secondary_text("SIN CONEXIÓN")
            self.messageDialog.run()
        else:                       #EN CASO DE FUNCIÓN CORRECTA
            for i, r in enumerate(texto, start=0):

                if not texto[i].commands == "":
                    expander1 = Gtk.Expander(label=texto[i].commands)
                    label1 = Gtk.Label(
                        label=texto[i].description,
                        halign=Gtk.Align.START
                    )
                    expander1.add(label1)
                    self.lista.append(expander1)
                    self.boxComandos.pack_start(expander1, expand=False, fill=False, padding=10)
                else:
                    label1 = Gtk.Label(
                        label=texto[i].description,
                        halign=Gtk.Align.START
                    )
                    self.lista.append(label1)
                    self.boxComandos.pack_start(label1, expand=False, fill=False, padding=10)

                separator = Gtk.Separator()
                separator.set_orientation(Gtk.Orientation.HORIZONTAL)
                self.lista.append(separator)
                self.boxComandos.pack_start(separator, expand=False, fill=False, padding=10)

        self.window.show_all()


    def eliminarVentana(self, widget):
        self.messageDialog.hide()


    def eliminarWidgets(self):

        for widget in self.lista:
            widget.destroy()



    def show_all(self):
        win.window.show_all()




# MUESTA LA VENTANA
win = View()
win.window.connect("destroy", Gtk.main_quit)
win.show_all()
Gtk.main()





