Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792481373;
	b=5gWYjdl3kPR+nGsX4uxOOvJBnbK+vyw3OhTq+PjEPYar10QttAaPMMNI4rChFXmNYzmt
	 U01q6S49djbS6HVvGR1zWjriXFSGQzyXWvVsXdlRJCgLABHEguqLyjkFhz8Ap7CwxFmWC
	 7GcdmrBXcQPaDmhacUVZ649DOe7a3EWZ625VHFcRRUfA82A72dfcLBxRqdKcluytTf6Hg
	 PoRY7wNUjATQ176YAJVnhMzK2iYWw5S1qqVmKFUxTXYTtTbXReXF/RUSVJAwyIoH9n2+Y
	 Dh9aB3WH1ggbGMMw+yRIlfG9CRnk2qr+qyEpavvTXiQ63tKSYORNbidinW97Q3/xkbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481373;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=z1YaeM955c5Bg9XHvbbBfUPCacacDup65awF5+IJ5F8=;
	b=gIbhoPjXnlLpTwM/1Rr72QwnPT+zIjN0n+hHiMmeSqMrAI+rRnVnvNn9QAyAWfs54xSw
	 2U6qsWAgqJ/3UdijaZ2xek2u2QJj3zm/v6onHUGLNh6udXu/VZnXKJOLcMNabmPeJuPw8
	 jrMXRbHWYO3wkiTgkCIleaVyfNrBZ9Xflkfk9xwP5sgRsx7pKgGHxNoqeXWMRQnsOtg5J
	 zkKYEUC2qVTwoTJPIQP2TqMKweGvuBR2bEzc5skBrxLN68NmIrS6LdgQMlTOnD/jlgOBG
	 j1fosD71adB5Nxb8rTEigzem9qd4+JZoNneFb1PX84Nl+ragBZSDF0lNEFav1+kicAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C7scRXjg;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C1606A333
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 07:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C66C1606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C7scRXjg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792481371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z1YaeM955c5Bg9XHvbbBfUPCacacDup65awF5+IJ5F8=;
	b=C7scRXjgiajTybUWayWkedhZIUgFBVbnoqrIeNbURZsNLndQMRaSNE2WAVIk1jxNGWpfle
	Q27EZxRPZ44FN/kVIVP2BiuNqEAhRESqL0mwWC+z/ZbJZMvoQUevxzz/6n8kpEYZUWsqV+
	Nu5bQpJNLyCPP7AVpz5v4Sl+LkMonrM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-vcvVZGlcOCC5emXWRKr1WQ-1; Tue, 20 Oct 2026 03:29:29 -0400
X-MC-Unique: vcvVZGlcOCC5emXWRKr1WQ-1
X-Mimecast-MFC-AGG-ID: vcvVZGlcOCC5emXWRKr1WQ_1792481369
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49cdc4080ddso2647315e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 00:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481368; x=1793086168;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=z1YaeM955c5Bg9XHvbbBfUPCacacDup65awF5+IJ5F8=;
        b=f6eCSHARAWFqmxfovSvud+Ypo3s6aqgoZ7nys4qXYYt+PQSTxEgWGeDpKzpk42QUMj
         gh8Zzvawj9y2Zr0FiQEHeam+Qx8ViiFto0t0hKjGL0TGgsxsCBLKcco6YwrSbuQtCrWk
         ZYxCDHPWTAeK8Xko3sd7YJN2hPA0MqrFyCZJQP9PRowRcBjPyMUy3vCE0MrtTVE3f+6m
         dIA17rWf6s2P4E1LQnuWXSuA04dT83kfg6CKq8/QKUFKVrt1bMVgZpuaDtYUDvQS6aUE
         rA+VzUTdjR6bbfzvqgjEYM5OPXxJnWrRe3O/9msA9Ywt3tf+dTxHafvam401UVdQPLmV
         303Q==
X-Forwarded-Encrypted: i=1; AKwUvBzpkrKqVLG39vR1gBuk8APhPBlmFqPWla07D2ZJ5nN5zDM2IJ1pUPb488zlaDbvDaDqTtxnefNKrio7Nc8RCAAGY1Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6KCb4somAZ2Ozj7PQ5/iWvhmITX++n1krUgBoRUzIH3XmQX8Y
	r/8edbLCJX98oMUZ4cdbiRuBatgV3qqS+RGXzFtw7q+AvniXvRoEkPE+KlJY4zerxzCHdxKOhCc
	aosKpEk+vifHJHcfGb4kMPZNosN1LOhnDCO7s2JWTzP81DwXmFg40pnNVQRnhN8tWTRtGEOp03g
	==
