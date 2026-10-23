Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771540;
	b=KY9aNSCdGLvAuBzv1A9soFHZR6xVLnytXzzLplbBjBIzrdCABrYfnC7/VuVOqEgFGOS9
	 c8WlpAlOZW+yfbpwSlNDYO9J4Y/dhDmLxgQWhMDDNF2PggCQkz9r91M2WgxfkfeNIxcD+
	 BmAI8pTkTyrUkQn/abZEcpFuUOWCQpBMiB7MGfGCzXDtyAb7LCIguVXjnmfJDiZDQUei+
	 fq2R+Db4AFJbyUZcm486tUmAFhqiVXnmp1r1whztdbI76F5cZktopYoEaGZ4IE3gg/bN7
	 liPpUcqddPaYSF3sFWlM/WXkvEByFr7OtkWPc+CVb58bmOgJ9SMGaon4w1elSWJfNJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771540;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=K14cnwecKDZXuHS20WMKxtkA3ZjcXzFbG9A0UfcDyZs=;
	b=K6E63maLTWbikvCNSDXlREeIdOwDrUY5q25jN05SdRAPHDndy9gcZiAAr1p+AQHVzB6s
	 PTZYE07L1+KYMsUVi/qN6bine9oVFga+ypOpPxQITh2WoRzqBoLKuJEmGNwfO3PXQPfrF
	 glO6MJb/THneSPOgYkC00KSi1ZBf3dmF9DwvxLE7kF6HWNip+0w3LdG3zgJJtphq3soFP
	 ybZzDy/LcqJcc5kml8+kaBRUcr137+5eD5U2U/0rMfr9V5YQLqGVPbQTCce065uvtOPCN
	 Jd7RxEAiNeWHTz/8nbeYbhWKpB5Kx1zfAViL5QCir1C6mjhJdLhP78FQrJYXn1JoQLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RURnCJNZ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFE0606A31E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 16:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BFE0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RURnCJNZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792771538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K14cnwecKDZXuHS20WMKxtkA3ZjcXzFbG9A0UfcDyZs=;
	b=RURnCJNZFRJjWEAtmAn/mHfKMFq8/VYaQ2PRiwiu3WGHCht7OzCjvATkd471bbGZMR5zn0
	ErGWifBSQtWpuIgzZTTFOclJvPvRqhKrgg56l+cAEHH1wfscrl0WAl2MCuo1i13/kt24Z3
	FbNJkiCwuWL3sFlBfHG3HRV+aUME8yE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-hCUlMHu2NfK6Ym3rH0uA_g-1; Fri, 23 Oct 2026 12:05:35 -0400
X-MC-Unique: hCUlMHu2NfK6Ym3rH0uA_g-1
X-Mimecast-MFC-AGG-ID: hCUlMHu2NfK6Ym3rH0uA_g_1792771534
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a2063be141so9043415e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 09:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792771534; x=1793376334;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K14cnwecKDZXuHS20WMKxtkA3ZjcXzFbG9A0UfcDyZs=;
        b=je3iN/vhfsrN7EMUMfR9u4gGrX8aOjH6772Yy4OY2UI0y08K8VGglAC1M5heDR8obD
         IuVPDH7zgys6oL5KOKC4eLr3IkcbaIvylPTJqbGcJ43WWAHyBXXeXLJiUDppsISBCt/L
         vBhjbiNZTKCi2KiId51NCxSzgpFmYlac1W4bj7EE1bKH8lx+4fls4ocK7U16Lhr+w3H6
         jR/sZQKOZ8KAR7hN7gorGCB3zZE4yrg8Buggh4HGA/flBa5InLhFRP5cvl0Dvg93plno
         8/3izt87vcFCtq4iNKkW81X+u+/m36xuqAYXp2/EVHe33ctOZSWAffuCin/DHtw6nz0p
         lZDA==
X-Forwarded-Encrypted: i=1; AKwUvBzIiF3DmxXZvKk6qehIcMU//QB6nxdjSvYiEsIabutYfUMgLTpIxHC3qG4oZYu5pWknmuERGcAL//kKIfMG01deXLM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVfbFVlhMvWq892PkaJR2y1kR3YtK7ui8Vl53PiRXFrDylnEkk
	l8XMpbyNOFeSPQJVFrxW8jNSCEXY2Vv1NZhf48MxouiLcGWIyBiVNALI3RrZvk+c35T17q2ASce
	MrWOMNiiruuY4sLEAdzb3hTC2Byn67jp/VvfWWPcv74M3ThU+b7HKdpq51lfQMehQUFnk3Vpc9Q
	==
