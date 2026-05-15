Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC933B992E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838794; cv=none; b=T0g50vFsv1UG4f3d7mQnNtOCr8HNiX9F+b0mKqRqRTRCKZssfZUmQmmJavbWaE6V3R3oNn67w2GsrXyRxEVXKrUs+HM40HJHOKdelBCAZacjXxGpyl4SlXXv8N0TRYATdoLZx1biXSElAQrKK4vps1OxV9VcHpDm3XN8po5sESg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838794; c=relaxed/simple;
	bh=n4AzdDLoQXqpa5kfxYmvw6EapNyGhiwogGiqPBfQFsU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WilRGxOFL8JM9/qz7H/sBdURWbl+6iUQsZkdr5pYgqUykzpC3GvtVTTgKDMMNM99Pw/v2f2PJCMBEJsY5kZlWwIomNfKf2G/3IJRgGP0HHguKeoImTKmcCi07PCB+TvGcZNzb41zmJ29zItBgV3/6ZhbTUX9tqyLIsR0pvpRkTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LyhSKYZ6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyhSKYZ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778838789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fIGcQkciCDvjbgx4giVNkr6AUO8Ss4Pi24B5F2AGcvU=;
	b=LyhSKYZ64Zwmm+4TojxxedDd2ttuFD0srO//UMJJWp5jTiQq+bS6D1ZoKNjxxtRoX5fc9E
	ROBkoAg1f5Lebv9ajPmIN1RLgSclyCUpoF/2egH9bgbwTp+H5AlzXhiYf+FCizJg+OWfzn
	Xqnkb5losj+a9mfvUB/DcXPWiVwO5eU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-rTi_POyHPLu6XCzhcUkXwQ-1; Fri, 15 May 2026 05:53:07 -0400
X-MC-Unique: rTi_POyHPLu6XCzhcUkXwQ-1
X-Mimecast-MFC-AGG-ID: rTi_POyHPLu6XCzhcUkXwQ_1778838787
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48fd8162ed7so13166805e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 02:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778838787; x=1779443587;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xb+kW8gGsNUKOYY11FsPcGc+wbJBPmfXdlj9z1WdN8A=;
        b=PC/SUdpj+4qhiM7/8J4/BjIj5dXJAS5WrMiNcUP6MJrWiw1z5/ALY+UpN9NZTvVhWA
         p2X7gydmN34b3GYzvTdJc/DGkMVE0GSTE2Kqd0eWWeEgY6P/swzt+xyOgXLSpFh/P/mh
         vUkokJiIUj6lgIQuPZYQsyenvb5LN7UtSpCCbvJO6yu6OeDGf+80V2s37r9CPtg+vbMr
         e2LGeZC0rSigczpSakQihmEklwyudKTxdcfCTNDsJHYBxwB+uP2Y28Q3gYhwV7U/KWoD
         +FCYq75qyAqqKsCU0NHQMreq3gpQzC2Ls8EasaDpcUlpPT2wWzCYszuv/8ScjYvullmP
         yWmg==
X-Gm-Message-State: AOJu0YxMwaLNXeTIGMcVb+aEsP5bsthKWC+zn0s84gBkuqjarP2T0EWl
	9AmopBi5QNkxMdDlxsxVs/9x3Ypp+T0Pe7TcjhmG2xY24dVXM6IBiDRJQMAswKTFQk6UAvJSqCd
	O3K0hSq8f9LarE2LJJtLWGipjvRBDI75lG+AyVF9WscRvH9cSCVOOrFRr1jj1RLwm+uPxIbgDSw
	==
X-Gm-Gg: Acq92OGXLdjwIteiDwHwdItF84R/fVfavm6dD4PWXvxvl/dVQT8CQH7YGr3wh4doMMc
	dZy4CAj9d0RxfM9DiWGcNB6icEfJmWaK8FavcuwGhaktaV2jZI9LcSyFd89Q82h+ok9r3q5/LH6
	s0ngfgMQujk4nX6TF5d/q+GRVx0t4UBABpnYkL+vWIIByEZ5y8wI6fTGUBpdJHn1rlf1tazJeY/
	WiN18dWsmqBY97uFrzDqDr81nJDmQlMnAFByWGzLoAoj4OkafkiK/MUpChz8qsEF8iOYgwRWopl
	7w8C6xN8hBzgB4+tC9hCO9a5FC2/r1jGa1qsp/WVFmHZOfRcVfp7nesj2bPWRKHqlMrKl3oxGIa
	41VXnNl47KfU6o5IoTPo4tEt2Hk96RC6KylW7McpSiIc0NefPa78OCdv/195ST2w2TgwIRiZdcE
	2nqcsTzs8fERpNyNHxOHZ/CT9t5A==
X-Received: by 2002:a05:600c:c116:b0:48f:e230:2a22 with SMTP id 5b1f17b1804b1-48fe6632e84mr33418345e9.33.1778838786197;
        Fri, 15 May 2026 02:53:06 -0700 (PDT)
X-Received: by 2002:a05:600c:c116:b0:48f:e230:2a22 with SMTP id 5b1f17b1804b1-48fe6632e84mr33417815e9.33.1778838785272;
        Fri, 15 May 2026 02:53:05 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feb00e5easm11669125e9.13.2026.05.15.02.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:53:04 -0700 (PDT)
Message-ID: <16edc9bc32425af44152892d5d7df50ee32fdb22.camel@redhat.com>
Subject: Re: [RFC PATCH v2 08/10] rv/tlob: add tlob hybrid automaton monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Date: Fri, 15 May 2026 11:53:03 +0200
In-Reply-To: <fe5ed6a9a0a911e6ec74dc06c453786a2c4fb6d1.1778522945.git.wen.yang@linux.dev>
References: <cover.1778522945.git.wen.yang@linux.dev>
	 <fe5ed6a9a0a911e6ec74dc06c453786a2c4fb6d1.1778522945.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: knBpRuXY3rJAQxNiWaXczaYX7iLV5pnGXkw2jr5Oj4o_1778838787
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-12 at 02:24 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Introduce tlob (task latency over budget), a per-task hybrid-automaton
> RV monitor that measures elapsed time (CLOCK_MONOTONIC) across
> a user-delimited code section and fires an error_env_tlob tracepoint
> when the elapsed time exceeds a configurable per-invocation budget.
>=20
> The monitor is built on RV_MON_PER_OBJ with HA_TIMER_HRTIMER.=C2=A0 Three
> states track the scheduler status of the monitored task:
>=20
> =C2=A0 running=C2=A0 --(sleep)-------> sleeping
> =C2=A0 running=C2=A0 --(preempt)-----> waiting
> =C2=A0 sleeping --(wakeup)------> waiting
> =C2=A0 waiting=C2=A0 --(switch_in)--> running
>=20
> A single clock invariant clk_elapsed < BUDGET_NS() is active in all
> three states.=C2=A0 The budget hrtimer is rearmed on each DA transition f=
or
> the remaining budget, keeping the absolute deadline fixed at
> start_time + BUDGET_NS.
>=20
> Per-task state is stored in the DA framework's hash table keyed by
> task->pid.=C2=A0 Storage is pre-allocated by tlob_start_task() with
> GFP_KERNEL via da_create_or_get() before the scheduler tracepoints
> can fire, using DA_SKIP_AUTO_ALLOC so that no kmalloc occurs on the
> tracepoint hot path.=C2=A0 This avoids both the kmalloc_nolock() restrict=
ion
> (requires HAVE_ALIGNED_STRUCT_PAGE) and latency issues under PREEMPT_RT.
>=20
> Nested monitoring is handled by nest_depth: tlob_start_task() on an
> already-monitored pid returns -EEXIST and increments nest_depth without
> disturbing the outer window; only the outermost tlob_stop_task()
> performs real cleanup.
>=20
> Two userspace interfaces are provided.=C2=A0 The ioctl interface exposes
> in-process self-instrumentation via /dev/rv with TLOB_IOCTL_TRACE_START
> and TLOB_IOCTL_TRACE_STOP.=C2=A0 The uprobe interface enables external
> monitoring of unmodified binaries via tracefs:
>=20
> =C2=A0 echo "p PATH:OFFSET_START OFFSET_STOP threshold=3DNS" \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > /sys/kernel/tracing/rv/monitors/tlob/mon=
itor
>=20
> Violations are reported via error_env_tlob (HA clock-invariant)
> regardless of which interface triggered them.
>=20
> Suggested-by: Gabriele Monaco <gmonaco@redhat.com>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---
[...]
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 541ba404926a..1ea91bb3f1c2 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -21,6 +21,13 @@
> =C2=A0#include <linux/list.h>
> =C2=A0#include <linux/types.h>
> =C2=A0
> +/* Forward declaration: poll_table is only needed by rv_chardev_ops::pol=
l.
> + * Avoid pulling in <linux/poll.h> from rv.h =E2=80=94 that header is in=
cluded by
> + * sched.h, and poll.h =E2=86=92 fs.h =E2=86=92 rcupdate.h creates a hea=
der-ordering cycle
> + * with migrate_disable() on UML/non-SMP targets.
> + */
> +struct poll_table_struct;
> +
> =C2=A0/*
> =C2=A0 * Deterministic automaton per-object variables.
> =C2=A0 */
> @@ -158,6 +165,44 @@ int rv_register_monitor(struct rv_monitor *monitor,
> struct rv_monitor *parent);
> =C2=A0int rv_get_task_monitor_slot(void);
> =C2=A0void rv_put_task_monitor_slot(int slot);

Could you have everything that isn't strictly tlob-related in another
patch. This adds the ioctl functionality, can it stay on its own until
you wire it with tlob?

[...]

> diff --git a/include/rv/automata.h b/include/rv/automata.h
> index 4a4eb40cf09a..ae819638d85a 100644
> --- a/include/rv/automata.h
> +++ b/include/rv/automata.h
> @@ -41,6 +41,21 @@ static char *model_get_event_name(enum events event)
> =C2=A0=09return RV_AUTOMATON_NAME.event_names[event];
> =C2=A0}
> =C2=A0
> +/*
> + * model_get_timer_event_name - label used when the HA timer fires (no
> event).
> + *
> + * Monitors may define MONITOR_TIMER_EVENT_NAME before including the mod=
el
> + * header to give the timer-fired violation a semantically meaningful la=
bel
> + * (e.g. "budget_exceeded" for tlob).=C2=A0 Defaults to "none".
> + */
> +#ifndef MONITOR_TIMER_EVENT_NAME
> +#define MONITOR_TIMER_EVENT_NAME "none"
> +#endif

