Add-Type -AssemblyName System.Windows.Forms

$form = New-Object System.Windows.Forms.Form
$form.Text = "Herramientas de Sistema"
$form.Size = New-Object System.Drawing.Size(600, 700)

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
    $form.Size = New-Object System.Drawing.Size(400, 700)
    Write-Log "Modo de instalación cambiado a: Estándar" "Yellow"
})

$radioAdvanced = New-Object System.Windows.Forms.RadioButton
$radioAdvanced.Text = "Avanzado"
$radioAdvanced.Location = New-Object System.Drawing.Point(100, 20)
$radioAdvanced.Add_CheckedChanged({
    $panelAdvanced.Visible = $true
    $form.Size = New-Object System.Drawing.Size(600, 700)
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

# Este script de PowerShell crea una interfaz gráfica con botones para realizar varias tareas de optimización y limpieza en el sistema.

$btnDisableServices = New-Object System.Windows.Forms.Button
$btnDisableServices.Text = "Deshabilitar Servicios"
$btnDisableServices.Location = New-Object System.Drawing.Point(10, 510)
$btnDisableServices.Width = 180
$btnDisableServices.Add_Click({
    Write-Log "Deshabilitando servicios innecesarios..." "Green"
    Get-Service -Name "DiagTrack", "dmwappushservice" | Stop-Service -Force
    Get-Service -Name "DiagTrack", "dmwappushservice" | Set-Service -StartupType Disabled
    Write-Log "Servicios innecesarios deshabilitados." "Green"
})
$btnDisableServices.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnDisableServices, "Deshabilita servicios innecesarios del sistema para mejorar el rendimiento. Recomendado para usuarios avanzados.")
})

$btnCleanTempFiles = New-Object System.Windows.Forms.Button
$btnCleanTempFiles.Text = "Limpiar Archivos Temporales"
$btnCleanTempFiles.Location = New-Object System.Drawing.Point(10, 540)
$btnCleanTempFiles.Width = 180
$btnCleanTempFiles.Add_Click({
    Write-Log "Limpiando archivos temporales..." "Green"
    Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force
    Remove-Item -Path "$env:TEMP\*" -Recurse -Force
    Write-Log "Archivos temporales limpiados." "Green"
})
$btnCleanTempFiles.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnCleanTempFiles, "Elimina archivos temporales del sistema para liberar espacio en disco. Recomendado realizar periódicamente.")
})

$btnUninstallApps = New-Object System.Windows.Forms.Button
$btnUninstallApps.Text = "Desinstalar Apps Preinstaladas"
$btnUninstallApps.Location = New-Object System.Drawing.Point(10, 570)
$btnUninstallApps.Width = 180
$btnUninstallApps.Add_Click({
    Write-Log "Desinstalando aplicaciones preinstaladas..." "Green"
    Get-AppxPackage -AllUsers | Remove-AppxPackage
    Write-Log "Aplicaciones preinstaladas desinstaladas." "Green"
})
$btnUninstallApps.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnUninstallApps, "Desinstala aplicaciones preinstaladas del sistema para reducir el bloatware. Recomendado para usuarios que desean un sistema más limpio.")
})

$btnOptimizeStartup = New-Object System.Windows.Forms.Button
$btnOptimizeStartup.Text = "Optimizar Arranque"
$btnOptimizeStartup.Location = New-Object System.Drawing.Point(10, 600)
$btnOptimizeStartup.Width = 180
$btnOptimizeStartup.Add_Click({
    Write-Log "Optimizing startup..." "Green"
    Get-CimInstance -ClassName Win32_StartupCommand | Remove-CimInstance
    Write-Log "Startup optimized." "Green"
})
$btnOptimizeStartup.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnOptimizeStartup, "Elimina comandos de inicio para optimizar el arranque del sistema. Recomendado para mejorar el tiempo de inicio.")
})

