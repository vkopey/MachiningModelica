model my
  Modelica.Mechanics.Translational.Components.Fixed fixed annotation(
    Placement(visible = true, transformation(origin = {-90, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Mass mass(m = 7, s(fixed = true), v(fixed = true))  annotation(
    Placement(visible = true, transformation(origin = {-38, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.SpringDamper springDamper(c = 1e7, d = 3000)  annotation(
    Placement(visible = true, transformation(origin = {-66, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Noise.NormalNoise normalNoise(mu = 100, samplePeriod = 0.0001,sigma = 10, useAutomaticLocalSeed = true, useGlobalSeed = true)  annotation(
    Placement(visible = true, transformation(origin = {-84, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sources.Force force annotation(
    Placement(visible = true, transformation(origin = {-38, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Blocks.Noise.GlobalSeed globalSeed(enableNoise = true, useAutomaticSeed = true)  annotation(
    Placement(visible = true, transformation(origin = {-60, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sensors.PositionSensor positionSensor annotation(
    Placement(visible = true, transformation(origin = {-10, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Abs abs1 annotation(
    Placement(visible = true, transformation(origin = {68, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {40, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Mean mean(f = 10)  annotation(
    Placement(visible = true, transformation(origin = {24, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Mean mean1(f = 10)  annotation(
    Placement(visible = true, transformation(origin = {98, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(fixed.flange, springDamper.flange_a) annotation(
    Line(points = {{-90, 16}, {-76, 16}}, color = {0, 127, 0}));
  connect(springDamper.flange_b, mass.flange_a) annotation(
    Line(points = {{-56, 16}, {-48, 16}}, color = {0, 127, 0}));
  connect(force.flange, mass.flange_b) annotation(
    Line(points = {{-28, -38}, {-28, 16}}, color = {0, 127, 0}));
  connect(mass.flange_b, positionSensor.flange) annotation(
    Line(points = {{-28, 16}, {-20, 16}}, color = {0, 127, 0}));
  connect(positionSensor.s, feedback.u1) annotation(
    Line(points = {{1, 16}, {6, 16}, {6, 46}, {32, 46}}, color = {0, 0, 127}));
  connect(feedback.y, abs1.u) annotation(
    Line(points = {{49, 46}, {56, 46}}, color = {0, 0, 127}));
  connect(positionSensor.s, mean.u) annotation(
    Line(points = {{1, 16}, {12, 16}}, color = {0, 0, 127}));
  connect(mean.y, feedback.u2) annotation(
    Line(points = {{35, 16}, {40, 16}, {40, 38}}, color = {0, 0, 127}));
  connect(abs1.y, mean1.u) annotation(
    Line(points = {{79, 46}, {86, 46}}, color = {0, 0, 127}));
  connect(normalNoise.y, force.f) annotation(
    Line(points = {{-73, -38}, {-50, -38}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "3.2.3")),
    Diagram(coordinateSystem(extent = {{-100, -100}, {200, 100}})),
    Icon(coordinateSystem(extent = {{-100, -100}, {200, 100}})),
    version = "");
end my;
