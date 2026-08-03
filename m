Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564DF1DDC33
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Aug 2026 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785771550; cv=none; b=WdPgD+5buOFPpV/Kd1ndX2ULwu8JGDYMJU5W28CVxOTh+D46iFJ8CZYorFSF+6tRjlu1+sX9173yepcKJ1aUJRP/btCSctuQ55o6D0JkIo37WxNeLC2cW3Y1KGEkoyj/sHRKrSGCH6zhSLV+FCAJqKvaKsOwSIjR2bm/pTyycyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785771550; c=relaxed/simple;
	bh=xPgmW54m7MwqDEBpyR6KrE8rfplrHmQ0KSDtz5AO7as=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EV4zvS4LcH2Fx3gYNwk+lUX3+Ak1OAw65VnHsPbNrplQJ24tHX+LUzUF/iZpvTcP0k0NqxxLGYmfY8Ogf/OMId63M+/o/yQJqGIooXa/aSaEDspcSkXiwGpc/eBrhqc0HMORDvQGJT3WTC3A7AAwqRiaHCqlqmmPfqV79kyHp3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iw19dbvC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iw19dbvC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785771548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=E+UzXX7/IK3/mh9WH7z29C8ALI2O0q7JcWSEkUcxU90=;
	b=iw19dbvCuBWDGRXyekVJBF/AViNUA0gj/8HgtGmZR9cUnqulewIx6mcLVp4hE1LbXu9Rlc
	nroY+YJ2F/spIKWN9FsI+7lCPVJwKlzZeBYQlv7U2+F5HXTIu54diMPk44/pIYC58vJ+Jd
	nSfa7D57htDgBQdDE1F+Lphz0EYzPMg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-K-l1BIROPWST5356iqK_TQ-1; Mon, 03 Aug 2026 11:39:07 -0400
X-MC-Unique: K-l1BIROPWST5356iqK_TQ-1
X-Mimecast-MFC-AGG-ID: K-l1BIROPWST5356iqK_TQ_1785771546
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-496b61bd846so19055045e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Aug 2026 08:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785771546; x=1786376346;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ltzx3yDXOigUS6OFQK0hTJ5dTVg0Ee/FgqBIdijjhVA=;
        b=eBLhhgg6IirpjLf54YaeTmKk2cn1I3mNDH5MM8zw0SzDKQHWZrfsGba00Tx19rStzP
         GtxEN8jjlNqNJrJCWjIJW+TplRtUmh9GrraCnRrPsCDK8fA5RwGdWO/Z8NSnn2ptjJXe
         gZnOYtCSCuIjFiZt4ySELuuKJHpzPh7Rd478JywOS3R2wO4p3mdIZtI5ESCRG43ygEWv
         l68wBFM0DI0yY1advnIDn/vCbLBRxrdkM0D2YwMLZkQJCi1YpTnAf6lKvIgMfkU9771X
         7j7SBITtrYLrRnsZyKlDRrspXTjuBuEXR5n7f/nXOZpb+0SjohYzPnAwvTvqIxd0JXFX
         wupg==
X-Forwarded-Encrypted: i=1; AHgh+Rr9eiDfY/Hodbu6ogoc3JR46yzCliHCdmV0miv9kl156ri9FLk6WuutB/edn+u/Du+ZfoiXIzEECFRy5sm1iMS/H6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmIAyaaMysCScdnyuJxzwZcDongSvrYyoilb2OSokRA7NmZOLH
	9CGWVssHHQoTzGJforLyJPbkFwtfeKESKq/HrCP9OBSVDf5Q2vkKg1txKVjy1q4n0+SmNLdsjuw
	EpfpsBcsglyLKIShOjTUNFmA6ugl04W73XjCBQUCtrUoOur7wnaJa8hci70l9XB9TQGhbatb02A
	==
X-Gm-Gg: AR+sD120Cn7MQsF2nWVNGnxCYoITsfnH2NvXP7qo7g0shaV6x9+52DjeJ/m4bANkBNy
	5qDV2QyJjGy2kyoyGANRGsNhAJnGx4F5Yv1Vx+K8r5T2f/JLUQ2PpWGH+jQcZBFxRLiQNpOvhfG
	qykbbuQlBERj9Kr4TN8J3Y+3q7E7ndgksznonkk6QAcjNld1bvevR9gwbRpR4bPUOlK0axaBuJt
	jCDKDlCUFAL3buI/Ztk0sLXomDU63hpSOGnhCfc730sRIknSSzpGnOH6vkfnLU0+UKiFrckfvT3
	0dHM03DOYU9NvGjWjWVEHG/qbqVuKGtDrXTzkNn59rq2tCk64n/SsJsrkx2vmwvsrqIBpI8XCSc
	bTBnvJi23cEwybeb/rBzD0qnmEFR1
X-Received: by 2002:a05:600c:19cf:b0:496:bbce:fd with SMTP id 5b1f17b1804b1-4980c66c73amr243660075e9.6.1785771546109;
        Mon, 03 Aug 2026 08:39:06 -0700 (PDT)
X-Received: by 2002:a05:600c:19cf:b0:496:bbce:fd with SMTP id 5b1f17b1804b1-4980c66c73amr243659225e9.6.1785771545526;
        Mon, 03 Aug 2026 08:39:05 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fc2ff6sm992035e9.1.2026.08.03.08.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 08:39:05 -0700 (PDT)
Message-ID: <fa933b780eb63da7b194f9ca076d0d22f827c511.camel@redhat.com>
Subject: Re: [PATCH v2 1/4] rv/reactors: use context-sensitive lockdep wait
 type in rv_react()
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
	 <thomas.weissschuh@linutronix.de>
