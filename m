Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795192685;
	b=SCxNMoARZZNWFD2l8/pjSNB3NpCdptH0pvMqmHvcGCBqXCvuyvddBb2I6knqGvSXxeEF
	 qLQT6PBJvSCwkuKlUvoCduQ1lum5KNQV0Gnz02ESRW/YzR3mb6IVTQJV9bbl7sC7QNgR4
	 AoA7jr1gipBvOqk2kzbWEA/N/ZgjwT6O3qo2pfSwy8edeC/Snws+yvWQg6kByKBAn79FS
	 pMx+RozHio2mvm1Wva+UFxqkuXXGZ6XqYwGjYP2/d6QoH6PXbIjpyvntEnDI9Znukox0l
	 eIPQW91U7Lh0UsHdhPXvjapBfLjT5XScKWr89SSuz/Slgp1InFq0mMsLhQOpSh9PENA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795192685;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=A8m4Gnh8MPzABO/tiaVZwdQcVxLqr3KuTyQbxXbnRDU=;
	b=x8bZoUx+Jpdx/lAEAwpPLt1vZFArC1PS7Kc7a60u9XK9SaH28jqYFmmOROXaR9PPU/h4
	 2knHjq6ERANYDtYI76cNhwp+GAdQrNcu6mBzJLTH+SGPRjEgcj+zq+Z1TbqB+cP8wJs0B
	 t46fWbQB/SvexPdV1DdbDzxiWjEIIlpUze2x6vGyneSpTh9M8vqF5D1q9bJByjJ57BM8V
	 pOywbBjI3c5V6PQxuU1ZgiDzV49Y3wbnRfhzu0OQVZQG/0lRyfkghUA/qVmGyncUkJOer
	 iS8zQ1HdZQ4W7V6Xzp6QSTlK7u+DO0mMZWidMnbdtjIVqWripuJu56ajwmNKu3KOCAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vgvc0PC5;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1454F606A335
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 16:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1454F606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vgvc0PC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795192682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A8m4Gnh8MPzABO/tiaVZwdQcVxLqr3KuTyQbxXbnRDU=;
	b=Vgvc0PC54i9mpraViHhFapT+hh+3vWVzkeLGDqeiSmB92r4aVyuXJXVzCy7tkR1iUn+kcD
	JIjPkgxpOYlq8ScCq5eet5Ut2vUK19p1WjpCYjd+dWx2LmVub4Q88JDB+yusEQJkwAxvs0
	Boq4MT/dIps2tU0cQa6UwAZDD+Pjv08=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-jpiVqjowM3eUVELCo9Tl3w-1; Fri, 20 Nov 2026 16:38:00 +0000
X-MC-Unique: jpiVqjowM3eUVELCo9Tl3w-1
X-Mimecast-MFC-AGG-ID: jpiVqjowM3eUVELCo9Tl3w_1795192678
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4bb680f0ac4so7174265e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 08:37:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795192678; x=1795797478;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A8m4Gnh8MPzABO/tiaVZwdQcVxLqr3KuTyQbxXbnRDU=;
        b=hOLT2iTqxFZuHO+aAgzSE3vTAJbMjcedAEFIijrSGKZaZS05XyUFClfvGgC5MqvdlV
         fao26cmzLzzBrnuufGnWJxJjRDd9eoM+FfjGlqkZV8Ni2sZNy2FCLn+hr7DEJniNa05X
         VZt4/cnP0ud+IMyeb3m/mmVZMIARrvFLj4zKrFJ06+5KfirOtcQ6q5yEVGYHWAk3FWD4
         UeMCjCPwUayW+Ct1F+QrfYbAIaASBFNqmnmD7wFQFPGgc10K9Zm4fDYZH9J51JuC5SUG
         vqU2Pd5GdlIjW0cw9W1lKFf+6inUvygx69evFtUt34Ode7j/nsIenq5v3PquqMnGVQhY
         pSUA==
X-Forwarded-Encrypted: i=1; AL+hErF4eMjR1p5rZiXNrT8oq97YZbSAFMvcVU1n8379xCJl21tzF5wKxb2Z758kHPnqF1n+e/0i5H51ptmGL7r2KQ8yIB0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+T8Yrm+GStbdOmWr7e8HtqVBEZy4TrePbYNrGN0dSqJtzciHsM
	hjXzJIdIy2WGtZhZ7ucMPlEC+G2m3olB5HrnponMnvm2EdVpt4Tm0oIGVEB5uLZgjPpqMnaWLKQ
	3bibRchEiCSpnuPl0VEi7/JLPnJCdX5hEsBIisGiDHhHN+JOzzVEJkobHu8bTn02BoWjNbfJSLp
	/LPIye60uyTxE=
X-Gm-Gg: AYBFou34S0zv9pTTR+eB00blGF7E0l/yTUftiHof1DEvJFGqehOeaM7h9HNwsxdeiNb
	KaaVRALh9Cbq0P2WA8SfqIGIIzxykVgtxKe21zllvI0dpjahZF1xVMpxQ4hTVAar7nJt+P3WmQP
	JMOxeYS2JDrQSZpaxR9uEHEGmlZDN3Y/1h4SK7NFj8f0t0mmkEzz29EZi07WZjgQJtE/0grKcGU
	7/M5Wki5f1RxHjQ8K+VXEBjd8HvWqv3Qaox2ctUYf2DWBMHx/MgAq85QTXn2P3YOdXnmq/8LFRe
	ZeoFM37ascwnofvWMPX0KPvnI1byztTWWxZl5Fg1hc+hYMzk5tny/WoRvqW8nZ0ZuzhUEjRwb1Q
	9ooeuJeqKo9lqgN/t2hUAt5aUPUMUcyFsCIQJkvMz6ob7lioChkFaaq1bd+/w9rqttHoDlYLDMu
	PM
