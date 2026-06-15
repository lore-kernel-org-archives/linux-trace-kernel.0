Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A9A402B82
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537106; cv=none; b=qnqhQMqtKf+a2q0qmkSQ2tYGnOON61JKkRA/TGqsrL1MZAZFmR4tjSHmcVUun7PSKkbpn6VxTgxXi4YesLUn7ubffI+oA5QkArzwWtTtl8LzWRmxN1Pkt3U8VQoZkaonN2Wk01QS4kFh48vYYXSwf9FY/N16PCwv48kxlT1rt/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537106; c=relaxed/simple;
	bh=py9TH3CwKYwdFKihaJqyT6Ij1Pzm2c4vCerSqxSBQgM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZma6RaZmpb8tjPTTxtta7CwqL+9TY4mZ2Hg0VY9srJGcpYHZk10mtL05U2uU7xiYDJQlhM+7lssVW83cAJCibUivbJe4BDYSB98bTOoNQ0FVHxljrTZvC8Oh5e+7moRAUt9BhqAf8Ny0uT7R7j6qVcN7Um/xn9/NJ5VPxOG6BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QpYA7Io1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpYA7Io1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781537103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=py9TH3CwKYwdFKihaJqyT6Ij1Pzm2c4vCerSqxSBQgM=;
	b=QpYA7Io1MHRFvMk/Dc1PPBg4HKbTV6sBa/KJRig19sIaptGdXP6i5FkvgS5IA+wBDDicr7
	ZsG53LP9ZZGT/zqUvYU1I2WF/AjL2kQiyOXBrY67eWojqTerQOanrsG4mNi/AG7xjdU22K
	K1G08Ey6nQ/fIasilxtixl3x8vFju9c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-1ZiDLnMEMSSUkTaBN4Db_A-1; Mon, 15 Jun 2026 11:25:00 -0400
X-MC-Unique: 1ZiDLnMEMSSUkTaBN4Db_A-1
X-Mimecast-MFC-AGG-ID: 1ZiDLnMEMSSUkTaBN4Db_A_1781537099
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso22673065e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 08:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781537099; x=1782141899;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGelwhkJyqKxeswucRsBtBl8YAPqHvPBBn8Hcy3p64k=;
        b=KH8iFqCw6BZWmUx9cX2rlJo0r5263i4Pxwan70lR2aNVnjeFDbLaGXAF0AfpToDjfN
         uS9ggh3teVn4KTwZPwp8fmDPbI/jjhjJqPXJW6e+43gmq+UxW1lYAtjriBPCqzAVkBNR
         EvJ2T4YLV6g5qy4S3e6SetSHqMWo5jeCSjTkH8GivGsskHFr7vcNZItsAY7s2JjMGl6/
         fk3jmk8CjXyBn4F4HVtSJX7wPvdecRIKqkrooD0CEpkLmoe8/9a+Ft7MUl5vqQOKYW2+
         eLsx+tZXyvWTUDnYiJ/GS5wU8Fwi/HGmPPljUJhowhj2ownj/qickt/Fb6W8MQjkGfn0
         ThhQ==
X-Forwarded-Encrypted: i=1; AFNElJ8XUC4YSaMf6SU9Cj7G+HM8MqKtccOeL2/XXACl82wzS7ADjDUdUJaIGLV6d6GGw7/ZvrqXOa7FH1+c2+So0RTP+Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNXCXm6K/iLIDI/1X5lyEpMyCTBB8MNkrvhZw0Qe5EfBPmeBp6
	+3XzVdp6wRgPfD9z8xV/rdPJbL3JQN0YbOVN8MuOxKoMos9o018AwczyviJoWFl4zIBImBSD7C6
	2N37yAyR0ZpnpDFQecih4Wy1uDR7x0Uky70Ly0b3eMxF4eql9RkShu9wcPVdHb64jLsLOIpF9Vg
	==
X-Gm-Gg: Acq92OGXDZhrw/GBZPmo18PgLptu+aJw6gMdf3dN5JtK6Xve6HE1qCSfE1V9gpLA8FY
	QjMFnlPnDMcFcfbIFquUwZ4b/tfvm4fUQhIuPDpChaOI49/y6iMMcdWA/Zo83QB9zTTpxNow9Xx
	bNBIaZg0knqx9qm9BAC7YLDFx7D1ipeT742VnvKPTPcz8615xRMqNQrIhfe9tc4dfXROU1PU1J0
	YfKROKIgJbU+iIOd5Hf1gsDQk5NylSCB2JfKT/3Evb3kEkzE42eVPPG7+LvCQmlkLFL0YqrPBNe
	fEojGQNdP0MTYq0TwKa2fDLvW3rN1fHrCuOwJ3bIyqb9WjELukR7fDB30BrhBKpn3ATog0ria6M
	7L2JK4yeL7yZMENP+FklF3ukSfw==
