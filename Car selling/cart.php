<?php
// ================= SESSION =================
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// ================= CHECK LOGIN =================
if (!isset($_SESSION['customer_id'])) {
    header("Location: login.php?message=please_login");
    exit;
}

// ================= UPDATE CART (POST) =================
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_cart'])) {

    // Update quantities
    if (isset($_POST['qty'])) {
        foreach ($_POST['qty'] as $id => $qty) {
            if (isset($_SESSION['cart'][$id])) {
                $_SESSION['cart'][$id]['qty'] = max(1, (int)$qty);
            }
        }
    }

    // Save selected checkboxes
    $_SESSION['selected_ids'] = $_POST['selected_ids'] ?? [];
}

// ================= DB =================
require_once 'db.php';
$db_connection = $conn ?? $link;

// ================= CART DATA =================
$cart_content = $_SESSION['cart'] ?? [];
$list_ids = array_keys($cart_content);
$grand_total = 0;
?>

<div class="container py-5">
    <h3 class="fw-bold mb-4">Your Booking Cart</h3>

<?php if (empty($list_ids)): ?>
    <div class="alert alert-warning text-center">
        Your cart is empty.
        <a href="base.php?page=home" class="fw-bold">Shop now</a>
    </div>
<?php else: ?>

<form method="POST">
<input type="hidden" name="update_cart" value="1">

<?php
$ids_str = implode(',', $list_ids);
$sql = "SELECT * FROM vehicle WHERE vehicle_id IN ($ids_str)";
$result = $db_connection->query($sql);

while ($row = $result->fetch_assoc()):
    $id = $row['vehicle_id'];
    $qty = $cart_content[$id]['qty'];
    $subtotal = $row['price'] * $qty;

    $checked = !isset($_SESSION['selected_ids']) 
        || in_array($id, $_SESSION['selected_ids']);

    if ($checked) {
        $grand_total += $subtotal;
    }
?>

<div class="card mb-3 shadow-sm">
    <div class="row g-0 align-items-center p-3">

        <div class="col-md-1 text-center">
            <input type="checkbox"
                   name="selected_ids[]"
                   value="<?= $id ?>"
                   <?= $checked ? 'checked' : '' ?>>
        </div>

        <div class="col-md-2">
            <img src="<?= !empty($row['image_url']) ? $row['image_url'] : 'https://via.placeholder.com/150' ?>"
                 class="img-fluid rounded"
                 alt="<?= $row['model'] ?>">
        </div>

        <div class="col-md-6">
            <h5 class="fw-bold"><?= $row['model'] ?></h5>
            <p class="mb-1">Price: $<?= number_format($row['price']) ?></p>
        </div>

        <div class="col-md-1">
            <input type="number"
                   name="qty[<?= $id ?>]"
                   value="<?= $qty ?>"
                   min="1"
                   max="<?= $row['stock'] ?>"
                   class="form-control text-center">
        </div>

        <div class="col-md-2 text-end fw-bold">
            $<?= number_format($subtotal) ?>
        </div>

    </div>

    <div class="text-end pe-3 pb-2">
        <a href="cart_delete.php?id=<?= $id ?>"
           class="text-danger"
           onclick="return confirm('Remove this item?')">
            Remove
        </a>
    </div>
</div>

<?php endwhile; ?>

<button type="submit" class="btn btn-secondary w-100 mb-4">
    Update Cart
</button>

</form>

<!-- ================= SUMMARY ================= -->
<div class="card p-4 shadow-sm">
    <h5 class="fw-bold mb-3">Cart Summary</h5>

    <p class="fw-bold fs-5">
        Total: $<?= number_format($grand_total) ?>
    </p>

    <form action="base.php?page=checkout" method="POST">
        <input type="hidden" name="sub_total_input" value="<?= $grand_total ?>">
        <button type="submit" class="btn btn-dark w-100">
            Book
        </button>
    </form>
</div>

<?php endif; ?>
</div>
