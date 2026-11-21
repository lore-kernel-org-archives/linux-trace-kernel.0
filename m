Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795270996;
	b=sbbeSicpsUIXHjUQ5ZYtlgMeDMWBgu5tCHd3Qz9zJehZuAoWIFnuQqRsoj+8kPffGdF2
	 u/AhlUwswFmEfAZvrHOvX94VbZ8iikOP65mSM2vp6yWJfIfjmhA1C/2Pi8rDN+ugQRm5k
	 Q6rLTfvv8a9kk+5aFjq9FcY5uIx8wZZ0WRHgMwKykeBQXNOndv3GSNLFDGIIIlU8GpjJV
	 DsV0cu4vmrI4LChF2wghvt6H+GYqW6RoO0rkbMU2dlzY3lH5nsltzdYQATPleObSySOdf
	 qHAauxF+BEfXX8WjYs9aY7LGrebIzhT/dJjWBKICFZgrj1NHaVWKe0e/rX1t6Hs+3KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795270996;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=WqzN6zJ4R2jqDldWJTZ9k5y4S9ZfXvzqjQVQe1JBsIo=;
	b=G7QJE0qFeRXbcLPH5HUBu/Ki/ZdT97mmI004ScjgZvdPPD3KMq1TUeTtvBjzJOgJ0tCj
	 LYcPtI8BtYMrxqp/3TbgP2evmURs06q8D/QoCspDQW4a1xm9UEipfrOzlTUf352GT7BFG
	 IoQJipbG2PogG9lD063C+uO2EjwgY2ws7O2Q4q6cd1pd7IStVxZ/LQnHYmznNqAKsLNiw
	 dt0bgxokiBnx5hEw1KiZV8VxqVtAjaeNM6PUpSvVJT66wpFJDqN8P1JyIFOnPX29VXUCp
	 g+/7RIjL5XYSrJDgXYEMt9noH5MppqIEeVrFEP7v91w2m1PzieIMfNl+ePo+9lJ0RyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gSmgkcqx;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D347606A32A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 14:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D347606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gSmgkcqx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795270994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WqzN6zJ4R2jqDldWJTZ9k5y4S9ZfXvzqjQVQe1JBsIo=;
	b=gSmgkcqxubNWIlYYc8Ry7rjMOdcLZOiGCQNynXH7+mUPoRacPCUbYNvsgUgEyUdgnopVcc
	nFFllVhP1ypfvO9V+RLlBSlBQHDVwKrVDQPFnN0My4tY0eD98GyESJN6/2fMMAjymE12Ox
	uzHNvT/8tpApVmAUsMcTlYP314L4i3w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-h_zEpoMpP-aPZLz24UJlFA-1; Sat, 21 Nov 2026 14:23:12 +0000
X-MC-Unique: h_zEpoMpP-aPZLz24UJlFA-1
X-Mimecast-MFC-AGG-ID: h_zEpoMpP-aPZLz24UJlFA_1795270991
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48fbcf023dcso764147f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 06:23:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795270991; x=1795875791;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WqzN6zJ4R2jqDldWJTZ9k5y4S9ZfXvzqjQVQe1JBsIo=;
        b=KXkCvUGsr9iVW5beXIIf4x7+U/DBzn9g4aLpFrmCx4GMRbF5sKX/u1m/UlAXbEgCeh
         WuJdF1lkLJ/4jdmHiQEBUJaHRjb521V1RqYliGO5ogF/fDrwO5m/XvNVGQtTfIOgq09k
         RJfl1t1559n16HOV5WWeTyg64ApuQhcL+RwnfOv8Bm4KkFPd74JVjPaG5qP18oKUyuJK
         vazja/Q2G8VVM1QhGx3oD5XY7++ldws00cpp7q+2rY8Fz49nKWsNRerRJjSe8nwdOcGc
         f9LhgPwE9sB4JGY7loOEAOfMLfvbYHHNbmG8AVS7kk+YTf+DkXfme7M+mu1Mu5bmlh72
         J3rA==
