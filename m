Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442C0393DC8
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576974; cv=none; b=sKME69VICfFvrk1ZH2Wb3n5Wn+SIqfzfV4M1my0qEUaUz/Unhu+KDCwJjyWNLYzJI7zZgrHGkce75iYHzoekuZPQy4dhBdQPWxaVAXIHr0Mbii8e+QeVnTSLE9aIBsTZTQKi2SUgiqmV3EfNQupUr979A0gBsa4BKZ3WnvPmnpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576974; c=relaxed/simple;
	bh=UaHCW1fIVUt4KvsHqRNoQ/j4s2EJthw5kRd4BR/Yi1A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cByJqqiu83fCDydtm7pzhThIz9GOVs4DnR79n86gxFPmNXdgONiVz+feXqcbb3GXqcVp/oOnCatq1MRckUv+zNew5ywNRlIRB4srF18VHAv7rMf9oqo98ECGk1hCZLNgBg4aC4PUZTYSJzNab5dmQMeauJhL0KVrMzyJE9rJt6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUhC3lBs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUhC3lBs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778576971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UaHCW1fIVUt4KvsHqRNoQ/j4s2EJthw5kRd4BR/Yi1A=;
	b=XUhC3lBsVH2WsBwnG7aD0uEFkuHuHzOd3I7OJGLz81ACHFgkw5zwo/MvkXT6a++6xjSOQP
	tkXPvKdQVnEuFQAZztMNA1qLxXfmLunZ/xfx6mWSTnEIAkpdxjhv7IbQntp8obEZ2oZQTL
	8KoH9CQyF10rAKeEkrDuKVNpAF/LqX8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-ItpBiI2sPG-YPMLouBLYZQ-1; Tue, 12 May 2026 05:09:29 -0400
X-MC-Unique: ItpBiI2sPG-YPMLouBLYZQ-1
X-Mimecast-MFC-AGG-ID: ItpBiI2sPG-YPMLouBLYZQ_1778576968
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48d035e8593so37209985e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 02:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778576968; x=1779181768;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ku4PPIzPxXA06bNM7AJ3zKbTlFOq3BIrLLlOUlZKso=;
        b=DfsN/RQf3QVZSPxcZndfPzjRihndcvs4PRmAx8kWEG11RF1pV+m8dui5xHDWVQYy9Y
         ooEE0eBMy+sxTqPMr7y7EAgnEfrB+yLgLN9Mwh1x1FSS9b0hlK2At2ox8e3DfCKN9gJj
         68LpC81ua74kLQ/LiM1/3G9ij95WayPj8vOjpXz1Om62WRkHcootwCNQqFeXy0bFY9aC
         0tSxJSVf6RMFd93Q/w6awBYKABZoGTtFRZOrqb9OTdMj23yO+t0r6NDm/g90ZlgcslaD
         +tQBIfxm+eSeb+RzmkP/P669L9/rQEnGo4YgYX6NAC4hH0Y5gaMlA0PiAuG5R+DEurrG
         XGjQ==
X-Gm-Message-State: AOJu0Yx0j1uYJxl8rJaOQ8L9nrsct/PlYgoJxxpHWoeK9vsx84eTJaTn
	0IdWE5Unp1E5szTmYPRm7d4dkufU+RbXVZpxLk/Z72Hk83arGTE0pdF5jB/qHyg1JEYY8HD6csr
	rwc3iahFt3my0WUS/Ia5Lh1gaUdvNYlk3pQsKoR48yZK7G6Po13nBk6EKHU4w4Q8+Q4v/qh9waQ
	==
X-Gm-Gg: Acq92OEL+ZkqKTTp2x/bHAaylAVoFKN4AyFVXFm3jXeA0IjlOemeidvU9PpZfBTtxWZ
	ceSor/hDAIOq/KQVB8ghMh8QOBuKsGpU3gqTWTU6mhM9oBFHDDFWgLWTPJDEQDBgK7JNqGsDP3e
	uRVT+NwtExHnQDw7ymXY/wWw5TnC+nFD/kze3VHnnarwUV1BqVEOEXCvgyhL18/+faIRsIGT6w8
	24rGbHlZLtZkYbhhZE46Y26noUFa163J1qLwMME61CtlF37H65C6r0hhixeaJLXlphNVwa+fyp7
	MA+XZqBtb+iXFpOzvefsEk/xKeASx8mruscAWzVmuhGxA/5NCDTZyMfYYpNxTzMtSzkwlZ+CwUt
	bSZVZ8Fh15qBXmwzXolD/0sMCTm4Ur0TUTxYS1mqbo5jLgxXGQGVjWCzfGatMBLnH6SsoHgJBku
	L4GSQtgodV+zVbG7A=
