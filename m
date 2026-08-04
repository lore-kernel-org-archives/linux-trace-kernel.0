Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364DE4483A2
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840331; cv=none; b=QlfvEZOh4/L917T+tXNbJjciYFrJSz58Udorhjwo4M9DYPS1uwUT9b5y8IL/xk6dKw23wttaKcAtJNqWNSzFyw0XuzybNzy0v07n3rLASgrjlnyWrGyl3gPxfaOvvPdcFMHi5HXEAygJ2M1zW695zHCRb7TIM9muZObbqQYMmVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840331; c=relaxed/simple;
	bh=wLrvAGZ7jOnunflkcxAE6oQVsM5m+51uOLvAKd26H/0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GC+DMiDtBSrAqOxtwSVTOeL8EDgCf8bvP4vXUalfNRdF5N7filimKVFyKbfUeWrUn+Nhn0auTucmZ0Eafx4jM4iTktNNgt5cVrcbEOOeBtM52HcHafpAdgr8coz7vK6nsgI5Xi7SxvNBVKh3xtVTE0YBk2N/5eKnaXfrukR17Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQQSp/fr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQQSp/fr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785840328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wLrvAGZ7jOnunflkcxAE6oQVsM5m+51uOLvAKd26H/0=;
	b=UQQSp/fre+mguEDuO4aMmCe/UftL/UrvqsSSRgISMNVs44fubPwF7BKN3a2P78EQZmer1Z
	8FvAo25D3BgId/hBIOOiK5MNlZIB9JnZsi7p5YCGG0u3bphDhYY5Qlv//YDOU3PnpTgsrF
	JGetn5vNGwXayMg/Oc186g0jSZE4S6k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-UMwtvD7ZOryMp8p5i1nN6g-1; Tue, 04 Aug 2026 06:45:19 -0400
X-MC-Unique: UMwtvD7ZOryMp8p5i1nN6g-1
X-Mimecast-MFC-AGG-ID: UMwtvD7ZOryMp8p5i1nN6g_1785840318
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f8580ed9eso4221849f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 03:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785840318; x=1786445118;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wLrvAGZ7jOnunflkcxAE6oQVsM5m+51uOLvAKd26H/0=;
        b=e0tppaDLZF6473EWmmNzJCnu+JfeL61jrY8NSD2SSrkibtaXJbAr5haAdgSENf2rGl
         7wlzAHJvowwAe9x3edQRDwqCsgcb0UyejhA7P48fKv1UfPIfSVbrTqINEM/SwGGP91pR
         rmSpf89cWmR+xPq24Axy4i6N8yul+kRh63nr4jCdkb+eCKrKaWVCh4VGUq7nsKXy0N2s
         79D8/UeOMrerUI+27i8B526bT+28V7vkKbZE6/Mldxfxv3QEhSFgXbglOmuVtnPv/TbA
         BoJ9UJF+yxX6V9Md1y5ZQCfJouYb6BKh62IbaO03TmX3fl+vpHHW+DRA4mZPVwLyq9jE
         C1lg==
X-Forwarded-Encrypted: i=1; AHgh+Rrh2vm3K52jCP4GFEZAOpvCC/rGGi80nbiztvCMoKor+iL43nXn1u6c6bdSCsoWFsdoXSZjw8TXgLTlPVLdUP0cjz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdlhnktJdV64cE4y1dD5azTajbtm3st1tVLznScZG7xUREWbVW
	TMjw/rv1Asnw8urw5wi7Dz3WXsaBVIdDg4r4N+HW4biInFJ8Z6+cb6EjLP8SsgmyehjvsarWucZ
	nwCl92fEwsNaPMk0Z3BMAujLLD3sGjRVvTjhB2Ag3soTNS4klcdbdR6AmEigDvrGgsVH4kMPIrg
	==
X-Gm-Gg: AR+sD118nf5Q8cBNY2d3XZhXU71Gk91ILPNWKjnjD0oh2csgMafOGFgMAd6to6tZWr1
	0e2gXiDmoaSDqFlmHTY6c8XD5g4Udw6GpxmBZW0a3UIdqO5woM+cCkBuxer3wT0oC2X7dxYfpRH
	bJ5vfkFUov0Ri+WbWUEGQj0Cm1oOw98bOZymg23kqd1LRmE5QXwrS5BCd/XEWKhyyLP8tfa4cbl
	0P4hZ9EXhAQrB7RYN7JVBNBtFFaPhQed28YAnoWko1yIpFmAzTclh5wYsV++OEtXHyXqtTSYvfV
	oKqeYbRoQ6mBWCcQtExAafuwUDLgraU4KrQBxjqZGALYPbqtvTbUAqHHTvtSzN4OeqZlytyQ8An
	Cgg2VmsE1I67si2DjiQ7IGVI5pRua
