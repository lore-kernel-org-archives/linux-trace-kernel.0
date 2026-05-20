Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945713E0255
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779276138; cv=none; b=SXGvDsal9dodlmohNURFrt2O2SBTbelf0AaMWEgnNl/h1QYwLZ2o5cuM1HdMvN+yZBNKE41zywADMlh2DZGzRNh+dH7uZ9UuvEBwHeQeOZisyMkVtOAffAKRa5rH+G/NQHlEaWhAyYo4G4O1DzvVy/LWA0jJdmtnVN6PqUkuBSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779276138; c=relaxed/simple;
	bh=uD/RxaR6GLunIToCcvEcskCZg8RIXI01nR5aFxx/+b0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnEi8PR9fWQBvTtj3LC3o7CjhQR4NKP0Rr59sGEk8T3bXKpeyJryb6WrJSkHP4ZpjEn1UENmCr7PuFoTxUFC5uGPthF/qlL3sx6BkV81URsNjZvX+jaEk+ihCmZV/H+FirDg6/8HTkp5lsC+L2pSMzyakYnjnywhaGDw3nYmI70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHHyq8k7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHHyq8k7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779276134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uD/RxaR6GLunIToCcvEcskCZg8RIXI01nR5aFxx/+b0=;
	b=jHHyq8k7vq8nF7iN5NjQ6oMkmGGBaJf8zGZWKl+UyOumXrAPQ72Tmxo/03n+w2DmKcBPH/
	VsHIyOrPc+z8zBwXSjUJmynY+jE3BOC5pLjBZlsmKEGs6mkwy3czMcoA6pb4WTqyMw9dw2
	mykn4d1nqtiJX9HHuTWmHaT/l0r2H1U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-LLgRjaGcMa6tqaEIqq1xQQ-1; Wed, 20 May 2026 07:22:13 -0400
X-MC-Unique: LLgRjaGcMa6tqaEIqq1xQQ-1
X-Mimecast-MFC-AGG-ID: LLgRjaGcMa6tqaEIqq1xQQ_1779276132
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44d83e45febso3921201f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 04:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779276132; x=1779880932;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPwOMoB8ht/87MdxXd74PQwxTtZ3qHGDKBpwO7djAzw=;
        b=WX3AMUh2vACqScNhl+3im19+kApqPZZbrs3yPbek7xr3dS3WWqeolEiw82xWMJBuLm
         7zWm+LW/L4O6exZ2oHF46g32iFCf9KpzTp51WcXkhS/KNYYKHwAJhyQNpN6EPASX9Pyd
         hJ6FhlbeNLQy7/0e6qMlzf+58coOrgkU3z5GayVghb2mOSNnY0MvtJZBhKDdKtD5tD2u
         BwqLUh76THasYmuRlImOuNWr+OjKvaOKZLNhnp2bjLY4fuaj6u6lHmMu6i+YV4f7FuCw
         2ALcX4jDewoR5SKovRWfU6KEE4sD78G+aA3ol5yd2NAEDCcMmXYeQcr4MKFUFbMpuLtg
         G8vQ==
X-Forwarded-Encrypted: i=1; AFNElJ8XpbA3fNLJ52Hu1rzYxJOH42HzcfxNb7f8TthHCOpFApjsxqS25GrzMj7mufpoK0QA9xRDbIk0P6gk6AC5GBZfcHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe/FZl52QGBuw/QQwCpYnAHPtiOb3tz2MKfme93yfyR1u9G3Ri
	rPYqp3+A2mGeluUnFD1mds7f0xzWIGOVQWKxeSjXwd1XfXvqJ2ij6Nt7Jf568iWAJ+cU+171yKv
	RhTfj0eUxXMvxJUqGgt7fJIwSiNom3ZMOtZvi22eRsx5uARQ0fXN9d2ZKCx5dpVDaUDBudD3FDw
	==
X-Gm-Gg: Acq92OGQdc2q8MDjbDnGWKN/q6nX2859pAWSQOcNMaAeXFRysIWeLyaZk1hySmwyWbc
	Yl20G9BGGqt+6Ej6uMFf1Fc0JsdmFkKwVgxNbdCi6qfa9qiFBmjYURvpHl+eSfba1J2z5kIDbTf
	/9b5fjyrMlJOs+xlNsE6uxa/qZ2KH73OCOZ7XFrEQhWXDO7TDqybljMbBuOQBLh6H6F8sUa7hCd
	E6yJj/rmKce0DMvTCvwe9zI7ssSJss6ZWpMjK+PwSW7FiHspl71BYkhq9mwcX9zhpOcBOlNKkiv
	RWKiXb+dgMrag5zMkSPVPITtn+3Zv30vbLKt6epSeGuKhaUCO+OA5lcNLEKS7kt/GY402SXyK21
	vrDzsOWWmL9D8b/fncQY5IryhzVlTIdA9/HHZILCIj4GQjH1CajbJKm2WX43AQ/85jmaP6XC4rE
	9T9TOLrsStRSmlIz0Re3CqyZyXPw==
