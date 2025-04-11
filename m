Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BCF15D5B6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Apr 2025 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744361641; cv=none; b=r6iZ21f4oCLKaqy/4uIS0RXLzK44w9bkadESJOYFm5bme/fA2vJnz38aB0eEJU7LGvQq8HdC0VySpWeL1nqU+gfPk7ph2fjEbytYMFpzeTfQuNiRt/XeSG7rzbXsmpSnLYatp10FPAgdXxGEzO2CT6nWN0l1lVUQAMIhb+BtOf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744361641; c=relaxed/simple;
	bh=k0e87+8OGPQmaFWxAfBs/XQk7xPQcTlDXk5MeAbKx+A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpI/oK/L+ts1BPqQPgLmkSrmVhKmCxIqEr8FirAIxo67MDX8aA7bpt7gMeVNqABn6NMXIadsNgTXD+K5FghQbQv21b/QTSsvqXHoW7mHM1AXMX+qqXgJO6uGuGRgfvMgHHix8PLwO5TMm763d8/wgCdekUPNgNS0FMWNw9TJSeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLgviyZF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLgviyZF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744361638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k0e87+8OGPQmaFWxAfBs/XQk7xPQcTlDXk5MeAbKx+A=;
	b=ZLgviyZFiuP6z5NZT0pV4Lk7HCtukfuGyFPFtlt27ueyrdvcFRAbNhcWlvmOWDYqfRIzaT
	AJQ7ksoWY2ER1o3W+iMA4JdRuXPUe7sUrDUblyYsaS3W0sYKWdc9wH7RHkKdeweZaH8RZU
	XZ3KwW9wXS7yNaNmKWCn9HMo8sAWQaY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-iWGl0erpMPunlz6z0oVcxA-1; Fri, 11 Apr 2025 04:53:57 -0400
X-MC-Unique: iWGl0erpMPunlz6z0oVcxA-1
X-Mimecast-MFC-AGG-ID: iWGl0erpMPunlz6z0oVcxA_1744361636
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3913aea90b4so754495f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Apr 2025 01:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744361636; x=1744966436;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0e87+8OGPQmaFWxAfBs/XQk7xPQcTlDXk5MeAbKx+A=;
        b=cBoOgte5sYQ1RzKoiEDZx8PCmk4sCyZtXTajc4+grVBR9KxRJNz+17vPv18U8uvewW
         yzoDfu4J6KvTKwgooOnVC4sBlyrs+o25O2V3e+Xcm3CNFT+Bae8fHB83jWI4mpsc4wG+
         3yPguU+Q1oyB9Mu8eTXwVKguDhtMeIFF3Q8Idz+5Q8qOxtlMzRL0K3/dr+QVPEXfsYB6
         M9HygLZEXf90i3DpB0ByTHIDrfZpglu4TIcyFrJ6zlnx8VHcr2QPm2/4DQNzXRCbMcmq
         Ihfh3j5QCDXs3j6xSyVhs+haubZHgF+L0oQlEZ00r2ADDuk4nxyOVgRhimGXB5kbmFyK
         DWig==
X-Forwarded-Encrypted: i=1; AJvYcCXW/7LTO/+dHlwAoNL/Nl4Nd4AgBHrOgqJNuxz2e66rk5p4BdOaXKs61JmJDbr22ZqrxE/2Om0VlQhURMkr8gHTTm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNgproiL0jgZ0Sq5Ce+j8SON1BZlxVLbjUYS9S5o4BIrrh4Sdp
	8s4PXV4v9dmHpvOMCDa8UiGV2Dj2AH/IxPN+jjMs/X6BlGBdTBxOd894YLwae4zosIuPuTWRS1G
	ZbQHoWJz32NOFk5XWjctYFdUVuWTwZsyyesNF5eLBjf5Bn9MuoUDf5umIXSDWaBgvUhzj2w==
