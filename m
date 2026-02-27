Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997EB1DE8BE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 23:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236202; cv=none; b=OmpbSwvoOoisnXQxAPnw2Dx6X0SVRH/gO9KmrEdlw6m3iInTLSSOOMLCV4YWRiiiDXYckUFKRN1Bhia6ecS2R/hy6iNf537r5JoxpGz+ahETThWulzincQeoenvzHWQWV1d+kWLVLzcqv1GpGbKhuW4Nh+XfZ2qAH3PDlhWCEFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236202; c=relaxed/simple;
	bh=CrvSLztEuxXTWQeb4kA8RwxuPcblowQAFnD58qWJSAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Shy6kXUbOkLti21nveJ/Sy10wsYkUpw5nkU/QN35FQsL8WK+DvSLzul7qJmersHm9qyLrkzkPwvIaTWI7+T2HBcbnUmx96z5/eeNgg7//cxsyje25xgBBHM7M2l4LST2vzEeHY3P6/+Z8C9YIhU0JeAJROZPaSUmPLNaMBWSJiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNJ3p1Yp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNJ3p1Yp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772236199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36JieCPUJhG36kQvN2Yr7gnjwThSKz2dfLh65eA7xsQ=;
	b=TNJ3p1YpOrSI8yGDs0j9HiawG7frDc+YGIgTsLnZKp2WQsrL07sVzB0etEjYB3GsBO+zmk
	RER83E0YMpDzp9w/qqWbjQldVmNrRcA+Dh6rG4UIXmq17igFZi9kcnqjIlf62Gc/NgV2qe
	0pnedYJdMQN9Y9sPsAqBVJDaIscQPvI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-9UPzNsGwMxKDBUvHiVAJ0w-1; Fri, 27 Feb 2026 18:49:58 -0500
X-MC-Unique: 9UPzNsGwMxKDBUvHiVAJ0w-1
X-Mimecast-MFC-AGG-ID: 9UPzNsGwMxKDBUvHiVAJ0w_1772236198
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-899b6cc76a2so209113736d6.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 15:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236198; x=1772840998;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ww/Bhz3J3L+KhS5rSZm9FkdK6bU8Zv9mIU3Bpy6wyeY=;
        b=mg1trBeCqZ2FBIzEr81Q/ZOaKWt4Ms7hU8P2V4Fz0x9wDd1IX4Znjtdgq07ScrbA2F
         jcO6iZg0Fw7aCUT8DZ6LQjX9poE4fbVO+M5BFUnpzJczRwSIQKnVgalR6J5lSWjKXrxv
         ENvKJU108ZSEk02znd37iur2OVptqM2FAcePF0p9bn790fqx3/VH8VQSKXZ/+7DJ+XFO
         qoZoQDcj1xWJFhdivGo+/5PP+5+kyV7ofsmVLaXKG/TPFiI+i7ZddBYnARGnxhx06qcJ
         i11o5i723WXejIxPPIStG5RmtJGXW0qIecmh2ff7lj5PWpg6v3VCdN7ZC1DsDkHan1Db
         E0dw==
X-Forwarded-Encrypted: i=1; AJvYcCVgahFeSEBFnk5wi3mnCJUPmT023Ao2eGu8WqEenptyIPF0qGJ3ZYTRSPBpaaB1Xxn7BOPBRLzH3ltSzrnfM5ocNJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz41NvRIy6E49uFHhXqvE2/YFypbGQRNIry+djPTJ6NXg1gcZIg
	nOrAvQI3jC3CwCozuUK0evIkqgh/3zQJpocnEPm4dUM9GmqbVkjSMk7Q6sb2PICiZXd55tcjGIV
	AMZqKhVXgbobbKyCRPMJAB9E+h9iCDvvUtxkpDKZSlosAite7xt/I12540tGw4yd3A9h5ZQG9r+
	EZxdhGzw==
X-Gm-Gg: ATEYQzwSX2sn9r8A9wY739hQsak2DAhYHeJ4Tad7Zbd38+IfcNc9N28Rh0A4g2dYo+X
	3rdqeLQMQnYGYBtiNJSC+s0iXA4ldeQh434Qou831Hut1ULyIO/v5prTwRzIuSnj1+JD0BENZca
	v/1jqsdl49aJIiTN5n7d/bgDxyBVKOFAGFRGJWBC1Oj3eIGxWmVUTu5qgsbEZJ/U20l6C/gkGZh
	FBTULp5TMzUNsLy/zOo+s6HB1waLMfZmSQgxXq6FFYnNiKws2/OEUqmcUwkkEVIIBL6dkaWVbQ+
	MzI4Lq5KZWyWG6CnAEBxwHUNldJcPIqGKuOQ4DBWl5hhEnUXc3UNjT5FkVEgMG9kHFsEC84WzRk
	1rptzesZxIPqHYxB2ry2kYeJuOhCUa1jCaiQrxOp3WeqFc+kRLe8FJA==
