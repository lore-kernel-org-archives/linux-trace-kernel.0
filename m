Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931EF319859
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616226; cv=none; b=Np/OC7lUuBD3BGGDCwTg3bC1X3qKKFIkUu8QBcvt8nQgEZ6uBxP4uBkVgDAwq/buem7BUSxKXpSKub/TufUVlv1QLrxBBrJMSUs8n6bRwEpSgznvRT2BnA8Q8kLDQsk/QwRXsK+mQQ0EEIU6bZ0tFEqEIW0frAhrxS61Z/NsrXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616226; c=relaxed/simple;
	bh=6/gjmvkSpii/IqKh9UAiSZNv0CTgqy5Z8pAeKI2X/nw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bc4jDSX0haFDoH0c3lOpjKCQszg9PzzI2zhn7H1tQWPnBYCM03sL+RJgu65na4yf6EzBCGB3QL/OGMbIwSsts/O5DMs3L/iPWh7D8Xh8cjAANjfu0KDDltGP8XNRZcR/+lH3dKUSe5C3O1yiMURbNr0AVXRQdGH+GkN0b8z2nm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBD9qiuY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBD9qiuY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758616223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6/gjmvkSpii/IqKh9UAiSZNv0CTgqy5Z8pAeKI2X/nw=;
	b=EBD9qiuYEww/Ksij+gYtOdd+O5VleltpRlRFyRNYNemU2gPi2b482be1GcnrH/B5o8rJ6n
	0ARgQh4LSwFRjrdj5QTRBXEYTX2nd3OnkAd+UiBkJ39F3b4IOKYSJ60sJdFM+v+cfBfw2o
	ly7VUHErTcOdaYpCZfxWZndjMhA397I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-VVbk2ukUM52vmm7IY2G25g-1; Tue, 23 Sep 2025 04:30:22 -0400
X-MC-Unique: VVbk2ukUM52vmm7IY2G25g-1
X-Mimecast-MFC-AGG-ID: VVbk2ukUM52vmm7IY2G25g_1758616221
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e1a2a28f4so8346505e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758616221; x=1759221021;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLx9R2EJC+i3aV/vbWh4PIETJlQdJjHc+jfvD0nSMck=;
        b=SWVBYaSZSo+Bb0Y9drWoPhlJmvj57uQdVe51RcbRCtJtcYD3qLMnon2Pm+W/6zrY1V
         DEd8lFRYagoLRER4q9Ag/24YSCIvG5CQjXgmo7YUrJP0YVWjuFjPn73hk29Fa91HnkSQ
         Y7pObUvusxrELrTfGO/X1mFwhIDXtmoDtOPAo8iLSVmZIykAHZ4ahSE4TUoOp4P1axzy
         F0hhZjU2FYbadc7oldT3yxsi3XSABLQBUJORSSn6BFJQ28wvki5xYkCG1Syw4J3IIcCI
         xo4IOEqoLAETlHlp4OFm14o4fHPMzxEesaKQ2jBaz5rPDtcbFuNvN0YulxLqIpfpx00R
         GpCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVreaNo/17MgyEJttrSmJw8arLy3FnxffX+pqzCooK3iu1v3R3J62juoTVVJIndBqB8CDWrAHPUGYHV0m6Xl594DH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ9/idBIpc65gej8olbNyCx6x1VMpYDq8BYqTHNywm+EjWSkF7
	xZHnzdwJIVMksLB7sSyRvQDxCZb9nvvvz0wMymK2iiT9IVBJe63oYKqQU71RMI83uz0RFNUSLRR
	/zzXMcEr/ID3WvTuzf1WOvS0KYkmYEkygt9LKTVVaqenYEpvjGbWA8n7YpBQaafSWiDMXLlSdDA
	==
X-Gm-Gg: ASbGncujoTLdsqO6PYnPrAHHINFGr5t7WnP3kQX+U8pwVUqIBtE2BxbaVT+0vEZHjGo
	baS/Akh1U/H2xnDCCRgAn54vpdwsZv7J6oJAr0pq//bcbEcg4rMZmvioRaE7+oTGThaDd16R3yT
	1vTEkmlsbt24d2c3LIZNmsCza+nLmBjs6HwfnBhKaLOCDJrv9JkDlF3nKCC0FUqcqmm0NDPiu/P
	inyZbGus6KgwY4XBXgjsg4bhuBpTszCI6aNODFoLfLVE8R8DXvH3riMcuJB8HjCefvRPtpnBvlq
	tSXhkkKK6dB63MPS77ZFrZidxyNqm/b1UlQzUeB6+HIXNB4QyuLDVwbpIUM7XSVi7w==