X-Gm-Gg: ASbGncu+Y4v2nH4gKUbsUx1Y0Ox1Unk+Y68iGYzpz98QKdCKpDOGFfJiym+iJucaDrh
	hhd1mm2esqTepM+6WNaU9xeLv6FOLdNtUomI+Nosz2MdxrsVtslPHqTLlsqvanUcKOdf3i/NgRM
	OWyd1dhs90mRSnSlYI2jPee3wyobxpOv3GZGOR9wofGXoWWRfAhnTSrTE6PO5pN74mLZjIhxIOZ
	D3fnKTHOJr7i29mjmsFErOhBd7upPTBiiWdsOzwxvCqa3sCXX1u6hu9tQOVWZb4aATMcgaEgQMt
	is0SQZ1hgCADCTGJAcoJ8wH6J6oCaUkkVXRaSQ==
X-Received: by 2002:a05:6000:1863:b0:391:952:c728 with SMTP id ffacd0b85a97d-39ea51d2ef2mr1307052f8f.4.1744361636072;
        Fri, 11 Apr 2025 01:53:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZHH2qTSDheGEe1uWpBsnE3Tq6ugbYEaivo2aQTNOcuG05nQHeLEfmSnMJN6OnPKr9PgpSTw==
X-Received: by 2002:a05:6000:1863:b0:391:952:c728 with SMTP id ffacd0b85a97d-39ea51d2ef2mr1307034f8f.4.1744361635759;
        Fri, 11 Apr 2025 01:53:55 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96cfdbsm1342657f8f.40.2025.04.11.01.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 01:53:55 -0700 (PDT)
