library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DecryptorUnit is
    port (
        clk: in std_logic;
        input: in string (1 to 19) := "B C D E F G H I J K";
        prime1_receiver, prime2_receiver: buffer integer;
        outCurr: out character;
        outputEncrypt: out character;
        outputDecrypt: out character
    );
end entity DecryptorUnit;

architecture rtl of DecryptorUnit is

    component KeyGenUnit is
        port (
            clk: in std_logic;
            en: in std_logic;
            prime1_key, prime2_key: buffer integer;
            encryption_key, decryption_key, n_key: out integer
        );
    end component KeyGenUnit;

    type state is (FETCH, ENCRYPT, SHOW_ENCRYPTION, DECRYPT, SHOW_DECRYPTION);

    signal currstate, nextstate: state;
    signal en_receiver: std_logic := '1';
    signal e, d, n: integer;

begin    
    KeyGen: KeyGenUnit port map (
        clk => clk,
        en => en_receiver,
        prime1_key => prime1_receiver,
        prime2_key => prime2_receiver,
        encryption_key => e,
        decryption_key => d,
        n_key => n
    );

    process(clk)
        variable i_int, e_int, d_int: integer := 0;
        variable pc: integer := 1;
    begin
        if rising_edge(clk) then
            outCurr <= input(pc);
            case currstate is
                when FETCH =>
                    i_int := character'pos(input(pc)) - 64;

                    if prime1_receiver > 0 AND prime2_receiver > 0 then
                        en_receiver <= '0';
                        nextstate <= ENCRYPT;
                    end if;
                when ENCRYPT =>
                    e_int := (i_int ** e) mod n;
                    nextstate <= SHOW_ENCRYPTION;
                when SHOW_ENCRYPTION =>
                    outputEncrypt <= character'val(e_int + 64); 
                    nextstate <= DECRYPT;
                when DECRYPT =>
                    d_int := (e_int ** d) mod n;
                    nextstate <= SHOW_DECRYPTION;
                when SHOW_DECRYPTION =>
                    outputDecrypt <= character'val(d_int + 64);
                    pc := pc + 1;
                    nextstate <= FETCH;
            end case;
        end if;
    end process;

    process(clk)
    begin
        if rising_edge(clk) then
            currstate <= nextstate;
        end if;
    end process;
  
end architecture rtl;