X-Received: by 2002:a05:600c:4f12:b0:45f:2843:e76d with SMTP id 5b1f17b1804b1-46e1d973866mr18538045e9.4.1758616220814;
        Tue, 23 Sep 2025 01:30:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW0VkMOIN+fpxJPQSaM1wk6e9xJF4D82MSSPsILxiY2I4mZV59aGE2qlB9thG2n6jd0jvl2g==
X-Received: by 2002:a05:600c:4f12:b0:45f:2843:e76d with SMTP id 5b1f17b1804b1-46e1d973866mr18537665e9.4.1758616220301;
        Tue, 23 Sep 2025 01:30:20 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f0e28c83d6sm17831553f8f.56.2025.09.23.01.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:30:19 -0700 (PDT)
Message-ID: <aacdcc85c9f8d3a51a85b6429646c38d4b239449.camel@redhat.com>
Subject: Re: [PATCH] rv: Fix wrong type cast in enabled_monitors_next()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Nathan Chancellor <nathan@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 23 Sep 2025 10:30:18 +0200
In-Reply-To: <87tt0t4u19.fsf@yellow.woof>
References: <20250806120911.989365-1-namcao@linutronix.de>
	 <20250923002004.GA2836051@ax162> <87tt0t4u19.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Dtt5H9XYELlf2h3R33lMs1AUiQEuZZy2JCVDRuNgWdo_1758616221
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-09-23 at 07:28 +0200, Nam Cao wrote:
> Hi Nathan,
>=20

Thanks for finding this!

> Nathan Chancellor <nathan@kernel.org> writes:
> > I am seeing a crash when reading from
> > /sys/kernel/tracing/rv/enabled_monitors
> > on a couple of my arm64 boxes running Fedora after this change, which
> > landed in mainline in 6.17-rc7. I can reproduce this in QEMU pretty
> > easily.
> ...
> > With this change reverted, there is no crash. As this change seems to
> > have proper justification, is there some other latent bug here?
>=20
> Thanks for the report.
>=20
> Yes, this patch is broken, because argument 'p' of
> enabled_monitors_next() *is* a pointer to struct rv_monitor. I'm not
> sure how did I even test this patch...

Damn, I'm wondering the same :facepalm: ..

> Steven is right, we really need something in kselftest for RV, another th=
ing
> in my RV TODO list.

I can work on that, at least a few selftests for the sysfs, I think this ge=
ts
the top priority now.

>=20
> But reverting is not the real fix, because monitors_show() still expects
> a pointer to list_head. Changing monitors_show() is not an option,
> because it is shared with the 'available_monitors' interface.
>=20
> So the real fix is completely changing the iterator to be list_head
> instead of rv_monitor.

Looks reasonable, can you work on the fix?
I see Steve is out for conferences so this won't be too urgent.

Thanks,
Gabriele

>=20
> Best regards,
> Nam
>=20
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 48338520376f..43e9ea473cda 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -501,7 +501,7 @@ static void *enabled_monitors_next(struct seq_file *m=
,
> void *p, loff_t *pos)
> =C2=A0
> =C2=A0=09list_for_each_entry_continue(mon, &rv_monitors_list, list) {
> =C2=A0=09=09if (mon->enabled)
> -=09=09=09return mon;
> +=09=09=09return &mon->list;
> =C2=A0=09}
> =C2=A0
> =C2=A0=09return NULL;
> @@ -509,7 +509,7 @@ static void *enabled_monitors_next(struct seq_file *m=
,
> void *p, loff_t *pos)
> =C2=A0
> =C2=A0static void *enabled_monitors_start(struct seq_file *m, loff_t *pos=
)
> =C2=A0{
> -=09struct rv_monitor *mon;
> +=09struct list_head *head;
> =C2=A0=09loff_t l;
> =C2=A0
> =C2=A0=09mutex_lock(&rv_interface_lock);
> @@ -517,15 +517,15 @@ static void *enabled_monitors_start(struct seq_file=
 *m,
> loff_t *pos)
> =C2=A0=09if (list_empty(&rv_monitors_list))
> =C2=A0=09=09return NULL;
> =C2=A0
> -=09mon =3D list_entry(&rv_monitors_list, struct rv_monitor, list);
> +=09head =3D &rv_monitors_list;
> =C2=A0
> =C2=A0=09for (l =3D 0; l <=3D *pos; ) {
> -=09=09mon =3D enabled_monitors_next(m, mon, &l);
> -=09=09if (!mon)
> +=09=09head =3D enabled_monitors_next(m, head, &l);
> +=09=09if (!head)
> =C2=A0=09=09=09break;
> =C2=A0=09}
> =C2=A0
> -=09return mon;
> +=09return head;
> =C2=A0}
> =C2=A0
> =C2=A0/*

