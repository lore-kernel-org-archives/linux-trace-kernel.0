Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB7D8BEE
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104052; cv=none; b=JasNbLMsVEyuJ6C0edMeJMRnOER7ZMirz3ppPc0qaI1c3FEmMLA7ol809L9Pu99r+CbRtJhjeugWFrGArnqop4lhV02sAYzhgBjouFl/8T1JgA6R1Tkix8p80MSca6TMUMVrThIGOecVSmIReebxVz1M8gO2wSqcY+UixlPihc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104052; c=relaxed/simple;
	bh=tYoNAwNsLr8pHoM3EsHU74MkBwQ/e8QRpH4ju7+c4mk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKzS3sXEia/ErwRBfpyIDai05SaIccAju6087d3Eb1hsRAlnxu54c+ZdU34S6/CiFutmegfLDmaNOvnPWr4guZGNutyFvy08CchPo4ywWyQTeWYJ6PheArslAdC1L2PoVYSZVmW54MSEL7pbSf6OKKZjOhIs2aE7idEoOWkre4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFUUWdVh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFUUWdVh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753104049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tYoNAwNsLr8pHoM3EsHU74MkBwQ/e8QRpH4ju7+c4mk=;
	b=ZFUUWdVh7yiaIcmoV/uSAs9XBp6kU67+fF8FDtCVNO7CxGEOBESIN1uCXqNYgICpG0kzCI
	da5cmvRiLsOB0uKJZPokX9Nm0ysq6ntGvxiJdgmHf+687IRpixzympvxS6aOW7WIW2soZH
	jFkGR98h1/XIe7fflVVzm9SAZZsNnRo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-dZ3KnkeGOwqQM-ZCLUiMTQ-1; Mon, 21 Jul 2025 09:20:48 -0400
X-MC-Unique: dZ3KnkeGOwqQM-ZCLUiMTQ-1
X-Mimecast-MFC-AGG-ID: dZ3KnkeGOwqQM-ZCLUiMTQ_1753104047
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso25634845e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753104047; x=1753708847;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+AoU5qxLehjaVgf+JGObJ+FmPcimzGOtcrHBsNtP8U=;
        b=inelrMtqf7zSQM7kT9/OUfcABze16CNWHXj8/LDGZOAvdYlxxTnoiCZxWI9+l1eJyV
         ScKxq+h/sK/Pd4NLjZSJA+I8ZYJSeTrWOkQ7OobjSveMq/N1vVDiMoxCP+IhkIECP3s3
         yv67YyuIy5a8fF/m1NEtbW4L+EcmeA3CgnY069n1G1SYo4pOHZFO4DiTyBxnqW2R7hRp
         /5Eqp1sFMkQId8LherkZtLjCjaZBmhNRS3zTL6IAkAKxbknYrTFMLm2XcDnINz7S2jtS
         JcA3zEm5/yZ4ZuAnezz+Ysk7V4Mx7FMBmKq2GLScSajRP1tk7CCR3NmHPMj9VVdFmBuT
         W1ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWjprUJ9d/DScnQMODPy1rJj+OzG2dwXOwl/wJNxaOT7b+r3iDsj+SrB7jagX4Xn4+Jsq8Yo5m0iahLrJsjavxKVxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI6Ria/MEgB8CRHfOf3uwhs/R9SfPxBVyPCMLqj+wDgVJ/gG9X
	gHSTpmL7PYKglByA4XR2i4sbilR3HVMppIyM1TPS5b0YQDv3MDlLU1Zinll7VF+EPt4K1OKQihC
	QIQZsQI70bdWrggjqheHVofDwwQUMlU+T0R9PxAQZH2XzbTt8BsgLsxUiFbvShGzT08FqNr0E1w
	==
