Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62033F23B1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105303; cv=none; b=KTAit8mDe98moy8+cQ2qs+Nqb08oMP00iIwzH6Up2po9/kA3DqoDK2QgBEPEYpepzSO9bP2R5wrTrEv2Dgnv88c/BcJHZTG3PccpNITc1unZlnQgiebRCJXKIW88SHCx/oFB9nHnQC8SxhciIWrJ4gHw9ZhGZQwBWGl/uW5wlQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105303; c=relaxed/simple;
	bh=SuSuAwn5cjR6a6nAmQnGSBDzhrc50gJ32i9/CwU2ZqU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pKCQ+sNaqrycFs9u2kp71eEe8nEKkglegR0EFxxqFHuIPL0i9zD8G7fj3Eo+GUwP7Rjdc0sPkPekQBpDEdZaCbvbHq9ESsbm9x465PFvGZ2+epymjqBLjGacLZpxLo/XPv2XC5tpi/2JHceY2NO1cvU2ECedMsfzxTdYzW08ARQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYRkqmfY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYRkqmfY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779105300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SuSuAwn5cjR6a6nAmQnGSBDzhrc50gJ32i9/CwU2ZqU=;
	b=XYRkqmfYhV5A6IRx+P9nWU+XeGrK+uA5iUoHuOjCIViGg1tsSzc3NtZ9wsrihySpI7vgUG
	zmvC9e9nyAM4st6WVBF7XUp5KJ4//nNFpKILPb5nindLLBYo73QuNe4WSXrR6gjk3VHsBB
	ZDR8rzyitcq0kDDPuvrGJ2Q7p9MSPJA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-TqcXON9qMa-nOu7i8Ap6Gg-1; Mon, 18 May 2026 07:54:59 -0400
X-MC-Unique: TqcXON9qMa-nOu7i8Ap6Gg-1
X-Mimecast-MFC-AGG-ID: TqcXON9qMa-nOu7i8Ap6Gg_1779105298
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fe6894f3fso12820805e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 04:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779105298; x=1779710098;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3UgbDRpmQmH2/TOIM1YiFxCO5Zorb55RAkELVVLIqwE=;
        b=ZprMWVGXcUO88Svyu9s6WHxwDfKaF53HkT+tFf3U/yOC1mA+TTbo3UYjcay15i9IkB
         fylm0q2HCJioFcwuFhV+aaEq9NPEtlXXXCmcUzZSdxR+ZUuWi7OmDh1S0Tk2Nz23oPJj
         uWEqVduP6+7SQs480U62GxuW7Ov7VM/0Os5ayQlXeoGMrvFcAyzvU6t+5sVUM1gXQMW6
         PdPAFaRNzC2hzYiVPz1OsXm3aYNL6O/m8iI1URvpz5OelM6Fw4vjNHAXTXeAyz2KrS34
         X1f5zvHMqaPK/MbwxnNycYQCl7/vq+zVaBSy0cXU09b5HejGeRm/POZQpPGoV43ZfCuY
         t5Ag==
X-Forwarded-Encrypted: i=1; AFNElJ+AFJy8FoxKsia6tMs4iKvAF7SyBQV0eScQY/sTY+JoHvkXgz5UAcR/3ll+ISK2rBeLLmM2/1Qy79n07e9UA1yMobs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx64X0BzI4w0boyC2OCTMw4OmZG5nJ9rEBpvSQcOEpYyVZEzUiI
	2eGxY0zkf6rzvYGw0dLNbchGPmh8js2Ydjw+ECI1sm8uLRsJtJx8BmTUdAo0RQibL4jyvlWmFR3
	qrHmBZNeu6Tjua6Fk4kyU4ZoN05aD9yvGZnZa9oQfCIN6BeLA4yxXsF9qZ06mElRSYZa2111spu
	J3ixEilL6L
X-Gm-Gg: Acq92OFcKp/UZBPhQsjtj9h5pWrzxFO4pKBz1ZLbyunNdRxiRRQFcqng3MS+DM228ni
	VkrPllUIxXFNrt4ExQ50D8n1OFOBSP3RiWf0UBDL7ixA3kNF1GDxvKAIT4uoAaI+wlIaM0lulWX
	4dDS2SsLQVOvSVxQQF8hVZifN+VWuhv60h9RuTM0D8HtB7H8Hm//JZKc+m1f+DhzxCb1nA/RjMv
	eFtlGzuEq18S+qj0Wq60QqyLFdFcfxwSgrr1BOeYFyCjjbSSl0Xqi76IxKGWj5BlAtx8K/cbcUs
	rudX4ydYqfumrckAOB07pYR/n7/xe4APDKQJ9K9yHi4R0H6GQVQJ4D4O/ExX1ixY/fvTEG4KJMc
	Bae+qfRILIdOGMC3ISlOpxTTNsdJ1iaMwFWS97c+RJEmuP2GZmSwR4JzCS5TNXlnzZg1x8c9xYv
	/Lp+8OJXQK0jPB927CjIjwXvJ7Tw==
