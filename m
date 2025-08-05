Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9D422F767
	for <linux-trace-kernel@vger.kernel.org>; Tue,  5 Aug 2025 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383241; cv=none; b=ixcPF7v8xWG5yhMe3MHdag1Pvrf89XLDtX/eDQfdJUKRjm2FmWReRXsNZY9fFDA2hXT6Stk9TqyoTg+mPCdtD6OrxjnmAmWC8LJS/wi4ulvIytDJHkqd1J1Wk1HZ+XaqJymA2xmfZ/ecpgkHAYZr18EsOiCIngwGUFPbHMJgxHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383241; c=relaxed/simple;
	bh=62umD/PrW0j/L0i9CI/BO1CmA007cMeuCo+O/prnR0E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEE1XOW1luIjk2v/toZm/Ar2/Ag5a4lk1KbLc75VUeWNfmjF3ev6nxoL1nLRH9+q6Kpt4wxwSofJFd0eC1BaV8R+jn0ECML05OwgjwvKfEXmDbrv66mUAdthfdhynKvJATh7zWaHx1FXie53gVdwS6/UUBEo17OfMV8eQmJ8ntw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAhO0lMj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAhO0lMj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754383235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=62umD/PrW0j/L0i9CI/BO1CmA007cMeuCo+O/prnR0E=;
	b=FAhO0lMj31xlEQ/LaphbcH5w0DGizB62pFJz0rDGNWzsYfS1GlPvfAY9XkOmZtt3Xmi2gq
	NiZrFIw4v5dQtH7Oyhf7qrG8aFMDvvlAYKXclWC4hC2/UZQ2Ru1Q5xQjJfgmxOtT+Zgaf/
	t++glUwnJB1hTM/ktzFkmuqwADsqabs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-jYBtrz48NdWwjHhstkLRUw-1; Tue, 05 Aug 2025 04:40:34 -0400
X-MC-Unique: jYBtrz48NdWwjHhstkLRUw-1
X-Mimecast-MFC-AGG-ID: jYBtrz48NdWwjHhstkLRUw_1754383233
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-459e30e4477so2241545e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 05 Aug 2025 01:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754383233; x=1754988033;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+IC70/RTqTB2gnQ0vbDz5H3dkDco044aKQEBYM9Czs=;
        b=R4LAff2KrTkZMfoDGXqhCBmASrouajpnYN+QVf0alF8wFOs/F7jETc5ET9rC5t7a1l
         /U8jPArt6L3tj+v7Jl4oat9R5q/Ao+gTsaDRnDy5UCrdIuSyOcUTtPGkWo72y2LsA8GS
         Z3Hj3zruGB/p7UKPyikYRgcAMTGdFX5uM1vDk4Zvoz7iVGo89fXk3VX/8oR0WpOqMBo8
         87adJXLd/8G9WUVkAn3uTlPQuPlSm2QKclmk79ZvdVGuHMMZiSZS6rrT64NqwftLesPp
         9rO+iHVnrX0nq0bAfKGR7T9LZeg/9meSOK7WRAFjHZoOIdtx8uvmQik2fm8I5W84Zwsa
         wdEw==
X-Forwarded-Encrypted: i=1; AJvYcCWjNcEjl1kfwmWObPkOoRMahbwBbRw1dXmP2Hf773uu5eZSQxGUAd7aLP6tdTGKRs2bimOuzKYT9DUM65rO+MPfZLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3alzT8LWpMvmMdLcutbwVtwOqbuE8wcHlU3O8LGbc17FOb5Bu
	Kkz329iDDH1SqTVu0bfEFeu2IXQ/RHvycPoEqWzqrmIFJdeU+MvekwwU7pJzeSaYOpiY25BqPGJ
	c8IaSvTribxBlBmHI2+4V3BLL2qDb/XZ0853SUNaybuHxF9b2g2L7iMRxsMSbC6ZlNCIvobdasK
	QyQEbeCFnc
X-Gm-Gg: ASbGncvTG/aAc3MixlacLcQeR/mfiopQ8/3FUhI8z/pOSVaOYziMN+MpMxjq7twMxtC
	s2gjKiPSiV1eLv9CSaA0N1u8ukR8ywz7OzDpLGQAsyEBFS+c5EvMdMXAE6So4hrM7l/fyOFDdjO
	24xHt1pGAtekUanYda+x10VwYvUUAsoYJuWgV+RgKLmYxIo54Ws7S4LxBez+MWuK6a9uW8VjXpN
	6YwADtfQ72bHHdVfcjtL89isE7iTEnThHeIYYYHAe1aeTRDE/qfF/vyqrPctBnEGTLTA+d0aFh3
	olk1RnaQOPsmJ2RRsxdNv3CbamtobwBS/Z45S82p8/yY18iGws1bdERX+Mz8Vj/g5Q==
X-Received: by 2002:a05:600c:138d:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-458b69f2c1fmr112792375e9.2.1754383233230;
        Tue, 05 Aug 2025 01:40:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXkz7yJxMJRXO7x7Pqbkwu+fuUUUkCO0wHwuYcC2A1NgNZuooTmjERjvi3xOdnENJNnRES1w==
X-Received: by 2002:a05:600c:138d:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-458b69f2c1fmr112791985e9.2.1754383232756;
        Tue, 05 Aug 2025 01:40:32 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459de85efb0sm51611085e9.7.2025.08.05.01.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 01:40:32 -0700 (PDT)