X-Gm-Gg: AYBFou0QxgNsMzwqtUkid9bKZU1w5q+SBDAPHD9jYfCLINV5G8rjadjjBprE+0EVj3j
	H/wuyO8tXBag7fNB1OZ7FtnxUyySLMx/Z4NeOpNknmhGe7FgXeWJZrLGKPtmpDGQGgiYJoK8ayy
	31V5XZQ253vX6gfMrZi7K3SHVagJa1zSReTEr0qWR5UrZP9Xd+tf3J+JJKlQNz6vnsJvm73u739
	eYqwlrh5NVL3U2a0TbxO10a9uQd3zDnOQLfQR1icG+/vZ7GpRReE7DhXYJLMD6vBEPJc18JGTEB
	DnE6HV3ddCmkdbmfx794/LfArw7Dx5N6jk3g40teIaHRz3aIPLV4S/P4eSvrMjRxmUmWwV/joTV
	4vl84Vi/5nBM4SV81DPaYvN8kcA==
X-Received: by 2002:a05:600c:8b8b:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4a1f4fa223cmr28534205e9.16.1792481368491;
        Tue, 20 Oct 2026 00:29:28 -0700 (PDT)
X-Received: by 2002:a05:600c:8b8b:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4a1f4fa223cmr28533915e9.16.1792481368070;
        Tue, 20 Oct 2026 00:29:28 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.134.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d41c8asm51300695e9.8.2026.10.20.00.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:29:27 -0700 (PDT)
Message-ID: <0d4f11b1999588ddba9d855db43fc492eda32de1.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: John Ogness <john.ogness@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Nam Cao
	 <namcao@linutronix.de>, Wen Yang <wen.yang@linux.dev>, Tobias Schaffner
	 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Date: Tue, 20 Oct 2026 09:29:25 +0200
In-Reply-To: <87pkx5q1w4.fsf@jogness.linutronix.de>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	 <20261001152042.124445-11-gmonaco@redhat.com>
	 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
	 <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
	 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
	 <878q3xtptq.fsf@jogness.linutronix.de>
	 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
	 <87bj8s8ih9.fsf@jogness.linutronix.de>
	 <DM78SVMBI2XW.2XHVC67VON48A@gmail.com>
	 <87v770uuyr.fsf@jogness.linutronix.de>
	 <DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com>
	 <87ik2zryzo.fsf@jogness.linutronix.de>
	 <0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
	 <CAP4=nvR2i092924zszA8Qh0UUYnwXfAsa+7KjPe-NpwC+bbLXw@mail.gmail.com>
	 <8580176d216258e9008c344e0529509117dcc18b.camel@redhat.com>
	 <CAP4=nvTc297yQHz8aumZFAQ3+JK=5Z_=416WdosT0S6nHEeNfQ@mail.gmail.com>
	 <87pkx5q1w4.fsf@jogness.linutronix.de>
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
X-Mimecast-MFC-PROC-ID: WvhBEib6v5bNGLUzXAuw4pFNF_ifFeSgT8uLiz201Pc_1792481369
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-10-19 at 15:08 +0206, John Ogness wrote:
> On 2026-10-19, Tomas Glozar <tglozar@redhat.com> wrote:
> > Do I understand it correctly that the idea is to modify existing
> > tracefs instances when enabling an RV monitor to filter our RV-related
> > bpf_trace_printk events?
>=20
> Not necessarily. But does the ordering matter? If I run:
>=20
> $ sudo trace-cmd record -e bpf_trace:bpf_trace_printk \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -f 'bpf_=
string ~ "rv: violation: *"'
>=20
> it does not matter if the instance is running before or after starting
> the monitor.

I'm not sure if that was a question, but I don't think it would matter eith=
er
way. If RV generates it's own events, these exist even before the monitor r=
uns
(just like bpf_printk) so it doesn't really matter when ftrace attaches to =
them.