X-Gm-Gg: ASbGncs6+UZAp9zPm9YyX22T0kbv0UOCJ8kPvY4OwuuVTQ3wTTrJX3O+JYhU85XaFv5
	SUKM6i3eDINSKIqo3rt7ClXtD5REcRXYGoigGHr9vE5YbY4M7YRVWiOoEG7bzFSUI/OJ77uDjMV
	Fr9aNsx86uhx470+95BqALR+Dc7iCgYpk2ZNo2ADN/8aNCUQYLSgvnZ347QE/CwpkmG+Z0fQd76
	NAey+qbSpv0GLcoaHMDBa05hUyAgODRUN121Q0EqJ2xVQfkkEBK2GI3E6laYE1uGkxJXhlO4gfN
	CQUAgpGmdXN7UgbYk5NuS3LSJj3gSPhywkWhIT3DTYM8qV0haLI0KQIAvNPZpBy4yg==
X-Received: by 2002:a05:600c:33a4:b0:456:18b3:df2a with SMTP id 5b1f17b1804b1-4563a51b343mr92566185e9.7.1753104047336;
        Mon, 21 Jul 2025 06:20:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOTM6ONcxT8TNzNwzNgZef2vd3Udqw06/2iLtjejzGkaQjZg1nsKTC+TtCLNdqG08YDrHFZg==
X-Received: by 2002:a05:600c:33a4:b0:456:18b3:df2a with SMTP id 5b1f17b1804b1-4563a51b343mr92565925e9.7.1753104046858;
        Mon, 21 Jul 2025 06:20:46 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca486edsm10564559f8f.56.2025.07.21.06.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:20:46 -0700 (PDT)
Message-ID: <2de814842fbbeee888e076db2f80bf2028fdbb0d.camel@redhat.com>
Subject: Re: [PATCH 4/6] rv: Remove rv_reactor's reference counter
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2025 15:20:44 +0200
In-Reply-To: <4ebe4d49e07890eadae41da233e111f8723fba12.1753091084.git.namcao@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
	 <4ebe4d49e07890eadae41da233e111f8723fba12.1753091084.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: iJ59wHO6YC-h9jEX7RauQMtbHVJz8SC7FyloqmhcYoA_1753104047
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-07-21 at 11:47 +0200, Nam Cao wrote:
> rv_reactor has a reference counter to ensure it is not removed while
> monitors are still using it.
>=20
> However, this is futile, as __exit functions are not expected to fail
> and
> will proceed normally despite rv_unregister_reactor() returning an
> error.
>=20
> At the moment, reactors do not support being built as modules,
> therefore
> they are never removed and the reference counters are not necessary.
>=20
> If we support building RV reactors as modules in the future,
> MODULE_SOFTDEP should be used instead of a custom implementation.
>=20

Mmh, I'm not understanding how, let's assume I create a custom reactor
as a kernel module and I want to use it on existing models (built in or
modules themselves), I'd do.

 insmod myreactor
 echo myreactor > mymodel/reactors
 rmmod myreactor
 ## I want this one to fail because the reactor is in use

 echo nop > mymodel/reactors
 rmmod myreactor
 # now it can succeed

How is MODULE_SOFTDEP helping in this scenario?
Am I missing something here?

Thanks,
Gabriele