$btnDisableVisualEffects = New-Object System.Windows.Forms.Button
$btnDisableVisualEffects.Text = "Desactivar Efectos Visuales"
$btnDisableVisualEffects.Location = New-Object System.Drawing.Point(10, 630)
$btnDisableVisualEffects.Width = 180
$btnDisableVisualEffects.Add_Click({
    Write-Log "Desactivando efectos visuales..." "Green"
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "VisualFXSetting" -Value 2
    Write-Log "Efectos visuales desactivados." "Green"
})
$btnDisableVisualEffects.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnDisableVisualEffects, "Desactiva los efectos visuales del sistema para mejorar el rendimiento. Recomendado para sistemas con recursos limitados.")
})
$btnEnableFirewall = New-Object System.Windows.Forms.Button
$btnEnableFirewall.Text = "Habilitar Firewall"
$btnEnableFirewall.Location = New-Object System.Drawing.Point(200, 510)
$btnEnableFirewall.Width = 180
$btnEnableFirewall.Add_Click({
    Write-Log "Habilitando Firewall..." "Green"
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
    Write-Log "Firewall habilitado." "Green"
})
$btnEnableFirewall.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnEnableFirewall, "Habilita el firewall de Windows para mejorar la seguridad del sistema.")
})

$btnDisableFirewall = New-Object System.Windows.Forms.Button
$btnDisableFirewall.Text = "Deshabilitar Firewall"
$btnDisableFirewall.Location = New-Object System.Drawing.Point(200, 540)
$btnDisableFirewall.Width = 180
$btnDisableFirewall.Add_Click({
    Write-Log "Deshabilitando Firewall..." "Green"
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
    Write-Log "Firewall deshabilitado." "Green"
})
$btnDisableFirewall.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnDisableFirewall, "Deshabilita el firewall de Windows. No recomendado a menos que sea necesario.")
})

$btnEnableDefender = New-Object System.Windows.Forms.Button
$btnEnableDefender.Text = "Habilitar Defender"
$btnEnableDefender.Location = New-Object System.Drawing.Point(200, 570)
$btnEnableDefender.Width = 180
$btnEnableDefender.Add_Click({
    Write-Log "Habilitando Windows Defender..." "Green"
    Set-MpPreference -DisableRealtimeMonitoring $false
    Write-Log "Windows Defender habilitado." "Green"
})
$btnEnableDefender.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnEnableDefender, "Habilita la protección en tiempo real de Windows Defender.")
})

$btnDisableDefender = New-Object System.Windows.Forms.Button
$btnDisableDefender.Text = "Deshabilitar Defender"
$btnDisableDefender.Location = New-Object System.Drawing.Point(200, 600)
$btnDisableDefender.Width = 180
$btnDisableDefender.Add_Click({
    Write-Log "Deshabilitando Windows Defender..." "Green"
    Set-MpPreference -DisableRealtimeMonitoring $true
    Write-Log "Windows Defender deshabilitado." "Green"
})
$btnDisableDefender.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnDisableDefender, "Deshabilita la protección en tiempo real de Windows Defender. No recomendado.")
})

$btnClearDNSCache = New-Object System.Windows.Forms.Button
$btnClearDNSCache.Text = "Limpiar Caché DNS"
$btnClearDNSCache.Location = New-Object System.Drawing.Point(200, 630)
$btnClearDNSCache.Width = 180
$btnClearDNSCache.Add_Click({
    Write-Log "Limpiando caché DNS..." "Green"
    Clear-DnsClientCache
    Write-Log "Caché DNS limpiada." "Green"
})
$btnClearDNSCache.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnClearDNSCache, "Limpia la caché DNS del sistema para resolver problemas de conectividad.")
})

$btnFlushDNS = New-Object System.Windows.Forms.Button
$btnFlushDNS.Text = "Flush DNS"
$btnFlushDNS.Location = New-Object System.Drawing.Point(200, 660)
$btnFlushDNS.Width = 180
$btnFlushDNS.Add_Click({
    Write-Log "Flushing DNS..." "Green"
    ipconfig /flushdns
    Write-Log "DNS flushed." "Green"
})
$btnFlushDNS.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnFlushDNS, "Flushes the DNS resolver cache to resolve connectivity issues.")
})

$btnRestartNetwork = New-Object System.Windows.Forms.Button
$btnRestartNetwork.Text = "Reiniciar Red"
$btnRestartNetwork.Location = New-Object System.Drawing.Point(390, 510)
$btnRestartNetwork.Width = 180
$btnRestartNetwork.Add_Click({
    Write-Log "Reiniciando adaptadores de red..." "Green"
    Get-NetAdapter | Restart-NetAdapter
    Write-Log "Adaptadores de red reiniciados." "Green"
})
$btnRestartNetwork.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnRestartNetwork, "Reinicia todos los adaptadores de red para resolver problemas de conectividad.")
})

