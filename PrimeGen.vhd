library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity PrimeGen is
    port (
        clk: in std_logic;
        en: in std_logic;
        prime1, prime2: buffer integer
    );
end entity PrimeGen;

architecture rtl of PrimeGen is

begin
    process(clk)
        variable seed1: integer := 1;
        variable seed2: integer := 2;
        variable rand_int1, rand_int2: integer;
        variable is_prime1, is_prime2: boolean;

        --Random Number Generator Function
        impure function rand_int_gen(
            min: integer;
            max: integer
        ) return integer is
            variable randomValue: real;
        begin
            uniform(seed1, seed2, randomValue);
            return integer(round(randomValue * real(max - min + 1) + real(min) - 0.5));
        end function;

    begin            
        if rising_edge(clk) AND en = '1' then
            is_prime1 := false;
            is_prime2 := false;

            while not (is_prime1 and is_prime2) loop
                rand_int1 := rand_int_gen(0, 8);
                rand_int2 := rand_int_gen(0, 8);

                --Primality testing using trial division method
                is_prime1 := true;
                for i in 2 to integer(sqrt(real(rand_int1))) loop
                    if rand_int1 mod i = 0 then
                        is_prime1 := false;
                        exit;
                    end if;
                end loop;

                is_prime2 := true;
                for i in 2 to integer(sqrt(real(rand_int2))) loop
                    if rand_int2 mod i = 0 then
                        is_prime2 := false;
                        exit;
                    end if;
                end loop;
            end loop;

            prime1 <= rand_int1;
            prime2 <= rand_int2;
        end if;
    end process;
end architecture rtl;

