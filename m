Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A1D366553
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 06:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790836305; cv=none; b=ERbuwn+2nOEUzsquBHW4ghx2KUqB+wgwYZsqid9VU5pbx8HNERGFEvaQxV4Mi5J3kUhm8bJoqJyIkGtozuHL4wyZ/fr9e0ngMSDYKPbpe2Li6SZsLzd0FjtJIH19J2n2w7qD11Yd/oRYaXX3FkMg0EWvMPBJxLSFFu4uTBIko60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790836305; c=relaxed/simple;
	bh=e55rHesjVHHVhmCsC2irpNpvPhA++zKRmYZwYf+RJOk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DyYXGxft+CQVNdjcwvyRhPsfcjnXBUakmzm0mUdkLk3K9EXEGVEwcBfGigtEs+uk9gtGWsQAZf+xe5EnhPjr6vREuETACtXZnsx0JVa95a7Z6BmukzG4KqLTf9koZPOYPHdyvOeXEHSFPefR+WorgTHGK7H2kNA7s7IWZdPJheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZgW+DOC2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZgW+DOC2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790836302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e55rHesjVHHVhmCsC2irpNpvPhA++zKRmYZwYf+RJOk=;
	b=ZgW+DOC2jxega5rnGATZgQTBRdT/AZwnMPxN2OlUS82ncvpzKdwcnldgWA+yZyLnDD/i9/
	MRfUlWjPXZeDM8F6GmMtl2gfOPQIFLHsuVT2zbJsQZKimpOO7/r8Jiq1q0QCEI+4QIHOsj
	7OdHexxn4P2oY9Ym9AibEiH+GmOPDm4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-lIUwFLVPPTC8H5OLKbh-3g-1; Thu, 01 Oct 2026 02:31:41 -0400
X-MC-Unique: lIUwFLVPPTC8H5OLKbh-3g-1
X-Mimecast-MFC-AGG-ID: lIUwFLVPPTC8H5OLKbh-3g_1790836300
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a01c621dc2so6780515e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 23:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790836300; x=1791441100;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KmUsUjxSpFiungKCvsESmFXzpjQ9eHiLCJCMaDAibjo=;
        b=jtdAu+x4VsLV1inIxBV8MnxEEZn1GMB8vZ0F1eVAo4tlmfwGFnkg0Si2Se1kqetGoe
         A5+zAoCUbN/DPAO6C7DywMESzT6+8HD4u0Iezu66V/eeNVqUbIg8o74GjA+JnYfxNnml
         xeGOmGem9wfa0VCXz6F0khq4B5x+bX0U+S1O2mxajLE2fCBSAPfd7OtoCwTAMKQNyvnn
         Gu1MJvHkPcAwalJC1uH25NUyxVvPMjJiCQpiPhN46b7hOHFZY1Z2KDdNj6eMONmxx+FN
         VxQSpAnb+dAuhH/PdIq1MzzmMFywvFYl7pI3sS058qnFrD2zqsY8t4q+UPQpEI02oZ/3
         mV4g==
X-Forwarded-Encrypted: i=1; AKwUvBzdp3p43anSiVGEU0pwQpWPG+ORvd2sl6o9+88nRfwSQrrfdv6+l0b2aZZuJzVIo7vwo6utA7VTGHFB5jgFYR8+c/I=@vger.kernel.org
X-Gm-Message-State: AFuF++mXr5A2jN+SEYogWXso4rj5fEuGQ/Llnv9k69BmRv0N7Q8ytpNr
	WwOzHTVE5ACnBSFl2FcUWRabYkqFS0zrVdX81Vde3BIhZgNnxPIr8r1KtxS7Cfp1vLOuJgyofhb
	TA+bUwOLRDjlWVoVX/oCr27QViNcRRG57ChimgDjQ7H67SPuwSDnjej+MlYdwPzAggCuJbuIHQQ
	==
