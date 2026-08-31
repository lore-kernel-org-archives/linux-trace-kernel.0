Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9902B3D25AD
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169734; cv=none; b=czJoa5FXMvIeaob678b2PFVduLWl9z9O3iL3hApUASWva3surqN9zmKXzJGIK1HPIxtmRMsh3pyuGXBk3rWJUkZJ3rWNJzH7WjkQCZEpPy/fhvGtrlVL5Vpa7i60IbOwweiI+prvlDiBsZ/lh7BTI72/LSrhzLtZzeN+cqsia68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169734; c=relaxed/simple;
	bh=SgyDu7vH7rLuEa2THLKFoPWMOA5FVcQ4/ghn3hpoi3Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K45AjPtMES+qvtelx9L/auLXvIxi5KI4g/ML3LlJuSNGuLr/9vuU2xRrCXtOLXSmfFjXqrB7IDoXOHsaI4VHbfjZDmsdr79nh21IgIuYQx4EC5t8EmRtmK9q3KsNsiA+nzPkwri9RYf+dG9SP1aHBwAfEIsXQhfjGYwEHfkMtDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KgrHsKGE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgrHsKGE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788169731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=taHcNytSEadYjenDLhiiAS82t1wBrOuQ/VLQkC4/1sA=;
	b=KgrHsKGEAuNho7glQZlovr5d5vAIJ5f6I8kmLCq+AWD0PQrOpV+ol/4RZUqPukn81qXOy2
	JuJd35y1gvSkKdbdxDwiXYssegjLXjKVaYiXEIzbkGkauFk5bSZ2PuEKaP4riEYU4ODAOg
	0xf6TsDazfj8gmOM0plhfnhGfR7fZIw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-pzh11kp_NQaIFVDZ1auyBQ-1; Mon, 31 Aug 2026 05:48:49 -0400
X-MC-Unique: pzh11kp_NQaIFVDZ1auyBQ-1
X-Mimecast-MFC-AGG-ID: pzh11kp_NQaIFVDZ1auyBQ_1788169729
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c252634bc4dso302715566b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 02:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788169729; x=1788774529;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hri4pxqYPzTEc6ZBZYkjRuO0ivhZyic4cgUNvU7rE+A=;
        b=kcB74wsAj8B5sAEqPpspslhyX3eAuCreICh+YMnl60liTkJDWHYPCQPb62VZxcm05m
         YwWisnYkZXhCyGM/EV7FVdJYSN8euRqmXyZK0nNXIpWfvhiRrC72biyh/fYltXU6QdYN
         0W0SYMKpiFX0KcEqzxD5vFXGXJaGTnXooKcINyJ5PvxPHdrBGISkL2GlNX7qA28R7NAy
         DkfP3b90AJlfSS7NjjxeYe3s3bYRBusjKIZqRySxWYd5ER5sXShwV815eErxvth8NX81
         RDqR7ujT1xhtjdmP6SGgBy1IQd7aHHzlLkNoSquls3y5uNO1R5PKAwZbfApDZ8tMmBQC
         Kbeg==
X-Forwarded-Encrypted: i=1; AHgh+RqrC7g32cAM8KT6u4J7Z6Qh1BUM8dCO8lOesg8S3gbaCqabDEeTAdNBAHFXHBtEvOuJo8dCPVWitNYKBTIY3GRVYXc=@vger.kernel.org
X-Gm-Message-State: AFuF++mcE8ilkw0VH5BLs4IfGYvDMbvzDgIObV93HljhQAJNwcM/kYJl
	BXEgOoDZc1EKUInAHb++d9/4Sw6cpOfJm7kVK/NG1J+8XnYBw8NoRbmxOk2/6ZIpIZtaOyZISod
	4+lOhbAzIxI0GqA+pQjatHxKCAnvuZX9j7Y6wSJeuej7xu4LkpsVRALA250tENsFN3YYWzIRxog
	==
X-Gm-Gg: AR+sD12usX033rEMTrAo3Wy1DuPIxIPf0twilG1B4xxSoLH477hT4vmN/OAqudPQ7mA
	JBlAkyIAIWhBAxeo1EQDzLO/bpQAU4b75vZC3NUzYX9Y+UqkEdSGCtGGreq5fwIuuYe4VXpgDkV
	Ew8vSiaoSsvOLLg4lEYJeB1PhiB2w3uoMd6g8V/L/fH+Jdur2DapG8rWNTjSN3DQwIU21Uwst6x
	PKwOc9S0VxfTjwn2v4uNgASpmjRPPiX0+bb92qnNNjt+ewIwkbWFNQ8HDe66UyVerLfHOnZ4pdF
	9FtHTMxKHriPtstBfLaAqAVn6kmZDSUQVTZDr2TI74ZNtB39jdjfnOYkH7GB0El6YoyoaiZjsvn
	JhYs9k7lgIaambEci/qOXwsldKCpLs/dxCE1szT7l/IdidqEBldVQ2cHsDdYW7DcbcrmAKQ==