Message-ID: <16410f1680d27424869f0aa642ef41ae9647bd40.camel@redhat.com>
Subject: Re: [PATCH v2 06/22] verification/dot2k: Remove __buff_to_string()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de
Date: Fri, 11 Apr 2025 10:53:52 +0200
In-Reply-To: <5e50fa5438830238d92c037c6e609db104503584.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
	 <5e50fa5438830238d92c037c6e609db104503584.1744355018.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nGLngAzETT2jU822XwlahHxfLk2a3kKaTs6BscPDQjo_1744361636
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gRnJpLCAyMDI1LTA0LTExIGF0IDA5OjM3ICswMjAwLCBOYW0gQ2FvIHdyb3RlOgo+IHN0ci5q
b2luKCkgY2FuIGRvIHdoYXQgX19idWZmX3RvX3N0cmluZygpIGRvZXMuIFRoZXJlZm9yZSByZXBs
YWNlCj4gX19idWZmX3RvX3N0cmluZygpIHRvIG1ha2UgdGhlIHNjcmlwdHMgbW9yZSBweXRob25p
Yy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBOYW0gQ2FvIDxuYW1jYW9AbGludXRyb25peC5kZT4KPiAt
LS0KPiDCoHRvb2xzL3ZlcmlmaWNhdGlvbi9kb3QyL2RvdDIvZG90MmsucHkgfCAyMSArKysrKyst
LS0tLS0tLS0tLS0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDE1IGRl
bGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS90b29scy92ZXJpZmljYXRpb24vZG90Mi9kb3Qy
L2RvdDJrLnB5Cj4gYi90b29scy92ZXJpZmljYXRpb24vZG90Mi9kb3QyL2RvdDJrLnB5Cj4gaW5k
ZXggZGQ0YjU1MjhhNGYyLi4wOTIyNzU0NDU0YjkgMTAwNjQ0Cj4gLS0tIGEvdG9vbHMvdmVyaWZp
Y2F0aW9uL2RvdDIvZG90Mi9kb3Qyay5weQo+ICsrKyBiL3Rvb2xzL3ZlcmlmaWNhdGlvbi9kb3Qy
L2RvdDIvZG90MmsucHkKPiBAQCAtMTA5LDE1ICsxMDksNiBAQCBjbGFzcyBkb3QyayhEb3QyYyk6
Cj4gwqDCoMKgwqDCoMKgwqDCoCBmZC5jbG9zZSgpCj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
Y29udGVudAo+IMKgCj4gLcKgwqDCoCBkZWYgX19idWZmX3RvX3N0cmluZyhzZWxmLCBidWZmKToK
PiAtwqDCoMKgwqDCoMKgwqAgc3RyaW5nID0gIiIKPiAtCj4gLcKgwqDCoMKgwqDCoMKgIGZvciBs
aW5lIGluIGJ1ZmY6Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RyaW5nID0gc3RyaW5nICsg
bGluZSArICJcbiIKPiAtCj4gLcKgwqDCoMKgwqDCoMKgICMgY3V0IG9mZiB0aGUgbGFzdCBcbgo+
IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gc3RyaW5nWzotMV0KPiAtCj4gwqDCoMKgwqAgZGVmIGZp
bGxfbW9uaXRvcl90eXBlKHNlbGYpOgo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHNlbGYubW9u
aXRvcl90eXBlLnVwcGVyKCkKPiDCoAo+IEBAIC0xNDgsMTkgKzEzOSwxOSBAQCBjbGFzcyBkb3Qy
ayhEb3QyYyk6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnVmZi5hcHBlbmQo
Ilx0ZGFfJXNfJXMoJXMlcyk7IiAlIChoYW5kbGUsCj4gc2VsZi5uYW1lLCBldmVudCwgc2VsZi5l
bnVtX3N1ZmZpeCkpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBidWZmLmFwcGVuZCgifSIp
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ1ZmYuYXBwZW5kKCIiKQo+IC3CoMKgwqDCoMKg
wqDCoCByZXR1cm4gc2VsZi5fX2J1ZmZfdG9fc3RyaW5nKGJ1ZmYpCj4gK8KgwqDCoMKgwqDCoMKg
IHJldHVybiAnXG4nLmpvaW4oYnVmZikKPiDCoAo+IMKgwqDCoMKgIGRlZiBmaWxsX3RyYWNlcG9p
bnRfYXR0YWNoX3Byb2JlKHNlbGYpOgo+IMKgwqDCoMKgwqDCoMKgwqAgYnVmZiA9IFtdCj4gwqDC
oMKgwqDCoMKgwqDCoCBmb3IgZXZlbnQgaW4gc2VsZi5ldmVudHM6Cj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGJ1ZmYuYXBwZW5kKCJcdHJ2X2F0dGFjaF90cmFjZV9wcm9iZShcIiVzXCIsIC8q
IFhYWDoKPiB0cmFjZXBvaW50ICovLCBoYW5kbGVfJXMpOyIgJSAoc2VsZi5uYW1lLCBldmVudCkp
Cj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiBzZWxmLl9fYnVmZl90b19zdHJpbmcoYnVmZikKPiAr
wqDCoMKgwqDCoMKgwqAgcmV0dXJuICdcbicuam9pbihidWZmKQo+IMKgCj4gwqDCoMKgwqAgZGVm
IGZpbGxfdHJhY2Vwb2ludF9kZXRhY2hfaGVscGVyKHNlbGYpOgo+IMKgwqDCoMKgwqDCoMKgwqAg
YnVmZiA9IFtdCj4gwqDCoMKgwqDCoMKgwqDCoCBmb3IgZXZlbnQgaW4gc2VsZi5ldmVudHM6Cj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ1ZmYuYXBwZW5kKCJcdHJ2X2RldGFjaF90cmFjZV9w
cm9iZShcIiVzXCIsIC8qIFhYWDoKPiB0cmFjZXBvaW50ICovLCBoYW5kbGVfJXMpOyIgJSAoc2Vs
Zi5uYW1lLCBldmVudCkpCj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiBzZWxmLl9fYnVmZl90b19z
dHJpbmcoYnVmZikKPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuICdcbicuam9pbihidWZmKQo+IMKg
Cj4gwqDCoMKgwqAgZGVmIGZpbGxfbWFpbl9jKHNlbGYpOgo+IMKgwqDCoMKgwqDCoMKgwqAgbWFp
bl9jID0gc2VsZi5tYWluX2MKPiBAQCAtMjEwLDcgKzIwMSw3IEBAIGNsYXNzIGRvdDJrKERvdDJj
KToKPiDCoMKgwqDCoMKgwqDCoMKgIGJ1ZmYgPSBzZWxmLmZpbGxfbW9kZWxfaF9oZWFkZXIoKQo+
IMKgwqDCoMKgwqDCoMKgwqAgYnVmZiArPSBzZWxmLmZvcm1hdF9tb2RlbCgpCj4gwqAKPiAtwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIHNlbGYuX19idWZmX3RvX3N0cmluZyhidWZmKQo+ICvCoMKgwqDC
oMKgwqDCoCByZXR1cm4gJ1xuJy5qb2luKGJ1ZmYpCj4gwqAKPiDCoMKgwqDCoCBkZWYgZmlsbF9t
b25pdG9yX2NsYXNzX3R5cGUoc2VsZik6Cj4gwqDCoMKgwqDCoMKgwqDCoCBpZiBzZWxmLm1vbml0
b3JfdHlwZSA9PSAicGVyX3Rhc2siOgo+IEBAIC0yNDIsNyArMjMzLDcgQEAgY2xhc3MgZG90Mmso
RG90MmMpOgo+IMKgwqDCoMKgwqDCoMKgwqAgdHBfYXJnc19jID0gIiwgIi5qb2luKFtiIGZvciBh
LGIgaW4gdHBfYXJnc10pCj4gwqDCoMKgwqDCoMKgwqDCoCBidWZmLmFwcGVuZCgiCcKgwqDCoMKg
IFRQX1BST1RPKCVzKSwiICUgdHBfcHJvdG9fYykKPiDCoMKgwqDCoMKgwqDCoMKgIGJ1ZmYuYXBw
ZW5kKCIJwqDCoMKgwqAgVFBfQVJHUyglcykiICUgdHBfYXJnc19jKQo+IC3CoMKgwqDCoMKgwqDC
oCByZXR1cm4gc2VsZi5fX2J1ZmZfdG9fc3RyaW5nKGJ1ZmYpCj4gK8KgwqDCoMKgwqDCoMKgIHJl
dHVybiAnXG4nLmpvaW4oYnVmZikKPiDCoAo+IMKgwqDCoMKgIGRlZiBmaWxsX21vbml0b3JfZGVw
cyhzZWxmKToKPiDCoMKgwqDCoMKgwqDCoMKgIGJ1ZmYgPSBbXQo+IEBAIC0yNTAsNyArMjQxLDcg
QEAgY2xhc3MgZG90MmsoRG90MmMpOgo+IMKgwqDCoMKgwqDCoMKgwqAgaWYgc2VsZi5wYXJlbnQ6
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ1ZmYuYXBwZW5kKCIJZGVwZW5kcyBvbiBSVl9N
T05fJXMiICUKPiBzZWxmLnBhcmVudC51cHBlcigpKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBidWZmLmFwcGVuZCgiCWRlZmF1bHQgeSIpCj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiBzZWxm
Ll9fYnVmZl90b19zdHJpbmcoYnVmZikKPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuICdcbicuam9p
bihidWZmKQo+IMKgCj4gwqDCoMKgwqAgZGVmIGZpbGxfdHJhY2VfaChzZWxmKToKPiDCoMKgwqDC
oMKgwqDCoMKgIHRyYWNlX2ggPSBzZWxmLnRyYWNlX2gKCkdvb2Qgb25lLCBJJ3ZlIGJlZW4gdG9v
IGxhenkgdG8gZG8gaXQuIFRoYW5rcyEKClJldmlld2VkLWJ5OiBHYWJyaWVsZSBNb25hY28gPGdt
b25hY29AcmVkaGF0LmNvbT4K