X-Received: by 2002:a05:600c:a0b:b0:4b7:6a8b:9df2 with SMTP id 5b1f17b1804b1-4bb8882432bmr79973625e9.25.1795192678039;
        Fri, 20 Nov 2026 08:37:58 -0800 (PST)
X-Received: by 2002:a05:600c:a0b:b0:4b7:6a8b:9df2 with SMTP id 5b1f17b1804b1-4bb8882432bmr79972945e9.25.1795192677449;
        Fri, 20 Nov 2026 08:37:57 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm78504535e9.0.2026.11.20.08.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:37:56 -0800 (PST)
Message-ID: <df35b9bf6b509a02b96d8aea8224ad538275e356.camel@redhat.com>
Subject: Re: [PATCH v8 11/14] rv: Add tlob hybrid automaton monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 20 Nov 2026 17:37:55 +0100
In-Reply-To: <3471283eefd839c47fdd0fd2cfd6ac4e28a342dc.1793900349.git.wen.yang@linux.dev>
References: <cover.1793900349.git.wen.yang@linux.dev>
	 <3471283eefd839c47fdd0fd2cfd6ac4e28a342dc.1793900349.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oC9qA149Bf3z4YekGuX86tL7OLm66wjsGPzlIv9Vam8_1795192678
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-11-06 at 01:49 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> tlob (task latency over budget) is a per-task hybrid automaton RV
> monitor that tracks wall-clock time across a user-delimited code
> section and emits an error when the elapsed time exceeds a configurable
> budget.
>=20
> The monitor tracks four states (running, waiting, sleeping, stopped)
> driven by sched_switch and sched_wakeup tracepoints.=C2=A0 A single clock
> invariant, clk_elapsed < BUDGET_NS(), is enforced by a per-task hrtimer
> (HRTIMER_MODE_REL_HARD).=C2=A0 On expiry error_env_tlob is emitted; which
> phase consumed the budget (running, waiting or sleeping) is recovered
> from event_tlob in user space.
>=20
> Tasks are registered for monitoring by writing to the tracefs monitor
> file using the ftrace uprobe_events convention:
> =C2=A0 echo "p:myregion /path/to/binary:OFFSET_START OFFSET_STOP threshol=
d=3DNS" \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >> /sys/kernel/tracing/rv/monitors/t=
lob/monitor
>=20
> The per-task monitoring record is embedded directly into struct
> da_monitor_storage via DA_OBJ_EMBEDDED_TYPE, eliminating the need for a
> private mempool, separate RCU reclamation, or parallel OPEN/CLOSED/RETIRE=
D
> states. Window transitions and reentrancy are managed directly by the
> automaton model and framework storage lifecycle.
>=20
> Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---

That's the right direction, I still have a few comments.
Remember the goal here is to keep handlers/constraints as simple as
possible and as close as possible to what rvgen gives, so the source is
an almost direct product of the model.

...

> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 2bc412304293..68f0b9bc2dc3 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -82,6 +82,7 @@ source "kernel/trace/rv/monitors/wakeup/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/stall/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/deadline/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/nomiss/Kconfig"
> +source "kernel/trace/rv/monitors/tlob/Kconfig"

This shouldn't be here, otherwise it's breaking the generation script
for new deadline models.

> =C2=A0# Add new deadline monitors here
> =C2=A0

It should be here (like you had on V7 and like rvgen does).

> =C2=A0# Add new monitors here
> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index 8dc14a1819b8..99a8dceb829f 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_RV_MON_OPID) +=3D monitors/opid/opid.o
> =C2=A0obj-$(CONFIG_RV_MON_STALL) +=3D monitors/stall/stall.o
> =C2=A0obj-$(CONFIG_RV_MON_DEADLINE) +=3D monitors/deadline/deadline.o
> =C2=A0obj-$(CONFIG_RV_MON_NOMISS) +=3D monitors/nomiss/nomiss.o
> +obj-$(CONFIG_RV_MON_TLOB) +=3D monitors/tlob/tlob.o
> =C2=A0obj-$(CONFIG_RV_MON_WAKEUP) +=3D monitors/wakeup/wakeup.o
> =C2=A0# Add new monitors here
> =C2=A0obj-$(CONFIG_RV_UPROBE) +=3D rv_uprobe.o
> diff --git a/kernel/trace/rv/monitors/tlob/Kconfig
> b/kernel/trace/rv/monitors/tlob/Kconfig
> new file mode 100644
> index 000000000000..4f072a9a4da2
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/tlob/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +config RV_MON_TLOB
> +=09bool "tlob monitor"
> +=09depends on RV && UPROBES && HIGH_RES_TIMERS
> +=09select HA_MON_EVENTS_ID
> +=09select RV_UPROBE
> +=09help
> +=09=C2=A0 Enable the tlob (task latency over budget) hybrid-automaton RV
> +=09=C2=A0 monitor.=C2=A0 tlob tracks per-task elapsed time across a
> +=09=C2=A0 user-delimited code section and emits a violation when the
> +=09=C2=A0 elapsed time exceeds a configurable per-invocation budget.
> diff --git a/kernel/trace/rv/monitors/tlob/tlob.c
> b/kernel/trace/rv/monitors/tlob/tlob.c
> new file mode 100644
> index 000000000000..fe7d88df62f1
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/tlob/tlob.c
> @@ -0,0 +1,732 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * tlob (task latency over budget) RV monitor.
> + *
> + * A per-task hybrid automaton that checks a task's elapsed time against
> + * a configurable budget across a user-delimited code section.
> + */
> +#include <linux/ftrace.h>
> +#include <linux/tracepoint.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/rv.h>
> +#include <linux/fs.h>
> +#include <linux/namei.h>
> +#include <linux/security.h>
> +#include <linux/ctype.h>
> +#include <linux/seq_file.h>
> +#include <rv/instrumentation.h>
> +#include <rv/rv_uprobe.h>
> +#include <rv.h>

