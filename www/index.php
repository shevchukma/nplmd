<?php
// Подключение к базе данных
$servername = "percona-server";
$username = "myuser";
$password = "123456";
$dbname = "mydb";

$conn = new mysqli($servername, $username, $password, $dbname);

// Проверка подключения к базе данных
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Увеличение счетчика при каждом обращении к странице
$sql = "UPDATE counters SET count = count + 1 WHERE id = 1";
$conn->query($sql);

// Получение текущего значения счетчика
$sql = "SELECT count FROM counters WHERE id = 1";
$result = $conn->query($sql);
$row = $result->fetch_assoc();
$count = $row['count'];

// Закрытие соединения с базой данных
$conn->close();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Page Counter App</title>
</head>
<body>
    <h1>Hello World!</h1>
    <p>Page visits: <?php echo $count; ?></p>
</body>
</html>
