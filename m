Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7C81EE010
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Apr 2025 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316301; cv=none; b=dLBXlK6D3v2CYQ00ycIkoUIjSiRt9I3maP6ramfR2OWQ4Ef9mGOfMhVJyf8QD2b5UkmGtOVYZqNRNh5CpVQuUg2YIH7fSYeRuV0ULJ2E7iMKYRN2NfAgwIXKpFIqeQL+TcBPtOS18IVYcAHJ0OfrxZ7IImn6WU+aue4m0J5tkjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316301; c=relaxed/simple;
	bh=CdPcvhf/ahPmKmIC1CmEeJxNI7czNB0FGTHZ5c1mbVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I41+eLJeTtVTDXCGTB55tHc4IOE1dDGWZopuOfH+21tu4y0T3I2RoHS0ZL10VBoXVEPPNGnvxd4KSKrt5huGtD+qbSXNhE5q0o5MN4cHh8HZgJX3GyN9qI+Afih7QS/Cl8oTvC3i9gxgTam8s2ivDHiIzePqVP3H5MmY168aIqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvMJRwDT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvMJRwDT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745316296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CdPcvhf/ahPmKmIC1CmEeJxNI7czNB0FGTHZ5c1mbVs=;
	b=DvMJRwDTetzN9slqQeTdtJn653dVKzOtiXuGrjQGp8rljQVBPc326+XuH48sgNmLUagTBp
	pXQxhj3IYYcoAWk8w4/wjwQWZLLGH4YYFn5/PjpS2Mj9mtnDNmvIA+Vd3ZFKckot3nSBaj
	oGi8kcAOtx3b+DHaWW3viQrigGeK7dk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-pidDGwYDNwOLB3xjt5KKOQ-1; Tue, 22 Apr 2025 06:04:55 -0400
X-MC-Unique: pidDGwYDNwOLB3xjt5KKOQ-1
X-Mimecast-MFC-AGG-ID: pidDGwYDNwOLB3xjt5KKOQ_1745316294
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-acb67aad0e2so221677266b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Apr 2025 03:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745316294; x=1745921094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdPcvhf/ahPmKmIC1CmEeJxNI7czNB0FGTHZ5c1mbVs=;
        b=Yv16qZnUVU92ny+hDVQoSmU/AgRDOqDhnU7HSRma3CeLCrX4e0PvoXChZZMwhbnemx
         UTbMleqfVDvkNdoZovlieo9tohSJVe6uEzWLCxUFvG2p8mcmI2XbzxOfr/BD7U3iqGby
         Pqg4muLoZ+yT5lrjw1LQqFlk2wcyvREaVNfQ0GJZyV7F3tm0lzNnHvLLmU15Of/uTM0h
         yIXSPRsoa2ImxuVaYlcO1zcabFekJk+xwc421MN9lIJ+FL0QDGZFCHqV7w6ynwmxQRGb
         k/uKUlh3CXRQE9lgYY7FVHqMKKBvDLBTynR7k5EiuubET61IeoRqlvgtnpDStrNYzZ/t
         XmZg==
X-Forwarded-Encrypted: i=1; AJvYcCU2btJpb2hkGfAmYo+cZCgh4nYmppyqvBGT+WRKhnytiOn/LMPVrQznWmzVLHRvSIZQPLB3wiJFloFWFbDU6zDq6mU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZLd/UdF2oBBZqFDkD1hBPuz9jfH3tKEUsvtJsAJHilOGRlM4B
	hreHyRvJNQpmtkncp9KMYE7+0EAWSce4tdXAxt7URXdrVDqCltiN7ca4ycHysQi8WztBgVxWDOY
	+nxDKUqoQEgqpZZNfWbSphz3nvDia5rQe6tM0cZrD1s2yH4LlJ6Xnm0/29zC6CnPG2ZhAk7hHh6
	+gnCJQDaiMk3F4ELqUw9gAHHvuVy3kRFwNpZ6yZ8mxl1gX
X-Gm-Gg: ASbGncvAxrU5/mGiKYI5dS32QJPc7lp0iSDw7BOAcefvVkI9eXterzLxbGW1ZJ5gXyB
	DA4fCSmMUoE5NLQ6BBso2MtOKZ/ZB+wQ6XGcyU4i+z4YUfCPSI15JbfW6fgOoEnmXhbQ=
X-Received: by 2002:a17:907:da5:b0:ac6:f5b5:36e0 with SMTP id a640c23a62f3a-acb6ee25062mr1472998266b.19.1745316294152;
        Tue, 22 Apr 2025 03:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEocv/L0nToQ7kYM3gB28uBuFBeg8ALFgkKHZKEf3amBvzaQqbbtvC9G/XmbyN3ShDIskp2cRqNYtv1TgpjpYU=
X-Received: by 2002:a17:907:da5:b0:ac6:f5b5:36e0 with SMTP id
 a640c23a62f3a-acb6ee25062mr1472995866b.19.1745316293811; Tue, 22 Apr 2025
 03:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417185757.2194541-1-costa.shul@redhat.com>
In-Reply-To: <20250417185757.2194541-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 22 Apr 2025 12:04:42 +0200
X-Gm-Features: ATxdqUHcspjbOIWY14j0F-oPXOZj_P8-oMYmXO0yXpJlZ0dsTkm6nnAn_YYmvic
Message-ID: <CAP4=nvSf=iBs-nLQj3RVm+xeQyh6_5++qeb0+M4W=0Pqzcu6bw@mail.gmail.com>
Subject: Re: [PATCH v2] rtla: Set distinctive exit value for failed tests
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	John Kacur <jkacur@redhat.com>, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, 
	Eder Zulian <ezulian@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Jan Stancek <jstancek@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pAtq3VNwyKJYLi6f_y7hieiXgztkUd1lMqOnHEhXhco_1745316294
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 17. 4. 2025 v 20:58 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> A test is considered failed when a sample trace exceeds the threshold.
> Failed tests return the same exit code as passed tests, requiring test
> frameworks to determine the result by searching for "hit stop tracing"
> in the output.
>
> Assign a distinct exit code for failed tests to enable the use of shell
> expressions and seamless integration with testing frameworks without the
> need to parse output.
>
> Add enum type for return value.
>
> Update `make check`.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
>
> ---
> v2: Expanded the patch description as requested by Tomas
>

Thank you, looks good to me now.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas

