Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19011F03F2
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 May 2025 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747641301; cv=none; b=fg3QxqfGDZ8wymnobZLdPfKjbYR2KYcYN43GqArqYqOHorQiZ2N15DogDNcpEDIJczivI7ghkOwaLrHhw8GwHWN+mDr8Zj7qSRusNGt02o122lpi+sUfhb+dfnsJ3y9ZzuLHEefEQDAhMZ71b5w+0+32lTnh5UWTO8yggnOKpSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747641301; c=relaxed/simple;
	bh=zRaXWFsLCZTdy869yY7WHCAjDVTKxWy9kgXr0+7zWGk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqbGslvIcJ+LVaHTK31A/ZrV8UMTYDVL+0BNsc7NCCqz5l6d0gY23TZ/Tvk4+rRva8s4vLjtMmQ9zdQU/XNS4j5TLkk5o82AA/MweV6e6Z3XyQymqKnl5+cQtjrAH6zK70HZxvcgNJ0fVag2tVrnfN167qkM6o1QPduQOmjrn4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=URVlI4jg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URVlI4jg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747641298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zRaXWFsLCZTdy869yY7WHCAjDVTKxWy9kgXr0+7zWGk=;
	b=URVlI4jgMcjdnxjTSUJdS9Z03UX5Z5DBxgoFe5cY2Aa/Zy++/cJaEDFTW8ra2CcmGsURDY
	V9slSP3E/r2axvrc4AV0cw4N8kpViyZwlH9IwGYYpRQGSchK/o79LNI3Ip5KZZTUpAAKzj
	BgezS0+KqwJhi5EK7IteJj1+PDKV3+k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-YSf3nowTMkaeUyiTL5bHUQ-1; Mon, 19 May 2025 03:54:55 -0400
X-MC-Unique: YSf3nowTMkaeUyiTL5bHUQ-1
X-Mimecast-MFC-AGG-ID: YSf3nowTMkaeUyiTL5bHUQ_1747641294
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a3703c1fe7so267323f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 May 2025 00:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747641294; x=1748246094;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRaXWFsLCZTdy869yY7WHCAjDVTKxWy9kgXr0+7zWGk=;
        b=vemvFKlusyPb6Kvy+TyvTjEIF4JNGzH711/00GKogSjI6HjKCTuzXHPvPvA/28BjQh
         conmF5rOzc0k0JYmOUblQFHUqZ+OPYniJyFZRhYNaYVBIcBHPL+tdhCJbT8Ot7SQnTtA
         wxZJe7iVhNcvlS7PF2xgGfb8t/quzQIMZmbXSZQMxlc/+XPLjLbtzAuWq+t3WuAWyEpy
         6ew+GOqDIFSdqy3yMWqdbZAjbYl2yKoOtTAAhyPI5Inou20ikZjpu1kTvre7W6hL885o
         W9ClRFDJDvyKGh0pu6AQLh7PJPcE1i2NjMQbfaKhSQb0ncpu9Rk4W8O6U4CZ3UJb134q
         jI7g==
X-Forwarded-Encrypted: i=1; AJvYcCU+ZhBe21147LU4AwB9g3ZniEtyKp3YmVmKt41MQz/ZfSeqxzB8wqzhsSTCs0R5iJ7bK70bXdCgZLArVmw2SwrjG0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YynDRYd8oq22a6SoVu4zNyY8KZVwA51YipdMC8oaWKnd7/R2kLd
	xqXXEbTbkijduAIoRuptcbZ+AxyhYK6CgY3Ux+4IkjWN/cIMGWAVQI/DsRBVFE7bNkt4IQriT3R
	JOoG1DpBfYuZk0mb9YmxQsLQ/PBdd2+qhR2/mVsQrnT8/CdehWYII5tLeQLYOaAdqHtbgTu95NQ
	==
X-Gm-Gg: ASbGncvFXvztR8Juckv7xXrlHEotZlLWm1VLZWykCNgXgqe+hBLcgfuLFvZhYHMmjQX
	g1OQ14Pst60356Iucd8Al0qHmyRkhyFA2E8uv7fOHFYyfvfWmUgooXNQ5qCOLehnlcdkZDQ4yfY
	PUJyv7++9TnjMHkszURUQObUEVq3Y4q3vIO9jLa6QXIGXLTO0bb7tOY2WCPESuwC2oQBeK+eJod
	RzC/RluxJuLX8zgCg4WTxy6s33soFP45K/i9gWls0iomRpxPItC2g31BT8sRRN6nr6tESY32FgE
	9QEM5NKgFyvXF1V5iysALbdzLK5DA5lYalYiXg==