X-Received: by 2002:a05:600c:8b62:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48e6748afe8mr262618395e9.5.1778576968321;
        Tue, 12 May 2026 02:09:28 -0700 (PDT)
X-Received: by 2002:a05:600c:8b62:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48e6748afe8mr262617945e9.5.1778576967888;
        Tue, 12 May 2026 02:09:27 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454917d57aesm31655504f8f.26.2026.05.12.02.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 02:09:27 -0700 (PDT)
Message-ID: <8e80cbcf739304de95356f1fac677261628977fa.camel@redhat.com>
Subject: Re: [RFC PATCH v2 02/10] rv/da: fix per-task da_monitor_destroy()
 ordering and sync
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Date: Tue, 12 May 2026 11:09:26 +0200
In-Reply-To: <f654a17c671469fd8fc9ea438daf2266d05068d4.camel@redhat.com>
References: <cover.1778522945.git.wen.yang@linux.dev>
		 <d02c656aada7d071f083460a5c9a454363669b61.1778522945.git.wen.yang@linux.dev>
	 <f654a17c671469fd8fc9ea438daf2266d05068d4.camel@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 0GL1rM2TPCaPKEDIaiLkTPqIWEBerIaAMF9UL1eyUcQ_1778576968
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-12 at 10:27 +0200, Gabriele Monaco wrote:
> On Tue, 2026-05-12 at 02:24 +0800, wen.yang@linux.dev=C2=A0wrote:
> > From: Wen Yang <wen.yang@linux.dev>
> >=20
> > The following two paths race:
> >=20
> > =C2=A0 CPU 0 (disable_stall/__rv_disable_monitor)=C2=A0 CPU 1 (wwnr pro=
be handler)
> =09=09=09=09=09=09=09^ did you mean stall?

Ok I got it now, so essentially you'd reproduce it like:

* start a DA per-task monitor (no timer)
* stop it, a handler is still running after reset, it sets monitoring back =
to 1
* start an HA per-task monitor

that would use the same slot that is now looking like:

 { monitoring =3D 1, timer.function =3D NULL }

because it was not initialised as HA but monitoring was reset in the race.