X-Received: by 2002:a7b:c017:0:b0:48e:6db3:ff2e with SMTP id 5b1f17b1804b1-49220093459mr107021255e9.15.1781537098415;
        Mon, 15 Jun 2026 08:24:58 -0700 (PDT)
X-Received: by 2002:a7b:c017:0:b0:48e:6db3:ff2e with SMTP id 5b1f17b1804b1-49220093459mr107020585e9.15.1781537097618;
        Mon, 15 Jun 2026 08:24:57 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4619b9b7750sm7782687f8f.6.2026.06.15.08.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:24:57 -0700 (PDT)
Message-ID: <04900b5700a2d5d344a60cb346cfffaf4e3d5fa4.camel@redhat.com>
Subject: Re: [PATCH v3 6/9] rv/tlob: add tlob hybrid automaton monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 15 Jun 2026 17:24:55 +0200
In-Reply-To: <629023dbcc4389fcc6ec46d88c98eb19aa0abc36.1780847473.git.wen.yang@linux.dev>
References: <cover.1780847473.git.wen.yang@linux.dev>
	 <629023dbcc4389fcc6ec46d88c98eb19aa0abc36.1780847473.git.wen.yang@linux.dev>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CeRIDKS5hO92emHuLKTiPwuOpkyzRAJz08nwpDhrwAQ_1781537099
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-08 at 00:13 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Add tlob (task latency over budget), a per-task hybrid automaton RV
> monitor that tracks elapsed wall-clock time across a user-delimited
> code section and emits error_env_tlob when the elapsed time exceeds a
> configurable budget.
>=20
> The monitor uses RV_MON_PER_OBJ with three states (running, waiting,
> sleeping) driven by sched_switch and sched_wakeup tracepoints, and a
> single clock invariant clk_elapsed < budget enforced by an hrtimer
> (HRTIMER_MODE_REL_HARD).=C2=A0 On violation, detail_env_tlob provides a
> per-state time breakdown (running_ns, waiting_ns, sleeping_ns).
>=20
> Per-task state is managed via DA_ALLOC_POOL to avoid allocation on
> the
> scheduler tracepoint path.=C2=A0 Uprobe pairs are registered through the
> tracefs monitor file as "p PATH:OFFSET_START OFFSET_STOP
> threshold=3DNS".
>=20
> Also adds ha_cancel_timer_sync() to ha_monitor.h, a blocking cancel
> variant needed by tlob's stop_task path to ensure the hrtimer
> callback
> has completed before the per-task monitor state is freed.
>=20
> Suggested-by: Gabriele Monaco <gmonaco@redhat.com>

I'm not sure this applies to be fair, I'm reviewing the patch and as
part of that I'm suggesting things, but the main idea is yours [1].

Unless you mess up, I'm going to appear as reviewer anyway ;)

[1] - https://www.kernel.org/doc/html/latest/process/submitting-patches.htm=
l#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---

...

> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index e2e0033a00b9..ed2de31d0312 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -85,6 +85,7 @@ source "kernel/trace/rv/monitors/sleep/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/stall/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/deadline/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/nomiss/Kconfig"
> +source "kernel/trace/rv/monitors/tlob/Kconfig"
> =C2=A0# Add new deadline monitors here

Your line should be after the marker for deadline monitors, this is
required for the Kconfig to look good with nested monitors.

Just let rvgen handle the way it looks (V2 was fine, just above the
general monitor marker):

 # Add new deadline monitors here

+source "kernel/trace/rv/monitors/tlob/Kconfig"
 # Add new monitors here

> =C2=A0
> =C2=A0# Add new monitors here

> diff --git a/kernel/trace/rv/monitors/tlob/tlob.c
> b/kernel/trace/rv/monitors/tlob/tlob.c
> new file mode 100644
> index 000000000000..d8e0c4794720
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/tlob/tlob.c
> @@ -0,0 +1,968 @@
> +#include <linux/hrtimer.h>
> +#include <linux/kernel.h>
> +#include <linux/ktime.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/namei.h>
> +#include <linux/rv.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/tracefs.h>
> +#include <kunit/visibility.h>
> +#include <rv/instrumentation.h>
> +#include <rv/rv_uprobe.h>