It seems you're using some includes that aren't quite needed. I can
build fine without fs, seq_file and ctype.

> +
> +#define MODULE_NAME "tlob"
> +
> +#include <rv_trace.h>
> +#include <trace/events/sched.h>
> +
> +struct tlob_uprobe_binding;

Do you really need to forward declare this struct and define it later?
Cannot you just define it here?

> +
> +/*
> + * Per-task monitoring record, embedded directly in struct da_monitor_st=
orage
> + * via DA_OBJ_EMBEDDED_TYPE. Allocated and freed with the storage.
> + */
> +struct tlob_record {
> +=09u64=09=09=09=09threshold_ns;
> +=09struct tlob_uprobe_binding=09*binding;
> +};
> +
> +#define DA_OBJ_EMBEDDED_TYPE struct tlob_record
> +#define RV_MON_TYPE RV_MON_PER_OBJ
> +#define HA_TIMER_TYPE HA_TIMER_HRTIMER
> +#define DA_MON_POOL_SIZE TLOB_MAX_MONITORED
> +#define EVENT_NONE_LBL "budget_exceeded"
> +
> +#include "tlob.h"
> +#include <rv/ha_monitor.h>
> +
> +#define BUDGET_NS(ha_mon) (ha_get_target(ha_mon)->threshold_ns)
> +
> +static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_tlob env,
> +=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 time_ns)
> +{
> +=09if (env =3D=3D clk_elapsed_tlob)
> +=09=09return ha_get_clk_ns(ha_mon, env, time_ns);
> +=09return ENV_INVALID_VALUE;
> +}
> +
> +static void ha_reset_env(struct ha_monitor *ha_mon, enum envs_tlob env,
> +=09=09=09 u64 time_ns)
> +{
> +=09if (env =3D=3D clk_elapsed_tlob)
> +=09=09ha_reset_clk_ns(ha_mon, env, time_ns);
> +}
> +
> +/*
> + * clk_elapsed <=3D BUDGET_NS in running/waiting/sleeping; stopped exemp=
t.
> + */

These functions significantly deviate from rvgen's output mostly for no
reason. That makes it harder to maintain, please stick to what rvgen
gives you with 1 exception (see later).

> +static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
> +=09=09=09=09=09enum states curr_state,
> +=09=09=09=09=09enum events event,
> +=09=09=09=09=09enum states next_state,
> +=09=09=09=09=09u64 time_ns)
> +{
> +=09if (curr_state =3D=3D stopped_tlob)
> +=09=09return true;
> +=09return ha_check_invariant_ns(ha_mon, clk_elapsed_tlob, time_ns,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 BUDGET_NS(ha_mon));
> +}

The reset_env is called by ha_verify_guards(). The compiler should
produce mostly the same code anyway.

