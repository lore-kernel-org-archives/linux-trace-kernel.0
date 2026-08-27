Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984C743F8AC
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787825147; cv=none; b=ZdZSzmyuCLqFSIB1RkIg3gVfzvdNZ4pCzatmsgsLPusjll8nN7dCH3BKSQ3JBc/VIxPCUZev7STERQSTQirCvURc5H/OO3Nf/DwS2BmruZ2d5ukzPj/dBM5Uu7zNp1QhFk41irAQsGc5E+QwRl8pjhjqT7H1dBjRqUVOpyelAQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787825147; c=relaxed/simple;
	bh=zlOztHVKOcDOkmBAEaZ0iQktELGD2NlLB1Y2elmijoA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Td/GEak9zTQSnkXkgOH1kc69+pugF+avix/kpJsRsVjq7zKDsuibUKVEZ7HKpvN5CrRCUtvHRzGCYQfUqnVAQM9s5MHBlbZvOhkge1Zw9ZT05s7wYSMTseEEhvJRygIzkZ6mPvIwJz6Z0ge6w44MXVtenvPeVNo8yXGc4gaPAHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=II09McmN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="II09McmN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787825133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zlOztHVKOcDOkmBAEaZ0iQktELGD2NlLB1Y2elmijoA=;
	b=II09McmNjqGbz7KHS6/m2fTOzeqbYRG01ZpLO2pDNAnnb1bDcURCNiRnT5n7D/HUNN/S5w
	jM6iOmXVQoO7+3C/CfKvdsRYWZdaICAMJNulNujHqujPK58cQ1yOyb+GgTWYY7z0mJrHn4
	DDmmIVbJyTTMbWb5QIX+6tXWjIDSxyk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-jAi62z7OP-WbkkZS-gSD_g-1; Thu, 27 Aug 2026 06:05:32 -0400
X-MC-Unique: jAi62z7OP-WbkkZS-gSD_g-1
X-Mimecast-MFC-AGG-ID: jAi62z7OP-WbkkZS-gSD_g_1787825131
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c252c2ffeb8so180441766b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 03:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787825130; x=1788429930;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pW88VWxynzX4FH5YDB27jvLcss8TpBBYAW8EnWr/occ=;
        b=fMv2EfI0htQzqnMGz7mF61Q82kiTTrGs0jefiVXYZfTBNCfxzsa1reRQqMV4BeMJiq
         ND8ik1DMBimrkd8uqEogQlU0et1ge2wDttT5j0RFuEarlbjMR9Lpf5o+IJy9rzR/IZHW
         VdvIP//wTx7mLzvbHN7d3xAZAZV33BDjiKPiq3koZ9/lnnjsK8nnvxEiaM/SNrvywzJn
         oKlrPUfkvjNbDOgiw6zwPDwE/++YD7lLqEzn2CosssKMsvdzbLGPttP7PexatzXO/0v7
         0BNAJJB77tpy0VIWFy85lNj3WBoGl3SHNsixKl5D0JdYCILLXDilNB2cp53S8HNfFiCN
         Xm9A==
X-Forwarded-Encrypted: i=1; AHgh+RruWb/CiM8BtL4IuFI+/wM8T9K3x0zIltUQdgm06BDVUc/7vpXX4IeeDqCQHX+25Stl203gJs2uTy/MsyHnSmfNyE0=@vger.kernel.org
X-Gm-Message-State: AFuF++kK7/KgUHoDHNo5xrm/4TCGTWDrd9PndzKK2MV8tQT72hSAN/mD
	Psj7D0au+DzJJHQiMuzm+0k/nqXDA+K0C8BgxPlJvwzf+jGT28uB5Ij3sTplK2z0Foqphz59N8e
	TBNsI8P+UaRt40HYUMHrr/Hwx+bRsSEF2Hr1aG2nL8zm1vwXKgSdP/ESGoFA1h/k3c0FXS8uW6w
	==