X-Received: by 2002:a05:600c:3b01:b0:493:f0f5:f2d7 with SMTP id 5b1f17b1804b1-4980c66c90fmr254160035e9.7.1785840318413;
        Tue, 04 Aug 2026 03:45:18 -0700 (PDT)
X-Received: by 2002:a05:600c:3b01:b0:493:f0f5:f2d7 with SMTP id 5b1f17b1804b1-4980c66c90fmr254159185e9.7.1785840317938;
        Tue, 04 Aug 2026 03:45:17 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456a6cbsm38107677f8f.23.2026.08.04.03.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:45:17 -0700 (PDT)
Message-ID: <c9fbfea2eeb6603f275365e61bef0bbfb355d963.camel@redhat.com>
Subject: Re: [RFC PATCH v2] Documentation/rv: Explain epoll and aborted
 sleeps
From: Gabriele Monaco <gmonaco@redhat.com>
To: Chao Liu <chao.liu@processmission.com>, Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, 
	zhouzhouyi@gmail.com, lianux.mm@gmail.com, lianux.wang@processmission.com, 
 Shuah Khan <skhan@linuxfoundation.org>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Tue, 04 Aug 2026 12:45:16 +0200
In-Reply-To: <20260729081102.73138-1-chao.liu@processmission.com>
References: <20260729081102.73138-1-chao.liu@processmission.com>
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
X-Mimecast-MFC-PROC-ID: e7O_F4ZxibxOwMR2MllKwvK0TcOhEpYIJu9OX_oGv_0_1785840318
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-29 at 16:11 +0800, Chao Liu wrote:
> epoll_wait() is a valid sleeping reason for real-time tasks because it
> uses PI-aware locking, but the rtapp sleep monitor documentation only
> discusses clock_nanosleep() and futexes. Document it.
>=20
> ABORT_SLEEP represents a task restoring TASK_RUNNING before entering
> the scheduler. Since the task does not actually block, it becomes
> runnable again without a wakeup sequence unsafe for real-time. Document
> this behavior.
>=20

Looks good, thanks! Please next time you send a patch, even if it's an RFC,=
 put
the extra comments after the --- . This way I can pull it directly without
changing the commit message because git am ignores everything after the ---=
 .
Also, no big deal, but for simple patches like this one, and even after get=
ting
comments, there's no need to mark as RFC.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

I'd appreciate an ack from Nam, then I might be able to squeeze this before=
 the
merge window together with the last fixes.

Thanks,
Gabriele

> This RFC is based on Nam Cao's pending "rv: rtapp monitor update" v2
> series:
>=20
> https://lore.kernel.org/r/cover.1781852967.git.namcao@linutronix.de
>=20
> Signed-off-by: Chao Liu <chao.liu@processmission.com>
> ---
> Changes in v2:
> - Explain why epoll_wait() is RT-safe in terms of PI-aware locking.
> - Explain that ABORT_SLEEP does not require an RT-unsafe wakeup sequence.
> - Update the commit message accordingly.
>=20
> Link to v1:
> https://lore.kernel.org/linux-trace-kernel/20260722045706.85633-1-chao.li=
u@processmission.com/
>=20
> =C2=A0Documentation/trace/rv/monitor_rtapp.rst | 6 ++++++
> =C2=A01 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/trace/rv/monitor_rtapp.rst
> b/Documentation/trace/rv/monitor_rtapp.rst
> index 238b59395ff5..b95994ade14a 100644
> --- a/Documentation/trace/rv/monitor_rtapp.rst
> +++ b/Documentation/trace/rv/monitor_rtapp.rst
> @@ -67,6 +67,8 @@ thread to sleep for one of the following reasons:
> =C2=A0=C2=A0=C2=A0=C2=A0 variables as safe for real-time. As an alternati=
ve, the librtpi library
> =C2=A0=C2=A0=C2=A0=C2=A0 exists to provide a conditional variable impleme=
ntation that is correct
> for
> =C2=A0=C2=A0=C2=A0=C2=A0 real-time applications in Linux.
> +=C2=A0 - Real-time thread waiting for events using `epoll_wait`, which i=
s a
> +=C2=A0=C2=A0=C2=A0 real-time-safe syscall for sleeping as it uses PI-awa=
re locking.
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
> +entering the scheduler. In this case, the task does not actually block, =
so
> the
> +task is back to runnable without any wakeup sequence unsafe for real-tim=
e.
> +
> =C2=A0Beside the scenarios described above, this specification also defin=
es an
> allow list
> =C2=A0to handle some special cases:
> =C2=A0
>=20
> base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
> prerequisite-patch-id: d8b6c952a954662852e6b0684e0a3386eaab7f41
> prerequisite-patch-id: 940f7637aeabe4ba15a09c048c6f48138406f332
> prerequisite-patch-id: b99812692691f76d825778e01a2e771e058febd6
> prerequisite-patch-id: 512c300dce2cb74ac9cc007f9234aa507ef5c008