X-Forwarded-Encrypted: i=1; AL+hErGsF3NIIgCC4u+QLg5K46tlakaJvwfmEsk7GAlWK3TSSJgYysl98o7w5iyAj7HrApYD6Px1XStI3OdDPwYIQdDGYWA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+iFmqNIBSognDBEipPVNiheuOYvu3Q657bT2O20+SOqznM1i1h
	FqLNORWvFZJOYKFZuTl3cGR2/3A9h+bVUJyIn9JCaI8e3wA3R2lEU6i98+IqTjJRaOwJ4nEnY/e
	Gsp/j6jRr8KM9Q2zGDV4pemOP9fjbOAhVwR9lUgAiZOsFrqm09OyBMvzz7T0R9ru7ijJkJ0dSCI
	eKsc9BpCH2
X-Gm-Gg: AZFdTZcNW25wrggtaJirTH0mpwl2aw+ma1CIlhOQbowo85ee8JwgKLaBGyrWQtyEfub
	3Fl1YhBvRNWcienExF73yy/KUp38rbNapwjLNmMyY7BgxX40wrY7EsHA6w9yvNTl8go1XJjf8/N
	gLRKB9o4NOkQjky88Wu9dg5Reic49SF8ievXs3/HLOmG9Bp3msJBrwLDAZ918G2/YsNSbsMn3G1
	wA7IJ47Af9rvcUWSJiT90k9tPxYpNbsr7AsnjXUJIduXxipvUjfme3KNYRV/kUBRZKr256wl+zd
	UQU0vg+O6PCD5aA0N8rXb6OOesfaC3uXmRAocQRqkhvf+XfahS2gpJ9KDUbtw2JWy92vGi+Rs4f
	136I6vthym/hLzS74OB8OARfKpYzC2ee7gtqZdK6NJXXawuIvsRoPRbVcpL9BO0Wl496daY38cc
	qs
X-Received: by 2002:a05:6000:47d4:b0:4aa:5396:a7bc with SMTP id ffacd0b85a97d-4abb4b849fbmr9281732f8f.40.1795270991170;
        Sat, 21 Nov 2026 06:23:11 -0800 (PST)
X-Received: by 2002:a05:6000:47d4:b0:4aa:5396:a7bc with SMTP id ffacd0b85a97d-4abb4b849fbmr9281710f8f.40.1795270990742;
        Sat, 21 Nov 2026 06:23:10 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4abbd84e661sm10354767f8f.18.2026.11.21.06.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 06:23:10 -0800 (PST)
Message-ID: <9419fa94de8acc8f1ae445004b77d20d0be3e98e.camel@redhat.com>
Subject: Re: [RFC PATCH v2 0/9] rv: Verify generic IRQ context transitions
From: Gabriele Monaco <gmonaco@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers	
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@kernel.org>, 
 Sebastian Andrzej Siewior	 <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Ingo Molnar	 <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Andy Lutomirski	 <luto@kernel.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot	 <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,  Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>,  K Prateek Nayak <kprateek.nayak@amd.com>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,  Randy
 Dunlap <rdunlap@infradead.org>, Wen Yang <wen.yang@linux.dev>,
 linux-trace-kernel@vger.kernel.org, 	linux-rt-devel@lists.linux.dev,
 linux-doc@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Sat, 21 Nov 2026 15:23:08 +0100
In-Reply-To: <20261107171252.25090-1-kmehltretter@gmail.com>
References: <20261107171252.25090-1-kmehltretter@gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LE1oXcW-lt6P5orzD-cxReoct983gZbtleW97wsmwNQ_1795270991
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-11-07 at 18:12 +0100, Karl Mehltretter wrote:
> Questions still open from v1:
>=20
> =C2=A0 1. Are dedicated scheduler tracepoints the right way to follow
> =C2=A0=C2=A0=C2=A0=C2=A0 preempt_schedule_irq() across task switches and =
migration?

So I'm not quite sure you care about running outside or inside the exceptio=
n
context tracking. If you don't, an fentry/fexit in BPF (or fprobe in the ke=
rnel,
not supported) could work for you.

That said, we do roughly the same in __schedule(), so I don't see anything =
wrong
with what you're doing, as long as Peter is fine with it.