Thinking about this again, it isn't just an issue with per-task monitors, a=
ll
monitors reusing slots would suffer from it.
Besides, relying on monitoring can be fragile when using LTL monitors on th=
e
same task (those don't even have monitoring).

Perhaps the solution isn't that trivial, I'm going to give one more thought=
 on
it, but thanks again for bringing this up!

Gabriele

> > =C2=A0 ------------------------------------------=C2=A0 ---------------=
--------------
> > =C2=A0 disable_stall()
> > =C2=A0=C2=A0=C2=A0 da_monitor_destroy()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 da_monitor_reset_all()=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <------ [task T: monitoring=3D0]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 da_monitor_start(&T->rv=
[n])
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* no timer_setup */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monitoring=3D1=C2=
=A0 <----
> > =C2=A0 tracepoint_synchronize_unregister()
> > =C2=A0 // CPU 1 probe has already returned; sync returns
> >=20
> > Later, enable_stall() acquires the same slot and calls da_monitor_init(=
):
> >=20
> > =C2=A0 da_monitor_reset_all()
> > =C2=A0=C2=A0=C2=A0 da_monitor_reset(&T->rv[slot])=C2=A0=C2=A0=C2=A0 // =
monitoring=3D1, timer.function=3D=3D0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ha_monitor_reset_env()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ha_cancel_timer()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timer_delete(&ha=
_mon->timer)=C2=A0 // ODEBUG: timer never initialised
> >=20
> > =C2=A0 ODEBUG: assert_init not available (active state 0)
> > =C2=A0 object type: timer_list
> > =C2=A0 Call trace: timer_delete <- da_monitor_reset_all <- enable_stall
> >=20
> > Call tracepoint_synchronize_unregister() inside da_monitor_destroy()
> > before da_monitor_reset_all().=C2=A0 The unregister_trace_xxx() calls i=
n the
> > monitor's disable() have already disconnected the tracepoints; the sync
> > here drains any handler still in flight, so no new monitoring=3D1 can
> > appear after da_monitor_reset_all() clears the slot.
> >=20
> > Also fix the slot release ordering: release the slot only after
> > reset_all() to avoid accessing rv[] with an out-of-bounds index.
> >=20
> > Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
> > Signed-off-by: Wen Yang <wen.yang@linux.dev>
> > ---
>=20
> Thanks for the fix, I have a similar one waiting for submission.
>=20
> These are technically 2 separate fixes though: the ordering with unset
> task_mon_slot (independent on HA) and the synchronisation with pending
> tracepoints. They probably deserve separate patches and visibility, the f=
irst
> has always been around and we're technically overwriting who knows what.
>=20
>=20
> The explanation above is a bit hard to follow though, are you talking abo=
ut a
> handler for the same (stall) monitor running after the reset, effectively
> undoing it by setting the monitoring flag?
>=20
> Then this is indeed an issue with ha_monitor_reset_env() which expects a =
clean
> environment.
>=20
> So that's basically what you'd see now much more often because in fact we
> don't
> reset the right slot (though, again, that's a different issue).
>=20
>=20
> Calling tracepoint_synchronize_unregister() there too would surely fix, b=
ut it
> used to be kinda slow. But it's probably gotten faster since now tracepoi=
nts
> use
> SRCU, so we can wait for a dedicated grace period.
>=20
> I liked the idea to wait cumulatively in the end, but that's just making
> things
> harder.. Let's do like this:
>=20
> Prepare 2 separate patches as fixes, put the task slot one first (would e=
ase
> backporting), mention this issue with the race condition only in the seco=
nd.
> You can send them independently and I'll add them to the tree as urgent.
>=20
>=20
> I'm soon going to send my set of fixes that will also include the task sl=
ot
> patch (not removing to ease my life with conflicts).
>=20
> Thanks,
> Gabriele
>=20
> > =C2=A0include/rv/da_monitor.h | 18 ++++++++++++++++--
> > =C2=A01 file changed, 16 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> > index 00ded3d5ab3f..d04bb3229c75 100644
> > --- a/include/rv/da_monitor.h
> > +++ b/include/rv/da_monitor.h
> > @@ -304,6 +304,20 @@ static int da_monitor_init(void)
> > =C2=A0
> > =C2=A0/*
> > =C2=A0 * da_monitor_destroy - return the allocated slot
> > + *
> > + * Call tracepoint_synchronize_unregister() before reset_all() to clos=
e
> > + * the race where an in-flight non-HA probe handler sets monitoring=3D=
1
> > + * (without calling timer_setup()) after da_monitor_reset_all() has
> > + * already cleared the slot but before the caller's own sync completes=
.
> > + * Without this barrier, an HA_TIMER_WHEEL monitor that later acquires
> > + * the same slot would call timer_delete() on a never-initialised
> > + * timer_list, triggering ODEBUG warnings.
> > + *
> > + * Note: tracepoint_synchronize_unregister() is a system-wide barrier
> > + * that waits for all CPUs to finish any in-flight tracepoint handlers=
.
> > + * The caller's own __rv_disable_monitor() issues a second sync after
> > + * returning from disable(); that redundant call is harmless on the
> > + * infrequent admin (enable/disable) path.
> > =C2=A0 */
> > =C2=A0static inline void da_monitor_destroy(void)
> > =C2=A0{
> > @@ -311,10 +325,10 @@ static inline void da_monitor_destroy(void)
> > =C2=A0=09=09WARN_ONCE(1, "Disabling a disabled monitor: "
> > __stringify(MONITOR_NAME));
> > =C2=A0=09=09return;
> > =C2=A0=09}
> > +=09tracepoint_synchronize_unregister();
> > +=09da_monitor_reset_all();
> > =C2=A0=09rv_put_task_monitor_slot(task_mon_slot);
> > =C2=A0=09task_mon_slot =3D RV_PER_TASK_MONITOR_INIT;
> > -
> > -=09da_monitor_reset_all();
> > =C2=A0}
> > =C2=A0
> > =C2=A0#elif RV_MON_TYPE =3D=3D RV_MON_PER_OBJ

