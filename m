Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39F6327C18
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782809316; cv=none; b=TkcGhE0i3Nw+qyEl3/d2KbMYG8DPhTtvRIhLPQSHfn38kRe54ggS3e3eBFBmOAk64537b5WLlmqa4+R6DLIcE4RcdWnBuzb2qIS6d+OHJSIhpvaklMJPg5XFDqIUgCtnp/gNa1vbGrMpoYrwAIjNXfge3KwAwggTjbrux64zTnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782809316; c=relaxed/simple;
	bh=m4BouL0UZrVRx8mJf3NJdDgw3CZPevJ+PFi28laxN7Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oenRbQQ2rsU72YQrl4D+onjhuaIFwOE8zh6Tm0G4K+wyuupvE4FBhCpTpIaAyqJLcl3vryCxK3K6fTpatmTi2modzSV01HgD6Nxd7IDDzKF2oV2VHb7fluZmhT/dUOnjRxtej+B1ZAhaWeOlqpvyqt4TFmIa8wz+gVaOcmR64GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QwM9TNf3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QwM9TNf3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782809312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m4BouL0UZrVRx8mJf3NJdDgw3CZPevJ+PFi28laxN7Q=;
	b=QwM9TNf39wTmsDhZ/B+Leiry++DytkL2YIh9QzdVAfCRf39/tHvYWwkCh9aY0gJuwrpXnm
	SY81MG7sjHpkMbacQoYM1ILS5cERCF3QfDqVQKo4TfaCj2v/4NCmIBgzJfyLzQ6XwKh04s
	pfC8VCgAsSemO0ErTA3JkJBk3eT1oLU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-WZLb9Wr2N-GdliKUXz0NOg-1; Tue, 30 Jun 2026 04:48:29 -0400
X-MC-Unique: WZLb9Wr2N-GdliKUXz0NOg-1
X-Mimecast-MFC-AGG-ID: WZLb9Wr2N-GdliKUXz0NOg_1782809308
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493bb6a4336so3085275e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 01:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782809308; x=1783414108;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bJxrnM2KFSiN+0oOuCzSeDSBRcSTj2/OBxlo/Vc/3g=;
        b=O9rqXeAbbu40oXPrAqVKkIIcbMvcmgkAB28H89uqcuxbzugrZG2NVtqtfV27CcWzUZ
         MeYvQGOOOkPkpKWFp07rmWbbsDr+WYTaK0gsNAaRA7pCOJvTj4S6cTeNWmG7d78i9H7z
         Iwp+JOR8lHLxwOe+ySE4BwML4uZQctiKqDXAu8RNUJ1leBvMjPYyI8K6XOmoScejQB/e
         4fg8m572QC1ZioGd/VrBZduQLLpN7XQGow1EHu68sXy53Cecop2Kg34KsRB+DG2oUIKT
         QbpYdicojOm5Zrl5F6stWRCzRARVDypbCl9IfnFbemF8bEOZXGWz+ueljeBeA1TtS5d1
         JZBA==
X-Gm-Message-State: AOJu0Yx+MaNPM8j+0OwH2Wc43hLjs+QvT7QkdaLpjhtlxKn5lhitItZ8
	cKTjAYBMSmuLwiO2IGpnoGSB8D/jDxfLFuPntEaDCDJx8TLAxmFvrIE3J47jwoMBTmpqPsalo+z
	eKBEotK+EDCKoZUVWNGUK65VWLvvJck3FPClqw/OZac624YaSrAcH8lFcOg77+fzt/Uf0akZ3JA
	==
X-Gm-Gg: AfdE7ck7G5u1Fsj2GKl98vMTJiE+TOkTAPWej5LtPo9dwI73L1VJTIkJ6vYbOyudIzZ
	lAfqjvaZBfdx7OdqkHeS+Ihjq41OMdwIS9+47s7YKdSN/d/JsqNrZRfV2hH6MtXyQ/GeKEhynwf
	kugGSW/MK3Xnflvfq3lj2gjUFibqovuJjrMz508BxMn8Z4Pi9LxHmXk04lBAfq1wQPhiafilpYl
	1lG5aU0aKmOHHiZz5B1DXEqwWmV5HtMak5SE5iTDg/sFI8OBNX6EJEjh2RgkFtbsO4Vh3QwBG+K
	cK7CxIPoG0OVm7EigY42Uj6dNYXUQhPiVGeboxyztw8XAERvVJhcBtm9CaOYWAMYNXx/Yqbumpw
	8J5He9qBnZTFedhFpTltwqPgNIQpPU42xtV9WFtysAnAnfZLaFYBO/fyoSRD1cYEHDzZqjGhWiX
	TPKr9z
X-Received: by 2002:a05:600c:c0c6:b0:492:63c3:8eeb with SMTP id 5b1f17b1804b1-493b82c0e2bmr34476095e9.35.1782809307959;
        Tue, 30 Jun 2026 01:48:27 -0700 (PDT)
X-Received: by 2002:a05:600c:c0c6:b0:492:63c3:8eeb with SMTP id 5b1f17b1804b1-493b82c0e2bmr34475685e9.35.1782809307380;
        Tue, 30 Jun 2026 01:48:27 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8cd303csm50976985e9.6.2026.06.30.01.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 01:48:26 -0700 (PDT)
Message-ID: <ebde84b7c65cd6b01a1e8d124de0b1eaf0793006.camel@redhat.com>
Subject: Re: [PATCH v3 2/9] rv: add generic uprobe infrastructure for RV
 monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 30 Jun 2026 10:48:25 +0200
In-Reply-To: <878be1d4-2f93-4fbd-a1f6-b2b7836c9c44@linux.dev>
References: <cover.1780847473.git.wen.yang@linux.dev>
	 <9d1a1d491af16853b2b421f358fd6cca965588ab.1780847473.git.wen.yang@linux.dev>
	 <a645534b04d9bf32f2c2caa5d2206bb87cfcb3e1.camel@redhat.com>
	 <878be1d4-2f93-4fbd-a1f6-b2b7836c9c44@linux.dev>
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
X-Mimecast-MFC-PROC-ID: VaytHW-sXPi-BJzGpd3KE_5IpWfmLeKvBPTa-W19QSg_1782809308
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-29 at 00:47 +0800, Wen Yang wrote:
> On [2-1]~[2-5]: embedded consumer causes UAF on PREEMPT_RT
> -----------------------------------------------------------
>=20
> The uprobe_bind selftest oopses on PREEMPT_RT(full):
>=20
> =C2=A0=C2=A0 handler_chain+0xc9: mov rax, [r15+0x18]=C2=A0 ; advance list=
 iterator
> =C2=A0=C2=A0 RAX: 000015ec00001f28=C2=A0=C2=A0 ; garbage =E2=80=94 &uprob=
e->consumers after kfree
>=20
> handler_chain() reads uc->cons_node.next after uc->handler() returns,
> still inside rcu_read_lock_trace().=C2=A0 That pointer is &uprobe->consum=
ers
> (the list head embedded in struct uprobe), which gets freed through:
>=20
> =C2=A0=C2=A0 put_uprobe()
> =C2=A0=C2=A0=C2=A0=C2=A0 -> schedule_work(uprobe_free_deferred)=C2=A0=C2=
=A0 /* async */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> call_srcu(&uretprobes_srcu,=
 ...)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> call_rcu_=
tasks_trace(kfree_uprobe)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 -> kfree(uprobe)
>=20
> rv_uprobe_sync() calls uprobe_unregister_sync() which calls
> synchronize_srcu(&uretprobes_srcu), but that only matters after the
> kworker has submitted work to uretprobes_srcu.=C2=A0 On a loaded PREEMPT_=
RT
> box the kworker may not have run yet, so synchronize_srcu() returns
> immediately and kfree(uprobe) races with the still-iterating
> handler_chain():
>=20
> =C2=A0=C2=A0 CPU A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU B
> =C2=A0=C2=A0 consumer_del() =E2=86=92 list_del_rcu=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 rcu_read_lock_trace()
> =C2=A0=C2=A0 put_uprobe()=C2=A0=C2=A0 =E2=86=92 schedule_work=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uc->handler() returns
> =C2=A0=C2=A0 rv_uprobe_sync():=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 reading cons_node.next...
> =C2=A0=C2=A0=C2=A0=C2=A0 synchronize_srcu(&uretprobes_srcu)

If CPU B is in an RCU trace read-side critical section this doesn't
return immediately, it returns after readers are done, doesn't it?
(well, what you really care here is the synchronize_rcu_tasks_trace()
but we do both).

> =C2=A0=C2=A0=C2=A0=C2=A0 =E2=86=90 idle; returns immediately
> =C2=A0=C2=A0 [kworker fires later]
> =C2=A0=C2=A0=C2=A0=C2=A0 kfree(uprobe)=C2=A0 =E2=86=90 frees &uprobe->con=
sumers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cons_node.next =3D freed mem =E2=86=92 CRASH
>=20

So I had a bit of a look and as far as I understand, we don't have any
control over the uprobe allocation pattern (workqueues and whatnot) and
we don't really care as long as we deregister it appropriately.

What we do control is the uprobe_consumer, that must be freed only after
the uprobe was synchronously deregistered, that should guarantee no
reader is going to reference it, shouldn't it?

uprobe_unregister_nosync() removes it from the cons_node list, so it's
safe to assume any handler_chain() after the next RCU-trace grace period
won't see it.

In the sketch I sent this is happening (all kfree(b) are after
rv_uprobe_unregister() which does the sync). What am I missing here?


uprobe is also freed after both grace periods, so no reader should use
that either.

The situation you're seeing isn't fully clear to me, I applied my sketch
and don't see any splat on a vng box.

> With uc embedded in the binding (as [2-1] suggests), no amount of
> delaying kfree(binding) helps: uprobe->consumers is freed by a chain we
> don't control.=C2=A0 The fix is to keep uc->cons_node in memory that outl=
ives
> the handler_chain() iteration, which means a separate allocation freed
> only after rv_uprobe_sync():
>=20
> =C2=A0=C2=A0 rv_uprobe_unregister_nosync()=C2=A0 /* list_del_rcu + schedu=
le_work */
> =C2=A0=C2=A0 rv_uprobe_sync()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* waits for any already-submitt=
ed=20
> srcu work */

We of course need to do any free after this sync, but I don't get why we
need an additional allocation since the following are both plain
synchronous frees, why isn't a single one (on b) enough?

I'm a bit lost on this..

Thanks,
Gabriele

