# FermentTwin – AI-Powered Virtual Fermentation Simulator

> **Simulate. Analyze. Optimize.**  
> A bioprocess digital-twin simulation platform designed for an 8-hour interdisciplinary hackathon.

---

## 🌟 Executive Summary

**FermentTwin** is a virtual bioreactor simulation platform built for industrial biotechnology monitoring, optimization, and training. It combines a **deterministic biophysical simulation engine** with an interactive **3D WebGL virtual vessel**, dynamic **Plotly analytics**, **scenario comparison**, **AI diagnostic alerts**, and **automated PDF/CSV reporting**.

---

## 🔬 Mathematical Simulation Model

All simulation curves are calculated using coupled non-linear ordinary differential equations (ODEs) integrated via **SciPy / NumPy** (`solve_ivp` RK45):

### 1. Biomass Growth Kinetics ($X$ in g/L)
$$\frac{dX}{dt} = (\mu - k_d) \cdot X$$
$$\mu = \mu_{\max} \cdot f_S(S) \cdot f_T(T) \cdot f_{pH}(pH) \cdot f_{DO}(DO) \cdot f_{shear}(N)$$

- **Substrate Limitation (Monod-Haldane Kinetics)**:
  $$f_S(S) = \frac{S}{K_S + S + \frac{S^2}{K_I}}$$
- **Cardinal Temperature Model (Ratkowsky)**: Non-linear asymmetrical bell curve with denaturation cutoff above $T_{\max}$.
- **pH Ionization Factor**: Bell-shaped Michaelis ionization centered at biological optimum.
- **Dissolved Oxygen Transfer Factor**: Clark-type hyperbolic affinity $DO / (K_{DO} + DO)$.

### 2. Substrate Mass Balance ($S$ in g/L)
$$\frac{dS}{dt} = - \left( \frac{1}{Y_{X/S}} \frac{dX}{dt} + \frac{1}{Y_{P/S}} \frac{dP}{dt} + m_S \cdot X \right)$$

### 3. Product Synthesis (Luedeking-Piret Model)
$$\frac{dP}{dt} = \alpha \frac{dX}{dt} + \beta \cdot X$$

### 4. Gas-Liquid Oxygen Mass Transfer ($DO$ in % saturation)
$$\frac{d(DO)}{dt} = k_L a \cdot (DO^* - DO) - q_{O_2} \cdot X$$
$$k_L a = 45.0 \cdot \left(\frac{RPM}{350}\right)^{0.85} \cdot (vvm)^{0.60}$$

### 5. Energetics & Thermal Dynamic Regulation ($T$ in °C)
$$\frac{dT}{dt} = Q_{met} - Q_{jacket} = \Delta H_{met} \cdot \mu \cdot X - k_{cool} \cdot (T - T_{set})$$

> **Notice of Simulated Nature**: All results, curves, and parameters are identified as simulated bioprocess outputs for virtual research, training, and algorithmic optimization.

---

## 🚀 Key Features

1. **Overview Dashboard**:
   - Live time scrubber and playback controls (Start, Pause, Reset, Step, 0.5x–10x speeds).
   - 6 dynamic metric cards: Temperature, pH, Dissolved Oxygen, Biomass, Substrate, and Batch Progress.
   - KPI yield ribbon: Biomass yield $Y_{X/S}$, Product yield $Y_{P/S}$, Volumetric productivity $Q_P$, Peak growth rate $\mu_{\max}$.
   - Mini 3D Bioreactor preview with instant status beacons.

2. **Virtual 3D Bioreactor**:
   - Interactive Three.js WebGL digital twin.
   - Transparent cylindrical glass tank with stainless steel heads and support legs.
   - Dynamic fluid broth: turbidity and color transition based on simulated cell density.
   - Rotating dual Rushton turbine impellers spinning at RPM-proportional speeds.
   - Animated rising sparged micro-bubbles scaled with aeration $vvm$ and dissolved oxygen.
   - Immersed sensor array (Temperature RTD, pH combination, Clark DO, NIR optical density).
   - Camera presets: Isometric, Impeller Core, Sensor Cluster, Top Flange.

3. **Parameter Controls**:
   - Temperature (20–45°C), pH (4–9), Dissolved Oxygen (0–100%), Substrate (0–100 g/L), Initial Biomass (0.1–5 g/L), Agitation (100–1000 RPM), Aeration (0.1–3.0 vvm), Duration (12–72 h).
   - 4 Organism Presets: *S. cerevisiae* (Bioethanol), *E. coli* BL21 (Recombinant Protein), *L. plantarum* (Lactic Acid), *P. chrysogenum* (Penicillin G).

4. **Simulation Analytics (6 Plotly Charts)**:
   - Biomass Growth Curve ($X$ vs $t$).
   - Substrate Consumption Curve ($S$ vs $t$).
   - Temperature Dynamic Trend ($T$ vs $t$).
   - pH Dynamic Trend ($pH$ vs $t$).
   - Dissolved Oxygen Trend ($DO$ vs $t$).
   - Product Formation Curve ($P$ vs $t$).
   - Modes: 6-Grid Matrix, 2-Column Split, and Single-Graph Focus with cross-hair hover.

5. **Scenario Comparison (A/B Testing)**:
   - Run baseline (Scenario A) vs modified candidate (Scenario B).
   - Dual-overlay curves with distinct cyan and amber traces.
   - Quantitative scorecard ($\Delta X$, $\Delta P$, $\Delta Y_{P/S}$, % product boost).
   - "Promote Scenario B to Baseline" button.

6. **AI Insights & Process Alerts**:
   - Optimization Health Score (0–100).
   - Categorized diagnostics: CRITICAL, WARNING, OPTIMAL.
   - Trend forecaster: predicts exact substrate exhaustion hour, peak biomass, and final product titer.
   - Actionable recommendations to eliminate bottlenecks.

7. **Reports & Session History**:
   - Download Executive Bioprocess Dossier as PDF (ReportLab).
   - Download complete 145-step time-series dataset as CSV.
   - Session history log preserving previous simulation runs with 1-click restore.

---

## 🛠️ Technology Stack

- **Frontend**: React 19, Tailwind CSS, Three.js, Plotly.js, Lucide Icons, Vite
- **Backend**: Python 3.10+, Flask, NumPy, SciPy, Pandas, ReportLab, Flask-CORS
- **Architecture**: REST API with client-side biophysical fallback for 100% offline uptime.

---

## 🏁 Quickstart Guide

### Option 1: One-Click Runner (Recommended)
Double-click `run_app.bat` or run in terminal:
```powershell
.\run_app.bat
```
This launches the Flask backend and opens `http://127.0.0.1:5000` in your default browser.

### Option 2: Development Mode (Vite HMR + Flask)
```powershell
# Terminal 1: Backend
cd backend
python app.py

# Terminal 2: Frontend
cd frontend
npm run dev
```
Open `http://localhost:3000`.
