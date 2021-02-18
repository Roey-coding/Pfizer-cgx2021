nasm.exe optimized_takeover_no_nrg_85.asm
nasm.exe optimized_takeover_nrg_85.asm
copy optimized_takeover_nrg_85 run_zombies_offline\corewars8086-4.0.2\survivors\nrg1
copy optimized_takeover_no_nrg_85 run_zombies_offline\corewars8086-4.0.2\survivors\nrg2
java -cp run_zombies_offline\corewars8086-4.0.2\lib\debugger.jar;run_zombies_offline\corewars8086-4.0.2\lib\* il.co.codeguru.corewars8086.CoreWarsEngine
