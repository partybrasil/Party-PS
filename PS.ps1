Add-Type -AssemblyName System.Windows.Forms

$form = New-Object System.Windows.Forms.Form
$form.Text = "Herramientas de Sistema"
$form.Size = New-Object System.Drawing.Size(600, 500)

# Mostrar el tamaño de la ventana en la barra de título para debug
$form.Add_SizeChanged({
    $form.Text = "Herramientas de Sistema - Tamaño: $($form.Size.Width)x$($form.Size.Height)"
})

# Panel para opciones avanzadas
$panelAdvanced = New-Object System.Windows.Forms.Panel
$panelAdvanced.Location = New-Object System.Drawing.Point(400, 10)
$panelAdvanced.Size = New-Object System.Drawing.Size(180, 350)
$panelAdvanced.Visible = $false

# Opciones avanzadas
$chkOption1 = New-Object System.Windows.Forms.CheckBox
$chkOption1.Text = "Opción Avanzada 1"
$chkOption1.Location = New-Object System.Drawing.Point(10, 10)

$chkOption2 = New-Object System.Windows.Forms.CheckBox
$chkOption2.Text = "Opción Avanzada 2"
$chkOption2.Location = New-Object System.Drawing.Point(10, 40)

$chkOption3 = New-Object System.Windows.Forms.CheckBox
$chkOption3.Text = "Opción Avanzada 3"
$chkOption3.Location = New-Object System.Drawing.Point(10, 70)

$panelAdvanced.Controls.AddRange(@($chkOption1, $chkOption2, $chkOption3))

