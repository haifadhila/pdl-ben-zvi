-- JOIN
SELECT * FROM bitemporal_join_renting_room();

-- COALESCE
SELECT * FROM coalesce_organization();
SELECT * FROM coalesce_room();

-- PROJECTION
SELECT * FROM organization_projection_organization_name();
SELECT * FROM renting_projection_event_name();
SELECT * FROM room_projection_room_name();

-- SELECTION
SELECT * FROM organization_selection_by_id(1);
SELECT * FROM room_selection_by_id(1);
SELECT * FROM renting_selection_by_organization_id(1);
SELECT * FROM renting_selection_by_rent_id(1);
SELECT * FROM renting_selection_by_room_id(1);

-- VALID TIME SLICE
SELECT * FROM renting_transaction_time_slice('2019-09-09');
SELECT * FROM organization_transaction_time_slice('2019-09-09');
SELECT * FROM room_transaction_time_slice('2019-09-09');

-- TRANSACTION TIME SLICE
SELECT * FROM renting_valid_time_slice('2019-09-09');
SELECT * FROM organization_valid_time_slice('2019-09-09');
SELECT * FROM room_valid_time_slice('2019-09-09');

-- SET DIFFERENCE
SELECT * 
FROM Renting 
EXCEPT 	
	SELECT * 
	FROM Renting 
	WHERE room_id = 1;
	
-- ALLEN's 13 RELATIONSHIP
SELECT * FROM allen_is_after('2019-09-01', '2019-09-15', '2019-09-06', '2019-09-08');
SELECT * FROM allen_is_before('2019-09-01', '2019-09-15', '2019-09-06', '2019-09-08');
SELECT * FROM allen_is_during('2019-09-01', '2019-09-15', '2019-09-06', '2019-09-08');
SELECT * FROM allen_is_during_inverse('2019-09-01', '2019-09-15', '2019-09-06', '2019-09-08');
SELECT * FROM allen_is_equal('2019-09-01', '2019-09-15', '2019-09-06', '2019-09-08');
SELECT * FROM allen_is_finish('2019-09-01', '2019-09-15', '2019-09-06', '2019-09-08');
SELECT * FROM allen_is_finish_inverse('2019-09-01', '2019-09-15', '2019-09-06', '2019-09-08');
SELECT * FROM allen_is_meet('2019-09-01', '2019-09-15', '2019-09-06', '2019-09-08');
SELECT * FROM allen_is_meet_inverse('2019-09-01', '2019-09-15', '2019-09-06', '2019-09-08');
SELECT * FROM allen_is_overlapping('2019-09-01', '2019-09-15', '2019-09-06', '2019-09-08');
SELECT * FROM allen_is_overlapping_inverse('2019-09-01', '2019-09-15', '2019-09-06', '2019-09-08');
SELECT * FROM allen_is_start('2019-09-01', '2019-09-15', '2019-09-06', '2019-09-08');
SELECT * FROM allen_is_start_inverse('2019-09-01', '2019-09-15', '2019-09-06', '2019-09-08');