You added a few includes I don't believe you need: hrtimer, ktime, sched
(included in events/sched) and tracefs (included in rv).

You can keep the others as they come from the template, all monitors
include them anyway.

> +#include "../../rv.h"

This is <rv.h> the includepath allows that just like rv_trace.

> +
> +#define MODULE_NAME "tlob"
> +
> +#include <trace/events/sched.h>
> +#include <rv_trace.h>

...

> +/* Type for da_monitor_storage.target; must be defined before the
> includes. */
> +typedef struct tlob_task_state *monitor_target;
> +
> +/* Forward-declared so da_monitor_reset_hook works before
> ha_monitor.h. */
> +static inline void tlob_reset_notify(struct da_monitor *da_mon);
> +#define da_monitor_reset_hook tlob_reset_notify
> +
> +/* Override EVENT_NONE_LBL so the timer-fired violation shows
> "budget_exceeded". */
> +#define EVENT_NONE_LBL "budget_exceeded"
> +
> +#include "tlob.h"
> +
> +/*
> + * DA_MON_POOL_SIZE must be defined HERE: after tlob.h (which
> defines
> + * TLOB_MAX_MONITORED) and before #include <rv/ha_monitor.h> (which
> + * transitively includes da_monitor.h and expands
> __da_monitor_init_pool
> + * using this macro).=C2=A0 Placing the define before tlob.h or after
> + * ha_monitor.h both cause a build error.
> + */

I don't think you need this comment here. I would add a comment in case
moving it somewhere else would silently change the behaviour, but here
the compiler is going to tell you what isn't defined if you really want
to move it around.

Same for the one line comments above but those are less invasive.

> +#define DA_MON_POOL_SIZE TLOB_MAX_MONITORED
> +
> +/*
> + * Forward-declare tlob_extra_cleanup so the #define below is valid
> when
> + * da_monitor.h (included via ha_monitor.h) expands da_extra_cleanup
> inside
> + * da_monitor_destroy().=C2=A0 The full definition follows after
> ha_monitor.h.
> + */

I'd argue the same here. Though defining da_extra_cleanup() before is
the actual catch (if you do after, the compiler won't tell you it's
using a no-op). If you really want to leave a line for that, feel free
to but I wouldn't be that verbose.
You can combine it to da_monitor_reset_hook() where the same rules
apply.

> +static inline void tlob_extra_cleanup(struct da_monitor *da_mon);
> +#define da_extra_cleanup tlob_extra_cleanup
> +
> +#include <rv/ha_monitor.h>
> +
> +/*
> + * Called from da_monitor_reset() on both normal stop and hrtimer
> expiry.
> + * On violation (stopping=3D=3D0), emits detail_env_tlob.
> + */
> +static inline void tlob_reset_notify(struct da_monitor *da_mon)
> +{
> +=09struct ha_monitor *ha_mon =3D to_ha_monitor(da_mon);
> +=09struct tlob_task_state *ws;
> +
> +=09ha_monitor_reset_env(da_mon);

Could have the rest run only if trace_detail_env_tlob_enabled() and
later use trace_call__detail_env_tlob() (the raw tracepoint without
enabled check).

So if the tracepoint is disabled, this code almost doesn't exist.

> +
> +=09ws =3D ha_get_target(ha_mon);
> +=09if (!ws)
> +=09=09return;
> +
> +=09/*
> +=09 * Emit per-state breakdown on budget violation only.
> +=09 * stopping=3D=3D0: timer callback owns this path (genuine
> overrun).
> +=09 * stopping=3D=3D1: normal stop claimed ownership first; skip.
> +=09 */
> +=09if (!atomic_read(&ws->stopping)) {
> +=09=09unsigned int curr_state =3D READ_ONCE(da_mon-
> >curr_state);
> +=09=09u64 running_ns, waiting_ns, sleeping_ns, partial_ns;
> +=09=09unsigned long flags;
> +
> +=09=09/*
> +=09=09 * Snapshot accumulators; partial_ns covers
> curr_state time
> +=09=09 * not yet folded in (transition-out pending).
> +=09=09 */
> +=09=09raw_spin_lock_irqsave(&ws->entry_lock, flags);
> +=09=09partial_ns=C2=A0=C2=A0 =3D ktime_get_ns() - ktime_to_ns(ws-
> >last_ts);
> +=09=09running_ns=C2=A0=C2=A0 =3D ws->running_ns=C2=A0 +
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (curr_state =3D=3D running=
_tlob=C2=A0 ?
> partial_ns : 0);
> +=09=09waiting_ns=C2=A0=C2=A0 =3D ws->waiting_ns=C2=A0 +
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (curr_state =3D=3D waiting=
_tlob=C2=A0 ?
> partial_ns : 0);
> +=09=09sleeping_ns=C2=A0 =3D ws->sleeping_ns +
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (curr_state =3D=3D sleepin=
g_tlob ?
> partial_ns : 0);
> +=09=09raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
> +
> +=09=09trace_detail_env_tlob(da_get_id(da_mon), ws-
> >threshold_ns,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 running_ns, waiting_ns,
> sleeping_ns);
> +=09}
> +}
> +
> +#define BUDGET_NS(ha_mon) (ha_get_target(ha_mon)->threshold_ns)
> +
> +/* HA constraint functions (called by ha_monitor_handle_constraint)
> */
> +
> +static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_tlob env,
> u64 time_ns)
> +{
> +=09if (env =3D=3D clk_elapsed_tlob)
> +=09=09return ha_get_clk_ns(ha_mon, env, time_ns);
> +=09return ENV_INVALID_VALUE;
> +}

