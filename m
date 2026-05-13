Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7789F195811
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778664696; cv=none; b=Nh548f46GJIuvESpjpUx5uLQmjzbIs1OJ0GuIOKIa2Fs1qfIL3+7DNeRDmfaW9GMkCU1TDORIztEhK1JpYXF0mR4GXNV6cBtkLxWy2eKHQlTHTI9Vt1WgkWfNoWBC4ya2Cd/XLMftkc78JvV8y91dSkF0fPHO4RuMb/1Lv6fTt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778664696; c=relaxed/simple;
	bh=HfrrePNjXPb8lWJQRQpFEci02fjSu/vu0PgQYVnIppk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sU8i5A0ELVN6sh+YahRwKIXNNTVBQs5t/IAlKbejM7ddkaxSh/4NrT77VC2QqFelarA/RLQhiVAkaqrzT10ZIeB+BbDwW09q5m5tVq2BPAph6A+FJf5WFbM8TDuPZZuo8zhuOEzWH0SIVem20LKwxUxxsdY4VTfz79b/xX/vjv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsuQvfbq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsuQvfbq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778664693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HfrrePNjXPb8lWJQRQpFEci02fjSu/vu0PgQYVnIppk=;
	b=gsuQvfbq5Z0/KO8T3ykWeCxevwnAxX7+37vh3w4zfWYYWm5pjpRuAjpEJpTV25LBfDgqxH
	vrVol1lZ4KejCN/1x1J67SLv6mYzZ37+cOUeJrwrXH5K1HudHKTOR7cZGfw10Ebe4OCJnN
	GZudrhxwyEGwXM2OqaxS4EcdZtepcTQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-2V1eVHoxMLyYbLNiVruFAQ-1; Wed, 13 May 2026 05:31:32 -0400
X-MC-Unique: 2V1eVHoxMLyYbLNiVruFAQ-1
X-Mimecast-MFC-AGG-ID: 2V1eVHoxMLyYbLNiVruFAQ_1778664691
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488d3eec9bcso47139635e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 02:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778664691; x=1779269491;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9n2IgyZqpJfs0Yeip0ZAGShA1zXFX+3dWz5lTELV1IE=;
        b=oYd6aq4oUuvZUKGRqYDD21yOjPZFycSTHNDrZDHtln12BG7/LYbtRfsGXS9ZuK3vze
         BzLOhauwcp6bYy2ZAf541e301cTqo3NlRXsJB5LavKTxbhhuV5bbOuXAOBiG5L4FyAeg
         3S92GfwDlRF5BpXTaQDm+cF6oFbmKUo+M/325hJs341an7yfdzBJj82vgVbg4pGN1j7B
         hZMhCcjnSsBOX2S+LepYDCXBn4L1m/Zccbc6/kaTOC8aR4eFMQiMFbAHeZd5mc8uf/pp
         3CKJgw7rOAj0FcHeY9TIhAqiksSq2rUSKO48w0J8QzxWE+Jc+DL1IkPHOYTrj0PKSRPd
         KFeQ==
X-Gm-Message-State: AOJu0YwG7OLM9wxoqq/Mc7DY/JSElbe3mmx5hlna4LArnOsp98m1hYt7
	CaJOWzFcR6vNwUCENZRbaHy2PumI0C00e/s2ayx1ErGB6FLmbbVvYeAwUgkGgkZRVTHcgXz640g
	k0AMCOCeU0WlGFxUkH0eO0lCCACQzdC7eR7qdImMjWMpFe98vEmnP15qhvmaP0KoEg1PZOwVhi9
	YDcWvbzRp+
