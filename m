Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482F93FB056
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106706; cv=none; b=ob1ZRGFT5UaNXU9Kp4VZjJwlsG0TbD+q7G2QCfvEqInTEe/t6TbbpBzYzC2L/Z945oK3HFS4Lk9drLzUUubW2yBNbth9Y4jgaKUsp/k7IqsYEgxwh0Jq3lrySwS96iVZsEH6NuvggpybWje00OZmsQvxW70/1vO1JCwk+w4EvCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106706; c=relaxed/simple;
	bh=MraOR1jdq/+WHWxnObtE9PYFA8Gu3+qJzacjadp9K6o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYOez8VgupiCwdkT7Ur9LoWo1YN2K4NQ6voIBns0ERoVJofgW7Xj2mXm/NnpGfVwyXzIROma8z+MTMlRkpOq6XnErBfs0UeSYYfRtddyPAkYPux3ytS61n+1CO9F3cMa4Y8UkQCp9EbZtsVOqGnqaHAy1LmuP5rRT8ImOTWebto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MNv40R7Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNv40R7Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779106704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MraOR1jdq/+WHWxnObtE9PYFA8Gu3+qJzacjadp9K6o=;
	b=MNv40R7ZUUf/GAeq1896uzk1V425qoxuOUJyn76wQOm31UJhEWSX9Ul6CO7bO+2S6Tb27+
	fLbi7wjEwM15wHiE1Eg9CALvhqRTKX75v7DgxiPTwF3L4iVOwdGGm94cAO+hJw0E2+NMyA
	l6wWh/E8N1T8UitVoazDgH6yIKnq3Y0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-pEa9fwiYNbqs2yT9_6P00Q-1; Mon, 18 May 2026 08:18:23 -0400
X-MC-Unique: pEa9fwiYNbqs2yT9_6P00Q-1
X-Mimecast-MFC-AGG-ID: pEa9fwiYNbqs2yT9_6P00Q_1779106702
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-bcb9366d7d1so280560066b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 05:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779106702; x=1779711502;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQl1wZtNagxEOpQU7m4q7/yA3E+Om2kxUStl/NA5j0o=;
        b=DeqCBxaMb+RLyFQQL+F5eX44CXE9RM6d+NQ5D+LzxlJ11H4tKGhr4h4eDHFhK7Wg0e
         taocLAaZaFzwfjhTTWT/wjOt/LjzSaYAjtgsMk88nIMQvRCXftXLLMcVQyNH6zEv4Yhp
         OkcrarbwWRttvz1YJVhiiZHB41dcWTQyweb58a2lC4ffE/vPdiyQfrQD15o8CcCTzbRX
         iHd1b/8szZVWpe5JB0ok6/H201XS5oQR+1ldPufGjTz+2OHCR6vPHoaXAapBz7/94vgr
         XrIkwPVLsX96EwqRZg4SMHk3/JN6wBAmPQ6kgTVDLWuhexezboTgAIJFimSEK/CRglQc
         fUWw==
X-Forwarded-Encrypted: i=1; AFNElJ9sKE4Js9nxWdXxe6Ooz78Q73x4e8zlx3yCl0UMJ+m+XSetjkenIDLHF5sW4RBNAHfCtI1BWSukhF7Dl1tPzzoXctE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQarOJz/EQx1E3rS+BplHhubTYLEr4NVPtFBGctneV1UE1CeZc
	w/Xwjj7lSH436tJjJJOna5qLgcQBkSRQFeYol5VXxaGZagCaw5Wx5zBh8b86q6EhioNOO59nG8E
	DyOT72AbN2daIj/6rrWbLX1IIATz6HglIRwth7813Zs0I5b0jJBTquMDEsDzR6Hu2sEaTVBgFeA
	==
X-Gm-Gg: Acq92OF6VjfRwRPjitIktoKEA0fO1YQW0M8ysFrbI1FT+gPQuRCDsWz+K1qWmflN4UN
	qnX1rE5p71TZsVHiWbZ8o5hcSLcVmpnd5uC4WLESasmXyJdwpUqKTGMEW/QSxsXVzYViBGjALTz
	spoNbMATYZG5LGa+UZiam2Ycunpf89kdDnsIZduNJNJKPPI0EdFivEVOW5/3Xpoia0Jwz6N5cVn
	AWjlWffNxtwji8eFIHwyu31xgmRnKmidvTxXhkf2B0lcMoYtjU92dYVmaSuy9l3BI7S/pUSRQzf
	zMYzlMgVhrtSZtkrqVs2A3CIvQHgZkXBfxho5fB+0szyp76dg9+BrcWriowe5Chzln4xJ8z2Rfg
	43h76yIU8DlltiMde4rHsHb9aMdK27rZyZe/PDqF9GdmzOfG7Epqi9+T712+w04KXtf9dIVYR96
	Bb38AxyFJUNRVEv4Y=