So here you removed ha_reset_env() because that's done implicitly in the
start. It seems to work, but you're going to need to define it if we
apply an automatic reset at start (what I mentioned in the other review).

It's kinda idiomatic to have resets whenever you have clocks, yours is a
special case because you don't really expect start (the only event with a
reset) to happen again.

It's ok to redefine the functions the way you did, though you risk
leaving them out of sync in case you update the model (rvgen's output is
going to be quite different). Not sure if that's ever going to happen
anyway.

> +
> +/*
> + * ha_verify_invariants - clk_elapsed < BUDGET_NS must hold in all
> states.
> + *
> + * The invariant is uniform across running/waiting/sleeping; check
> it
> + * unconditionally rather than enumerating each state.
> + */
> +static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
> +=09=09=09=09=09enum states curr_state, enum
> events event,
> +=09=09=09=09=09enum states next_state, u64
> time_ns)
> +{

The compiler is probably going to produce something not that different
if you keep the ifs, but this is smaller and cleaner. Again, you only
need to track it manually but it looks alright now.

> +=09return ha_check_invariant_ns(ha_mon, clk_elapsed_tlob,
> time_ns);
> +}
> +
> +/*
> + * Convert invariant (deadline) to guard (reset anchor) on state
> transitions.
> + *
> + * The conversion is identical for every departing state; skip only
> self-loops.
> + */
> +static inline void ha_convert_inv_guard(struct ha_monitor *ha_mon,
> +=09=09=09=09=09enum states curr_state, enum
> events event,
> +=09=09=09=09=09enum states next_state, u64
> time_ns)
> +{
> +=09if (curr_state !=3D next_state)
> +=09=09ha_inv_to_guard(ha_mon, clk_elapsed_tlob,
> BUDGET_NS(ha_mon), time_ns);
> +}
> +
> +/* No per-event guard conditions for tlob; invariants suffice. */
> +static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0 enum states curr_state, enum
> events event,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0 enum states next_state, u64
> time_ns)
> +{

Yeah you're not quite using a reset and you probably shouldn't so this
is alright too.

> +=09return true;
> +}
> +
> +/*
> + * Arm or cancel the HA budget timer on state transitions.
> + *
> + * The timer must run in every monitored state
> (running/waiting/sleeping),
> + * so arm it whenever next_state is any of the three.=C2=A0 On a self-
> loop caused
> + * by a non-start event the timer is already running; skip the
> redundant
> + * restart.=C2=A0 On a true state change the old timer is implicitly
> superseded by
> + * the new ha_start_timer_ns() call.
> + *
> + * Guard on stopping: sched_switch events can arrive after
> ha_cancel_timer_sync,
> + * restarting the timer and triggering an ODEBUG "activate active"
> splat.
> + * The _acquire pairs with the cmpxchg_release in tlob_stop_task.
> + */
> +static inline void ha_setup_invariants(struct ha_monitor *ha_mon,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum states curr_state,=
 enum
> events event,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum states next_state,=
 u64
> time_ns)
> +{
> +=09if (next_state =3D=3D curr_state && event !=3D start_tlob)
> +=09=09return;
> +

stopping is only ever set in the cleanup phase, right? You don't really
need to cancel timers because you should have done it already, what
about the slightly more readable:

=09if (atomic_read_acquire(&ha_get_target(ha_mon)->stopping))
=09=09return;
=09if (next_state < state_max_tlob)
=09=09ha_start_timer_ns(ha_mon, clk_elapsed_tlob, BUDGET_NS(ha_mon), time_n=
s);
=09else
=09=09ha_cancel_timer(ha_mon);

> +=09if (next_state < state_max_tlob) {
> +=09=09if (!atomic_read_acquire(&ha_get_target(ha_mon)-
> >stopping))
> +=09=09=09ha_start_timer_ns(ha_mon, clk_elapsed_tlob,
> BUDGET_NS(ha_mon), time_ns);
> +=09} else {
> +=09=09ha_cancel_timer(ha_mon);
> +=09}
> +}