X-Received: by 2002:a05:6214:491:b0:894:6622:a6d4 with SMTP id 6a1803df08f44-899d1f49c66mr69077836d6.61.1772236197911;
        Fri, 27 Feb 2026 15:49:57 -0800 (PST)
X-Received: by 2002:a05:6214:491:b0:894:6622:a6d4 with SMTP id 6a1803df08f44-899d1f49c66mr69077546d6.61.1772236197396;
        Fri, 27 Feb 2026 15:49:57 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf678156sm662047785a.18.2026.02.27.15.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:49:57 -0800 (PST)
Message-ID: <d7be6fcb6540b3734019fe82ff8e7f4ff49220c2.camel@redhat.com>
Subject: Re: [PATCH] tracing/osnoise: Add option to align tlat threads
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
  Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, John Kacur
	 <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin
	 <costa.shul@redhat.com>, Wander Lairson Costa <wander@redhat.com>, LKML
	 <linux-kernel@vger.kernel.org>, linux-trace-kernel
	 <linux-trace-kernel@vger.kernel.org>
Date: Fri, 27 Feb 2026 17:49:55 -0600
In-Reply-To: <20260227150420.319528-1-tglozar@redhat.com>
References: <20260227150420.319528-1-tglozar@redhat.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gr8tzUBKFvUendEt8zIHx0Q2qTfRKhwiFI72nlMdYF8_1772236198
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-02-27 at 16:04 +0100, Tomas Glozar wrote:
> Add an option called TIMERLAT_ALIGN to osnoise/options, together with a
> corresponding setting osnoise/timerlat_align_us.
>=20
> This option sets the alignment of wakeup times between different
> timerlat threads, similarly to cyclictest's -A/--aligned option. If
> TIMERLAT_ALIGN is set, the first thread that reaches the first cycle
> records its first wake-up time. Each following thread sets its first
> wake-up time to a fixed offset from the recorded time, and incremenets
> it by the same offset.

Why not just set the initial timer expiration to be=20
"period + cpu * align_us"?  Then you wouldn't need any interaction
between CPUs.

>  kernel/trace/trace_osnoise.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)

Documentation needs to be updated as well.

Should mention that updating align_us while the timer is running won't
take effect immediately (unlike period, which does).

> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index dee610e465b9..df1d4529d226 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -58,6 +58,7 @@ enum osnoise_options_index {
>  =09OSN_PANIC_ON_STOP,
>  =09OSN_PREEMPT_DISABLE,
>  =09OSN_IRQ_DISABLE,
> +=09OSN_TIMERLAT_ALIGN,
>  =09OSN_MAX
>  };
> =20
> @@ -66,7 +67,8 @@ static const char * const osnoise_options_str[OSN_MAX] =
=3D {
>  =09=09=09=09=09=09=09"OSNOISE_WORKLOAD",
>  =09=09=09=09=09=09=09"PANIC_ON_STOP",
>  =09=09=09=09=09=09=09"OSNOISE_PREEMPT_DISABLE",
> -=09=09=09=09=09=09=09"OSNOISE_IRQ_DISABLE" };
> +=09=09=09=09=09=09=09"OSNOISE_IRQ_DISABLE",
> +=09=09=09=09=09=09=09"TIMERLAT_ALIGN" };

Do we really need a flag for this, or can we just interpret a non-zero
align_us value as enabling the feature?

> @@ -1820,6 +1824,7 @@ static int wait_next_period(struct timerlat_variabl=
es *tlat)
>  {
>  =09ktime_t next_abs_period, now;
>  =09u64 rel_period =3D osnoise_data.timerlat_period * 1000;
> +=09static atomic64_t align_next;

How will this get reset if the tracer is stopped and restarted?

>  =09now =3D hrtimer_cb_get_time(&tlat->timer);
>  =09next_abs_period =3D ns_to_ktime(tlat->abs_period + rel_period);
> @@ -1829,6 +1834,17 @@ static int wait_next_period(struct timerlat_variab=
les *tlat)
>  =09 */
>  =09tlat->abs_period =3D (u64) ktime_to_ns(next_abs_period);
> =20
> +=09if (test_bit(OSN_TIMERLAT_ALIGN, &osnoise_options) && !tlat->count
> +=09    && atomic64_cmpxchg_relaxed(&align_next, 0, tlat->abs_period)) {
> +=09=09/*
> +=09=09 * Align thread in first cycle on each CPU to the set alignment.
> +=09=09 */
> +=09=09tlat->abs_period =3D atomic64_fetch_add_relaxed(osnoise_data.timer=
lat_align_us * 1000,
> +=09=09=09&align_next);
> +=09=09tlat->abs_period +=3D osnoise_data.timerlat_align_us * 1000;
> +=09=09next_abs_period =3D ns_to_ktime(tlat->abs_period);
> +=09}

I'm already unclear about the existing purpose of next_abs_period, but
if it has any use at all shouldn't it be to avoid writing intermediate
values like this back to tlat?

-Crystal

