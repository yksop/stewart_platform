function plot_stewart_ik(P_base, P_top, sol_inv, sol)

    figure('Position', [100, 100, 1400, 800], 'Name', 'Stewart Platform Inverse Kinematics');

    subplot(2, 3, [1, 2, 4, 5]);
    hold on;
    grid on;
    axis equal;

    scatter3(P_base(:,1), P_base(:,2), P_base(:,3), ...
        150, 'r', 'filled', 'o', 'MarkerEdgeColor', 'k', 'LineWidth', 2);

    scatter3(P_top(:,1), P_top(:,2), P_top(:,3), ...
        120, 'b', 'filled', 'o', 'MarkerEdgeColor', 'k', 'LineWidth', 2);

    actuator_labels = {'RR', 'RL', 'FL', 'FR'};
    actuator_lengths = [double(sol_inv.hmp_rr), double(sol_inv.hmp_rl), double(sol_inv.hmp_fl), double(sol_inv.hmp_fr)];

    for i = 1:4
        plot3([P_base(i,1), P_top(i,1)], ...
              [P_base(i,2), P_top(i,2)], ...
              [P_base(i,3), P_top(i,3)], ...
              'g-', 'LineWidth', 4);

        text(P_base(i,1), P_base(i,2), P_base(i,3)-0.05, ...
             sprintf('B_%s', actuator_labels{i}), ...
             'FontSize', 9, 'FontWeight', 'bold', 'Color', 'red', ...
             'HorizontalAlignment', 'center');

        text(P_top(i,1), P_top(i,2), P_top(i,3)+0.05, ...
             sprintf('T_%s', actuator_labels{i}), ...
             'FontSize', 9, 'FontWeight', 'bold', 'Color', 'blue', ...
             'HorizontalAlignment', 'center');
    end

    fill3(P_top(:,1), P_top(:,2), P_top(:,3), ...
          'b', 'FaceAlpha', 0.3, 'EdgeColor', 'k', 'LineWidth', 3);

    fill3(P_base(:,1), P_base(:,2), P_base(:,3), ...
          'r', 'FaceAlpha', 0.3, 'EdgeColor', 'k', 'LineWidth', 2);

    plot3([P_top(:,1); P_top(1,1)], [P_top(:,2); P_top(1,2)], [P_top(:,3); P_top(1,3)], ...
          'k-', 'LineWidth', 3);
    plot3([P_base(:,1); P_base(1,1)], [P_base(:,2); P_base(1,2)], [P_base(:,3); P_base(1,3)], ...
          'r--', 'LineWidth', 2);

    quiver3(0, 0, 0, 0.2, 0, 0, 'r', 'LineWidth', 3, 'MaxHeadSize', 0.1);
    quiver3(0, 0, 0, 0, 0.2, 0, 'g', 'LineWidth', 3, 'MaxHeadSize', 0.1);
    quiver3(0, 0, 0, 0, 0, 0.2, 'b', 'LineWidth', 3, 'MaxHeadSize', 0.1);
    text(0.22, 0, 0, 'X', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'r');
    text(0, 0.22, 0, 'Y', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'g');
    text(0, 0, 0.22, 'Z', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'b');

    xlabel('X [m]', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Y [m]', 'FontSize', 12, 'FontWeight', 'bold');
    zlabel('Z [m]', 'FontSize', 12, 'FontWeight', 'bold');
    title('Inverse Kinematics', 'FontSize', 16, 'FontWeight', 'bold');

    view(45, 30);

    legend({'Base Points (P_{base})', 'Platform Points (P_{top})'}, ...
           'Location', 'northeast');

    % Computed Actuator Lengths
    subplot(2, 3, 3);
    bar(1:4, actuator_lengths, 'FaceColor', [0.5, 0.8, 1], 'EdgeColor', 'k', 'LineWidth', 1.5);
    grid on;
    xlabel('Actuator Number', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Length [m]', 'FontSize', 12, 'FontWeight', 'bold');
    title('Computed Actuator Lengths', 'FontSize', 14, 'FontWeight', 'bold');
    set(gca, 'XTick', 1:4, 'XTickLabel', {'1(RR)', '2(RL)', '3(FL)', '4(FR)'});

    for i = 1:4
        text(i, actuator_lengths(i) + 0.015, sprintf('%.3f', actuator_lengths(i)), ...
             'HorizontalAlignment', 'center', 'FontWeight', 'bold');
    end

    % Desired Input Parameters
    subplot(2, 3, 6);
    desired_params = [sol.z_mp, sol.phi_mp * 180/pi, sol.theta_mp * 180/pi];
    param_labels = {'Z [m]', '\phi [°]', '\theta [°]'};
    colors = [0.2, 0.7, 0.3; 1, 0.6, 0.8; 1, 0.6, 0.8];

    bar(1:3, desired_params, 'FaceColor', 'flat', 'CData', colors, 'EdgeColor', 'k', 'LineWidth', 1.5);
    grid on;
    xlabel('Desired Parameters', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Value', 'FontSize', 12, 'FontWeight', 'bold');
    title('Desired Input Parameters', 'FontSize', 14, 'FontWeight', 'bold');
    set(gca, 'XTick', 1:3, 'XTickLabel', param_labels);
    
    for i = 1:3
        if i == 1
            text(i, desired_params(i) + sign(desired_params(i)) * 0.02, sprintf('%.3f', desired_params(i)), ...
                 'HorizontalAlignment', 'center', 'FontWeight', 'bold');
        else
            text(i, desired_params(i) + sign(desired_params(i)) * 0.2, sprintf('%.2f', desired_params(i)), ...
                 'HorizontalAlignment', 'center', 'FontWeight', 'bold');
        end
    end
    
    hold on;
    plot([0.5, 3.5], [0, 0], 'k--', 'LineWidth', 1);
    hold off;
   
end