Date: Mon, 03 Aug 2026 17:39:04 +0200
In-Reply-To: <fb4c2c0ab10e32bb02cd7da747a00ef988eaf276.1785695669.git.wen.yang@linux.dev>
References: <cover.1785695669.git.wen.yang@linux.dev>
	 <fb4c2c0ab10e32bb02cd7da747a00ef988eaf276.1785695669.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: k6rY1DbBMgwszyNqWRQAthZvGCiw9oIMjZtTvVNQ3iU_1785771546
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-08-03 at 02:43 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> The single DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE) in
> rv_react() declares wait_type_inner =3D LD_WAIT_FREE for every execution
> context.=C2=A0 In a preemptible context (e.g. CONFIG_PREEMPT_RT or a KUni=
t
> test running on a task), a timer interrupt can fire during a reactor

We are obviously not doing this for KUnit tests, but aren't tracepoint hand=
lers
also running with preemption enabled on non-PREEMPT_RT kernels now?
So technically this is a problem with any configuration if events don't run=
 with
preemption disabled for other reasons.

Or is the issue with spinlocks only popping out on PREEMPT_RT because they
become sleeping locks?
Is lockdep really happy to allow an interrupt/schedule taking spinlocks und=
er
LD_WAIT_FREE on non-PREEMPT_RT?

> callback; the interrupt exit path then schedules and acquires rq->__lock
> (LD_WAIT_SPIN) while the override map is still held.=C2=A0 Since the map
> declares the context to be wait-free, lockdep reports a spurious
> "Invalid wait context" warning:
>=20
> =C2=A0=C2=A0=C2=A0 [ BUG: Invalid wait context ]
> =C2=A0=C2=A0=C2=A0 context-{5:5}
> =C2=A0=C2=A0=C2=A0 1 lock held by kunit_try_catch/209:
> =C2=A0=C2=A0=C2=A0=C2=A0 #0: (rv_react_map-wait-type-override){+.+.}-{1:1=
}
> =C2=A0=C2=A0=C2=A0 kunit_try_catch/209 is trying to lock:
> =C2=A0=C2=A0=C2=A0 ffff8a743ed3e8a0 (&rq->__lock){-...}-{2:2}
>=20
> Use two lockdep override maps, selected by execution context:
>=20
> =C2=A0 - Preemptible context (task, softirq, PREEMPT_RT irq thread): the
> =C2=A0=C2=A0=C2=A0 scheduler may preempt, so use LD_WAIT_SPIN, the tighte=
st wait type
> =C2=A0=C2=A0=C2=A0 the scheduler itself uses, to suppress the spurious wa=
rning.
>=20
> =C2=A0 - NMI/hardirq context: preemption is disabled and the scheduler ca=
nnot
> =C2=A0=C2=A0=C2=A0 run, so the false positive cannot arise.=C2=A0 Keep LD=
_WAIT_FREE here to
> =C2=A0=C2=A0=C2=A0 preserve the original constraint that reactors must no=
t take raw
> =C2=A0=C2=A0=C2=A0 spinlocks in atomic context.

So here you're describing at length the solution but not really why you're =
doing
that. A reader that didn't follow the discussion might think the requiremen=
t is
indeed context-dependant, it isn't.

I'd write very bluntly something like:

  "Reactors are not supposed to explicitly take locks, reactor code must co=
mply
with LD_WAIT_FREE. However reactors may run with interrupts and preemption
enabled, so the interrupting code may not satisfy this constraint. Relax it=
 if
we are running from a context that cannot be interrupted to avoid false
positives."

I would write something like that also in the comment, to make clear that
reactors really should be LD_WAIT_FREE, but we are asserting that as best
effort.

What do you think?
Thanks,
Gabriele

> Fixes: 69d8895cb9a9 ("rv: Add explicit lockdep context for reactors")
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> Cc: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
> =C2=A0kernel/trace/rv/rv_reactors.c | 17 ++++++++++++-----
> =C2=A01 file changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.=
c
> index 2f5fc8d18dea..cd571b1649f5 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -465,18 +465,25 @@ int init_rv_reactors(struct dentry *root_dir)
> =C2=A0
> =C2=A0void rv_react(struct rv_monitor *monitor, const char *msg, ...)
> =C2=A0{
> -=09static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE);
> +=09/*
> +=09 * A reactor callback can be preempted; the scheduler then takes
> +=09 * rq->__lock (LD_WAIT_SPIN).=C2=A0 Advertise that in preemptible con=
texts
> +=09 * to avoid a spurious lockdep report, and keep LD_WAIT_FREE in
> atomic
> +=09 * ones where the scheduler cannot run.
> +=09 */
> +=09static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map,=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 LD_WAIT_SPIN);
> +=09static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map_atomic, LD_WAIT_FREE);
> +=09struct lockdep_map * __maybe_unused map;
> =C2=A0=09va_list args;
> =C2=A0
> =C2=A0=09if (!rv_reacting_on() || !monitor->react)
> =C2=A0=09=09return;
> =C2=A0
> +=09map =3D (in_nmi() || in_hardirq()) ? &rv_react_map_atomic :
> &rv_react_map;
> =C2=A0=09va_start(args, msg);
> -
> -=09lock_map_acquire_try(&rv_react_map);
> +=09lock_map_acquire_try(map);
> =C2=A0=09monitor->react(msg, args);
> -=09lock_map_release(&rv_react_map);
> -
> +=09lock_map_release(map);
> =C2=A0=09va_end(args);
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(rv_react);