X-Gm-Gg: AYBFou0IkpKMQLWCsVncPFFcqwihPLVbYFjW2LNIlSMkVHLLXiagw7Vxysn9i2lqBhi
	KYrpEwGQlqf6hIYlMszboc4uePoNuSqJxvtQcH8gytzEprQt+HvSB+I4Gzv6WOVAlLGeCQb2Mwi
	68O9NXJUQe2q2DD99R55yGEHI1o8hZWN96yi6hAIOlYBlHQ+umfErq6lHM6iS8R1VcTAGLnqKWC
	DOgTggSlgo6gihTg+ASD0df4vZ+u1QRt6o5LpUAQafcCyoyJSogb9egWkO84uAJl2xDJaffWzce
	emykyBTgSDzICt05rGPlHXJ0UE77DQR2rbCWXvwgdWjzSdKhdEt3iNdHbL94q+NqFVBz/+ZHqPy
	AVj/Bza0Z5CEZtx6sQjg2Yg9m3BA=
X-Received: by 2002:a05:600c:3ba2:b0:4a0:1b14:e846 with SMTP id 5b1f17b1804b1-4a01b14e893mr67031175e9.4.1790836300191;
        Wed, 30 Sep 2026 23:31:40 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba2:b0:4a0:1b14:e846 with SMTP id 5b1f17b1804b1-4a01b14e893mr67030875e9.4.1790836299812;
        Wed, 30 Sep 2026 23:31:39 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01fa15e51sm43325415e9.2.2026.09.30.23.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 23:31:39 -0700 (PDT)
Message-ID: <e6f78faca93f92981130621d712ac05374d83b05.camel@redhat.com>
Subject: Re: [PATCH] rv/rtapp/wakeup: Use "rv_this" the rv_monitor variable
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, John
 Ogness	 <john.ogness@linutronix.de>
Date: Thu, 01 Oct 2026 08:31:38 +0200
In-Reply-To: <20261001044218.3508990-1-namcao@linutronix.de>
References: <20261001044218.3508990-1-namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AYYg5gvSBsqjlOeD21JRIwpx3bbD8B8AbEUaFAC2pRo_1790836300
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-10-01 at 06:42 +0200, Nam Cao wrote:
> Commit d9e4c61a12dd ("rv: Use generic rv_this for the rv_monitor
> variable in LTL") renamed the rv_monitor variable to rv_this. But
> rtapp/wakeup monitor was late to the party and missed that.
>=20
> So for this monitor, rv_this is an empty struct. The reactor fails to
> work, because rv_react() checks monitor->react and sees NULL.
>=20
> Correct to "rv_this" and make the reactor work again.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Damn.. Thanks for noticing!

That's a weird one, I cannot think of a way to only declare the rv_this, so=
 the
compiler is perfectly happy to give you the empty one..

I'm taking this, but I believe it deserves the Fixes tag. What do you think=
?

Thanks,
Gabriele

> ---
> =C2=A0kernel/trace/rv/monitors/wakeup/wakeup.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/trace/rv/monitors/wakeup/wakeup.c
> b/kernel/trace/rv/monitors/wakeup/wakeup.c
> index 01b47416f24e..2e803e79181e 100644
> --- a/kernel/trace/rv/monitors/wakeup/wakeup.c
> +++ b/kernel/trace/rv/monitors/wakeup/wakeup.c
> @@ -128,7 +128,7 @@ static void disable_wakeup(void)
> =C2=A0=09ltl_monitor_destroy();
> =C2=A0}
> =C2=A0
> -static struct rv_monitor rv_wakeup =3D {
> +static struct rv_monitor rv_this =3D {
> =C2=A0=09.name =3D "wakeup",
> =C2=A0=09.description =3D "Monitor that real-time tasks are not woken by =
lower-
> priority tasks",
> =C2=A0=09.enable =3D enable_wakeup,
> @@ -137,12 +137,12 @@ static struct rv_monitor rv_wakeup =3D {
> =C2=A0
> =C2=A0static int __init register_wakeup(void)
> =C2=A0{
> -=09return rv_register_monitor(&rv_wakeup, &rv_rtapp);
> +=09return rv_register_monitor(&rv_this, &rv_rtapp);
> =C2=A0}
> =C2=A0
> =C2=A0static void __exit unregister_wakeup(void)
> =C2=A0{
> -=09rv_unregister_monitor(&rv_wakeup);
> +=09rv_unregister_monitor(&rv_this);
> =C2=A0}
> =C2=A0
> =C2=A0module_init(register_wakeup);

