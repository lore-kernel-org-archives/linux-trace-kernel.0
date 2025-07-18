Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0281FBCA1
	for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752831335; cv=none; b=Xrn7s24dlGgp0uXE3pACaFj+kNMR7KzKNV6+FZoYdZHhDgAttY+rSLrauRnIzSWSR7/jqRyGdXm6CWQKzO04tJZZEG5Mo6uLLg+62r8Jojv6/zeMs4pT6wqEhi6rmOmUmaFwL0R3fh2C2ZzM1TO8qiRs0vySgAEJGGN7abPTIz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752831335; c=relaxed/simple;
	bh=j32iSwaPRhCdbNytF/aLuJvBvQUaJNyRi6rUn8fDeWg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajg/mMz1mXLFl71ajET+JciGTYbvUrvSWyG7NbDLzNyg7xYzVJhxwgKWPLwbn9EzC/HBqgcJ6WSi/ER1Uk6vFSAHdtn5/SPygHMpIbQabt4xDiHMWM7SBVaZFzW6zKrqvTZG7f+FJC2bgu/HKBChcJvECrpIOniPpM3QrPmkR2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zwv0SrBO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zwv0SrBO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752831332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j32iSwaPRhCdbNytF/aLuJvBvQUaJNyRi6rUn8fDeWg=;
	b=Zwv0SrBO9CZ8va+6QgL+bzMYJCp1LGLSquhXmd6oXoOwq8Ors5PEAkfU7/qeNfJSRNEM+Z
	XqFlsnLJQZlz6tj/TxtYQ976jcYyR3Qx7mRweKimIh8iWhMlSC8/c5fb65hdO2LHrps00V
	ll5QrTVIoe9MSVilcfrTurabuaGn5bM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-KsmZ8r1JNveDwANKYUWUYg-1; Fri, 18 Jul 2025 05:35:31 -0400
X-MC-Unique: KsmZ8r1JNveDwANKYUWUYg-1
X-Mimecast-MFC-AGG-ID: KsmZ8r1JNveDwANKYUWUYg_1752831330
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4561611dc2aso16663205e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752831330; x=1753436130;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iTF6vz15x5rsg8l38DnxKYnwMg1qcWf6xTcMKtsaUCM=;
        b=ni09S8umMF66DcifIg/pKSx1/2C3f4YuPq7EjOCc8NBQPZCdRpP/fSSHRb1HVf6I+Y
         qqURfd7AcNBfFDOMA1FA1pd/8prFuKSqhKAT1uCp59Xk0kq4tbvBLKHtkUdps+4mGIUC
         U1U33FijmmilFlLDC2FZMWClroTbLpornz+uOSFXFNDMOeCTsv297OiTNo8z0u1C9ghV
         bh7bfmQkPoMDGgIwTWx8kxMQacAMTemXDqnwXSPOHNvzJ6MXSlab6ONDVYM/jhWe5gL3
         2C6SZSr7Qbzy1DWLHVWF+soeaoI1cdIch8wSndUEuXk+KV4mgU2V+lR2t2L3rPhvLGYV
         PNNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+ia6aHwUxW+KWaLJmroLQx99DVHnz2vuM2pABtTstp2zDanXGV2l1wHc5AczrRRrJpsJc95jguUPPCr6UXKN9cUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXMmvBJuPbjUJ7V9MiIQClfBJHksIqk0cHzKM/Rcuz5gf+VlHu
	FhViRa/ne0+uSOSYJXw3EPPobymIlG6PXET6ROqdwvcm9kViEuojlOPX8rsTdYzIT/Xol+tjA/T
	I7//sWno79gHszs/3GebloXzzpDN7SwD+kRu+4GbWzyfUy76Y9uYuABkA+0+UBF1iJhz+sHQogl
	bOYL2Hj1J3
