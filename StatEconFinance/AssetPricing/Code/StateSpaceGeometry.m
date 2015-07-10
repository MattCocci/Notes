function [] = StateSpaceGeometry()

  close all

  %% Colors and helper functions
  gray   = [0.70  0.70  0.70];
  blue   = [0.40  0.75  1.00];
  orange = [1.00  0.59  0.40];
  black  = [0.33  0.30  0.33];
  green  = [0.49  0.88  0.49];

  %% Main Vectors and some proj.bections/computations
  v.a = [2 1]';
  v.b = [1 1]';
  v.c = [2 2.5]';
  v.o = [0 0]';

  vs = {'b', 'c'};
  for n = 1:length(vs)
    vv = vs{n};
    beta.(vv) = inv(v.a'*v.a)*v.a'*v.(vv);
    proj.(vv) = beta.(vv)*v.a;

    runRise.(vv)    = proj.(vv)-v.(vv);
    slope.(vv)      = runRise.(vv)(2)/runRise.(vv)(1);
    yintercept.(vv) = v.(vv)(2) - v.(vv)(1)*slope.(vv);
    xintercept.(vv) = -yintercept.(vv)/slope.(vv);
  end



  %% Function to draw arrow and add annote
  function [H] = myarrow(base, point, color)
    if ~exist('color', 'var')
      color = black;
    end

    H = arrow(base, point, 3, 'FaceColor', color, 'EdgeColor', color);
    text(point(1), point(2)-0.01*diff(ylim()), sprintf('(%2.1f,%2.1f)', point(1), point(2)), 'FontSize', 14);
  end


  %% Fig1: Starting plot: Just vector v.a and its direction
  function [fig] = Fig1(hoff)
    fig = figure();
    hold on

    plot([0 v.a(1)*10], [0 v.a(2)*10], ':', 'Color', gray);
    myarrow(v.o,v.a);

    if hoff
      hold off
    end
  end


  %% Fig2: Add vector v.b to Fig1
  function [fig] = Fig2(hoff)
    fig = Fig1(0);

    myarrow(v.o, v.b, blue);

    if hoff
      hold off
    end
  end


  %% Fig3: Show proj.bection of y1 onto v.a, with the epsilon
  function [fig] = Fig3(hoff)
    fig = Fig2(0);

    myarrow(v.o, proj.b, blue);
    myarrow(v.b, proj.b, orange);

    if hoff
      hold off
    end
  end


  %% Fig4: Extend epsilon line
  function [fig] = Fig4(hoff)
    fig = Fig3(0);

    plot([0 xintercept.b], [yintercept.b 0], ':', 'Color', gray)

    if hoff
      hold off
    end
  end

  %% Fig5: Many vectors along epsilon line
  function [fig] = Fig5(hoff)
    fig = Fig2(0);

    plot([0 xintercept.b], [yintercept.b 0], ':', 'Color', gray)
    myarrow(v.o, proj.b, blue);
    for w = -3:1:2
      myarrow(v.o, w*proj.b+(1-w)*v.b, blue);
    end

    if hoff
      hold off
    end
  end

  %% Fig5: Show for other line
  function [fig] = Fig6(hoff)
    fig = Fig4(0);

    myarrow(v.o, v.c, green);
    myarrow(v.o, proj.c, green);
    myarrow(v.c, proj.c, orange);
    plot([0 xintercept.c], [yintercept.c 0], ':', 'Color', gray)

    if hoff
      hold off
    end
  end


  fig.f1 = Fig1(1);
  fig.f2 = Fig2(1);
  fig.f3 = Fig3(1);
  fig.f4 = Fig4(1);
  fig.f5 = Fig5(1);
  fig.f6 = Fig6(1);


  lim = [0 3];
  f = fieldnames(fig);
  for n = 1:length(f)
    figure(fig.(f{n}))
    axis([lim, lim])
    set(gca(), 'FontSize', 16)
  end

end
