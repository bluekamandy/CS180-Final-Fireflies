#pragma once

#include <vector>

#ifndef _COMMON_H_
#define _COMMON_H_

namespace masood
{
    float randFloat(float l, float h);

    // Drawback of my method is that it doesn't check for numeric types
    // or bad input. This is beyond my capabilities right now.

    // Based loosely on Processing.org's map function,
    // though I've made the math a bit more clear.

    template <class T>
    inline T map(T value, T low1, T high1, T low2, T high2)
    {
        float slope = (value - low1) / (high1 - low1);
        return slope * (high2 - low2) + low2;
    }

    // Based loosely on constrian from Processing and Arduino
    // https://stackoverflow.com/questions/8941262/constrain-function-port-from-arduino

    template <class T>
    inline T constrain(T x, T a, T b)
    {
        if (x < a)
        {
            return a;
        }
        else if (b < x)
        {
            return b;
        }
        else
            return x;
    }

}

#endif