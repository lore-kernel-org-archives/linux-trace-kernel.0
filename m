Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B981B423B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747413078; cv=none; b=TBWKOHKi1tff5sJGwKO+uW1AlEnZlq2goelMLg8INtFEqK8/RFkBl0n/hY9XXqyJJFOVcrDvwT2qKXP7jmOI2vvGIxOd7xQ61y8WmIdy/ZNMunmHLewbWkMLdOewcpgQoP5/RiiwKyAM3NbKDKpox9pKcp0edw7QdrzJarbxOn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747413078; c=relaxed/simple;
	bh=UV8xL9BtxgGWLUbVLCpFHSzhYQlSo3dU/AXQmZ277Sc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=niQ7X2AzteG/FAFYk25NDizJfeGBKdkdRXrYxMtfNMZN5f5P7D5trjy1kR5Eoj+rEMPLseQpJCsJflpE5k/yiImL9eFol1y0TklYrLiSaLCux8w1+Iy3zekGvXln1y+WRkX7oXNnz5A+qZR1aXSNZPr7oiCTYkS4dcAxqZzofDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dXIamwnf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXIamwnf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747413072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UV8xL9BtxgGWLUbVLCpFHSzhYQlSo3dU/AXQmZ277Sc=;
	b=dXIamwnfl5oSN9y2Z5IXxvpXWmvfjw5Y3nJ2mf4EN/fMiiNDQjxaRJ607cGxKmosGnpIwn
	VwxHI2mDb2hrcpMoVquQh/R1+KEAT71FKfnG8Bd2Yll+OkmIoxPFhYaNI3NW2KXdlKdw5f
	orP5yCPRINysB2Tl7n/rtKKOZTfE3VU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-GwniidGaMiGVMEZatjmxXg-1; Fri, 16 May 2025 12:31:08 -0400
X-MC-Unique: GwniidGaMiGVMEZatjmxXg-1
X-Mimecast-MFC-AGG-ID: GwniidGaMiGVMEZatjmxXg_1747413067
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-acb61452b27so183802866b.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 09:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747413067; x=1748017867;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UV8xL9BtxgGWLUbVLCpFHSzhYQlSo3dU/AXQmZ277Sc=;
        b=Y+ljKf40AntPEqWKMyzAVquFvyThTfupakBLbwZ0yeZ8pXEv2auqnG3vPgcF5aAudd
         JDbYoilnFALhVrmOUs6Oq/9ovOwidTOtVQZkyMM6GXsDpmPJ2pteNv7DScWr5Z7EaIiO
         dqYKmngg7O7cukdWrWtWaiXXWeBco4zrQWpp4YJh6V0PT4j1aWVTmPwxAuyb4TcrAqVX
         CteFBi2W1DKzP9EbboQwiiYMOv3jbaIA08mgZhRD+ROuqjbJR261HAz9OL6ap/jO6CYH
         C7OgHuUoZOXFAW/CdMreTNMAqd6n4sLfgdxS08PiaZ0XhqBfmwzauBv9/8/Oew4yYV3S
         2yyQ==
X-Gm-Message-State: AOJu0YztoB1tAQp/OYiAf35xJf7CCshzYsb9i1HtwwGPLbWIUwG6Pc+w
	nywIBz2NmK/TJdT3+g6g/ULfxGuHPpQca/E5N+rtjJr8baChqHoF7HAayuwfy7H3jPJ+irft9+v
	JNqfZy99KWYhCaxRCPsyC/Gq+3Zf4dPJse2iPEANNdOUu/Nt6kRyqeBg+rk8ZVyl+akpkD8K0M9
	/X5DM5t3K8
X-Gm-Gg: ASbGncuH4FOfMeRZhz6XUNjlMuLqpwhcI1r5SKXTAMQURhr085MrucUO0Z272Xn4UjE
	0WRQyN1hLzjO3Mk/6N9QdltI/1D2iZhFGGeXNfO23vCb2DWM+aLvBgEJgpa2kuTkh0I5mUN8miV
	ZNU83FKYXYhCrfPRWp9BYH4xq5FupM7IroXqJF4lFCtosCQT4tQt45jx2C/gUtMIbjRk/OQ8lpW
	wQ4VeVJsaO5X8kp7YRHG+5mKdsCzRF+ZEG6dIwAd7GTmKgwcRR3cXhSeTmBZbGNs7Tu2iXES6aa
	zrSSGdFDgg==
X-Received: by 2002:a17:907:1b0b:b0:ad2:4c38:5a22 with SMTP id a640c23a62f3a-ad52d5e144dmr410419866b.51.1747413066788;
        Fri, 16 May 2025 09:31:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWVJwyxa0un4t3kTwqsc0r9/HTSCK9X81GGlxHgODTAdoiap55ll0IKjkZD/2U3bg8GAGQPA==
