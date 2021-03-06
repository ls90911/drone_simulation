function [ desired_angle,F ] = controller_velocity_body( desired_velocity_body )
%CONTROLLER_VELOCITY_BODY ????????????
%   ????????
global  pointer g m velocity_body_error step  controller sensor_states

switch controller
    case 'PID'
        k_p_v_x_body = 1.3;
        k_p_v_y_body = 1.3;
        k_p_v_z_body = 3;

        k_d_v_x_body = 0;
        k_d_v_y_body = 0;
        k_d_v_z_body = 0;

        u = sensor_states(4,pointer);
        v = sensor_states(5,pointer);
        w = sensor_states(6,pointer);
        p = sensor_states(10,pointer);
        q = sensor_states(11,pointer);
        r = sensor_states(12,pointer);



        velocity_body_error(:,pointer) = [(desired_velocity_body(1)-u) ...
            (desired_velocity_body(2)-v) (desired_velocity_body(3)- w)]';

        if pointer == 1
            d_velocity_error = zeros(2,1);
        else
            d_velocity_error = (velocity_body_error(1:2,pointer)-velocity_body_error(1:2,pointer-1))/step;
        end

        desired_theta = (k_p_v_x_body*(velocity_body_error(1,pointer) + ...
            k_d_v_x_body*d_velocity_error(1))+(q*w-r*v))/(-g);

        desired_phi = (k_p_v_y_body*(velocity_body_error(2,pointer)+...
            k_d_v_y_body*d_velocity_error(2))+(r*u-p*w))/(g);
        F = (-g + k_p_v_z_body*velocity_body_error(3,pointer))*m; 
        desired_angle = [desired_phi desired_theta]';
    case 'INDI'
        k_p_v_x_body = 1.3;
        k_p_v_y_body = 1.3;
        k_p_v_z_body = 3;

        k_d_v_x_body = 0;
        k_d_v_y_body = 0;
        k_d_v_z_body = 0;

        u = sensor_states(4,pointer);
        v = sensor_states(5,pointer);
        w = sensor_states(6,pointer);
        p = sensor_states(10,pointer);
        q = sensor_states(11,pointer);
        r = sensor_states(12,pointer);



        velocity_body_error(:,pointer) = [(desired_velocity_body(1)-u) ...
            (desired_velocity_body(2)-v) (desired_velocity_body(3)- w)]';

        if pointer == 1
            d_velocity_error = zeros(2,1);
        else
            d_velocity_error = (velocity_body_error(1:2,pointer)-velocity_body_error(1:2,pointer-1))/step;
        end

        desired_theta = (k_p_v_x_body*(velocity_body_error(1,pointer) + ...
            k_d_v_x_body*d_velocity_error(1))+(q*w-r*v))/(-g);

        desired_phi = (k_p_v_y_body*(velocity_body_error(2,pointer)+...
            k_d_v_y_body*d_velocity_error(2))+(r*u-p*w))/(g);
        F = (-g + k_p_v_z_body*velocity_body_error(3,pointer))*m; 
        desired_angle = [desired_phi desired_theta]';
        
end

end

