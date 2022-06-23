// we add items to the above list and delete them once decayed, this is run once on restarts.
const TimeAllowed = 1000 * 60 * 40320; // 28 days

function DeleteOld() {
}

function CleanDroppedInventories() {
    db(`DELETE FROM user_inventory2 WHERE dropped = '1'`)
    db(`DELETE FROM user_inventory2 WHERE name LIKE '%_trash'`)
    DeleteOld()
}

setTimeout(CleanDroppedInventories, 30000)