X-Received: by 2002:a17:907:1b0b:b0:ad2:4c38:5a22 with SMTP id a640c23a62f3a-ad52d5e144dmr410414666b.51.1747413066226;
        Fri, 16 May 2025 09:31:06 -0700 (PDT)
Received: from [127.0.0.1] ([195.174.132.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d06ddd6sm184078466b.55.2025.05.16.09.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 09:31:05 -0700 (PDT)
Date: Fri, 16 May 2025 16:31:03 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de
Message-ID: <06d48208-686a-4d33-95ca-4e4d5991a42f@redhat.com>
In-Reply-To: <3199656a35cc8a7acc2e30d320defa778acf8532.1747046848.git.namcao@linutronix.de>
References: <cover.1747046848.git.namcao@linutronix.de> <3199656a35cc8a7acc2e30d320defa778acf8532.1747046848.git.namcao@linutronix.de>
Subject: Re: [PATCH v8 20/22] rv: Add rtapp_sleep monitor
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Correlation-ID: <06d48208-686a-4d33-95ca-4e4d5991a42f@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BFh7ORs187enFqtMuL2vYFbHy-H383MSV-3sLKNY33o_1747413067
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2025-05-12T10:56:30Z Nam Cao <namcao@linutronix.de>:

> Add a monitor for checking that real-time tasks do not go to sleep in a
> manner that may cause undesirable latency.
>
> Also change
> =C2=A0=C2=A0=C2=A0 RV depends on TRACING
> to
> =C2=A0=C2=A0=C2=A0 RV select TRACING
> to avoid the following recursive dependency:
>
> error: recursive dependency detected!
> =C2=A0=C2=A0=C2=A0 symbol TRACING is selected by PREEMPTIRQ_TRACEPOINTS
> =C2=A0=C2=A0=C2=A0 symbol PREEMPTIRQ_TRACEPOINTS depends on TRACE_IRQFLAG=
S
> =C2=A0=C2=A0=C2=A0 symbol TRACE_IRQFLAGS is selected by RV_MON_SLEEP
> =C2=A0=C2=A0=C2=A0 symbol RV_MON_SLEEP depends on RV
> =C2=A0=C2=A0=C2=A0 symbol RV depends on TRACING
>
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 3 +-
> kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 1 +
> kernel/trace/rv/monitors/sleep/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 13 +
> kernel/trace/rv/monitors/sleep/sleep.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 236 +++++++++++++++++
> kernel/trace/rv/monitors/sleep/sleep.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 250 +++++++++++++++++++
> kernel/trace/rv/monitors/sleep/sleep_trace.h |=C2=A0 14 ++
> kernel/trace/rv/rv_trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 +
> tools/verification/models/rtapp/sleep.ltl=C2=A0=C2=A0=C2=A0 |=C2=A0 22 ++
> 8 files changed, 539 insertions(+), 1 deletion(-)
> create mode 100644 kernel/trace/rv/monitors/sleep/Kconfig
> create mode 100644 kernel/trace/rv/monitors/sleep/sleep.c
> create mode 100644 kernel/trace/rv/monitors/sleep/sleep.h
> create mode 100644 kernel/trace/rv/monitors/sleep/sleep_trace.h
> create mode 100644 tools/verification/models/rtapp/sleep.ltl
> [...]
> diff --git a/kernel/trace/rv/monitors/sleep/Kconfig b/kernel/trace/rv/mon=
itors/sleep/Kconfig
> new file mode 100644
> index 000000000000..d00aa1aae069
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/sleep/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +config RV_MON_SLEEP
> +=C2=A0=C2=A0 depends on RV
> +=C2=A0=C2=A0 select RV_LTL_MONITOR
> +=C2=A0=C2=A0 depends on HAVE_SYSCALL_TRACEPOINTS
> +=C2=A0=C2=A0 depends on RV_MON_RTAPP
> +=C2=A0=C2=A0 select TRACE_IRQFLAGS

I had a different approach towards those (the preemptirq tracepoints) under=
 the assumption adding them introduces latency.
Besides me picking the wrong config (I used IRQSOFF, I'll fix that) I consi=
dered the monitor should /depend/ on the tracepoint instead of select it.
This way it looks easier to me to avoid making a change that introduces lat=
ency slip in when distribution maintainers enable the monitor (e.g. TRACE_I=
RQFLAGS may be enabled on debug kernels and using depends would automatical=
ly prevent the monitor on non-debug kernels).

Now is this concern justified? Is it only a performance issue for the preem=
pt tracepoint or not even there?
I'd like to keep consistency but I really can't decide on which approach is=
 better.

Also curiosity on my side (I didn't try), you require TRACE_IRQFLAGS to use=
 hardirq_context but how different is it from in_hardirq() in your case?

Thanks,
Gabriele

> +=C2=A0=C2=A0 default y
> +=C2=A0=C2=A0 select LTL_MON_EVENTS_ID
> +=C2=A0=C2=A0 bool "sleep monitor"
> +=C2=A0=C2=A0 help
> +=C2=A0=C2=A0=C2=A0=C2=A0 Monitor that real-time tasks do not sleep in a =
manner that may cause undesirable latency.
> diff --git a/kernel/trace/rv/monitors/sleep/sleep.c b/kernel/trace/rv/mon=
itors/sleep/sleep.c
> new file mode 100644
> index 000000000000..1841875e1cef
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/sleep/sleep.c
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/ftrace.h>
> +#include <linux/tracepoint.h>
> +#include <linux/init.h>
> +#include <linux/irqflags.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/rv.h>
> +#include <linux/sched/deadline.h>
> +#include <linux/sched/rt.h>
> +#include <rv/instrumentation.h>
> +
> +#define MODULE_NAME "sleep"
> +
> +#include <trace/events/syscalls.h>
> +#include <trace/events/sched.h>
> +#include <trace/events/lock.h>
> +#include <uapi/linux/futex.h>
> +#include <rv_trace.h>
> +#include <monitors/rtapp/rtapp.h>
> +
> +#include "sleep.h"
> +#include <rv/ltl_monitor.h>
> +
> +static void ltl_atoms_fetch(struct task_struct *task, struct ltl_monitor=
 *mon)
> +{
> +=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0 * This includes "actual" real-time tasks and also PI-=
boosted tasks. A task being PI-boosted
> +=C2=A0=C2=A0=C2=A0 * means it is blocking an "actual" real-task, therefo=
re it should also obey the monitor's
> +=C2=A0=C2=A0=C2=A0 * rule, otherwise the "actual" real-task may be delay=
ed.
> +=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0 ltl_atom_set(mon, LTL_RT, rt_or_dl_task(task));
> +}
> +
> +static void ltl_atoms_init(struct task_struct *task, struct ltl_monitor =
*mon, bool task_creation)
> +{
> +=C2=A0=C2=A0 ltl_atom_set(mon, LTL_SLEEP, false);
> +=C2=A0=C2=A0 ltl_atom_set(mon, LTL_WAKE, false);
> +=C2=A0=C2=A0 ltl_atom_set(mon, LTL_ABORT_SLEEP, false);
> +=C2=A0=C2=A0 ltl_atom_set(mon, LTL_WOKEN_BY_HARDIRQ, false);
> +=C2=A0=C2=A0 ltl_atom_set(mon, LTL_WOKEN_BY_NMI, false);
> +=C2=A0=C2=A0 ltl_atom_set(mon, LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO, false)=
;
> +
> +=C2=A0=C2=A0 if (task_creation) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_KTHREAD_SHOUL=
D_STOP, false);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_NANOSLEEP_CLO=
CK_MONOTONIC, false);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_NANOSLEEP_CLO=
CK_TAI, false);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_NANOSLEEP_TIM=
ER_ABSTIME, false);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_CLOCK_NANOSLE=
EP, false);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_FUTEX_WAIT, f=
alse);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_FUTEX_LOCK_PI=
, false);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_BLOCK_ON_RT_M=
UTEX, false);
> +=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0 if (task->flags & PF_KTHREAD) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_KERNEL_THREAD=
, true);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* kernel tasks do not do syscall *=
/
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_FUTEX_WAIT, f=
alse);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_FUTEX_LOCK_PI=
, false);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_NANOSLEEP_CLO=
CK_MONOTONIC, false);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_NANOSLEEP_CLO=
CK_TAI, false);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_NANOSLEEP_TIM=
ER_ABSTIME, false);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_CLOCK_NANOSLE=
EP, false);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (strstarts(task->comm, "migratio=
n/"))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_se=
t(mon, LTL_TASK_IS_MIGRATION, true);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_se=
t(mon, LTL_TASK_IS_MIGRATION, false);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (strstarts(task->comm, "rcu"))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_se=
t(mon, LTL_TASK_IS_RCU, true);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_se=
t(mon, LTL_TASK_IS_RCU, false);
> +=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_KTHREAD_SHOUL=
D_STOP, false);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_KERNEL_THREAD=
, false);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_TASK_IS_RCU, =
false);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_TASK_IS_MIGRA=
TION, false);
> +=C2=A0=C2=A0 }
> +
> +}
> +
> +static void handle_sched_set_state(void *data, struct task_struct *task,=
 int state)
