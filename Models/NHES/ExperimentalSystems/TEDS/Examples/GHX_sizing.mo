within NHES.ExperimentalSystems.TEDS.Examples;
model GHX_sizing
  "Test designed to ensure the TEDS loop can operate in all modes."

  parameter Real FV_opening=0.250;

  Modelica.Fluid.Sources.MassFlowSource_T Chiller_Mass_Flow(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    use_m_flow_in=false,
    m_flow=12.436347384722,
    T=279.816666,
    nPorts=1)
    annotation (Placement(transformation(extent={{-34,-226},{-14,-206}})));

  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    p=300000,
    T=291.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{210,-200},{190,-220}})));

  TRANSFORM.HeatExchangers.GenericDistributed_HX Glycol_HX(
    p_b_start_shell=105000,
    T_a_start_shell=523.15,
    T_b_start_shell=473.15,
    p_b_start_tube=145000,
    counterCurrent=true,
    m_flow_a_start_tube=12,
    m_flow_a_start_shell=1,
    redeclare package Medium_tube =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
    redeclare package Medium_shell =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS316,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
        (
        D_o_shell=0.192,
        nV=10,
        nTubes=113,
        nR=3,
        length_shell=3.0,
        dimension_tube=0.013,
        length_tube=3.0,
        th_wall=0.0001),
    p_a_start_tube=150000,
    T_a_start_tube=285.15,
    T_b_start_tube=298.15,
    p_a_start_shell=110000,
    redeclare model HeatTransfer_tube =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple
        (CF=1.0),
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple
        (CF=2.0))
    annotation (Placement(transformation(extent={{69,-224},{100,-194}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Ethylene_glycol_exit_temperature(
      redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
      precision=3)
    annotation (Placement(transformation(extent={{140,-222},{170,-198}})));
  Modelica.Blocks.Sources.RealExpression Q_GHX(y=Glycol_HX.port_a_shell.m_flow*
        (Oil_Mass_Flow.ports[1].h_outflow - Glycol_HX.port_b_shell.h_outflow))
    annotation (Placement(transformation(extent={{72,-252},{94,-230}})));
  Modelica.Fluid.Sources.MassFlowSource_T Oil_Mass_Flow(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    use_m_flow_in=false,
    m_flow=1*1.73696520202777777777,
    T=598.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{158,-174},{138,-154}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C,
    p=300000,
    T=291.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-76,-156},{-56,-176}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Oil_exit_temperature(redeclare
      package Medium =
        TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C, precision
      =3) annotation (Placement(transformation(extent={{22,-178},{-8,-154}})));
  Modelica.Blocks.Sources.RealExpression Q_GHX1(y=Oil_Mass_Flow.ports[1].h_outflow)
    annotation (Placement(transformation(extent={{68,-110},{90,-88}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Ethylene_glycol_exit_temperature1(
      redeclare package Medium =
        TRANSFORM.Media.Fluids.EthyleneGlycol.LinearEthyleneGlycol_50_Water,
      precision=3)
    annotation (Placement(transformation(extent={{20,-228},{50,-204}})));
equation
  connect(Glycol_HX.port_b_tube, Ethylene_glycol_exit_temperature.port_a)
    annotation (Line(points={{100,-209},{100,-210},{140,-210}},           color=
         {0,127,255}));
  connect(Ethylene_glycol_exit_temperature.port_b, boundary1.ports[1])
    annotation (Line(points={{170,-210},{190,-210}}, color={0,127,255}));
  connect(Oil_exit_temperature.port_b, boundary2.ports[1])
    annotation (Line(points={{-8,-166},{-56,-166}}, color={0,127,255}));
  connect(Oil_Mass_Flow.ports[1], Glycol_HX.port_a_shell) annotation (Line(
        points={{138,-164},{106,-164},{106,-202.1},{100,-202.1}}, color={0,127,
          255}));
  connect(Glycol_HX.port_b_shell, Oil_exit_temperature.port_a) annotation (Line(
        points={{69,-202.1},{56,-202.1},{56,-166},{22,-166}}, color={0,127,255}));
  connect(Chiller_Mass_Flow.ports[1], Ethylene_glycol_exit_temperature1.port_a)
    annotation (Line(points={{-14,-216},{20,-216}}, color={0,127,255}));
  connect(Ethylene_glycol_exit_temperature1.port_b, Glycol_HX.port_a_tube)
    annotation (Line(points={{50,-216},{64,-216},{64,-209},{69,-209}}, color={0,
          127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-220},{240,
            140}}), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-156,-208},{232,138}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-24,68},{176,-30},{-24,-150},{-24,68}})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-220},{
            240,140}})),
    experiment(
      StopTime=16000,
      Interval=10,
      Tolerance=0.001,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_Commands(file="../../TEDS/Basic_TEDS_setup.mos" "Basic_TEDS_setup",
        file="../../TEDS/M3_TEDS.mos" "M3_TEDS"),
    conversion(noneFromVersion=""));
end GHX_sizing;