X-Received: by 2002:a17:906:dc8b:b0:bc3:a0aa:1a04 with SMTP id a640c23a62f3a-bd4f3345cbdmr987043766b.13.1779106701776;
        Mon, 18 May 2026 05:18:21 -0700 (PDT)
X-Received: by 2002:a17:906:dc8b:b0:bc3:a0aa:1a04 with SMTP id a640c23a62f3a-bd4f3345cbdmr987041266b.13.1779106701257;
        Mon, 18 May 2026 05:18:21 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4bd0992sm553554866b.13.2026.05.18.05.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:18:20 -0700 (PDT)
Message-ID: <4c44732fe99ed455466d06e5989680177f02248e.camel@redhat.com>
Subject: Re: [PATCH 8/9] rv: Add automatic cleanup handlers for per-task HA
 monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Nam
 Cao	 <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org
Date: Mon, 18 May 2026 14:18:19 +0200
In-Reply-To: <843882d4-3cf1-403f-8d49-172c8efb8201@linux.dev>
References: <20260512140250.262190-1-gmonaco@redhat.com>
	 <20260512140250.262190-9-gmonaco@redhat.com>
	 <843882d4-3cf1-403f-8d49-172c8efb8201@linux.dev>
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
X-Mimecast-MFC-PROC-ID: JLyIyExmwG-0Vd49LswlHfzfnNjwffOmQ2WJw5hYiKk_1779106702
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-05-17 at 17:40 +0800, Wen Yang wrote:
> ha_cancel_timer_sync() is the right choice for task exit; the
> ha_mon_initializing guard correctly handles the init-window race.
>=20
> One issue: after ha_monitor_disable_hook(), an in-flight
> ha_handle_sched_process_exit() handler may still be executing.=C2=A0 It
> reads task_mon_slot via da_get_monitor() (&p->rv[task_mon_slot]);
> da_monitor_sync_hook() =3D synchronize_rcu() cannot drain it because
> tracepoint handlers run outside any RCU read-side section.=C2=A0 If
> rv_put_task_monitor_slot() writes RV_PER_TASK_MONITOR_INIT to
> task_mon_slot first, the handler dereferences an OOB index.
>=20
> This is the same race Patch 5 closes for PER_OBJ with
> tracepoint_synchronize_unregister(); the PER_TASK da_monitor_destroy()
> needs the same call (and so does every other PER_TASK monitor, not only
> the new exit handler).
>=20
> Could you add tracepoint_synchronize_unregister() to the PER_TASK
> da_monitor_destroy() ?=C2=A0 Alternatively, we can carry the fix on top o=
f
> your series.

Yeah you're right, that's the neatest way to solve it.

Indeed, any in-flight handler would do da_get_monitor() not only the newly =
added
exit hook, so we're going to need tracepoint_synchronize_unregister() befor=
e
touching task_mon_slot in any per-task monitor (not only HA, also DA and ev=
en
LTL).

Feel free to send your patch and I'll apply it to this series, including al=
so
ltl_monitor_destroy().

Thanks,
Gabriele

