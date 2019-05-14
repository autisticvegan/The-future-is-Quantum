// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.

namespace Quantum.Kata.UnitaryPatterns {
    
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
	open Microsoft.Quantum.Arrays;
    
    //////////////////////////////////////////////////////////////////
    // Welcome!
    //////////////////////////////////////////////////////////////////
    
    // The "Unitary Patterns" quantum kata is a series of exercises designed
    // to get you comfortable with creating unitary transformations which can be represented
    // with matrices of certain shapes (with certain pattern of zero and non-zero values).
    
    // Each task is wrapped in one operation preceded by the description of the task.
    // Each task has a unit test associated with it, which initially fails.
    // Your goal is to fill in the blank (marked with // ... comment)
    // with some Q# code to make the failing test pass.
    
    // The tasks are given in approximate order of increasing difficulty;
    // harder ones are marked with asterisks.
    
    // Each task describes a matrix which your unitary needs to implement.
    // The row and column indices of the matrix elements are in little-endian format (the least significant bit is stored first).
    // For example, index 1 corresponds to the qubit state |10..0⟩, and to store this state in an array of qubits qs 
    // its first element qs[0] would have to be in state |1⟩ and the rest of the qubits would have to be in state |0⟩.

    // In the example patterns provided in the tasks, X marks a "non-zero" element, and . marks a "zero" element.
    // "Zero" element of a matrix is a complex number which has an absolute value of 0.001 or less,
    // and "non-zero" element is a complex number which has an absolute value of 0.001 or greater.
    // You can see the details of the verification in Tests.qs file, operation AssertOperationMatrixMatchesPattern.

    // Note that all tasks require you to implement a unitary transformation,
    // which means that you're not allowed to use any measurements.
    


    // Task 1. Main diagonal
    // Input: N qubits in an arbitrary state.
    // Goal: Implement a unitary transformation on N qubits which is represented by a matrix
    //       with non-zero elements on the main diagonal and zero elements everywhere else.
    // Example: For N = 2, the matrix of the transformation should look as follows:
    //          X...
    //          .X..
    //          ..X.
    //          ...X
    operation MainDiagonal (qs : Qubit[]) : Unit {
        // The simplest example of such a unitary transformation is represented by an identity matrix. 
        // This means that the operation doesn't need to do anything with the input qubits.
        // Build the project and run the tests to see that T01_MainDiagonal_Test test passes.
		I(qs[0]);
        // You are welcome to try and come up with other diagonal unitaries.
        // ...
    }
    
    
    // Task 2. All-non-zero matrix
    // Input: N qubits in an arbitrary state.
    // Goal: Implement a unitary transformation on N qubits which is represented by a matrix
    //       with all elements non-zero.
    // Example: For N = 2, the matrix of the transformation should look as follows:
    //          XXXX
    //          XXXX
    //          XXXX
    //          XXXX
    operation AllNonZero (qs : Qubit[]) : Unit {
        // ...
		// Note unrelated: but use Fst and Snd for accessing pairs
		ApplyToEach(H, qs);
    }
    

	// From solution for Block diagonal:
	//	Here and in the rest of D problems X denotes a non-zero element of the matrix (a complex number which has the
//square of the absolute value greater than or equal to 10−5
//), and . denotes a zero element of the matrix (a complex
//number which has the square of the absolute value less than 10−5
//).
//Solution. This was the easiest problem of the contest. The editorial for problem U2 of the warmup round covered
//creating simple matrices which can be represented as tensor product of other matrices, so this pattern should be
//immediately recognizable as a tensor product IN−1 ⊗ H. Remember that the indices are given in little endian, so the
//Hadamard gate has to be applied to the first qubit of the array.
    
    // Task 3. Block diagonal matrix
    // Input: N qubits in an arbitrary state.
    // Goal: Implement a unitary transformation on N qubits which is represented by a matrix
    //       which has 2x2 blocks of non-zero elements on the main diagonal and zero elements everywhere else.
    // Example: For N = 3, the matrix of the transformation should look as follows:
    //          XX......
    //          XX......
    //          ..XX....
    //          ..XX....
    //          ....XX..
    //          ....XX..
    //          ......XX
    //          ......XX
    operation BlockDiagonal (qs : Qubit[]) : Unit {
        // ...
		// can also use Head, remember for other cases Tail, Most as well
		H(qs[0]);
		// Why this works - since its little endian we want the first
		// because this is equivalent to the tensor product of I sub N-1 and H
    }




