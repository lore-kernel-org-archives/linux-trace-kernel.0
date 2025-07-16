Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0C22F5319
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682491; cv=none; b=YMIQ4h0BRK4OHpFVddSBmfH7+HUo59Ff1iO/5xh2qRjKIZmNZNdbnqgFzaAq4JObV5v+JITlNx1wLlcXN+k41ZaS3GhXbMaE8aJU7awIGcRbWKzVPCxtyANkfk3jOLTp+B4V6chbwWCSU3OnAljGx5o5SX5s3dBxJ+k2rOQYJ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682491; c=relaxed/simple;
	bh=caPQsxMaBKfuAJUhMxcZI02W5/m/8IxsrRwhRieczQY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BeengKRRA8uEZcxqV6wvfnTOtf7znOVdqwJRCBmELFZr2W63IZIKZHKEE9Z5xtW4AFR6ObSIxQ+naVSkd2MP3frsgZ3iFDQjTftjdnitrN2aM4ZpcmZjhEj5yQy78EYVqR0xmR4e7MeW1KTfvcU59xUXLHouy5L0cPhrTESmAr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J9F9kubb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9F9kubb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752682488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=caPQsxMaBKfuAJUhMxcZI02W5/m/8IxsrRwhRieczQY=;
	b=J9F9kubb/GA+6Lse7JqI6j/5WCP9zWuJ8COCImZDytFyCWvTH6h0DlYPhKLQvLaoUGwY+k
	CA/z6reEgy31Bj4TSI2zbP3T2AMj2pCIacshUZSM4jasbWV1JwMlB1yh5D4nN5R/eumrJZ
	2dqgM1eSYkSe9c0brbNML0EC6hUHUrA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-9lqwS6dsO-WqcJqWtxuwjw-1; Wed, 16 Jul 2025 12:14:45 -0400
X-MC-Unique: 9lqwS6dsO-WqcJqWtxuwjw-1
X-Mimecast-MFC-AGG-ID: 9lqwS6dsO-WqcJqWtxuwjw_1752682484
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a503f28b09so53475f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682484; x=1753287284;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=caPQsxMaBKfuAJUhMxcZI02W5/m/8IxsrRwhRieczQY=;
        b=kQbAnxtQqIulIFwV9VasWv1aKCNEBEvZJcMAJHVdRrYptK6zfC3kwnydSvwydPZV0h
         otNbQCWbDIICOeBgcFXD99qAQ25FajNkytvifVHNRAEfouqbYZ7aJDqduNsoIo8t/VOr
         FN+mC6uuI3MhGgZSokZdXTI0S9iLLZEp6LHPV4Wx0XoxmAJ9YzjculkJxIAHYRzLLirC
         ixLZzFNSB0K8PF3oJA5h9PLYPhOShTocklVp/Ws1syls3CEBGqwFClL7H5PNzqRFqWi5
         Q468l73svQ9ssssn0H+g4ObwJTbdz9pzN1uaChwdAmlzZuihetG2BGqMPp1MvhCZgi/Z
         wukw==
X-Forwarded-Encrypted: i=1; AJvYcCVS26UcS6LywDsIuz56Dk9FFyWNEnYzBNAY5xeEesw/yZBNEbNzaRGO0lF+OmBujmmi4MIf5MuK2TWBC0oapEkq2Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrNDwr/cxSnOee+FAA6t6gpRwZXcz+WkQuxUGmKjB/grSih14T
	Ul0xviFBjU7GmR28gyVi1TV7SnfR/2jJEWesJEldntns38LUoT6dUzJs/WsUrVEUbbZhN9pXdjp
	3zbR0TJeXuEgM+7ZibSO9a+tYFEtJ4G/YcvqCnu89vXmWJgxI3ekxHo/0VVx4S0mCtNOgC2usEQ
	==
X-Gm-Gg: ASbGncuiFo9zIlzsvsJG2XfM+dQSmW0sTO7qlG0Uj/j1ZBnkSg3TBWo4UmntqzgLtOK
	24wWHa3w2Ita2h2SB75Hz5WpZfG341KXIgiqLPIGzpHumPDYY1XXPATmVAC/7LcEiDe1uWyCI4X
	oGukkK4sUg+4xz2MTgJVlpoTmzmVNLU0qFZoNba+0I9/xgtemhQFFyZXc+PD5r2Y7+HM6tmUmUH
	ACrpHxaE5qplYrcd3UZssIKzPbP7ymaKb3W2Yh1F8AVdGnpoOZEddgWJIbBzDoawuDXGXUApJMh
	UMTfKdWFx9dDRWHtHDnIUTCTO0yTv7DN4Ko19yMvPktirsH56fSGsZFM7MWwlWAvxw==