> Remove this reference counter.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 2 --
> =C2=A0kernel/trace/rv/rv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 1 -
> =C2=A0kernel/trace/rv/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 6 ------
> =C2=A0kernel/trace/rv/rv_reactors.c | 33 ++------------------------------=
-
> =C2=A04 files changed, 2 insertions(+), 40 deletions(-)
>=20
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index c22c9b8c1567..2f867d6f72ba 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -91,8 +91,6 @@ struct rv_reactor {
> =C2=A0=09const char=09=09*description;
> =C2=A0=09__printf(1, 2) void=09(*react)(const char *msg, ...);
> =C2=A0=09struct list_head=09list;
> -=09/* protected by the monitor interface lock */
> -=09int=09=09=09counter;
> =C2=A0};
> =C2=A0#endif
> =C2=A0
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 6c0be2fdc52d..6c8498743b98 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -769,7 +769,6 @@ static const struct file_operations
> monitoring_on_fops =3D {
> =C2=A0
> =C2=A0static void destroy_monitor_dir(struct rv_monitor *mon)
> =C2=A0{
> -=09reactor_cleanup_monitor(mon);
> =C2=A0=09rv_remove(mon->root_d);
> =C2=A0}
> =C2=A0
> diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
> index 8c38f9dd41bc..1485a70c1bf4 100644
> --- a/kernel/trace/rv/rv.h
> +++ b/kernel/trace/rv/rv.h
> @@ -31,7 +31,6 @@ bool rv_is_nested_monitor(struct rv_monitor *mon);
> =C2=A0
> =C2=A0#ifdef CONFIG_RV_REACTORS
> =C2=A0int reactor_populate_monitor(struct rv_monitor *mon);
> -void reactor_cleanup_monitor(struct rv_monitor *mon);
> =C2=A0int init_rv_reactors(struct dentry *root_dir);
> =C2=A0#else
> =C2=A0static inline int reactor_populate_monitor(struct rv_monitor *mon)
> @@ -39,11 +38,6 @@ static inline int reactor_populate_monitor(struct
> rv_monitor *mon)
> =C2=A0=09return 0;
> =C2=A0}
> =C2=A0
> -static inline void reactor_cleanup_monitor(struct rv_monitor *mon)
> -{
> -=09return;
> -}
> -
> =C2=A0static inline int init_rv_reactors(struct dentry *root_dir)
> =C2=A0{
> =C2=A0=09return 0;
> diff --git a/kernel/trace/rv/rv_reactors.c
> b/kernel/trace/rv/rv_reactors.c
> index 2c7909e6d0e7..a8e849e6cd85 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -172,10 +172,6 @@ static void monitor_swap_reactors_single(struct
> rv_monitor *mon,
> =C2=A0=09if (monitor_enabled)
> =C2=A0=09=09rv_disable_monitor(mon);
> =C2=A0
> -=09/* swap reactor's usage */
> -=09mon->reactor->counter--;
> -=09reactor->counter++;
> -
> =C2=A0=09mon->reactor =3D reactor;
> =C2=A0=09mon->reacting =3D reacting;
> =C2=A0=09mon->react =3D reactor->react;
> @@ -343,23 +339,10 @@ int rv_register_reactor(struct rv_reactor
> *reactor)
> =C2=A0 */
> =C2=A0int rv_unregister_reactor(struct rv_reactor *reactor)
> =C2=A0{
> -=09int ret =3D 0;
> -
> =C2=A0=09mutex_lock(&rv_interface_lock);
> -
> -=09if (!reactor->counter) {
> -=09=09list_del(&reactor->list);
> -=09} else {
> -=09=09printk(KERN_WARNING
> -=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "rv: the rv_reactor %s is in =
use by %d
> monitor(s)\n",
> -=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reactor->name, reactor->count=
er);
> -=09=09printk(KERN_WARNING "rv: the rv_reactor %s cannot be
> removed\n",
> -=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reactor->name);
> -=09=09ret =3D -EBUSY;
> -=09}
> -
> +=09list_del(&reactor->list);
> =C2=A0=09mutex_unlock(&rv_interface_lock);
> -=09return ret;
> +=09return 0;
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -456,23 +439,11 @@ int reactor_populate_monitor(struct rv_monitor
> *mon)
> =C2=A0=09 * Configure as the rv_nop reactor.
> =C2=A0=09 */
> =C2=A0=09mon->reactor =3D get_reactor_rdef_by_name("nop");
> -=09mon->reactor->counter++;
> =C2=A0=09mon->reacting =3D false;
> =C2=A0
> =C2=A0=09return 0;
> =C2=A0}
> =C2=A0
> -/**
> - * reactor_cleanup_monitor - cleanup a monitor reference
> - * @mon:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the monitor.
> - */
> -void reactor_cleanup_monitor(struct rv_monitor *mon)
> -{
> -=09lockdep_assert_held(&rv_interface_lock);
> -=09mon->reactor->counter--;
> -=09WARN_ON_ONCE(mon->reactor->counter < 0);
> -}
> -
> =C2=A0/*
> =C2=A0 * Nop reactor register
> =C2=A0 */