X-Gm-Gg: AYBFou0LuVcOMpL09qzIAUj41VFOSM8s3VkOdPtWjmgRxBIyu/5iXiQ6RHrWUYeo3ux
	HSUykAi/StSW6EDqqZltKuFVUHviljqsCJjfZI3fhDEj8Kg5Va72flZ9GJiXnIJAXPuqLt5fhCI
	BddwSDtSeTMwx3bJMH78aBqgamdW23JP0jcXufj4NJO943rAgE17yFOijm98ZTybehuum93hgNk
	+grgo6Q/iLozy0IH6VP6tLZuhjCe2c7bNnWrRPhKZNUy3AlE8TnmjqP/mfcVqpPwwapsOJ5YmIa
	444IaidNICEpPDgkHmyu9dxU/G4PqnZCwnJIKopxbQDR7jfWqj/U9kILLTA0RNNSvp+asPhuyAf
	RySYcnr5S+AYgCLm0gHwBze6Wljyb
X-Received: by 2002:a05:600c:3514:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4a211ed7602mr43987625e9.26.1792771533986;
        Fri, 23 Oct 2026 09:05:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3514:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4a211ed7602mr43987145e9.26.1792771533585;
        Fri, 23 Oct 2026 09:05:33 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a312ea914esm4004515e9.2.2026.10.23.09.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:05:32 -0700 (PDT)
Message-ID: <5b3ff014bf2f571b935f9519f422966a1c665c32.camel@redhat.com>
Subject: Re: [RFC PATCH 0/9] rv: Verify generic IRQ context transitions
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
 Dunlap <rdunlap@infradead.org>, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, 	linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 23 Oct 2026 18:05:30 +0200
In-Reply-To: <20261022050712.75035-1-kmehltretter@gmail.com>
References: <20261022050712.75035-1-kmehltretter@gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
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
X-Mimecast-MFC-PROC-ID: ImDm92FxctG_CB4xLBBfxZP7S_y-NBGYWZtdpUreQQ4_1792771534
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-10-22 at 07:07 +0200, Karl Mehltretter wrote:
> IRQ action tracepoints describe handlers, but not the lifetime of the
> enclosing IRQ context. One context may run several actions, and an action
> may be dispatched outside hardirq context. PREEMPT_RT may also enter
> serving-softirq state without invoking an action. This leaves no generic
> event stream from which an RV monitor can check IRQ-context transitions.
>=20
> This RFC adds events at the generic hardirq and serving-softirq
> boundaries. The irqstate RV monitor checks their order and agreement with
> live kernel state. irqexit follows the owner of a preempt_schedule_irq()
> invocation across task switches and CPU migration.
>=20
> The hardirq events cover paths through irq_enter() or irq_enter_rcu() and
> their matching exits. They do not cover direct __irq_enter() and
> __irq_exit() users, raw paths, or architecture-specific entry and return
> intervals. irqexit covers preempt_schedule_irq(), not the complete
> interrupt-return path.
>=20
> Boundary callbacks can raise softirq work after the pending-work check.
> The series wakes ksoftirqd or ktimerd for remaining work. KUnit covers
> nesting, monitor synchronization, PREEMPT_RT worker intervals, provenance
> and late-work handoff.

Hi Karl,

thanks for your contribution!
I'm probably not going to have much time to look at this soon as I have a f=
ew
holidays planned and other series to review first. But it looks interesting=
.

What points my eyes is that you didn't include any schematic graph in the
documentation.
Some folks don't like RST, but I find having a textual representation of th=
e
model there easy to understand what you're trying to do without having to b=
uild
the models.
We use graph-easy for that (and adapt things if the model is too complex).

Do not send a V2 just for this, but please keep that in mind for next time.

Thanks,
Gabriele