X-Received: by 2002:a05:600c:83c7:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-48fe53a8eccmr356808035e9.16.1779276131688;
        Wed, 20 May 2026 04:22:11 -0700 (PDT)
X-Received: by 2002:a05:600c:83c7:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-48fe53a8eccmr356807435e9.16.1779276131207;
        Wed, 20 May 2026 04:22:11 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe248dsm52513736f8f.30.2026.05.20.04.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 04:22:10 -0700 (PDT)
Message-ID: <1d7268da9c74d99c84a83d7039e67a9f0da14d98.camel@redhat.com>
Subject: Re: [PATCH 6/9] rv: Ensure synchronous cleanup for HA monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Nam
 Cao	 <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org
Date: Wed, 20 May 2026 13:22:09 +0200
In-Reply-To: <5f8ceba5-ec25-4c19-a74b-ed98715e89b6@linux.dev>
References: <20260512140250.262190-1-gmonaco@redhat.com>
	 <20260512140250.262190-7-gmonaco@redhat.com>
	 <b7d760dc-162a-48e8-af75-e566bfa46493@linux.dev>
	 <88a6fc5c08d18e3c1f6d29dc106db80fa688bf87.camel@redhat.com>
	 <5f8ceba5-ec25-4c19-a74b-ed98715e89b6@linux.dev>
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
X-Mimecast-MFC-PROC-ID: q5c6PcgosgyKd9kX1G8tLSGhy751Y5WpXFXan3ZoRKU_1779276132
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-05-20 at 00:48 +0800, Wen Yang wrote:
> The goal is right.=C2=A0 One thing worth double-checking is the load orde=
r
> in the callback against the "SMP BARRIER PAIRING" section of
> Documentation/memory-barriers.txt, which states:
>=20

Yeah I realised that after I sent my answer.. You might have noticed but I
proposed a version using acquire/release semantics in [1].

I'm waiting to send it all in a V2 for the fixes series.

Are you going to send your patch with tracepoint_synchronize_unregister() i=
n the
per-task destruction (can be a patch alone)?

If not I'll do it myself and append that too, I prefer to have everything
together to avoid conflict resolution issues.

Thanks,
Gabriele

[1] -
https://lore.kernel.org/lkml/02c522f2a09183c9e1a6ff5b0110d0d5cc5e35bd.camel=
@redhat.com/

> =C2=A0=C2=A0 [!] Note that the stores before the write barrier would norm=
ally be
> =C2=A0=C2=A0 expected to match the loads after the read barrier or the
> =C2=A0=C2=A0 address-dependency barrier, and vice versa ...
>=20
> So, we should to swap the read order in the callback so that it matches
> the standard pattern:
>=20
> =C2=A0=C2=A0 void __ha_monitor_timer_callback() {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guard(rcu)();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 curr_state =3D READ_ONCE=
(ha_mon->da_mon.curr_state);=C2=A0 /* B:=20
> before rmb */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smp_rmb();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(!da_monitor=
ing(&ha_mon->da_mon)))=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* A:=20
> after rmb */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Reached here: mo=
nitoring =3D 1 (old_A).
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Standard wmb/rmb=
 guarantee: curr_state (read before rmb) is also
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * old, i.e. not in=
itial_state.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ha_react(curr_state, EVE=
NT_NONE, env_string.buffer);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0 void da_monitor_reset() {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 da_monitor_reset_hook(da=
_mon);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WRITE_ONCE(da_mon->monit=
oring, 0);=C2=A0=C2=A0 /* A: before wmb */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smp_wmb();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WRITE_ONCE(da_mon->curr_=
state, model_get_initial_state());=C2=A0 /*=20
> B: after wmb */
> =C2=A0=C2=A0 }
>=20
>=20
>=20
> --
> Best wishes,
> Wen
>=20
> >=20
> > [1] -
> > https://lore.kernel.org/lkml/8af5ba4bd93d2acb8a546e8e47ced974a87c1eb8.1=
778522945.git.wen.yang@linux.dev
> >=20
> > >=20
> > >=20
> > > --
> > > Best wishes,
> > > Wen
> > >=20
> > >=20
> > > On 5/12/26 22:02, Gabriele Monaco wrote:
> > > > HA monitors may start timers, all cleanup functions currently stop =
the
> > > > timers asynchronously to avoid sleeping in the wrong context.
> > > > Nothing makes sure running callbacks terminate on cleanup.
> > > >=20
> > > > Run the entire HA timer callback in an RCU read-side critical secti=
on,
> > > > this way we can simply synchronize_rcu() with any pending timer and=
 are
