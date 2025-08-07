Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938397082A
	for <linux-trace-kernel@vger.kernel.org>; Thu,  7 Aug 2025 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577269; cv=none; b=VwzRxzjoJv48l6TqX2pyzx5/O5dh1aCnq6Xg7iNd7kxFKmEMayniQCTKL6EzMKjtX8Z5x/KO3W/P0vI/tUvP+bdnd9/ISLfDskwo5bzza8Aml1EohUSLi55JF7/RSf++xW7jCl9IxHjt9r77r3uqbCZV17jh1pE3IU9j4WIeM8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577269; c=relaxed/simple;
	bh=YlXDInpOjzjXgGXMUCksyHc5Fm1FlglaOGIjuJoTwbo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXoCQPl/Vc6afrKrpdEHHcFB0C0mXFQXS2ErJgRls/ZR4svid2pAWatCkh337kXkF7VgWFBDVBjhHxCr3JIrV2f2J7bkWNgGBao71DELwpGzZXoj/djBD+75QeGaFXPL50liEjhrsRc7LELH+PM6OTRpshFtNLvuHNKk4yjOeHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6xeYCyV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6xeYCyV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754577266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iVE1i9wITpiKa8wzsIRYJsZMrD+fBbEGJNKC9sVom60=;
	b=a6xeYCyVWQ6pQ3Kv/zT+W2Efn3MVTHsahnQH9YHj1mXB7D40kKzrNWTdzdi5HlBUZVwA/q
	iyP423SK221X2p0wudmvQfl/+P+lQx3pigzCwWTBZAGIwr2Ay0JciHFxf01MLeNxLXfbzP
	lW7ItD64+c9dZyduWWS8aSbyVM9PGIs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-d3iYYlSZP_KK0EsNRuqDnQ-1; Thu, 07 Aug 2025 10:34:25 -0400
X-MC-Unique: d3iYYlSZP_KK0EsNRuqDnQ-1
X-Mimecast-MFC-AGG-ID: d3iYYlSZP_KK0EsNRuqDnQ_1754577265
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b096d8fc3bso24393271cf.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 07 Aug 2025 07:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754577265; x=1755182065;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8JhdPbjaG7LJYzZIp+ylPJV8hHjzRxow/loSvjwY9k=;
        b=vIxz6t2UlkgGK3gYPiyKixDK2sfCBhuL9MOKGCVcRQVkz0FcSAwjNMZ6tn+Mj4Cqv2
         QtUZVrnYFAQz9O7z9dRBA4ne8oyCPijCZWyZ8kO76qZAWw/gkfA3HcHboNRpojfwCg+Q
         t46MKSLE/7163toqJ0Rztl88xXNVEJehXMqUV/GNJqvCbWbwdl2FAE4aXpyVPn0ttrfO
         IxZuCZo5LtGaFsjW2ghSghWiChprK57gAFiHid6bQxxvtq4J51BiuE8oV+BTo761wTKU
         Y0v87JM6FVVpr9igfW2rTNlGk6B2LG3hGiAM+E/o35N8yhX111SK3NbsusNehhHqT+AT
         QeyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+auU9kqD4Yfu4GoURz1tFxCF2fJIGaAoZz5jzidDcXgqXKeAVzO6GWfqASWkXbtzLPTMbLfXPHbHecbQ+7azsnaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjDUmT+GI474juYBW06EJ4Tfu7J+eF4MOSjVK2SbYu8GaZpFW4
	I0V+tO7pwrHpBHjbPRhw0Jk9IvoSZuun03qnPAx3YOhyFiDPz/NqMKK/xwQDcNiLzqOJzp4kRKq
	7rkzmmQqMM7I+BW8us8UXuthizrQZQ6xW0sZaTnCK5D3ikEL4fmxC20CzwW84TB5JcZp2pyDhuQ
	==
X-Gm-Gg: ASbGncvmqXqDpUg30U5x9YoMVbmyBbLgY5WMaoRkWoqwfWuRAZV/H4UYJrMMzIXW1aQ
	ZcGxr6TcfXRGb+hixzQU8RCPd9IHybpJGsAoea07R1AXFNc2WTWyk3MxIvQb2RkJP+HVrnNHs0m
	Do5lN13Y5JI6LyRM+fP+Qm+CvuOA/sMSehJexpvZf7ZC74mfyuJQ+eT3taVPhZG699oh9NlbsFc
	hPIm9RVyGVIusaP7rJ2AAv6Xq4dmPItjat+tOl+mkeHzc4ZQESupUXXLpWym+PL+BeysiBr8SoD
	NTZaBLHqD93QsEz2NGrhwqfcDFiMi4xpS0r/teYiTGpVWQkIfBmfTMeD5ed5iIevww==
