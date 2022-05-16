import 'dart:math';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:vaccine_scheduler/styles.dart';

class InfoTabWidget extends StatelessWidget {
  InfoTabWidget({Key? key}) : super(key: key);

  final colors = [
    Colors.deepOrangeAccent.withOpacity(0.2),
    Colors.orangeAccent.withOpacity(0.2),
    Colors.brown.shade100.withOpacity(0.5),
    Color.fromARGB(255, 251, 0, 0).withOpacity(0.2),
    Colors.pink.withOpacity(0.2),
    Colors.purpleAccent.withOpacity(0.2),
    Colors.blueAccent.withOpacity(0.2),
  ];

  final vaccinesInfo = [
    {
      "Immunization": '''
Immunization, or vaccination is the process by which an individual's immune system becomes fortified against an infectious agent (known as the immunogen).

When this system is exposed to molecules that are foreign to the body, called non-self, it will orchestrate an immune response, and it will also develop the ability to quickly respond to a subsequent encounter because of immunological memory. This is a function of the adaptive immune system. Therefore, by exposing a human, or an animal, to an immunogen in a controlled way, its body can learn to protect itself: this is called active immunization.

Vaccines train your immune system to create antibodies, just as it does when it’s exposed to a disease. However, because vaccines contain only killed or weakened forms of germs like viruses or bacteria, they do not cause the disease or put you at risk of its complications.

Vaccines prevents illness, disabilities and death from vaccines preventable diseases including polio, rotavirus diarrhoea, pneumonia etc
'''
    },
    {
      "Bacille Calmett Guerin (BCG)":
          "Bacille Calmett Guerin (BCG) is the vaccine given to children and / or adults to prevent Mycobacterium tuberculosis infection. In infancy, it is given soon after delivery, usually within the first 48 hours, intradermally, and in the upper arm of the baby. The dose is 0.5 millilitre and this protects against severe forms of tuberculosis for life. The vaccine is very safe."
    },
    {
      "Oral Polio Vaccine ":
          "Oral Polio Vaccine is given to prevent infection from Poliomyelitis virus which causes acute flaccid paralysis. The vaccine has helped eradicate polio in Nigeria, a status achieved in 2019 and it is safe. OPV is given orally as 2 drops per dose, and infants receive it at birth (OPV 0), 6 weeks (OPV 1), 10 weeks (OPV 2), and 14 weeks (OPV 3)."
    },
    {
      "Hepatitis B Vaccine":
          "Hepatitis B is a viral disease that primarily affects the liver causing severe damage to the liver and its functioning. If left untreated, hepatitis B infection can lead to liver cirrhosis and hepatocellular cancer. Hepatitis infection can be contracted following contact with human and bodily fluids, sexually or through blood transfusion. The vaccine is given 3 times at intervals to achieve lifelong immunity against the disease. It is safe and given as intramuscular injection."
    },
    {
      "Pneumococcal vaccine":
          "Pneumococcal vaccine it is given to induce immunity against the pneumococcal organism that causes respiratory infection and meningitis, which is a major cause of childhood illness and death. The vaccine is safe and is given as an intramuscular injection"
    },
    {
      "Rotavirus Vaccine ":
          "Diarrhoeal diseases are one of the commonest causes of death in Nigeria, and the commonest cause of this diarrhoea is rotavirus. This vaccine is given orally and it is safe for all babies. Most babies who receive rotavirus infection do not have any problems but some mothers have reported diarrhoea following administration of the vaccine, and this usually stops within a day."
    },
    {
      "Measles Vaccine ":
          "The measles virus causes a constellation of symptoms and signs, fever, rash, cough, runny nose, and red, watery eyes. Complications can include ear infection, diarrhea, pneumonia, brain damage, and death. It is usually given after 6 months of age because maternal immunity transferred to the baby starts waning at that time."
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 247, 247).withOpacity(0.9),
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: Text(
          "Vaccines Information",
          style: TextStyles.subtitle,
        ),
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              SizedBox(height: 20),
              ...vaccinesInfo
                  .mapIndexed(
                    (index, element) => ExpansionTile(
                      textColor: Colors.black,
                      collapsedBackgroundColor: colors[index % 5],
                      tilePadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      childrenPadding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      title: Text(
                        element.keys.first,
                        style: TextStyles.subtitleSm.medium,
                      ),
                      children: [
                        Text(
                          element[element.keys.first]!,
                          style: TextStyles.body,
                        ),
                      ],
                    ),
                  )
                  .toList(),
              /*   for (var vac in vaccinesInfo) ...[
                ExpansionTile(
                  textColor: Colors.black,
                  collapsedBackgroundColor:
                      colors[Random().nextInt(colors.length)],
                  tilePadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  childrenPadding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  title: Text(
                    vac.keys.first,
                    style: TextStyles.subtitleSm.medium,
                  ),
                  children: [
                    Text(
                      vac[vac.keys.first]!,
                      style: TextStyles.body,
                    ),
                  ],
                ),
              ], */
            ],
          ),
        ),
      ),
    );
  }
}