Why don't you just override EVENT_NONE_LBL (and if you prefer call it
MONITOR_TIMER_EVENT_NAME) without the need for another function?

> +static inline char *model_get_timer_event_name(void)
> +{
> +=09return MONITOR_TIMER_EVENT_NAME;
> +}
> +

[...]

> diff --git a/include/rv/rv_uprobe.h b/include/rv/rv_uprobe.h
> index 084cdb36a2ff..9106c5c9275e 100644
> --- a/include/rv/rv_uprobe.h
> +++ b/include/rv/rv_uprobe.h
> @@ -79,9 +79,41 @@ struct rv_uprobe *rv_uprobe_attach(const char *binpath=
,
> loff_t offset,
> =C2=A0 * for any in-progress handler to finish, then releases the path re=
ference
> =C2=A0 * and frees the rv_uprobe struct.=C2=A0 The caller's priv data is =
NOT freed.
> =C2=A0 *
> + * When removing a single probe, prefer this over the three-phase API.
> =C2=A0 * Safe to call from process context only (uprobe_unregister_sync()=
 may
> =C2=A0 * schedule).
> =C2=A0 */
> =C2=A0void rv_uprobe_detach(struct rv_uprobe *p);

Why don't you put all this in the patch about uprobes?

> =C2=A0
> +/**
> + * rv_uprobe_unregister_nosync - dequeue an uprobe without waiting
> + * @p:=C2=A0 probe to dequeue; may be NULL (no-op)
> + *
> + * Removes the uprobe from the uprobe subsystem but does NOT wait for
> + * in-flight handlers to complete.=C2=A0 The caller must call rv_uprobe_=
sync()
> + * before calling rv_uprobe_free() on the same probe.
> + *
> + * Use this to batch multiple deregistrations before a single
> rv_uprobe_sync().
> + */
> +void rv_uprobe_unregister_nosync(struct rv_uprobe *p);
> +
> +/**
> + * rv_uprobe_sync - wait for all in-flight uprobe handlers to complete
> + *
> + * Global barrier: waits for every in-flight uprobe handler across the s=
ystem
> + * to finish.=C2=A0 Call once after a batch of rv_uprobe_unregister_nosy=
nc() calls
> + * and before any rv_uprobe_free() call.
> + */
> +void rv_uprobe_sync(void);
> +
> +/**
> + * rv_uprobe_free - release resources of a previously deregistered probe
> + * @p:=C2=A0 probe to free; may be NULL (no-op)
> + *
> + * Releases the path reference and frees the rv_uprobe struct.=C2=A0 Mus=
t only
> + * be called after rv_uprobe_sync() has returned.=C2=A0 The caller's pri=
v data
> + * is NOT freed.
> + */
> +void rv_uprobe_free(struct rv_uprobe *p);
> +
> =C2=A0#endif /* _RV_UPROBE_H */
> diff --git a/include/uapi/linux/rv.h b/include/uapi/linux/rv.h
> new file mode 100644
> index 000000000000..a34e5426393b
> --- /dev/null
> +++ b/include/uapi/linux/rv.h
> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * UAPI definitions for Runtime Verification (RV) monitors.
> + *
> + * All RV monitors that expose an ioctl self-instrumentation interface
> + * share the magic byte RV_IOC_MAGIC ('r').
> + *
> + * Usage examples and design rationale are in:
> + *=C2=A0=C2=A0 Documentation/trace/rv/monitor_tlob.rst
> + */

Same as above, this could be in a separate patch.

> +
> +#ifndef _UAPI_LINUX_RV_H
> +#define _UAPI_LINUX_RV_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
[...]
> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index f139b904bea3..8a5b5c84aff9 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -2,7 +2,7 @@
> =C2=A0
> =C2=A0ccflags-y +=3D -I $(src)=09=09# needed for trace events
> =C2=A0
> -obj-$(CONFIG_RV) +=3D rv.o
> +obj-$(CONFIG_RV) +=3D rv.o rv_chardev.o

Same here.

> =C2=A0obj-$(CONFIG_RV_MON_WIP) +=3D monitors/wip/wip.o
> =C2=A0obj-$(CONFIG_RV_MON_WWNR) +=3D monitors/wwnr/wwnr.o
> =C2=A0obj-$(CONFIG_RV_MON_SCHED) +=3D monitors/sched/sched.o
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/tlob/Kconfig
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +config RV_MON_TLOB
> +=09depends on RV
> +=09select RV_UPROBE
> +=09select HA_MON_EVENTS_ID
> +=09bool "tlob monitor"
> +=09help
> +=09=C2=A0 Enable the tlob (task latency over budget) monitor.=C2=A0 This=
 monitor
> +=09=C2=A0 tracks the elapsed time (CLOCK_MONOTONIC) of a marked code pat=
h
> +=09=C2=A0 within a task (including both on-CPU and off-CPU time) and rep=
orts
> +=09=C2=A0 a violation when the elapsed time exceeds a configurable budge=
t.
> +
> +=09=C2=A0 The monitor uses a three-state hybrid automaton (running, wait=
ing,
> +=09=C2=A0 sleeping) stored per object using RV_MON_PER_OBJ.=C2=A0 A sing=
le HA
> +=09=C2=A0 clock invariant (clk_elapsed < BUDGET_NS) is enforced in all t=
hree
> +=09=C2=A0 states via a per-task hrtimer.
> +
> +=09=C2=A0 States: running (initial, on-CPU), waiting (in runqueue, off-C=
PU),
> +=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleeping (bloc=
ked on resource, off-CPU).
> +=09=C2=A0 Key transitions:
> +=09=C2=A0=C2=A0=C2=A0 running=C2=A0 --(sleep)------> sleeping
> +=09=C2=A0=C2=A0=C2=A0 running=C2=A0 --(preempt)----> waiting
> +=09=C2=A0=C2=A0=C2=A0 sleeping --(wakeup)-----> waiting
> +=09=C2=A0=C2=A0=C2=A0 waiting=C2=A0 --(switch_in)--> running
> +=09=C2=A0 task_start calls da_handle_start_event() to set the initial st=
ate,
> +=09=C2=A0 then arms the budget timer directly via ha_reset_clk_ns() +
> +=09=C2=A0 ha_start_timer_ns().=C2=A0 task_stop cancels the timer synchro=
nously via
> +=09=C2=A0 ha_cancel_timer_sync() then calls da_monitor_reset().
> +
> +=09=C2=A0 Two userspace interfaces are provided:
> +
> +=09=C2=A0 tracefs uprobe binding (external, unmodified binaries):
> +=09=C2=A0=C2=A0=C2=A0 echo "p PATH:OFFSET_START OFFSET_STOP threshold=3D=
NS" \
> +=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > /sys/kernel/tracing/rv/m=
onitors/tlob/monitor
> +=09=C2=A0 The uprobe at offset_start fires tlob_start_task(); the uprobe=
 at
> +=09=C2=A0 offset_stop fires tlob_stop_task().=C2=A0 Both are plain entry=
 uprobes
> +=09=C2=A0 so a mistyped offset cannot corrupt the call stack.
> +
> +=09=C2=A0 /dev/rv ioctl (in-process self-instrumentation):
> +=09=C2=A0=C2=A0=C2=A0 ioctl(fd, TLOB_IOCTL_TRACE_START, &args);
> +=09=C2=A0=C2=A0=C2=A0 do_critical_work();
> +=09=C2=A0=C2=A0=C2=A0 ret =3D ioctl(fd, TLOB_IOCTL_TRACE_STOP, NULL);
> +=09=C2=A0=C2=A0=C2=A0 /* ret =3D=3D -EOVERFLOW when budget exceeded */
> +=09=C2=A0 Allows conditional monitoring, sub-function granularity, and
> +=09=C2=A0 inline reaction to violations without polling the trace buffer=
.
> +
> +=09=C2=A0 Up to TLOB_MAX_MONITORED tasks may be monitored simultaneously=
.
> +
> +=09=C2=A0 Violations are always reported via the standard error_env_tlob=
 RV
> +=09=C2=A0 tracepoint regardless of which interface triggered them.=C2=A0=
 The
> +=09=C2=A0 tracefs interface requires only tracefs write permissions, avo=
iding
> +=09=C2=A0 the CAP_BPF privilege needed for equivalent eBPF-based approac=
hes.
> +
> +=09=C2=A0 For further information, see:
> +=09=C2=A0=C2=A0=C2=A0 Documentation/trace/rv/monitor_tlob.rst
> +
> +config TLOB_KUNIT_TEST

Do you need to add this here? Since you have a patch adding KUnit tests
to tlob, cannot you put everything kunit-related there?

That's also going to simplify things since RV KUnits aren't stable right
now.

> +=09tristate "KUnit tests for tlob monitor" if !KUNIT_ALL_TESTS

I couldn't build it as module, do we need it that way?

  ERROR: modpost: "sched_setscheduler_nocheck" [kernel/trace/rv/monitors/tl=
ob/tlob_kunit.ko] undefined!

> +=09depends on RV_MON_TLOB && KUNIT
> +=09default KUNIT_ALL_TESTS
> +=09help
> +=09=C2=A0 Enable KUnit in-kernel unit tests for the tlob RV monitor.
> +
> +=09=C2=A0 Tests cover automaton state transitions, the start/stop task
> +=09=C2=A0 interface, scheduler context-switch accounting, and the uprobe
> +=09=C2=A0 format string parser.
> +
> +=09=C2=A0 Say Y or M here to run the tlob KUnit test suite; otherwise sa=
y N.
> diff --git a/kernel/trace/rv/monitors/tlob/tlob.c
> b/kernel/trace/rv/monitors/tlob/tlob.c
> new file mode 100644
> index 000000000000..475e972ae9aa
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/tlob/tlob.c
> @@ -0,0 +1,1307 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * tlob: task latency over budget monitor
> + *
> + * Track the elapsed wall-clock time of a marked code path and detect wh=
en
> + * a monitored task exceeds its per-task latency budget.=C2=A0 CLOCK_MON=
OTONIC
> + * is used so both on-CPU and off-CPU time count toward the budget.
> + *
> + * On a budget violation, two tracepoints are emitted from the hrtimer
> + * callback: error_env_tlob signals the violation, and detail_env_tlob
> + * provides a per-state time breakdown (running_ns, waiting_ns, sleeping=
_ns)
> + * that pinpoints whether the overrun occurred in running, waiting, or
> sleeping state.
> + *
> + * The monitor uses RV_MON_PER_OBJ: per-task state (struct tlob_task_sta=
te)
> + * is stored as monitor_target in the framework's hash table.
> + *
> + * One HA clock invariant is enforced:
> + *=C2=A0=C2=A0 clk_elapsed < BUDGET_NS()=C2=A0=C2=A0 (active in all stat=
es)
> + *
> + * task_start uses da_handle_start_event() to set the initial state, the=
n
> + * calls ha_reset_clk_ns() + ha_start_timer_ns() directly to initialise =
the
> + * clock and arm the budget timer.=C2=A0 No synthetic event is needed.
> + * The HA timer is cancelled synchronously by ha_cancel_timer_sync() in
> + * tlob_stop_task().
> + *
> + * Copyright (C) 2026 Wen Yang <wen.yang@linux.dev>
> + */
> +#include <linux/completion.h>
> +#include <linux/hrtimer.h>
> +#include <linux/kernel.h>
> +#include <linux/ktime.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/namei.h>
> +#include <linux/refcount.h>
> +#include <linux/rv.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/tracefs.h>
> +#include <linux/uaccess.h>
> +#include <kunit/visibility.h>
> +#include <rv/instrumentation.h>
> +#include <rv/rv_uprobe.h>
> +#include <uapi/linux/rv.h>
> +#include "../../rv.h"
> +
> +#define MODULE_NAME "tlob"
> +
> +#include <trace/events/sched.h>
> +#include <rv_trace.h>
> +
> +/*
> + * Per-fd private data; one instance per open /dev/rv fd.
> + * monitoring: set while TRACE_START is active; cleared at TRACE_STOP.
> + * budget_exceeded: set by hrtimer callback; read at TRACE_STOP to repor=
t
> + * -EOVERFLOW even when cleanup was claimed by a concurrent stop_all or
> + * a task-exit handler.
> + */
> +struct tlob_fpriv {
> +=09struct task_struct=09*task;
> +=09bool=09=09=09monitoring;
> +=09bool=09=09=09budget_exceeded;
> +};
> +
> +/*
> + * Per-task latency monitoring state.=C2=A0 One instance per monitoring =
window.
> + * Stored as monitor_target in da_monitor_storage; freed via call_rcu.
> + */
> +struct tlob_task_state {
> +=09struct task_struct=09*task;=09=09/* via get_task_struct */
> +=09u64=09=09=09threshold_us;=09/* budget in microseconds */
> +
> +=09/* 1 =3D cleanup claimed; ha_setup_invariants won't restart the timer=
.
> */
> +=09atomic_t=09=09stopping;
> +
> +=09/* Serialises the ns accumulators; held briefly (hardirq-safe). */
> +=09raw_spinlock_t=09=09entry_lock;
> +=09u64=09=09=09running_ns;=09/* time in running state=C2=A0 */
> +=09u64=09=09=09waiting_ns;=09/* time in waiting state=C2=A0 */
> +=09u64=09=09=09sleeping_ns;=09/* time in sleeping state */
> +=09ktime_t=09=09=09last_ts;
> +
> +=09/* store-release in TRACE_START ioctl, load-acquire in reset_notify.
> */
> +=09struct tlob_fpriv=09*fpriv;
> +
> +=09struct rcu_head=09=09rcu;=09=09/* for call_rcu()
> teardown */
> +};
> +
> +#define RV_MON_TYPE RV_MON_PER_OBJ
> +#define HA_TIMER_TYPE HA_TIMER_HRTIMER
> +/* Pool mode: da_handle_start_event uses da_fill_empty_storage, not kmal=
loc.
> */
> +#define DA_SKIP_AUTO_ALLOC
> +
> +/* Type for da_monitor_storage.target; must be defined before the includ=
es.
> */
> +typedef struct tlob_task_state *monitor_target;
> +
> +/* Forward-declared so da_monitor_reset_hook works before ha_monitor.h. =
*/
> +static inline void tlob_reset_notify(struct da_monitor *da_mon);
> +#define da_monitor_reset_hook tlob_reset_notify
> +
> +/*
> + * When the hrtimer fires (budget elapsed), the HA framework emits
> + * error_env_tlob with this label instead of the generic "none".
> + */
> +#define MONITOR_TIMER_EVENT_NAME "budget_exceeded"
> +
> +#include "tlob.h"
> +#include <rv/ha_monitor.h>
> +
> +/*
> + * Called from da_monitor_reset() on both normal stop and hrtimer expiry=
.
> + * On violation (stopping=3D=3D0), emits detail_env_tlob.
> + */
> +static inline void tlob_reset_notify(struct da_monitor *da_mon)
> +{
> +=09struct ha_monitor *ha_mon =3D to_ha_monitor(da_mon);
> +=09struct tlob_task_state *ws;
> +
> +=09ha_monitor_reset_env(da_mon);
> +
> +=09ws =3D ha_get_target(ha_mon);
> +=09if (!ws)
> +=09=09return;
> +
> +=09/*
> +=09 * Emit per-state breakdown on budget violation only.
> +=09 * stopping=3D=3D0: timer callback owns this path (genuine overrun).
> +=09 * stopping=3D=3D1: normal stop claimed ownership first; skip.
> +=09 */
> +=09if (!atomic_read(&ws->stopping)) {
> +=09=09unsigned int curr_state =3D READ_ONCE(da_mon->curr_state);
> +=09=09u64 running_ns, waiting_ns, sleeping_ns, partial_ns;
> +=09=09struct tlob_fpriv *fp;
> +=09=09unsigned long flags;
> +
> +=09=09/*
> +=09=09 * Snapshot accumulators; partial_ns covers curr_state time
> +=09=09 * not yet folded in (transition-out pending).
> +=09=09 */
> +=09=09raw_spin_lock_irqsave(&ws->entry_lock, flags);
> +=09=09partial_ns=C2=A0=C2=A0 =3D ktime_get_ns() - ktime_to_ns(ws->last_t=
s);
> +=09=09running_ns=C2=A0=C2=A0 =3D ws->running_ns=C2=A0 +
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (curr_state =3D=3D running=
_tlob=C2=A0 ? partial_ns :
> 0);
> +=09=09waiting_ns=C2=A0=C2=A0 =3D ws->waiting_ns=C2=A0 +
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (curr_state =3D=3D waiting=
_tlob=C2=A0 ? partial_ns :
> 0);
> +=09=09sleeping_ns=C2=A0 =3D ws->sleeping_ns +
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (curr_state =3D=3D sleepin=
g_tlob ? partial_ns :
> 0);
> +=09=09raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
> +
> +=09=09trace_detail_env_tlob(da_get_id(da_mon), ws->threshold_us,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 running_ns, waiting_ns, sleep=
ing_ns);
> +
> +=09=09/*
> +=09=09 * Latch violation in the fd so TRACE_STOP can return -
> EOVERFLOW
> +=09=09 * even if a concurrent stop_all or task-exit handler claims
> +=09=09 * cleanup first.=C2=A0 Pairs with smp_store_release in
> TRACE_START.
> +=09=09 */
> +=09=09fp =3D smp_load_acquire(&ws->fpriv);
> +=09=09if (fp)
> +=09=09=09WRITE_ONCE(fp->budget_exceeded, true);
> +=09}
> +}
> +
> +#define BUDGET_US(ha_mon) (ha_get_target(ha_mon)->threshold_us)
> +#define BUDGET_NS(ha_mon) (BUDGET_US(ha_mon) * 1000ULL)
> +
> +/* HA constraint functions (called by ha_monitor_handle_constraint) */
> +
> +static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_tlob env, u64
> time_ns)
> +{
> +=09if (env =3D=3D clk_elapsed_tlob)
> +=09=09return ha_get_clk_ns(ha_mon, env, time_ns);
> +=09return ENV_INVALID_VALUE;
> +}
> +
> +static void ha_reset_env(struct ha_monitor *ha_mon, enum envs_tlob env, =
u64
> time_ns)
> +{
> +=09if (env =3D=3D clk_elapsed_tlob)
> +=09=09ha_reset_clk_ns(ha_mon, env, time_ns);
> +}
> +
> +/*
> + * ha_verify_invariants - clk_elapsed < BUDGET_NS must hold in all state=
s.
> + */
> +static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
> +=09=09=09=09=09enum states curr_state, enum events
> event,
> +=09=09=09=09=09enum states next_state, u64 time_ns)
> +{
> +=09if (curr_state =3D=3D running_tlob)
> +=09=09return ha_check_invariant_ns(ha_mon, clk_elapsed_tlob,
> time_ns);
> +=09else if (curr_state =3D=3D sleeping_tlob)
> +=09=09return ha_check_invariant_ns(ha_mon, clk_elapsed_tlob,
> time_ns);
> +=09else if (curr_state =3D=3D waiting_tlob)
> +=09=09return ha_check_invariant_ns(ha_mon, clk_elapsed_tlob,
> time_ns);
> +=09return true;
> +}
> +
> +/*
> + * Convert invariant (deadline) to guard (reset anchor) on state transit=
ions.
> + * Skip if uninitialised (ENV_INVALID_VALUE): the race between
> + * da_handle_start_event() and ha_reset_clk_ns() would give U64_MAX -
> BUDGET_NS.
> + */
> +static inline void ha_convert_inv_guard(struct ha_monitor *ha_mon,
> +=09=09=09=09=09enum states curr_state, enum events
> event,
> +=09=09=09=09=09enum states next_state, u64 time_ns)
> +{
> +=09if (curr_state =3D=3D next_state)
> +=09=09return;
> +=09if (curr_state =3D=3D running_tlob &&
> +=09=C2=A0=C2=A0=C2=A0 !ha_monitor_env_invalid(ha_mon, clk_elapsed_tlob))
> +=09=09ha_inv_to_guard(ha_mon, clk_elapsed_tlob, BUDGET_NS(ha_mon),
> time_ns);
> +=09else if (curr_state =3D=3D sleeping_tlob &&
> +=09=09 !ha_monitor_env_invalid(ha_mon, clk_elapsed_tlob))
> +=09=09ha_inv_to_guard(ha_mon, clk_elapsed_tlob, BUDGET_NS(ha_mon),
> time_ns);
> +=09else if (curr_state =3D=3D waiting_tlob &&
> +=09=09 !ha_monitor_env_invalid(ha_mon, clk_elapsed_tlob))
> +=09=09ha_inv_to_guard(ha_mon, clk_elapsed_tlob, BUDGET_NS(ha_mon),
> time_ns);
> +}
> +
> +/* No per-event guard conditions for tlob; invariants suffice. */
> +static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0 enum states curr_state, enum events
> event,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0 enum states next_state, u64 time_ns)
> +{
> +=09return true;
> +}
> +
> +/*
> + * Arm or cancel the HA budget timer on state transitions.
> + * Guard on stopping: sched_switch events can arrive after
> ha_cancel_timer_sync,
> + * restarting the timer and triggering an ODEBUG "activate active" splat=
.
> + */
> +static inline void ha_setup_invariants(struct ha_monitor *ha_mon,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum states curr_state,=
 enum events
> event,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum states next_state,=
 u64 time_ns)