$btnCheckUpdates = New-Object System.Windows.Forms.Button
$btnCheckUpdates.Text = "Buscar Actualizaciones"
$btnCheckUpdates.Location = New-Object System.Drawing.Point(390, 540)
$btnCheckUpdates.Width = 180
$btnCheckUpdates.Add_Click({
    Write-Log "Buscando actualizaciones de Windows..." "Green"
    Install-Module PSWindowsUpdate -Force
    Import-Module PSWindowsUpdate
    Get-WindowsUpdate -Install -AcceptAll -AutoReboot
    Write-Log "Actualizaciones de Windows instaladas." "Green"
})
$btnCheckUpdates.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnCheckUpdates, "Busca e instala actualizaciones de Windows para mantener el sistema actualizado.")
})

$btnClearEventLogs = New-Object System.Windows.Forms.Button
$btnClearEventLogs.Text = "Limpiar Logs de Eventos"
$btnClearEventLogs.Location = New-Object System.Drawing.Point(390, 570)
$btnClearEventLogs.Width = 180
$btnClearEventLogs.Add_Click({
    Write-Log "Limpiando logs de eventos..." "Green"
    wevtutil el | Foreach-Object { wevtutil cl $_ }
    Write-Log "Logs de eventos limpiados." "Green"
})
$btnClearEventLogs.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnClearEventLogs, "Limpia todos los logs de eventos del sistema para liberar espacio y mejorar el rendimiento.")
})

$btnEnableHibernate = New-Object System.Windows.Forms.Button
$btnEnableHibernate.Text = "Habilitar Hibernación"
$btnEnableHibernate.Location = New-Object System.Drawing.Point(390, 600)
$btnEnableHibernate.Width = 180
$btnEnableHibernate.Add_Click({
    Write-Log "Habilitando hibernación..." "Green"
    powercfg -h on
    Write-Log "Hibernación habilitada." "Green"
})
$btnEnableHibernate.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnEnableHibernate, "Habilita la opción de hibernación en el sistema para ahorrar energía.")
})

$btnDisableHibernate = New-Object System.Windows.Forms.Button
$btnDisableHibernate.Text = "Deshabilitar Hibernación"
$btnDisableHibernate.Location = New-Object System.Drawing.Point(390, 630)
$btnDisableHibernate.Width = 180
$btnDisableHibernate.Add_Click({
    Write-Log "Deshabilitando hibernación..." "Green"
    powercfg -h off
    Write-Log "Hibernación deshabilitada." "Green"
})
$btnDisableHibernate.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnDisableHibernate, "Deshabilita la opción de hibernación en el sistema para liberar espacio en disco.")
})

# Nuevos botones con scripts útiles y populares para Windows 11

$btnEnableDarkMode = New-Object System.Windows.Forms.Button
$btnEnableDarkMode.Text = "Habilitar Modo Oscuro"
$btnEnableDarkMode.Location = New-Object System.Drawing.Point(580, 510)
$btnEnableDarkMode.Width = 180
$btnEnableDarkMode.Add_Click({
    Write-Log "Habilitando Modo Oscuro..." "Green"
    New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0 -PropertyType DWORD -Force
    Write-Log "Modo Oscuro habilitado." "Green"
})
$btnEnableDarkMode.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnEnableDarkMode, "Habilita el modo oscuro en Windows 11.")
})

$btnDisableDarkMode = New-Object System.Windows.Forms.Button
$btnDisableDarkMode.Text = "Deshabilitar Modo Oscuro"
$btnDisableDarkMode.Location = New-Object System.Drawing.Point(580, 540)
$btnDisableDarkMode.Width = 180
$btnDisableDarkMode.Add_Click({
    Write-Log "Deshabilitando Modo Oscuro..." "Green"
    New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 1 -PropertyType DWORD -Force
    Write-Log "Modo Oscuro deshabilitado." "Green"
})
$btnDisableDarkMode.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnDisableDarkMode, "Deshabilita el modo oscuro en Windows 11.")
})