>=20
> --
> Best wishes,
> Wen
>=20
>=20
> On 5/12/26 22:02, Gabriele Monaco wrote:
> > Hybrid automata monitors may start timers, depending on the model, thes=
e
> > may remain active on an exiting task and cause false positives or even
> > access freed memory.
> >=20
> > Add an enable/disable hook in the HA code, currently only populated by
> > the per-task handler for registration and deregistration.
> > This hooks to the sched_process_exit event and ensures the timer is
> > stopped for every exiting task. The handler is enabled automatically bu=
t
> > may be disabled, for instance if the monitor uses the event for another
> > purpose (but should still manually ensure timers are stopped).
> >=20
> > Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > ---
> > =C2=A0 include/rv/ha_monitor.h | 44 +++++++++++++++++++++++++++++++++++=
++++++
> > =C2=A0 1 file changed, 44 insertions(+)
> >=20
> > diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> > index 11ae85bad492..1bdf866e9c63 100644
> > --- a/include/rv/ha_monitor.h
> > +++ b/include/rv/ha_monitor.h
> > @@ -28,6 +28,7 @@ static inline void ha_monitor_init_env(struct da_moni=
tor
> > *da_mon);
> > =C2=A0 static inline void ha_monitor_reset_env(struct da_monitor *da_mo=
n);
> > =C2=A0 static inline void ha_setup_timer(struct ha_monitor *ha_mon);
> > =C2=A0 static inline bool ha_cancel_timer(struct ha_monitor *ha_mon);
> > +static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon);
> > =C2=A0 static bool ha_monitor_handle_constraint(struct da_monitor *da_m=
on,
> > =C2=A0=C2=A0=09=09=09=09=09 enum states curr_state,
> > =C2=A0=C2=A0=09=09=09=09=09 enum events event,
> > @@ -38,6 +39,26 @@ static bool ha_monitor_handle_constraint(struct
> > da_monitor *da_mon,
> > =C2=A0 #define da_monitor_reset_hook ha_monitor_reset_env
> > =C2=A0 #define da_monitor_sync_hook() synchronize_rcu()
> > =C2=A0=20
> > +#if !defined(HA_SKIP_AUTO_CLEANUP) && RV_MON_TYPE =3D=3D RV_MON_PER_TA=
SK
> > +/*
> > + * Automatic cleanup handlers for per-task HA monitors, only skip if y=
ou
> > know
> > + * what you are doing (e.g. you want to implement cleanup manually in
> > another
> > + * handler doing more things).
> > + */
> > +static void ha_handle_sched_process_exit(void *data, struct task_struc=
t *p,
> > +=09=09=09=09=09 bool group_dead);
> > +
> > +#define
> > ha_monitor_enable_hook()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +=09rv_attach_trace_probe(__stringify(MONITOR_NAME),
> > sched_process_exit, \
> > +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ha_handle_sched_process_exit)
> > +#define
> > ha_monitor_disable_hook()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +=09rv_detach_trace_probe(__stringify(MONITOR_NAME),
> > sched_process_exit, \
> > +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ha_handle_sched_process_exit)
> > +#else
> > +#define ha_monitor_enable_hook()
> > +#define ha_monitor_disable_hook()
> > +#endif
> > +
> > =C2=A0 #include <rv/da_monitor.h>
> > =C2=A0 #include <linux/seq_buf.h>
> > =C2=A0=20
> > @@ -124,12 +145,14 @@ static int ha_monitor_init(void)
> > =C2=A0=20
> > =C2=A0=C2=A0=09ha_mon_initializing =3D true;
> > =C2=A0=C2=A0=09ret =3D da_monitor_init();
> > +=09ha_monitor_enable_hook();
> > =C2=A0=C2=A0=09ha_mon_initializing =3D false;
> > =C2=A0=C2=A0=09return ret;
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 static void ha_monitor_destroy(void)
> > =C2=A0 {
> > +=09ha_monitor_disable_hook();
> > =C2=A0=C2=A0=09da_monitor_destroy();
> > =C2=A0 }
> > =C2=A0=20
> > @@ -230,6 +253,18 @@ static inline void ha_trace_error_env(struct ha_mo=
nitor
> > *ha_mon,
> > =C2=A0 {
> > =C2=A0=C2=A0=09CONCATENATE(trace_error_env_, MONITOR_NAME)(id, curr_sta=
te, event,
> > env);
> > =C2=A0 }
> > +
> > +#if !defined(HA_SKIP_AUTO_CLEANUP) && RV_MON_TYPE =3D=3D RV_MON_PER_TA=
SK
> > +static void ha_handle_sched_process_exit(void *data, struct task_struc=
t *p,
> > +=09=09=09=09=09 bool group_dead)
> > +{
> > +=09struct da_monitor *da_mon =3D da_get_monitor(p);
> > +
> > +=09if (likely(!ha_monitor_uninitialized(da_mon)))
> > +=09=09ha_cancel_timer_sync(to_ha_monitor(da_mon));
> > +}
> > +#endif
> > +
> > =C2=A0 #endif /* RV_MON_TYPE */
> > =C2=A0=20
> > =C2=A0 /*
> > @@ -455,6 +490,10 @@ static inline bool ha_cancel_timer(struct ha_monit=
or
> > *ha_mon)
> > =C2=A0 {
> > =C2=A0=C2=A0=09return timer_delete(&ha_mon->timer);
> > =C2=A0 }
> > +static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon)
> > +{
> > +=09timer_delete_sync(&ha_mon->timer);
> > +}
> > =C2=A0 #elif HA_TIMER_TYPE =3D=3D HA_TIMER_HRTIMER
> > =C2=A0 /*
> > =C2=A0=C2=A0 * Helper functions to handle the monitor timer.
> > @@ -506,6 +545,10 @@ static inline bool ha_cancel_timer(struct ha_monit=
or
> > *ha_mon)
> > =C2=A0 {
> > =C2=A0=C2=A0=09return hrtimer_try_to_cancel(&ha_mon->hrtimer) =3D=3D 1;
> > =C2=A0 }
> > +static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon)
> > +{
> > +=09hrtimer_cancel(&ha_mon->hrtimer);
> > +}
> > =C2=A0 #else /* HA_TIMER_NONE */
> > =C2=A0 /*
> > =C2=A0=C2=A0 * Start function is intentionally not defined, monitors us=
ing timers must
> > @@ -516,6 +559,7 @@ static inline bool ha_cancel_timer(struct ha_monito=
r
> > *ha_mon)
> > =C2=A0 {
> > =C2=A0=C2=A0=09return false;
> > =C2=A0 }
> > +static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon) { }
> > =C2=A0 #endif
> > =C2=A0=20
> > =C2=A0 #endif