>=20
> Cross-architecture RV KUnit testing also exposed an Arm-specific opid bug=
:
>=20
> =C2=A0 https://lore.kernel.org/r/20261020035158.90190-1-kmehltretter@gmai=
l.com
>=20
> I would especially appreciate feedback on:
>=20
> =C2=A0 1. Should the context boundaries be trace events or private RV
> =C2=A0=C2=A0=C2=A0=C2=A0 instrumentation?
> =C2=A0 2. Are dedicated scheduler events the right way to follow
> =C2=A0=C2=A0=C2=A0=C2=A0 preempt_schedule_irq() across task switches and =
migration?
> =C2=A0 3. Should irqstate and irqexit remain separate monitors?
> =C2=A0 4. Is the KUnit-only hook for an empty ksoftirqd invocation accept=
able?
> =C2=A0=C2=A0=C2=A0=C2=A0 Outside a KUnit run, its worker checks take a di=
sabled static-key
> =C2=A0=C2=A0=C2=A0=C2=A0 path.
>=20
> Patches 1-5 add the events, monitors, and documentation. Patches 6-9 add
> KUnit coverage.
>=20
> This series is based on v7.3 (c03c1a14507d) and depends on the following
> accepted change, which is not included:
>=20
> =C2=A0 softirq: Preserve interrupt context on return from interrupt
> =C2=A0 https://lore.kernel.org/r/20261011060742.30584-1-kmehltretter@gmai=
l.com
>=20
> A pre-existing issue can make rv_test_dummy intermittently report a
> false-positive invalid-wait-context warning under lockdep. Wen Yang has
> posted a fix:
>=20
> =C2=A0
> https://lore.kernel.org/lkml/5586dd00789a0f904cc299cd8889744b8c6f8dc9.178=
9412799.git.wen.yang@linux.dev/
>=20
> This series does not include that fix.
>=20
> Karl Mehltretter (9):
> =C2=A0 tracing/irq: Add generic IRQ context boundary events
> =C2=A0 tracing/sched: Add IRQ preemption lifecycle events
> =C2=A0 rv: Add a monitor for generic IRQ context transitions
> =C2=A0 rv: Add a monitor for IRQ-exit scheduling ownership
> =C2=A0 docs/rv: Document the IRQ-entry monitors
> =C2=A0 rv: Add KUnit coverage for IRQ context transitions
> =C2=A0 rv: Add KUnit coverage for IRQ-exit scheduling
> =C2=A0 rv: Test empty PREEMPT_RT softirq worker intervals
> =C2=A0 rv: Test IRQ-exit softirq provenance and handoff
>=20
> =C2=A0Documentation/trace/rv/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0Documentation/trace/rv/monitor_irqentry.rst=C2=A0=C2=A0 |=C2=A0 398=
 ++++
> =C2=A0include/linux/interrupt.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 7 +
> =C2=A0include/rv/kunit.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 34 +-
> =C2=A0include/trace/events/irq.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 70 +
> =C2=A0include/trace/events/sched.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 51 +
> =C2=A0kernel/sched/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 6 +
> =C2=A0kernel/softirq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 308 ++-
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 5 +
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 3 +
> =C2=A0kernel/trace/rv/monitors/irqentry/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 13 +
> =C2=A0kernel/trace/rv/monitors/irqentry/irqentry.c=C2=A0 |=C2=A0=C2=A0 35=
 +
> =C2=A0kernel/trace/rv/monitors/irqentry/irqentry.h=C2=A0 |=C2=A0=C2=A0=C2=
=A0 3 +
> =C2=A0kernel/trace/rv/monitors/irqexit/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 14 +
> =C2=A0kernel/trace/rv/monitors/irqexit/irqexit.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 172 ++
> =C2=A0kernel/trace/rv/monitors/irqexit/irqexit.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 85 +
> =C2=A0.../trace/rv/monitors/irqexit/irqexit_kunit.c |=C2=A0 537 +++++
> =C2=A0.../trace/rv/monitors/irqexit/irqexit_kunit.h |=C2=A0=C2=A0 21 +
> =C2=A0.../trace/rv/monitors/irqexit/irqexit_trace.h |=C2=A0=C2=A0 19 +
> =C2=A0kernel/trace/rv/monitors/irqstate/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 14 +
> =C2=A0kernel/trace/rv/monitors/irqstate/irqstate.c=C2=A0 |=C2=A0 289 +++
> =C2=A0kernel/trace/rv/monitors/irqstate/irqstate.h=C2=A0 |=C2=A0 139 ++
> =C2=A0.../rv/monitors/irqstate/irqstate_kunit.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
 2062 +++++++++++++++++
> =C2=A0.../rv/monitors/irqstate/irqstate_kunit.h=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 25 +
> =C2=A0.../rv/monitors/irqstate/irqstate_trace.h=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 15 +
> =C2=A0kernel/trace/rv/rv_monitors_test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 29 +
> =C2=A0kernel/trace/rv/rv_trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0=C2=A0 2 +
> =C2=A0.../verification/models/irqentry/irqexit.dot=C2=A0 |=C2=A0=C2=A0 21=
 +
> =C2=A0.../verification/models/irqentry/irqstate.dot |=C2=A0=C2=A0 32 +
> =C2=A029 files changed, 4397 insertions(+), 13 deletions(-)
> =C2=A0create mode 100644 Documentation/trace/rv/monitor_irqentry.rst
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqentry/Kconfig
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqentry/irqentry.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/irqentry/irqentry.h
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
> =C2=A0create mode 100644 tools/verification/models/irqentry/irqexit.dot
> =C2=A0create mode 100644 tools/verification/models/irqentry/irqstate.dot
>=20
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> prerequisite-patch-id: 6ac7167f0aa7c5319dac78bf5b06a989fd7dfac5

