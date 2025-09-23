Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2B1154BF5
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613373; cv=none; b=feNFmT3/eyPMMiHe/nagQr4a3Jj9rL5U5/df3JNqnP+RC2PKzBXdodcI1v+F7+5OJQzd50s7ehBKKe750sBaTKT3qG8R3iEFWgRknUPFMmUbKAh5ZHqaEuWQAYUYlckwO49aDnVvdOWTT0FSkIqV9Nj4AGMKZVeLvJcxbGwCSkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613373; c=relaxed/simple;
	bh=v4vA/J5nR9y/1H0wWEE2xipj7OJjVrfidqQyRK9VsSY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hD8yVcbkQBCxEUjGsz0Z8oHbwai3SpGd/CD771QRf+72ykzTvH1S5OuBuBOeqWT+omCOUeFVhRH2aXIAlohCHq+JItbY7gJBhqpPhqYC9ZWIrKDrceXAVXBR3AeoVroyCtWxDAj27VgGq6olkjExd/flfPs8lI84+/2WCcHuljk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X/XA6UMG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/XA6UMG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758613370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v4vA/J5nR9y/1H0wWEE2xipj7OJjVrfidqQyRK9VsSY=;
	b=X/XA6UMGAs5ImDIYfzBnj/hiK8+mf3Wa9DjsvaX6npGt71zj+/oLeeE0Gj5ePOZN71wgDA
	s2mM+c6Z8d+z+LCegvkUvA5LBkCJnflRUqLduGQNH3l/AbsrPslLO5sD6fNOQbflDw5jdl
	qGKaCBW+UNblLQYg/Xp7hHFl4S9oepc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-dK3p8RhVOOiXs4chW67iFQ-1; Tue, 23 Sep 2025 03:42:49 -0400
X-MC-Unique: dK3p8RhVOOiXs4chW67iFQ-1
X-Mimecast-MFC-AGG-ID: dK3p8RhVOOiXs4chW67iFQ_1758613368
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e19f00bc2so9702735e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 00:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758613368; x=1759218168;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3Qv0LLTCUmjMWNaQL1ZnMdluzFHkPix+U/IfYErqFw=;
        b=RY7aL8zh8mN8FtmyJ1cxj/qnUVfYMk8lvTbkuQ09/NKvsgWqeE8ryDzgsCLOXOYUBf
         0IyrC72TbN+N4AYKpcKGTfzZSs/aT6qYcqDE5Oc+IBXUM/lSPE+4sQzBIeaQ30ssiJWz
         cEZNendB/RiApbbZC/puu1MimmeQlkymOiBmHB4pmrokLH86eg8dpwPOrQqSn+5r2eJz
         ml/lRV1djJJK0195pz5/PmlBlMa4uxKBspXRXB7muifN8/+kXXVf+tdL2ilAbfnyLSK1
         IXAT7I8HisipTdPrM8VnM8ocDnhBuAZV1kZcw9+hvO3etofqhFpV4KhkYU/aVytN/Si9
         4jUw==
X-Forwarded-Encrypted: i=1; AJvYcCUpX8lwGp7T46XIKVFumesiACxDjwE8uX3hw8U3QqcfeTAUX6Pb4HDbf8H3A0j79uTJ5pe+21P4sygjfR4IUIt/Nc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI5UF3+v3t2Zz/Pn2X2su55B0s+W06i8knGNNoIkYFmyN1BXZS
	ZN62s1IBAr24Hmkgr7zHFHksCbfimFFqFrQMY4y5MYUuUE/8SxWY1Q1AmXQut05An6OftyNlR4F
	qZqDAskS4hFOAtLEbTvMc4dFRooOIdLE6L7sasWQw6eg4c9LOdeZfkQAJZ+5/sVf+6lj/XrrWPw
	==
