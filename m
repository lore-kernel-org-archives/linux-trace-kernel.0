Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519B821C187
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Jul 2025 07:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751440723; cv=none; b=h/Fr4v1+zGfaKdB+Y1f3xnPVjM0pibShfK2NzKCyPHBm4PZLViIf0khWyqMJlhaK0pulPoOQ6yJChNRuashd5Sl64KTBbITsaRlX+vM29aNfb8YuGPIbj503Lh7DJCrtdFLAJseo7O9sjddVBb/GdvwYTGrZCauHH2Kt4/wi5ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751440723; c=relaxed/simple;
	bh=AT7bhteY5L8Tq2p/pluU+cmzUv5/OBqLYcbsj13GJO0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIuJ2rKva2L/ecekkx55afAN+GQPubIPHjpF6b7frtS1ZMwK+AcxO6E78MBfIrHaDc9HCNufjA9I884gX6yPDQt3BvI9b4kIa0lXob1dFa5Koe9LNQD3eBj66lvnRUAsdLIgIcl4tOpyrCaf5U2JwqVJKX6Pd9/nl93q8MRBYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AooL8h0k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AooL8h0k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751440720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1HpnIoplFmWQYQkSy1915z9kG2C5g+9MVhFgiTrBDOc=;
	b=AooL8h0k6TfdJmF9pNrqNoGYQv6n7617f4HDrtX6gPmcPKuILKGJZpiCcyWAWuer8htQSb
	YR8Ln9hW8I1wLH2r99cQyuax5GVAk0u5Of67ap5+/a8ehM5Im++5MAwwPuEdDe9xbAvLlF
	xxGWXzAFTjNhgfaujHAkI2khC9Hhk0c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-1X89huJxPnCpc-yv2Q5ypg-1; Wed, 02 Jul 2025 03:18:37 -0400
X-MC-Unique: 1X89huJxPnCpc-yv2Q5ypg-1
X-Mimecast-MFC-AGG-ID: 1X89huJxPnCpc-yv2Q5ypg_1751440716
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4536962204aso16276405e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 02 Jul 2025 00:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751440716; x=1752045516;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDUViJcXkIlXiB88dAQamJf+aOAdf1T+Ho4KanTBA8E=;
        b=Dei995qybccbDegk/KheajTqbI4X1s87owRWlRW180PSF3voGpuD2L3Yb0sqXVwGqX
         cDAtJBp4V1WuZod9v/qZPzJiKW/cOuXi/HkmvyrZT7hKegu3Y2UvyLLxcS4XUAZkI0e1
         G7AmHRnbE6nk7NCSKFCAvb1Je/gQkUzHVaOq7Oxx7p1Izyt1+x6g5Ef78nviiEbfdCqC
         qWctZPxngVxOJTOhymVIYwHd0nTu2K8XU2xa1WoAit/QbPU1wzNfhKqIygW5lsGr9Pn7
         q/99W4aZnixdCUrzsq4Xa/F9/QBVFlhjV1Di2EH6KZw82UAtCCLzJo/OnkZreCj5V9iS
         9pFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC6A0mlUhAoO6rbAClCVWlEwJCxMhk46Hb8A6v1N3K+CMd92Kmfq2499ODOx6cYcUg5MDlLYn2L82j9N1Wxs6sGmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8dLFvaegKEbJzyPYm1DI9ttEywiUcdehwit8ZxgpHqYf4AmqB
	FKZoCd20VrFHqKVxQ26iQTjjSO3vCfnohg96UXqB1SXj6LLHwomSenjMcrV8I2mB3b036DjraWZ
	f61pFoWN95sWn3NtM8viReG9skbdrxu81CaqRbvunGqh+eiInmSHNZ6mmD+uTTPZuRFOHmMQWnw
	==
X-Gm-Gg: ASbGnct6t27/0D9ggjJZ+Dcfy/bRv3JmDQdc5SkA0Mp+JqgLTaRbpfKQocobPWzBzWS
	Q/UQvg0qwfoAuJ3JCkfKiKSZM62i+db1ivdezVIfFrPc9syCrw/8PTL+De1Mw+EZ1UhWiKJd59N
	9L/QVdQZpIqFhJBDUWMyFE5OsLtjHeXKuKr+oKJNDrmxdGG5E9LTDMDPfLihuLY5VatHDTwPcb5
	8he1rce0FCpGbEESLlHJM3tgDPZZmHhreEVAEn25TFqpMYoTO9Ef7BOBFq4OUAqDagumqbso7w1
	vQ8xmzo6cFAm1zuo8CiRLXRBn95yuiyahZsj7QZ+2WHQGwMg