X-Gm-Gg: ASbGncvvnTmSJ7oz8MRNKyD57TgQFikI9jubmFfQFQQT2IDMFwH6jNkOUManGybt/uW
	Zx/xK8RaQ9NZGmi3TL9lGq/mPQ2Rlxdza4Nrh3nzgillXS6PKq96Hb12m2dxu0rEfexDPEkViSV
	ow0nLwv3Ef1zXVxKfTg5IAIFFi00kALNn5yjUA/3d9ojeUjQIegDbuH5yRH2dalbw5owCNFgXsc
	EIUOBwCcXHPbVSr8LfVLGkRkPxTSHdTTM4grcNIE7ZGaGNL2ASaTkP5ETlDE/MGiLb1sWA1uCqB
	uGp0L2odk7Rr144XvWuNrVn0VntlCPaDQHH3Q1WMI7ow5CWMHPbJZK5DAWMcY8fcbQ==
X-Received: by 2002:a05:600c:3491:b0:439:9b2a:1b2f with SMTP id 5b1f17b1804b1-4562e039d93mr105237635e9.3.1752831329884;
        Fri, 18 Jul 2025 02:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGQ7ZA5e7DAm4x7neiy2lZh2cXrvrJW8tFpyTLTBIoUHtoh3gHTEOBzZXNrp024CiQjWToSA==
X-Received: by 2002:a05:600c:3491:b0:439:9b2a:1b2f with SMTP id 5b1f17b1804b1-4562e039d93mr105237345e9.3.1752831329405;
        Fri, 18 Jul 2025 02:35:29 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bf4bsm1317245f8f.31.2025.07.18.02.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 02:35:28 -0700 (PDT)
Message-ID: <57b1e83ede5ef8f5b2d661b3326374d82da0bd1a.camel@redhat.com>
Subject: Re: [PATCH] rv: Ensure containers are registered first
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Date: Fri, 18 Jul 2025 11:35:27 +0200
In-Reply-To: <20250718091850.2057864-1-namcao@linutronix.de>
References: <20250718091850.2057864-1-namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LWEETLYIbFOwsMRYV6S7NvXKlG5ItfjCs31dFVLwj88_1752831330
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-07-18 at 11:18 +0200, Nam Cao wrote:
> If rv_register_monitor() is called with a non-NULL parent pointer
> (i.e. by
> monitors inside a container), it is expected that the parent (a.k.a
> container) is already registered.
>=20
> The containers seem to always be registered first. I suspect because
> of the order in Makefile. But nothing guarantees this.

Yes, the linking order does guarantee this.
But I guess it doesn't hurt enforcing it.

Anyway do you have a good reason for using device_initcall/__exitcall
instead of module_init/module_exit?
Keeping those might save a bit of ifdeffery if (when) we decide to
fully support RV monitors as kernel modules.

Thanks,
Gabriele

