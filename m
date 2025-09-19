Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F5131062E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284780; cv=none; b=W3PHikXcJpSS8WvO3HHeN64RymqUPYTAMpecRdwWHKXh9ANRS+brHJtH2/7LEUIYxC9rKxwPGcmLZ8LdG3uaA0Sk9jEK3/rRsq4lSEu5yYF6XpFCrMofEsNP/4D1KLa482X/A5B+q1h7fI6rcDGyqFVNlLiveppNMRkizOSEHTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284780; c=relaxed/simple;
	bh=d1sX/D+DcalmI4LfSMAzkuteep4cIgZVtw5NAwASs6I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzUSOKbOa28kMyX0gaeEu3EBdV3y2O6xhlmHUMpdrMp2Zj+eHBDlip61HJ2K2ri27IuvxAsOFB+mCuryAmG6wzctfRq+ZzgCEqmNRa8fZMdV+DVplAtsVnSvbbFNN6mEB94pyKWxKEW0KxvJuqsvY+ZJFBU69P+sq+nyu0Uga18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hU7sMltQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hU7sMltQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758284778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d1sX/D+DcalmI4LfSMAzkuteep4cIgZVtw5NAwASs6I=;
	b=hU7sMltQYbWACjRS+h/V8Cv5nBHSt6jstfXUEmttqyE1gAlI5wpieJrT/oZwNHPRnC7Qj3
	T/tXRxgU6WyWPjHgIgoFabajFLGTQmjgzmIgr4dne3KXBgXJVGx9kRuKlQhdW+blF3lAqM
	VacoJewqR7CW9JeC7Yn3EaOdnr6aA7Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-a7nz0AQoP32uhcUqhQqZCA-1; Fri, 19 Sep 2025 08:26:16 -0400
X-MC-Unique: a7nz0AQoP32uhcUqhQqZCA-1
X-Mimecast-MFC-AGG-ID: a7nz0AQoP32uhcUqhQqZCA_1758284776
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45f2b9b958aso20240535e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Sep 2025 05:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758284776; x=1758889576;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2XSBYp5h1Vr225E++TG9Fqb3LLvB175rci2oqHmbHw=;
        b=n6jrxijto/i4AbLFiHieuLWRbi0pyu0tc0uH5s2vOeNR+E9Dvs220dZoaKDPtS50lA
         OW9h6nNnsPEwe6djSn9PErEIIgh4aUxH9UK46nbiDBRzIf9EHn1Q4C4mfy29W51aVQAA
         6/VCoPHr+WDZclPEX2AAPxnOlvtYQBLsmYSd3dPqlrqlgmtB8dRR/Y53Kg+tIDjQuiD/
         XB9a8FO7yhKc7B0shK+7mJh8d8KirK27X3M9kNQWs4P9djyM9uTolQbIMOdZdJ5YkAk1
         CtLEkkP4d9wd9eOZdsmhknh4j7szf6DlY9zi1YuWW9qOvGZRBBFQjjbzoelY7Zpfw9eQ
         YurA==
X-Forwarded-Encrypted: i=1; AJvYcCWQtEc8A6LR0Yq3/DU84u24Pm44CLOwKLUp4ADRqy2Xn+3z4ifjZqjJhWpptCYBtMmOrjw5lvbkuZ/inPcTHvvJrSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMYMLR8ba6+jqGnp0Qxg/scMxQ+nH5CGY+/s1c8oxaBnuHvB3U
	TPInFmm8mkycpe14WMA50ElQ7S7orItG19/GeqEC5thzpZFNjdmh6ZjRyDZbMzeFx/0a7tu+ySm
	tfXEvYNJ5FIIJNBSO9sOgVTOAtafHiJS+okMwwxlU/QpREbk5jCK2zouU+TBL/I6y/hvJVd9ifg
	==
X-Gm-Gg: ASbGnct/XBkNEjs7OXnBBfvZc8GWBIWhuqM02jMvRac2jpKr3i9fRJ5ekqziSdX/Wop
	7odY5zrthxT+Pgv8vbFzIP4QuW/7VKf4iuWq56Rxy4fuiUA5JE1Uqem5cA8853myDEAgliN47YA
	CIpHnAPrB3Buc5TwAJS21b9oZT1YMYGwkJiYnao0nzPy85xEYBrntLmx43RFHvmGPM8URZlwQ4t
	eetZ25VkLfpN/EnBookryODy2EmUvzb3xzcsjiGQQSvSMWgpsSVLs67SvmfgVE0+N2s0QU4UloG
	gyiAsYwLoZG5bY1OsywuhpYXe+k+nSjI6LgTLKNs6Wne1EG+RbCOLw/5+8xSE41XVTFS
