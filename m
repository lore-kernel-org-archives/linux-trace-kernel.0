Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E643938A29A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Jul 2026 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784877652; cv=none; b=XMJuU33HYnDYR3kS9S0lwEkba7EjxEbQ00p9eW/4omA9840dB2tOPnUAlWxIW6DMkcPQl97dMXQ3XRz3sx3IFqc9mkbjJzyQnJLcDNJTyMBvmb7nTOe5QWH4e9DYakHmsm7plcqePetg+6yxTrJZcNyclMWoYiQCcMIwJEst05s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784877652; c=relaxed/simple;
	bh=aOiahXnkJLxeXT2PiJPVq12iZVqQpAlIz++UX1OKaMU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qsbv8D/DXDmXMuQrt7+z7jy2d+uELPFoDH0OCX7g53MVSAYerZUrfrLj8p9m/qNWaqY8xYhNfggeoqvYHi/pZCRASYetksWyYcRHz6b3AtCM6hLkDOV6CEh6eEyv1WI4IfrOMj1cZDVqw6otlftLGC/iFvuw4zwnY4MmDoN+8SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZQQFJN5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZQQFJN5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784877649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aOiahXnkJLxeXT2PiJPVq12iZVqQpAlIz++UX1OKaMU=;
	b=JZQQFJN5OWbBf1nhDJdhEku78CGW16JwCsvDzj6XV1H3bLT3xD4T4D8HVK5TPp+BQTxGvB
	ct0azTgQT2cV9pD3MKIK7f6C75uaKuZ7wvzHJdVVElReKlpK9MQ+J2e3g74x6Y1zFxW5GV
	mjC0UUgt+h0ukbITzi6pCkOfn78Ww+s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462--GniF-WyMN2HC94bx9CvtA-1; Fri, 24 Jul 2026 03:20:48 -0400
X-MC-Unique: -GniF-WyMN2HC94bx9CvtA-1
X-Mimecast-MFC-AGG-ID: -GniF-WyMN2HC94bx9CvtA_1784877647
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15d4224f9dso12746266b.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Jul 2026 00:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784877647; x=1785482447;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aOiahXnkJLxeXT2PiJPVq12iZVqQpAlIz++UX1OKaMU=;
        b=ebv0B3N4CuQ+vDKZRgztvuuxukdHy32I49SBpboArG6W0aMMYRAH3c5jz/JwbyU8DS
         7i1+NfThbHkeyLY+06qQBavUFroEmCD3mnfegV9bROZW5xMPaOrgyBv0/EBX+DufFUV1
         ZNKXxMB/2YIuNuvFy7B/QIzW2AkcM0aTscQQ4YygcG6r+XXDmIYd/413kegmcBIbEoad
         77fItOemWuraIDBl0HYUMm1sQfAhMlWQLs9Pg6vxht9WMSt3ZM98nSC9cP9Z+a/rTWmG
         bATO6U+g22qMStFKt9BYQLnZpjLVmNkKlcvMkniAhr3W1rpyvFY9teq71Pkz6E7G/ACA
         4NEw==
X-Forwarded-Encrypted: i=1; AHgh+RrONNeQFRzt5LFhgd7t7A0WONx/sOsqlnctEfJWsr6zZQlbz8nyd2bcirm8hjnaw8xPldfIUEkozQV0M5N8ThRB1pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygHcmnpJynsuiyLlTI3MA/w4BHYPTMT6rKwEWvl1TYNDoVSDiU
	LJ8fRhD0Jm17rJnvoDtbPXVXFeGysqNUHfFpQ31V7i6nydJEe+TtcgF1Fqeukjv6VSvyiI3hDPo
	IezfsBDX1hyr1jiA2D9gWdZOC4z3aEr4AneE6u2yeaufpvNZskRlYmHVKy5HgSlvwmx7yJtYsqg
	==
X-Gm-Gg: AR+sD10Th8oiOzT4YadvISAY4Cv4UwWNkQgwsiOSGAj/Ob7NuOzyG51jV6RWyosdQ0l
	cM2rMdjxdLZDyItU1YFD5aKSmSN18p3qQbq110mDntzEw5N8tdQRKAl01hXGpVAAqRyAHsPXGuo
	+bdajij/d64u+oWhLSsPHyJxvj3NCnEQ+VEKdv+IaNXAW8KEvmgPa0hanC0k3+66vZ/9Q3XnU1D
	ZPPLBnYLb0hil2F2kjoelxsduyUvmFVo9XJLkSJb8T85TKFoIL8d8UtMja2rnpwA4pUuM4w6rDZ
	Tpuuc6QAp2Ui89Xhf/Fqc89B/vCLGK6kmXTqqKb2xbPqd285R8VvPo2LlK0UA9dmS2Y04or6Zhx
	/E1dz0ExmOBRarUEzhIyha2rIS/TyeO2XGzEuIAEmUeZYf8Ra3359M7FZxu1lyURkGecQ+Q==