X-Received: by 2002:a5d:61c9:0:b0:3b5:e077:af52 with SMTP id ffacd0b85a97d-3b613a23674mr20543f8f.25.1752682483842;
        Wed, 16 Jul 2025 09:14:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBt7nrUXuBFgPX3anXe0tcehLEJl16049ahtmmdy0QKOqK7pYfXdmuoS7eEKIXQnFLYIFwag==
X-Received: by 2002:a5d:61c9:0:b0:3b5:e077:af52 with SMTP id ffacd0b85a97d-3b613a23674mr20511f8f.25.1752682483409;
        Wed, 16 Jul 2025 09:14:43 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc2464sm18650429f8f.38.2025.07.16.09.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:14:43 -0700 (PDT)
Message-ID: <1da3336a234fddcea9dc91f5ef9943e7ccecc07e.camel@redhat.com>
Subject: Re: [PATCH v3 12/17] sched: Adapt sched tracepoints for RV task
 model
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, Tomas
 Glozar	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 18:14:40 +0200
In-Reply-To: <20250716153144.GY1613200@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-13-gmonaco@redhat.com>
	 <20250716123832.GW1613200@noisy.programming.kicks-ass.net>
	 <122cfd4ba6b0805e91ff09526d5d159ff3871964.camel@redhat.com>
	 <20250716134513.GB905792@noisy.programming.kicks-ass.net>
	 <fe38ba0b9da0209bcc97c2f348f5a6b266991073.camel@redhat.com>
	 <20250716141958.GC905792@noisy.programming.kicks-ass.net>
	 <be966ed3d4a7ace6aa430bbc5c16ecbff3118426.camel@redhat.com>
	 <20250716153144.GY1613200@noisy.programming.kicks-ass.net>
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
X-Mimecast-MFC-PROC-ID: ffg2zDv2rP-dvN5HIAaCwBGDFayX6nCS8hqUPAI2qpY_1752682484
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-07-16 at 17:31 +0200, Peter Zijlstra wrote:
> On Wed, Jul 16, 2025 at 04:38:36PM +0200, Gabriele Monaco wrote:
>=20
> > So as you said, we can still reconstruct what happened from the
> > trace, but the model suddenly needs more states and more events.
>=20
> So given a sequence like:
>=20
> =C2=A0 trace_sched_enter_tp();
> =C2=A0 { trace_irq_disable();
> =C2=A0=C2=A0=C2=A0 **irq_entry();**
> =C2=A0=C2=A0=C2=A0 **irq_exit();**
> =C2=A0=C2=A0=C2=A0 trace_irq_enable(); } * Ni
> =C2=A0 trace_irq_disable();
> =C2=A0 { trace_sched_switch(); } * Nj
> =C2=A0 trace_irq_enable();
> =C2=A0 { trace_irq_disable();
> =C2=A0=C2=A0=C2=A0 **irq_entry();**
> =C2=A0=C2=A0=C2=A0 **irq_exit();**
> =C2=A0=C2=A0=C2=A0 trace_irq_enable(); } * Nk
> =C2=A0 trace_sched_exit_tp();
>=20
> It becomes somewhat hard to figure out which exact IRQ disabled
> section
> the switch did not happen in (Nj =3D=3D 0).
>=20
> > If we could directly tell whether interrupts were disabled manually
> > or from an actual interrupt, that wouldn't be necessary, for
> > instance (as in the original model by Daniel).
>=20
> Hmm.. we do indeed appear to trace the IRQ state before adding
> HARDIRQ_OFFSET to preempt_count(). Yes, that complicates things a
> little.
>=20
> So... it *might* be possible to lift lockdep_hardirq_enter() to
> before we start tracing. But then you're stuck to running with
> lockdep enabled -- I'm thinking that's not ideal, given those other
> patches you sent.
>=20
> I'm going to go on holidays soon, but I've made a note to see if we
> can lift setting HARDIRQ_OFFSET before we start tracing. IIRC the
> current order is because setting HARDIRQ_OFFSET is using
> preempt_count_add() which can be instrumented itself.
>=20

Yeah I wondered if that was something perhaps required by RCU or
something else (some calls are in the way). NMIs have it set during the
tracepoints, for instance.

Thanks again and enjoy your holiday!

Gabriele

> But we could use __preempt_count_add() instead, then we loose the
> tracing from setting HARDIRQ_OFFSET, but I don't think that is a
> problem. We already get the latency from the IRQ tracepoints after
> all.
>=20
> > I get your point why we don't really need the additional
> > tracepoint, but some
> > arguments giving more context come almost for free.
>=20
> Right. So please always try and justify adding tracepoints.