X-Received: by 2002:a05:600c:45c9:b0:45d:d1a3:ba6a with SMTP id 5b1f17b1804b1-467f15d405emr26612485e9.33.1758284775634;
        Fri, 19 Sep 2025 05:26:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExVo5Bm/Gvq4znkAjNfJnMZLgqKOOOnEVHm6N4TjEKj5ArkEr2zku7wSBIOGTxDiXnA/4U1w==
X-Received: by 2002:a05:600c:45c9:b0:45d:d1a3:ba6a with SMTP id 5b1f17b1804b1-467f15d405emr26612175e9.33.1758284775117;
        Fri, 19 Sep 2025 05:26:15 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.132.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613d14d212sm141809075e9.12.2025.09.19.05.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 05:26:14 -0700 (PDT)
Message-ID: <d0aaaf1f47f0d948b60b0575e179564e3c024188.camel@redhat.com>
Subject: Re: [PATCH] rv: Add signal reactor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers	 <mathieu.desnoyers@efficios.com>
Date: Fri, 19 Sep 2025 14:26:12 +0200
In-Reply-To: <20250919-rv-reactor-signal-v1-1-fb0012034158@linutronix.de>
References: <20250919-rv-reactor-signal-v1-1-fb0012034158@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: j9PBJwzhJgpvjRJRPNyF2eE3nTlmX4QE8NXJ5-qBHGw_1758284776
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-09-19 at 12:49 +0200, Thomas Wei=C3=9Fschuh wrote:
> Reactions of the existing reactors are not easily detectable from program=
s
> and also not easily attributable to the triggering task.
> This makes it hard to test the monitors themselves programmatically.
>=20
> The signal reactors allows applications to validate the correct operation=
s
> of monitors either by installing custom signal handlers or by forking a
> child and waiting for the expected exit code.

Thanks, this looks like a really nice addition!

> For now only SIGBUS is supported, but additional signals can be added.

Curious choice of a default signal, is this specific to your use-case?

We may want to add some kind of reactors options in the future to allow
configuring this, but I'd say it isn't needed for now.

> As the reactors are called from tracepoints they need to be able to run i=
n
> any context. To avoid taking any of the looks used during signal delivery

You probably meant "locks"

> from an invalid context, schedule it through task_work. The delivery will
> be delayed, for example when then sleep monitor detects an invalid sleep.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +++
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0kernel/trace/rv/reactor_signal.c | 114
> +++++++++++++++++++++++++++++++++++++++
> =C2=A03 files changed, 123 insertions(+)
>=20
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index
> 5b4be87ba59d3fa5123a64efa746320c9e8b73b1..dc7b546615a67c811ce94c43bb1db28=
26cd0
> 0c77 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -93,3 +93,11 @@ config RV_REACT_PANIC
> =C2=A0=09help
> =C2=A0=09=C2=A0 Enables the panic reactor. The panic reactor emits a prin=
tk()
> =C2=A0=09=C2=A0 message if an exception is found and panic()s the system.
> +
> +config RV_REACT_SIGNAL
> +=09bool "Signal reactor"
> +=09depends on RV_REACTORS
> +=09default y
> +=09help
> +=09=C2=A0 Enables the signal reactor. The signal reactors sends a signal=
 to
> the
> +=09=C2=A0 task triggering an exception.

This assumption is not always correct, imagine a failure in the sleep monit=
or
caused by the wakeup event. The offending task is not current but the wakee=
.

This is a bit tricky because reactors don't have access to that task, just =
to
keep the same implementation between per-cpu and per-task monitors.

We may want to revise that, perhaps like Nam is doing with the monitor_targ=
et
thing [1].

Besides, I'm assuming this reactor is only meaningful for monitors written =
to
validate userspace tasks (signals and TWA_RESUME are probably
meaningless/dangerous for kernel threads).

I'm fine with that but you should probably mention it here and/or in the re=
actor
itself, since we have also monitors validating kernel behaviour (see the sc=
hed
collection).

[1] -
https://lore.kernel.org/lkml/9a1b5a8c449fcb4f1a671016389c1e4fca49a351.17549=
00299.git.namcao@linutronix.de

> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index
> 42ff5d5aa9dde3ed2964e0b8d4ab7b236f498319..adf56bbd03ffa0d48de1f0d86ca5fcc=
e1628
> bdba 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -23,3 +23,4 @@ obj-$(CONFIG_RV_MON_OPID) +=3D monitors/opid/opid.o
> =C2=A0obj-$(CONFIG_RV_REACTORS) +=3D rv_reactors.o
> =C2=A0obj-$(CONFIG_RV_REACT_PRINTK) +=3D reactor_printk.o
> =C2=A0obj-$(CONFIG_RV_REACT_PANIC) +=3D reactor_panic.o
> +obj-$(CONFIG_RV_REACT_SIGNAL) +=3D reactor_signal.o
> diff --git a/kernel/trace/rv/reactor_signal.c
> b/kernel/trace/rv/reactor_signal.c
> new file mode 100644
> index
> 0000000000000000000000000000000000000000..e123786d94371a240beb63b2d1b2f30=
44a46
> 6404
> --- /dev/null
> +++ b/kernel/trace/rv/reactor_signal.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Thomas Wei=C3=9Fschuh, Linutronix GmbH
> + *
> + * Signal RV reactor:
> + *=C2=A0=C2=A0 Prints the exception msg to the kernel message log and se=
nds a signal to
> the offending task.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/cpumask.h>
> +#include <linux/init.h>
> +#include <linux/mempool.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/rv.h>
> +#include <linux/sched/signal.h>
> +#include <linux/task_work.h>
> +
> +struct rv_signal_work {
> +=09struct callback_head twork;
> +=09int signal;
> +=09char message[256];
> +};
> +
> +static mempool_t *rv_signal_task_work_pool;
> +
> +static void rv_signal_force_sig(int signal, const char *message)
> +{
> +=09/* The message already contains a subsystem prefix, so use raw
> printk() */
> +=09printk(KERN_WARNING "%s", message);
> +=09pr_warn("Killing PID %d with signal %d", task_pid_nr(current),
> signal);
> +=09force_sig(signal);
> +}
> +
> +static void rv_signal_task_work(struct callback_head *cbh)
> +{
> +=09struct rv_signal_work *work =3D container_of_const(cbh, struct
> rv_signal_work, twork);
> +
> +=09rv_signal_force_sig(work->signal, work->message);
> +
> +=09mempool_free(work, rv_signal_task_work_pool);
> +}
> +
> +static void rv_reaction_signal(int signal, const char *fmt, va_list args=
)
> +{
> +=09struct rv_signal_work *work;
> +=09char message[256];
> +
> +=09work =3D mempool_alloc_preallocated(rv_signal_task_work_pool);
> +=09if (!work) {
> +=09=09pr_warn_ratelimited("Unable to signal through task_work,
> sending directly\n");
> +=09=09vsnprintf(message, sizeof(message), fmt, args);
> +=09=09rv_signal_force_sig(signal, message);
> +=09=09return;
> +=09}

Why do you use the task_work at all instead of signalling directly?
If that's something not safe from a (any) tracepoint because it can sleep y=
ou
should definitely not call it if allocation fails.

> +
> +=09init_task_work(&work->twork, rv_signal_task_work);
> +=09work->signal =3D signal;
> +=09vsnprintf(work->message, sizeof(work->message), fmt, args);
> +
> +=09/*
> +=09 * The reactor can be called from any context through tracepoints.
> +=09 * To avoid any locking or other operations not usable from all
> contexts, use TWA_RESUME.
> +=09 * The signal might be delayed, but that shouldn't be an issue.
> +=09 */
> +=09task_work_add(current, &work->twork, TWA_RESUME);
> +}
> +
> +__printf(1, 2)
> +static void rv_reaction_sigbus(const char *fmt, ...)
> +{
> +=09va_list args;
> +
> +=09va_start(args, fmt);
> +=09rv_reaction_signal(SIGBUS, fmt, args);
> +=09va_end(args);
> +}
> +
> +static struct rv_reactor rv_sigbus =3D {
> +=09.name=09=09=3D "sigbus",
> +=09.description=09=3D "Kill the current task with SIGBUS",
> +=09.react=09=09=3D rv_reaction_sigbus,
> +};

Let's be consistent and call this reactor "signal", you can use SIGBUS only=
 in
the description until/if we allow different signals.

What do you think?

Thanks,
Gabriele