> =C2=A0=C2=A0 rv_uprobe_free()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* kfree(impl) =E2=80=94 safe, i=
teration is=20
> done */
> =C2=A0=C2=A0 kfree(b)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* binding; never contained uc */
>=20
> v4 keeps the public API shape you suggested with impl private:
>=20
> =C2=A0=C2=A0 struct rv_uprobe {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rv_uprobe_impl=C2=A0 *impl;=
=C2=A0 /* allocated by=20
> rv_uprobe_register() */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct inode=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *inode;
> =C2=A0=C2=A0 };
> =C2=A0=C2=A0 #define DECLARE_RV_UPROBE(name)=C2=A0 struct rv_uprobe name=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* [2-2] */
>=20
> =C2=A0=C2=A0 int=C2=A0=C2=A0 rv_uprobe_register(const char *binpath, loff=
_t offset,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct rv_uprobe *p, handler_fn,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ret_handler_fn, void *priv);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* [2-4] */
> =C2=A0=C2=A0 void=C2=A0 rv_uprobe_unregister(struct rv_uprobe *p);
> =C2=A0=C2=A0 void=C2=A0 rv_uprobe_unregister_nosync(struct rv_uprobe *p);
> =C2=A0=C2=A0 void=C2=A0 rv_uprobe_sync(void);
> =C2=A0=C2=A0 void=C2=A0 rv_uprobe_free(struct rv_uprobe *p);=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=20
> [2-5] restored */
> =C2=A0=C2=A0 bool=C2=A0 rv_uprobe_is_registered(const struct rv_uprobe *p=
);=C2=A0=C2=A0=C2=A0=C2=A0 /*=20
> [2-7] added */
> =C2=A0=C2=A0 void *rv_uprobe_get_priv(struct uprobe_consumer *uc);
>=20
> Handler signature is (struct uprobe_consumer *self, ...) [2-3]; private
> data is retrieved via rv_uprobe_get_priv(self) instead of container_of().
>=20
> Then, rv_uprobe_free() is restored ([2-5] partially reverted).
>=20
>=20
> All other v3 items have been resolved, we are waiting for your comments=
=20
> on the above=EF=BC=88embedded consumer causes UAF=EF=BC=89:
>=20
> [1-1,1-3]=C2=A0 `# define` / `# error` space removed
> [1-4]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 `=E2=9F=B9` -> `=3D>`
> [1-6,1-7]=C2=A0 #if/#else in da_destroy_storage() and da_monitor_init()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 replac=
ed with plain if (DA_MON_ALLOCATION_STRATEGY =3D=3D=20
> DA_ALLOC_POOL)
> [1-8]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracepoint_synchronize_unregister() l=
ifted to=20
> da_monitor_destroy before the pool/kmalloc branch
>=20
> [2-2]=C2=A0 DECLARE_RV_UPROBE(name) =E2=80=94 kept
> [2-3]=C2=A0 handler sig (struct uprobe_consumer *self, ...) =E2=80=94 kep=
t
> [2-4]=C2=A0 rv_uprobe_register() returns int =E2=80=94 kept
> [2-5]=C2=A0 rv_uprobe_attach/detach removed; rv_uprobe_free() restored (s=
ee=20
> above)
> [2-6]=C2=A0 offset, path fields removed; inode used for identity
> [2-7]=C2=A0 rv_uprobe_is_registered() added
>=20
> [6-1]=C2=A0 Suggested-by removed
> [6-2]=C2=A0 tlob Kconfig entry placed after the deadline monitors marker
> [6-3]=C2=A0 Unnecessary includes removed (hrtimer.h, ktime.h, sched.h, tr=
acefs.h)
> [6-4]=C2=A0 `#include "../../rv.h"` -> `<rv.h>`
> [6-5,6-6]=C2=A0 Verbose comments around DA_MON_POOL_SIZE and da_extra_cle=
anup
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 simpli=
fied; early return in tlob_reset_notify() on
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !trace=
_detail_env_tlob_enabled()
> [6-7]=C2=A0 ha_setup_invariants():
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (atomic_read_ac=
quire(&target->stopping)) return;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (next_state < s=
tate_max_tlob) ha_start_timer_ns(...);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else ha_cancel_tim=
er(ha_mon);
> [6-8]=C2=A0 offsetof() arithmetic -> enum-indexed array:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum tlob_acc_idx =
{ TLOB_ACC_RUNNING, TLOB_ACC_WAITING,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 TLOB_ACC_SLEEPING, TLOB_ACC_MAX };
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 accs_ns[TLOB_A=
CC_MAX];
> [6-9]=C2=A0 1000 =E2=86=92 TLOB_MIN_THRESHOLD_NS
> [6-10] WARN_ON_ONCE(!da_mon) -> if (unlikely(WARN_ON_ONCE(!da_mon)))
> [6-11] __free(kfree) + list_add_tail(&no_free_ptr(b)->list, ...) in
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlob_add_uprobe(); note that "=
b =3D no_free_ptr(b)" would restore b
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and re-trigger __free on retur=
n =E2=80=94 the correct pattern is to use
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no_free_ptr() as the argument =
to list_add_tail() directly
> [6-15] tlob.h enum/struct order aligned with rvgen output
> [6-16] tracefs_create_file() -> rv_create_file()
>=20
> [7-1]=C2=A0 KUnit tests call tlob_parse_uprobe_line/tlob_parse_remove_lin=
e
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 directly; no real uprobe creat=
ion from unit tests
> [7-2]=C2=A0 KUNIT_EXPECT_EQ(test, ..., 0) for valid-line cases
>=20
> [8-1]=C2=A0 ftracetest: walk-up algorithm to locate test.d/functions
> [9-4]=C2=A0 tlob_busy/sleep/preempt_work unified to duration_ms
>=20
>=20
> --
> Best wishes,
> Wen
>=20
>=20
> > Gabriele
> >=20
> > **Suggested simplification:**
> >=20
> > ---
> > diff --git a/include/rv/rv_uprobe.h b/include/rv/rv_uprobe.h
> > index 9106c5c927..4fb3f50a63 100644
> > --- a/include/rv/rv_uprobe.h
> > +++ b/include/rv/rv_uprobe.h
> > @@ -7,83 +7,56 @@
> > =C2=A0 #ifndef _RV_UPROBE_H
> > =C2=A0 #define _RV_UPROBE_H
> > =C2=A0=20
> > -#include <linux/path.h>
> > =C2=A0 #include <linux/types.h>
> > +#include <linux/uprobes.h>
> > =C2=A0=20
> > =C2=A0 struct pt_regs;
> > +struct inode;
> > =C2=A0=20
> > =C2=A0 /**
> > =C2=A0=C2=A0 * struct rv_uprobe - a single uprobe registered on behalf =
of an RV
> > monitor
> > =C2=A0=C2=A0 *
> > - * @offset:=C2=A0=C2=A0 byte offset within the ELF binary where the pr=
obe is
> > installed
> > - * @priv:=C2=A0=C2=A0=C2=A0=C2=A0 monitor-private pointer; set at atta=
ch time, never touched by
> > - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t=
his layer; passed unchanged to entry_fn / ret_fn
> > - * @path:=C2=A0=C2=A0=C2=A0=C2=A0 resolved path of the probed binary (=
read-only after attach);
> > - *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
allers may use path.dentry for identity comparisons
> > - *
> > - * The implementation fields (uprobe_consumer, uprobe handle, callback=
s)
> > are
> > - * private to rv_uprobe.c and are not exposed here; monitors must not
> > access
> > - * them directly.
> > + * @uc:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 underlying uprobe consumer=
 (publicly visible)
> > + * @uprobe:=C2=A0=C2=A0 active uprobe structure handle
> > + * @inode:=C2=A0=C2=A0=C2=A0 inode of the target binary (read-only aft=
er registration)
> > =C2=A0=C2=A0 */
> > =C2=A0 struct rv_uprobe {
> > -=09/* public: read-only after rv_uprobe_attach*() */
> > -=09loff_t=09=09 offset;
> > -=09void=09=09*priv;
> > -=09struct path=09 path;
> > +=09struct uprobe_consumer=09uc;
> > +=09struct uprobe=09=09*uprobe;
> > +=09struct inode=09=09*inode;
> > =C2=A0 };
> > =C2=A0=20
> > -/**
> > - * rv_uprobe_attach_path - register an uprobe given an already-resolve=
d
> > path
> > - * @path:=C2=A0=C2=A0=C2=A0=C2=A0 path of the target binary; rv_uprobe=
 takes its own reference
> > - * @offset:=C2=A0=C2=A0 byte offset within the binary
> > - * @entry_fn: called on probe hit (entry); may be NULL
> > - * @ret_fn:=C2=A0=C2=A0 called on function return (uretprobe); may be =
NULL
> > - * @priv:=C2=A0=C2=A0=C2=A0=C2=A0 opaque pointer forwarded to callback=
s unchanged
> > - *
> > - * Use this variant when the caller has already resolved the path (e.g=
. to
> > - * register multiple probes on the same binary with a single kern_path
> > call).
> > - * The inode is derived internally via d_real_inode(), so inode and pa=
th
> > are
> > - * always consistent.
> > - *
> > - * Returns a pointer to the new rv_uprobe on success, ERR_PTR on failu=
re.
> > - */
> > -struct rv_uprobe *rv_uprobe_attach_path(struct path *path, loff_t offs=
et,
> > -=09int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64
> > *data),
> > -=09int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
> > -=09=09=09struct pt_regs *regs, __u64 *data),
> > -=09void *priv);
> > +/* Seamless inline declaration of a named uprobe inside user structs *=
/
> > +#define DECLARE_RV_UPROBE(name) \
> > +=09struct rv_uprobe name
> > =C2=A0=20
> > =C2=A0 /**
> > - * rv_uprobe_attach - resolve binpath and register an uprobe
> > - * @binpath:=C2=A0 absolute path to the target binary
> > - * @offset:=C2=A0=C2=A0 byte offset within the binary
> > - * @entry_fn: called on probe hit (entry); may be NULL
> > - * @ret_fn:=C2=A0=C2=A0 called on function return (uretprobe); may be =
NULL
> > - * @priv:=C2=A0=C2=A0=C2=A0=C2=A0 opaque pointer forwarded to callback=
s unchanged
> > + * rv_uprobe_register - resolve binpath and register an uprobe
> > + * @binpath:=C2=A0=C2=A0=C2=A0=C2=A0 absolute path to the target binar=
y
> > + * @offset:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 byte offset within the binar=
y
> > + * @p:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 poi=
nter to the allocated/embedded rv_uprobe structure
> > + * @handler:=C2=A0=C2=A0=C2=A0=C2=A0 called on probe hit (entry); may =
be NULL
> > + * @ret_handler: called on function return (uretprobe); may be NULL
> > =C2=A0=C2=A0 *
> > - * Resolves binpath via kern_path(), then delegates to
> > rv_uprobe_attach_path().
> > + * Resolves binpath via kern_path(), registers the uprobe directly usi=
ng
> > the
> > + * embedded `uprobe_consumer`, and immediately releases the path refer=
ence.
> > =C2=A0=C2=A0 *
> > - * Returns a pointer to the new rv_uprobe on success, ERR_PTR on failu=
re.
> > + * Returns 0 on success, or a negative error code on failure.
> > =C2=A0=C2=A0 */
> > -struct rv_uprobe *rv_uprobe_attach(const char *binpath, loff_t offset,
> > -=09int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64
> > *data),
> > -=09int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
> > -=09=09=09struct pt_regs *regs, __u64 *data),
> > -=09void *priv);
> > +int rv_uprobe_register(const char *binpath, loff_t offset, struct rv_u=
probe
> > *p,
> > +=09int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs,
> > __u64 *data),
> > +=09int (*ret_handler)(struct uprobe_consumer *self, unsigned long
> > func,
> > +=09=09=09=C2=A0=C2=A0 struct pt_regs *regs, __u64 *data));
> > =C2=A0=20
> > =C2=A0 /**
> > - * rv_uprobe_detach - synchronously unregister an uprobe and free it
> > - * @p:=C2=A0 probe to detach; may be NULL (no-op)
> > - *
> > - * Calls uprobe_unregister_nosync(), then uprobe_unregister_sync() to =
wait
> > - * for any in-progress handler to finish, then releases the path refer=
ence
> > - * and frees the rv_uprobe struct.=C2=A0 The caller's priv data is NOT=
 freed.
> > + * rv_uprobe_unregister - synchronously unregister a uprobe
> > + * @p:=C2=A0 probe to unregister; may be NULL (no-op)
> > =C2=A0=C2=A0 *
> > - * When removing a single probe, prefer this over the three-phase API.
> > - * Safe to call from process context only (uprobe_unregister_sync() ma=
y
> > - * schedule).
> > + * Dequeues the uprobe and waits synchronously for all in-flight handl=
ers
> > + * to complete.
> > =C2=A0=C2=A0 */
> > -void rv_uprobe_detach(struct rv_uprobe *p);
> > +void rv_uprobe_unregister(struct rv_uprobe *p);
> > =C2=A0=20
> > =C2=A0 /**
> > =C2=A0=C2=A0 * rv_uprobe_unregister_nosync - dequeue an uprobe without =
waiting
> > @@ -91,9 +64,7 @@ void rv_uprobe_detach(struct rv_uprobe *p);
> > =C2=A0=C2=A0 *
> > =C2=A0=C2=A0 * Removes the uprobe from the uprobe subsystem but does NO=
T wait for
> > =C2=A0=C2=A0 * in-flight handlers to complete.=C2=A0 The caller must ca=
ll rv_uprobe_sync()
> > - * before calling rv_uprobe_free() on the same probe.
> > - *
> > - * Use this to batch multiple deregistrations before a single
> > rv_uprobe_sync().
> > + * before freeing any container holding this probe.
> > =C2=A0=C2=A0 */
> > =C2=A0 void rv_uprobe_unregister_nosync(struct rv_uprobe *p);
> > =C2=A0=20
> > @@ -101,19 +72,8 @@ void rv_uprobe_unregister_nosync(struct rv_uprobe *=
p);
> > =C2=A0=C2=A0 * rv_uprobe_sync - wait for all in-flight uprobe handlers =
to complete
> > =C2=A0=C2=A0 *
> > =C2=A0=C2=A0 * Global barrier: waits for every in-flight uprobe handler=
 across the