X-Received: by 2002:a05:600c:4fc9:b0:48d:366:b962 with SMTP id 5b1f17b1804b1-48fe60e368amr195597925e9.6.1779105298113;
        Mon, 18 May 2026 04:54:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc9:b0:48d:366:b962 with SMTP id 5b1f17b1804b1-48fe60e368amr195597355e9.6.1779105297597;
        Mon, 18 May 2026 04:54:57 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fffb9aac4sm242820785e9.9.2026.05.18.04.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 04:54:57 -0700 (PDT)
Message-ID: <88a6fc5c08d18e3c1f6d29dc106db80fa688bf87.camel@redhat.com>
Subject: Re: [PATCH 6/9] rv: Ensure synchronous cleanup for HA monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Nam
 Cao	 <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org
Date: Mon, 18 May 2026 13:54:55 +0200
In-Reply-To: <b7d760dc-162a-48e8-af75-e566bfa46493@linux.dev>
References: <20260512140250.262190-1-gmonaco@redhat.com>
	 <20260512140250.262190-7-gmonaco@redhat.com>
	 <b7d760dc-162a-48e8-af75-e566bfa46493@linux.dev>
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
X-Mimecast-MFC-PROC-ID: ncUyCStQJK_w6o8GeOE4lAIUp_04zhMpDibYjtU5FMQ_1779105298
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-05-17 at 17:12 +0800, Wen Yang wrote:
> The guard(rcu)() + synchronize_rcu() mechanism for HA timer callbacks
> is correct.
>=20
> One concern: TOCTOU between the pre-check and guard(rcu)().

Yes, this could happen, but I'm not sure it's really a big issue:

>=20
> da_monitor_reset() calls reset_hook BEFORE clearing monitoring:
>=20
> =C2=A0=C2=A0 da_monitor_reset_hook(da_mon);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* ha_cancel_timer [async]=C2=A0=C2=A0 */
> =C2=A0=C2=A0 WRITE_ONCE(da_mon->monitoring, 0);=C2=A0=C2=A0=C2=A0 /* clea=
red AFTER reset_hook=C2=A0 */
> =C2=A0=C2=A0 da_mon->curr_state =3D model_get_initial_state();
>=20
> This may creates a window where the callback pre-check passes but the
> monitor is reset before guard(rcu)() is acquired:

If a callback is running, there was a violation because the timer expired, =
so it
isn't wrong to report, although we are unloading the monitor.

>=20
> =C2=A0=C2=A0 /* __ha_monitor_timer_callback() */
> =C2=A0=C2=A0 if (unlikely(!da_monitor_handling_event(&ha_mon->da_mon)))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>=20
> =C2=A0=C2=A0 /* passes: monitoring=3D1
> =C2=A0=C2=A0=C2=A0 *
> =C2=A0=C2=A0=C2=A0 * WINDOW =E2=94=80 CPU A runs da_monitor_reset_all() h=
ere:
> =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 ha_cancel_timer()=C2=A0 [returns: callba=
ck is running, cannot cancel]
> =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 WRITE_ONCE(monitoring, 0)
> =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 curr_state =3D model_get_initial_state()
> =C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0 guard(rcu)();
> =C2=A0=C2=A0 curr_state =3D READ_ONCE(ha_mon->da_mon.curr_state);=C2=A0 /=
* initial_state */
> =C2=A0=C2=A0 /* no second da_monitoring() check */
> =C2=A0=C2=A0 ha_react(curr_state, EVENT_NONE, env_string.buffer); /* spur=
ious call */
> =C2=A0=C2=A0 ha_trace_error_env(ha_mon, ...);=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* fires=20
> unconditionally */
>=20
> Result: spurious ha_trace_error_env() for initial_state.=C2=A0 For existi=
ng
> monitors (stall/nomiss/opid), model_should_send_event_env(initial, NONE)
> returns false, so no false-positive reaction, but the trace event fires.
> Monitors where initial_state carries a constraint would produce a false
> positive.

I'm not sure what you mean here, if I understand the situation correctly: t=
he
callback is running (so we should react), da_monitor_reset() is too late to=
 stop
it but somehow manages to reset curr_state on time for the callback to see =
it
change: react reports the wrong state in an otherwise valid reaction.

