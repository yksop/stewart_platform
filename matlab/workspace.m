function workspace(max_height, min_height, range_theta, range_phi)
    Y = 1.6;
    X = 0.82;
    range_z = max_height - min_height;
    
    vertices = [
            -X, -Y, min_height;  
            X, -Y, min_height;   
            X, Y, min_height;    
            -X, Y, min_height;   
            -X, -Y, max_height;  
            X, -Y, max_height;   
            X, Y, max_height;    
            -X, Y, max_height    
        ];
    
        faces = [
            1, 2, 3, 4;  
            5, 6, 7, 8;  
            1, 2, 6, 5;  
            3, 4, 8, 7; 
            1, 4, 8, 5;  
            2, 3, 7, 6   
        ];
    
        fig_workspace = figure('Name', 'Platform Workspace Envelope', ...
            'NumberTitle', 'off', ...
            'Position', [100, 100, 1000, 700]);
        clf(fig_workspace);
        hold off;
        
        patch('Vertices', vertices, 'Faces', faces, ...
            'FaceColor', 'cyan', 'FaceAlpha', 0.2, ...
            'EdgeColor', 'blue', 'LineWidth', 1.5);
        
        axis equal;
        grid on;
        view(3);
        xlabel('X [m]');
        ylabel('Y [m]');
        zlabel('Z [m]');
        title('Platform Workspace - Translational Envelope');
        hold on;
        
        plot3(0, 0, (min_height + max_height)/2, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'red');
        text(0, 0, (min_height + max_height)/2 + 0.02, 'Platform Center', 'HorizontalAlignment', 'center');
            
        P_base = [
            -X, -Y, 0;   
            X, -Y, 0;     
            X, Y, 0;      
            -X, Y, 0      
        ];
        
        neutral_height = (min_height + max_height) / 2;
        P_platform = [
            -X, -Y, neutral_height;
            X, -Y, neutral_height;
            X, Y, neutral_height;
            -X, Y, neutral_height
        ];
        
        actuator_colors = {'red', 'green', 'blue', 'magenta'};
        
        for i = 1:4
            plot3(P_base(i,1), P_base(i,2), P_base(i,3), 'ks', ...
                'MarkerSize', 8, 'MarkerFaceColor', 'black');
            
            plot3(P_platform(i,1), P_platform(i,2), P_platform(i,3), 'o', ...
                'Color', actuator_colors{i}, 'MarkerSize', 6, 'MarkerFaceColor', actuator_colors{i});
            
            plot3([P_base(i,1), P_platform(i,1)], ...
                  [P_base(i,2), P_platform(i,2)], ...
                  [P_base(i,3), P_platform(i,3)], ...
                  'Color', actuator_colors{i}, 'LineWidth', 2);
        end
        
        base_vertices = [P_base; P_base(1,:)]; 
        plot3(base_vertices(:,1), base_vertices(:,2), base_vertices(:,3), ...
            'k-', 'LineWidth', 1.5);
        
        platform_vertices = [P_platform; P_platform(1,:)]; 
        plot3(platform_vertices(:,1), platform_vertices(:,2), platform_vertices(:,3), ...
            'r-', 'LineWidth', 1.5);
        
        view(45, 30);
    
        % xlim([-1.5 * 2, 1.5 * 2]);
        
        text_str = sprintf('Z range: %.3f m', ...
            range_z);
        text(min(vertices(:,1)), max(vertices(:,2)), max(vertices(:,3)), text_str, ...
            'FontSize', 10, 'BackgroundColor', 'white', 'EdgeColor', 'black');
        fig_theta = figure('Name', 'Theta Workspace Visualization', ...
            'NumberTitle', 'off', ...
            'Position', [900, 100, 800, 600]);
        
        clf(fig_theta);
        
        theta_max = deg2rad(- range_theta/2) / 2;
        theta_steps = 50;
        theta_range = linspace(-theta_max, theta_max, theta_steps);
            
        hold on;
        colors = jet(length(theta_range));
        
        for i = 1:length(theta_range)
            theta = theta_range(i);
            
            R_theta = [cos(theta), 0, sin(theta);
                       0, 1, 0;
                       -sin(theta), 0, cos(theta)];
            
            platform_corners = [
                -X, -Y, 0;
                X, -Y, 0;
                X, Y, 0;
                -X, Y, 0
            ];
            
            rotated_corners = (R_theta * platform_corners')';
            
            rotated_corners(:,3) = rotated_corners(:,3) + neutral_height;
            
            platform_poly = [rotated_corners; rotated_corners(1,:)];
    
            plot3(platform_poly(:,1), platform_poly(:,2), platform_poly(:,3), ...
                'Color', colors(i,:), 'LineWidth', 1.5);
            
            if i == 1 || i == length(theta_range) || abs(theta) < 0.01
                fill3(rotated_corners([1:4,1],1), rotated_corners([1:4,1],2), ...
                      rotated_corners([1:4,1],3), colors(i,:), ...
                      'FaceAlpha', 0.3, 'EdgeColor', colors(i,:));
            end
        end
        
        base_corners = [
            -X, -Y, 0;
            X, -Y, 0;
            X, Y, 0;
            -X, Y, 0
        ];
        base_poly = [base_corners; base_corners(1,:)];
        plot3(base_poly(:,1), base_poly(:,2), base_poly(:,3), ...
            'k-', 'LineWidth', 2);
        
        extreme_indices = [1, length(theta_range)];
        actuator_colors_theta = {'red', 'blue'};
        
        for idx = 1:length(extreme_indices)
            i = extreme_indices(idx);
            theta = theta_range(i);
            
            R_theta = [cos(theta), 0, sin(theta);
                       0, 1, 0;
                       -sin(theta), 0, cos(theta)];
            
            platform_corners = [
                -X, -Y, 0;
                X, -Y, 0;
                X, Y, 0;
                -X, Y, 0
            ];
            rotated_corners = (R_theta * platform_corners')';
            rotated_corners(:,3) = rotated_corners(:,3) + neutral_height;
            
            for j = 1:4
                plot3([P_base(j,1), rotated_corners(j,1)], ...
                      [P_base(j,2), rotated_corners(j,2)], ...
                      [P_base(j,3), rotated_corners(j,3)], ...
                      'Color', actuator_colors_theta{idx}, 'LineWidth', 2, ...
                      'LineStyle', '--');
            end
        end
        
        plot3(0, 0, neutral_height, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'black');
        
        axis equal;
        grid on;
        view(45, 20);
        xlabel('X [m]');
        ylabel('Y [m]');
        zlabel('Z [m]');
        title(sprintf('Theta Workspace Visualization (±%.1f°)', range_theta/2));
        
        colormap(jet);
        c = colorbar;
        c.Label.String = 'Theta Angle';
        c.Ticks = [0 0.5 1];
        c.TickLabels = {sprintf('-%.1f°', range_theta/2), '0°', sprintf('+%.1f°', range_theta/2)};
        
        hold off;
            fig_phi = figure('Name', 'Phi Workspace Visualization', ...
            'NumberTitle', 'off', ...
            'Position', [1200, 100, 800, 600]);
        clf(fig_phi);
        
        phi_max = deg2rad(range_phi/2) / 2;
        phi_steps = 50;
        phi_range = linspace(-phi_max, phi_max, phi_steps);
        
        hold on;
        colors_phi = jet(length(phi_range));
        
        for i = 1:length(phi_range)
            phi = phi_range(i);
            
            R_phi = [1, 0, 0;
                     0, cos(phi), -sin(phi);
                     0, sin(phi), cos(phi)];
            
            platform_corners = [
                -X, -Y, 0;
                X, -Y, 0;
                X, Y, 0;
                -X, Y, 0
            ];
            
            rotated_corners = (R_phi * platform_corners')';
            
            rotated_corners(:,3) = rotated_corners(:,3) + neutral_height;
            
            platform_poly = [rotated_corners; rotated_corners(1,:)];
            
            plot3(platform_poly(:,1), platform_poly(:,2), platform_poly(:,3), ...
                'Color', colors_phi(i,:), 'LineWidth', 1.5);
            
            if i == 1 || i == length(phi_range) || abs(phi) < 0.01
                fill3(rotated_corners([1:4,1],1), rotated_corners([1:4,1],2), ...
                      rotated_corners([1:4,1],3), colors_phi(i,:), ...
                      'FaceAlpha', 0.3, 'EdgeColor', colors_phi(i,:));
            end
        end
        
        plot3(base_poly(:,1), base_poly(:,2), base_poly(:,3), ...
            'k-', 'LineWidth', 2);
        
        extreme_indices_phi = [1, length(phi_range)];
        actuator_colors_phi = {'red', 'green'};
        
        for idx = 1:length(extreme_indices_phi)
            i = extreme_indices_phi(idx);
            phi = phi_range(i);
            
            R_phi = [1, 0, 0;
                     0, cos(phi), -sin(phi);
                     0, sin(phi), cos(phi)];
            
            platform_corners = [
                -X, -Y, 0;
                X, -Y, 0;
                X, Y, 0;
                -X, Y, 0
            ];
            rotated_corners = (R_phi * platform_corners')';
            rotated_corners(:,3) = rotated_corners(:,3) + neutral_height;
            
            for j = 1:4
                plot3([P_base(j,1), rotated_corners(j,1)], ...
                      [P_base(j,2), rotated_corners(j,2)], ...
                      [P_base(j,3), rotated_corners(j,3)], ...
                      'Color', actuator_colors_phi{idx}, 'LineWidth', 2, ...
                      'LineStyle', '--');
            end
        end
        
        plot3(0, 0, neutral_height, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'black');
        
        axis equal;
        grid on;
        view(30, 20); 
        xlabel('X [m]');
        ylabel('Y [m]');
        zlabel('Z [m]');
        title(sprintf('Phi Workspace Visualization (±%.1f°)', - range_phi/2));
        
        colormap(jet);
        c = colorbar;
        c.Label.String = 'Phi Angle';
        c.Ticks = [0 0.5 1];
        c.TickLabels = {sprintf('-%.1f°', - range_phi/2), '0°', sprintf('+%.1f°', - range_phi/2)};
        
        hold off;
    fig_combined = figure('Name', 'Complete Platform Workspace', ...
        'NumberTitle', 'off', ...
        'Position', [50, 50, 800, 600]);
    clf(fig_combined);
    
    % Single plot: Combined workspace - overlay of all three workspaces
    hold on;
    
    % Calculate neutral height and workspace parameters
    neutral_height = (min_height + max_height) / 2;
    theta_max = deg2rad(range_theta/2);
    phi_max = deg2rad(range_phi/2);
    
    % 1. Add translational workspace (Z) - base envelope
    vertices = [
        -X, -Y, min_height;  
        X, -Y, min_height;   
        X, Y, min_height;    
        -X, Y, min_height;   
        -X, -Y, max_height;  
        X, -Y, max_height;   
        X, Y, max_height;    
        -X, Y, max_height    
    ];
    
    faces = [
        1, 2, 3, 4;  
        5, 6, 7, 8;  
        1, 2, 6, 5;  
        3, 4, 8, 7; 
        1, 4, 8, 5;  
        2, 3, 7, 6   
    ];
    
    patch('Vertices', vertices, 'Faces', faces, ...
        'FaceColor', 'cyan', 'FaceAlpha', 0.1, ...
        'EdgeColor', 'blue', 'LineWidth', 1.5);
    
    % 2. Add theta workspace envelope
    theta_range_combined = linspace(-theta_max, theta_max, 30);
    
    for i = 1:length(theta_range_combined)
        theta = theta_range_combined(i);
        R_theta = [cos(theta), 0, sin(theta);
                   0, 1, 0;
                   -sin(theta), 0, cos(theta)];
        
        platform_corners = [-X, -Y, 0; X, -Y, 0; X, Y, 0; -X, Y, 0];
        rotated_corners = (R_theta * platform_corners')';
        rotated_corners(:,3) = rotated_corners(:,3) + neutral_height;
        
        platform_poly = [rotated_corners; rotated_corners(1,:)];
        plot3(platform_poly(:,1), platform_poly(:,2), platform_poly(:,3), ...
            'Color', [1, 0, 0, 0.3], 'LineWidth', 1);
        
        % Fill extreme positions
        if i == 1 || i == length(theta_range_combined)
            fill3(rotated_corners([1:4,1],1), rotated_corners([1:4,1],2), ...
                  rotated_corners([1:4,1],3), 'red', ...
                  'FaceAlpha', 0.2, 'EdgeColor', 'red');
        end
    end
    
    % 3. Add phi workspace envelope
    phi_range_combined = linspace(-phi_max, phi_max, 30);
    
    for i = 1:length(phi_range_combined)
        phi = phi_range_combined(i);
        R_phi = [1, 0, 0;
                 0, cos(phi), -sin(phi);
                 0, sin(phi), cos(phi)];
        
        platform_corners = [-X, -Y, 0; X, -Y, 0; X, Y, 0; -X, Y, 0];
        rotated_corners = (R_phi * platform_corners')';
        rotated_corners(:,3) = rotated_corners(:,3) + neutral_height;
        
        platform_poly = [rotated_corners; rotated_corners(1,:)];
        plot3(platform_poly(:,1), platform_poly(:,2), platform_poly(:,3), ...
            'Color', [0, 1, 0, 0.3], 'LineWidth', 1);
        
        % Fill extreme positions
        if i == 1 || i == length(phi_range_combined)
            fill3(rotated_corners([1:4,1],1), rotated_corners([1:4,1],2), ...
                  rotated_corners([1:4,1],3), 'green', ...
                  'FaceAlpha', 0.2, 'EdgeColor', 'green');
        end
    end
    
    % 4. Add base and platform references
    P_base = [-X, -Y, 0; X, -Y, 0; X, Y, 0; -X, Y, 0];
    P_platform = [-X, -Y, neutral_height; X, -Y, neutral_height; 
                  X, Y, neutral_height; -X, Y, neutral_height];
    
    base_poly = [P_base; P_base(1,:)];
    plot3(base_poly(:,1), base_poly(:,2), base_poly(:,3), 'k-', 'LineWidth', 2);
    
    platform_neutral = [P_platform; P_platform(1,:)];
    plot3(platform_neutral(:,1), platform_neutral(:,2), platform_neutral(:,3), ...
        'k-', 'LineWidth', 2);
    
    % Add actuators in neutral position
    actuator_colors = {'red', 'green', 'blue', 'magenta'};
    for i = 1:4
        plot3(P_base(i,1), P_base(i,2), P_base(i,3), 'ks', ...
            'MarkerSize', 8, 'MarkerFaceColor', 'black');
        plot3([P_base(i,1), P_platform(i,1)], ...
              [P_base(i,2), P_platform(i,2)], ...
              [P_base(i,3), P_platform(i,3)], ...
              'Color', actuator_colors{i}, 'LineWidth', 2.5);
    end
    
    % Add center point
    plot3(0, 0, neutral_height, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'red');
    
    % Set plot properties
    axis equal; grid on; view(45, 30);
    xlabel('X [m]', 'FontSize', 12); 
    ylabel('Y [m]', 'FontSize', 12); 
    zlabel('Z [m]', 'FontSize', 12);
    title(sprintf('Combined Workspace Envelope\nZ: %.3f m | Theta: ±%.1f° | Phi: ±%.1f°', ...
        range_z, range_theta/2, - range_phi/2), 'FontSize', 14, 'FontWeight', 'bold');
    
    hold off;
end