X-Received: by 2002:a05:622a:2b49:b0:4af:3b7:7011 with SMTP id d75a77b69052e-4b091557f51mr103085611cf.35.1754577264730;
        Thu, 07 Aug 2025 07:34:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeQaz8gvnURliGGeO14IZFbkhaXotOsQNsr+/7ky7JlqogY8m9QAQ1+9NYNz4DpwDy16cgZg==
X-Received: by 2002:a05:622a:2b49:b0:4af:3b7:7011 with SMTP id d75a77b69052e-4b091557f51mr103084901cf.35.1754577264158;
        Thu, 07 Aug 2025 07:34:24 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e81237b2e2sm319451385a.72.2025.08.07.07.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 07:34:23 -0700 (PDT)
Message-ID: <ecd720a0b971658a915473f0f864668cd6e1ef1a.camel@redhat.com>
Subject: Re: [PATCH v2 5/5] rv: Add rts monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann	 <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman	 <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, K Prateek Nayak	 <kprateek.nayak@amd.com>
Date: Thu, 07 Aug 2025 16:34:19 +0200
In-Reply-To: <88fdbeb3f2ecf3a6259f3ee8636ae5b21fa6b72d.1754466623.git.namcao@linutronix.de>
References: <cover.1754466623.git.namcao@linutronix.de>
	 <88fdbeb3f2ecf3a6259f3ee8636ae5b21fa6b72d.1754466623.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: p5BXJS_OEN0RPMhd64_D3iCvaglwizFizvGrfVXmkRM_1754577265
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-08-06 at 10:01 +0200, Nam Cao wrote:
> Add "real-time scheduling" monitor, which validates that SCHED_RR and
> SCHED_FIFO tasks are scheduled before tasks with normal and
> extensible scheduling policies
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---

The monitor shows a violation also in case of priority inversion
boosting, e.g.:

 stress-ng --prio-inv 2

It seems perfectly reasonable from the monitor description but it's
actually a behaviour meant to improve real time response.
Is the user seeing this type of violation supposed to make sure all
locks held by RT tasks are never shared by fair tasks? If that's the
case I'd mention it in the description.


Also very rarely I see failures while cleaning up the monitor, not sure
exactly what caused it but I could reproduce it with something like:

  for i in $(seq 100); do timeout -s INT 2 rv mon rts -r printk; done

Running the monitor without stopping for the same amount of time
doesn't seem to show violations (until I terminate it).

"rv" here is the tool under tools/verifications/rv, also the rv package
on fedora works, but debian/ubuntu may still be shipping an outdated
version, if they ship one at all.

Thanks,
Gabriele

> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> v2:
> =C2=A0 - use the new tracepoints
> =C2=A0 - move to be under the rtapp container monitor
> =C2=A0 - re-generate with the modified scripts
> =C2=A0 - fixup incorrect enqueued status
> ---
> =C2=A0Documentation/trace/rv/monitor_sched.rst |=C2=A0 19 +++
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
1 +
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0kernel/trace/rv/monitors/rts/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 17 +++
> =C2=A0kernel/trace/rv/monitors/rts/rts.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 144
> +++++++++++++++++++++++
> =C2=A0kernel/trace/rv/monitors/rts/rts.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 126 ++++++++++++++++++++
> =C2=A0kernel/trace/rv/monitors/rts/rts_trace.h |=C2=A0 15 +++
> =C2=A0kernel/trace/rv/rv_trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0tools/verification/models/sched/rts.ltl=C2=A0 |=C2=A0=C2=A0 5 +
> =C2=A09 files changed, 329 insertions(+)
> =C2=A0create mode 100644 kernel/trace/rv/monitors/rts/Kconfig
> =C2=A0create mode 100644 kernel/trace/rv/monitors/rts/rts.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/rts/rts.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/rts/rts_trace.h
> =C2=A0create mode 100644 tools/verification/models/sched/rts.ltl
>=20
> diff --git a/Documentation/trace/rv/monitor_sched.rst
> b/Documentation/trace/rv/monitor_sched.rst
> index 3f8381ad9ec7..2f9d62a1af1f 100644
> --- a/Documentation/trace/rv/monitor_sched.rst
> +++ b/Documentation/trace/rv/monitor_sched.rst
> @@ -396,6 +396,25 @@ preemption is always disabled. On non-
> ``PREEMPT_RT`` kernels, the interrupts
> =C2=A0might invoke a softirq to set ``need_resched`` and wake up a task.
> This is
> =C2=A0another special case that is currently not supported by the monitor=
.
> =C2=A0
> +Monitor rts
> +-----------
> +
> +The real-time scheduling monitor validates that tasks with real-time
> scheduling
> +policies (`SCHED_FIFO` and `SCHED_RR`) are always scheduled before
> tasks with
> +normal and extensible scheduling policies (`SCHED_OTHER`,
> `SCHED_BATCH`,
> +`SCHED_IDLE`, `SCHED_EXT`):
> +
> +.. literalinclude:: ../../../tools/verification/models/sched/rts.ltl
> +
> +Note that this monitor may report errors if real-time throttling or
> fair
> +deadline server is enabled. These mechanisms prevent real-time tasks
> from
> +monopolying the CPU by giving tasks with normal and extensible
> scheduling
> +policies a chance to run. They give system administrators a chance
> to kill a
> +misbehaved real-time task. However, they violate the scheduling
> priorities and
> +may cause latency to well-behaved real-time tasks. Thus, if you see
> errors from
> +this monitor, consider disabling real-time throttling and the fair
> deadline
> +server.
> +
> =C2=A0References
> =C2=A0----------
> =C2=A0
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 7ef89006ed50..e9007ed32aea 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -67,6 +67,7 @@ source "kernel/trace/rv/monitors/opid/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/rtapp/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/pagefault/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/sleep/Kconfig"
> +source "kernel/trace/rv/monitors/rts/Kconfig"
> =C2=A0# Add new rtapp monitors here
> =C2=A0
> =C2=A0# Add new monitors here
> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index 750e4ad6fa0f..d7bfc7ae6677 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_RV_MON_STS) +=3D monitors/sts/sts.o
> =C2=A0obj-$(CONFIG_RV_MON_NRP) +=3D monitors/nrp/nrp.o
> =C2=A0obj-$(CONFIG_RV_MON_SSSW) +=3D monitors/sssw/sssw.o
> =C2=A0obj-$(CONFIG_RV_MON_OPID) +=3D monitors/opid/opid.o
> +obj-$(CONFIG_RV_MON_RTS) +=3D monitors/rts/rts.o
> =C2=A0# Add new monitors here
> =C2=A0obj-$(CONFIG_RV_REACTORS) +=3D rv_reactors.o
> =C2=A0obj-$(CONFIG_RV_REACT_PRINTK) +=3D reactor_printk.o
> diff --git a/kernel/trace/rv/monitors/rts/Kconfig
> b/kernel/trace/rv/monitors/rts/Kconfig
> new file mode 100644
> index 000000000000..5481b371bce1
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rts/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +config RV_MON_RTS
> +=09depends on RV
> +=09select RV_LTL_MONITOR
> +=09depends on RV_MON_RTAPP
> +=09default y
> +=09select LTL_MON_EVENTS_CPU
> +=09bool "rts monitor"
> +=09help
> +=09=C2=A0 Add support for RTS (real-time scheduling) monitor which
> validates
> +=09=C2=A0 that real-time-priority tasks are scheduled before
> SCHED_OTHER tasks.
> +
> +=09=C2=A0 This monitor may report an error if RT throttling or
> deadline server
> +=09=C2=A0 is enabled.
> +
> +=09=C2=A0 Say Y if you are debugging or testing a real-time system.
> diff --git a/kernel/trace/rv/monitors/rts/rts.c
> b/kernel/trace/rv/monitors/rts/rts.c
> new file mode 100644
> index 000000000000..b4c3d3a4671d
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rts/rts.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/ftrace.h>
> +#include <linux/tracepoint.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/rv.h>
> +#include <linux/sched/deadline.h>
> +#include <linux/sched/rt.h>
> +#include <rv/instrumentation.h>
> +
> +#define MODULE_NAME "rts"
> +
> +#include <trace/events/sched.h>
> +#include <rv_trace.h>
> +#include <monitors/rtapp/rtapp.h>
> +
> +#include "rts.h"
> +#include <rv/ltl_monitor.h>
> +
> +static DEFINE_PER_CPU(unsigned int, nr_queued);
> +
> +static void ltl_atoms_fetch(unsigned int cpu, struct ltl_monitor
> *mon)
> +{
> +}
> +
> +static void ltl_atoms_init(unsigned int cpu, struct ltl_monitor
> *mon,
> +=09=09=09=C2=A0=C2=A0 bool target_creation)
> +{
> +=09ltl_atom_set(mon, LTL_SCHED_SWITCH, false);
> +=09ltl_atom_set(mon, LTL_SCHED_SWITCH_DL, false);
> +=09ltl_atom_set(mon, LTL_SCHED_SWITCH_RT, false);
> +
> +=09/*
> +=09 * This may not be accurate, there may be enqueued RT tasks.
> But that's
> +=09 * okay, the worst we get is a false negative. It will be
> accurate as
> +=09 * soon as the CPU no longer has any queued RT task.
> +=09 */
> +=09ltl_atom_set(mon, LTL_RT_TASK_ENQUEUED, false);
> +}
> +
> +static void handle_enqueue_task(void *data, int cpu, struct
> task_struct *task)
> +{
> +=09unsigned int *queued =3D per_cpu_ptr(&nr_queued, cpu);
> +
> +=09if (!rt_task(task))
> +=09=09return;
> +
> +=09(*queued)++;
> +=09ltl_atom_update(cpu, LTL_RT_TASK_ENQUEUED, true);
> +}
> +
> +static void handle_dequeue_task(void *data, int cpu, struct
> task_struct *task)
> +{
> +=09unsigned int *queued =3D per_cpu_ptr(&nr_queued, cpu);
> +
> +=09if (!rt_task(task))
> +=09=09return;
> +
> +=09/*
> +=09 * This may not be accurate for a short time after the
> monitor is
> +=09 * enabled, because there may be enqueued RT tasks which are
> not counted
> +=09 * torward nr_queued. But that's okay, the worst we get is a
> false
> +=09 * negative. nr_queued will be accurate as soon as the CPU
> no longer has
> +=09 * any queued RT task.
> +=09 */
> +=09if (*queued)
> +=09=09(*queued)--;
> +=09if (!*queued)
> +=09=09ltl_atom_update(cpu, LTL_RT_TASK_ENQUEUED, false);
> +}
> +
> +static void handle_sched_switch(void *data, bool preempt, struct
> task_struct *prev,
> +=09=09=09=09struct task_struct *next, unsigned
> int prev_state)
> +{
> +=09unsigned int cpu =3D smp_processor_id();
> +=09struct ltl_monitor *mon =3D ltl_get_monitor(cpu);
> +
> +=09ltl_atom_set(mon, LTL_SCHED_SWITCH_RT, rt_task(next));
> +=09ltl_atom_set(mon, LTL_SCHED_SWITCH_DL, dl_task(next));
> +=09ltl_atom_update(cpu, LTL_SCHED_SWITCH, true);
> +
> +=09ltl_atom_set(mon, LTL_SCHED_SWITCH_RT, false);
> +=09ltl_atom_set(mon, LTL_SCHED_SWITCH_DL, false);
> +=09ltl_atom_update(cpu, LTL_SCHED_SWITCH, false);
> +}
> +
> +static int enable_rts(void)
> +{
> +=09unsigned int cpu;
> +=09int retval;
> +
> +=09retval =3D ltl_monitor_init();
> +=09if (retval)
> +=09=09return retval;
> +
> +=09for_each_possible_cpu(cpu) {
> +=09=09unsigned int *queued =3D per_cpu_ptr(&nr_queued, cpu);
> +
> +=09=09*queued =3D 0;
> +=09}
> +
> +=09rv_attach_trace_probe("rts", dequeue_task_tp,
> handle_dequeue_task);
> +=09rv_attach_trace_probe("rts", enqueue_task_tp,
> handle_enqueue_task);
> +=09rv_attach_trace_probe("rts", sched_switch,
> handle_sched_switch);
> +
> +=09return 0;
> +}
> +
> +static void disable_rts(void)
> +{
> +=09rv_detach_trace_probe("rts", sched_switch,
> handle_sched_switch);
> +=09rv_detach_trace_probe("rts", enqueue_task_tp,
> handle_enqueue_task);
> +=09rv_detach_trace_probe("rts", dequeue_task_tp,
> handle_dequeue_task);
> +
> +=09ltl_monitor_destroy();
> +}
> +
> +/*
> + * This is the monitor register section.
> + */
> +static struct rv_monitor rv_rts =3D {
> +=09.name =3D "rts",
> +=09.description =3D "Validate that real-time tasks are scheduled
> before lower-priority tasks",
> +=09.enable =3D enable_rts,
> +=09.disable =3D disable_rts,
> +};
> +
> +static int __init register_rts(void)
> +{
> +=09return rv_register_monitor(&rv_rts, &rv_rtapp);
> +}
> +
> +static void __exit unregister_rts(void)
> +{
> +=09rv_unregister_monitor(&rv_rts);
> +}
> +
> +module_init(register_rts);
> +module_exit(unregister_rts);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
> +MODULE_DESCRIPTION("rts: Validate that real-time tasks are scheduled
> before lower-priority tasks");
> diff --git a/kernel/trace/rv/monitors/rts/rts.h
> b/kernel/trace/rv/monitors/rts/rts.h
> new file mode 100644
> index 000000000000..5881f30a38ce
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rts/rts.h
> @@ -0,0 +1,126 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * C implementation of Buchi automaton, automatically generated by
> + * tools/verification/rvgen from the linear temporal logic
> specification.
> + * For further information, see kernel documentation:
> + *=C2=A0=C2=A0 Documentation/trace/rv/linear_temporal_logic.rst
> + */
> +
> +#include <linux/rv.h>
> +
> +#define MONITOR_NAME rts
> +
> +#define LTL_MONITOR_TYPE RV_MON_PER_CPU
> +
> +enum ltl_atom {
> +=09LTL_RT_TASK_ENQUEUED,
> +=09LTL_SCHED_SWITCH,
> +=09LTL_SCHED_SWITCH_DL,
> +=09LTL_SCHED_SWITCH_RT,
> +=09LTL_NUM_ATOM
> +};
> +static_assert(LTL_NUM_ATOM <=3D RV_MAX_LTL_ATOM);
> +
> +static const char *ltl_atom_str(enum ltl_atom atom)
> +{
> +=09static const char *const names[] =3D {
> +=09=09"rt_ta_en",
> +=09=09"sc_sw",
> +=09=09"sc_sw_dl",
> +=09=09"sc_sw_rt",
> +=09};
> +
> +=09return names[atom];
> +}
> +
> +enum ltl_buchi_state {
> +=09S0,
> +=09S1,
> +=09S2,
> +=09S3,
> +=09S4,
> +=09RV_NUM_BA_STATES
> +};
> +static_assert(RV_NUM_BA_STATES <=3D RV_MAX_BA_STATES);
> +
> +static void ltl_start(unsigned int cpu, struct ltl_monitor *mon)
> +{
> +=09bool sched_switch_rt =3D test_bit(LTL_SCHED_SWITCH_RT, mon-
> >atoms);
> +=09bool sched_switch_dl =3D test_bit(LTL_SCHED_SWITCH_DL, mon-
> >atoms);
> +=09bool sched_switch =3D test_bit(LTL_SCHED_SWITCH, mon->atoms);
> +=09bool rt_task_enqueued =3D test_bit(LTL_RT_TASK_ENQUEUED, mon-
> >atoms);
> +=09bool val13 =3D !rt_task_enqueued;
> +=09bool val8 =3D sched_switch_dl || val13;
> +=09bool val9 =3D sched_switch_rt || val8;
> +=09bool val6 =3D !sched_switch;
> +=09bool val1 =3D !rt_task_enqueued;
> +
> +=09if (val1)
> +=09=09__set_bit(S0, mon->states);
> +=09if (val6)
> +=09=09__set_bit(S1, mon->states);
> +=09if (val9)
> +=09=09__set_bit(S4, mon->states);
> +}
> +
> +static void
> +ltl_possible_next_states(struct ltl_monitor *mon, unsigned int
> state, unsigned long *next)
> +{
> +=09bool sched_switch_rt =3D test_bit(LTL_SCHED_SWITCH_RT, mon-
> >atoms);
> +=09bool sched_switch_dl =3D test_bit(LTL_SCHED_SWITCH_DL, mon-
> >atoms);
> +=09bool sched_switch =3D test_bit(LTL_SCHED_SWITCH, mon->atoms);
> +=09bool rt_task_enqueued =3D test_bit(LTL_RT_TASK_ENQUEUED, mon-
> >atoms);
> +=09bool val13 =3D !rt_task_enqueued;
> +=09bool val8 =3D sched_switch_dl || val13;
> +=09bool val9 =3D sched_switch_rt || val8;
> +=09bool val6 =3D !sched_switch;
> +=09bool val1 =3D !rt_task_enqueued;
> +
> +=09switch (state) {
> +=09case S0:
> +=09=09if (val1)
> +=09=09=09__set_bit(S0, next);
> +=09=09if (val6)
> +=09=09=09__set_bit(S1, next);
> +=09=09if (val9)
> +=09=09=09__set_bit(S4, next);
> +=09=09break;
> +=09case S1:
> +=09=09if (val6)
> +=09=09=09__set_bit(S1, next);
> +=09=09if (val1 && val6)
> +=09=09=09__set_bit(S2, next);
> +=09=09if (val1 && val9)
> +=09=09=09__set_bit(S3, next);
> +=09=09if (val9)
> +=09=09=09__set_bit(S4, next);
> +=09=09break;
> +=09case S2:
> +=09=09if (val6)
> +=09=09=09__set_bit(S1, next);
> +=09=09if (val1 && val6)
> +=09=09=09__set_bit(S2, next);
> +=09=09if (val1 && val9)
> +=09=09=09__set_bit(S3, next);
> +=09=09if (val9)
> +=09=09=09__set_bit(S4, next);
> +=09=09break;
> +=09case S3:
> +=09=09if (val1)
> +=09=09=09__set_bit(S0, next);
> +=09=09if (val6)
> +=09=09=09__set_bit(S1, next);
> +=09=09if (val9)
> +=09=09=09__set_bit(S4, next);
> +=09=09break;
> +=09case S4:
> +=09=09if (val1)
> +=09=09=09__set_bit(S0, next);
> +=09=09if (val6)
> +=09=09=09__set_bit(S1, next);
> +=09=09if (val9)
> +=09=09=09__set_bit(S4, next);
> +=09=09break;
> +=09}
> +}
> diff --git a/kernel/trace/rv/monitors/rts/rts_trace.h
> b/kernel/trace/rv/monitors/rts/rts_trace.h
> new file mode 100644
> index 000000000000..ac4ea84162f7
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rts/rts_trace.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Snippet to be included in rv_trace.h
> + */
> +
> +#ifdef CONFIG_RV_MON_RTS
> +DEFINE_EVENT(event_ltl_monitor_cpu, event_rts,
> +=09TP_PROTO(unsigned int cpu, char *states, char *atoms, char
> *next),
> +=09TP_ARGS(cpu, states, atoms, next));
> +
> +DEFINE_EVENT(error_ltl_monitor_cpu, error_rts,
> +=09TP_PROTO(unsigned int cpu),
> +=09TP_ARGS(cpu));
> +#endif /* CONFIG_RV_MON_RTS */
> diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
> index bf7cca6579ec..7b3a6fb8ca6f 100644
> --- a/kernel/trace/rv/rv_trace.h
> +++ b/kernel/trace/rv/rv_trace.h
> @@ -221,6 +221,7 @@ DECLARE_EVENT_CLASS(error_ltl_monitor_cpu,
> =C2=A0
> =C2=A0=09TP_printk("cpu%u: violation detected", __entry->cpu)
> =C2=A0);
> +#include <monitors/rts/rts_trace.h>
> =C2=A0// Add new monitors based on CONFIG_LTL_MON_EVENTS_CPU here
> =C2=A0
> =C2=A0#endif /* CONFIG_LTL_MON_EVENTS_CPU */
> diff --git a/tools/verification/models/sched/rts.ltl
> b/tools/verification/models/sched/rts.ltl
> new file mode 100644
> index 000000000000..90872bca46b1
> --- /dev/null
> +++ b/tools/verification/models/sched/rts.ltl
> @@ -0,0 +1,5 @@
> +RULE =3D always (RT_TASK_ENQUEUED imply SCHEDULE_RT_NEXT)
> +
> +SCHEDULE_RT_NEXT =3D (not SCHED_SWITCH) until (SCHED_SWITCH_RT or
> EXCEPTIONS)
> +
> +EXCEPTIONS =3D SCHED_SWITCH_DL or not RT_TASK_ENQUEUED