> +
> +static inline void ha_setup_invariants(struct ha_monitor *ha_mon,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum events event,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum states next_state,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 time_ns)
> +{

Here you're actually doing some optimisation that does make sense,
please at least keep the original prototype (also curr_state) even if
you don't need all arguments.

I couldn't find a trivial way to represent what you're trying to do here
from the generator. rvgen is a bit too zealous with invariants, arms and
cancels every time, since you have a subgraph sharing the same
invariant, it makes sense to keep it stable.

But let's at least make it /looking like/ what rvgen gives you, then in
the future we can think if rvgen can support this case:

=09static inline void ha_setup_invariants(struct ha_monitor *ha_mon,
=09=09=09=09=09=09   enum states curr_state, enum events event,
=09=09=09=09=09=09   enum states next_state, u64 time_ns)
=09{
=09=09if (next_state =3D=3D curr_state)
=09=09=09return;

=09=09/*
=09=09 * Only a start arms the timer.  Every other transition keeps
=09=09 * the anchor, so the timer already points at the right expiry and
=09=09 * re-arming it would just take the hrtimer base lock on every
=09=09 * scheduler event of a monitored task.
=09=09 */
=09=09if (event =3D=3D start_tlob)
=09=09=09ha_start_timer_ns(ha_mon, clk_elapsed_tlob, BUDGET_NS(ha_mon), tim=
e_ns);
=09=09else if (next_state =3D=3D stopped_tlob)
=09=09=09ha_cancel_timer(ha_mon);
=09}


> +=09if (next_state =3D=3D stopped_tlob) {
> +=09=09ha_cancel_timer(ha_mon);
> +=09=09return;
> +=09}
> +
> +=09/*
> +=09 * Only a start re-anchors the clock.=C2=A0 Every other transition ke=
eps
> +=09 * the anchor, so the timer already points at the right expiry and
> +=09 * re-arming it would just take the hrtimer base lock on every
> +=09 * scheduler event of a monitored task.
> +=09 */
> +=09if (event !=3D start_tlob)
> +=09=09return;
> +
> +=09ha_reset_clk_ns(ha_mon, clk_elapsed_tlob, time_ns);
> +=09ha_start_timer_ns(ha_mon, clk_elapsed_tlob, BUDGET_NS(ha_mon),
> +=09=09=09=C2=A0 time_ns);
> +}
> +
> +static bool ha_verify_constraint(struct ha_monitor *ha_mon,
> +=09=09=09=09 enum states curr_state, enum events event,
> +=09=09=09=09 enum states next_state, u64 time_ns)
> +{
> +=09if (ha_verify_invariants(ha_mon, curr_state, event,
> +=09=09=09=09 next_state, time_ns)) {
> +=09=09ha_setup_invariants(ha_mon, event, next_state, time_ns);
> +=09=09return true;
> +=09}
> +
> +=09/*
> +=09 * The event itself found the budget exceeded, so it reports the
> +=09 * overrun and closes the window.=C2=A0 Without the reset the transit=
ion
> +=09 * would still be taken with the timer left armed, and the expiry
> +=09 * would report the same overrun a second time.
> +=09 */
> +=09da_monitor_reset(&ha_mon->da_mon);
> +=09return false;
> +}

Then you also restore this and you should have equivalent behaviour with
minimal (though justified) modification from rvgen's.

> +
> +/*
> + * One registered uprobe pair. Multiple bindings can be active simultane=
ously
> + * on different binaries or on disjoint ranges of the same binary.
> + */
> +struct tlob_uprobe_binding {
> +=09struct list_head=09=09list;
> +=09char=09=09=09=09name[TLOB_MAX_NAME];
> +=09char=09=09=09=09binpath[TLOB_MAX_PATH];
> +=09loff_t=09=09=09=09offset_start;
> +=09loff_t=09=09=09=09offset_stop;
> +=09u64=09=09=09=09threshold_ns;
> +=09struct path=09=09=09path;
> +=09struct rv_uprobe=09=09start_probe;
> +=09struct rv_uprobe=09=09stop_probe;
> +};
> +
> +static LIST_HEAD(tlob_uprobe_list);
> +static DEFINE_MUTEX(tlob_uprobe_mutex);
> +
> +static int tlob_start_task(struct task_struct *task, u64 threshold_ns,
> +=09=09=09=C2=A0=C2=A0 struct tlob_uprobe_binding *binding)
> +{

This function is over-engineered. Nobody is checking the return value,
why all the reporting?

> +=09struct tlob_record *rec;
> +=09struct da_monitor *da_mon;
> +
> +=09if (!da_monitor_enabled())
> +=09=09return -ENODEV;

Alright, I'd skip this but I see you want to short circuit before doing
any other decisions. This isn't a hot path though.

> +
> +=09if (threshold_ns < TLOB_MIN_THRESHOLD_NS ||
> +=09=C2=A0=C2=A0=C2=A0 threshold_ns > TLOB_MAX_THRESHOLD_NS)
> +=09=09return -ERANGE;

This is functional, should stay.

> +
> +=09scoped_guard(rcu) {
> +=09=09da_mon =3D da_get_monitor(task->pid, NULL);
> +=09=09if (da_mon) {
> +=09=09=09rec =3D da_get_target(da_mon);
> +=09=09=09if (WARN_ON_ONCE(!rec))
> +=09=09=09=09return -ENODEV;
> +=09=09=09/*
> +=09=09=09 * A record left by a removed binding is adopted: the
> +=09=09=09 * task is between windows and nothing owns it.
> +=09=09=09 * Anything else starting it while it still belongs
> to
> +=09=09=09 * another binding would silently shadow that window.
> +=09=09=09 */
> +=09=09=09if (rec->binding && rec->binding !=3D binding) {
> +=09=09=09=09trace_error_tlob(task->pid,
> +=09=09=09=09=09=09 model_get_state_name(da_mon-
> >curr_state),
> +=09=09=09=09=09=09
> model_get_event_name(start_tlob));
> +=09=09=09=09return -EALREADY;
> +=09=09=09}

You aren't supposed to do custom event handling, that can go very wrong
very fast (no reactor, no proper reset, etc.)

> +=09=09=09/*
> +=09=09=09 * A START while the window is still open is a model
> +=09=09=09 * violation (running/waiting/sleeping x start). Hand
> it
> +=09=09=09 * to the model for reporting, but leave the record
> +=09=09=09 * untouched: adopting the new budget here would
> change
> +=09=09=09 * the window that is already running.
> +=09=09=09 */
> +=09=09=09if (da_monitoring(da_mon) &&
> +=09=09=09=C2=A0=C2=A0=C2=A0 READ_ONCE(da_mon->curr_state) !=3D stopped_t=
lob) {
> +=09=09=09=09da_handle_event(task->pid, NULL, start_tlob);
> +=09=09=09=09return -EALREADY;
> +=09=09=09}

The model already does exactly this, I see you don't want to update
before the error but it's mostly duplicated code.

> +=09=09=09rec->binding =3D binding;
> +=09=09=09rec->threshold_ns =3D threshold_ns;
> +=09=09=09/*
> +=09=09=09 * Not da_handle_event(): a violation reset the
> +=09=09=09 * monitor, and a plain event is dropped while
> +=09=09=09 * !da_monitoring(). This restarts it and runs start.
> +=09=09=09 */
> +=09=09=09return da_handle_start_run_event(task->pid, NULL,
> +=09=09=09=09=09=09=09 start_tlob) ? 0 :
> +=09=09=09=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
> ENODEV;
> +=09=09}
> +=09}
> +
> +=09struct tlob_record init_rec =3D {
> +=09=09.threshold_ns =3D threshold_ns,
> +=09=09.binding =3D binding,
> +=09};
> +
> +=09if (da_handle_start_run_event(task->pid, &init_rec, start_tlob))
> +=09=09return 0;
> +
> +=09/*
> +=09 * The framework reports a disabled monitor and an exhausted pool the
> +=09 * same way.=C2=A0 Storage is published only once a pool slot was cla=
imed,
> +=09 * so its absence means the pool is what ran out.
> +=09 */
> +=09scoped_guard(rcu)
> +=09=09da_mon =3D da_get_monitor(task->pid, NULL);
> +=09if (da_mon)
> +=09=09return -ENODEV;
> +
> +=09pr_warn_once("%s: no free record, task %d stays unmonitored\n",
> +=09=09=C2=A0=C2=A0=C2=A0=C2=A0 __stringify(MODULE_NAME), task->pid);
> +=09return -ENOSPC;
> +}

