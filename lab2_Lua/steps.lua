
function climbStairs(n)
    local memo = {}
    return helper(n, memo)
end

function helper(n, memo)
    if n == 0 or n == 1 then
        return 1
    end

    if not memo[n] then
        memo[n] = helper(n - 1, memo) + helper(n - 2, memo)
    end

    return memo[n]
end


-- Тест 1: n = 0
print(climbStairs(0)) -- Ожидаемый результат: 1

-- Тест 2: n = 1
print(climbStairs(1)) -- Ожидаемый результат: 1

-- Тест 3: n = 5
print(climbStairs(5)) -- Ожидаемый результат: 8

-- Тест 4: n = 10
print(climbStairs(10)) -- Ожидаемый результат: 89

-- Тест 5: n = 15
print(climbStairs(15)) -- Ожидаемый результат: 987