    // Task 4. Quarters
    // Input: N qubits in an arbitrary state.
    // Goal: Implement a unitary transformation on N qubits which is represented by a matrix
    //       with non-zero elements in top left and bottom right quarters
    //       and zero elements everywhere else.
    // Example: For N = 3, the matrix of the transformation should look as follows:
    //          XXXX....
    //          XXXX....
    //          XXXX....
    //          XXXX....
    //          ....XXXX
    //          ....XXXX
    //          ....XXXX
    //          ....XXXX
	//			
	//			XX..
	//			..XX
	//
	//			X.
	//			.X
	//
    operation Quarters (qs : Qubit[]) : Unit {
        // Hint: represent this matrix as a tensor product of a 2x2 diagonal matrix and a larger matrix with all non-zero elements.
		// all except the last one
		ApplyToEach(H, Most(qs));
        // ...
    }
    
    
    // Task 5. Even chessboard pattern
    // Input: N qubits in an arbitrary state.
    // Goal: Implement a unitary transformation on N qubits which is represented by a matrix
    //       with non-zero elements in positions where row and column indices have the same parity
    //       and zero elements everywhere else.
    // Example: For N = 2, the matrix of the transformation should look as follows:
    //          X.X.
    //          .X.X
    //          X.X.
    //          .X.X
	//
	//			X.
	//			.X
	//
	//			X.X.X.X.
	//			.X.X.X.X
	//			X.X.X.X.
	//			.X.X.X.X
	//			X.X.X.X.
	//			.X.X.X.X
	//			X.X.X.X.
	//			.X.X.X.X
    operation EvenChessPattern (qs : Qubit[]) : Unit {
        // ...
		// opposite of most
		ApplyToEach(H, qs[1 .. Length(qs)-1]);
    }
    
    
    // Task 6. Odd chessboard pattern
    // Input: N qubits in an arbitrary state.
    // Goal: Implement a unitary transformation on N qubits which is represented by a matrix
    //       with non-zero elements in positions where row and column indices have different parity
    //       and zero elements everywhere else.
    // Example: For N = 2, the matrix of the transformation should look as follows:
    //          .X.X
    //          X.X.
    //          .X.X
    //          X.X.
    operation OddChessPattern (qs : Qubit[]) : Unit {
        // ...
		X(qs[0]);
		ApplyToEach(H, qs[1 .. Length(qs) - 1]);
		// Can also put the X after
    }
    
    
    // Task 7. Anti-diagonal
    // Input: N qubits in an arbitrary state.
    // Goal: Implement a unitary transformation on N qubits which is represented by a matrix
    //       with non-zero elements on the anti-diagonal and zero elements everywhere else.
    // Example: For N = 2, the matrix of the transformation should look as follows:
    //          ...X
    //          ..X.
    //          .X..
    //          X...
    operation Antidiagonal (qs : Qubit[]) : Unit {
        // ...
		ApplyToEach(X, qs);
    }


    // Task 8. 2x2 chessboard pattern
    // Input: N qubits in an arbitrary state.
    // Goal: Implement a unitary transformation on N qubits which is represented by a matrix
    //       in which zero and non-zero elements form a chessboard pattern with 2x2 squares,
    //       with the top left square occupied by non-zero elements.
    // Example: For N = 3, the matrix of the transformation should look as follows:
    //          XX..XX..
    //          XX..XX..
    //          ..XX..XX
    //          ..XX..XX
    //          XX..XX..
    //          XX..XX..
    //          ..XX..XX
    //          ..XX..XX
    operation ChessPattern2x2 (qs : Qubit[]) : Unit {
        // ...
		H(Head(qs));
        for (i in 2 .. Length(qs) - 1) {
            H(qs[i]);
        }
    }
    

    // Task 9. Two patterns
    // Input: N qubits in an arbitrary state.
    // Goal: Implement a unitary transformation on N qubits which is represented by a matrix
    //       with all zero elements in the top right and bottom left quarters, 
    //       an anti-diagonal pattern from task 1.6 in the top left quarter,
    //       and an all-non-zero pattern from task 1.2 in the bottom right quarter.
    // Example: For N = 2, the matrix of the transformation should look as follows:
    //          .X..
    //          X...
    //          ..XX
    //          ..XX
    operation TwoPatterns (qs : Qubit[]) : Unit {
        // bottom right quarter is obtained by applying Controlled AllNonZero
        ApplyToEach(Controlled H([Tail(qs)], _), Most(qs));
        // top left quarter is obtained by applying 0-controlled Antidiagonal
        ApplyToEach((ControlledOnInt(0, X))([Tail(qs)], _), Most(qs));
    }