$btnEnableTransparency = New-Object System.Windows.Forms.Button
$btnEnableTransparency.Text = "Habilitar Transparencia"
$btnEnableTransparency.Location = New-Object System.Drawing.Point(580, 570)
$btnEnableTransparency.Width = 180
$btnEnableTransparency.Add_Click({
    Write-Log "Habilitando Transparencia..." "Green"
    New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 1 -PropertyType DWORD -Force
    Write-Log "Transparencia habilitada." "Green"
})
$btnEnableTransparency.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnEnableTransparency, "Habilita la transparencia en Windows 11.")
})

$btnDisableTransparency = New-Object System.Windows.Forms.Button
$btnDisableTransparency.Text = "Deshabilitar Transparencia"
$btnDisableTransparency.Location = New-Object System.Drawing.Point(580, 600)
$btnDisableTransparency.Width = 180
$btnDisableTransparency.Add_Click({
    Write-Log "Deshabilitando Transparencia..." "Green"
    New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0 -PropertyType DWORD -Force
    Write-Log "Transparencia deshabilitada." "Green"
})
$btnDisableTransparency.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnDisableTransparency, "Deshabilita la transparencia en Windows 11.")
})

$btnEnableFastStartup = New-Object System.Windows.Forms.Button
$btnEnableFastStartup.Text = "Habilitar Inicio Rápido"
$btnEnableFastStartup.Location = New-Object System.Drawing.Point(580, 630)
$btnEnableFastStartup.Width = 180
$btnEnableFastStartup.Add_Click({
    Write-Log "Habilitando Inicio Rápido..." "Green"
    powercfg -h on
    Write-Log "Inicio Rápido habilitado." "Green"
})
$btnEnableFastStartup.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnEnableFastStartup, "Habilita el inicio rápido en Windows 11.")
})

$btnDisableFastStartup = New-Object System.Windows.Forms.Button
$btnDisableFastStartup.Text = "Deshabilitar Inicio Rápido"
$btnDisableFastStartup.Location = New-Object System.Drawing.Point(580, 660)
$btnDisableFastStartup.Width = 180
$btnDisableFastStartup.Add_Click({
    Write-Log "Deshabilitando Inicio Rápido..." "Green"
    powercfg -h off
    Write-Log "Inicio Rápido deshabilitado." "Green"
})
$btnDisableFastStartup.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnDisableFastStartup, "Deshabilita el inicio rápido en Windows 11.")
})

$btnEnableSystemRestore = New-Object System.Windows.Forms.Button
$btnEnableSystemRestore.Text = "Habilitar Restauración del Sistema"
$btnEnableSystemRestore.Location = New-Object System.Drawing.Point(770, 510)
$btnEnableSystemRestore.Width = 180
$btnEnableSystemRestore.Add_Click({
    Write-Log "Habilitando Restauración del Sistema..." "Green"
    Enable-ComputerRestore -Drive "C:\"
    Write-Log "Restauración del Sistema habilitada." "Green"
})
$btnEnableSystemRestore.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnEnableSystemRestore, "Habilita la restauración del sistema en Windows 11.")
})

$btnDisableSystemRestore = New-Object System.Windows.Forms.Button
$btnDisableSystemRestore.Text = "Deshabilitar Restauración del Sistema"
$btnDisableSystemRestore.Location = New-Object System.Drawing.Point(770, 540)
$btnDisableSystemRestore.Width = 180
$btnDisableSystemRestore.Add_Click({
    Write-Log "Deshabilitando Restauración del Sistema..." "Green"
    Disable-ComputerRestore -Drive "C:\"
    Write-Log "Restauración del Sistema deshabilitada." "Green"
})
$btnDisableSystemRestore.Add_MouseHover({
    $tooltip = New-Object System.Windows.Forms.ToolTip
    $tooltip.SetToolTip($btnDisableSystemRestore, "Deshabilita la restauración del sistema en Windows 11.")
})

$btn

$form.Controls.AddRange(@($btnEnableFirewall, $btnDisableFirewall, $btnEnableDefender, $btnDisableDefender, $btnClearDNSCache, $btnFlushDNS, $btnRestartNetwork, $btnCheckUpdates, $btnClearEventLogs, $btnEnableHibernate, $btnDisableHibernate))

$form.Controls.AddRange(@($btnDisableServices, $btnCleanTempFiles, $btnUninstallApps, $btnOptimizeStartup, $btnDisableVisualEffects))

[void]$form.ShowDialog()