> +{
> +=09if (next_state =3D=3D curr_state)
> +=09=09return;
> +=09if (next_state =3D=3D running_tlob) {
> +=09=09if (!atomic_read_acquire(&ha_get_target(ha_mon)->stopping))
> +=09=09=09ha_start_timer_ns(ha_mon, clk_elapsed_tlob,
> BUDGET_NS(ha_mon), time_ns);
> +=09} else if (next_state =3D=3D sleeping_tlob) {
> +=09=09if (!atomic_read_acquire(&ha_get_target(ha_mon)->stopping))
> +=09=09=09ha_start_timer_ns(ha_mon, clk_elapsed_tlob,
> BUDGET_NS(ha_mon), time_ns);
> +=09} else if (next_state =3D=3D waiting_tlob) {
> +=09=09if (!atomic_read_acquire(&ha_get_target(ha_mon)->stopping))
> +=09=09=09ha_start_timer_ns(ha_mon, clk_elapsed_tlob,
> BUDGET_NS(ha_mon), time_ns);
> +=09} else if (curr_state =3D=3D running_tlob)
> +=09=09ha_cancel_timer(ha_mon);
> +=09else if (curr_state =3D=3D waiting_tlob)
> +=09=09ha_cancel_timer(ha_mon);
> +=09else if (curr_state =3D=3D sleeping_tlob)
> +=09=09ha_cancel_timer(ha_mon);
> +}
> +
> +static bool ha_verify_constraint(struct ha_monitor *ha_mon,
> +=09=09=09=09 enum states curr_state, enum events event,
> +=09=09=09=09 enum states next_state, u64 time_ns)
> +{
> +=09if (!ha_verify_invariants(ha_mon, curr_state, event, next_state,
> time_ns))
> +=09=09return false;
> +
> +=09ha_convert_inv_guard(ha_mon, curr_state, event, next_state, time_ns);
> +
> +=09if (!ha_verify_guards(ha_mon, curr_state, event, next_state,
> time_ns))
> +=09=09return false;
> +
> +=09ha_setup_invariants(ha_mon, curr_state, event, next_state, time_ns);
> +
> +=09return true;
> +}
> +
> +static struct kmem_cache *tlob_state_cache;
> +
> +static atomic_t tlob_num_monitored =3D ATOMIC_INIT(0);
> +
> +/* Uprobe binding list; protected by tlob_uprobe_mutex. */
> +static LIST_HEAD(tlob_uprobe_list);
> +static DEFINE_MUTEX(tlob_uprobe_mutex);
> +
> +/*
> + * Serialises duplicate-check + da_create_or_get() to prevent two concur=
rent
> + * callers for the same pid from both inserting into the hash table.
> + */
> +static DEFINE_MUTEX(tlob_start_mutex);
> +
> +/*
> + * Counts open /dev/rv fds plus one synthetic ref held while enabled.
> + * __tlob_destroy_monitor() drops the synthetic ref and waits for zero
> + * before teardown, preventing kmem_cache_zalloc() on a destroyed cache.
> + */
> +static refcount_t tlob_fd_refcount =3D REFCOUNT_INIT(0);
> +static DECLARE_COMPLETION(tlob_fd_released);
> +
> +/* Per-uprobe-binding state: a start + stop probe pair for one binary re=
gion.
> */
> +struct tlob_uprobe_binding {
> +=09struct list_head=09list;
> +=09u64=09=09=09threshold_us;
> +=09char=09=09=09binpath[TLOB_MAX_PATH];
> +=09loff_t=09=09=09offset_start;
> +=09loff_t=09=09=09offset_stop;
> +=09struct rv_uprobe=09*start_probe;
> +=09struct rv_uprobe=09*stop_probe;
> +};
> +
> +/* RCU callback: free the slab once no readers remain. */
> +static void tlob_free_rcu(struct rcu_head *head)
> +{
> +=09struct tlob_task_state *ws =3D
> +=09=09container_of(head, struct tlob_task_state, rcu);
> +=09kmem_cache_free(tlob_state_cache, ws);
> +}
> +
> +/*
> + * handle_sched_switch - advance the DA on every context switch.
> + *
> + * Generates three DA events:
> + *=C2=A0=C2=A0 prev, prev_state !=3D 0=C2=A0 -> sleep_tlob=C2=A0=C2=A0=
=C2=A0 (running -> sleeping)
> + *=C2=A0=C2=A0 prev, prev_state =3D=3D 0=C2=A0 -> preempt_tlob=C2=A0 (ru=
nning -> waiting)
> + *=C2=A0=C2=A0 next=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> switch_in_tlob=
 (waiting -> running)
> + */
> +static void handle_sched_switch(void *data, bool preempt_unused,
> +=09=09=09=09struct task_struct *prev,
> +=09=09=09=09struct task_struct *next,
> +=09=09=09=09unsigned int prev_state)
> +{
> +=09struct tlob_task_state *ws;
> +=09unsigned long flags;
> +=09bool do_prev =3D false, do_next =3D false;
> +=09bool prev_preempted;
> +=09ktime_t now;
> +

Perhaps keep the handler simpler by moving this reporting to a helper
function and use guard(rcu)() there.

> +=09rcu_read_lock();
> +
> +=09ws =3D da_get_target_by_id(prev->pid);
> +=09if (ws) {
> +=09=09raw_spin_lock_irqsave(&ws->entry_lock, flags);
> +=09=09now =3D ktime_get();
> +=09=09ws->running_ns +=3D ktime_to_ns(ktime_sub(now, ws->last_ts));
> +=09=09ws->last_ts =3D now;
> +=09=09/* prev_state =3D=3D 0: TASK_RUNNING (preempted); !=3D 0: sleeping=
.
> */
> +=09=09prev_preempted =3D (prev_state =3D=3D 0);
> +=09=09do_prev =3D true;
> +=09=09raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
> +=09}
> +
> +=09ws =3D da_get_target_by_id(next->pid);
> +=09if (ws) {
> +=09=09raw_spin_lock_irqsave(&ws->entry_lock, flags);
> +=09=09now =3D ktime_get();
> +=09=09ws->waiting_ns +=3D ktime_to_ns(ktime_sub(now, ws->last_ts));
> +=09=09ws->last_ts =3D now;
> +=09=09do_next =3D true;
> +=09=09raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
> +=09}
> +
> +=09rcu_read_unlock();
> +

You probably don't need these. da_handle_event should skip tasks without
a monitor.

> +=09if (do_prev)
> +=09=09da_handle_event(prev->pid, NULL,
> +=09=09=09=09prev_preempted ? preempt_tlob : sleep_tlob);
> +=09if (do_next)
> +=09=09da_handle_event(next->pid, NULL, switch_in_tlob);
> +}
> +
> +/*
> + * handle_sched_wakeup - sleeping -> waiting transition.
> + *
> + * try_to_wake_up() skips TASK_RUNNING tasks, so this never fires for a
> + * task already in running or waiting state.
> + */
> +static void handle_sched_wakeup(void *data, struct task_struct *p)
> +{
> +=09struct tlob_task_state *ws;
> +=09unsigned long flags;
> +=09bool found =3D false;
> +

Same as above to keep the handler simple.

> +=09rcu_read_lock();
> +=09ws =3D da_get_target_by_id(p->pid);
> +=09if (ws) {
> +=09=09ktime_t now =3D ktime_get();
> +
> +=09=09raw_spin_lock_irqsave(&ws->entry_lock, flags);
> +=09=09ws->sleeping_ns +=3D ktime_to_ns(ktime_sub(now, ws->last_ts));
> +=09=09ws->last_ts =3D now;
> +=09=09raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
> +=09=09found =3D true;
> +=09}
> +=09rcu_read_unlock();
> +
> +=09if (found)

You probably don't need this. da_handle_event should skip tasks without
a monitor.

> +=09=09da_handle_event(p->pid, NULL, wakeup_tlob);
> +}
> +
> +/*
> + * handle_sched_process_exit - clean up if a task exits without TRACE_ST=
OP.
> + *
> + * Called in do_exit() context; the task still has a valid pid here.
> + */
> +static void handle_sched_process_exit(void *data, struct task_struct *p,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool group_dead)
> +{
> +=09struct tlob_task_state *ws;
> +=09bool found =3D false;
> +

> +=09rcu_read_lock();
> +=09ws =3D da_get_target_by_id(p->pid);
> +=09found =3D !!ws;
> +=09rcu_read_unlock();
> +
> +=09if (found)

You can skip all this here.

> +=09=09tlob_stop_task(p);
> +}
> +
> +
> +
> +/**
> + * tlob_start_task - begin monitoring @task with budget @threshold_us us=
.
> + * @task:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Task to monito=
r; may be current or another task.
> + * @threshold_us: Latency budget in microseconds (wall-clock; running +
> waiting + sleeping). > 0.
> + *
> + * Returns 0, -ENODEV, -EALREADY, -ENOSPC, or -ENOMEM.
> + */
> +int tlob_start_task(struct task_struct *task, u64 threshold_us)
> +{
> +=09struct tlob_task_state *ws_existing;
> +=09struct tlob_task_state *ws;
> +=09struct da_monitor *da_mon;
> +=09struct ha_monitor *ha_mon;
> +=09u64 now_ns;
> +=09int ret;
> +
> +=09if (!da_monitor_enabled())
> +=09=09return -ENODEV;
> +
> +=09if (threshold_us =3D=3D 0)
> +=09=09return -ERANGE;
> +
> +=09/* Serialise duplicate-check + da_create_or_get for the same pid. */
> +=09guard(mutex)(&tlob_start_mutex);
> +
> +=09rcu_read_lock();

That should be a scoped_guard(rcu), definitely use guards if you have
return paths, the compiler is going to clean up (unlock) for you.

> +=09ws_existing =3D da_get_target_by_id(task->pid);
> +=09if (ws_existing) {
> +=09=09rcu_read_unlock();
> +=09=09return -EALREADY;
> +=09}
> +=09rcu_read_unlock();
> +
> +=09ws =3D kmem_cache_zalloc(tlob_state_cache, GFP_KERNEL);
> +=09if (!ws)
> +=09=09return -ENOMEM;
> +
> +=09ws->task =3D task;
> +=09get_task_struct(task);
> +=09ws->threshold_us =3D threshold_us;
> +=09ws->last_ts =3D ktime_get();
> +=09raw_spin_lock_init(&ws->entry_lock);
> +
> +=09/* Claim a pool slot (no kmalloc; DA_SKIP_AUTO_ALLOC + prealloc). */
> +=09ret =3D da_create_or_get(task->pid, ws);
> +=09if (ret) {
> +=09=09put_task_struct(task);
> +=09=09kmem_cache_free(tlob_state_cache, ws);
> +=09=09return ret;
> +=09}
> +
> +=09atomic_inc(&tlob_num_monitored);
> +
> +=09/* Hold RCU across handle + timer setup to keep da_mon valid. */
> +=09rcu_read_lock();

Same here about guards.
Sadly there doesn't seem to be a cleanup helper for kmem_cache_free,
would be worth adding one. You have also a lot of other things to do
here so it isn't a big deal.

> +=09da_handle_start_event(task->pid, ws, switch_in_tlob);
> +=09da_mon =3D da_get_monitor(task->pid, NULL);
> +=09if (unlikely(!da_mon)) {
> +=09=09/* Slot registered; missing da_mon means concurrent destroy.
> */
> +=09=09rcu_read_unlock();
> +=09=09da_destroy_storage(task->pid);
> +=09=09atomic_dec(&tlob_num_monitored);
> +=09=09put_task_struct(task);
> +=09=09kmem_cache_free(tlob_state_cache, ws);
> +=09=09return -ENOMEM;
> +=09}
> +=09ha_mon =3D to_ha_monitor(da_mon);
> +=09now_ns =3D ktime_get_ns();
> +=09ha_reset_env(ha_mon, clk_elapsed_tlob, now_ns);
> +=09ha_start_timer_ns(ha_mon, clk_elapsed_tlob, BUDGET_NS(ha_mon),
> now_ns);
> +=09rcu_read_unlock();
> +
> +=09return 0;
> +}
> +EXPORT_SYMBOL_GPL(tlob_start_task);
> +
> +/**
> + * tlob_stop_task - stop monitoring @task.
> + * @task: Task to stop.
> + *
> + * CAS on ws->stopping (0->1) under RCU claims cleanup ownership;
> + * the winner cancels the timer synchronously and frees all resources.
> + *
> + * Returns 0, -EOVERFLOW (budget exceeded), -ESRCH (not monitored),
> + * or -EAGAIN (concurrent caller claimed cleanup).
> + */
> +int tlob_stop_task(struct task_struct *task)
> +{
> +=09struct da_monitor *da_mon;
> +=09struct ha_monitor *ha_mon;
> +=09struct tlob_task_state *ws;
> +=09bool budget_exceeded;
> +
> +=09rcu_read_lock();
> +=09ws =3D da_get_target_by_id(task->pid);
> +=09if (!ws) {
> +=09=09rcu_read_unlock();
> +=09=09return -ESRCH;
> +=09}
> +
> +=09da_mon =3D da_get_monitor(task->pid, NULL);
> +=09if (unlikely(!da_mon)) {
> +=09=09/* ws in hash but da_mon gone; internal inconsistency. */
> +=09=09rcu_read_unlock();
> +=09=09WARN_ON_ONCE(1);
> +=09=09return -ESRCH;
> +=09}
> +
> +=09ha_mon =3D to_ha_monitor(da_mon);
> +
> +=09/*
> +=09 * CAS (0->1) claims cleanup ownership under RCU (ws guaranteed
> valid).
> +=09 * _release pairs with atomic_read_acquire in ha_setup_invariants.
> +=09 */
> +=09if (atomic_cmpxchg_release(&ws->stopping, 0, 1) !=3D 0) {
> +=09=09rcu_read_unlock();
> +=09=09return -EAGAIN;
> +=09}
> +
> +=09rcu_read_unlock();
> +
> +=09/* Wait for in-flight timer callback before reading da_monitoring. */
> +=09ha_cancel_timer_sync(ha_mon);
> +
> +=09/* Timer fired first -> budget exceeded; otherwise reset normally. */
> +=09rcu_read_lock();
> +=09budget_exceeded =3D !da_monitoring(da_mon);
> +=09if (!budget_exceeded)
> +=09=09da_monitor_reset(da_mon);
> +=09rcu_read_unlock();
> +=09da_destroy_storage(task->pid);
> +=09atomic_dec(&tlob_num_monitored);
> +
> +=09put_task_struct(ws->task);
> +=09call_rcu(&ws->rcu, tlob_free_rcu);
> +=09return budget_exceeded ? -EOVERFLOW : 0;
> +}
> +EXPORT_SYMBOL_GPL(tlob_stop_task);
> +
> +static void tlob_stop_all(void)
> +{

All this function does should be done by da_monitor_destroy. It does
have some concurrency issues I'm trying to fix, but there's no reason
not to use it.

We could add a way to pass some additional deallocation for all the
other cleanup you're doing on each storage.

Something like a da_extra_cleanup() you can define as whatever you need
and gets called in all per-obj destruction paths.

In general, let's try to use/extend as much as possible in the RV API
rather then re-implementing things.

> +=09struct da_monitor_storage *ms;
> +=09pid_t pids[TLOB_MAX_MONITORED];
> +=09int bkt, n =3D 0;
> +
> +=09/* Snapshot pids under RCU; re-derive ws under a fresh lock below. */
> +=09rcu_read_lock();
> +=09hash_for_each_rcu(da_monitor_ht, bkt, ms, node) {
> +=09=09if (ms->target && n < TLOB_MAX_MONITORED)
> +=09=09=09pids[n++] =3D ms->id;
> +=09}
> +=09rcu_read_unlock();
> +
> +=09for (int i =3D 0; i < n; i++) {
> +=09=09pid_t pid =3D pids[i];
> +=09=09struct da_monitor *da_mon;
> +=09=09struct ha_monitor *ha_mon;
> +=09=09struct tlob_task_state *ws;
> +
> +=09=09rcu_read_lock();
> +=09=09da_mon =3D da_get_monitor(pid, NULL);
> +=09=09if (!da_mon) {
> +=09=09=09/* Cleaned up by tlob_stop_task or exit handler. */
> +=09=09=09rcu_read_unlock();
> +=09=09=09continue;
> +=09=09}
> +
> +=09=09ws =3D da_get_target(da_mon);
> +=09=09ha_mon =3D to_ha_monitor(da_mon);
> +
> +=09=09/* CAS (0->1) claims ownership; skip if another caller won.
> */
> +=09=09if (atomic_cmpxchg_release(&ws->stopping, 0, 1) !=3D 0) {
> +=09=09=09rcu_read_unlock();
> +=09=09=09continue;
> +=09=09}
> +=09=09rcu_read_unlock();
> +
> +=09=09ha_cancel_timer_sync(ha_mon);
> +
> +=09=09scoped_guard(rcu) {
> +=09=09=09da_monitor_reset(da_mon);
> +=09=09}
> +=09=09da_destroy_storage(pid);
> +=09=09atomic_dec(&tlob_num_monitored);
> +=09=09put_task_struct(ws->task);
> +=09=09call_rcu(&ws->rcu, tlob_free_rcu);
> +=09}
> +}
> +
> +static int tlob_uprobe_entry_handler(struct rv_uprobe *p, struct pt_regs
> *regs,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 __u64 *data)
> +{
> +=09struct tlob_uprobe_binding *b =3D p->priv;
> +
> +=09tlob_start_task(current, b->threshold_us);
> +=09return 0;
> +}
> +
> +static int tlob_uprobe_stop_handler(struct rv_uprobe *p, struct pt_regs
> *regs,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0 __u64 *data)
> +{
> +=09tlob_stop_task(current);
> +=09return 0;
> +}
> +
> +/*
> + * Register start + stop entry uprobes for a binding.
> + * Called with tlob_uprobe_mutex held.
> + */
> +static int tlob_add_uprobe(u64 threshold_us, const char *binpath,
> +=09=09=09=C2=A0=C2=A0 loff_t offset_start, loff_t offset_stop)
> +{
> +=09struct tlob_uprobe_binding *b, *tmp_b;
> +=09char pathbuf[TLOB_MAX_PATH];
> +=09struct path path;
> +=09char *canon;
> +=09int ret;
> +
> +=09if (binpath[0] !=3D '/')
> +=09=09return -EINVAL;
> +
> +=09b =3D kzalloc_obj(*b, GFP_KERNEL);
> +=09if (!b)
> +=09=09return -ENOMEM;
> +
> +=09b->threshold_us =3D threshold_us;
> +=09b->offset_start =3D offset_start;
> +=09b->offset_stop=C2=A0 =3D offset_stop;
> +
> +=09ret =3D kern_path(binpath, LOOKUP_FOLLOW, &path);
> +=09if (ret)
> +=09=09goto err_free;
> +
> +=09if (!d_is_reg(path.dentry)) {
> +=09=09ret =3D -EINVAL;
> +=09=09goto err_path;
> +=09}
> +
> +=09/* Reject duplicate start offset for the same binary. */
> +=09list_for_each_entry(tmp_b, &tlob_uprobe_list, list) {
> +=09=09if (tmp_b->offset_start =3D=3D offset_start &&
> +=09=09=C2=A0=C2=A0=C2=A0 tmp_b->start_probe->path.dentry =3D=3D path.den=
try) {
> +=09=09=09ret =3D -EEXIST;
> +=09=09=09goto err_path;
> +=09=09}
> +=09}
> +
> +=09canon =3D d_path(&path, pathbuf, sizeof(pathbuf));
> +=09if (IS_ERR(canon)) {
> +=09=09ret =3D PTR_ERR(canon);
> +=09=09goto err_path;
> +=09}
> +=09strscpy(b->binpath, canon, sizeof(b->binpath));
> +
> +=09/* Both probes share b (priv) and path; attach_path refs path itself.
> */
> +=09b->start_probe =3D rv_uprobe_attach_path(&path, offset_start,
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlob_uprobe_entry_ha=
ndler,
> NULL, b);
> +=09if (IS_ERR(b->start_probe)) {
> +=09=09ret =3D PTR_ERR(b->start_probe);
> +=09=09b->start_probe =3D NULL;
> +=09=09goto err_path;
> +=09}
> +
> +=09b->stop_probe =3D rv_uprobe_attach_path(&path, offset_stop,
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlob_uprobe_stop_handler, =
NULL,
> b);
> +=09if (IS_ERR(b->stop_probe)) {
> +=09=09ret =3D PTR_ERR(b->stop_probe);
> +=09=09b->stop_probe =3D NULL;
> +=09=09goto err_start;
> +=09}
> +
> +=09path_put(&path);
> +=09list_add_tail(&b->list, &tlob_uprobe_list);
> +=09return 0;
> +
> +err_start:
> +=09rv_uprobe_detach(b->start_probe);
> +err_path:
> +=09path_put(&path);
> +err_free:
> +=09kfree(b);
> +=09return ret;
> +}
> +
> +static int tlob_remove_uprobe_by_key(loff_t offset_start, const char
> *binpath)
> +{
> +=09struct tlob_uprobe_binding *b, *tmp;
> +=09struct path remove_path;
> +=09int ret;
> +
> +=09ret =3D kern_path(binpath, LOOKUP_FOLLOW, &remove_path);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09ret =3D -ENOENT;
> +=09list_for_each_entry_safe(b, tmp, &tlob_uprobe_list, list) {
> +=09=09if (b->offset_start !=3D offset_start)
> +=09=09=09continue;
> +=09=09if (b->start_probe->path.dentry !=3D remove_path.dentry)
> +=09=09=09continue;
> +=09=09list_del(&b->list);
> +=09=09rv_uprobe_detach(b->start_probe);
> +=09=09rv_uprobe_detach(b->stop_probe);
> +=09=09kfree(b);
> +=09=09ret =3D 0;
> +=09=09break;
> +=09}
> +
> +=09path_put(&remove_path);
> +=09return ret;
> +}
> +
> +static void tlob_remove_all_uprobes(void)
> +{
> +=09struct tlob_uprobe_binding *b, *tmp;
> +=09LIST_HEAD(pending);
> +
> +=09mutex_lock(&tlob_uprobe_mutex);
> +=09list_for_each_entry_safe(b, tmp, &tlob_uprobe_list, list) {
> +=09=09list_move(&b->list, &pending);
> +=09=09rv_uprobe_unregister_nosync(b->start_probe);
> +=09=09rv_uprobe_unregister_nosync(b->stop_probe);
> +=09}
> +=09mutex_unlock(&tlob_uprobe_mutex);
> +
> +=09if (list_empty(&pending))
> +=09=09return;
> +
> +=09/*
> +=09 * One global barrier for all probes dequeued above; no new handlers
> +=09 * for any of them can fire after this returns.
> +=09 */
> +=09rv_uprobe_sync();
> +
> +=09list_for_each_entry_safe(b, tmp, &pending, list) {
> +=09=09rv_uprobe_free(b->start_probe);
> +=09=09rv_uprobe_free(b->stop_probe);
> +=09=09kfree(b);
> +=09}
> +}
> +
> +static ssize_t tlob_monitor_read(struct file *file,
> +=09=09=09=09 char __user *ubuf,
> +=09=09=09=09 size_t count, loff_t *ppos)
> +{
> +=09const int line_sz =3D TLOB_MAX_PATH + 128;
> +=09struct tlob_uprobe_binding *b;
> +=09char *buf, *p;
> +=09int n =3D 0, buf_sz, pos =3D 0;
> +=09ssize_t ret;
> +
> +=09mutex_lock(&tlob_uprobe_mutex);
> +=09list_for_each_entry(b, &tlob_uprobe_list, list)
> +=09=09n++;
> +
> +=09buf_sz =3D (n ? n : 1) * line_sz + 1;
> +=09buf =3D kmalloc(buf_sz, GFP_KERNEL);
> +=09if (!buf) {
> +=09=09mutex_unlock(&tlob_uprobe_mutex);
> +=09=09return -ENOMEM;
> +=09}
> +
> +=09list_for_each_entry(b, &tlob_uprobe_list, list) {
> +=09=09p =3D b->binpath;
> +=09=09pos +=3D scnprintf(buf + pos, buf_sz - pos,
> +=09=09=09=09 "p %s:0x%llx 0x%llx threshold=3D%llu\n",
> +=09=09=09=09 p,
> +=09=09=09=09 (unsigned long long)b->offset_start,
> +=09=09=09=09 (unsigned long long)b->offset_stop,
> +=09=09=09=09 b->threshold_us);
> +=09}
> +=09mutex_unlock(&tlob_uprobe_mutex);
> +
> +=09ret =3D simple_read_from_buffer(ubuf, count, ppos, buf, pos);
> +=09kfree(buf);
> +=09return ret;
> +}
> +
> +/*
> + * Parse "p PATH:OFFSET_START OFFSET_STOP threshold=3DUS".
> + * PATH may contain ':'; the last ':' separates path from offset.
> + * Returns 0 or -EINVAL.
> + */
> +static int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
> +=09=09=09=09=C2=A0 char **path_out,
> +=09=09=09=09=C2=A0 loff_t *start_out, loff_t *stop_out)
> +{
> +=09unsigned long long thr =3D 0, stop_val =3D 0;
> +=09long long start_val;
> +=09char *p, *path_token, *token, *colon;
> +=09bool got_stop =3D false, got_thr =3D false;
> +=09int n;
> +
> +=09/* Must start with "p " */
> +=09if (buf[0] !=3D 'p' || buf[1] !=3D ' ')
> +=09=09return -EINVAL;
> +
> +=09p =3D buf + 2;
> +=09while (*p =3D=3D ' ')
> +=09=09p++;
> +
> +=09/* First space-delimited token is PATH:OFFSET_START */
> +=09path_token =3D strsep(&p, " \t");
> +=09if (!path_token || !*path_token)
> +=09=09return -EINVAL;
> +
> +=09/* Split at last ':' to handle paths that contain ':'. */
> +=09colon =3D strrchr(path_token, ':');
> +=09if (!colon || colon - path_token < 2)
> +=09=09return -EINVAL;
> +=09*colon =3D '\0';
> +
> +=09if (path_token[0] !=3D '/')
> +=09=09return -EINVAL;
> +
> +=09n =3D 0;
> +=09if (sscanf(colon + 1, "%lli%n", &start_val, &n) !=3D 1 || n =3D=3D 0)
> +=09=09return -EINVAL;
> +=09if (start_val < 0)
> +=09=09return -EINVAL;
> +
> +=09/* Remaining tokens: OFFSET_STOP threshold=3DUS */
> +=09while (p && (token =3D strsep(&p, " \t")) !=3D NULL) {
> +=09=09if (!*token)
> +=09=09=09continue;
> +=09=09if (strncmp(token, "threshold=3D", 10) =3D=3D 0) {
> +=09=09=09if (kstrtoull(token + 10, 0, &thr))
> +=09=09=09=09return -EINVAL;
> +=09=09=09got_thr =3D true;
> +=09=09} else if (!got_stop) {
> +=09=09=09long long sv;
> +
> +=09=09=09n =3D 0;
> +=09=09=09if (sscanf(token, "%lli%n", &sv, &n) !=3D 1 || n =3D=3D 0)
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
> +=09if (!got_stop || !got_thr || thr =3D=3D 0)
> +=09=09return -EINVAL;
> +=09if (start_val =3D=3D (long long)stop_val)
> +=09=09return -EINVAL;
> +
> +=09*thr_out=C2=A0=C2=A0 =3D thr;
> +=09*path_out=C2=A0 =3D path_token;
> +=09*start_out =3D (loff_t)start_val;
> +=09*stop_out=C2=A0 =3D (loff_t)stop_val;
> +=09return 0;
> +}
> +
> +/* Parse "-PATH:OFFSET_START" (ftrace uprobe_events removal convention).=
 */
> +static int tlob_parse_remove_line(char *buf, char **path_out, loff_t
> *start_out)
> +{
> +=09char *binpath, *colon;
> +=09long long off;
> +=09int n =3D 0;
> +
> +=09if (buf[0] !=3D '-')
> +=09=09return -EINVAL;
> +=09binpath =3D buf + 1;
> +=09if (binpath[0] !=3D '/')
> +=09=09return -EINVAL;
> +=09colon =3D strrchr(binpath, ':');
> +=09if (!colon || colon - binpath < 2)
> +=09=09return -EINVAL;
> +=09*colon =3D '\0';
> +=09if (sscanf(colon + 1, "%lli%n", &off, &n) !=3D 1 || n =3D=3D 0)
> +=09=09return -EINVAL;
> +=09*path_out=C2=A0 =3D binpath;
> +=09*start_out =3D (loff_t)off;
> +=09return 0;
> +}
> +
> +VISIBLE_IF_KUNIT int tlob_create_or_delete_uprobe(char *buf)
> +{
> +=09loff_t offset_start, offset_stop;
> +=09u64 threshold_us;
> +=09char *binpath;
> +=09int ret;
> +
> +=09if (buf[0] =3D=3D '-') {
> +=09=09ret =3D tlob_parse_remove_line(buf, &binpath, &offset_start);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09mutex_lock(&tlob_uprobe_mutex);
> +=09=09ret =3D tlob_remove_uprobe_by_key(offset_start, binpath);
> +=09=09mutex_unlock(&tlob_uprobe_mutex);
> +=09=09return ret;
> +=09}
> +=09ret =3D tlob_parse_uprobe_line(buf, &threshold_us, &binpath,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 &offset_start, &offset_stop);
> +=09if (ret)
> +=09=09return ret;
> +=09mutex_lock(&tlob_uprobe_mutex);
> +=09ret =3D tlob_add_uprobe(threshold_us, binpath, offset_start,
> offset_stop);
> +=09mutex_unlock(&tlob_uprobe_mutex);
> +=09return ret;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_create_or_delete_uprobe);
> +
> +static ssize_t tlob_monitor_write(struct file *file,
> +=09=09=09=09=C2=A0 const char __user *ubuf,
> +=09=09=09=09=C2=A0 size_t count, loff_t *ppos)
> +{
> +=09char buf[TLOB_MAX_PATH + 128];
> +
> +=09if (count >=3D sizeof(buf))
> +=09=09return -EINVAL;
> +=09if (copy_from_user(buf, ubuf, count))
> +=09=09return -EFAULT;
> +=09buf[count] =3D '\0';
> +=09if (count > 0 && buf[count - 1] =3D=3D '\n')
> +=09=09buf[count - 1] =3D '\0';
> +=09return tlob_create_or_delete_uprobe(buf) ?: (ssize_t)count;
> +}
> +
> +static const struct file_operations tlob_monitor_fops =3D {
> +=09.open=09=3D simple_open,
> +=09.read=09=3D tlob_monitor_read,
> +=09.write=09=3D tlob_monitor_write,
> +=09.llseek=09=3D noop_llseek,
> +};
> +
> +static int __tlob_init_monitor(void)
> +{
> +=09int retval;
> +
> +=09tlob_state_cache =3D kmem_cache_create("tlob_task_state",
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(struct tlob_task_state),
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 0, 0, NULL);
> +=09if (!tlob_state_cache)
> +=09=09return -ENOMEM;
> +
> +=09atomic_set(&tlob_num_monitored, 0);
> +
> +=09retval =3D da_monitor_init_prealloc(TLOB_MAX_MONITORED);
> +=09if (retval) {
> +=09=09kmem_cache_destroy(tlob_state_cache);
> +=09=09tlob_state_cache =3D NULL;
> +=09=09return retval;
> +=09}
> +
> +=09/* Synthetic reference: held while the monitor is enabled. */
> +=09reinit_completion(&tlob_fd_released);
> +=09refcount_set(&tlob_fd_refcount, 1);
> +
> +=09rv_this.enabled =3D 1;
> +=09return 0;
> +}
> +
> +static void __tlob_destroy_monitor(void)
> +{
> +=09rv_this.enabled =3D 0;
> +=09/*
> +=09 * Remove uprobes first so stop_task can't race with tlob_stop_all().
> +=09 * rv_uprobe_sync() inside ensures all in-flight handlers have
> finished.
> +=09 */
> +=09tlob_remove_all_uprobes();
> +=09tlob_stop_all();
> +=09/* Wait for tlob_free_rcu and da_pool_return_cb before pool teardown.
> */
> +=09synchronize_rcu();
> +
> +=09/*
> +=09 * Drop the synthetic ref and wait for all open fds to close before
> +=09 * teardown; prevents kmem_cache_zalloc() on the destroyed cache.
> +=09 */
> +=09if (!refcount_dec_and_test(&tlob_fd_refcount))
> +=09=09wait_for_completion(&tlob_fd_released);
> +
> +=09da_monitor_destroy();
> +=09kmem_cache_destroy(tlob_state_cache);
> +=09tlob_state_cache =3D NULL;
> +}
> +
> +/* KUnit wrappers that acquire rv_interface_lock around monitor init/des=
troy.
> */
> +#if IS_ENABLED(CONFIG_KUNIT)
> +int tlob_init_monitor(void)
> +{
> +=09int ret;
> +
> +=09mutex_lock(&rv_interface_lock);
> +=09ret =3D __tlob_init_monitor();
> +=09mutex_unlock(&rv_interface_lock);
> +=09return ret;
> +}
> +EXPORT_SYMBOL_GPL(tlob_init_monitor);
> +
> +void tlob_destroy_monitor(void)
> +{
> +=09mutex_lock(&rv_interface_lock);
> +=09__tlob_destroy_monitor();
> +=09mutex_unlock(&rv_interface_lock);
> +}
> +EXPORT_SYMBOL_GPL(tlob_destroy_monitor);
> +
> +int tlob_num_monitored_read(void)
> +{
> +=09return atomic_read(&tlob_num_monitored);
> +}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_num_monitored_read);
> +
> +/* Tracepoint probes for KUnit; rv_trace.h is only included here. */
> +static struct tlob_captured_event=C2=A0=C2=A0=C2=A0=C2=A0 tlob_kunit_las=
t_event;
> +static struct tlob_captured_error_env tlob_kunit_last_error_env;
> +static atomic_t tlob_kunit_event_cnt=C2=A0=C2=A0=C2=A0 =3D ATOMIC_INIT(0=
);
> +static atomic_t tlob_kunit_error_env_cnt =3D ATOMIC_INIT(0);
> +
> +static void tlob_kunit_event_probe(void *data, int id, char *state, char
> *event,
> +=09=09=09=09=C2=A0=C2=A0 char *next_state, bool final_state)
> +{
> +=09tlob_kunit_last_event.id =3D id;
> +=09strscpy(tlob_kunit_last_event.state, state,
> +=09=09sizeof(tlob_kunit_last_event.state));
> +=09strscpy(tlob_kunit_last_event.event, event,
> +=09=09sizeof(tlob_kunit_last_event.event));
> +=09strscpy(tlob_kunit_last_event.next_state, next_state,
> +=09=09sizeof(tlob_kunit_last_event.next_state));
> +=09tlob_kunit_last_event.final_state =3D final_state;
> +=09atomic_inc(&tlob_kunit_event_cnt);
> +}
> +
> +static void tlob_kunit_error_env_probe(void *data, int id, char *state,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *event, char *env)
> +{
> +=09tlob_kunit_last_error_env.id =3D id;
> +=09strscpy(tlob_kunit_last_error_env.state, state,
> +=09=09sizeof(tlob_kunit_last_error_env.state));
> +=09strscpy(tlob_kunit_last_error_env.event, event,
> +=09=09sizeof(tlob_kunit_last_error_env.event));
> +=09strscpy(tlob_kunit_last_error_env.env, env,
> +=09=09sizeof(tlob_kunit_last_error_env.env));
> +=09atomic_inc(&tlob_kunit_error_env_cnt);
> +}
> +
> +int tlob_register_kunit_probes(void)
> +{
> +=09int ret;
> +
> +=09atomic_set(&tlob_kunit_event_cnt, 0);
> +=09atomic_set(&tlob_kunit_error_env_cnt, 0);
> +
> +=09ret =3D register_trace_event_tlob(tlob_kunit_event_probe, NULL);
> +=09if (ret)
> +=09=09return ret;
> +=09ret =3D register_trace_error_env_tlob(tlob_kunit_error_env_probe,
> NULL);
> +=09if (ret) {
> +=09=09unregister_trace_event_tlob(tlob_kunit_event_probe, NULL);
> +=09=09return ret;
> +=09}
> +=09return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_register_kunit_probes);
> +
> +void tlob_unregister_kunit_probes(void)
> +{
> +=09unregister_trace_event_tlob(tlob_kunit_event_probe, NULL);
> +=09unregister_trace_error_env_tlob(tlob_kunit_error_env_probe, NULL);
> +=09tracepoint_synchronize_unregister();
> +}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_unregister_kunit_probes);
> +
> +int tlob_event_count_read(void)
> +{
> +=09return atomic_read(&tlob_kunit_event_cnt);
> +}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_event_count_read);
> +
> +void tlob_event_count_reset(void)
> +{
> +=09atomic_set(&tlob_kunit_event_cnt, 0);
> +}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_event_count_reset);
> +
> +int tlob_error_env_count_read(void)
> +{
> +=09return atomic_read(&tlob_kunit_error_env_cnt);
> +}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_error_env_count_read);
> +
> +void tlob_error_env_count_reset(void)
> +{
> +=09atomic_set(&tlob_kunit_error_env_cnt, 0);
> +}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_error_env_count_reset);
> +
> +const struct tlob_captured_event *tlob_last_event_read(void)
> +{
> +=09return &tlob_kunit_last_event;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_last_event_read);
> +
> +const struct tlob_captured_error_env *tlob_last_error_env_read(void)
> +{
> +=09return &tlob_kunit_last_error_env;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_last_error_env_read);
> +
> +#endif /* CONFIG_KUNIT */
> +
> +VISIBLE_IF_KUNIT int tlob_enable_hooks(void)
> +{
> +=09rv_attach_trace_probe("tlob", sched_switch, handle_sched_switch);
> +=09rv_attach_trace_probe("tlob", sched_wakeup, handle_sched_wakeup);
> +=09rv_attach_trace_probe("tlob", sched_process_exit,
> handle_sched_process_exit);
> +=09return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_enable_hooks);
> +
> +VISIBLE_IF_KUNIT void tlob_disable_hooks(void)
> +{
> +=09rv_detach_trace_probe("tlob", sched_switch, handle_sched_switch);
> +=09rv_detach_trace_probe("tlob", sched_wakeup, handle_sched_wakeup);
> +=09rv_detach_trace_probe("tlob", sched_process_exit,
> handle_sched_process_exit);
> +}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_disable_hooks);
> +
> +static int enable_tlob(void)
> +{
> +=09int retval;
> +
> +=09retval =3D __tlob_init_monitor();
> +=09if (retval)
> +=09=09return retval;
> +
> +=09return tlob_enable_hooks();
> +}
> +
> +static void disable_tlob(void)
> +{
> +=09tlob_disable_hooks();
> +=09__tlob_destroy_monitor();
> +}
> +
> +static struct rv_monitor rv_this =3D {
> +=09.name=09=09=3D "tlob",
> +=09.description=09=3D "Per-task latency-over-budget monitor.",
> +=09.enable=09=09=3D enable_tlob,
> +=09.disable=09=3D disable_tlob,
> +=09.reset=09=09=3D da_monitor_reset_all,
> +=09.enabled=09=3D 0,
> +};
> +
> +static void *tlob_chardev_bind(void)
> +{
> +=09struct tlob_fpriv *fp;
> +
> +=09fp =3D kzalloc_obj(*fp, GFP_KERNEL);
> +=09if (!fp)
> +=09=09return ERR_PTR(-ENOMEM);
> +
> +=09/* Pin cache/pool for fd lifetime; balanced in tlob_chardev_release.
> +=09 * If the synthetic ref has already been dropped
> (__tlob_destroy_monitor
> +=09 * ran to completion), reject the bind so the caller gets ENODEV
> instead
> +=09 * of corrupting a zero refcount.
> +=09 */
> +=09if (!refcount_inc_not_zero(&tlob_fd_refcount)) {
> +=09=09kfree(fp);
> +=09=09return ERR_PTR(-ENODEV);
> +=09}
> +=09return fp;
> +}
> +
> +static void tlob_chardev_release(void *priv)
> +{
> +=09struct tlob_fpriv *fp =3D priv;
> +
> +=09if (fp->monitoring) {
> +=09=09/* All return values are safe on close. */
> +=09=09(void)tlob_stop_task(fp->task);
> +=09=09put_task_struct(fp->task);
> +=09}
> +
> +=09kfree(fp);
> +
> +=09/* Release fd's pin; if last, wake __tlob_destroy_monitor. */
> +=09if (refcount_dec_and_test(&tlob_fd_refcount))
> +=09=09complete(&tlob_fd_released);
> +}
> +
> +static long tlob_chardev_ioctl(void *priv, unsigned int cmd, unsigned lo=
ng
> arg)
> +{
> +=09struct tlob_fpriv *fp =3D priv;
> +=09struct tlob_start_args args;
> +=09struct task_struct *task;
> +=09int ret;
> +
> +=09switch (cmd) {
> +=09case TLOB_IOCTL_TRACE_START:
> +=09=09if (fp->monitoring)
> +=09=09=09return -EALREADY;
> +
> +=09=09if (copy_from_user(&args, (void __user *)arg, sizeof(args)))
> +=09=09=09return -EFAULT;
> +
> +=09=09ret =3D tlob_start_task(current, args.threshold_us);
> +=09=09if (ret)
> +=09=09=09return ret;
> +
> +=09=09fp->task =3D current;
> +=09=09get_task_struct(current);
> +=09=09fp->budget_exceeded =3D false;
> +
> +=09=09/* Link fd so hrtimer callback can latch budget_exceeded. */
> +=09=09scoped_guard(rcu) {
> +=09=09=09struct tlob_task_state *ws =3D
> da_get_target_by_id(current->pid);
> +
> +=09=09=09if (ws)
> +=09=09=09=09smp_store_release(&ws->fpriv, fp);
> +=09=09}
> +
> +=09=09fp->monitoring =3D true;
> +=09=09return 0;
> +
> +=09case TLOB_IOCTL_TRACE_STOP:
> +=09=09if (!fp->monitoring)
> +=09=09=09return -EINVAL;
> +
> +=09=09task =3D fp->task;
> +=09=09fp->monitoring =3D false;
> +=09=09fp->task =3D NULL;
> +
> +=09=09ret =3D tlob_stop_task(task);
> +=09=09put_task_struct(task);
> +
> +=09=09/*
> +=09=09 * -EOVERFLOW: budget exceeded; propagate to caller.
> +=09=09 * -EAGAIN: concurrent stop_all claimed cleanup; fall through
> to
> +=09=09 *=C2=A0=C2=A0 budget_exceeded latch set by the hrtimer callback.
> +=09=09 * -ESRCH: task exited before TRACE_STOP (process-exit
> handler
> +=09=09 *=C2=A0=C2=A0 claimed cleanup); same latch applies.=C2=A0 Not an =
internal
> error.
> +=09=09 */
> +=09=09if (ret =3D=3D -EAGAIN || ret =3D=3D -ESRCH)
> +=09=09=09return READ_ONCE(fp->budget_exceeded) ? -EOVERFLOW :
> 0;
> +=09=09return ret;
> +
> +=09default:
> +=09=09return -ENOTTY;
> +=09}
> +}
> +
> +static const struct rv_chardev_ops tlob_chardev_ops =3D {
> +=09.owner=C2=A0=C2=A0 =3D THIS_MODULE,
> +=09.bind=C2=A0=C2=A0=C2=A0 =3D tlob_chardev_bind,
> +=09.ioctl=C2=A0=C2=A0 =3D tlob_chardev_ioctl,
> +=09.release =3D tlob_chardev_release,
> +};
> +
> +static int __init register_tlob(void)
> +{
> +=09int ret;
> +
> +=09ret =3D rv_chardev_register_monitor("tlob", &tlob_chardev_ops);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09ret =3D rv_register_monitor(&rv_this, NULL);
> +=09if (ret) {
> +=09=09rv_chardev_unregister_monitor("tlob");
> +=09=09return ret;
> +=09}
> +
> +=09if (rv_this.root_d) {
> +=09=09if (!tracefs_create_file("monitor", 0644, rv_this.root_d,
> NULL,
> +=09=09=09=09=09 &tlob_monitor_fops)) {
> +=09=09=09rv_unregister_monitor(&rv_this);
> +=09=09=09rv_chardev_unregister_monitor("tlob");
> +=09=09=09return -ENOMEM;
> +=09=09}
> +=09}
> +
> +=09return 0;
> +}
> +
> +static void __exit unregister_tlob(void)
> +{
> +=09rv_chardev_unregister_monitor("tlob");
> +=09rv_unregister_monitor(&rv_this);
> +}
> +
> +module_init(register_tlob);
> +module_exit(unregister_tlob);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Wen Yang <wen.yang@linux.dev>");
> +MODULE_DESCRIPTION("tlob: task latency over budget per-task monitor.");
> diff --git a/kernel/trace/rv/monitors/tlob/tlob.h
> b/kernel/trace/rv/monitors/tlob/tlob.h
> new file mode 100644
> index 000000000000..71c1735d27d2
> --- /dev/null
[...]
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index ee4e68102f17..a45c4763dbe5 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -142,10 +142,17 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/slab.h>
> +#include <kunit/visibility.h>
> =C2=A0
> =C2=A0#ifdef CONFIG_RV_MON_EVENTS
> =C2=A0#define CREATE_TRACE_POINTS
> =C2=A0#include <rv_trace.h>
> +
> +#ifdef CONFIG_RV_MON_TLOB
> +EXPORT_TRACEPOINT_SYMBOL_GPL(error_tlob);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(event_tlob);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(error_env_tlob);
> +#endif

