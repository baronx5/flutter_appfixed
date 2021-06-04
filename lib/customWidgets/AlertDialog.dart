import 'package:flutter/material.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

messageDialog(BuildContext context, String msg) {
  return AlertDialog(
    title: Text('Message dialog'),
    content: Container(
        height: 200,
        width: 200,
        child: Center(child: Text(msg),)
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, 'OK'),
        child: Text(
          'OK',
          style: TextStyle(
            color: Color(0xFF6200EE),
          ),
        ),
      ),
    ],
  );
}

invoiceDialog(BuildContext context, MFExecutePaymentRequest request, String invoiceId) {
  return AlertDialog(
    title: Center(child: Text('فاتورة الطلب')),
    content: Container(
        height: 200,
        width: 200,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text('تم الطلب بنجاح')),

              Text('الاسم: ${request.customerName.toString()}'),
              Text('رقم الهاتف النقال: ${request.customerMobile.toString()}'),
              Text('البريد الالكتروني: ${request.customerEmail.toString()}'),
              Text('السعر: ${request.invoiceValue.toString()}'),
              Text('رقم الفاتورة: ${invoiceId}'),
            ],
          ),
        )
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, 'OK'),
        child: Text(
          'OK',
          style: TextStyle(
            color: Color(0xFF6200EE),
          ),
        ),
      ),
    ],
  );
}