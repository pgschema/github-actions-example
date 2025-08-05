CREATE OR REPLACE PROCEDURE set_default_address(
    p_user_id integer,
    p_address_id integer
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Check if the address exists and belongs to the user
    IF NOT EXISTS (
        SELECT 1 FROM addresses 
        WHERE id = p_address_id AND user_id = p_user_id
    ) THEN
        RAISE EXCEPTION 'Address % does not exist or does not belong to user %', 
            p_address_id, p_user_id;
    END IF;
    
    -- Start transaction
    BEGIN
        -- Set all addresses for this user to non-default
        UPDATE addresses 
        SET is_default = false 
        WHERE user_id = p_user_id;
        
        -- Set the specified address as default
        UPDATE addresses 
        SET is_default = true 
        WHERE id = p_address_id;
        
        -- Log the change (optional - remove if you don't need logging)
        RAISE NOTICE 'Default address set to % for user %', p_address_id, p_user_id;
    
    EXCEPTION
        WHEN OTHERS THEN
            -- Rollback will happen automatically
            RAISE EXCEPTION 'Failed to set default address: %', SQLERRM;
    END;
END;
$$;