Cannot this stay in tlob.c ? So you keep the shared file clean and skip
the ifdeffery.

> =C2=A0#endif
> =C2=A0
> =C2=A0#include "rv.h"
> @@ -696,6 +703,33 @@ static void turn_monitoring_on(void)
> =C2=A0=09WRITE_ONCE(monitoring_on, true);
> =C2=A0}
> =C2=A0
> +#if IS_ENABLED(CONFIG_KUNIT)
> +/**
> + * rv_kunit_monitoring_on - enable the global monitoring_on flag for KUn=
it
> tests.
> + *
> + * KUnit test suite_init functions must call this before initialising an=
y
> + * monitor, mirroring the turn_monitoring_on() call in rv_init_interface=
().
> + * The matching rv_kunit_monitoring_off() must be called in suite_exit t=
o
> + * restore the flag so that test suites do not interfere with each other=
.
> + */
> +void rv_kunit_monitoring_on(void)
> +{
> +=09turn_monitoring_on();
> +}
> +EXPORT_SYMBOL_IF_KUNIT(rv_kunit_monitoring_on);
> +
> +/**
> + * rv_kunit_monitoring_off - disable the global monitoring_on flag for K=
Unit
> tests.
> + *
> + * Must be called in suite_exit to restore global state after
> rv_kunit_monitoring_on().
> + */
> +void rv_kunit_monitoring_off(void)
> +{
> +=09turn_monitoring_off();
> +}
> +EXPORT_SYMBOL_IF_KUNIT(rv_kunit_monitoring_off);
> +#endif /* CONFIG_KUNIT */
> +
> =C2=A0static void turn_monitoring_on_with_reset(void)
> =C2=A0{
> =C2=A0=09lockdep_assert_held(&rv_interface_lock);
> @@ -846,6 +880,10 @@ int __init rv_init_interface(void)
> =C2=A0=09if (retval)
> =C2=A0=09=09return 1;
> =C2=A0
> +=09retval =3D rv_chardev_init();
> +=09if (retval)
> +=09=09return 1;
> +

Both of those can stay in separate patches as mentioned above.

> =C2=A0=09turn_monitoring_on();
> =C2=A0
> =C2=A0=09rv_root.root_dir =3D no_free_ptr(root_dir);
> diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
> index 2c0f51ff9d5c..82c9a2b57596 100644
> --- a/kernel/trace/rv/rv.h
> +++ b/kernel/trace/rv/rv.h
> @@ -31,6 +31,8 @@ int rv_enable_monitor(struct rv_monitor *mon);
> =C2=A0bool rv_is_container_monitor(struct rv_monitor *mon);
> =C2=A0bool rv_is_nested_monitor(struct rv_monitor *mon);
> =C2=A0
> +int rv_chardev_init(void);
> +

Same here.

> =C2=A0#ifdef CONFIG_RV_REACTORS
> =C2=A0int reactor_populate_monitor(struct rv_monitor *mon, struct dentry =
*root);
> =C2=A0int init_rv_reactors(struct dentry *root_dir);
> diff --git a/kernel/trace/rv/rv_chardev.c b/kernel/trace/rv/rv_chardev.c
> new file mode 100644
> index 000000000000..1fba1642ebc1
> --- /dev/null
> +++ b/kernel/trace/rv/rv_chardev.c
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0
> +

And here.

> diff --git a/kernel/trace/rv/rv_uprobe.c b/kernel/trace/rv/rv_uprobe.c
> index bc28399cfd4b..1ba7b80c1d87 100644
> --- a/kernel/trace/rv/rv_uprobe.c
> +++ b/kernel/trace/rv/rv_uprobe.c

Also this probably belongs in the uprobes patch.

> @@ -132,13 +132,10 @@ EXPORT_SYMBOL_GPL(rv_uprobe_attach);
> =C2=A0 */
> =C2=A0void rv_uprobe_detach(struct rv_uprobe *p)
> =C2=A0{
> -=09struct rv_uprobe_impl *impl;
> -
> =C2=A0=09if (!p)
> =C2=A0=09=09return;
> =C2=A0
> -=09impl =3D container_of(p, struct rv_uprobe_impl, pub);
> -=09uprobe_unregister_nosync(impl->uprobe, &impl->uc);
> +=09rv_uprobe_unregister_nosync(p);
> =C2=A0=09/*
> =C2=A0=09 * uprobe_unregister_sync() is a global barrier: it waits for al=
l
> =C2=A0=09 * in-flight uprobe handlers across the entire system to complet=
e,
> @@ -146,8 +143,47 @@ void rv_uprobe_detach(struct rv_uprobe *p)
> =C2=A0=09 * guarantees that no handler touching impl->pub.priv is running=
 by
> =C2=A0=09 * the time we return, even if the caller immediately frees priv=
.
> =C2=A0=09 */
> +=09rv_uprobe_sync();
> +=09rv_uprobe_free(p);
> +}
> +EXPORT_SYMBOL_GPL(rv_uprobe_detach);

[...]

> diff --git a/tools/include/uapi/linux/rv.h b/tools/include/uapi/linux/rv.=
h
> new file mode 100644
> index 000000000000..a34e5426393b
> --- /dev/null
> +++ b/tools/include/uapi/linux/rv.h
> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * UAPI definitions for Runtime Verification (RV) monitors.
> + *
> + * All RV monitors that expose an ioctl self-instrumentation interface
> + * share the magic byte RV_IOC_MAGIC ('r').
> + *
> + * Usage examples and design rationale are in:
> + *=C2=A0=C2=A0 Documentation/trace/rv/monitor_tlob.rst
> + */

And this in a new ioctl patch.

> +
> +#ifndef _UAPI_LINUX_RV_H
> +#define _UAPI_LINUX_RV_H

Thanks,
Gabriele

