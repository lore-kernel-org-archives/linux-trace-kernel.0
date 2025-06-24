Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A272E7637
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Jun 2025 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776300; cv=none; b=bXzjXOQhAQ9H4UiIFrMnN/Gt4Z9A+WZOfLsBZwWYBFLLI3/L9nXxjp80u5GeoiBDf4jeDFiOWdv6RI4NCXjm/RqRpqKpSiiFL8v7AjFR6jUd8Kl6YOZcMeRtMlcLxGAcVv1WmvPLkxaazV2QaB2Pbe3DhDFE0+OiJdarWLpvk5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776300; c=relaxed/simple;
	bh=AjkJ+y8YmCAvwln9VEOfIy6WpZHk/a1nQR2X1/vMMp0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azrQyA18iUojQj1/YLteaWyjwjLsIvx4WGzl+9J9vYb7FzJocEXhdlGSHuM5nIYpKRWYe3EFSCOD6oqyuibjFYAiitnQihPnOZri+YJj/L4w0PXWRe7MQ2cN7xvIrYXKYW/yG1GTXcKuNh4IdC1cVSCsZ/NJ+U4HXPNsQJ6ir3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jMYq7Jop; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMYq7Jop"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750776296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gHqfJeywI6ziSB1Gdb2sQjWIBx0ZSLhj1gn56Myi5+w=;
	b=jMYq7JopvkW36xe7xMJIJZFsnHp9GmqfGanwgGafWUNFloCp0RIdDn1iBvQt26uzG73ORA
	ju+lKqy3ZEeG8MpubG3qBS5gYSYL8ModPlIWtyyD7+vPx4VSdMmaIzXCvxlhjUzPADQc1e
	lIww2gI7WSWGtb+5J8kOfegcpSVvwMg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-44_mvjYJOQmGSn007YcAOw-1; Tue, 24 Jun 2025 10:44:53 -0400
X-MC-Unique: 44_mvjYJOQmGSn007YcAOw-1
X-Mimecast-MFC-AGG-ID: 44_mvjYJOQmGSn007YcAOw_1750776293
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450eaae2934so46761705e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Jun 2025 07:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750776292; x=1751381092;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLcxxnqRZ5+f05tvB52Bk6zB2CYTD16ghvbgMe9EAr8=;
        b=dGc+2Ou6IZyrUxYE3RjUaYs15RYq4GoWKQb4Wfa5j5o/mgRAeiR5/Z/ABqCS835+YB
         LNlT4BI32N0Pv8hnxjKJgP37L3tmKcU1P635c7CEgzntWcbTXxdtyi1n0T1OhwC5OBZQ
         nScimpk9DsOUP3B9/wF4bM06HvqrNHyP/0KUi1mefh9FO2WKffAs39miDdb0xCHjRjI+
         JaaVPgroq/X9WCf97AeDYHKIt/8zHscxmHNaVRjXYBBrpv94VXhQqbsnwtxhyNtFaQ3w
         jwLbRz2JV7rGhGKZDp8J+KosDj9QMFk0wAcUg3YqEZz8U5zYwU+wayLiAfuRYhjelD/n
         3RcA==
X-Forwarded-Encrypted: i=1; AJvYcCXXdswtFDCz+vXlh5dhjyLULYAUDv6cBayy4mNBqpGWQkG3SBnvk5Eu8TW6xdY02RJ9oIVRLcgGSWMy2vv4OvAPV10=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPDXQBvYLg4ar8qre9bRAZOnjh45smRKM3Dyzs/+KTd2w5clgX
	SbZrlmfzbyEaEfrBR/xiQnYk12dA8DONBfXU4S7qBL6HMgIbAdb3y1T4s5LERzAlpx48yvphQrA
	wVaV/Q1nMpE2Y0QezsnCrbSt/WmGqA+Zq/bQ4hBWW5/2fNFw91LbfK1dsZ9ifyge8PUTrmERKkg
	==
X-Gm-Gg: ASbGncuYkHzaK0csCnW2R4XzvJVtcVqgR11LG6zVqhAH5oGmcSaWmFUNZ5SaTNA+ATu
	33/5AO610B7czW7Kq2jcsc5xjZn9Ok9sbP9f2xy683H62lQCSGZzxAcf3QoonTYmzMy+pbcEVr9
	aiCGQj2nVYg8H+ZM1Fhu1w70+sp80CbAH7/HslnDAuYecU8f9wjbTdOn+S/nx/3JwNOdhV1gMbL
	FkAo4uV0UjEtLVYsdzh4QXqGQ//fC17HR+TwWzx9xVOT8G3JJ2hv4U8h8W+7jO79UNhXnFfxLUL
	VUiz2uBRqD6ZVCVdI07gA+yyCO1/ras1IF5S2fMiqoWUpWnJ
X-Received: by 2002:a05:600c:4fc5:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-453659ee9famr167525195e9.16.1750776292486;
        Tue, 24 Jun 2025 07:44:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH+bnvqk5AdSusPNS/x+/GsWWWythv10L4NSLOB5NqoePKQqBx7+VdoIha2cWe8D+LTySvCA==
X-Received: by 2002:a05:600c:4fc5:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-453659ee9famr167524865e9.16.1750776292042;
        Tue, 24 Jun 2025 07:44:52 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646cb57fsm146342375e9.1.2025.06.24.07.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:44:51 -0700 (PDT)