X-Gm-Gg: AR+sD12SZDlvxOBerzXVST+ppKfYcsM6f6MdCqfkAhui4CcZYujpXLGvzarAYzt/AC/
	pAu+guYCUmiR4k0iTNQoXSv90aoeFXgW095uDgiXDihWr7yw3rnawmLKaVtpynf2AZaISXtAQWN
	1I+68tjIChjGLRb0A9JPX3pkSkfW0Fzeq6FlDyXnbKhKV4Ce5aChKHDyjCDjZtyXlo8k1pdFGn3
	jn8h2v+i0yWH9t0PCJdUaWSmlXVz/Jfdd66AxbcThJ9zcAiH7BODfQ2eusiZXxkYo4/tKeaOwFS
	PVVka/dBTtntbY7U5lTyTf4r6oI3foF/uT85zqi5uuh3cBhETIefegzeMSRHiDoTfbScfTe6rXK
	RBdIG02ufSqgsS8PYfeGWPV1M/RcXBAxprJ2h1SW6jv1D9JhdQAIil+0vAuuK4GYl7d8S9A==
X-Received: by 2002:a17:907:8997:b0:c24:6505:8f66 with SMTP id a640c23a62f3a-c250c595824mr1566835666b.13.1787825130547;
        Thu, 27 Aug 2026 03:05:30 -0700 (PDT)
X-Received: by 2002:a17:907:8997:b0:c24:6505:8f66 with SMTP id a640c23a62f3a-c250c595824mr1566829466b.13.1787825130067;
        Thu, 27 Aug 2026 03:05:30 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9b43absm719115766b.51.2026.08.27.03.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 03:05:29 -0700 (PDT)
Message-ID: <4d96d3520f5f2079155f6fcc6f7075deef8aec20.camel@redhat.com>
Subject: Re: [PATCH v6 6/9] rv: Add tlob hybrid automaton monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 27 Aug 2026 12:05:28 +0200
In-Reply-To: <d8eb57e037881da2187c84fb9c8499f3acf04fb3.1787243842.git.wen.yang@linux.dev>
References: <cover.1787243842.git.wen.yang@linux.dev>
	 <d8eb57e037881da2187c84fb9c8499f3acf04fb3.1787243842.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UOkibIV-i9zB0GXcStL1VD3tc3iI01Llkcvm1UKm6K0_1787825131
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wen,

thanks for the series, I'm going with the first chunk, I still need to
review the unbind_reap logic here.

On Fri, 2026-08-21 at 00:45 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
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
> +=09 * stopping=3D=3D1 means tlob_stop_task() ended this window already.
> +=09 * acquire pairs with the _release clear in ha_setup_invariants().
> +=09 */
> +=09if (atomic_read_acquire(&ws->stopping))
> +=09=09return;

Maybe I'm getting confused by the "acquire" in here, but are you aiming
to "acquire" the stopping here by reading and then setting it later?
That's obviously not atomic so you could read 0 and a concurring handler
could set it to 1 before you do. Wouldn't it be better to cmpxchg?

> +
> +=09/*
> +=09 * Monitor disable (ha_mon_destroying set) is not a violation: the
> +=09 * teardown paths free ws regardless.=C2=A0 Couples to an HA-layer fl=
ag
> +=09 * with no public contract; a framework-level equivalent would be
> +=09 * cleaner.
> +=09 */
> +=09if (unlikely(READ_ONCE(ha_mon_destroying)))
> +=09=09return;

This should be the first check in this function, there's no need to do
anything else and you cannot trust the da_mon pointer.
Put it before ha_monitor_reset_env() (to_ha_monitor is pointer
arithmetic, it can stay where it is for better readability).

