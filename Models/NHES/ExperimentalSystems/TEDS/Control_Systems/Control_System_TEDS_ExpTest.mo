within NHES.ExperimentalSystems.TEDS.Control_Systems;
model Control_System_TEDS_ExpTest
  "Runs all Modes of the TEDS system with Milestone controllers (Manual inputs for load, hence why there are two controllers)"

  parameter Real FV_opening=0.00250;

  BaseClasses.SignalSubBus_ActuatorInput SensorSubBus
    annotation (Placement(transformation(extent={{-58,-122},{-10,-76}})));
  BaseClasses.SignalSubBus_SensorOutput ActuatorSubBus
    annotation (Placement(transformation(extent={{16,-122},{64,-76}})));
  Modelica.Blocks.Sources.RealExpression PV004(y=1)
    annotation (Placement(transformation(extent={{-30,138},{-10,158}})));

parameter SI.Temperature T_hot_design = 300;

  Modelica.Blocks.Sources.RealExpression PV008(y=1)
    annotation (Placement(transformation(extent={{-28,70},{-8,90}})));
  TRANSFORM.Controls.LimPID PV012(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-0.0004,
    Ti=5,
    yMax=0.999,
    yMin=0.001,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.5)
    annotation (Placement(transformation(extent={{-160,-4},{-148,8}})));
  Modelica.Blocks.Sources.CombiTimeTable T_GHXout(table=[0,400; 2220,400; 2400,400;
        9180,400; 9280,138; 10980,138; 11080,138; 14640,138; 14740,138; 15740,138],
      startTime=0)
    annotation (Placement(transformation(extent={{-436,-2},{-414,20}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-210,-8},{-190,12}})));
  Modelica.Blocks.Sources.Constant const3(k=273.15)      annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={-236,-4})));
  Modelica.Blocks.Sources.RealExpression Heater_BOP_Demand1(y=1 - PV012.y)
    annotation (Placement(transformation(extent={{-28,44},{-6,66}})));
  Modelica.Blocks.Sources.RealExpression GPMconversion(y=15850.323140625002)
    annotation (Placement(transformation(extent={{-336,174},{-314,196}})));
  Modelica.Blocks.Math.Product FM_001_gpm
    annotation (Placement(transformation(extent={{-264,176},{-254,186}})));
  Modelica.Blocks.Sources.CombiTimeTable Flow(table=[0,44; 2220,44; 2400,34; 2760,
        34; 2860,23; 3120,23; 3220,15; 3840,15; 3940,13; 5280,13; 5380,11.2; 9180,
        11.2; 9280,10.1; 10980,10.8; 11080,11.1; 14640,11.1; 14740,12; 15740,12],
      startTime=0)
    annotation (Placement(transformation(extent={{-446,194},{-432,208}})));
  TRANSFORM.Controls.LimPID VolFlow_Control(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.04,
    Ti=50,
    yMax=0.99,
    yMin=0.01,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.5)
    annotation (Placement(transformation(extent={{-180,194},{-168,206}})));
  Modelica.Blocks.Sources.RealExpression Conversion_lpm(y=1/15850.323140625002*1000
        *60)
    annotation (Placement(transformation(extent={{-246,212},{-224,234}})));
  Modelica.Blocks.Math.Product FM_1
    annotation (Placement(transformation(extent={{-182,216},{-172,226}})));
  Modelica.Blocks.Sources.CombiTimeTable PV006(table=[0,1; 2220,1; 2400,
        FV_opening; 9180,FV_opening; 9280,1; 10980,1; 11080,FV_opening; 14640,
        FV_opening; 14740,1; 15740,1], startTime=0)
    annotation (Placement(transformation(extent={{-448,110},{-434,124}})));
  Modelica.Blocks.Sources.CombiTimeTable PV049_PV052(table=[0,0; 2220,0; 2400,1;
        9180,1; 9280,0; 10980,0; 11080,0; 14640,0; 14740,0; 15740,0], startTime=
       0) annotation (Placement(transformation(extent={{-436,-40},{-422,-26}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder5(
    T=5,
    initType=Modelica.Blocks.Types.Init.NoInit,
    y_start=1)
    annotation (Placement(transformation(extent={{-312,-78},{-300,-66}})));
  Modelica.Blocks.Sources.CombiTimeTable PV050_PV051(table=[0,0.001; 2220,0; 2400,
        0; 9180,0; 9280,0; 10980,0; 11080,1; 14640,1; 14740,0; 15740,0],
      startTime=0)
    annotation (Placement(transformation(extent={{-436,-60},{-422,-46}})));
  TRANSFORM.Controls.LimPID Chromolox_Heater_Control(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=10,
    Ti=0.03,
    k_s=1,
    k_m=1,
    yMax=225e3,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=200e3)
    annotation (Placement(transformation(extent={{-204,266},{-192,278}})));
  Modelica.Blocks.Sources.Constant const4(k=273.15)      annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={-288,278})));
  Modelica.Blocks.Sources.CombiTimeTable THeater(table=[0,300; 3000,300; 3060,250;
        10980,250; 11080,0; 12000,0.0], startTime=0)
    annotation (Placement(transformation(extent={{-436,296},{-422,310}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{-246,272},{-226,292}})));
  Modelica.Blocks.Sources.Constant const2(k=12.6)
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={-80,308})));
  Modelica.Blocks.Math.Gain Gain(k=1)
    annotation (Placement(transformation(extent={{-410,110},{-396,124}})));
  Modelica.Blocks.Math.Gain Gain1(k=1)
    annotation (Placement(transformation(extent={{-266,-60},{-252,-46}})));
  Modelica.Blocks.Math.Gain Gain2(k=1)
    annotation (Placement(transformation(extent={{-394,-36},{-380,-22}})));