So essentially here you could do pretty much only

=09da_handle_start_run_event(task->pid, &init_rec, start_tlob)

Then you'd lose:
1. Error on a sequential binding
2. Reporting for no free space
3. After unbinding and re-binding, we no longer update

Is 1. really a use case? I suppose you could create a dummy
"start_shadowed" event only possible in an "unreachable" state and
trigger it on every start with different binding, but do you really have
to?

2. is something we may want to report on a framework level. Essentially
we could transform the unlikely(!da_mon) into a WARN_ON_ONCE(!da_mon)
after da_prepare_storage() and be done with it.

3. I would really like to just destroy the storage during unbind and
have the framework fill it again during the next start, I'm afraid that
might require some care though.
If that gets too complicated, I guess it's alright to just override it
when binding is NULL during start and let the model continue with that.

Would this be enough?

> +
> +static int tlob_stop_task(struct task_struct *task,
> +=09=09=09=C2=A0 struct tlob_uprobe_binding *binding)
> +{
> +=09struct tlob_record *rec;
> +=09struct da_monitor *da_mon;
> +
> +=09if (!da_monitor_enabled())
> +=09=09return -ENODEV;
> +
> +=09scoped_guard(rcu) {
> +=09=09da_mon =3D da_get_monitor(task->pid, NULL);
> +=09=09if (!da_mon)
> +=09=09=09return -ESRCH;
> +
> +=09=09rec =3D da_get_target(da_mon);
> +=09=09if (WARN_ON_ONCE(!rec))
> +=09=09=09return -ENODEV;
> +=09=09if (binding && rec->binding && rec->binding !=3D binding)
> +=09=09=09return -EINVAL;

Now I wonder what are all these covering. Why do we need to account for
an invalid event? Can it really happen or are you just being over
cautious? Nobody checks the return value anyway.

I assume this kind of stop during a window happens only for overlapping
windows, which aren't allowed, are they?

> +
> +=09=09/*
> +=09=09 * A budget overrun already closed the window and reset the
> +=09=09 * monitor; the STOP that follows must not report again.
> +=09=09 */
> +=09=09if (!da_monitoring(da_mon))
> +=09=09=09return 0;

Do you really need this? If you aren't monitoring, the model is already
ignoring the event.

> +
> +=09=09da_handle_event(task->pid, NULL, stop_tlob);
> +=09}

All in all in this function I'd really just da_handle_event(), which
should do everything you need. Then always return 0.

> +=09return 0;
> +}
> +
> +static void handle_sched_switch(void *data, bool preempt,
> +=09=09=09=09struct task_struct *prev,
> +=09=09=09=09struct task_struct *next,
> +=09=09=09=09unsigned int prev_state)
> +{
> +=09if (!preempt && prev_state !=3D TASK_RUNNING)
> +=09=09da_handle_event(prev->pid, NULL, sleep_tlob);
> +=09else
> +=09=09da_handle_event(prev->pid, NULL, preempt_tlob);
> +
> +=09da_handle_event(next->pid, NULL, switch_in_tlob);
> +}
> +
> +static void handle_sched_wakeup(void *data, struct task_struct *p)
> +{
> +=09da_handle_event(p->pid, NULL, wakeup_tlob);
> +}
> +
> +static void handle_sched_process_exit(void *data, struct task_struct *p,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool group_dead)
> +{
> +=09da_destroy_storage(p->pid);
> +}
> +
> +static int tlob_uprobe_entry_handler(struct uprobe_consumer *self,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 struct pt_regs *regs, __u64 *data)
> +{
> +=09struct tlob_uprobe_binding *b =3D
> +=09=09container_of(self, struct tlob_uprobe_binding,
> start_probe.uc);
> +
> +=09tlob_start_task(current, b->threshold_ns, b);
> +=09return 0;
> +}
> +
> +static int tlob_uprobe_stop_handler(struct uprobe_consumer *self,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0 struct pt_regs *regs, __u64 *data)
> +{
> +=09struct tlob_uprobe_binding *b =3D
> +=09=09container_of(self, struct tlob_uprobe_binding,
> stop_probe.uc);
> +
> +=09tlob_stop_task(current, b);
> +=09return 0;
> +}
> +
> +/*
> + * tlob_release_binding - stop tracking the windows opened by @binding
> + *
> + * A binding may be removed while tasks are still inside its windows.=C2=
=A0 Their
> + * timers are armed and would report an overrun against a binding that n=
o
> + * longer exists, so reset those monitors once no handler can run anymor=
e.
> + * The record is left in place and its owner cleared: a later START, pos=
sibly
> + * from another binding, adopts and restarts it.
> + *
> + * Runs after rv_uprobe_unregister_sync(), which is what makes the walk =
free
> + * of concurrent writers to rec->binding.
> + */
> +static void tlob_release_binding(struct tlob_uprobe_binding *binding)
> +{
> +=09struct da_monitor_storage *mon_storage;
> +=09int bkt;
> +
> +=09guard(rcu)();
> +=09hash_for_each_rcu(da_monitor_ht, bkt, mon_storage, node) {
> +=09=09struct tlob_record *rec =3D da_get_target(&mon_storage-
> >rv.da_mon);
> +
> +=09=09if (rec && rec->binding =3D=3D binding) {
> +=09=09=09rec->binding =3D NULL;
> +=09=09=09da_monitor_reset(&mon_storage->rv.da_mon);
> +=09=09}
> +=09}
> +}
> +
> +static void tlob_unbind(struct tlob_uprobe_binding *b)
> +{
> +=09rv_uprobe_unregister_nosync(&b->start_probe);
> +=09rv_uprobe_unregister_nosync(&b->stop_probe);
> +=09rv_uprobe_unregister_sync();

I wonder if this further sync should be part of the framework (now
it assumes tracepoints only), but it would probably add some duplicate
waiting.
Leave it for now, but it's something to think about.

> +
> +=09tlob_release_binding(b);
> +
> +=09iput(b->start_probe.inode);
> +=09iput(b->stop_probe.inode);

This is what I meant in the uprobe series, cannot we just pass the
path around and let rv_uprobe handle inodes?

> +=09path_put(&b->path);
> +}
> +
> +static int tlob_remove_uprobe_by_name(const char *name)
> +{
> +=09struct tlob_uprobe_binding *b, *tmp;
> +
> +=09guard(mutex)(&tlob_uprobe_mutex);
> +
> +=09list_for_each_entry_safe(b, tmp, &tlob_uprobe_list, list) {
> +=09=09if (strcmp(b->name, name))
> +=09=09=09continue;
> +=09=09list_del(&b->list);
> +=09=09tlob_unbind(b);
> +=09=09kfree(b);
> +=09=09return 0;
> +=09}
> +
> +=09return -ENOENT;
> +}
> +
> +static void tlob_remove_all_uprobes(void)
> +{
> +=09struct tlob_uprobe_binding *b, *tmp;
> +=09LIST_HEAD(pending);
> +
> +=09guard(mutex)(&tlob_uprobe_mutex);
> +
> +=09list_for_each_entry_safe(b, tmp, &tlob_uprobe_list, list) {
> +=09=09list_move(&b->list, &pending);
> +=09=09rv_uprobe_unregister_nosync(&b->start_probe);
> +=09=09rv_uprobe_unregister_nosync(&b->stop_probe);
> +=09}
> +
> +=09if (list_empty(&pending))
> +=09=09return;
> +
> +=09rv_uprobe_unregister_sync();
> +
> +=09list_for_each_entry_safe(b, tmp, &pending, list) {
> +=09=09list_del(&b->list);
> +=09=09tlob_release_binding(b);
> +=09=09iput(b->start_probe.inode);
> +=09=09iput(b->stop_probe.inode);
> +=09=09path_put(&b->path);
> +=09=09kfree(b);
> +=09}
> +}
> +
> +static int tlob_add_uprobe(const char *name, const char *binpath,
> +=09=09=09=C2=A0=C2=A0 loff_t offset_start, loff_t offset_stop,
> +=09=09=09=C2=A0=C2=A0 u64 threshold_ns)
> +{
> +=09struct tlob_uprobe_binding *tmp_b;
> +=09char pathbuf[TLOB_MAX_PATH];
> +=09struct inode *inode;
> +=09struct path path __free(path_put) =3D {};
> +=09char *canon;
> +=09int ret;
> +
> +=09guard(mutex)(&tlob_uprobe_mutex);
> +
> +=09if (binpath[0] !=3D '/')
> +=09=09return -EINVAL;
> +
> +=09struct tlob_uprobe_binding *b __free(kfree) =3D
> +=09=09kzalloc_obj(*b, GFP_KERNEL);
> +=09if (!b)
> +=09=09return -ENOMEM;
> +
> +=09strscpy(b->name, name, sizeof(b->name));
> +=09b->threshold_ns =3D threshold_ns;
> +=09b->offset_start =3D offset_start;
> +=09b->offset_stop=C2=A0 =3D offset_stop;
> +
> +=09ret =3D kern_path(binpath, LOOKUP_FOLLOW, &path);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09if (!d_is_reg(path.dentry))
> +=09=09return -EINVAL;
> +
> +=09inode =3D d_real_inode(path.dentry);
> +
> +=09/*
> +=09 * Names are unique, and so are ranges on the same binary: a task
> +=09 * runs one window at a time, the second would silently shadow the
> +=09 * first. Direction normalised so a reversed start/stop still
> matches.
> +=09 */
> +=09list_for_each_entry(tmp_b, &tlob_uprobe_list, list) {
> +=09=09loff_t s1, e1, s2, e2;
> +
> +=09=09if (strcmp(tmp_b->name, name) =3D=3D 0)
> +=09=09=09return -EEXIST;
> +=09=09if (!rv_uprobe_is_registered(&tmp_b->start_probe))
> +=09=09=09continue;
> +=09=09if (tmp_b->start_probe.inode !=3D inode)
> +=09=09=09continue;
> +
> +=09=09s1 =3D min(offset_start, offset_stop);
> +=09=09e1 =3D max(offset_start, offset_stop);
> +=09=09s2 =3D min(tmp_b->offset_start, tmp_b->offset_stop);
> +=09=09e2 =3D max(tmp_b->offset_start, tmp_b->offset_stop);
> +=09=09if (s1 <=3D e2 && s2 <=3D e1)
> +=09=09=09return -EEXIST;
> +=09}
> +
> +=09canon =3D d_path(&path, pathbuf, sizeof(pathbuf));
> +=09if (IS_ERR(canon))
> +=09=09return PTR_ERR(canon);
> +=09strscpy(b->binpath, canon, sizeof(b->binpath));
> +
> +=09b->start_probe.uc.handler =3D tlob_uprobe_entry_handler;
> +=09ret =3D rv_uprobe_register(inode, offset_start, &b->start_probe);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09b->stop_probe.uc.handler =3D tlob_uprobe_stop_handler;
> +=09ret =3D rv_uprobe_register(inode, offset_stop, &b->stop_probe);
> +=09if (ret) {
> +=09=09tlob_unbind(b);
> +=09=09return ret;
> +=09}
> +
> +=09b->path =3D path;
> +=09path_get(&b->path);

Do not path_get() to compensate the cleanup, it's confusing.
This is an unconventional one because it isn't a pointer,
apparently to borrow the path you can do memset(&path, 0, sizeof(path))
(what no_free_ptr would do if it were a pointer), see
__trace_uprobe_create() in kernel/trace/trace_uprobe.c , you can copy
the comment from there.


> +
> +=09list_add_tail(&no_free_ptr(b)->list, &tlob_uprobe_list);
> +=09return 0;
> +}
> +
> +static void *tlob_seq_start(struct seq_file *m, loff_t *pos)
> +{
> +=09mutex_lock(&tlob_uprobe_mutex);
> +=09return seq_list_start(&tlob_uprobe_list, *pos);
> +}
> +
> +static void *tlob_seq_next(struct seq_file *m, void *v, loff_t *pos)
> +{
> +=09return seq_list_next(v, &tlob_uprobe_list, pos);
> +}
> +
> +static void tlob_seq_stop(struct seq_file *m, void *v)
> +{
> +=09mutex_unlock(&tlob_uprobe_mutex);
> +}
> +
> +static int tlob_seq_show(struct seq_file *m, void *v)
> +{
> +=09struct tlob_uprobe_binding *b =3D
> +=09=09list_entry(v, struct tlob_uprobe_binding, list);
> +
> +=09seq_printf(m, "p:%s %s:0x%llx 0x%llx threshold=3D%llu\n",
> +=09=09=C2=A0=C2=A0 b->name, b->binpath,
> +=09=09=C2=A0=C2=A0 (unsigned long long)b->offset_start,
> +=09=09=C2=A0=C2=A0 (unsigned long long)b->offset_stop,
> +=09=09=C2=A0=C2=A0 b->threshold_ns);
> +=09return 0;
> +}
> +
> +static const struct seq_operations tlob_monitor_seq_ops =3D {
> +=09.start=09=3D tlob_seq_start,
> +=09.next=09=3D tlob_seq_next,
> +=09.stop=09=3D tlob_seq_stop,
> +=09.show=09=3D tlob_seq_show,
> +};
> +
> +static int tlob_parse_uprobe_line(char *buf, char **name_out, char
> **path_out,
> +=09=09=09=09=C2=A0 loff_t *start_out, loff_t *stop_out,
> +=09=09=09=09=C2=A0 u64 *thr_out)
> +{
> +=09unsigned long long thr =3D 0, stop_val =3D 0;
> +=09long long start_val;
> +=09char *p, *name, *path_token, *token, *colon;
> +=09bool got_stop =3D false, got_thr =3D false;
> +
> +=09if (buf[0] !=3D 'p' || buf[1] !=3D ':')
> +=09=09return -EINVAL;
> +
> +=09p =3D buf + 2;
> +=09while (*p =3D=3D ' ' || *p =3D=3D '\t')
> +=09=09p++;
> +
> +=09name =3D strsep(&p, " \t");
> +=09if (strlen(name) >=3D TLOB_MAX_NAME || !is_good_name(name))
> +=09=09return -EINVAL;
> +
> +=09if (!p)
> +=09=09return -EINVAL;
> +=09while (*p =3D=3D ' ' || *p =3D=3D '\t')
> +=09=09p++;
> +=09path_token =3D strsep(&p, " \t");
> +=09if (!path_token || !*path_token)
> +=09=09return -EINVAL;
> +
> +=09colon =3D strrchr(path_token, ':');
> +=09if (!colon || colon - path_token < 2)
> +=09=09return -EINVAL;
> +=09*colon =3D '\0';
> +
> +=09if (path_token[0] !=3D '/')
> +=09=09return -EINVAL;
> +
> +=09if (kstrtoll(colon + 1, 0, &start_val))
> +=09=09return -EINVAL;
> +=09if (start_val < 0)
> +=09=09return -EINVAL;
> +
> +=09while (p && (token =3D strsep(&p, " \t")) !=3D NULL) {
> +=09=09if (!*token)
> +=09=09=09continue;
> +=09=09if (strncmp(token, "threshold=3D", 10) =3D=3D 0) {
> +=09=09=09if (got_thr)
> +=09=09=09=09return -EINVAL;
> +=09=09=09if (kstrtoull(token + 10, 0, &thr))
> +=09=09=09=09return -EINVAL;
> +=09=09=09if (thr < TLOB_MIN_THRESHOLD_NS ||
> +=09=09=09=C2=A0=C2=A0=C2=A0 thr > TLOB_MAX_THRESHOLD_NS)
> +=09=09=09=09return -ERANGE;
> +=09=09=09got_thr =3D true;
> +=09=09} else if (!got_stop) {
> +=09=09=09long long sv;
> +
> +=09=09=09if (kstrtoll(token, 0, &sv))
> +=09=09=09=09return -EINVAL;
> +=09=09=09if (sv < 0)
> +=09=09=09=09return -EINVAL;
> +=09=09=09stop_val =3D (unsigned long long)sv;
> +=09=09=09got_stop =3D true;
> +=09=09} else {
> +=09=09=09return -EINVAL;
> +=09=09}
> +=09}
> +
> +=09if (!got_stop || !got_thr)
> +=09=09return -EINVAL;
> +=09if (start_val =3D=3D (long long)stop_val)
> +=09=09return -EINVAL;
> +
> +=09*name_out=C2=A0 =3D name;
> +=09*thr_out=C2=A0=C2=A0 =3D thr;
> +=09*path_out=C2=A0 =3D path_token;
> +=09*start_out =3D (loff_t)start_val;
> +=09*stop_out=C2=A0 =3D (loff_t)stop_val;
> +=09return 0;
> +}
> +
> +static int tlob_parse_remove_line(char *buf, char **name_out)
> +{
> +=09char *name =3D buf + 2;
> +
> +=09if (buf[0] !=3D '-' || buf[1] !=3D ':')
> +=09=09return -EINVAL;
> +=09if (strlen(name) >=3D TLOB_MAX_NAME || !is_good_name(name))
> +=09=09return -EINVAL;
> +
> +=09*name_out =3D name;
> +=09return 0;
> +}
> +
> +static int tlob_create_or_delete_uprobe(char *buf)
> +{
> +=09loff_t offset_start, offset_stop;
> +=09u64 threshold_ns;
> +=09char *name, *binpath;
> +=09int ret;
> +
> +=09if (buf[0] =3D=3D '-' && buf[1] =3D=3D ':') {
> +=09=09ret =3D tlob_parse_remove_line(buf, &name);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09return tlob_remove_uprobe_by_name(name);
> +=09}
> +=09ret =3D tlob_parse_uprobe_line(buf, &name, &binpath, &offset_start,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 &offset_stop, &threshold_ns);
> +=09if (ret)
> +=09=09return ret;
> +=09return tlob_add_uprobe(name, binpath, offset_start, offset_stop,
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 threshold_ns);
> +}
> +
> +static ssize_t tlob_monitor_write(struct file *file,
> +=09=09=09=09=C2=A0 const char __user *ubuf,
> +=09=09=09=09=C2=A0 size_t count, loff_t *ppos)
> +{
> +=09char buf[TLOB_MAX_PATH + TLOB_MAX_NAME + 128];
> +
> +=09if (count >=3D sizeof(buf))
> +=09=09return -EINVAL;
> +=09if (copy_from_user(buf, ubuf, count))
> +=09=09return -EFAULT;
> +=09buf[count] =3D '\0';
> +=09if (count > 0 && buf[count - 1] =3D=3D '\n')
> +=09=09buf[count - 1] =3D '\0';
> +=09if (!buf[0])
> +=09=09return count;
> +=09return tlob_create_or_delete_uprobe(buf) ?: (ssize_t)count;
> +}
> +
> +static int tlob_monitor_open(struct inode *inode, struct file *file)
> +{
> +=09int ret;
> +
> +=09ret =3D security_locked_down(LOCKDOWN_TRACEFS);

Umh, that's something we probably want also for the other files, I'm not
too familiar with this thing though.

Thanks,
Gabriele