> +
> +=09/* Genuine expiry: end the window so a later start takes the restart
> path. */
> +=09atomic_set(&ws->stopping, 1);
> +
> +=09/* Stamped regardless of the tracepoint; tlob_stop_task() reads it.
> */
> +=09WRITE_ONCE(ws->budget_exceeded, true);
> +
> +=09if (!trace_detail_env_tlob_enabled())
> +=09=09return;
> +
> +=09unsigned int curr_state =3D READ_ONCE(da_mon->curr_state);
> +=09u64 accs[TLOB_ACC_MAX], partial_ns;
> +=09unsigned long flags;
> +
> +=09/* Snapshot accumulators; partial_ns covers curr_state time not yet
> folded in. */
> +=09raw_spin_lock_irqsave(&ws->entry_lock, flags);
> +=09partial_ns =3D ktime_get_ns() - ktime_to_ns(ws->last_ts);
> +=09accs[TLOB_ACC_RUNNING]=C2=A0 =3D ws->accs_ns[TLOB_ACC_RUNNING]=C2=A0 =
+
> +=09=09=09=09=C2=A0 (curr_state =3D=3D running_tlob=C2=A0 ? partial_ns :
> 0);
> +=09accs[TLOB_ACC_WAITING]=C2=A0 =3D ws->accs_ns[TLOB_ACC_WAITING]=C2=A0 =
+
> +=09=09=09=09=C2=A0 (curr_state =3D=3D waiting_tlob=C2=A0 ? partial_ns :
> 0);
> +=09accs[TLOB_ACC_SLEEPING] =3D ws->accs_ns[TLOB_ACC_SLEEPING] +
> +=09=09=09=09=C2=A0 (curr_state =3D=3D sleeping_tlob ? partial_ns :
> 0);
> +=09raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
> +
> +=09trace_detail_env_tlob(da_get_id(da_mon), ws->threshold_ns,
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 accs[TLOB_ACC_RUNNING],
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 accs[TLOB_ACC_WAITING],
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 accs[TLOB_ACC_SLEEPING]);
> +}
> +
> +#define BUDGET_NS(ha_mon) (ha_get_target(ha_mon)->threshold_ns)
> +
> +/* HA constraint functions (called by ha_monitor_handle_constraint) */
> +
> +static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_tlob env,
> +=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 time_ns)
> +{
> +=09if (env =3D=3D clk_elapsed_tlob)
> +=09=09return ha_get_clk_ns(ha_mon, env, time_ns);
> +=09return ENV_INVALID_VALUE;
> +}
> +
> +/*
> + * Invariant: clk_elapsed < BUDGET_NS in running/waiting/sleeping.=C2=A0=
 "stopped"
> + * is exempt: the parked period must not be measured against the old win=
dow's
> + * clock anchor (restart from "stopped" would otherwise spuriously overr=
un).
> + */
> +static inline bool ha_verify_invariants(struct ha_monitor *ha_mon,
> +=09=09=09=09=09enum states curr_state, enum events
> event,
> +=09=09=09=09=09enum states next_state, u64 time_ns)
> +{
> +=09if (curr_state =3D=3D stopped_tlob)
> +=09=09return true;
> +=09return ha_check_invariant_ns(ha_mon, clk_elapsed_tlob, time_ns,
> BUDGET_NS(ha_mon));
> +}
> +
> +/*
> + * The clock stays in guard (anchor) representation all window: env_stor=
e
> + * holds the window-start timestamp, re-anchored on start/restart.
> + * ha_invariant_passed_ns() never stores the deadline representation (th=
e
> + * framework dropped ha_set_invariant_ns(), commit ab2900ae252b), so cal=
ling
> + * ha_inv_to_guard() here would subtract BUDGET_NS from the anchor and s=
kew
> + * every check by one budget.=C2=A0 nomiss likewise never converts.
> + */
> +
> +/* No per-event guard conditions for tlob; invariants suffice. */
> +static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0 enum states curr_state, enum events
> event,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0 enum states next_state, u64 time_ns)
> +{

Mmh, I just realised you don't use the guards for resets, is the order
of actions a problem for this monitor?

> +=09return true;
> +}
> +
> +/*
> + * Guard on stopping: a sched_switch after ha_cancel_timer_sync() would
> + * re-arm the timer (ODEBUG splat).=C2=A0 _acquire pairs with cmpxchg_re=
lease in
> + * tlob_stop_task.
> + *
> + * Entering stopped_tlob also resets env_store to the invalid sentinel, =
so a
> + * restart re-anchors the clock; a stale anchor would wrap the restart's
> + * timer delay to ~U64_MAX.
> + */
> +static inline void ha_setup_invariants(struct ha_monitor *ha_mon,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum states curr_state,=
 enum events
> event,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum states next_state,=
 u64 time_ns)