equation

  connect(ActuatorSubBus.PV008, PV008.y) annotation (Line(
      points={{40,-99},{40,80},{-7,80}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ActuatorSubBus.PV004, PV004.y) annotation (Line(
      points={{40,-99},{40,148},{-9,148}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(T_GHXout.y[1], add.u1) annotation (Line(points={{-412.9,9},{-220,9},{
          -220,8},{-212,8}},
                        color={0,0,127}));
  connect(const3.y,add. u2) annotation (Line(points={{-231.6,-4},{-212,-4}},
                                 color={0,0,127}));
  connect(add.y, PV012.u_s)
    annotation (Line(points={{-189,2},{-161.2,2}}, color={0,0,127}));
  connect(SensorSubBus.TC006, PV012.u_m) annotation (Line(
      points={{-34,-99},{-154,-99},{-154,-5.2}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ActuatorSubBus.PV012, PV012.y) annotation (Line(
      points={{40,-99},{40,2},{-147.4,2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ActuatorSubBus.PV009, Heater_BOP_Demand1.y) annotation (Line(
      points={{40,-99},{40,55},{-4.9,55}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(GPMconversion.y,FM_001_gpm. u1) annotation (Line(points={{-312.9,185},
          {-312.9,184},{-265,184}}, color={0,0,127}));
  connect(Flow.y[1], VolFlow_Control.u_s) annotation (Line(points={{-431.3,201},
          {-186,201},{-186,200},{-181.2,200}}, color={0,0,127}));
  connect(FM_001_gpm.y, VolFlow_Control.u_m) annotation (Line(points={{-253.5,
          181},{-253.5,180},{-174,180},{-174,192.8}},
                                                 color={0,0,127}));
  connect(Conversion_lpm.y,FM_1. u1) annotation (Line(points={{-222.9,223},{
          -220,224},{-183,224}},
                           color={0,0,127}));
  connect(Flow.y[1],FM_1. u2) annotation (Line(points={{-431.3,201},{-190,201},
          {-190,218},{-183,218}},
                           color={0,0,127}));
  connect(SensorSubBus.Volume_flow_rate, FM_001_gpm.u2) annotation (Line(
      points={{-34,-99},{-120,-99},{-120,164},{-265,164},{-265,178}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ActuatorSubBus.Valve_fl, VolFlow_Control.y) annotation (Line(
      points={{40,-99},{40,200},{-167.4,200}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PV050_PV051.y[1], firstOrder5.u) annotation (Line(points={{-421.3,-53},
          {-421.3,-54},{-320,-54},{-320,-72},{-313.2,-72}}, color={0,0,127}));
  connect(ActuatorSubBus.PV051, firstOrder5.y) annotation (Line(
      points={{40,-99},{40,-70},{-299.4,-70},{-299.4,-72}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(const4.y,add1. u2) annotation (Line(points={{-283.6,278},{-256,278},{
          -256,276},{-248,276}},
                               color={0,0,127}));
  connect(THeater.y[1],add1. u1) annotation (Line(points={{-421.3,303},{-421.3,
          296},{-416,296},{-416,288},{-248,288}},
                                              color={0,0,127}));
  connect(add1.y,Chromolox_Heater_Control. u_s) annotation (Line(points={{-225,
          282},{-210,282},{-210,272},{-205.2,272}},
                                                color={0,0,127}));
  connect(SensorSubBus.TC003, Chromolox_Heater_Control.u_m) annotation (Line(
      points={{-34,-99},{-64,-99},{-64,-100},{-120,-100},{-120,252},{-198,252},
          {-198,264.8}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ActuatorSubBus.W_heater, Chromolox_Heater_Control.y) annotation (Line(
      points={{40,-99},{40,272},{-191.4,272}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ActuatorSubBus.M_dot_glycol, const2.y) annotation (Line(
      points={{40,-99},{40,308},{-75.6,308}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PV006.y[1], Gain.u) annotation (Line(points={{-433.3,117},{-433.3,118},
          {-411.4,118},{-411.4,117}}, color={0,0,127}));
  connect(ActuatorSubBus.PV006[1], Gain.y) annotation (Line(
      points={{40,-99},{40,117},{-395.3,117}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PV049_PV052.y[1], Gain2.u) annotation (Line(points={{-421.3,-33},{
          -410,-33},{-410,-29},{-395.4,-29}}, color={0,0,127}));
  connect(ActuatorSubBus.PV049, Gain2.y) annotation (Line(
      points={{40,-99},{40,-29},{-379.3,-29}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ActuatorSubBus.PV050[1], Gain1.y) annotation (Line(
      points={{40,-99},{40,-53},{-251.3,-53}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PV050_PV051.y[1], Gain1.u)
    annotation (Line(points={{-421.3,-53},{-267.4,-53}}, color={0,0,127}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},
            {120,140}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-180,-100},{120,140}})));
end Control_System_TEDS_ExpTest;
