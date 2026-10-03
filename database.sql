CREATE TABLE IF NOT EXISTS tow_jobs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    vehicle_model VARCHAR(50) NOT NULL,
    distance_traveled FLOAT NOT NULL,
    earnings INT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);