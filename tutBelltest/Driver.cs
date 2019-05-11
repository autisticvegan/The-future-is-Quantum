using System;

using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.Bell
{
    class Driver
    {
        static void Main(string[] args)
        {
            using (var qsim = new QuantumSimulator())
            {
                // Try initial values
                Result[] initials = new Result[] { Result.Zero, Result.One };
                foreach (Result initial in initials)
                {
                    var res = BellTest.Run(qsim, 10000, initial).Result;
                    var (numZeros, numOnes, agree) = res;
                    System.Console.WriteLine(
                        $"Init:{initial,-4} 0s={numZeros,-4} 1s={numOnes,-4} agree={agree,-4}");
                }
            }

            System.Console.WriteLine("Press any key to continue...");
            Console.ReadKey();
        }
    }
}

/*
   var estimator = new ResourcesEstimator();
            BellTest.Run(estimator, 1000, Result.Zero).Wait();

            System.Console.WriteLine(estimator.ToTSV());
            
            System.Console.WriteLine("Press any key to continue...");
            Console.ReadKey();
            */


/*
 *             using (var qsim = new QuantumSimulator())
        {
            // Try initial values
            Result[] initials = new Result[] { Result.Zero, Result.One };
            foreach (Result initial in initials)
            {
                var res = BellTest.Run(qsim, 1000, initial).Result;
                var (numZeros, numOnes) = res;
                System.Console.WriteLine(
                    $"Init:{initial,-4} 0s={numZeros,-4} 1s={numOnes,-4}");
            }
        }

        System.Console.WriteLine("Press any key to continue...");
        Console.ReadKey();
*/