Maybe, you could somehow reuse the __schedule() tracepoints and understand =
you
came from interrupt context, but that would obviously not match the
interrupt/preemption counts, although they are (now) guarded by a BUG so yo=
u
don't really need them.
The loop should work fairly well anyway.

The nrp model does something similar with the nested_preempt, flagging a
schedule entry after irq as an irq preemption. You may look into that, I do=
n't
exactly remember but it probably isn't really accurate and you might need
something else.

> =C2=A0 2. Is the KUnit-only hook for an empty ksoftirqd invocation
> =C2=A0=C2=A0=C2=A0=C2=A0 acceptable? Outside a KUnit run, its worker chec=
ks take a disabled
> =C2=A0=C2=A0=C2=A0=C2=A0 static-key path.

I mentioned it briefly in another email, but I don't think you should touch
softirq code at all. Just simulate events, don't cause them.
As a rule of thumb, if your RV unit test creeps into other subsystems, you'=
re
doing something wrong.

Another story is if you want to write softirq KUnit tests, but that's beyon=
d the
scope of this series and I'm not the one to answer it.

Thanks,
Gabriele

>=20
> Patches 1-5 add the tracepoints, monitors and documentation. Patches 6-9
> add KUnit coverage.
>=20
> The series is based on v7.4-rc1, which contains the v1 prerequisite and
> Wen Yang's reactor lockdep fix:
>=20
> =C2=A0 commit feb5c9a2447a ("softirq: Preserve interrupt context on retur=
n from
> interrupt")
> =C2=A0 commit 39ccedfd9e55 ("rv: Use LD_WAIT_SPIN as the reactor lockdep =
wait
> type")
>=20
> The series is independent of the early-hardirq series [2], which
> installs hardirq state before entry tracing. Both change
> kernel/softirq.c, so applying one on top of the other needs a small
> conflict resolution in __irq_exit_rcu().
>=20
> Changes since v1:
>=20
> =C2=A0 - Use bare DECLARE_TRACE() tracepoints instead of trace events
> =C2=A0=C2=A0=C2=A0 (Gabriele)
> =C2=A0 - Rename the irqentry container to irq (Gabriele)
> =C2=A0 - Add text schematics of both models to the documentation (Gabriel=
e)
> =C2=A0 - Document why irqstate and irqexit are separate automata
> =C2=A0 - Rebase onto v7.4-rc1
>=20
> Testing on v7.4-rc1 with Clang 23.1.5, GCC 14.2 (x86) and GCC 16.2
> (cross), and QEMU 10.0 TCG, with lockdep and the locking selftests:
>=20
> =C2=A0 - Each patch builds with W=3D1 on x86_64 without new warnings.
> =C2=A0=C2=A0=C2=A0 RV_MONITORS_KUNIT_TEST=3Dm builds on x86_64 and arm64.=
 kernel-doc
> =C2=A0=C2=A0=C2=A0 reports no warnings for the changed headers.
> =C2=A0 - The rv_mon KUnit suite and the reactor suites passed without
> =C2=A0=C2=A0=C2=A0 failures on:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x86_64=C2=A0=C2=A0 PREEMPT SMP4 and UP, PR=
EEMPT with nohz_full=3D1-3 and
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 threadirqs, PREEMPT_RT SMP4, PREEMPT_RT SMP8 with
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 nohz_full=3D1-3
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arm64=C2=A0=C2=A0=C2=A0 PREEMPT, PREEMPT w=
ith nohz_full=3D1-3 and threadirqs,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 PREEMPT_RT, PREEMPT_RT SMP8 with nohz_full=3D1-3
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv64=C2=A0 PREEMPT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARMv7=C2=A0=C2=A0=C2=A0 UP
>=20
> =C2=A0=C2=A0=C2=A0 Each configuration ran 13 to 21 of the 29 rv_mon cases=
. The others
> =C2=A0=C2=A0=C2=A0 are skipped because they need a different configuratio=
n.
> =C2=A0 - RV=3Dn kernels boot on x86_64 and arm64.
> =C2=A0 - On top of the early-hardirq series, the same suites passed on
> =C2=A0=C2=A0=C2=A0 x86_64 (PREEMPT, PREEMPT_RT), arm64 (PREEMPT, PREEMPT_=
RT) and
> =C2=A0=C2=A0=C2=A0 riscv64.
>=20
> An LLM assisted with the patches and the testing.
>=20
> v1: https://lore.kernel.org/all/20261022050712.75035-1-kmehltretter@gmail=
.com/
>=20
> [1]
> https://lore.kernel.org/all/FACA54EC-F846-4051-9ADD-DB46E7665FAD@redhat.c=
om/
> [2] https://lore.kernel.org/all/20261028033127.82193-1-kmehltretter@gmail=
.com/
>=20
> Karl Mehltretter (9):
> =C2=A0 tracing/irq: Add generic IRQ context boundary tracepoints
> =C2=A0 tracing/sched: Add IRQ preemption lifecycle tracepoints
> =C2=A0 rv: Add a monitor for generic IRQ context transitions
> =C2=A0 rv: Add a monitor for IRQ-exit scheduling ownership
> =C2=A0 docs/rv: Document the IRQ monitors
> =C2=A0 rv: Add KUnit coverage for IRQ context transitions
> =C2=A0 rv: Add KUnit coverage for IRQ-exit scheduling
> =C2=A0 rv: Test empty PREEMPT_RT softirq worker intervals
> =C2=A0 rv: Test IRQ-exit softirq provenance and handoff
>=20
> =C2=A0Documentation/trace/rv/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0Documentation/trace/rv/monitor_irq.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 475 ++++
> =C2=A0include/linux/interrupt.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 8 +
> =C2=A0include/rv/kunit.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 34 +-
> =C2=A0include/trace/events/irq.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 56 +
> =C2=A0include/trace/events/sched.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 26 +
> =C2=A0kernel/sched/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 6 +
> =C2=A0kernel/softirq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 324 ++-
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 11 +-
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 3 +
> =C2=A0kernel/trace/rv/monitors/irq/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 13 +
> =C2=A0kernel/trace/rv/monitors/irq/irq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 35 +
> =C2=A0kernel/trace/rv/monitors/irq/irq.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 3 +
> =C2=A0kernel/trace/rv/monitors/irqexit/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 14 +
> =C2=A0kernel/trace/rv/monitors/irqexit/irqexit.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 172 ++
> =C2=A0kernel/trace/rv/monitors/irqexit/irqexit.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 85 +
> =C2=A0.../trace/rv/monitors/irqexit/irqexit_kunit.c |=C2=A0 540 ++++
> =C2=A0.../trace/rv/monitors/irqexit/irqexit_kunit.h |=C2=A0=C2=A0 21 +
> =C2=A0.../trace/rv/monitors/irqexit/irqexit_trace.h |=C2=A0=C2=A0 19 +
> =C2=A0kernel/trace/rv/monitors/irqstate/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 14 +
> =C2=A0kernel/trace/rv/monitors/irqstate/irqstate.c=C2=A0 |=C2=A0 289 ++
> =C2=A0kernel/trace/rv/monitors/irqstate/irqstate.h=C2=A0 |=C2=A0 139 +
> =C2=A0.../rv/monitors/irqstate/irqstate_kunit.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
 2339 +++++++++++++++++
> =C2=A0.../rv/monitors/irqstate/irqstate_kunit.h=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 25 +
> =C2=A0.../rv/monitors/irqstate/irqstate_trace.h=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 15 +
> =C2=A0kernel/trace/rv/rv_monitors_test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 30 +
> =C2=A0kernel/trace/rv/rv_trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0=C2=A0 2 +
> =C2=A0tools/verification/models/irq/irqexit.dot=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 21 +
> =C2=A0tools/verification/models/irq/irqstate.dot=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 32 +
> =C2=A029 files changed, 4737 insertions(+), 15 deletions(-)
> =C2=A0create mode 100644 Documentation/trace/rv/monitor_irq.rst
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irq/Kconfig
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irq/irq.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irq/irq.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqexit/Kconfig
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_kunit.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_kunit.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_trace.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqstate/Kconfig
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_kunit=
.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_kunit=
.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_trace=
.h
> =C2=A0create mode 100644 tools/verification/models/irq/irqexit.dot
> =C2=A0create mode 100644 tools/verification/models/irq/irqstate.dot
>=20
>=20
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