>=20
> > > > I can imagine an RV-specific trace event for that, however, it woul=
d
> > > > require a separate kfunc to generate it, and ideally also distinct
> > > > labeling of a BPF program eligible to call that kfunc. The "rv"
> > > > userspace tool could then iterate over these labels so the user kno=
ws
> > > > which violation events can be expected to occur on the system.
> > >=20
> > > That'd work too. It's what I initially envisioned but I'm not sure a =
kfunc
> > > producing a tracepoint is something BPF folks would really like (and
> > > technically
> > > any other unrelated BPF program could call that, unless there's some
> > > access
> > > control mechanism I'm not aware of).
> > >=20
> > > Not sure how much it matters in practice against the glob filter, it
> > > probably
> > > really depends on the other bpf_printk users (and a mildly better
> > > usability).
> >=20
> > bpf_trace_printk is already a BPF helper producing a tracepoint, this
> > would be equivalent.

By the way, there are other occurrences in the kernel, apparently used only=
 for
testing in include/trace/events/bpf_test_run.h

> > Of course, that does not mean we want it, but it
> > is something we already have in at least one instance. I know of at
> > least one quirk: you can have a BPF program attached to a tracepoint
> > that will call bpf_trace_printk(), and a tracefs instance tracing both
> > bpf_trace_printk() and the original tracepoint. That leads to a new
> > tracepoint triggering while another tracepoint is already in progress.
> > I don't know how it is currently handled; from what I recall when
> > testing RTLA's BPF actions, the bpf_trace_printk() event might get
> > dropped by the tracefs instance, so I had to use a different way to
> > signal to userspace in BPF actions test.
>=20
> This is interesting because it is very likely that the RV monitor is
> attaching to and generating the violation from the same tracepoints that
> I may be additionally tracing. For example, the sleep RV monitor
> attaches to sched_waking, which I would also use while investigating my
> broken real-time system.

Yes, that's actually what standard RV has always been doing, I've never not=
iced
dropped tracepoints.
I thought bpf_printk used some shared buffers or some other things on top o=
f
that but it doesn't seem to have anything but a tracepoint string.

>=20
> However, I just ran a test with a simple eBPF program that attaches to a
> tracepoint and calls bpf_trace_printk(). I started trace-cmd to trace
> both the attach tracepoint and also bpf_trace_printk using a glob. After
> starting trace-cmd, I loaded/attached the eBPF program. The running
> trace-cmd was able to capture both events (with about 15us difference in
> timestamp).
>=20
> > As I said, to prevent unrelated BPF programs from calling the new
> > tracepoint, you'd need to recognize and track RV BPF programs as a
> > special type of program, similarly to what your original RFC did. I'm
> > not sure if that's what we want, but I see some advantages. In
> > addition to better filtering of reactor events, you could separate
> > reactors from the monitors entirely: you could trigger the tracepoint
> > unconditionally, and attach reactors as tracepoint triggers to the new
> > tracepoint.
>=20
> Thank you for making this suggestion. This is the direction I would
> prefer we take.
>=20
> > All of that adds complexity, though, and requires separate discussion,
> > so it's probably not something relevant for the initial
> > implementation. I just wanted to mention it so that it doesn't get
> > lost.
>=20
> Since relocating RV to userspace requires an enormous amount of effort
> and coordination (mainlining, packaging, distributions, documentation),
> I do not think it makes sense to have an "initial implementation" that
> is already not what we want in the long term.

Fair enough, I feel to be cautious at redefining what reactors are right no=
w,
though. Currently they are nothing but a function call to the set-up action=
.
It's trivial to verify where the code goes without adding the tracing subsy=
stem
as a dependency in the path (typically important in some safety critical ca=
ses).
Sure, handlers are called by the same tracing subsystem nonetheless, so it =
may
not add much value.

Let's leave reactors aside for a moment. What I am coming to terms with,
instead, is that the current ringbuffer to userspace design isn't what we w=
ant.
In kernel monitors communicate their status through tracepoints, perfectly
integrating to tracing tools, BPF monitors use a custom buffer.

Generating a tracepoint here is probably the way to go. bpf_printk does gen=
erate
one, but as Tomas pointed out, hijacking that for everything (think of moni=
tor
events) might be a bit much.
Nonetheless, we want RV BPF handlers to generate tracepoints, then attachin=
g
actions on error tracepoints (whether we call that reactors or not) can be =
done
later.

Summarising, we have 2 potential designs.

1. bpf_printk only:
  bpf_printk("event: monitor: curr_state x event -> next_state")
  bpf_printk("error: monitor: event not expected in curr_state")

2. new kfunc(s) calling a tracepoint:=20
  trace_event_da_bpf("monitor", "curr_state", "event", "next_state")
  trace_error_da_bpf("monitor", "curr_state", "event")

1. is simpler and works mostly out of the box, depending on how powerful gl=
ob
filters are, it can reach the same functionality as 2. Might risk to overlo=
ad
the shared bpf_printk event and perhaps have a higher filtering overhead.
2. is closest to the current in-kernel implementation and offers flexibilit=
y to
easily filter the type of event (useful for DA, e.g. I want a backtrace onl=
y
when going from state A to B). But it requires a series of kfuncs (e.g. err=
or
and event for each monitor class).

In both cases a malicious actor could call the kfunc and make us believe th=
ere
was a reaction (they cannot mess with the model though). If we own the kfun=
cs we
can at least limit the availability (tracing-only and CAP_SYS_BOOT).
This, unless we register BPF monitors in the kernel like in V1.

I'm going to test each design once I get again to work on this.

Thoughts?

Gabriele