X-Received: by 2002:a05:6000:1848:b0:3a3:64d5:5b5b with SMTP id ffacd0b85a97d-3a364d55c21mr5704844f8f.5.1747641294278;
        Mon, 19 May 2025 00:54:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvHz58uwM2+x7HZV40etQPbkDCTTwdHiDnNcbgIzq1H8F23HoVmQ7z0cS3LG9HdyPrrz6HRA==
X-Received: by 2002:a05:6000:1848:b0:3a3:64d5:5b5b with SMTP id ffacd0b85a97d-3a364d55c21mr5704824f8f.5.1747641293891;
        Mon, 19 May 2025 00:54:53 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39ef811sm194669155e9.35.2025.05.19.00.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 00:54:53 -0700 (PDT)
Message-ID: <bd35a5165cb01450e799f025e8faaaa8a36ad51a.camel@redhat.com>
Subject: Re: [PATCH v8 20/22] rv: Add rtapp_sleep monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de
Date: Mon, 19 May 2025 09:54:52 +0200
In-Reply-To: <20250519070425.xDEPNyBe@linutronix.de>
References: <cover.1747046848.git.namcao@linutronix.de>
	 <3199656a35cc8a7acc2e30d320defa778acf8532.1747046848.git.namcao@linutronix.de>
	 <06d48208-686a-4d33-95ca-4e4d5991a42f@redhat.com>
	 <20250519070425.xDEPNyBe@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pZQ2inGTi6yJIJCbeuOGjyPrtEmU0QuA4h8ooFc4Wmc_1747641294
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Mon, 2025-05-19 at 09:04 +0200, Nam Cao wrote:
> On Fri, May 16, 2025 at 04:31:03PM +0000, Gabriele Monaco wrote:
> > 2025-05-12T10:56:30Z Nam Cao <namcao@linutronix.de>:
> > > diff --git a/kernel/trace/rv/monitors/sleep/Kconfig
> > > b/kernel/trace/rv/monitors/sleep/Kconfig
> > > new file mode 100644
> > > index 000000000000..d00aa1aae069
> > > --- /dev/null
> > > +++ b/kernel/trace/rv/monitors/sleep/Kconfig
> > > @@ -0,0 +1,13 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +#
> > > +config RV_MON_SLEEP
> > > +=C2=A0=C2=A0 depends on RV
> > > +=C2=A0=C2=A0 select RV_LTL_MONITOR
> > > +=C2=A0=C2=A0 depends on HAVE_SYSCALL_TRACEPOINTS
> > > +=C2=A0=C2=A0 depends on RV_MON_RTAPP
> > > +=C2=A0=C2=A0 select TRACE_IRQFLAGS
> >=20
> > I had a different approach towards those (the preemptirq
> > tracepoints)
> > under the assumption adding them introduces latency. Besides me
> > picking
> > the wrong config (I used IRQSOFF, I'll fix that) I considered the
> > monitor
> > should /depend/ on the tracepoint instead of select it.
> >=20
> > This way it looks easier to me to avoid making a change that
> > introduces
> > latency slip in when distribution maintainers enable the monitor
> > (e.g.
> > TRACE_IRQFLAGS may be enabled on debug kernels and using depends
> > would
> > automatically prevent the monitor on non-debug kernels).
> >=20
> > Now is this concern justified? Is it only a performance issue for
> > the
> > preempt tracepoint or not even there?=C2=A0 I'd like to keep consistenc=
y
> > but I
> > really can't decide on which approach is better.
>=20
> Both approach is fine, I don't have a strong preference.
>=20
> I doubt that the distribution people would carelessly enable anything
> new,
> and these monitors are disabled by default. So I wouldn't worry too
> much.
>=20

Yeah that's true, I still see dependency makes their life mildly
easier, but as long as it's clear this type of monitor can affect
performance, both solutions work.

> I will do some measurements on the runtime impact of having these
> monitors
> built, so that there will be a recommendation whether to enable them
> in
> distribution kernel. But for now, just like any other debug configs,
> people
> should expect some performance hit.
>=20

Fair enough. We did some tests internally showing noticeable latency
increases with /both/ preempt and irq tracepoints enabled but didn't
perform tests with the irq one alone.
Nevertheless, I'd say a note saying enabling compilation of the monitor
may affect performance even when the monitor is off would do the job
(or anything along the line as you see fit).
Currently RV should not really affect the system when compiled in but
disabled, so I'd make it clear when that happens.

> > Also curiosity on my side (I didn't try), you require
> > TRACE_IRQFLAGS to
> > use hardirq_context but how different is it from in_hardirq() in
> > your
> > case?
>=20
> There is a wake_timersd() in __irq_exit_rcu(). This is a wakeup
> performed
> within interrupt handling, but in_hardirq() doesn't say that.
>=20

Alright, got it.

Thanks,
Gabriele

