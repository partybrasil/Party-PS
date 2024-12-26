Add-Type -AssemblyName System.Windows.Forms

$form = New-Object System.Windows.Forms.Form
$form.Text = "Herramientas de Sistema"
$form.Size = New-Object System.Drawing.Size(600, 500)

# Función para escribir log con colores
function Write-Log {
    param (
        [string]$message,
        [string]$color = "White"
    )
    Write-Host $message -ForegroundColor $color
}

# Mostrar el tamaño de la ventana en la barra de título para debug
$form.Add_SizeChanged({
    $form.Text = "Herramientas de Sistema - Tamaño: $($form.Size.Width)x$($form.Size.Height)"
    Write-Log "Tamaño de la ventana cambiado a: $($form.Size.Width)x$($form.Size.Height)" "Yellow"
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
    Write-Log "Botón 'Instalar Software' clickeado" "Green"
    if (-not $chkTerms.Checked) {
        [System.Windows.Forms.MessageBox]::Show("Debe aceptar los términos y condiciones.", "Advertencia", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
        Write-Log "Advertencia: Debe aceptar los términos y condiciones." "Red"
        return
    }
    if ($txtPath.Text -eq "") {
        [System.Windows.Forms.MessageBox]::Show("Debe ingresar una ruta de instalación.", "Advertencia", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
        Write-Log "Advertencia: Debe ingresar una ruta de instalación." "Red"
        return
    }
    # Aquí puedes agregar la lógica para instalar software
    Write-Log "Simulando instalación de software en la ruta: $($txtPath.Text)" "Green"
    [System.Windows.Forms.MessageBox]::Show("Instalación completada.", "Información", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    Write-Log "Instalación completada." "Green"
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
    Write-Log "Modo de instalación cambiado a: Estándar" "Yellow"
})

$radioAdvanced = New-Object System.Windows.Forms.RadioButton
$radioAdvanced.Text = "Avanzado"
$radioAdvanced.Location = New-Object System.Drawing.Point(100, 20)
$radioAdvanced.Add_CheckedChanged({
    $panelAdvanced.Visible = $true
    $form.Size = New-Object System.Drawing.Size(600, 500)
    Write-Log "Modo de instalación cambiado a: Avanzado" "Yellow"
})

$grpMode.Controls.AddRange(@($radioStandard, $radioAdvanced))

# LinkLabel para más información
$linkInfo = New-Object System.Windows.Forms.LinkLabel
$linkInfo.Text = "Party PS Profile"
$linkInfo.Location = New-Object System.Drawing.Point(10, 210)
$linkInfo.Add_LinkClicked({
    Start-Process "https://github.com/partybrasil/PowerShell-Profile/blob/master/Microsoft.PowerShell_profile.ps1"
    Write-Log "Abriendo enlace: https://github.com/partybrasil/PowerShell-Profile/blob/master/Microsoft.PowerShell_profile.ps1" "Blue"
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
        Write-Log "Información sobre $selectedItem mostrada" "Blue"
    }
})

# Botón para cancelar
$btnCancel = New-Object System.Windows.Forms.Button
$btnCancel.Text = "Cancelar"
$btnCancel.Location = New-Object System.Drawing.Point(10, 330)
$btnCancel.Add_Click({
    $form.Close()
    Write-Log "Formulario cerrado por el usuario" "Red"
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
        Write-Log "Tema cambiado a: Oscuro" "Yellow"
    } else {
        $chkTheme.Text = "☀️"
        $form.BackColor = [System.Drawing.Color]::White
        $form.ForeColor = [System.Drawing.Color]::Black
        Write-Log "Tema cambiado a: Claro" "Yellow"
    }
})

$form.Controls.AddRange(@($btnInstall, $txtPath, $comboType, $chkTerms, $grpMode, $linkInfo, $listComponents, $btnCancel, $panelAdvanced, $chkTheme))

# Botón para limpiar la ruta de instalación
$btnClearPath = New-Object System.Windows.Forms.Button
$btnClearPath.Text = "Limpiar Ruta"
$btnClearPath.Location = New-Object System.Drawing.Point(380, 40)
$btnClearPath.Add_Click({
    $txtPath.Clear()
    Write-Log "Ruta de instalación limpiada" "Yellow"
})

# Botón para seleccionar la ruta de instalación
$btnBrowse = New-Object System.Windows.Forms.Button
$btnBrowse.Text = "Examinar..."
$btnBrowse.Location = New-Object System.Drawing.Point(380, 70)
$btnBrowse.Add_Click({
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    if ($folderBrowser.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $txtPath.Text = $folderBrowser.SelectedPath
        Write-Log "Ruta de instalación seleccionada: $($folderBrowser.SelectedPath)" "Yellow"
    }
})

# Barra de progreso para la instalación
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(10, 430)
$progressBar.Size = New-Object System.Drawing.Size(580, 30)
$progressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous

# Función para actualizar la barra de progreso en bucle
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 50
$direction = 1
$timer.Add_Tick({
    if ($progressBar.Value -ge 100) {
        $direction = -1
    } elseif ($progressBar.Value -le 0) {
        $direction = 1
    }
    $progressBar.Value += $direction
})
$timer.Start()

# Botón SOS para ejecutar en modo administrador
$btnSOS = New-Object System.Windows.Forms.Button
$btnSOS.Text = "WinSOS"
$btnSOS.Location = New-Object System.Drawing.Point(10, 380)
$btnSOS.Add_Click({
    Start-Process powershell -ArgumentList "Start-Process powershell -ArgumentList 'irm https://christitus.com/win | iex' -Verb RunAs" -Verb RunAs
    Write-Log "Ejecutando comando SOS en modo administrador" "Red"
})

# Agregar controles adicionales al formulario
$form.Controls.AddRange(@($btnClearPath, $btnBrowse, $progressBar, $btnSOS))

# Botón para salir, cerrar la ventana correctamente y liberar recursos
$btnExit = New-Object System.Windows.Forms.Button
$btnExit.Text = "Salir"
$btnExit.Location = New-Object System.Drawing.Point(10, 470)
$btnExit.Add_Click({
    $form.Close()
    $form.Dispose()
    Write-Log "Formulario cerrado y recursos liberados" "Red"
})
$form.Controls.AddRange(@($btnExit))

[void]$form.ShowDialog()