>=20
> Proposed fix : re-check inside the RCU critical section:
>=20
> =C2=A0=C2=A0 guard(rcu)();
> =C2=A0=C2=A0 if (unlikely(!da_monitoring(&ha_mon->da_mon)))=C2=A0 /* re-c=
heck here */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> =C2=A0=C2=A0 curr_state =3D READ_ONCE(ha_mon->da_mon.curr_state);

I'm not sure that's going to fix it anyway, RCU cannot synchronise readers,
checking again would at most (mildly) reduce the race window, not remove it=
.

What we could do is to play with barriersin for the callback to either:
* see monitoring =3D 1 AND the old curr_state
* see monitoring =3D 0 AND the new curr_state

Something like:

void __ha_monitor_timer_callback() {
=09guard(rcu)(); //this is only for waiters, let them wait more

=09if (unlikely(!da_monitor_handling_event(&ha_mon->da_mon)))
=09=09return;
=09smp_rmb();
=09curr_state =3D READ_ONCE(ha_mon->da_mon.curr_state);
=09...
}

void da_monitor_reset() {
=09da_monitor_reset_hook(da_mon);
=09WRITE_ONCE(da_mon->monitoring, 0);
=09smp_wmb();
=09WRITE_ONCE(da_mon->curr_state, model_get_initial_state());
}

Coupled with your patch [1] adding more atomic accesses to da_mon->monitori=
ng
should probably do the trick.

Am I missing anything?

Thanks,
Gabriele

[1] -
https://lore.kernel.org/lkml/8af5ba4bd93d2acb8a546e8e47ced974a87c1eb8.17785=
22945.git.wen.yang@linux.dev