> > system
> > - * to finish.=C2=A0 Call once after a batch of rv_uprobe_unregister_no=
sync()
> > calls
> > - * and before any rv_uprobe_free() call.
> > + * to finish.
> > =C2=A0=C2=A0 */
> > =C2=A0 void rv_uprobe_sync(void);
> > =C2=A0=20
> > -/**
> > - * rv_uprobe_free - release resources of a previously deregistered pro=
be
> > - * @p:=C2=A0 probe to free; may be NULL (no-op)
> > - *
> > - * Releases the path reference and frees the rv_uprobe struct.=C2=A0 M=
ust only
> > - * be called after rv_uprobe_sync() has returned.=C2=A0 The caller's p=
riv data
> > - * is NOT freed.
> > - */
> > -void rv_uprobe_free(struct rv_uprobe *p);
> > -
> > =C2=A0 #endif /* _RV_UPROBE_H */
> > diff --git a/kernel/trace/rv/monitors/tlob/tlob.c
> > b/kernel/trace/rv/monitors/tlob/tlob.c
> > index d8e0c47947..28a6c740c7 100644
> > --- a/kernel/trace/rv/monitors/tlob/tlob.c
> > +++ b/kernel/trace/rv/monitors/tlob/tlob.c
> > @@ -252,8 +252,8 @@ struct tlob_uprobe_binding {
> > =C2=A0=C2=A0=09char=09=09=09binpath[TLOB_MAX_PATH];
> > =C2=A0=C2=A0=09loff_t=09=09=09offset_start;
> > =C2=A0=C2=A0=09loff_t=09=09=09offset_stop;
> > -=09struct rv_uprobe=09*start_probe;
> > -=09struct rv_uprobe=09*stop_probe;
> > +=09DECLARE_RV_UPROBE(start_probe);
> > +=09DECLARE_RV_UPROBE(stop_probe);
> > =C2=A0 };
> > =C2=A0=20
> > =C2=A0 /* RCU callback: free the slab once no readers remain. */
> > @@ -512,16 +512,16 @@ int tlob_stop_task(struct task_struct *task)
> > =C2=A0 EXPORT_SYMBOL_GPL(tlob_stop_task);
> > =C2=A0=20
> > =C2=A0=20
> > -static int tlob_uprobe_entry_handler(struct rv_uprobe *p, struct pt_re=
gs
> > *regs,
> > +static int tlob_uprobe_entry_handler(struct uprobe_consumer *self, str=
uct
> > pt_regs *regs,
> > =C2=A0=C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 __u64 *data)
> > =C2=A0 {
> > -=09struct tlob_uprobe_binding *b =3D p->priv;
> > +=09struct tlob_uprobe_binding *b =3D container_of(self, struct
> > tlob_uprobe_binding, start_probe.uc);
> > =C2=A0=20
> > =C2=A0=C2=A0=09tlob_start_task(current, b->threshold_ns);
> > =C2=A0=C2=A0=09return 0;
> > =C2=A0 }
> > =C2=A0=20
> > -static int tlob_uprobe_stop_handler(struct rv_uprobe *p, struct pt_reg=
s
> > *regs,
> > +static int tlob_uprobe_stop_handler(struct uprobe_consumer *self, stru=
ct
> > pt_regs *regs,
> > =C2=A0=C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0 __u64 *data)
> > =C2=A0 {
> > =C2=A0=C2=A0=09tlob_stop_task(current);
> > @@ -537,6 +537,7 @@ static int tlob_add_uprobe(u64 threshold_ns, const =
char
> > *binpath,
> > =C2=A0 {
> > =C2=A0=C2=A0=09struct tlob_uprobe_binding *b, *tmp_b;
> > =C2=A0=C2=A0=09char pathbuf[TLOB_MAX_PATH];
> > +=09struct inode *inode;
> > =C2=A0=C2=A0=09struct path path;
> > =C2=A0=C2=A0=09char *canon;
> > =C2=A0=C2=A0=09int ret;
> > @@ -561,10 +562,12 @@ static int tlob_add_uprobe(u64 threshold_ns, cons=
t
> > char *binpath,
> > =C2=A0=C2=A0=09=09goto err_path;
> > =C2=A0=C2=A0=09}
> > =C2=A0=20
> > -=09/* Reject duplicate start offset for the same binary. */
> > +=09inode =3D d_real_inode(path.dentry);
> > +
> > +=09/* Reject duplicate start offset for the same binary inode. */
> > =C2=A0=C2=A0=09list_for_each_entry(tmp_b, &tlob_uprobe_list, list) {
> > =C2=A0=C2=A0=09=09if (tmp_b->offset_start =3D=3D offset_start &&
> > -=09=09=C2=A0=C2=A0=C2=A0 tmp_b->start_probe->path.dentry =3D=3D path.d=
entry) {
> > +=09=09=C2=A0=C2=A0=C2=A0 tmp_b->start_probe.inode =3D=3D inode) {
> > =C2=A0=C2=A0=09=09=09ret =3D -EEXIST;
> > =C2=A0=C2=A0=09=09=09goto err_path;
> > =C2=A0=C2=A0=09=09}
> > @@ -577,29 +580,25 @@ static int tlob_add_uprobe(u64 threshold_ns, cons=
t
> > char *binpath,
> > =C2=A0=C2=A0=09}
> > =C2=A0=C2=A0=09strscpy(b->binpath, canon, sizeof(b->binpath));
> > =C2=A0=20
> > -=09/* Both probes share b (priv) and path; attach_path refs path
> > itself. */
> > -=09b->start_probe =3D rv_uprobe_attach_path(&path, offset_start,
> > -=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlob_uprobe_entry_=
handler,
> > NULL, b);
> > -=09if (IS_ERR(b->start_probe)) {
> > -=09=09ret =3D PTR_ERR(b->start_probe);
> > -=09=09b->start_probe =3D NULL;
> > -=09=09goto err_path;
> > -=09}
> > +=09path_put(&path);
> > +
> > +=09/* Both probes are registered directly on the embedded fields */
> > +=09ret =3D rv_uprobe_register(b->binpath, offset_start, &b->start_prob=
e,
> > +=09=09=09=09 tlob_uprobe_entry_handler, NULL);
> > +=09if (ret)
> > +=09=09goto err_free;
> > =C2=A0=20
> > -=09b->stop_probe =3D rv_uprobe_attach_path(&path, offset_stop,
> > -=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlob_uprobe_stop_handler=
,
> > NULL, b);
> > -=09if (IS_ERR(b->stop_probe)) {
> > -=09=09ret =3D PTR_ERR(b->stop_probe);
> > -=09=09b->stop_probe =3D NULL;
> > +=09ret =3D rv_uprobe_register(b->binpath, offset_stop, &b->stop_probe,
> > +=09=09=09=09 tlob_uprobe_stop_handler, NULL);
> > +=09if (ret)
> > =C2=A0=C2=A0=09=09goto err_start;
> > -=09}
> > =C2=A0=20
> > -=09path_put(&path);
> > =C2=A0=C2=A0=09list_add_tail(&b->list, &tlob_uprobe_list);
> > =C2=A0=C2=A0=09return 0;
> > =C2=A0=20
> > =C2=A0 err_start:
> > -=09rv_uprobe_detach(b->start_probe);
> > +=09rv_uprobe_unregister(&b->start_probe);
> > +=09goto err_free;
> > =C2=A0 err_path:
> > =C2=A0=C2=A0=09path_put(&path);
> > =C2=A0 err_free:
> > @@ -611,21 +610,24 @@ static int tlob_remove_uprobe_by_key(loff_t
> > offset_start, const char *binpath)
> > =C2=A0 {
> > =C2=A0=C2=A0=09struct tlob_uprobe_binding *b, *tmp;
> > =C2=A0=C2=A0=09struct path remove_path;
> > +=09struct inode *inode;
> > =C2=A0=C2=A0=09int ret;
> > =C2=A0=20
> > =C2=A0=C2=A0=09ret =3D kern_path(binpath, LOOKUP_FOLLOW, &remove_path);
> > =C2=A0=C2=A0=09if (ret)
> > =C2=A0=C2=A0=09=09return ret;
> > =C2=A0=20
> > +=09inode =3D d_real_inode(remove_path.dentry);
> > +
> > =C2=A0=C2=A0=09ret =3D -ENOENT;
> > =C2=A0=C2=A0=09list_for_each_entry_safe(b, tmp, &tlob_uprobe_list, list=
) {
> > =C2=A0=C2=A0=09=09if (b->offset_start !=3D offset_start)
> > =C2=A0=C2=A0=09=09=09continue;
> > -=09=09if (b->start_probe->path.dentry !=3D remove_path.dentry)
> > +=09=09if (b->start_probe.inode !=3D inode)
> > =C2=A0=C2=A0=09=09=09continue;
> > =C2=A0=C2=A0=09=09list_del(&b->list);
> > -=09=09rv_uprobe_detach(b->start_probe);
> > -=09=09rv_uprobe_detach(b->stop_probe);
> > +=09=09rv_uprobe_unregister(&b->start_probe);
> > +=09=09rv_uprobe_unregister(&b->stop_probe);
> > =C2=A0=C2=A0=09=09kfree(b);
> > =C2=A0=C2=A0=09=09ret =3D 0;
> > =C2=A0=C2=A0=09=09break;
> > @@ -643,8 +645,8 @@ static void tlob_remove_all_uprobes(void)
> > =C2=A0=C2=A0=09mutex_lock(&tlob_uprobe_mutex);
> > =C2=A0=C2=A0=09list_for_each_entry_safe(b, tmp, &tlob_uprobe_list, list=
) {
> > =C2=A0=C2=A0=09=09list_move(&b->list, &pending);
> > -=09=09rv_uprobe_unregister_nosync(b->start_probe);
> > -=09=09rv_uprobe_unregister_nosync(b->stop_probe);
> > +=09=09rv_uprobe_unregister_nosync(&b->start_probe);
> > +=09=09rv_uprobe_unregister_nosync(&b->stop_probe);
> > =C2=A0=C2=A0=09}
> > =C2=A0=C2=A0=09mutex_unlock(&tlob_uprobe_mutex);
> > =C2=A0=20
> > @@ -658,8 +660,6 @@ static void tlob_remove_all_uprobes(void)
> > =C2=A0=C2=A0=09rv_uprobe_sync();
> > =C2=A0=20
> > =C2=A0=C2=A0=09list_for_each_entry_safe(b, tmp, &pending, list) {
> > -=09=09rv_uprobe_free(b->start_probe);
> > -=09=09rv_uprobe_free(b->stop_probe);
> > =C2=A0=C2=A0=09=09kfree(b);
> > =C2=A0=C2=A0=09}
> > =C2=A0 }
> > diff --git a/kernel/trace/rv/rv_uprobe.c b/kernel/trace/rv/rv_uprobe.c
> > index 3d8b764dde..69b8b0c27e 100644
> > --- a/kernel/trace/rv/rv_uprobe.c
> > +++ b/kernel/trace/rv/rv_uprobe.c
> > @@ -10,149 +10,74 @@
> > =C2=A0 #include <linux/uprobes.h>
> > =C2=A0 #include <rv/rv_uprobe.h>
> > =C2=A0=20
> > -/*
> > - * Private extension of struct rv_uprobe.=C2=A0 Allocated by rv_uprobe=
_attach*()
> > - * and returned to callers as &impl->pub.
> > - */
> > -struct rv_uprobe_impl {
> > -=09struct rv_uprobe=09pub;=09/* must be first; callers hold &pub
> > */
> > -=09struct uprobe_consumer=09uc;
> > -=09struct uprobe=09=09*uprobe;
> > -=09int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64
> > *data);
> > -=09int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
> > -=09=09=09struct pt_regs *regs, __u64 *data);
> > -};
> > -
> > -static int rv_uprobe_handler(struct uprobe_consumer *uc,
> > -=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 struct pt_regs *regs, __u64 *data)
> > -{
> > -=09struct rv_uprobe_impl *impl =3D container_of(uc, struct
> > rv_uprobe_impl, uc);
> > -
> > -=09if (impl->entry_fn)
> > -=09=09return impl->entry_fn(&impl->pub, regs, data);
> > -=09return 0;
> > -}
> > -
> > -static int rv_uprobe_ret_handler(struct uprobe_consumer *uc,
> > -=09=09=09=09 unsigned long func,
> > -=09=09=09=09 struct pt_regs *regs, __u64 *data)
> > -{
> > -=09struct rv_uprobe_impl *impl =3D container_of(uc, struct
> > rv_uprobe_impl, uc);
> > -
> > -=09if (impl->ret_fn)
> > -=09=09return impl->ret_fn(&impl->pub, func, regs, data);
> > -=09return 0;
> > -}
> > -
> > -static struct rv_uprobe *
> > -__rv_uprobe_attach(struct inode *inode, struct path *path, loff_t offs=
et,
> > -=09=09=C2=A0=C2=A0 int (*entry_fn)(struct rv_uprobe *p, struct pt_regs
> > *regs, __u64 *data),
> > -=09=09=C2=A0=C2=A0 int (*ret_fn)(struct rv_uprobe *p, unsigned long fu=
nc,
> > -=09=09=09=09=C2=A0=C2=A0 struct pt_regs *regs, __u64 *data),
> > -=09=09=C2=A0=C2=A0 void *priv)
> > -{
> > -=09struct rv_uprobe_impl *impl;
> > -=09int ret;
> > -
> > -=09if (!entry_fn && !ret_fn)
> > -=09=09return ERR_PTR(-EINVAL);
> > -
> > -=09impl =3D kzalloc_obj(*impl, GFP_KERNEL);
> > -=09if (!impl)
> > -=09=09return ERR_PTR(-ENOMEM);
> > -
> > -=09impl->pub.offset =3D offset;
> > -=09impl->pub.priv=C2=A0=C2=A0 =3D priv;
> > -=09impl->entry_fn=C2=A0=C2=A0 =3D entry_fn;
> > -=09impl->ret_fn=C2=A0=C2=A0=C2=A0=C2=A0 =3D ret_fn;
> > -=09path_get(path);
> > -=09impl->pub.path=C2=A0=C2=A0 =3D *path;
> > -
> > -=09if (entry_fn)
> > -=09=09impl->uc.handler=C2=A0=C2=A0=C2=A0=C2=A0 =3D rv_uprobe_handler;
> > -=09if (ret_fn)
> > -=09=09impl->uc.ret_handler =3D rv_uprobe_ret_handler;
> > -
> > -=09impl->uprobe =3D uprobe_register(inode, offset, 0, &impl->uc);
> > -=09if (IS_ERR(impl->uprobe)) {
> > -=09=09ret =3D PTR_ERR(impl->uprobe);
> > -=09=09path_put(&impl->pub.path);
> > -=09=09kfree(impl);
> > -=09=09return ERR_PTR(ret);
> > -=09}
> > -
> > -=09return &impl->pub;
> > -}
> > -
> > -/**
> > - * rv_uprobe_attach_path - register an uprobe given an already-resolve=
d
> > path
> > - */
> > -struct rv_uprobe *rv_uprobe_attach_path(struct path *path, loff_t offs=
et,
> > -=09int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64
> > *data),
> > -=09int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
> > -=09=09=09struct pt_regs *regs, __u64 *data),
> > -=09void *priv)
> > -{
> > -=09struct inode *inode =3D d_real_inode(path->dentry);
> > -
> > -=09return __rv_uprobe_attach(inode, path, offset, entry_fn, ret_fn,
> > priv);
> > -}
> > -EXPORT_SYMBOL_GPL(rv_uprobe_attach_path);
> > -
> > =C2=A0 /**
> > - * rv_uprobe_attach - resolve binpath and register an uprobe
> > + * rv_uprobe_register - resolve binpath and register an uprobe
> > =C2=A0=C2=A0 */
> > -struct rv_uprobe *rv_uprobe_attach(const char *binpath, loff_t offset,
> > -=09int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64
> > *data),
> > -=09int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
> > -=09=09=09struct pt_regs *regs, __u64 *data),
> > -=09void *priv)
> > +int rv_uprobe_register(const char *binpath, loff_t offset, struct rv_u=
probe
> > *p,
> > +=09int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs,
> > __u64 *data),
> > +=09int (*ret_handler)(struct uprobe_consumer *self, unsigned long
> > func,
> > +=09=09=09=C2=A0=C2=A0 struct pt_regs *regs, __u64 *data))
> > =C2=A0 {
> > -=09struct rv_uprobe *p;
> > +=09struct inode *inode;
> > =C2=A0=C2=A0=09struct path path;
> > =C2=A0=C2=A0=09int ret;
> > =C2=A0=20
> > +=09if (!handler && !ret_handler)
> > +=09=09return -EINVAL;
> > +
> > =C2=A0=C2=A0=09ret =3D kern_path(binpath, LOOKUP_FOLLOW, &path);
> > =C2=A0=C2=A0=09if (ret)
> > -=09=09return ERR_PTR(ret);
> > +=09=09return ret;
> > =C2=A0=20
> > =C2=A0=C2=A0=09if (!d_is_reg(path.dentry)) {
> > =C2=A0=C2=A0=09=09path_put(&path);
> > -=09=09return ERR_PTR(-EINVAL);
> > +=09=09return -EINVAL;
> > =C2=A0=C2=A0=09}
> > =C2=A0=20
> > -=09p =3D rv_uprobe_attach_path(&path, offset, entry_fn, ret_fn, priv);
> > +=09inode =3D d_real_inode(path.dentry);
> > +
> > +=09p->uc.handler=C2=A0=C2=A0=C2=A0=C2=A0 =3D handler;
> > +=09p->uc.ret_handler =3D ret_handler;
> > +=09p->inode=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
inode;
> > +
> > +=09p->uprobe =3D uprobe_register(inode, offset, 0, &p->uc);
> > =C2=A0=C2=A0=09path_put(&path);
> > -=09return p;
> > +
> > +=09if (IS_ERR(p->uprobe)) {
> > +=09=09ret =3D PTR_ERR(p->uprobe);
> > +=09=09p->uprobe =3D NULL;
> > +=09=09p->inode=C2=A0 =3D NULL;
> > +=09=09return ret;
> > +=09}
> > +
> > +=09return 0;
> > =C2=A0 }
> > -EXPORT_SYMBOL_GPL(rv_uprobe_attach);
> > +EXPORT_SYMBOL_GPL(rv_uprobe_register);
> > =C2=A0=20
> > =C2=A0 /**
> > - * rv_uprobe_detach - synchronously unregister an uprobe and free it
> > + * rv_uprobe_unregister - synchronously unregister a uprobe
> > =C2=A0=C2=A0 */
> > -void rv_uprobe_detach(struct rv_uprobe *p)
> > +void rv_uprobe_unregister(struct rv_uprobe *p)
> > =C2=A0 {
> > -=09if (!p)
> > +=09if (!p || IS_ERR_OR_NULL(p->uprobe))
> > =C2=A0=C2=A0=09=09return;
> > =C2=A0=20
> > =C2=A0=C2=A0=09rv_uprobe_unregister_nosync(p);
> > =C2=A0=C2=A0=09rv_uprobe_sync();
> > -=09rv_uprobe_free(p);
> > =C2=A0 }
> > -EXPORT_SYMBOL_GPL(rv_uprobe_detach);
> > +EXPORT_SYMBOL_GPL(rv_uprobe_unregister);
> > =C2=A0=20
> > =C2=A0 /**
> > =C2=A0=C2=A0 * rv_uprobe_unregister_nosync - dequeue an uprobe without =
waiting
> > =C2=A0=C2=A0 */
> > =C2=A0 void rv_uprobe_unregister_nosync(struct rv_uprobe *p)
> > =C2=A0 {
> > -=09struct rv_uprobe_impl *impl;
> > -
> > -=09if (!p)
> > +=09if (!p || IS_ERR_OR_NULL(p->uprobe))
> > =C2=A0=C2=A0=09=09return;
> > =C2=A0=20
> > -=09impl =3D container_of(p, struct rv_uprobe_impl, pub);
> > -=09uprobe_unregister_nosync(impl->uprobe, &impl->uc);
> > +=09uprobe_unregister_nosync(p->uprobe, &p->uc);
> > +=09p->uprobe =3D NULL;
> > +=09p->inode=C2=A0 =3D NULL;
> > =C2=A0 }
> > =C2=A0 EXPORT_SYMBOL_GPL(rv_uprobe_unregister_nosync);
> > =C2=A0=20
> > @@ -164,19 +89,3 @@ void rv_uprobe_sync(void)
> > =C2=A0=C2=A0=09uprobe_unregister_sync();
> > =C2=A0 }
> > =C2=A0 EXPORT_SYMBOL_GPL(rv_uprobe_sync);
> > -
> > -/**
> > - * rv_uprobe_free - release resources of a previously deregistered pro=
be
> > - */
> > -void rv_uprobe_free(struct rv_uprobe *p)
> > -{
> > -=09struct rv_uprobe_impl *impl;
> > -
> > -=09if (!p)
> > -=09=09return;
> > -
> > -=09impl =3D container_of(p, struct rv_uprobe_impl, pub);
> > -=09path_put(&p->path);
> > -=09kfree(impl);
> > -}
> > -EXPORT_SYMBOL_GPL(rv_uprobe_free);
> >=20

