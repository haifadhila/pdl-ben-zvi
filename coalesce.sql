CREATE OR REPLACE FUNCTION coalesce_organization()
    RETURNS TABLE (
        organization_id integer,
        organization_name character varying(50),
        t_eff_start date,
        t_reg_start date,
        t_eff_end date,
        t_reg_end date,
        t_deletion date
    )
    LANGUAGE plpgsql
AS $$
DECLARE
    var_x record;
    var_y record;
    min_eff_start date;
    max_eff_end date;
BEGIN
    DROP TABLE IF EXISTS excluded CASCADE;
    CREATE TEMP TABLE IF NOT EXISTS excluded (organization_id integer);

    FOR var_x IN (
        SELECT *
            FROM organization
            ORDER BY organization.organization_id
    ) LOOP
        IF var_x.organization_id NOT IN (SELECT excluded.organization_id FROM excluded) THEN
            INSERT INTO excluded (organization_id) VALUES (var_x.organization_id);
            organization_id = var_x.organization_id;
            organization_name = var_x.organization_name;
            t_eff_start := var_x.t_eff_start;
            t_eff_end := var_x.t_eff_end;
            t_reg_start := var_x.t_reg_start;
            t_reg_end := var_x.t_reg_end;
            FOR var_y IN (
                SELECT *
                    FROM organization
                    WHERE organization.organization_id NOT IN (SELECT excluded.organization_id FROM excluded)
                        AND organization.organization_name = var_x.organization_name
            ) LOOP
                IF var_y.organization_id NOT IN (SELECT excluded.organization_id FROM excluded) THEN
                    IF NOT (
                        allen_is_before(t_eff_start, t_eff_end, var_y.t_eff_start, var_y.t_eff_end) OR
                        allen_is_after(t_eff_start, t_eff_end, var_y.t_eff_start, var_y.t_eff_end)
                    ) THEN
                        IF (var_y.t_eff_start < t_eff_start) THEN
                            t_eff_start := var_y.t_eff_start;
                            t_reg_start := var_y.t_reg_start;
                        END IF;

                        IF (var_y.t_eff_end > t_eff_end OR var_y.t_eff_end IS NULL) THEN
                            t_eff_end := var_y.t_eff_end;
                            t_reg_end := var_y.t_reg_end;
                        END IF;

                        INSERT INTO excluded (organization_id) VALUES (var_y.organization_id);
                    END IF;
                END IF;
            END LOOP;
            RETURN NEXT;
        END IF;
   END LOOP;
END; $$;

CREATE OR REPLACE FUNCTION coalesce_room()
    RETURNS TABLE (
        room_id integer,
        room_name character varying(50),
        t_eff_start date,
        t_reg_start date,
        t_eff_end date,
        t_reg_end date,
        t_deletion date
    )
    LANGUAGE plpgsql
AS $$
DECLARE
    var_x record;
    var_y record;
    min_eff_start date;
    max_eff_end date;
BEGIN
    DROP TABLE IF EXISTS excluded CASCADE;
    CREATE TEMP TABLE IF NOT EXISTS excluded (room_id integer);

    FOR var_x IN (
        SELECT *
            FROM room
            ORDER BY room.room_id
    ) LOOP
        IF var_x.room_id NOT IN (SELECT excluded.room_id FROM excluded) THEN
            INSERT INTO excluded (room_id) VALUES (var_x.room_id);
            room_id = var_x.room_id;
            room_name = var_x.room_name;
            t_eff_start := var_x.t_eff_start;
            t_eff_end := var_x.t_eff_end;
            t_reg_start := var_x.t_reg_start;
            t_reg_end := var_x.t_reg_end;
            FOR var_y IN (
                SELECT *
                    FROM room
                    WHERE room.room_id NOT IN (SELECT excluded.room_id FROM excluded)
                        AND room.room_name = var_x.room_name
            ) LOOP
                IF var_y.room_id NOT IN (SELECT excluded.room_id FROM excluded) THEN
                    IF NOT (
                        allen_is_before(t_eff_start, t_eff_end, var_y.t_eff_start, var_y.t_eff_end) OR
                        allen_is_after(t_eff_start, t_eff_end, var_y.t_eff_start, var_y.t_eff_end)
                    ) THEN
                        IF (var_y.t_eff_start < t_eff_start) THEN
                            t_eff_start := var_y.t_eff_start;
                            t_reg_start := var_y.t_reg_start;
                        END IF;

                        IF (var_y.t_eff_end > t_eff_end OR var_y.t_eff_end IS NULL) THEN
                            t_eff_end := var_y.t_eff_end;
                            t_reg_end := var_y.t_reg_end;
                        END IF;

                        INSERT INTO excluded (room_id) VALUES (var_y.room_id);
                    END IF;
                END IF;
            END LOOP;
            RETURN NEXT;
        END IF;
   END LOOP;
END; $$;

CREATE OR REPLACE FUNCTION coalesce_renting()
    RETURNS TABLE (
        rent_id integer,
        room_id integer,
        organization_id integer,
        event_name character varying(50),
        t_eff_start date,
        t_reg_start date,
        t_eff_end date,
        t_reg_end date,
        t_deletion date
    )
    LANGUAGE plpgsql
AS $$
DECLARE
    var_x record;
    var_y record;
    min_eff_start date;
    max_eff_end date;
BEGIN
    DROP TABLE IF EXISTS excluded CASCADE;
    CREATE TEMP TABLE IF NOT EXISTS excluded (rent_id integer);

    FOR var_x IN (
        SELECT *
            FROM rent
            ORDER BY renting.rent_id
    ) LOOP
        IF var_x.rent_id NOT IN (SELECT excluded.rent_id FROM excluded) THEN
            INSERT INTO excluded (rent_id) VALUES (var_x.rent_id);
            rent_id = var_x.rent_id;
            room_id = var_x.room_id;
            organization_id = var_x.organization_id;
            event_name = var_x.event_name;
            t_eff_start := var_x.t_eff_start;
            t_eff_end := var_x.t_eff_end;
            t_reg_start := var_x.t_reg_start;
            t_reg_end := var_x.t_reg_end;
            FOR var_y IN (
                SELECT *
                    FROM rent
                    WHERE rent.rent_id NOT IN (SELECT excluded.rent_id FROM excluded)
                        AND rent.room_id = var_x.room_id
                        AND rent.organization_id = var_x.organization_id
                        AND rent.event_name = var_x.event_name
            ) LOOP
                IF var_y.rent_id NOT IN (SELECT excluded.rent_id FROM excluded) THEN
                    IF NOT (
                        allen_is_before(t_eff_start, t_eff_end, var_y.t_eff_start, var_y.t_eff_end) OR
                        allen_is_after(t_eff_start, t_eff_end, var_y.t_eff_start, var_y.t_eff_end)
                    ) THEN
                        IF (var_y.t_eff_start < t_eff_start) THEN
                            t_eff_start := var_y.t_eff_start;
                            t_reg_start := var_y.t_reg_start;
                        END IF;

                        IF (var_y.t_eff_end > t_eff_end OR var_y.t_eff_end IS NULL) THEN
                            t_eff_end := var_y.t_eff_end;
                            t_reg_end := var_y.t_reg_end;
                        END IF;

                        INSERT INTO excluded (rent_id) VALUES (var_y.rent_id);
                    END IF;
                END IF;
            END LOOP;
            RETURN NEXT;
        END IF;
   END LOOP;
END; $$;