Message-ID: <b3499e8d79c2215b4fb765c0ceb5294f322efa3a.camel@redhat.com>
Subject: Re: [PATCH 5/5] rv: Add rts monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 05 Aug 2025 10:40:30 +0200
In-Reply-To: <20834b8fcd4dfe75642cec2097e29f4c636a33fb.1753879295.git.namcao@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
	 <20834b8fcd4dfe75642cec2097e29f4c636a33fb.1753879295.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: GKMCYE8EtVhZfVGKsdbmuNHyD-33VzcFpEIqJlXe07s_1754383233
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-07-30 at 14:45 +0200, Nam Cao wrote:
> Add "real-time scheduling" monitor, which validates that SCHED_RR and
> SCHED_FIFO tasks are scheduled before tasks with normal and
> extensible
> scheduling policies
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Hello Nam,

I just built and booted up the monitor in a VM (virtme-ng), the
configuration has preemptirq tracepoints and all monitors so far (as we
have seen earlier, it doesn't build if rtapp monitors are not there
because of the circular dependency in the tracepoints).

All I did was to enable the monitor and printk reactor, but I get a
whole lot of errors (as in, I need to quit the VM for it to stop):

[ 1537.699834] rv: rts: 7: violation detected
[ 1537.699930] rv: rts: 3: violation detected
[ 1537.701827] rv: rts: 6: violation detected
[ 1537.704894] rv: rts: 0: violation detected
[ 1537.704925] rv: rts: 0: violation detected
[ 1537.704988] rv: rts: 3: violation detected
[ 1537.705019] rv: rts: 3: violation detected
[ 1537.705998] rv: rts: 0: violation detected
[ 1537.706024] rv: rts: 0: violation detected
[ 1537.709875] rv: rts: 6: violation detected
[ 1537.709921] rv: rts: 6: violation detected
[ 1537.711241] rv: rts: 6: violation detected

Curiously enough, I only see those CPUs (0, 3, 6 and 7).
Other runs have different CPUs but always a small subset (e.g. 10-15,
6-7=C2=A0only 2).
It doesn't always occur but enabling/disabling the monitor might help
triggering it.

Any idea what is happening?

Thanks,
Gabriele

> ---
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> ---
> =C2=A0Documentation/trace/rv/monitor_sched.rst |=C2=A0 19 ++++
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
1 +
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0kernel/trace/rv/monitors/rts/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 17 +++
> =C2=A0kernel/trace/rv/monitors/rts/rts.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 131
> +++++++++++++++++++++++
> =C2=A0kernel/trace/rv/monitors/rts/rts.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 126
> ++++++++++++++++++++++
> =C2=A0kernel/trace/rv/monitors/rts/rts_trace.h |=C2=A0 15 +++
> =C2=A0tools/verification/models/sched/rts.ltl=C2=A0 |=C2=A0=C2=A0 5 +
> =C2=A08 files changed, 315 insertions(+)
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
> index 951c2e0cda25..3992ff6ac8b1 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -62,6 +62,7 @@ source "kernel/trace/rv/monitors/sts/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/nrp/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/sssw/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/opid/Kconfig"
> +source "kernel/trace/rv/monitors/rts/Kconfig"
> =C2=A0# Add new sched monitors here
> =C2=A0
> =C2=A0source "kernel/trace/rv/monitors/rtapp/Kconfig"
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
> index 000000000000..1b780bce6133
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rts/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +config RV_MON_RTS
> +=09depends on RV
> +=09select RV_LTL_MONITOR
> +=09depends on RV_MON_SCHED
> +=09default y
> +=09select LTL_MON_EVENTS_IMPLICIT
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
> index 000000000000..e23563c47eb1
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rts/rts.c
> @@ -0,0 +1,131 @@
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
> +#include <monitors/sched/sched.h>
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
> +static void handle_enqueue_task_rt(void *data, int cpu, struct
> task_struct *task)
> +{
> +=09unsigned int *queued =3D per_cpu_ptr(&nr_queued, cpu);
> +
> +=09(*queued)++;
> +=09ltl_atom_update(cpu, LTL_RT_TASK_ENQUEUED, true);
> +}
> +
> +static void handle_dequeue_task_rt(void *data, int cpu, struct
> task_struct *task)
> +{
> +=09unsigned int *queued =3D per_cpu_ptr(&nr_queued, cpu);
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
> +=09int retval;
> +
> +=09retval =3D ltl_monitor_init();
> +=09if (retval)
> +=09=09return retval;
> +
> +=09rv_attach_trace_probe("rts", enqueue_task_rt_tp,
> handle_enqueue_task_rt);
> +=09rv_attach_trace_probe("rts", dequeue_task_rt_tp,
> handle_dequeue_task_rt);
> +=09rv_attach_trace_probe("rts", sched_switch,
> handle_sched_switch);
> +
> +=09return 0;
> +}
> +
> +static void disable_rts(void)
> +{
> +=09rv_detach_trace_probe("rts", enqueue_task_rt_tp,
> handle_enqueue_task_rt);
> +=09rv_detach_trace_probe("rts", dequeue_task_rt_tp,
> handle_dequeue_task_rt);
> +=09rv_detach_trace_probe("rts", sched_switch,
> handle_sched_switch);
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
> +=09return rv_register_monitor(&rv_rts, &rv_sched);
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
> index 000000000000..9fbf0d97c1a7
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
> +#define LTL_MONITOR_TYPE LTL_CPU_MONITOR
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
> index 000000000000..0ac9e112a8b0
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
> +DEFINE_EVENT(event_ltl_monitor, event_rts,
> +=09TP_PROTO(unsigned int cpu, char *states, char *atoms, char
> *next),
> +=09TP_ARGS(cpu, states, atoms, next));
> +
> +DEFINE_EVENT(error_ltl_monitor, error_rts,
> +=09TP_PROTO(unsigned int cpu),
> +=09TP_ARGS(cpu));
> +#endif /* CONFIG_RV_MON_RTS */
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