...

> +/*
> + * da_extra_cleanup - per-task teardown called by
> da_monitor_destroy().
> + *
> + * Claims cleanup ownership via CAS; cancels the budget timer;
> decrements the
> + * monitored-task counter; and schedules the slab free via
> call_rcu().
> + * Must run before da_monitor_reset() (i.e. before hash_del_rcu())
> so that
> + * ha_cancel_timer_sync() can safely access the still-registered
> ha_monitor.
> + */
> +static inline void tlob_extra_cleanup(struct da_monitor *da_mon)
> +{
> +=09struct ha_monitor *ha_mon =3D to_ha_monitor(da_mon);
> +=09struct tlob_task_state *ws =3D ha_get_target(ha_mon);
> +
> +=09if (!ws)
> +=09=09return;
> +
> +=09if (atomic_cmpxchg_release(&ws->stopping, 0, 1) !=3D 0)
> +=09=09return;
> +
> +=09ha_cancel_timer_sync(ha_mon);

You shouldn't need to do this since that's standard HA functionality and
is stopped already by the reset + sync RCU sequence.

> +=09put_task_struct(ws->task);
> +=09call_rcu(&ws->rcu, tlob_free_rcu);

And since you can sleep and already waited for a grace period, you can
probably just free now.
This is the same point I had in da_monitor_destroy_pool() vs
da_monitor_destroy_kmalloc(): let's align what we do with sync/RCU.

> +}
> +
> +/*
> + * __tlob_acc - accumulate elapsed ns into one per-state counter.
> + *
> + * Looks up the task's tlob_task_state under RCU, adds the interval
> + * [ws->last_ts, now] to the field at @offset within the state
> struct,
> + * and updates last_ts.=C2=A0 Returns true if the task is monitored.
> + *
> + * entry_lock is a raw spinlock so this is safe from hardirq
> context.
> + */
> +static inline bool __tlob_acc(struct task_struct *task, ktime_t now,
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t offset)
> +{
> +=09struct tlob_task_state *ws;
> +=09unsigned long flags;
> +
> +=09scoped_guard(rcu) {
> +=09=09ws =3D da_get_target_by_id(task->pid);
> +=09=09if (!ws)
> +=09=09=09return false;
> +=09=09raw_spin_lock_irqsave(&ws->entry_lock, flags);
> +=09=09*(u64 *)((char *)ws + offset) +=3D
> ktime_to_ns(ktime_sub(now, ws->last_ts));

I don't really like this, you have a few options to avoid raw pointer
arithmetics:

1. a macro:

=09#define __tlob_acc(task, now, field) do { \
=09=09...
=09=09ws->field +=3D ktime_stuff(now); \
=09=09...
=09}
=09static inline bool tlob_acc_running(struct task_struct *task, ktime_t no=
w)
=09{
=09=09return __tlob_acc(task, now, running_ns);
=09}

2. use an array in the struct and pass the index around:

=09enum tlob_acc {
=09=09running,
=09=09waiting,
=09=09sleeping,
=09=09max,
=09}

=09struct tlob_task_state {
=09=09...
=09=09u64=09=09=09accs_ns[max];
=09=09...
=09};

=09bool __tlob_acc(struct task_struct *task, ktime_t now, enum tlob_acc acc=
)
=09{
=09=09...
=09=09ws->accs_ns[acc] +=3D ktime_stuff(now);
=09=09...
=09}
=09static inline bool tlob_acc_running(struct task_struct *task, ktime_t no=
w)
=09{
=09=09return __tlob_acc(task, now, running);
=09}


Some folks don't like macros, so perhaps options 2 is cleaner.
You may not even need the helper functions since calling the generic
tlob_acc like this is still readable.

If you go down that path, you may also want to simplify the function
using normal (unscoped) guards for both RCU and the lock, since you take
them until the end of the function (won't work with the macro!).

> +=09=09ws->last_ts =3D now;
> +=09=09raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
> +=09}
> +=09return true;
> +}
> +
> +/* Accumulate running_ns for prev; returns true if prev is
> monitored. */
> +static inline bool tlob_acc_running(struct task_struct *task,
> ktime_t now)
> +{
> +=09return __tlob_acc(task, now, offsetof(struct
> tlob_task_state, running_ns));
> +}
> +
> +/* Accumulate waiting_ns for next; returns true if next is
> monitored. */
> +static inline bool tlob_acc_waiting(struct task_struct *task,
> ktime_t now)
> +{
> +=09return __tlob_acc(task, now, offsetof(struct
> tlob_task_state, waiting_ns));
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
> + *
> + * A single ktime_get() at handler entry is shared by both acc calls
> so that
> + * prev's running_ns and next's waiting_ns share the same context-
> switch
> + * timestamp; neither absorbs handler overhead into its accumulator.
> + *
> + * No waiting->sleeping edge exists: a task can only block
> voluntarily
> + * (call schedule()) while it is executing on CPU, which corresponds
> to
> + * the running DA state.=C2=A0 A task in the waiting state is
> TASK_RUNNING in
> + * kernel terms (on the runqueue) and cannot block itself.
> + *
> + * da_handle_event() is called unconditionally: it skips tasks that
> have no
> + * monitor entry in the hash table.
> + */
> +static void handle_sched_switch(void *data, bool preempt_unused,
> +=09=09=09=09struct task_struct *prev,
> +=09=09=09=09struct task_struct *next,
> +=09=09=09=09unsigned int prev_state)
> +{
> +=09ktime_t now =3D ktime_get();
> +=09bool prev_preempted =3D (prev_state =3D=3D 0);
> +
> +=09/*
> +=09 * No guard on tlob_num_monitored here: da_handle_event()
> internally
> +=09 * calls da_monitor_handling_event() which checks both
> rv_monitoring_on()
> +=09 * and da_monitoring(da_mon).=C2=A0 The hash lookup inside
> da_get_monitor()
> +=09 * simply returns NULL for unmonitored tasks, which is
> equally fast as
> +=09 * an atomic_read() guard.=C2=A0 By omitting the guard we avoid
> touching the
> +=09 * tlob_num_monitored cacheline on every global context-
> switch.
> +=09 */
> +=09if (tlob_acc_running(prev, now))
> +=09=09da_handle_event(prev->pid, NULL,
> +=09=09=09=09prev_preempted ? preempt_tlob :
> sleep_tlob);
> +=09if (tlob_acc_waiting(next, now))
> +=09=09da_handle_event(next->pid, NULL, switch_in_tlob);
> +}
> +
> +/* Accumulate sleeping_ns on wakeup; returns true if task is
> monitored. */
> +static inline bool tlob_acc_sleeping(struct task_struct *task,
> ktime_t now)
> +{
> +=09return __tlob_acc(task, now, offsetof(struct
> tlob_task_state, sleeping_ns));
> +}
> +
> +/*
> + * handle_sched_wakeup - sleeping -> waiting transition.
> + *
> + * try_to_wake_up() skips TASK_RUNNING tasks, so this never fires
> for a
> + * task already in running or waiting state.
> + */
> +static void handle_sched_wakeup(void *data, struct task_struct *p)
> +{
> +=09ktime_t now =3D ktime_get();
> +
> +=09/* Same reasoning as handle_sched_switch: rely on hash-
> lookup fast path. */
> +=09if (tlob_acc_sleeping(p, now))
> +=09=09da_handle_event(p->pid, NULL, wakeup_tlob);
> +}
> +
> +/*
> + * handle_sched_process_exit - clean up if a task exits without
> TRACE_STOP.
> + *
> + * Called in do_exit() context; the task still has a valid pid here.
> + * tlob_stop_task() returns -ESRCH if the task is not monitored,
> which is fine.
> + */
> +static void handle_sched_process_exit(void *data, struct task_struct
> *p,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool group_dead)
> +{
> +=09tlob_stop_task(p);
> +}
> +
> +
> +
> +/**
> + * tlob_start_task - begin monitoring @task with budget
> @threshold_ns ns.
> + * @task:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Task to monito=
r; may be current or another task.
> + * @threshold_ns: Latency budget in nanoseconds (wall-clock; running
> + waiting + sleeping).
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Must be in [1000, TLOB_MAX_THRESHOLD_NS].
> + *
> + * Returns 0, -ENODEV, -ERANGE, -EALREADY, -ENOMEM, or -ENOSPC.
> + */
> +int tlob_start_task(struct task_struct *task, u64 threshold_ns)
> +{
> +=09struct tlob_task_state *ws;
> +
> +=09if (!da_monitor_enabled())
> +=09=09return -ENODEV;
> +
> +=09if (threshold_ns < 1000 || threshold_ns >

Why not some TLOB_MIN_THRESHOLD_NS (that can of course be 1000)?

> TLOB_MAX_THRESHOLD_NS)
> +=09=09return -ERANGE;
> +
> +=09/* Serialise duplicate-check + pool-slot claim for the same
> pid. */
> +=09guard(mutex)(&tlob_start_mutex);
> +
> +=09if (da_get_target_by_id(task->pid))
> +=09=09return -EALREADY;
> +
> +=09ws =3D kmem_cache_zalloc(tlob_state_cache, GFP_KERNEL);
> +=09if (!ws)
> +=09=09return -ENOMEM;
> +
> +=09ws->task =3D task;
> +=09get_task_struct(task);
> +=09ws->threshold_ns =3D threshold_ns;
> +=09ws->last_ts =3D ktime_get();
> +=09raw_spin_lock_init(&ws->entry_lock);
> +
> +=09/*
> +=09 * da_handle_start_run_event() claims a pool slot via
> da_prepare_storage(),
> +=09 * initialises the monitor, and delivers start_tlob in one
> step: the
> +=09 * generated ha_setup_invariants() resets clk_elapsed and
> arms the timer.
> +=09 * Returns 0 if the pool is exhausted (-ENOSPC).
> +=09 */
> +=09if (!da_handle_start_run_event(task->pid, ws, start_tlob)) {
> +=09=09put_task_struct(task);
> +=09=09kmem_cache_free(tlob_state_cache, ws);
> +=09=09return -ENOSPC;
> +=09}
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
> + * the winner cancels the timer synchronously and frees all
> resources.
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
> +=09scoped_guard(rcu) {
> +=09=09ws =3D da_get_target_by_id(task->pid);
> +=09=09if (!ws)
> +=09=09=09return -ESRCH;
> +
> +=09=09da_mon =3D da_get_monitor(task->pid, NULL);
> +=09=09if (unlikely(!da_mon)) {
> +=09=09=09/* ws in hash but da_mon gone; internal
> inconsistency. */
> +=09=09=09WARN_ON_ONCE(1);

=09if (unlikely(WARN_ON_ONCE(!da_mon)))

> +=09=09=09return -ESRCH;
> +=09=09}
> +
> +=09=09ha_mon =3D to_ha_monitor(da_mon);
> +
> +=09=09/*
> +=09=09 * CAS (0->1) claims cleanup ownership under RCU (ws
> guaranteed valid).
> +=09=09 * _release pairs with atomic_read_acquire in
> ha_setup_invariants.
> +=09=09 */
> +=09=09if (atomic_cmpxchg_release(&ws->stopping, 0, 1) !=3D
> 0)
> +=09=09=09return -EAGAIN;
> +=09}
> +
> +=09/* Wait for in-flight timer callback before reading
> da_monitoring. */
> +=09ha_cancel_timer_sync(ha_mon);
> +
> +=09/* Timer fired first -> budget exceeded; otherwise reset
> normally. */
> +=09scoped_guard(rcu) {
> +=09=09budget_exceeded =3D !da_monitoring(da_mon);
> +=09=09if (!budget_exceeded)
> +=09=09=09da_monitor_reset(da_mon);
> +=09}
> +=09da_destroy_storage(task->pid);
> +
> +=09put_task_struct(ws->task);
> +=09call_rcu(&ws->rcu, tlob_free_rcu);
> +=09return budget_exceeded ? -EOVERFLOW : 0;
> +}
> +EXPORT_SYMBOL_GPL(tlob_stop_task);
> +
> +
> +static int tlob_uprobe_entry_handler(struct rv_uprobe *p, struct
> pt_regs *regs,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 __u64 *data)
> +{
> +=09struct tlob_uprobe_binding *b =3D p->priv;
> +
> +=09tlob_start_task(current, b->threshold_ns);
> +=09return 0;
> +}
> +
> +static int tlob_uprobe_stop_handler(struct rv_uprobe *p, struct
> pt_regs *regs,
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
> +static int tlob_add_uprobe(u64 threshold_ns, const char *binpath,
> +=09=09=09=C2=A0=C2=A0 loff_t offset_start, loff_t offset_stop)
> +{

You can use cleanup helpers here to save a couple of gotos (making the
code less error prone and more readable):

> +=09struct tlob_uprobe_binding *b, *tmp_b;

struct tlob_uprobe_binding __free(kfree) *b =3D NULL, *tmp_b;

> +=09char pathbuf[TLOB_MAX_PATH];
> +=09struct path path;

struct path path __free(path_put) =3D {};

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
> +=09b->threshold_ns =3D threshold_ns;
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
try)
> {
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
> +=09/* Both probes share b (priv) and path; attach_path refs
> path itself. */
> +=09b->start_probe =3D rv_uprobe_attach_path(&path, offset_start,
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> tlob_uprobe_entry_handler, NULL, b);
> +=09if (IS_ERR(b->start_probe)) {
> +=09=09ret =3D PTR_ERR(b->start_probe);
> +=09=09b->start_probe =3D NULL;
> +=09=09goto err_path;
> +=09}
> +
> +=09b->stop_probe =3D rv_uprobe_attach_path(&path, offset_stop,
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> tlob_uprobe_stop_handler, NULL, b);
> +=09if (IS_ERR(b->stop_probe)) {
> +=09=09ret =3D PTR_ERR(b->stop_probe);
> +=09=09b->stop_probe =3D NULL;
> +=09=09goto err_start;
> +=09}
> +
> +=09path_put(&path);
> +=09list_add_tail(&b->list, &tlob_uprobe_list);

And finally tell the compiler you want to keep b in the happy path.

list_add_tail(&no_free_ptr(b)->list, &tlob_uprobe_list);

Not tested, but you got the gist, check include/linux/cleanup.h and grep
around for users if it doesn't work as expected.

> +=09return 0;
> +
> +err_start:
> +=09rv_uprobe_detach(b->start_probe);

This will need to stay, unless you want to DEFINE_FREE() for this, may
be fun but not required.

> +err_path:
> +=09path_put(&path);
> +err_free:
> +=09kfree(b);
> +=09return ret;
> +}

...

> +
> +/* Parse "-PATH:OFFSET_START" (ftrace uprobe_events removal
> convention). */

This isn't quite a standard function comment (and you don't really need
to make it so, it wouldn't add much value), but I'd say at least make it
a multi-line comment which is more common in this location:

/*
 * Parse ...
 */

...

> +static void __tlob_destroy_monitor(void)
> +{
> +=09rv_this.enabled =3D 0;
> +=09/*
> +=09 * Remove uprobes first; rv_uprobe_sync() inside ensures all
> in-flight
> +=09 * handlers have finished before we proceed.
> +=09 */
> +=09tlob_remove_all_uprobes();
> +
> +=09/*
> +=09 * da_monitor_destroy() iterates any remaining entries via
> da_extra_cleanup
> +=09 * (tlob_extra_cleanup), cancels their timers, and frees
> their state.
> +=09 * rcu_barrier() inside drains both da_pool_return_cb and
> tlob_free_rcu
> +=09 * callbacks before the pool arrays are freed.
> +=09 */

I'm not sure we need this many comments, the behaviour may change and we
don't need to describe what the function does before calling it.

If anything say /why/ you call a function before another, but I'd say
it's trivial here so you can just drop both comments.

> +=09ha_monitor_destroy();
> +=09kmem_cache_destroy(tlob_state_cache);
> +=09tlob_state_cache =3D NULL;
> +}

...

> +static int __init register_tlob(void)
> +{
> +=09int ret;
> +
> +=09ret =3D rv_register_monitor(&rv_this, NULL);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09if (rv_this.root_d) {
> +=09=09if (!tracefs_create_file("monitor", 0644,

We have rv_create_file() , it's exactly the same but let's be consistent
so if we ever decide to overload it, this won't stay behind.

> rv_this.root_d, NULL,
> +=09=09=09=09=09 &tlob_monitor_fops)) {
> +=09=09=09rv_unregister_monitor(&rv_this);
> +=09=09=09return -ENOMEM;
> +=09=09}
> +=09}
> +
> +=09return 0;
> +}

> diff --git a/kernel/trace/rv/monitors/tlob/tlob.h
> b/kernel/trace/rv/monitors/tlob/tlob.h
> new file mode 100644
> index 000000000000..b6724e629c69
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/tlob/tlob.h
> @@ -0,0 +1,148 @@

...

> +
> +enum states_tlob {
> +=09running_tlob,
> +=09waiting_tlob,
> +=09sleeping_tlob,
> +=09state_max_tlob,
> +};

This is personal preference, so feel free to ignore it. The header file
is (mostly) automatically generated and rvgen currently gives you a
different order for enums/arrays. Maybe just reorder all those according
to what rvgen does (just run it without the -a option and diff what
comes out).

The main reason is again to make it easy to update the file in case the
model/framework changes.

Thanks,
Gabriele