X-Gm-Gg: Acq92OGxDcJeEhMCr2w7u+LjPZApxNyDsylq+6oM9eBkN3P93VBy6EF9UsHGr0/KgGe
	oIoaHYJh0qJh36Np2YNxQKz8AlQpNzVP4xPpI3A6LdgooiIOK6pqcOlTXU8RvrTvqe8JJfi/E/z
	S3QLJgilqhFymDaUUlpbz9RyFiapR937LOA22FaIe5Xwx+4QPvG+UWYr9gqQYcUjlw5v2CW6gDK
	2uBPV2PJHb1VZx+OqHe6JRI7pYiOxfEN4aeuy0GtcXUtibZBeBkAKzCcsY04igVILFK6hId+F0D
	gIxWzmtfMLoN2A/+1n2V6ld+oeeeW7Ev4cdrrJdXZZTlFbEHii7D9hIj3efywFqW051mR/yMjcX
	yfQ8U842JkCt7EM4q2bSmbzaMspgY7o2b8qrfGtWHAzT+SZ9O0iA3m21hL6iuf5K2cU8R7S8eyH
	tBsXSvGo5+l5rMr3Q=
X-Received: by 2002:a05:600c:3051:b0:48f:d2fc:d025 with SMTP id 5b1f17b1804b1-48fd2fcd11emr5041755e9.6.1778664690938;
        Wed, 13 May 2026 02:31:30 -0700 (PDT)
X-Received: by 2002:a05:600c:3051:b0:48f:d2fc:d025 with SMTP id 5b1f17b1804b1-48fd2fcd11emr5041405e9.6.1778664690551;
        Wed, 13 May 2026 02:31:30 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f43c31dsm38451965e9.25.2026.05.13.02.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:31:30 -0700 (PDT)
Message-ID: <67839f35b6331c4623d60281ff1c26513117bf3d.camel@redhat.com>
Subject: Re: [RFC PATCH v2 02/10] rv/da: fix per-task da_monitor_destroy()
 ordering and sync
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Date: Wed, 13 May 2026 11:31:28 +0200
In-Reply-To: <cb929b8b-5bfb-4afe-ba50-45620c38ea96@linux.dev>
References: <cover.1778522945.git.wen.yang@linux.dev>
	 <d02c656aada7d071f083460a5c9a454363669b61.1778522945.git.wen.yang@linux.dev>
	 <f654a17c671469fd8fc9ea438daf2266d05068d4.camel@redhat.com>
	 <8e80cbcf739304de95356f1fac677261628977fa.camel@redhat.com>
	 <cb929b8b-5bfb-4afe-ba50-45620c38ea96@linux.dev>
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
X-Mimecast-MFC-PROC-ID: o51lc8I6fxKVR_7Ic1rg_3sx3OAxKua1QxEUT4vjyOk_1778664691
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-05-13 at 13:32 +0800, Wen Yang wrote:
> Thanks for both messages.=C2=A0 Two patches are ready; let me address
> your follow-up concerns before sending.
>=20
> =C2=A0=C2=A0 1. "all monitors reusing slots would suffer from it"
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Only RV_MON_PER_TASK uses the rv_get/put_t=
ask_monitor_slot()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pool.=C2=A0 RV_MON_GLOBAL and RV_MON_PER_C=
PU each have dedicated
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 storage (a single static variable and a pe=
r-cpu variable) and
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 never share slots across monitor types.=C2=
=A0 The race is exclusive
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to PER_TASK, so fixing that variant's da_m=
onitor_destroy() is
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the correct scope.
>=20
> =C2=A0=C2=A0 2. "LTL monitors don't even have monitoring"
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracepoint_synchronize_unregister() does n=
ot rely on the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monitoring flag at all.=C2=A0 It is a syst=
em-wide barrier =E2=80=94 it
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 calls synchronize_rcu_tasks_trace() follow=
ed by
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 synchronize_srcu(&tracepoint_srcu) =E2=80=
=94 draining every in-flight
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracepoint handler on every CPU regardless=
 of which monitor
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dispatched it.=C2=A0 LTL handlers are cove=
red without any special
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 treatment.
>=20
> The slot-ordering issue (patch 1) affects all per-task DA monitors,
> not only HA ones =E2=80=94 "independent on HA" =E2=80=94 because
> RV_PER_TASK_MONITOR_INIT equals CONFIG_RV_PER_TASK_MONITORS (one
> past the end of rv[]), so da_monitor_reset_all() overwrites whatever
> follows rv[] in task_struct whenever any per-task monitor is
> disabled.