Message-ID: <e2b2e78a9c66973d90a9dbeea83b88b97182c36e.camel@redhat.com>
Subject: Re: [RFC PATCH v2 09/12] rv: Replace tss monitor with more complete
 sts
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Jonathan Corbet	 <corbet@lwn.net>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Ingo Molnar	
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tomas Glozar	
 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
 john.ogness@linutronix.de
Date: Tue, 24 Jun 2025 16:44:49 +0200
In-Reply-To: <20250624073609.OA9Q1V4g@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
	 <20250514084314.57976-10-gmonaco@redhat.com>
	 <20250624073609.OA9Q1V4g@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lyPlJHGUfzdLFIUyo7lHLgsTbH3JWKm-L_g_oundZWo_1750776293
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2025-06-24 at 09:36 +0200, Nam Cao wrote:
> On Wed, May 14, 2025 at 10:43:11AM +0200, Gabriele Monaco wrote:
> > diff --git a/kernel/trace/rv/monitors/tss/tss_trace.h
> > b/kernel/trace/rv/monitors/sts/sts_trace.h
> > similarity index 67%
> > rename from kernel/trace/rv/monitors/tss/tss_trace.h
> > rename to kernel/trace/rv/monitors/sts/sts_trace.h
> > index 4619dbb50cc0..d78beb58d5b3 100644
> > --- a/kernel/trace/rv/monitors/tss/tss_trace.h
> > +++ b/kernel/trace/rv/monitors/sts/sts_trace.h
> > @@ -4,12 +4,12 @@
> > =C2=A0 * Snippet to be included in rv_trace.h
> > =C2=A0 */
> > =C2=A0
> > -#ifdef CONFIG_RV_MON_TSS
> > -DEFINE_EVENT(event_da_monitor, event_tss,
> > +#ifdef CONFIG_RV_MON_STS
> > +DEFINE_EVENT(event_da_monitor, event_sts,
> > =C2=A0=09=C2=A0=C2=A0=C2=A0=C2=A0 TP_PROTO(char *state, char *event, ch=
ar *next_state,
> > bool final_state),
> > =C2=A0=09=C2=A0=C2=A0=C2=A0=C2=A0 TP_ARGS(state, event, next_state, fin=
al_state));
> > =C2=A0
> > -DEFINE_EVENT(error_da_monitor, error_tss,
> > +DEFINE_EVENT(error_da_monitor, error_sts,
> > =C2=A0=09=C2=A0=C2=A0=C2=A0=C2=A0 TP_PROTO(char *state, char *event),
> > =C2=A0=09=C2=A0=C2=A0=C2=A0=C2=A0 TP_ARGS(state, event));
> > -#endif /* CONFIG_RV_MON_TSS */
> > +#endif /* CONFIG_RV_MON_STS */
>=20
> You are changing the tracepoint's name. Should we worry about
> breaking
> userspace?
>=20

Well, to be extremely picky, although that's what git shows, I'm not
changing tracepoints names, I'm removing tracepoints and adding similar
ones with different names.

That said, you're bringing a very good point, I guess removing/adding
monitors is going to be something quite common in the near future.

> It probably doesn't matter at the moment, because I doubt anyone is
> really
> relying on this tracepoint. But I think we should have a definite
> stance on
> this, for future references.
>=20
> I have seen tracepoints being changed (I know of [1][2][3], I was one
> of
> them :P), so it seems to be considered okay. But adding userspace
> tools to
> the equation and it doesn't make sense to me. For example, lttng is
> using
> the page_fault tracepoints [4], which is broken by [3].
>=20
> If this should be stable user API, then we should starting thinking
> about
> better API which allows changes like this to happen. Otherwise, they
> should
> be clearly documented to be unstable.
>=20
> (I think I may also need to change my rtapp's tracepoint names at
> some point
> in the future, that's why I am asking)
>=20

As you mentioned, nobody is likely relying on those tracepoints names
at the moment, but I would rather be cautious basing userspace tools on
some monitors to exist at all.

In my opinion, RV tracepoints are useful as an alternative of
reactors/rv userspace tool but cannot be used without considering the
RV interface itself (e.g. available_monitors and friends).

We could at least stick to the following assumptions:
1. monitors can change names, be added or removed
2. tracepoints are consistent to monitor names (in available_monitors)
3. the tracepoint structure does not change (i.e. event_/error_, args.)
   (can change for new monitors types where seen fit)

If in the future we allow the possibility to build RV monitors as BPF
programs, we'd probably also allow monitors without tracepoints at all,
but I'd say for now those assumptions are sensible.

What do you think?

Thanks,
Gabriele

> Best regards,
> Nam
>=20
> [1] commit dbb6ecb328cb ("btrfs: tracepoints: simplify raid56
> events")
> [2] commit 244132c4e577 ("tracing/timers: Rename the hrtimer_init
> event to hrtimer_setup")
> [3]
> https://lore.kernel.org/lkml/2dda8c03-072a-43b2-af0c-bb996d64c388@cs.wisc=
.edu/#t
> [4]
> https://github.com/lttng/lttng-modules/blob/master/include/instrumentatio=
n/events/arch/x86/exceptions.h#L88C48-L88C63