> +{
> +=C2=A0=C2=A0 if (state & TASK_INTERRUPTIBLE)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_pulse(task, LTL_SLEEP, tru=
e);
> +=C2=A0=C2=A0 else if (state =3D=3D TASK_RUNNING)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_pulse(task, LTL_ABORT_SLEE=
P, true);
> +}
> +
> +static void handle_sched_wakeup(void *data, struct task_struct *task)
> +{
> +=C2=A0=C2=A0 ltl_atom_pulse(task, LTL_WAKE, true);
> +}
> +
> +static void handle_sched_waking(void *data, struct task_struct *task)
> +{
> +=C2=A0=C2=A0 if (this_cpu_read(hardirq_context)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_pulse(task, LTL_WOKEN_BY_H=
ARDIRQ, true);
> +=C2=A0=C2=A0 } else if (in_task()) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (current->prio <=3D task->prio)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_pu=
lse(task, LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO, true);
> +=C2=A0=C2=A0 } else if (in_nmi()) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_pulse(task, LTL_WOKEN_BY_N=
MI, true);
> +=C2=A0=C2=A0 }
> +}
> +
> +static void handle_contention_begin(void *data, void *lock, unsigned int=
 flags)
> +{
> +=C2=A0=C2=A0 if (flags & LCB_F_RT)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_update(current, LTL_BLOCK_=
ON_RT_MUTEX, true);
> +}
> +
> +static void handle_contention_end(void *data, void *lock, int ret)
> +{
> +=C2=A0=C2=A0 ltl_atom_update(current, LTL_BLOCK_ON_RT_MUTEX, false);
> +}
> +
> +static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
> +{
> +=C2=A0=C2=A0 struct ltl_monitor *mon;
> +=C2=A0=C2=A0 unsigned long args[6];
> +=C2=A0=C2=A0 int op, cmd;
> +
> +=C2=A0=C2=A0 mon =3D ltl_get_monitor(current);
> +
> +=C2=A0=C2=A0 switch (id) {
> +=C2=A0=C2=A0 case __NR_clock_nanosleep:
> +#ifdef __NR_clock_nanosleep_time64
> +=C2=A0=C2=A0 case __NR_clock_nanosleep_time64:
> +#endif
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 syscall_get_arguments(current, regs=
, args);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_NANOSLEEP_CLO=
CK_MONOTONIC, args[0] =3D=3D CLOCK_MONOTONIC);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_NANOSLEEP_CLO=
CK_TAI, args[0] =3D=3D CLOCK_TAI);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_set(mon, LTL_NANOSLEEP_TIM=
ER_ABSTIME, args[1] =3D=3D TIMER_ABSTIME);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_update(current, LTL_CLOCK_=
NANOSLEEP, true);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +
> +=C2=A0=C2=A0 case __NR_futex:
> +#ifdef __NR_futex_time64
> +=C2=A0=C2=A0 case __NR_futex_time64:
> +#endif
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 syscall_get_arguments(current, regs=
, args);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D args[1];
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd =3D op & FUTEX_CMD_MASK;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (cmd) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case FUTEX_LOCK_PI:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case FUTEX_LOCK_PI2:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_up=
date(current, LTL_FUTEX_LOCK_PI, true);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case FUTEX_WAIT:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case FUTEX_WAIT_BITSET:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case FUTEX_WAIT_REQUEUE_PI:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ltl_atom_up=
date(current, LTL_FUTEX_WAIT, true);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0 }
> +}
> +
> +static void handle_sys_exit(void *data, struct pt_regs *regs, long ret)
> +{
> +=C2=A0=C2=A0 struct ltl_monitor *mon =3D ltl_get_monitor(current);
> +
> +=C2=A0=C2=A0 ltl_atom_set(mon, LTL_FUTEX_LOCK_PI, false);
> +=C2=A0=C2=A0 ltl_atom_set(mon, LTL_FUTEX_WAIT, false);
> +=C2=A0=C2=A0 ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, false);
> +=C2=A0=C2=A0 ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, false);
> +=C2=A0=C2=A0 ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
> +=C2=A0=C2=A0 ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, false);
> +}
> +
> +static void handle_kthread_stop(void *data, struct task_struct *task)
> +{
> +=C2=A0=C2=A0 /* FIXME: this could race with other tracepoint handlers */
> +=C2=A0=C2=A0 ltl_atom_update(task, LTL_KTHREAD_SHOULD_STOP, true);
> +}
> +
> +static int enable_sleep(void)
> +{
> +=C2=A0=C2=A0 int retval;
> +
> +=C2=A0=C2=A0 retval =3D ltl_monitor_init();
> +=C2=A0=C2=A0 if (retval)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return retval;
> +
> +=C2=A0=C2=A0 rv_attach_trace_probe("rtapp_sleep", sched_waking, handle_s=
ched_waking);
> +=C2=A0=C2=A0 rv_attach_trace_probe("rtapp_sleep", sched_wakeup, handle_s=
ched_wakeup);
> +=C2=A0=C2=A0 rv_attach_trace_probe("rtapp_sleep", sched_set_state_tp, ha=
ndle_sched_set_state);
> +=C2=A0=C2=A0 rv_attach_trace_probe("rtapp_sleep", contention_begin, hand=
le_contention_begin);
> +=C2=A0=C2=A0 rv_attach_trace_probe("rtapp_sleep", contention_end, handle=
_contention_end);
> +=C2=A0=C2=A0 rv_attach_trace_probe("rtapp_sleep", sched_kthread_stop, ha=
ndle_kthread_stop);
> +=C2=A0=C2=A0 rv_attach_trace_probe("rtapp_sleep", sys_enter, handle_sys_=
enter);
> +=C2=A0=C2=A0 rv_attach_trace_probe("rtapp_sleep", sys_exit, handle_sys_e=
xit);
> +=C2=A0=C2=A0 return 0;
> +}
> +
> +static void disable_sleep(void)
> +{
> +=C2=A0=C2=A0 rv_detach_trace_probe("rtapp_sleep", sched_waking, handle_s=
ched_waking);
> +=C2=A0=C2=A0 rv_detach_trace_probe("rtapp_sleep", sched_wakeup, handle_s=
ched_wakeup);
> +=C2=A0=C2=A0 rv_detach_trace_probe("rtapp_sleep", sched_set_state_tp, ha=
ndle_sched_set_state);
> +=C2=A0=C2=A0 rv_detach_trace_probe("rtapp_sleep", contention_begin, hand=
le_contention_begin);
> +=C2=A0=C2=A0 rv_detach_trace_probe("rtapp_sleep", contention_end, handle=
_contention_end);
> +=C2=A0=C2=A0 rv_detach_trace_probe("rtapp_sleep", sched_kthread_stop, ha=
ndle_kthread_stop);
> +=C2=A0=C2=A0 rv_detach_trace_probe("rtapp_sleep", sys_enter, handle_sys_=
enter);
> +=C2=A0=C2=A0 rv_detach_trace_probe("rtapp_sleep", sys_exit, handle_sys_e=
xit);
> +
> +=C2=A0=C2=A0 ltl_monitor_destroy();
> +}
> +
> +static struct rv_monitor rv_sleep =3D {
> +=C2=A0=C2=A0 .name =3D "sleep",
> +=C2=A0=C2=A0 .description =3D "Monitor that RT tasks do not undesirably =
sleep",
> +=C2=A0=C2=A0 .enable =3D enable_sleep,
> +=C2=A0=C2=A0 .disable =3D disable_sleep,
> +};
> +
> +static int __init register_sleep(void)
> +{
> +=C2=A0=C2=A0 return rv_register_monitor(&rv_sleep, &rv_rtapp);
> +}
> +
> +static void __exit unregister_sleep(void)
> +{
> +=C2=A0=C2=A0 rv_unregister_monitor(&rv_sleep);
> +}
> +
> +module_init(register_sleep);
> +module_exit(unregister_sleep);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
> +MODULE_DESCRIPTION("sleep: Monitor that RT tasks do not undesirably slee=
p");
> diff --git a/kernel/trace/rv/monitors/sleep/sleep.h b/kernel/trace/rv/mon=
itors/sleep/sleep.h
> new file mode 100644
> index 000000000000..d1f990195a20
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/sleep/sleep.h
> @@ -0,0 +1,250 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/rv.h>
> +
> +#define MONITOR_NAME sleep
> +
> +enum ltl_atom {
> +=C2=A0=C2=A0 LTL_ABORT_SLEEP,
> +=C2=A0=C2=A0 LTL_BLOCK_ON_RT_MUTEX,
> +=C2=A0=C2=A0 LTL_CLOCK_NANOSLEEP,
> +=C2=A0=C2=A0 LTL_FUTEX_LOCK_PI,
> +=C2=A0=C2=A0 LTL_FUTEX_WAIT,
> +=C2=A0=C2=A0 LTL_KERNEL_THREAD,
> +=C2=A0=C2=A0 LTL_KTHREAD_SHOULD_STOP,
> +=C2=A0=C2=A0 LTL_NANOSLEEP_CLOCK_MONOTONIC,
> +=C2=A0=C2=A0 LTL_NANOSLEEP_CLOCK_TAI,
> +=C2=A0=C2=A0 LTL_NANOSLEEP_TIMER_ABSTIME,
> +=C2=A0=C2=A0 LTL_RT,
> +=C2=A0=C2=A0 LTL_SLEEP,
> +=C2=A0=C2=A0 LTL_TASK_IS_MIGRATION,
> +=C2=A0=C2=A0 LTL_TASK_IS_RCU,
> +=C2=A0=C2=A0 LTL_WAKE,
> +=C2=A0=C2=A0 LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO,
> +=C2=A0=C2=A0 LTL_WOKEN_BY_HARDIRQ,
> +=C2=A0=C2=A0 LTL_WOKEN_BY_NMI,
> +=C2=A0=C2=A0 LTL_NUM_ATOM
> +};
> +static_assert(LTL_NUM_ATOM <=3D RV_MAX_LTL_ATOM);
> +
> +static const char *ltl_atom_str(enum ltl_atom atom)
> +{
> +=C2=A0=C2=A0 static const char *const names[] =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ab_sl",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "bl_on_rt_mu",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "cl_na",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "fu_lo_pi",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "fu_wa",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ker_th",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "kth_sh_st",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "na_cl_mo",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "na_cl_ta",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "na_ti_ab",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "rt",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sl",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ta_mi",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ta_rc",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "wak",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "wo_eq_hi_pr",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "wo_ha",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "wo_nm",
> +=C2=A0=C2=A0 };
> +
> +=C2=A0=C2=A0 return names[atom];
> +}
> +
> +enum ltl_buchi_state {
> +=C2=A0=C2=A0 S0,
> +=C2=A0=C2=A0 S1,
> +=C2=A0=C2=A0 S2,
> +=C2=A0=C2=A0 S3,
> +=C2=A0=C2=A0 S4,
> +=C2=A0=C2=A0 S5,
> +=C2=A0=C2=A0 S6,
> +=C2=A0=C2=A0 S7,
> +=C2=A0=C2=A0 RV_NUM_BA_STATES
> +};
> +static_assert(RV_NUM_BA_STATES <=3D RV_MAX_BA_STATES);
> +
> +static void ltl_start(struct task_struct *task, struct ltl_monitor *mon)
> +{
> +=C2=A0=C2=A0 bool task_is_migration =3D test_bit(LTL_TASK_IS_MIGRATION, =
mon->atoms);
> +=C2=A0=C2=A0 bool task_is_rcu =3D test_bit(LTL_TASK_IS_RCU, mon->atoms);
> +=C2=A0=C2=A0 bool val40 =3D task_is_rcu || task_is_migration;
> +=C2=A0=C2=A0 bool futex_lock_pi =3D test_bit(LTL_FUTEX_LOCK_PI, mon->ato=
ms);
> +=C2=A0=C2=A0 bool val41 =3D futex_lock_pi || val40;
> +=C2=A0=C2=A0 bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, =
mon->atoms);
> +=C2=A0=C2=A0 bool val5 =3D block_on_rt_mutex || val41;
> +=C2=A0=C2=A0 bool kthread_should_stop =3D test_bit(LTL_KTHREAD_SHOULD_ST=
OP, mon->atoms);
> +=C2=A0=C2=A0 bool abort_sleep =3D test_bit(LTL_ABORT_SLEEP, mon->atoms);
> +=C2=A0=C2=A0 bool val32 =3D abort_sleep || kthread_should_stop;
> +=C2=A0=C2=A0 bool woken_by_nmi =3D test_bit(LTL_WOKEN_BY_NMI, mon->atoms=
);
> +=C2=A0=C2=A0 bool val33 =3D woken_by_nmi || val32;
> +=C2=A0=C2=A0 bool woken_by_hardirq =3D test_bit(LTL_WOKEN_BY_HARDIRQ, mo=
n->atoms);
> +=C2=A0=C2=A0 bool val34 =3D woken_by_hardirq || val33;
> +=C2=A0=C2=A0 bool woken_by_equal_or_higher_prio =3D test_bit(LTL_WOKEN_B=
Y_EQUAL_OR_HIGHER_PRIO,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mon->atoms);
> +=C2=A0=C2=A0 bool val14 =3D woken_by_equal_or_higher_prio || val34;
> +=C2=A0=C2=A0 bool wake =3D test_bit(LTL_WAKE, mon->atoms);
> +=C2=A0=C2=A0 bool val13 =3D !wake;
> +=C2=A0=C2=A0 bool kernel_thread =3D test_bit(LTL_KERNEL_THREAD, mon->ato=
ms);
> +=C2=A0=C2=A0 bool nanosleep_clock_tai =3D test_bit(LTL_NANOSLEEP_CLOCK_T=
AI, mon->atoms);
> +=C2=A0=C2=A0 bool nanosleep_clock_monotonic =3D test_bit(LTL_NANOSLEEP_C=
LOCK_MONOTONIC, mon->atoms);
> +=C2=A0=C2=A0 bool val24 =3D nanosleep_clock_monotonic || nanosleep_clock=
_tai;
> +=C2=A0=C2=A0 bool nanosleep_timer_abstime =3D test_bit(LTL_NANOSLEEP_TIM=
ER_ABSTIME, mon->atoms);
> +=C2=A0=C2=A0 bool val25 =3D nanosleep_timer_abstime && val24;
> +=C2=A0=C2=A0 bool clock_nanosleep =3D test_bit(LTL_CLOCK_NANOSLEEP, mon-=
>atoms);
> +=C2=A0=C2=A0 bool val18 =3D clock_nanosleep && val25;
> +=C2=A0=C2=A0 bool futex_wait =3D test_bit(LTL_FUTEX_WAIT, mon->atoms);
> +=C2=A0=C2=A0 bool val9 =3D futex_wait || val18;
> +=C2=A0=C2=A0 bool val11 =3D val9 || kernel_thread;
> +=C2=A0=C2=A0 bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
> +=C2=A0=C2=A0 bool val2 =3D !sleep;
> +=C2=A0=C2=A0 bool rt =3D test_bit(LTL_RT, mon->atoms);
> +=C2=A0=C2=A0 bool val1 =3D !rt;
> +=C2=A0=C2=A0 bool val3 =3D val1 || val2;
> +
> +=C2=A0=C2=A0 if (val3)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S0, mon->states);
> +=C2=A0=C2=A0 if (val11 && val13)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S1, mon->states);
> +=C2=A0=C2=A0 if (val11 && val14)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S4, mon->states);
> +=C2=A0=C2=A0 if (val5)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S5, mon->states);
> +}
> +
> +static void
> +ltl_possible_next_states(struct ltl_monitor *mon, unsigned int state, un=
signed long *next)
> +{
> +=C2=A0=C2=A0 bool task_is_migration =3D test_bit(LTL_TASK_IS_MIGRATION, =
mon->atoms);
> +=C2=A0=C2=A0 bool task_is_rcu =3D test_bit(LTL_TASK_IS_RCU, mon->atoms);
> +=C2=A0=C2=A0 bool val40 =3D task_is_rcu || task_is_migration;
> +=C2=A0=C2=A0 bool futex_lock_pi =3D test_bit(LTL_FUTEX_LOCK_PI, mon->ato=
ms);
> +=C2=A0=C2=A0 bool val41 =3D futex_lock_pi || val40;
> +=C2=A0=C2=A0 bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, =
mon->atoms);
> +=C2=A0=C2=A0 bool val5 =3D block_on_rt_mutex || val41;
> +=C2=A0=C2=A0 bool kthread_should_stop =3D test_bit(LTL_KTHREAD_SHOULD_ST=
OP, mon->atoms);
> +=C2=A0=C2=A0 bool abort_sleep =3D test_bit(LTL_ABORT_SLEEP, mon->atoms);
> +=C2=A0=C2=A0 bool val32 =3D abort_sleep || kthread_should_stop;
> +=C2=A0=C2=A0 bool woken_by_nmi =3D test_bit(LTL_WOKEN_BY_NMI, mon->atoms=
);
> +=C2=A0=C2=A0 bool val33 =3D woken_by_nmi || val32;
> +=C2=A0=C2=A0 bool woken_by_hardirq =3D test_bit(LTL_WOKEN_BY_HARDIRQ, mo=
n->atoms);
> +=C2=A0=C2=A0 bool val34 =3D woken_by_hardirq || val33;
> +=C2=A0=C2=A0 bool woken_by_equal_or_higher_prio =3D test_bit(LTL_WOKEN_B=
Y_EQUAL_OR_HIGHER_PRIO,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mon->atoms);
> +=C2=A0=C2=A0 bool val14 =3D woken_by_equal_or_higher_prio || val34;
> +=C2=A0=C2=A0 bool wake =3D test_bit(LTL_WAKE, mon->atoms);
> +=C2=A0=C2=A0 bool val13 =3D !wake;
> +=C2=A0=C2=A0 bool kernel_thread =3D test_bit(LTL_KERNEL_THREAD, mon->ato=
ms);
> +=C2=A0=C2=A0 bool nanosleep_clock_tai =3D test_bit(LTL_NANOSLEEP_CLOCK_T=
AI, mon->atoms);
> +=C2=A0=C2=A0 bool nanosleep_clock_monotonic =3D test_bit(LTL_NANOSLEEP_C=
LOCK_MONOTONIC, mon->atoms);
> +=C2=A0=C2=A0 bool val24 =3D nanosleep_clock_monotonic || nanosleep_clock=
_tai;
> +=C2=A0=C2=A0 bool nanosleep_timer_abstime =3D test_bit(LTL_NANOSLEEP_TIM=
ER_ABSTIME, mon->atoms);
> +=C2=A0=C2=A0 bool val25 =3D nanosleep_timer_abstime && val24;
> +=C2=A0=C2=A0 bool clock_nanosleep =3D test_bit(LTL_CLOCK_NANOSLEEP, mon-=
>atoms);
> +=C2=A0=C2=A0 bool val18 =3D clock_nanosleep && val25;
> +=C2=A0=C2=A0 bool futex_wait =3D test_bit(LTL_FUTEX_WAIT, mon->atoms);
> +=C2=A0=C2=A0 bool val9 =3D futex_wait || val18;
> +=C2=A0=C2=A0 bool val11 =3D val9 || kernel_thread;
> +=C2=A0=C2=A0 bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
> +=C2=A0=C2=A0 bool val2 =3D !sleep;
> +=C2=A0=C2=A0 bool rt =3D test_bit(LTL_RT, mon->atoms);
> +=C2=A0=C2=A0 bool val1 =3D !rt;
> +=C2=A0=C2=A0 bool val3 =3D val1 || val2;
> +
> +=C2=A0=C2=A0 switch (state) {
> +=C2=A0=C2=A0 case S0:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val3)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
0, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val11 && val13)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
1, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val11 && val14)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
4, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val5)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
5, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0 case S1:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val11 && val13)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
1, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val13 && val3)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
2, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val14 && val3)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
3, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val11 && val14)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
4, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val13 && val5)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
6, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val14 && val5)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
7, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0 case S2:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val11 && val13)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
1, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val13 && val3)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
2, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val14 && val3)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
3, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val11 && val14)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
4, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val13 && val5)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
6, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val14 && val5)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
7, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0 case S3:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val3)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
0, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val11 && val13)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
1, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val11 && val14)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
4, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val5)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
5, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0 case S4:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val3)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
0, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val11 && val13)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
1, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val11 && val14)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
4, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val5)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
5, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0 case S5:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val3)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
0, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val11 && val13)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
1, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val11 && val14)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
4, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val5)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
5, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0 case S6:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val11 && val13)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
1, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val13 && val3)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
2, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val14 && val3)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
3, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val11 && val14)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
4, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val13 && val5)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
6, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val14 && val5)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
7, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0 case S7:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val3)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
0, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val11 && val13)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
1, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val11 && val14)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
4, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val5)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __set_bit(S=
5, next);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0 }
> +}
> diff --git a/kernel/trace/rv/monitors/sleep/sleep_trace.h b/kernel/trace/=
rv/monitors/sleep/sleep_trace.h
> new file mode 100644
> index 000000000000..22eaf31da987
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/sleep/sleep_trace.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Snippet to be included in rv_trace.h
> + */
> +
> +#ifdef CONFIG_RV_MON_SLEEP
> +DEFINE_EVENT(event_ltl_monitor_id, event_sleep,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TP_PROTO(struct task_struct *=
task, char *states, char *atoms, char *next),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TP_ARGS(task, states, atoms, =
next));
> +DEFINE_EVENT(error_ltl_monitor_id, error_sleep,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TP_PROTO(struct task_struct *=
task),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TP_ARGS(task));
> +#endif /* CONFIG_RV_MON_SLEEP */
> diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
> index cfa34af5551b..36ed96868dc4 100644
> --- a/kernel/trace/rv/rv_trace.h
> +++ b/kernel/trace/rv/rv_trace.h
> @@ -173,6 +173,7 @@ TRACE_EVENT(error_ltl_monitor_id,
> =C2=A0=C2=A0=C2=A0 TP_printk("%s[%d]: violation detected", __get_str(comm=
), __entry->pid)
> );
> #include <monitors/pagefault/pagefault_trace.h>
> +#include <monitors/sleep/sleep_trace.h>
> // Add new monitors based on CONFIG_LTL_MON_EVENTS_ID here
> #endif /* CONFIG_LTL_MON_EVENTS_ID */
> #endif /* _TRACE_RV_H */
> diff --git a/tools/verification/models/rtapp/sleep.ltl b/tools/verificati=
on/models/rtapp/sleep.ltl
> new file mode 100644
> index 000000000000..6379bbeb6212
> --- /dev/null
> +++ b/tools/verification/models/rtapp/sleep.ltl
> @@ -0,0 +1,22 @@
> +RULE =3D always ((RT and SLEEP) imply (RT_FRIENDLY_SLEEP or ALLOWLIST))
> +
> +RT_FRIENDLY_SLEEP =3D (RT_VALID_SLEEP_REASON or KERNEL_THREAD)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 and ((not WAKE) until RT_FRIENDLY_WAKE)
> +
> +RT_VALID_SLEEP_REASON =3D FUTEX_WAIT
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or RT_FRIENDLY_NANOSLEEP
> +
> +RT_FRIENDLY_NANOSLEEP =3D CLOCK_NANOSLEEP
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and NANOSLEEP_TIMER_ABSTIME
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and (NANOSLEEP_CLOCK_MONOTONIC o=
r NANOSLEEP_CLOCK_TAI)
> +
> +RT_FRIENDLY_WAKE =3D WOKEN_BY_EQUAL_OR_HIGHER_PRIO
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 or WOKEN_BY_HARDIRQ
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 or WOKEN_BY_NMI
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 or ABORT_SLEEP
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 or KTHREAD_SHOULD_STOP
> +
> +ALLOWLIST =3D BLOCK_ON_RT_MUTEX
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or FUTEX_LOCK_PI
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or TASK_IS_RCU
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or TASK_IS_MIGRATION
> --
> 2.39.5