    // Task 10. Increasing blocks
    // Input: N qubits in an arbitrary state.
    // Goal: Implement a unitary transformation on N qubits which is represented by a matrix defined recursively:
    //     * for N = 1 the matrix has non-zero elements on the main diagonal and zero elements everywhere else,
    //     * for larger N the matrix has all zero elements in the top right and bottom left quarters,
    //                                   the matrix for N-1 in the top left quarter,
    //                                   and all non-zero elements in the bottom right quarter.
    // Example: For N = 3, the matrix of the transformation should look as follows:
    //          X.......
    //          .X......
    //          ..XX....
    //          ..XX....
    //          ....XXXX
    //          ....XXXX
    //          ....XXXX
    //          ....XXXX
    operation IncreasingBlocks (qs : Qubit[]) : Unit {
        // ...
		let N = Length(qs);
        // for N = 1, we need an identity
        if (N > 1) {
            // do the bottom-right quarter
            ApplyToEachCA(Controlled H([Tail(qs)], _), Most(qs));
            // do the top-left quarter by calling the same operation recursively
            (ControlledOnInt(0, IncreasingBlocks_Reference))([Tail(qs)], Most(qs));
        }
    }


    // Task 11. X-Wing fighter
    // Input: N qubits in an arbitrary state.
    // Goal: Implement a unitary transformation on N qubits which is represented by a matrix
    //       with non-zero elements on the main diagonal and the anti-diagonal
    //       and zero elements everywhere else.
    // Example: For N = 3, the matrix should look as follows:
    //          X......X
    //          .X....X.
    //          ..X..X..
    //          ...XX...
    //          ...XX...
    //          ..X..X..
    //          .X....X.
    //          X......X
    operation XWing_Fighter (qs : Qubit[]) : Unit {
        // ...
		        ApplyToEach(CNOT(qs[0], _), qs[1 .. Length(qs) - 1]);
        H(qs[0]);
        ApplyToEach(CNOT(qs[0], _), qs[1 .. Length(qs) - 1]);
    }
    

    // Task 12. Rhombus
    // Input: N qubits in an arbitrary state.
    // Goal: Implement a unitary transformation on N qubits which is represented by a matrix
    //       with non-zero elements forming a rhombus of width 1 with sides parallel to main diagonals.
    // Example: For N = 2, the matrix of the transformation should look as follows:
    //          .XX.
    //          X..X
    //          X..X
    //          .XX.
    // For N = 3, the matrix should look as follows:
    //          ...XX...
    //          ..X..X..
    //          .X....X.
    //          X......X
    //          X......X
    //          .X....X.
    //          ..X..X..
    //          ...XX...
    operation Rhombus (qs : Qubit[]) : Unit {
        // ...
		XWing_Fighter(qs);
		X(Tail(qs));
    }

    // Task 13. TIE fighter
    // Input: N qubits in an arbitrary state (2 <= N <= 5).
    // Goal: Implement a unitary transformation on N qubits that is represented by a matrix
    //       with non-zero elements in the following positions:
    //        - the central 2x2 sub-matrix;
    //        - the diagonals of the top right and bottom left sub-matrices of size 2^(N-1)-1
    //          that do not overlap with the central 2x2 sub-matrix;
    //        - the anti-diagonals of the top left and bottom right sub-matrices of size 2^(N-1)-1
    //          that do not overlap with the central 2x2 sub-matrix.
    // Example: For N = 3, the matrix should look as follows:
    // ..X..X..
    // .X....X.
    // X......X
    // ...XX...
    // ...XX...
    // X......X
    // .X....X.
    // ..X..X..
    operation TIE_Fighter (qs : Qubit[]) : Unit {        
        // ...
		        let n = Length(qs);
        X(qs[n-1]);
        Controlled ReflectDiagonal([qs[n-1]], qs[0..(n-2)]);
        X(qs[n-1]);
        DecrementRegister(qs[0..(n-2)]);
        H(qs[n-1]);
        Controlled ReflectDiagonal([qs[n-1]], qs[0..(n-2)]);
    }
    
	    // Helper operation: decrement a little-endian register
    operation DecrementRegister (qs : Qubit[]) : Unit {
        X(qs[0]);
        for (i in 1..Length(qs)-1) {
            Controlled X(qs[0..i-1], qs[i]);
        }
    }
    
