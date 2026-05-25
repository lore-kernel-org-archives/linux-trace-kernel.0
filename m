Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45CD3D5643
	for <linux-trace-kernel@vger.kernel.org>; Mon, 25 May 2026 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779696232; cv=none; b=oOBSr9J9YEXYJSpMHua8VE4hhM1N6D+NV7QegSxJDYkNmArZ32KkdD8Zi8szmhi7BSli/vd77uMsk5UxzIZus42VpGsnYgiy2le6uo0EAf3DgYB8XPZNXsVPb8/SZIN/cQi2vMmK+3w/TActVFbYreXeHvQXUckPvOY8c+TGXGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779696232; c=relaxed/simple;
	bh=WSjU0PHpTIs8bu7BgC0Fa7Dm0ggqtR3i0ZUfWRaO0lw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SsPMO3wlKGWwX5qwjq3YHE2YV3O3AjuKjxrvqhsN3YaYyOwuK2tEjpPSgZjeO1+X+qMnlaQwDiM4wgJD1ii1onCzrOwiqhEttg1KtRrta6tLN7U4ruG8swNJKUNOn6yRFamshqDHVpuQGGXuUV0JSC/69+JedZtsK1oav6HhQV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KExM5min; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KExM5min"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779696227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ljfiV7NVBEks1iojSao7hm1RgXp5/EWQvxbkWDe1JGo=;
	b=KExM5minYhhy/UASOpDYTOoTesdN+UTIPCT+wqr1tDk/GpZYoVNvhdkUThR2CKTOoZYtuZ
	cY6hnZXXWHtMKSuB9YbSre+KZ9Lg6xPyYp3UJbNRKKcaI93gYnGB4er8GovsFSA8wWmpeX
	ux/0dnaui5gECB5ywC1SYlEA7m8f1QQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-myxRpP0cNouwa6IYZ5_tXQ-1; Mon, 25 May 2026 04:03:45 -0400
X-MC-Unique: myxRpP0cNouwa6IYZ5_tXQ-1
X-Mimecast-MFC-AGG-ID: myxRpP0cNouwa6IYZ5_tXQ_1779696224
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48fdacf2616so47920285e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 25 May 2026 01:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779696223; x=1780301023;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsukF4dZCU0ZbqW5zX/pXif2FwbM6n8OKZoQAtV0fvI=;
        b=fgeNRw5hYSHuLgV3z3pufaKwl4vvNB7fIqeu8/AJ1lAoZALLj9PArfdHDukZ/rT4cP
         dVMqCwUgNYnEeHyiivUkvrsRVRKP/VAScp/33R1sY24k0AP5qE1ydVWJkhtL3NR44M0q
         NrsS5sUa7eQ+nLE/fYwrNZ7LGiYJEEzrEKxbiytpl1IY44dKxKyoF+i//YUc06NNc8aH
         2viGyl+mEOZdTReBGfm/DBfCM+cjshdFw3HgON3YKURkjOjoZq3mHllYxRdRl3aszwNK
         7NNkfmxBDxiYK3AVByhSuOp9bnj3GdDVUn+als0f3HNhldAuQmc7Qu8Ta+6gWZeQ0HQ/
         0GRw==
X-Forwarded-Encrypted: i=1; AFNElJ8NVSTQhbXI5PMf8A5TWJt3LIbcz+6AYxCctqzYMmXB+VpopWJpUcZZIixlFIMgOxs2J18KjLP9sTlQ7jFroYjhCxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznXkghczSOcgo91gBwC3C7aeC8YE8/p54vfrcW0wzkObik2blz
	172qL/i37rtw7dAn/wpyqKrc4maXavYrs7Nm0Nlff9GxcqyJyqs1unvDv3Xwok4XdyhvI9e1nvX
	1BIOcvgCZQIsfuogHfKiUeTUIpiPVPexowt8qJeocCxpGZt84DmMSbrqXbNXFgvG8jhdKW53mww
	==