X-Received: by 2002:a17:907:72c6:b0:c16:12ff:dc93 with SMTP id a640c23a62f3a-c25ab4b52f2mr133980566b.18.1788169728743;
        Mon, 31 Aug 2026 02:48:48 -0700 (PDT)
X-Received: by 2002:a17:907:72c6:b0:c16:12ff:dc93 with SMTP id a640c23a62f3a-c25ab4b52f2mr133978766b.18.1788169728339;
        Mon, 31 Aug 2026 02:48:48 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25ab254f49sm45172766b.10.2026.08.31.02.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 02:48:47 -0700 (PDT)
Message-ID: <e8a8de3683db55822595af75df6c56b263047962.camel@redhat.com>
Subject: Re: [PATCH v4 1/4] rv/reactors: use LD_WAIT_SPIN as the reactor
 lockdep wait type
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
	 <thomas.weissschuh@linutronix.de>
Date: Mon, 31 Aug 2026 11:48:46 +0200
In-Reply-To: <7bfe97bd497a2641de36b35e17f69e6f3f291c2a.1787854397.git.wen.yang@linux.dev>
References: <cover.1787854397.git.wen.yang@linux.dev>
	 <7bfe97bd497a2641de36b35e17f69e6f3f291c2a.1787854397.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: qILIRpmXZTW3JTYhq5WVFjb86xFtQQ1oTwms2pHrnSY_1788169729
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-08-28 at 02:22 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> diff --git a/Documentation/trace/rv/monitor_synthesis.rst
> b/Documentation/trace/rv/monitor_synthesis.rst
> index 2c1b5a0ae154..aab4b0342d5f 100644
> --- a/Documentation/trace/rv/monitor_synthesis.rst
> +++ b/Documentation/trace/rv/monitor_synthesis.rst
> @@ -365,6 +365,26 @@ but higher overhead. The timer wheel (``HA_TIMER_WHE=
EL``)
> is a good alternative
> =C2=A0for monitors with several instances (e.g. per-task) that achieves l=
ower
> =C2=A0overhead with increased latency, yet without compromising precision=
.
> =C2=A0
> +Reactors
> +--------
> +
> +A reactor is a callback triggered by a monitor when a violation is
> +detected. Reactors are registered via ``/sys/kernel/tracing/rv/reactors/=
``
> +and enabled per monitor.

This is not correct, they stay in
/sys/kernel/tracing/rv/monitors/MONITOR/reactors and it is already explaine=
d in
Documentation/trace/rv/runtime-verification.rst .

You don't need to add any further section here (you're more than welcome to
update the existing one obviously, but not as part of this patch/series).

monitor_synthesis.rst is not about reactors.
At the moment we don't really have a good spot under Documentation to descr=
ibe
the /implementation/ of reactors.

I'd say for the purpose of this patch, in-code documentation (i.e. a commen=
t) is
sufficient, we can revise this later if needed.

> +
> +Reactor Locking Rules
> ++++++++++++++++++++++
> +
> +A reactor callback may be invoked from various contexts (process,
> +softirq, hardirq, NMI) depending on the tracepoint to which its
> +monitor is attached.
> +
> +Lockdep uses a fixed wait type: ``LD_WAIT_SPIN``. This allows
> +``raw_spinlock_t`` but disallows sleepable locks. ``LD_WAIT_FREE`` is
> +not viable in preemptible contexts because scheduler preemption takes
> +``rq->__lock`` (``LD_WAIT_SPIN``), which would cause false-positive
> +warnings.
> +

The code looks fine but this documentation is missing the point. We don't n=
eed
to explain what lockdep does but why we use a specific class and what we
actually wanted to use. Let's readapt the comment you added in v3

=09/*
=09 * Reactors must not explicitly take locks, so they should be
=09 * LD_WAIT_FREE.  However, reactor callbacks can run with preemption
=09 * enabled, meaning the preempting code (e.g. the scheduler taking
=09 * rq->__lock at LD_WAIT_SPIN) may violate that constraint.  Use
=09 * LD_WAIT_SPIN to avoid false-positive lockdep reports.
         * But you should still NOT be using locks in reactors.
=09 */

> =C2=A0Final remarks
> =C2=A0-------------
> =C2=A0
> diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.=
c
> index 2f5fc8d18dea..afc97d097109 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -465,7 +465,11 @@ int init_rv_reactors(struct dentry *root_dir)
> =C2=A0
> =C2=A0void rv_react(struct rv_monitor *monitor, const char *msg, ...)
> =C2=A0{
> -=09static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE);
> +=09/*
> +=09 * Use LD_WAIT_SPIN uniformly for deterministic lockdep checking.
> +=09 * See Documentation/trace/rv/runtime-verification.rst.
> +=09 */

See above, I would only add an explicit comment here of /why/ we do LD_WAIT=
_SPIN
although we would like LD_WAIT_FREE.

Thanks,
Gabriele

> +=09static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_SPIN);
> =C2=A0=09va_list args;
> =C2=A0
> =C2=A0=09if (!rv_reacting_on() || !monitor->react)