X-Received: by 2002:a05:600c:1c09:b0:43c:f70a:2af0 with SMTP id 5b1f17b1804b1-454a38c6b35mr18382925e9.16.1751440715704;
        Wed, 02 Jul 2025 00:18:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0GCHKuqWnzbgcCC6m78Wi/zAqCIxAo5Dp7eqsRuep+U+N6YTxhNMXvShwaYLGKWZpCfAjNg==
X-Received: by 2002:a05:600c:1c09:b0:43c:f70a:2af0 with SMTP id 5b1f17b1804b1-454a38c6b35mr18382505e9.16.1751440715213;
        Wed, 02 Jul 2025 00:18:35 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c05csm219597395e9.5.2025.07.02.00.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 00:18:34 -0700 (PDT)
Message-ID: <5097b17cc506af60ca718aba5a0a10e0fda01440.camel@redhat.com>
Subject: Re: [PATCH v2] tracing: Fix inconsistency in irq tracking on NMIs
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
  Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andy
 Lutomirski <luto@kernel.org>,  Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>,  Mark
 Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org
Date: Wed, 02 Jul 2025 09:18:32 +0200
In-Reply-To: <20250701125459.GL1613200@noisy.programming.kicks-ass.net>
References: <20250625120823.60600-1-gmonaco@redhat.com>
	 <20250701125459.GL1613200@noisy.programming.kicks-ass.net>
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
X-Mimecast-MFC-PROC-ID: _gBC9tbNhUfi2UCRJ1IAQ_2QY_mS0N11F4d1Ii8Hxhc_1751440716
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2025-07-01 at 14:54 +0200, Peter Zijlstra wrote:
> On Wed, Jun 25, 2025 at 02:08:22PM +0200, Gabriele Monaco wrote:
> > The irq_enable/irq_disable tracepoints fire only when there's an
> > actual
> > transition (enabled->disabled and vice versa), this needs special
> > care
> > in NMIs, as they can potentially start with interrupts already
> > disabled.
> > The current implementation takes care of this by tracking the
> > lockdep
> > state on nmi_entry as well as using the variable tracing_irq_cpu to
> > synchronise with other calls (e.g. local_irq_disable/enable).
> >=20
> > This can be racy in case of NMIs when lockdep is enabled, and can
> > lead
> > to missing events when lockdep is disabled.
> >=20
> > Remove dependency on the lockdep status in the NMI common
> > entry/exit
> > code and adapt the tracing code to make sure that:
> >=20
> > - The first call disabling interrupts fires the tracepoint
> > - The first non-NMI call enabling interrupts fires the tracepoint
> > - The last NMI call enabling interrupts fires the tracepoint unless
> > =C2=A0 interrupts were disabled before the NMI
> > - All other calls don't fire
>=20
> I'm not at all convinced this is correct. Nor can I understand
> anything
> much about what you wrote above.
>=20
>=20
> > =C2=A0arch/arm64/kernel/entry-common.c |=C2=A0 5 ++---
> > =C2=A0kernel/entry/common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++---
> > =C2=A0kernel/trace/trace_preemptirq.c=C2=A0 | 12 +++++++-----
> > =C2=A03 files changed, 11 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/arch/arm64/kernel/entry-common.c
> > b/arch/arm64/kernel/entry-common.c
> > index 7c1970b341b8c..7f1844123642e 100644
> > --- a/arch/arm64/kernel/entry-common.c
> > +++ b/arch/arm64/kernel/entry-common.c
> > @@ -213,10 +213,9 @@ static void noinstr arm64_exit_nmi(struct
> > pt_regs *regs)
> > =C2=A0=09bool restore =3D regs->lockdep_hardirqs;
> > =C2=A0
> > =C2=A0=09ftrace_nmi_exit();
> > -=09if (restore) {
> > -=09=09trace_hardirqs_on_prepare();
> > +=09trace_hardirqs_on_prepare();
> > +=09if (restore)
> > =C2=A0=09=09lockdep_hardirqs_on_prepare();
> > -=09}
> > =C2=A0
> > =C2=A0=09ct_nmi_exit();
> > =C2=A0=09lockdep_hardirq_exit();
> > diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> > index a8dd1f27417cf..e234f264fb495 100644
> > --- a/kernel/entry/common.c
> > +++ b/kernel/entry/common.c
> > @@ -343,10 +343,9 @@ void noinstr irqentry_nmi_exit(struct pt_regs
> > *regs, irqentry_state_t irq_state)
> > =C2=A0{
> > =C2=A0=09instrumentation_begin();
> > =C2=A0=09ftrace_nmi_exit();
> > -=09if (irq_state.lockdep) {
> > -=09=09trace_hardirqs_on_prepare();
> > +=09trace_hardirqs_on_prepare();
> > +=09if (irq_state.lockdep)
> > =C2=A0=09=09lockdep_hardirqs_on_prepare();
> > -=09}
> > =C2=A0=09instrumentation_end();
> > =C2=A0
> > =C2=A0=09ct_nmi_exit();
> > diff --git a/kernel/trace/trace_preemptirq.c
> > b/kernel/trace/trace_preemptirq.c
> > index 0c42b15c38004..fa45474fc54f1 100644
> > --- a/kernel/trace/trace_preemptirq.c
> > +++ b/kernel/trace/trace_preemptirq.c
> > @@ -58,7 +58,11 @@ static DEFINE_PER_CPU(int, tracing_irq_cpu);
> > =C2=A0 */
> > =C2=A0void trace_hardirqs_on_prepare(void)
> > =C2=A0{
> > -=09if (this_cpu_read(tracing_irq_cpu)) {
> > +=09int tracing_count =3D this_cpu_read(tracing_irq_cpu);
> > +
> > +=09if (in_nmi() && tracing_count > 1)
> > +=09=09this_cpu_dec(tracing_irq_cpu);
> > +=09else if (tracing_count) {
> > =C2=A0=09=09trace(irq_enable, TP_ARGS(CALLER_ADDR0,
> > CALLER_ADDR1));
> > =C2=A0=09=09tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
> > =C2=A0=09=09this_cpu_write(tracing_irq_cpu, 0);
> > @@ -89,8 +93,7 @@ NOKPROBE_SYMBOL(trace_hardirqs_on);
> > =C2=A0 */
> > =C2=A0void trace_hardirqs_off_finish(void)
> > =C2=A0{
> > -=09if (!this_cpu_read(tracing_irq_cpu)) {
> > -=09=09this_cpu_write(tracing_irq_cpu, 1);
> > +=09if (this_cpu_inc_return(tracing_irq_cpu) =3D=3D 1) {
> > =C2=A0=09=09tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
> > =C2=A0=09=09trace(irq_disable, TP_ARGS(CALLER_ADDR0,
> > CALLER_ADDR1));
> > =C2=A0=09}
> > @@ -103,8 +106,7 @@ void trace_hardirqs_off(void)
> > =C2=A0{
> > =C2=A0=09lockdep_hardirqs_off(CALLER_ADDR0);
> > =C2=A0
> > -=09if (!this_cpu_read(tracing_irq_cpu)) {
> > -=09=09this_cpu_write(tracing_irq_cpu, 1);
> > +=09if (this_cpu_inc_return(tracing_irq_cpu) =3D=3D 1) {
> > =C2=A0=09=09tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
> > =C2=A0=09=09trace(irq_disable, TP_ARGS(CALLER_ADDR0,
> > CALLER_ADDR1));
> > =C2=A0=09}
>=20
> So what about lovely things like:
>=20
> trace_hardirqs_on_prepare()
> =C2=A0 if (tracing_irq_cpu) {
> =C2=A0=C2=A0=C2=A0 tracer_hardirqs_on();
> =C2=A0=C2=A0=C2=A0 <NMI>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_hardirqs_off_finish();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (this_cpu_inc_return() =3D=
=3D 1) // will be > 1
>=20
>=20
> So now we've traced IRQs are on, start an NMI, and loose the IRQs off
> event. Well done.
>=20
>=20
> This was all safe in that it would occasionally emit a duplicate
> state,
> but no state was wrong. Both your attempts have broken things.
>=20
> How about you fix you tool to accept duplicate state in the face of
> NMI
> instead?

Alright, I get this is yet another broken solution.. Thanks for
pointing it out.

The problem here is that, from the model's perspective, we don't only
get duplicated events, but also missing ones:

 d..1. ..932: irq_enable:   caller=3Dfinish_task_switch
 d.h3. ..933: event_sncid:  can_sched x irq_disable -> cant_sched
 d.h2. ..933: irq_disable:  caller=3Dirqentry_nmi_enter+0x53=20
 d.h2. ..936: nmi_handler:  perf_event_nmi_handler()
< missing irq_enable from NMI >
 ...2. ..942: error_sncid:  event schedule_exit not expected in the
state cant_sched

[This monitor verifies exiting and entering __schedule occur only with
interrupts enabled]

I first thought this was just possible with racing NMIs, but as Thomas
pointed out [1], this can happen much easier when irqsoff is enabled
but lockdep is not.

I could probably only fix this without even considering NMIs when
interrupts are disabled, but I believe if that happens, the tracepoints
would report something wrong, since using tracing_irq_cpu alone does:

local_irq_disable -> trace_irq_off
  nmi_enter -> no trace
  nmi_exit -> trace_irq_on
  // here interrupts are still off, aren't they?
local_irq_enable -> no trace

The idea that I described poorly, was to use tracing_irq_cpu in a way
that the first context disabling interrupts fires the tracepoint
(current behaviour), but when it's time to enable interrupts, an NMI
which didn't disable interrupts shouldn't trace but let the next
context trace.

Thanks,
Gabriele

[1] - https://lore.kernel.org/lkml/87sejup1fe.ffs@tglx