X-Gm-Gg: ASbGncvm3AeTDtTCJJeLycPUnqou3Bq+lWteuZPF+ujeBYcHUMoMLOeIjt2zOrYa+Xj
	nHeUo2uvqUujYiRvxK7gp9HEjGYqzPSZSQG/qc6aJazyIdbd4lLYbvT00P2jnArSlkOeseFsZHn
	u3Wu3gK4ijQiA2CUw2muB7hukukTqJpsEOaZ3D7/4NniEieVevc13hxqfMvhBmd18dtnWwcoPc+
	upxulqGQ+HNMosJ5pgGKTs3nMK9B0sBUpo8iGDShuVgGzJdRt6v0a1/CUjVVl5l5oIJveNkLc//
	kkowutrWK87GuDjF4XRw8WP5xE9Bz27dRHzsENnuL4wnMe718GG9mKDKRxAbaZwTRA==
X-Received: by 2002:a05:600c:4c15:b0:45d:e6b6:55fe with SMTP id 5b1f17b1804b1-46e1dacb263mr8066645e9.34.1758613368453;
        Tue, 23 Sep 2025 00:42:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8EXoCWEiqTmNsvoTITySrgXSbYUp7vJCyWTL7RnUVLQ1KyYva3lHV7061HfZx4QliTREupA==
X-Received: by 2002:a05:600c:4c15:b0:45d:e6b6:55fe with SMTP id 5b1f17b1804b1-46e1dacb263mr8066535e9.34.1758613368061;
        Tue, 23 Sep 2025 00:42:48 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613d14d564sm307041065e9.14.2025.09.23.00.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 00:42:47 -0700 (PDT)
Message-ID: <ced1cdde298d105ba2d789e4e4704caac8dec518.camel@redhat.com>
Subject: Re: [PATCH] rv: Add signal reactor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
	 <thomas.weissschuh@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers	 <mathieu.desnoyers@efficios.com>
Date: Tue, 23 Sep 2025 09:42:46 +0200
In-Reply-To: <20250922162900.eNwI7CS0@linutronix.de>
References: <20250919-rv-reactor-signal-v1-1-fb0012034158@linutronix.de>
	 <d0aaaf1f47f0d948b60b0575e179564e3c024188.camel@redhat.com>
	 <20250922162900.eNwI7CS0@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: nJMRg4IK8DsPDdwtb3TLzCsr7C6Oss1Uhr4PLazdHOE_1758613368
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-09-22 at 18:29 +0200, Nam Cao wrote:
> On Fri, Sep 19, 2025 at 02:26:12PM +0200, Gabriele Monaco wrote:
> > On Fri, 2025-09-19 at 12:49 +0200, Thomas Wei=C3=9Fschuh wrote:
> > > +static void rv_reaction_signal(int signal, const char *fmt, va_list =
args)
> > > +{
> > > +=09struct rv_signal_work *work;
> > > +=09char message[256];
> > > +
> > > +=09work =3D mempool_alloc_preallocated(rv_signal_task_work_pool);
> > > +=09if (!work) {
> > > +=09=09pr_warn_ratelimited("Unable to signal through task_work,
> > > sending directly\n");
> > > +=09=09vsnprintf(message, sizeof(message), fmt, args);
> > > +=09=09rv_signal_force_sig(signal, message);
> > > +=09=09return;
> > > +=09}
> >=20
> > Why do you use the task_work at all instead of signalling directly?
> > If that's something not safe from a (any) tracepoint because it can sle=
ep
>=20
> If I remember correctly, sending signals requires a spinlock and therefor=
e
> may sleep on PREEMPT_RT.

Yeah that's what I quickly glanced at. Which seems to be the case also for
mempool_alloc_preallocated by the way, so I'm not sure that's safer than
signalling directly on PREEMPT_RT.

Thomas, did you test your reactor on PREEMPT_RT? I'd expect a few fat warni=
ngs
when this is called from sched tracepoints. Unless you're lucky and never g=
et
contention. Lockdep (CONFIG_PROVE_LOCKING) may help here.

Thanks,
Gabriele

>=20
> > you should definitely not call it if allocation fails.
>=20
> Yep.
>=20
> We probably can get away with not reacting at all if allocation fails, by
> crafting our tests such that only one reaction happens at a time, and
> allocation won't fail.
>=20
> Nam