>=20
>=20
> --
> Best wishes,
> Wen
>=20
>=20
> On 5/12/26 22:02, Gabriele Monaco wrote:
> > HA monitors may start timers, all cleanup functions currently stop the
> > timers asynchronously to avoid sleeping in the wrong context.
> > Nothing makes sure running callbacks terminate on cleanup.
> >=20
> > Run the entire HA timer callback in an RCU read-side critical section,
> > this way we can simply synchronize_rcu() with any pending timer and are
> > sure any cleanup using kfree_rcu() runs after callbacks terminated.
> > Additionally make sure any unlikely callback running late won't run any
> > code if the monitor is marked as disabled.
> >=20
> > Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
> > Fixes: 4a24127bd6cb ("rv: Add support for per-object monitors in DA/HA"=
)
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > ---
> > =C2=A0 include/rv/da_monitor.h | 23 +++++++++++++++++++----
> > =C2=A0 include/rv/ha_monitor.h | 18 ++++++++++++++++--
> > =C2=A0 2 files changed, 35 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> > index a4a13b62d1a4..402d3b935c08 100644
> > --- a/include/rv/da_monitor.h
> > +++ b/include/rv/da_monitor.h
> > @@ -57,6 +57,15 @@ static struct rv_monitor rv_this;
> > =C2=A0 #define da_monitor_reset_hook(da_mon)
> > =C2=A0 #endif
> > =C2=A0=20
> > +/*
> > + * Hook to allow the implementation of hybrid automata: define it with=
 a
> > + * function that waits for the termination of all monitors background
> > + * activities (e.g. all timers). This hook can sleep.
> > + */
> > +#ifndef da_monitor_sync_hook
> > +#define da_monitor_sync_hook()
> > +#endif
> > +
> > =C2=A0 /*
> > =C2=A0=C2=A0 * Type for the target id, default to int but can be overri=
dden.
> > =C2=A0=C2=A0 * A long type can work as hash table key (PER_OBJ) but wil=
l be downgraded
> > to
> > @@ -179,6 +188,7 @@ static inline int da_monitor_init(void)
> > =C2=A0 static inline void da_monitor_destroy(void)
> > =C2=A0 {
> > =C2=A0=C2=A0=09da_monitor_reset_all();
> > +=09da_monitor_sync_hook();
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 #ifndef da_implicit_guard
> > @@ -232,6 +242,7 @@ static inline int da_monitor_init(void)
> > =C2=A0 static inline void da_monitor_destroy(void)
> > =C2=A0 {
> > =C2=A0=C2=A0=09da_monitor_reset_all();
> > +=09da_monitor_sync_hook();
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 #ifndef da_implicit_guard
> > @@ -319,6 +330,7 @@ static inline void da_monitor_destroy(void)
> > =C2=A0=C2=A0=09}
> > =C2=A0=20
> > =C2=A0=C2=A0=09da_monitor_reset_all();
> > +=09da_monitor_sync_hook();
> > =C2=A0=20
> > =C2=A0=C2=A0=09rv_put_task_monitor_slot(task_mon_slot);
> > =C2=A0=C2=A0=09task_mon_slot =3D RV_PER_TASK_MONITOR_INIT;
> > @@ -497,10 +509,9 @@ static void da_monitor_reset_all(void)
> > =C2=A0=C2=A0=09struct da_monitor_storage *mon_storage;
> > =C2=A0=C2=A0=09int bkt;
> > =C2=A0=20
> > -=09rcu_read_lock();
> > +=09guard(rcu)();
> > =C2=A0=C2=A0=09hash_for_each_rcu(da_monitor_ht, bkt, mon_storage, node)
> > =C2=A0=C2=A0=09=09da_monitor_reset(&mon_storage->rv.da_mon);
> > -=09rcu_read_unlock();
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 static inline int da_monitor_init(void)
> > @@ -516,13 +527,17 @@ static inline void da_monitor_destroy(void)
> > =C2=A0=C2=A0=09int bkt;
> > =C2=A0=20
> > =C2=A0=C2=A0=09tracepoint_synchronize_unregister();
> > +=09scoped_guard(rcu) {
> > +=09=09hash_for_each_rcu(da_monitor_ht, bkt, mon_storage, node) {
> > +=09=09=09da_monitor_reset_hook(&mon_storage->rv.da_mon);
> > +=09=09}
> > +=09}
> > +=09da_monitor_sync_hook();
> > =C2=A0=C2=A0=09/*
> > =C2=A0=C2=A0=09 * This function is called after all probes are disabled=
 and no
> > longer
> > =C2=A0=C2=A0=09 * pending, we can safely assume no concurrent user.
> > =C2=A0=C2=A0=09 */
> > -=09synchronize_rcu();
> > =C2=A0=C2=A0=09hash_for_each_safe(da_monitor_ht, bkt, tmp, mon_storage,=
 node) {
> > -=09=09da_monitor_reset_hook(&mon_storage->rv.da_mon);
> > =C2=A0=C2=A0=09=09hash_del_rcu(&mon_storage->node);
> > =C2=A0=C2=A0=09=09kfree(mon_storage);
> > =C2=A0=C2=A0=09}
> > diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> > index d59507e8cb30..47ff1a41febe 100644
> > --- a/include/rv/ha_monitor.h
> > +++ b/include/rv/ha_monitor.h
> > @@ -36,6 +36,7 @@ static bool ha_monitor_handle_constraint(struct da_mo=
nitor
> > *da_mon,
> > =C2=A0 #define da_monitor_event_hook ha_monitor_handle_constraint
> > =C2=A0 #define da_monitor_init_hook ha_monitor_init_env
> > =C2=A0 #define da_monitor_reset_hook ha_monitor_reset_env
> > +#define da_monitor_sync_hook() synchronize_rcu()
> > =C2=A0=20
> > =C2=A0 #include <rv/da_monitor.h>
> > =C2=A0 #include <linux/seq_buf.h>
> > @@ -237,12 +238,25 @@ static bool ha_monitor_handle_constraint(struct
> > da_monitor *da_mon,
> > =C2=A0=C2=A0=09return false;
> > =C2=A0 }
> > =C2=A0=20
> > +/*
> > + * __ha_monitor_timer_callback - generic callback representation
> > + *
> > + * This callback runs in an RCU read-side critical section to allow th=
e
> > + * destruction sequence to easily synchronize_rcu() with all pending t=
imer
> > + * after asynchronously disabling them.
> > + */
> > =C2=A0 static inline void __ha_monitor_timer_callback(struct ha_monitor=
 *ha_mon)
> > =C2=A0 {
> > -=09enum states curr_state =3D READ_ONCE(ha_mon->da_mon.curr_state);
> > =C2=A0=C2=A0=09DECLARE_SEQ_BUF(env_string, ENV_BUFFER_SIZE);
> > -=09u64 time_ns =3D ha_get_ns();
> > +=09enum states curr_state;
> > +=09u64 time_ns;
> > +
> > +=09if (unlikely(!da_monitor_handling_event(&ha_mon->da_mon)))
> > +=09=09return;
> > =C2=A0=20
> > +=09guard(rcu)();
> > +=09curr_state =3D READ_ONCE(ha_mon->da_mon.curr_state);
> > +=09time_ns =3D ha_get_ns();
> > =C2=A0=C2=A0=09ha_get_env_string(&env_string, ha_mon, time_ns);
> > =C2=A0=C2=A0=09ha_react(curr_state, EVENT_NONE, env_string.buffer);
> > =C2=A0=C2=A0=09ha_trace_error_env(ha_mon, model_get_state_name(curr_sta=
te),