> +{
> +=09if (next_state =3D=3D stopped_tlob) {
> +=09=09/*
> +=09=09 * Window ending: reset env_store to the invalid sentinel so
> +=09=09 * the next window gets a fresh clock anchor.=C2=A0 Keep
> stopping=3D=3D1
> +=09=09 * so __tlob_acc() continues to block sched events while
> parked.
> +=09=09 */
> +=09=09ha_monitor_reset_all_stored(ha_mon);

Is this really necessary since you have a reset() in the start edge?
Isn't that anyway equivalent to reset() on the stop edge too?

> +=09=09return;
> +=09}
> +
> +=09if (atomic_read_acquire(&ha_get_target(ha_mon)->stopping)) {

Same as above, do you mean to cmpxchg?

> +=09=09/*
> +=09=09 * Restart (stopped -> running): arm the timer, then clear
> +=09=09 * stopping so __tlob_acc() admits sched events only once the
> +=09=09 * state is already running_tlob.=C2=A0 _release pairs with the
> +=09=09 * acquires in __tlob_acc/tlob_reset_notify.
> +=09=09 */
> +=09=09if (next_state < state_max_tlob)
> +=09=09=09ha_start_timer_ns(ha_mon, clk_elapsed_tlob,
> BUDGET_NS(ha_mon), time_ns);
> +=09=09atomic_set_release(&ha_get_target(ha_mon)->stopping, 0);
> +=09=09return;
> +=09}
...
> +
> +/*
> + * Accumulate elapsed ns into accs_ns[idx] since last_ts and advance it.
> + * Returns true if monitored with an active window.=C2=A0 The stopping g=
ate is
> + * what keeps scheduler events from reaching a parked task (no "stopped"
> + * self-loops, see tlob.h) and keeps accs_ns[] from growing while parked=
.
> + */
> +static inline bool __tlob_acc(struct task_struct *task, ktime_t now,
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum tlob_acc_idx idx)
> +{
> +=09struct tlob_task_state *ws;
> +=09unsigned long flags;
> +
> +=09guard(rcu)();
> +=09ws =3D da_get_target_by_id(task->pid);
> +=09/* acquire pairs with the _release clear in ha_setup_invariants(). */
> +=09if (!ws || atomic_read_acquire(&ws->stopping))
> +=09=09return false;

Mmh, returning false on !ws is kind of a shortcut to avoid another
hashtable lookup that would return nothing, but skipping events on
stopping is actually changing how the model behaves.

It is usually clearer to allow all events in a stopped state as
self-loops (the /task/ can go through those events also when stopped).
I usually prefer to keep logic in the model rather than in the source
file.

It wouldn't be too wrong to say that the task can do anything but the
tlob instance is stopped and other events cannot occur there, like
you're doing, but that should be well documented.
You're vaguely mentioning this in some changelog, if you want to keep it
this way, please explain it in the documentation file.
Word it like a description of the model rather than how you implement
it, something like (adapt it accordingly): "although tasks can enter the
scheduler when tlob is in the stopped state, those events are explicitly
ignored by the tlob instance, hence there is no self-loop in the stopped
state".

Thanks,
Gabriele

