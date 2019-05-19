/*
  Melody
 
 Plays a melody 
 
 circuit:
 * 8-ohm speaker on digital pin 8
 
 created 21 Jan 2010
 modified 30 Aug 2011
 by Tom Igoe 

This example code is in the public domain.
 
 http://arduino.cc/en/Tutorial/Tone
 
 */
 #include "pitches.h"

// notes in the melody:
// note durations: 4 = quarter note, 8 = eighth note, etc.:
//int melody[] = { NOTE_C4, NOTE_G3, NOTE_G3, NOTE_A3, NOTE_G3, 0, NOTE_B3, NOTE_C4};
//int noteDurations[] = { 4, 8, 8, 4,4,4,4,4 };


struct Note
{
   int note;
   float duration;
};

Note melody[] =
{
  // Line 1
  { NOTE_B3, 4.0 }, { NOTE_A3, 4.0 }, { NOTE_G3, 4.0 }, { NOTE_A3, 4.0 },
  { NOTE_B3, 4.0 }, { NOTE_B3, 4.0 }, { NOTE_B3, 2.0 },
  { NOTE_A3, 4.0 }, { NOTE_A3, 4.0 }, { NOTE_A3, 2.0 },
  { NOTE_B3, 4.0 }, { NOTE_D4, 4.0 }, { NOTE_D4, 2.0 },

  // Line 2
  { NOTE_B3, 4.0 }, { NOTE_A3, 4.0 }, { NOTE_G3, 4.0 }, { NOTE_A3, 4.0 },
  { NOTE_B3, 4.0 }, { NOTE_B3, 4.0 }, { NOTE_B3, 4.0 }, { NOTE_B3, 4.0 },
  { NOTE_A3, 4.0 }, { NOTE_A3, 4.0 }, { NOTE_B3, 4.0 }, { NOTE_A3, 4.0 },
  { NOTE_G3, 1.0 },

  // Line 3
  { NOTE_B3, 4.0 }, { NOTE_A3, 4.0 }, { NOTE_G3, 4.0 }, { NOTE_A3, 4.0 },
  { NOTE_B3, 4.0 }, { NOTE_B3, 4.0 }, { NOTE_B3, 2.0 },
  { NOTE_A3, 4.0 }, { NOTE_A3, 4.0 }, { NOTE_A3, 2.0 },
  { NOTE_B3, 4.0 }, { NOTE_D4, 4.0 }, { NOTE_D4, 2.0 },

  // Line 4
  { NOTE_B3, 4.0 }, { NOTE_A3, 4.0 }, { NOTE_G3, 4.0 }, { NOTE_A3, 4.0 },
  { NOTE_B3, 4.0 }, { NOTE_B3, 4.0 }, { NOTE_B3, 4.0 }, { NOTE_B3, 4.0 },
  { NOTE_A3, 4.0 }, { NOTE_A3, 4.0 }, { NOTE_B3, 4.0 }, { NOTE_A3, 4.0 },
  { NOTE_G3, 1.3 }, { NOTE_D4, 4.0 },
 
  // Line 5
  { NOTE_B3, 4.0 }, { NOTE_A3, 4.0 }, { NOTE_G3, 4.0 }, { NOTE_A3, 4.0 },
  { NOTE_B3, 4.0 }, { NOTE_B3, 4.0 }, { NOTE_B3, 2.0 },
  { NOTE_A3, 4.0 }, { NOTE_A3, 4.0 }, { NOTE_A3, 2.0 },
  { NOTE_B3, 4.0 }, { NOTE_D4, 4.0 }, { NOTE_D4, 4.0 }, { NOTE_D4, 4.0 },

  // Line 6
  { NOTE_B3, 4.0 }, { NOTE_A3, 4.0 }, { NOTE_G3, 4.0 }, { NOTE_A3, 4.0 },
  { NOTE_B3, 4.0 }, { NOTE_B3, 4.0 }, { NOTE_B3, 4.0 }, { NOTE_B3, 4.0 },
  { NOTE_A3, 4.0 }, { NOTE_A3, 4.0 }, { NOTE_B3, 4.0 }, { NOTE_A3, 4.0 },
  { NOTE_G3, 1.3 }, { NOTE_D4, 4.0 },

  // Line 7
  { NOTE_B3, 4.0 }, { NOTE_A3, 4.0 }, { NOTE_G3, 4.0 }, { NOTE_A3, 4.0 },
  { NOTE_B3, 4.0 }, { NOTE_B3, 4.0 }, { NOTE_B3, 2.0 },
  { NOTE_A3, 4.0 }, { NOTE_A3, 4.0 }, { NOTE_A3, 2.0 },
  { NOTE_B3, 4.0 }, { NOTE_D4, 4.0 }, { NOTE_D4, 4.0 }, { NOTE_D4, 4.0 },

  // Line 8
  { NOTE_B3, 4.0 }, { NOTE_A3, 4.0 }, { NOTE_G3, 4.0 }, { NOTE_A3, 4.0 },
  { NOTE_B3, 4.0 }, { NOTE_B3, 4.0 }, { NOTE_B3, 4.0 }, { NOTE_B3, 4.0 },
  { NOTE_A3, 4.0 }, { NOTE_A3, 4.0 }, { NOTE_B3, 4.0 }, { NOTE_A3, 4.0 },
  { NOTE_G3, 1.0 },
};


// calculte number of notes by dividing size of melody array (which gives
// bytes) divided by size of an integer (also in bytes).
//int numberOfNotes = sizeof(melody) / sizeof(int);
int numberOfNotes = sizeof(melody) / sizeof(Note);

void setup() 
{
  // initialize the digital pin as an output.
  // Pin 13 has an LED connected on most Arduino boards:
  pinMode(13, OUTPUT);     

  // iterate over the notes of the melody:
  for (int thisNote = 0; thisNote < numberOfNotes; thisNote++) 
  {
    Note& note = melody[thisNode];

    // to calculate the note duration, take one second 
    // divided by the note type.
    //e.g. quarter note = 1000 / 4, eighth note = 1000/8, etc.
    //int noteDuration = 1000/noteDurations[thisNote];
    int noteDuration = 1000/melody[thisNode].duration;
    tone(8, melody[thisNote].note, noteDuration);

    // to distinguish the notes, set a minimum time between them.
    // the note's duration + 30% seems to work well:
    int pauseBetweenNotes = noteDuration * 1.30;
    delay(pauseBetweenNotes);
    // stop the tone playing:
    noTone(8);
  }
}

void loop() 
{
  digitalWrite(13, HIGH);   // set the LED on
  delay(1000);              // wait for a second
  digitalWrite(13, LOW);    // set the LED off
  delay(1000);              // wait for a second
}