X-Received: by 2002:a17:907:3ea0:b0:c1c:4858:c1a5 with SMTP id a640c23a62f3a-c1c50904a51mr330801066b.14.1784877647179;
        Fri, 24 Jul 2026 00:20:47 -0700 (PDT)
X-Received: by 2002:a17:907:3ea0:b0:c1c:4858:c1a5 with SMTP id a640c23a62f3a-c1c50904a51mr330799466b.14.1784877646796;
        Fri, 24 Jul 2026 00:20:46 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32a7986bsm315726666b.7.2026.07.24.00.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 00:20:46 -0700 (PDT)
Message-ID: <f2679e058fa3904db3534a5f75d1339a4065018f.camel@redhat.com>
Subject: Re: [RFC PATCH] Documentation/rv: Explain epoll and aborted sleeps
From: Gabriele Monaco <gmonaco@redhat.com>
To: Chao Liu <chao.liu@processmission.com>, Nam Cao <namcao@linutronix.de>, 
 Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>
Cc: lianux.mm@gmail.com, lianux.wang@processmission.com, Shuah Khan
	 <skhan@linuxfoundation.org>, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 24 Jul 2026 09:20:44 +0200
In-Reply-To: <20260722045706.85633-1-chao.liu@processmission.com>
References: <20260722045706.85633-1-chao.liu@processmission.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A7HDBj7x3isUgEzs7zg28rgCY63doylDK2cm4Z7ea7o_1784877647
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-22 at 12:57 +0800, Chao Liu wrote:
> The rtapp sleep monitor accepts epoll_wait() as a valid sleeping
> reason, but the prose only discusses clock_nanosleep and futexes. Add
> epoll_wait to the list of valid sleeping reasons.
>=20
> ABORT_SLEEP represents a task restoring TASK_RUNNING before entering
> the scheduler, but its meaning is not described. Explain why the
> aborted sleep attempt is valid.
>=20
> This RFC is based on Nam Cao's pending "rv: rtapp monitor update" v2
> series:
>=20
> https://lore.kernel.org/r/cover.1781852967.git.namcao@linutronix.de
>=20
> Signed-off-by: Chao Liu <chao.liu@processmission.com>
> ---

Thanks for the contribution! I have a couple of comments, we want to be
assertive in this docs: in general, let's not say something like "this is v=
alid
because the monitor thinks it's valid" but "this is valid because it is rt-=
safe
for reason X".

> =C2=A0Documentation/trace/rv/monitor_rtapp.rst | 6 ++++++
> =C2=A01 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/trace/rv/monitor_rtapp.rst
> b/Documentation/trace/rv/monitor_rtapp.rst
> index 238b59395ff5..234ed4d581ac 100644
> --- a/Documentation/trace/rv/monitor_rtapp.rst
> +++ b/Documentation/trace/rv/monitor_rtapp.rst
> @@ -67,6 +67,8 @@ thread to sleep for one of the following reasons:
> =C2=A0=C2=A0=C2=A0=C2=A0 variables as safe for real-time. As an alternati=
ve, the librtpi library
> =C2=A0=C2=A0=C2=A0=C2=A0 exists to provide a conditional variable impleme=
ntation that is correct
> for
> =C2=A0=C2=A0=C2=A0=C2=A0 real-time applications in Linux.
> +=C2=A0 - Real-time thread waiting for events using `epoll_wait`,

> + which the monitor accepts as a valid sleeping reason for real-time task=
s.

Not adding much value, try:

 which is a real-time-safe syscall for sleeping as it uses PI-aware locking=
.

> =C2=A0
> =C2=A0Beside the reason for sleeping, the eventual waker should also be
> =C2=A0real-time-safe. Namely, one of:
> @@ -114,6 +116,10 @@ The monitor's specification is::
> =C2=A0=C2=A0 ALLOWLIST =3D BLOCK_ON_RT_MUTEX
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or FUT=
EX_LOCK_PI
> =C2=A0
> +`ABORT_SLEEP` represents a task restoring its state to `TASK_RUNNING` be=
fore
> +entering the scheduler. In this case, the task does not actually block,


> + so the monitor treats the aborted sleep attempt as valid.

This sentence is a bit vague. Indeed an /aborted/ sleep is a valid wakeup, =
as if
the task woke up itself without even sleeping, saying "the monitor treats t=
he
attempt as valid" adds no value.

You could rephrase it to (full paragraph for clarity):

`ABORT_SLEEP` represents a task restoring its state to `TASK_RUNNING` befor=
e
entering the scheduler. In this case, the task does not actually block, so =
it is
back to runnable without any wakeup sequence unsafe for real-time.

What do you think?

Thanks,
Gabriele