> > > > sure any cleanup using kfree_rcu() runs after callbacks terminated.
> > > > Additionally make sure any unlikely callback running late won't run=
 any
> > > > code if the monitor is marked as disabled.
> > > >=20
> > > > Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
> > > > Fixes: 4a24127bd6cb ("rv: Add support for per-object monitors in DA=
/HA")
> > > > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > > > ---
> > > > =C2=A0=C2=A0 include/rv/da_monitor.h | 23 +++++++++++++++++++----
> > > > =C2=A0=C2=A0 include/rv/ha_monitor.h | 18 ++++++++++++++++--
> > > > =C2=A0=C2=A0 2 files changed, 35 insertions(+), 6 deletions(-)
> > > >=20
> > > > diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> > > > index a4a13b62d1a4..402d3b935c08 100644
> > > > --- a/include/rv/da_monitor.h
> > > > +++ b/include/rv/da_monitor.h
> > > > @@ -57,6 +57,15 @@ static struct rv_monitor rv_this;
> > > > =C2=A0=C2=A0 #define da_monitor_reset_hook(da_mon)
> > > > =C2=A0=C2=A0 #endif
> > > > =C2=A0=C2=A0=20
> > > > +/*
> > > > + * Hook to allow the implementation of hybrid automata: define it =
with
> > > > a
> > > > + * function that waits for the termination of all monitors backgro=
und
> > > > + * activities (e.g. all timers). This hook can sleep.
> > > > + */
> > > > +#ifndef da_monitor_sync_hook
> > > > +#define da_monitor_sync_hook()
> > > > +#endif
> > > > +
> > > > =C2=A0=C2=A0 /*
> > > > =C2=A0=C2=A0=C2=A0 * Type for the target id, default to int but can=
 be overridden.
> > > > =C2=A0=C2=A0=C2=A0 * A long type can work as hash table key (PER_OB=
J) but will be
> > > > downgraded
> > > > to
> > > > @@ -179,6 +188,7 @@ static inline int da_monitor_init(void)
> > > > =C2=A0=C2=A0 static inline void da_monitor_destroy(void)
> > > > =C2=A0=C2=A0 {
> > > > =C2=A0=C2=A0=C2=A0=09da_monitor_reset_all();
> > > > +=09da_monitor_sync_hook();
> > > > =C2=A0=C2=A0 }
> > > > =C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0 #ifndef da_implicit_guard
> > > > @@ -232,6 +242,7 @@ static inline int da_monitor_init(void)
> > > > =C2=A0=C2=A0 static inline void da_monitor_destroy(void)
> > > > =C2=A0=C2=A0 {
> > > > =C2=A0=C2=A0=C2=A0=09da_monitor_reset_all();
> > > > +=09da_monitor_sync_hook();
> > > > =C2=A0=C2=A0 }
> > > > =C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0 #ifndef da_implicit_guard
> > > > @@ -319,6 +330,7 @@ static inline void da_monitor_destroy(void)
> > > > =C2=A0=C2=A0=C2=A0=09}
> > > > =C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0=09da_monitor_reset_all();
> > > > +=09da_monitor_sync_hook();
> > > > =C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0=09rv_put_task_monitor_slot(task_mon_slot);
> > > > =C2=A0=C2=A0=C2=A0=09task_mon_slot =3D RV_PER_TASK_MONITOR_INIT;
> > > > @@ -497,10 +509,9 @@ static void da_monitor_reset_all(void)
> > > > =C2=A0=C2=A0=C2=A0=09struct da_monitor_storage *mon_storage;
> > > > =C2=A0=C2=A0=C2=A0=09int bkt;
> > > > =C2=A0=C2=A0=20
> > > > -=09rcu_read_lock();
> > > > +=09guard(rcu)();
> > > > =C2=A0=C2=A0=C2=A0=09hash_for_each_rcu(da_monitor_ht, bkt, mon_stor=
age, node)
> > > > =C2=A0=C2=A0=C2=A0=09=09da_monitor_reset(&mon_storage->rv.da_mon);
> > > > -=09rcu_read_unlock();
> > > > =C2=A0=C2=A0 }
> > > > =C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0 static inline int da_monitor_init(void)
> > > > @@ -516,13 +527,17 @@ static inline void da_monitor_destroy(void)
> > > > =C2=A0=C2=A0=C2=A0=09int bkt;
> > > > =C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0=09tracepoint_synchronize_unregister();
> > > > +=09scoped_guard(rcu) {
> > > > +=09=09hash_for_each_rcu(da_monitor_ht, bkt, mon_storage,
> > > > node) {
> > > > +=09=09=09da_monitor_reset_hook(&mon_storage->rv.da_mon);
> > > > +=09=09}
> > > > +=09}
> > > > +=09da_monitor_sync_hook();
> > > > =C2=A0=C2=A0=C2=A0=09/*
> > > > =C2=A0=C2=A0=C2=A0=09 * This function is called after all probes ar=
e disabled and no
> > > > longer
> > > > =C2=A0=C2=A0=C2=A0=09 * pending, we can safely assume no concurrent=
 user.
> > > > =C2=A0=C2=A0=C2=A0=09 */
> > > > -=09synchronize_rcu();
> > > > =C2=A0=C2=A0=C2=A0=09hash_for_each_safe(da_monitor_ht, bkt, tmp, mo=
n_storage, node)
> > > > {
> > > > -=09=09da_monitor_reset_hook(&mon_storage->rv.da_mon);
> > > > =C2=A0=C2=A0=C2=A0=09=09hash_del_rcu(&mon_storage->node);
> > > > =C2=A0=C2=A0=C2=A0=09=09kfree(mon_storage);
> > > > =C2=A0=C2=A0=C2=A0=09}
> > > > diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> > > > index d59507e8cb30..47ff1a41febe 100644
> > > > --- a/include/rv/ha_monitor.h
> > > > +++ b/include/rv/ha_monitor.h
> > > > @@ -36,6 +36,7 @@ static bool ha_monitor_handle_constraint(struct
> > > > da_monitor
> > > > *da_mon,
> > > > =C2=A0=C2=A0 #define da_monitor_event_hook ha_monitor_handle_constr=
aint
> > > > =C2=A0=C2=A0 #define da_monitor_init_hook ha_monitor_init_env
> > > > =C2=A0=C2=A0 #define da_monitor_reset_hook ha_monitor_reset_env
> > > > +#define da_monitor_sync_hook() synchronize_rcu()
> > > > =C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0 #include <rv/da_monitor.h>
> > > > =C2=A0=C2=A0 #include <linux/seq_buf.h>
> > > > @@ -237,12 +238,25 @@ static bool ha_monitor_handle_constraint(stru=
ct
> > > > da_monitor *da_mon,
> > > > =C2=A0=C2=A0=C2=A0=09return false;
> > > > =C2=A0=C2=A0 }
> > > > =C2=A0=C2=A0=20
> > > > +/*
> > > > + * __ha_monitor_timer_callback - generic callback representation
> > > > + *
> > > > + * This callback runs in an RCU read-side critical section to allo=
w the
> > > > + * destruction sequence to easily synchronize_rcu() with all pendi=
ng
> > > > timer
> > > > + * after asynchronously disabling them.
> > > > + */
> > > > =C2=A0=C2=A0 static inline void __ha_monitor_timer_callback(struct =
ha_monitor
> > > > *ha_mon)
> > > > =C2=A0=C2=A0 {
> > > > -=09enum states curr_state =3D READ_ONCE(ha_mon->da_mon.curr_state)=
;
> > > > =C2=A0=C2=A0=C2=A0=09DECLARE_SEQ_BUF(env_string, ENV_BUFFER_SIZE);
> > > > -=09u64 time_ns =3D ha_get_ns();
> > > > +=09enum states curr_state;
> > > > +=09u64 time_ns;
> > > > +
> > > > +=09if (unlikely(!da_monitor_handling_event(&ha_mon->da_mon)))
> > > > +=09=09return;
> > > > =C2=A0=C2=A0=20
> > > > +=09guard(rcu)();
> > > > +=09curr_state =3D READ_ONCE(ha_mon->da_mon.curr_state);
> > > > +=09time_ns =3D ha_get_ns();
> > > > =C2=A0=C2=A0=C2=A0=09ha_get_env_string(&env_string, ha_mon, time_ns=
);
> > > > =C2=A0=C2=A0=C2=A0=09ha_react(curr_state, EVENT_NONE, env_string.bu=
ffer);
> > > > =C2=A0=C2=A0=C2=A0=09ha_trace_error_env(ha_mon, model_get_state_nam=
e(curr_state),
> >=20