>=20
> If this registering order is changed, "strange" things happen. For
> example,
> if the container is registered last, rv_is_container_monitor()
> incorrectly
> says this is NOT a container. .enable() is then called, which is NULL
> for
> container, thus we have a NULL pointer deref crash.
>=20
> Guarantee that containers are registered first.
>=20
> Fixes: cb85c660fcd4 ("rv: Add option for nested monitors and include
> sched")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 5 +++++
> =C2=A0kernel/trace/rv/monitors/pagefault/pagefault.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/rtapp/rtapp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/sched/sched.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/sco/sco.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/scpd/scpd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/sleep/sleep.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/sncid/sncid.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/snep/snep.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/snroc/snroc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/tss/tss.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/wip/wip.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/wwnr/wwnr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0tools/verification/rvgen/rvgen/templates/container/main.c | 4 ++--
> =C2=A0tools/verification/rvgen/rvgen/templates/dot2k/main.c=C2=A0=C2=A0=
=C2=A0=C2=A0 | 4 ++--
> =C2=A0tools/verification/rvgen/rvgen/templates/ltl2k/main.c=C2=A0=C2=A0=
=C2=A0=C2=A0 | 4 ++--
> =C2=A016 files changed, 35 insertions(+), 30 deletions(-)
>=20
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 97baf58d88b2..094c9f62389c 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -119,5 +119,10 @@ static inline bool rv_reacting_on(void)
> =C2=A0}
> =C2=A0#endif /* CONFIG_RV_REACTORS */
> =C2=A0
> +#define rv_container_init device_initcall
> +#define rv_container_exit __exitcall
> +#define rv_monitor_init late_initcall
> +#define rv_monitor_exit __exitcall
> +
> =C2=A0#endif /* CONFIG_RV */
> =C2=A0#endif /* _LINUX_RV_H */
> diff --git a/kernel/trace/rv/monitors/pagefault/pagefault.c
> b/kernel/trace/rv/monitors/pagefault/pagefault.c
> index 9fe6123b2200..2b226d27ddff 100644
> --- a/kernel/trace/rv/monitors/pagefault/pagefault.c
> +++ b/kernel/trace/rv/monitors/pagefault/pagefault.c
> @@ -80,8 +80,8 @@ static void __exit unregister_pagefault(void)
> =C2=A0=09rv_unregister_monitor(&rv_pagefault);
> =C2=A0}
> =C2=A0
> -module_init(register_pagefault);
> -module_exit(unregister_pagefault);
> +rv_monitor_init(register_pagefault);
> +rv_monitor_exit(unregister_pagefault);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
> diff --git a/kernel/trace/rv/monitors/rtapp/rtapp.c
> b/kernel/trace/rv/monitors/rtapp/rtapp.c
> index fd75fc927d65..b078327e71bf 100644
> --- a/kernel/trace/rv/monitors/rtapp/rtapp.c
> +++ b/kernel/trace/rv/monitors/rtapp/rtapp.c
> @@ -25,8 +25,8 @@ static void __exit unregister_rtapp(void)
> =C2=A0=09rv_unregister_monitor(&rv_rtapp);
> =C2=A0}
> =C2=A0
> -module_init(register_rtapp);
> -module_exit(unregister_rtapp);
> +rv_container_init(register_rtapp);
> +rv_container_exit(unregister_rtapp);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
> diff --git a/kernel/trace/rv/monitors/sched/sched.c
> b/kernel/trace/rv/monitors/sched/sched.c
> index 905e03c3c934..e89e193bd8e0 100644
> --- a/kernel/trace/rv/monitors/sched/sched.c
> +++ b/kernel/trace/rv/monitors/sched/sched.c
> @@ -30,8 +30,8 @@ static void __exit unregister_sched(void)
> =C2=A0=09rv_unregister_monitor(&rv_sched);
> =C2=A0}
> =C2=A0
> -module_init(register_sched);
> -module_exit(unregister_sched);
> +rv_container_init(register_sched);
> +rv_container_exit(unregister_sched);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
> diff --git a/kernel/trace/rv/monitors/sco/sco.c
> b/kernel/trace/rv/monitors/sco/sco.c
> index 4cff59220bfc..b96e09e64a2f 100644
> --- a/kernel/trace/rv/monitors/sco/sco.c
> +++ b/kernel/trace/rv/monitors/sco/sco.c
> @@ -80,8 +80,8 @@ static void __exit unregister_sco(void)
> =C2=A0=09rv_unregister_monitor(&rv_sco);
> =C2=A0}
> =C2=A0
> -module_init(register_sco);
> -module_exit(unregister_sco);
> +rv_monitor_init(register_sco);
> +rv_monitor_exit(unregister_sco);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
> diff --git a/kernel/trace/rv/monitors/scpd/scpd.c
> b/kernel/trace/rv/monitors/scpd/scpd.c
> index cbdd6a5f8d7f..a4c8e78fa768 100644
> --- a/kernel/trace/rv/monitors/scpd/scpd.c
> +++ b/kernel/trace/rv/monitors/scpd/scpd.c
> @@ -88,8 +88,8 @@ static void __exit unregister_scpd(void)
> =C2=A0=09rv_unregister_monitor(&rv_scpd);
> =C2=A0}
> =C2=A0
> -module_init(register_scpd);
> -module_exit(unregister_scpd);
> +rv_monitor_init(register_scpd);
> +rv_monitor_exit(unregister_scpd);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
> diff --git a/kernel/trace/rv/monitors/sleep/sleep.c
> b/kernel/trace/rv/monitors/sleep/sleep.c
> index eea447b06907..6980f8de725d 100644
> --- a/kernel/trace/rv/monitors/sleep/sleep.c
> +++ b/kernel/trace/rv/monitors/sleep/sleep.c
> @@ -229,8 +229,8 @@ static void __exit unregister_sleep(void)
> =C2=A0=09rv_unregister_monitor(&rv_sleep);
> =C2=A0}
> =C2=A0
> -module_init(register_sleep);
> -module_exit(unregister_sleep);
> +rv_monitor_init(register_sleep);
> +rv_monitor_exit(unregister_sleep);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
> diff --git a/kernel/trace/rv/monitors/sncid/sncid.c
> b/kernel/trace/rv/monitors/sncid/sncid.c
> index f5037cd6214c..97a126c6083a 100644
> --- a/kernel/trace/rv/monitors/sncid/sncid.c
> +++ b/kernel/trace/rv/monitors/sncid/sncid.c
> @@ -88,8 +88,8 @@ static void __exit unregister_sncid(void)
> =C2=A0=09rv_unregister_monitor(&rv_sncid);
> =C2=A0}
> =C2=A0
> -module_init(register_sncid);
> -module_exit(unregister_sncid);
> +rv_monitor_init(register_sncid);
> +rv_monitor_exit(unregister_sncid);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
> diff --git a/kernel/trace/rv/monitors/snep/snep.c
> b/kernel/trace/rv/monitors/snep/snep.c
> index 0076ba6d7ea4..376a856ebffa 100644
> --- a/kernel/trace/rv/monitors/snep/snep.c
> +++ b/kernel/trace/rv/monitors/snep/snep.c
> @@ -88,8 +88,8 @@ static void __exit unregister_snep(void)
> =C2=A0=09rv_unregister_monitor(&rv_snep);
> =C2=A0}
> =C2=A0
> -module_init(register_snep);
> -module_exit(unregister_snep);
> +rv_monitor_init(register_snep);
> +rv_monitor_exit(unregister_snep);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
> diff --git a/kernel/trace/rv/monitors/snroc/snroc.c
> b/kernel/trace/rv/monitors/snroc/snroc.c
> index bb1f60d55296..e4439605b4b6 100644
> --- a/kernel/trace/rv/monitors/snroc/snroc.c
> +++ b/kernel/trace/rv/monitors/snroc/snroc.c
> @@ -77,8 +77,8 @@ static void __exit unregister_snroc(void)
> =C2=A0=09rv_unregister_monitor(&rv_snroc);
> =C2=A0}
> =C2=A0
> -module_init(register_snroc);
> -module_exit(unregister_snroc);
> +rv_monitor_init(register_snroc);
> +rv_monitor_exit(unregister_snroc);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
> diff --git a/kernel/trace/rv/monitors/tss/tss.c
> b/kernel/trace/rv/monitors/tss/tss.c
> index 542787e6524f..8f960c9fe0ff 100644
> --- a/kernel/trace/rv/monitors/tss/tss.c
> +++ b/kernel/trace/rv/monitors/tss/tss.c
> @@ -83,8 +83,8 @@ static void __exit unregister_tss(void)
> =C2=A0=09rv_unregister_monitor(&rv_tss);
> =C2=A0}
> =C2=A0
> -module_init(register_tss);
> -module_exit(unregister_tss);
> +rv_monitor_init(register_tss);
> +rv_monitor_exit(unregister_tss);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
> diff --git a/kernel/trace/rv/monitors/wip/wip.c
> b/kernel/trace/rv/monitors/wip/wip.c
> index ed758fec8608..5c39c6074bd3 100644
> --- a/kernel/trace/rv/monitors/wip/wip.c
> +++ b/kernel/trace/rv/monitors/wip/wip.c
> @@ -80,8 +80,8 @@ static void __exit unregister_wip(void)
> =C2=A0=09rv_unregister_monitor(&rv_wip);
> =C2=A0}
> =C2=A0
> -module_init(register_wip);
> -module_exit(unregister_wip);
> +rv_monitor_init(register_wip);
> +rv_monitor_exit(unregister_wip);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Daniel Bristot de Oliveira <bristot@kernel.org>");
> diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.c
> b/kernel/trace/rv/monitors/wwnr/wwnr.c
> index 172f31c4b0f3..ec671546f571 100644
> --- a/kernel/trace/rv/monitors/wwnr/wwnr.c
> +++ b/kernel/trace/rv/monitors/wwnr/wwnr.c
> @@ -79,8 +79,8 @@ static void __exit unregister_wwnr(void)
> =C2=A0=09rv_unregister_monitor(&rv_wwnr);
> =C2=A0}
> =C2=A0
> -module_init(register_wwnr);
> -module_exit(unregister_wwnr);
> +rv_monitor_init(register_wwnr);
> +rv_monitor_exit(unregister_wwnr);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Daniel Bristot de Oliveira <bristot@kernel.org>");
> diff --git
> a/tools/verification/rvgen/rvgen/templates/container/main.c
> b/tools/verification/rvgen/rvgen/templates/container/main.c
> index 89fc17cf8958..5820c9705d0f 100644
> --- a/tools/verification/rvgen/rvgen/templates/container/main.c
> +++ b/tools/verification/rvgen/rvgen/templates/container/main.c
> @@ -30,8 +30,8 @@ static void __exit unregister_%%MODEL_NAME%%(void)
> =C2=A0=09rv_unregister_monitor(&rv_%%MODEL_NAME%%);
> =C2=A0}
> =C2=A0
> -module_init(register_%%MODEL_NAME%%);
> -module_exit(unregister_%%MODEL_NAME%%);
> +rv_container_init(register_%%MODEL_NAME%%);
> +rv_container_exit(unregister_%%MODEL_NAME%%);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("dot2k: auto-generated");
> diff --git a/tools/verification/rvgen/rvgen/templates/dot2k/main.c
> b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
> index 83044a20c89a..d6bd248aba9c 100644
> --- a/tools/verification/rvgen/rvgen/templates/dot2k/main.c
> +++ b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
> @@ -83,8 +83,8 @@ static void __exit unregister_%%MODEL_NAME%%(void)
> =C2=A0=09rv_unregister_monitor(&rv_%%MODEL_NAME%%);
> =C2=A0}
> =C2=A0
> -module_init(register_%%MODEL_NAME%%);
> -module_exit(unregister_%%MODEL_NAME%%);
> +rv_monitor_init(register_%%MODEL_NAME%%);
> +rv_monitor_exit(unregister_%%MODEL_NAME%%);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("dot2k: auto-generated");
> diff --git a/tools/verification/rvgen/rvgen/templates/ltl2k/main.c
> b/tools/verification/rvgen/rvgen/templates/ltl2k/main.c
> index f85d076fbf78..2069a7a0f1ae 100644
> --- a/tools/verification/rvgen/rvgen/templates/ltl2k/main.c
> +++ b/tools/verification/rvgen/rvgen/templates/ltl2k/main.c
> @@ -94,8 +94,8 @@ static void __exit unregister_%%MODEL_NAME%%(void)
> =C2=A0=09rv_unregister_monitor(&rv_%%MODEL_NAME%%);
> =C2=A0}
> =C2=A0
> -module_init(register_%%MODEL_NAME%%);
> -module_exit(unregister_%%MODEL_NAME%%);
> +rv_monitor_init(register_%%MODEL_NAME%%);
> +rv_monitor_exit(unregister_%%MODEL_NAME%%);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR(/* TODO */);