    // Helper operation: antidiagonal 
    operation ReflectDiagonal (qs : Qubit[]) : Unit
    is Ctl {
        ApplyToEachC(X, qs);
    }

    
    // Task 14. Creeper
    // Input: 3 qubits in an arbitrary state.
    // Goal: Implement a unitary transformation on 3 qubits which is represented by a matrix
    //       with non-zero elements in the following pattern: 
    // XX....XX
    // XX....XX
    // ...XX...
    // ...XX...
    // ..X..X..
    // ..X..X..
    // XX....XX
    // XX....XX
    operation Creeper (qs : Qubit[]) : Unit {                
        // We observe that a Hadamard transform on 2 qubits already produces the block structure that is 
        // required for the 4 "corners" of the unitary matrix. The rest of the pattern is a suitable 
        // permutation of a additional block, where this block contains the Hadamard transform on 1 qubit. 
        // The permutation producing the corners can be constructed from a CNOT from middle qubit to most 
        // significant qubit. The permutation producing the pattern in the center can be produced by 
        // applying a cyclic shift of the quantum register. This can be accomplished using a CNOT and a CCNOT. 
        CNOT(qs[1], qs[2]); 
        CNOT(qs[2], qs[0]); 
        CCNOT(qs[0], qs[2], qs[1]); 
        X(qs[2]);
        Controlled H([qs[2]], qs[1]);
        X(qs[2]);
        H(qs[0]);
        CNOT(qs[1], qs[2]);     
    }
    
    
    // Task 15. Hessenberg matrices  
    // Input: N qubits in an arbitrary state (2 <= N <= 4).
    // Goal: Implement a unitary transformation on N qubits which is represented by a matrix 
    //       with non-zero elements forming an upper diagonal matrix plus the first subdiagonal. 
    //       This is called a 'Hessenberg matrix' https://en.wikipedia.org/wiki/Hessenberg_matrix.
    // Example: For N = 2, the matrix of the transformation should look as follows:
    //          XXXX
    //          XXXX
    //          .XXX
    //          ..XX
    // For N = 3, the matrix should look as follows:
    // XXXXXXXX
    // XXXXXXXX
    // .XXXXXXX
    // ..XXXXXX
    // ...XXXXX
    // ....XXXX
    // .....XXX
    // ......XX
    operation Hessenberg_Matrix (qs : Qubit[]) : Unit {        
        // ...
		        let n = Length(qs);
        for (i in 2^n-2..-1..0) {     
            Embed_2x2_Operator(H, i, i+1, qs);
        }
    }

	    // Helper function for Embedding_Perm: finds first location where bit strings differ. 
    function FirstDifference (bits1 : Bool[], bits2 : Bool[]) : Int {
        for (i in 0 .. Length(bits1)-1) {
            if (bits1[i] != bits2[i]) {
                return i;
            }
        }
        return -1;
    }
    
    // Helper function for Embed_2x2_Operator: performs a Clifford to implement a base change
    // that maps basis states index1 to 111...10 and index2 to 111...11 (in big endian notation, i.e., LSB in qs[n-1]) 
    operation EmbeddingPermClifford (index1 : Int, index2 : Int, qs : Qubit[]) : Unit
    is Adj {

        let n = Length(qs); 
        let bits1 = IntAsBoolArray(index1, n);
        let bits2 = IntAsBoolArray(index2, n);
        // find the index of the first bit at which the bit strings are different
        let diff = FirstDiff(bits1, bits2);

        // we care only about 2 inputs: basis state of bits1 and bits2

        // make sure that the state corresponding to bits1 has qs[diff] set to |0⟩
        if (bits1[diff]) { 
            X(qs[diff]); 
        }
        
        // iterate through the bit strings again, setting the final state of qubits
        for (i in 0..n-1) {
            if (bits1[i] == bits2[i]) {
                // if two bits are the same, set both to 1 using X or nothing
                if (not bits1[i]) {
                    X(qs[i]);
                }
            } else {
                // if two bits are different, set both to 1 using CNOT
                if (i > diff) {
                    if (not bits1[i]) {
                        X(qs[diff]);
                        CNOT(qs[diff], qs[i]);
                        X(qs[diff]);
                    }
                    if (not bits2[i]) {
                        CNOT(qs[diff], qs[i]);
                    }
                }
            }
        }

        // move the differing bit to the last qubit
        if (diff < n-1) {
            SWAP(qs[n-1], qs[diff]);
        }
    }
    
    
    // Helper function: apply the 2x2 unitary operator at the sub-matrix given by indices for 2 rows/columns
    operation Embed2x2Operator (U : (Qubit => Unit is Ctl), index1 : Int, index2 : Int, qs : Qubit[]) : Unit {
        EmbeddingPermClifford(index1, index2, qs);
        Controlled U(Most(qs), Tail(qs));
        Adjoint EmbeddingPermClifford(index1, index2, qs);
    }
}