Exactly, and since whatever follows .rv is randomised on a task_struct, thi=
s can
get quite nasty.

I included my version of the fix in the series in [1], but feel free to sen=
d
yours, you got there first ;)

>=20
> Also corrected "wwnr probe handler" to "stall probe handler" in
> patch 2 per your annotation.
>=20

While tracepoint_synchronize_unregister() does fix the race, I still see a =
timed
bomb in the way we do ha_monitor_reset_env().

Since we reused the same slots for per-task monitors (not for the others, y=
ou're
right I was brainfarting) we essentially don't know what happened before we=
 do
da_monitor_init(), the same slot could have been used by an LTL monitor whi=
ch
cannot even reliably clear the byte used by the monitoring flag.

Now, we either mandate all monitors to memset the entire slot (union
rv_task_monitor) or we don't assume anything about the slot's state during
initialisation. Any middle ground could reveal pesky bugs as soon as we ref=
actor
the structs.

The latter idea is what I did in [1]. I believe that would make the
synchronisation superfluous.

What do you think?

Thanks,
Gabriele

[1] - https://lore.kernel.org/lkml/20260512140250.262190-8-gmonaco@redhat.c=
om

> Please let me know if the above reasoning addresses your concerns.
>=20
>=20
> --
> Best wishes,
> Wen
>=20
> > >=20
> > > > =C2=A0=C2=A0include/rv/da_monitor.h | 18 ++++++++++++++++--
> > > > =C2=A0=C2=A01 file changed, 16 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> > > > index 00ded3d5ab3f..d04bb3229c75 100644
> > > > --- a/include/rv/da_monitor.h
> > > > +++ b/include/rv/da_monitor.h
> > > > @@ -304,6 +304,20 @@ static int da_monitor_init(void)
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0/*
> > > > =C2=A0=C2=A0 * da_monitor_destroy - return the allocated slot
> > > > + *
> > > > + * Call tracepoint_synchronize_unregister() before reset_all() to =
close
> > > > + * the race where an in-flight non-HA probe handler sets monitorin=
g=3D1
> > > > + * (without calling timer_setup()) after da_monitor_reset_all() ha=
s
> > > > + * already cleared the slot but before the caller's own sync compl=
etes.
> > > > + * Without this barrier, an HA_TIMER_WHEEL monitor that later acqu=
ires
> > > > + * the same slot would call timer_delete() on a never-initialised
> > > > + * timer_list, triggering ODEBUG warnings.
> > > > + *
> > > > + * Note: tracepoint_synchronize_unregister() is a system-wide barr=
ier
> > > > + * that waits for all CPUs to finish any in-flight tracepoint hand=
lers.
> > > > + * The caller's own __rv_disable_monitor() issues a second sync af=
ter
> > > > + * returning from disable(); that redundant call is harmless on th=
e
> > > > + * infrequent admin (enable/disable) path.
> > > > =C2=A0=C2=A0 */
> > > > =C2=A0=C2=A0static inline void da_monitor_destroy(void)
> > > > =C2=A0=C2=A0{
> > > > @@ -311,10 +325,10 @@ static inline void da_monitor_destroy(void)
> > > > =C2=A0=C2=A0=09=09WARN_ONCE(1, "Disabling a disabled monitor: "
> > > > __stringify(MONITOR_NAME));
> > > > =C2=A0=C2=A0=09=09return;
> > > > =C2=A0=C2=A0=09}
> > > > +=09tracepoint_synchronize_unregister();
> > > > +=09da_monitor_reset_all();
> > > > =C2=A0=C2=A0=09rv_put_task_monitor_slot(task_mon_slot);
> > > > =C2=A0=C2=A0=09task_mon_slot =3D RV_PER_TASK_MONITOR_INIT;
> > > > -
> > > > -=09da_monitor_reset_all();
> > > > =C2=A0=C2=A0}
> > > > =C2=A0=20
> > > > =C2=A0=C2=A0#elif RV_MON_TYPE =3D=3D RV_MON_PER_OBJ
> >=20