X-Gm-Gg: Acq92OEsjaU3Km3ePwG1imV5Owlz8OtPaSGxfEaJTT9Rz5bsVDqPyDQfx8/6IDDspon
	CB7Xb7XbrckQjPEq0oVvfP3M8zWwuunaf2G9au2odc27vdhy+SmTAymm9ZJPCIYbyw3gRQ13cJy
	MDbaluy2YwOOlyoBjMrgqjj14U11z9f5jFUckXyO1edJ6SA1QAu7xjNfQWd+sxFGbXEzJth1b/3
	KNOTknMjkCasqSRaWY2YUxKFs53wnUBNj8nD+12faoSSyssVDJe5oLaCZruMAkLl5unhOMhqtpB
	mVQwlpFDVgOsU3NONWGzyV9urdzAZpo/iepDlMkEkuwbEVTnPYatzSKTtzgfM7F3X8WHh0CBx+Z
	/skPFPRoe/MAEG7OnDk6MavEHFQ8z18OneVKgm633bbq+tQuTzt+9UqQ9CpCrdXzoBDErArr2dI
	xrxkGmLV/30FktLcI=
X-Received: by 2002:a05:600c:3e0d:b0:490:4e3e:b483 with SMTP id 5b1f17b1804b1-4904e3eb5abmr160515845e9.22.1779696223547;
        Mon, 25 May 2026 01:03:43 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0d:b0:490:4e3e:b483 with SMTP id 5b1f17b1804b1-4904e3eb5abmr160515155e9.22.1779696222950;
        Mon, 25 May 2026 01:03:42 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904561f2dfsm217801585e9.12.2026.05.25.01.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 01:03:42 -0700 (PDT)
Message-ID: <054cfff25288a98a7d7922de149be91fcbc79bc0.camel@redhat.com>
Subject: Re: [PATCH 07/13] rv: Simply hybrid automata monitors's clock
 variables
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
	 <wander@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 25 May 2026 10:03:40 +0200
In-Reply-To: <a779af6dc89721179e0dbab08623e42aa0191275.1777962130.git.namcao@linutronix.de>
References: <cover.1777962130.git.namcao@linutronix.de>
	 <a779af6dc89721179e0dbab08623e42aa0191275.1777962130.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FUnX5tNOOB4_nvWEvQkBic9E94okG-_o3KTRZYQTSzo_1779696224
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-05 at 08:59 +0200, Nam Cao wrote:
> -static inline bool ha_check_invariant_ns(struct ha_monitor *ha_mon,
> -=09=09=09=09=09 enum envs env, u64 time_ns)
> +static inline bool ha_check_invariant_ns(struct ha_monitor *ha_mon, enum=
 envs
> env,
> +=09=09=09=09=09 u64 time_ns, u64 expire_ns)
> =C2=A0{
> -=09return READ_ONCE(ha_mon->env_store[env]) >=3D time_ns;
> +=09return time_ns - READ_ONCE(ha_mon->env_store[env]) <=3D expire_ns;
> =C2=A0}

This function had the silent assumption that invalid/uninitialised
values (max u64) pass the check.

This is no longer working (see nomiss) but could be restored by doing:

  READ_ONCE(ha_mon->env_store[env]) >=3D time_ns - expire_ns

But.. Yeah, that's a weak assumption. We should probably refactor the
thing to use ha_reset_env() in ha_monitor_reset_all_stored(), then
variables are never going to be uninitialised. It needs a bit of
tinkering but it's definitely better than now.

I'll try and add that to my fixes series.
And I should add some nomiss and stall selftest..

> -static inline bool ha_check_invariant_jiffy(struct ha_monitor *ha_mon,
> -=09=09=09=09=09=C2=A0=C2=A0=C2=A0 enum envs env, u64 time_ns)
> +static inline bool ha_check_invariant_jiffy(struct ha_monitor *ha_mon, e=
num
> envs env,
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0 u64 time_ns, u64 expire_jiffy)
> =C2=A0{
> -=09return time_after64(READ_ONCE(ha_mon->env_store[env]),
> get_jiffies_64());
> -
> +=09return time_after64(READ_ONCE(ha_mon->env_store[env]) + expire_jiffy,
> get_jiffies_64());
> =C2=A0}

I'd prefer if this was consistent with the above as in (now - env <=3D
expire) or (env >=3D now - env), whichever you prefer but let's keep it
equivalent.
Or do you have a reason to rearrange it here?

Thanks,
Gabriele