# Botón para instalar software
$btnInstall = New-Object System.Windows.Forms.Button
$btnInstall.Text = "Instalar Software"
$btnInstall.Location = New-Object System.Drawing.Point(10, 10)
$btnInstall.Add_Click({
    if (-not $chkTerms.Checked) {
        [System.Windows.Forms.MessageBox]::Show("Debe aceptar los términos y condiciones.", "Advertencia", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
        return
    }
    if ($txtPath.Text -eq "") {
        [System.Windows.Forms.MessageBox]::Show("Debe ingresar una ruta de instalación.", "Advertencia", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
        return
    }
    # Aquí puedes agregar la lógica para instalar software
    Write-Host "Simulando instalación de software en la ruta: $($txtPath.Text)"
    [System.Windows.Forms.MessageBox]::Show("Instalación completada.", "Información", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

# Caja de texto para ingresar la ruta de instalación
$txtPath = New-Object System.Windows.Forms.TextBox
$txtPath.Location = New-Object System.Drawing.Point(10, 40)
$txtPath.Width = 360
$txtPath.PlaceholderText = "Ingrese la ruta de instalación"

# Lista desplegable para seleccionar el tipo de instalación
$comboType = New-Object System.Windows.Forms.ComboBox
$comboType.Items.Add("Típica")
$comboType.Items.Add("Personalizada")
$comboType.Location = New-Object System.Drawing.Point(10, 70)
$comboType.Width = 360

# CheckBox para aceptar términos y condiciones
$chkTerms = New-Object System.Windows.Forms.CheckBox
$chkTerms.Text = "Acepto los términos y condiciones"
$chkTerms.Location = New-Object System.Drawing.Point(10, 100)

# RadioButton para seleccionar el modo de instalación
$grpMode = New-Object System.Windows.Forms.GroupBox
$grpMode.Text = "Modo de Instalación"
$grpMode.Location = New-Object System.Drawing.Point(10, 130)
$grpMode.Size = New-Object System.Drawing.Size(360, 70)

$radioStandard = New-Object System.Windows.Forms.RadioButton
$radioStandard.Text = "Estándar"
$radioStandard.Location = New-Object System.Drawing.Point(10, 20)
$radioStandard.Checked = $true
$radioStandard.Add_CheckedChanged({
    $panelAdvanced.Visible = $false
    $form.Size = New-Object System.Drawing.Size(400, 500)
})

$radioAdvanced = New-Object System.Windows.Forms.RadioButton
$radioAdvanced.Text = "Avanzado"
$radioAdvanced.Location = New-Object System.Drawing.Point(100, 20)
$radioAdvanced.Add_CheckedChanged({
    $panelAdvanced.Visible = $true
    $form.Size = New-Object System.Drawing.Size(600, 500)
})

$grpMode.Controls.AddRange(@($radioStandard, $radioAdvanced))

# LinkLabel para más información
$linkInfo = New-Object System.Windows.Forms.LinkLabel
$linkInfo.Text = "Más información"
$linkInfo.Location = New-Object System.Drawing.Point(10, 210)
$linkInfo.Add_LinkClicked({
    Start-Process "https://www.example.com"
})

# ListBox para seleccionar componentes adicionales
$listComponents = New-Object System.Windows.Forms.ListBox
$listComponents.SelectionMode = [System.Windows.Forms.SelectionMode]::MultiExtended
$listComponents.Items.AddRange(@("Componente 1", "Componente 2", "Componente 3"))
$listComponents.Location = New-Object System.Drawing.Point(10, 240)
$listComponents.Size = New-Object System.Drawing.Size(360, 80)
$listComponents.Add_DoubleClick({
    $selectedItem = $listComponents.SelectedItem
    if ($selectedItem) {
        [System.Windows.Forms.MessageBox]::Show("Información sobre $selectedItem", "Información del Componente", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    }
})

# Botón para cancelar
$btnCancel = New-Object System.Windows.Forms.Button
$btnCancel.Text = "Cancelar"
$btnCancel.Location = New-Object System.Drawing.Point(10, 330)
$btnCancel.Add_Click({
    $form.Close()
})

# Botón tipo interruptor para cambiar el tema
$chkTheme = New-Object System.Windows.Forms.CheckBox
$chkTheme.Appearance = [System.Windows.Forms.Appearance]::Button
$chkTheme.Text = "☀️"
$chkTheme.Location = New-Object System.Drawing.Point(380, 10)
$chkTheme.Size = New-Object System.Drawing.Size(30, 30)
$chkTheme.Add_CheckedChanged({
    if ($chkTheme.Checked) {
        $chkTheme.Text = "☀️"
        $form.BackColor = [System.Drawing.Color]::Black
        $form.ForeColor = [System.Drawing.Color]::White
    } else {
        $chkTheme.Text = "☀️"
        $form.BackColor = [System.Drawing.Color]::White
        $form.ForeColor = [System.Drawing.Color]::Black
    }
})

# Sección de iconos de aplicaciones de ejemplo
$panelIcons = New-Object System.Windows.Forms.Panel
$panelIcons.Location = New-Object System.Drawing.Point(10, 370)
$panelIcons.Size = New-Object System.Drawing.Size(580, 100)

$iconUrls = @(
    "https://cdn.icon-icons.com/icons2/1211/PNG/96/1491580651-yumminkysocialmedia28_83061.png",
    "https://cdn.icon-icons.com/icons2/1211/PNG/96/1491580651-yumminkysocialmedia28_83061.png",
    "https://cdn.icon-icons.com/icons2/1211/PNG/96/1491580651-yumminkysocialmedia28_83061.png",
    "https://cdn.icon-icons.com/icons2/1211/PNG/96/1491580651-yumminkysocialmedia28_83061.png",
    "https://cdn.icon-icons.com/icons2/1211/PNG/96/1491580651-yumminkysocialmedia28_83061.png"
)

$webClient = New-Object System.Net.WebClient

for ($i = 0; $i -lt $iconUrls.Length; $i++) {
    $pictureBox = New-Object System.Windows.Forms.PictureBox
    try {
        $imageStream = $webClient.OpenRead($iconUrls[$i])
        $pictureBox.Image = [System.Drawing.Image]::FromStream($imageStream)
        $imageStream.Close()
    } catch {
        [System.Windows.Forms.MessageBox]::Show("No se pudo cargar la imagen: $($iconUrls[$i])", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        continue
    }
    $pictureBox.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::StretchImage
    $pictureBox.Size = New-Object System.Drawing.Size(100, 100)
    # Asegúrate de que $i sea un valor numérico
    $i = [int]$i
    $pictureBox.Location = New-Object System.Drawing.Point(10 + ($i * 100), 10)
    $pictureBox.Add_Click({
        [System.Windows.Forms.MessageBox]::Show("Ejecutando aplicación: $($iconUrls[$i])", "Ejecutar Aplicación", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    })
    $panelIcons.Controls.Add($pictureBox)
}

$form.Controls.AddRange(@($btnInstall, $txtPath, $comboType, $chkTerms, $grpMode, $linkInfo, $listComponents, $btnCancel, $panelAdvanced, $chkTheme, $panelIcons))
[void]$form.ShowDialog()
# Botón para limpiar la ruta de instalación
$btnClearPath = New-Object System.Windows.Forms.Button
$btnClearPath.Text = "Limpiar Ruta"
$btnClearPath.Location = New-Object System.Drawing.Point(380, 40)
$btnClearPath.Add_Click({
    $txtPath.Clear()
})

# Botón para seleccionar la ruta de instalación
$btnBrowse = New-Object System.Windows.Forms.Button
$btnBrowse.Text = "Examinar..."
$btnBrowse.Location = New-Object System.Drawing.Point(380, 70)
$btnBrowse.Add_Click({
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    if ($folderBrowser.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $txtPath.Text = $folderBrowser.SelectedPath
    }
})


# Barra de progreso para la instalación
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(10, 430)
$progressBar.Size = New-Object System.Drawing.Size(580, 30)
$progressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous

# Agregar controles adicionales al formulario
$form.Controls.AddRange(@($btnClearPath, $btnBrowse, $progressBar))

# Botón para salir, cerrar la ventana correctamente y liberar recursos
$btnExit = New-Object System.Windows.Forms.Button
$btnExit.Text = "Salir"
$btnExit.Location = New-Object System.Drawing.Point(10, 470)
$btnExit.Add_Click({
    $form.Close()
    $form.Dispose()
})
$form.Controls.AddRange(@($btnExit))


