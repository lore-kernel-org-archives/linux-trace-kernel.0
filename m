Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510266;
	b=OmJar44TQAriVIZeLn5bSZ6njOHmeo6uE65bEQ4xUxfK+j8bhqML2An5jn4uGR8cgevc
	 5G8NfLzHJsmq2tgaf/B/nII2e26Cb8i3j624uwRpkDjCZXXkcpi5vSJDabPILp3R1405J
	 IzYk8BOgxf54SUQI6tW66qdxKvmiciMKkLhbHf3MgEJUnKA2KAtHtMdS0FwhSWRALImFY
	 ZRkZTuPT/zLKbjXi3+0C0vQP7M+E/IfSdPbvlEi3KylpaYXzyGIn/1DsvaBJq3eY5aHdo
	 GNssZAZu7ZxD3Qe0vlamJcDCsMZBj0sFYNf7xmDO6nF7CCfoalAcReyeqfgZr835I8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510266;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=F/xZ2QSRGTW4CINPeKVQ6TPwAJsUcgs4ci8OmxiBPkU=;
	b=oYDm3Qf/EtAwqBdA4uPHqOhSFmfXtOR5+e8mvLvD7g4+e31jS3HR47WUv8G+kSEVp5xF
	 +RWpG2MDAHy5FHjiBkLjmfcb5YYZXyCM+3UwZu7s8eFqgfWpIF1s9Rlj1MUFW0TcBp4Ao
	 SX0Y4HlFOfaeJqgLoGVA4NQccRaOAeDkFAWJN9XRZPDja+VLA424aps3mw/YtQVtKt0iF
	 k5xwECqmfblo6/QVkIzR51RP5r3XAFExnZwAGgtVseik0DgC3Xmw6Z8pLsAKDAAYT929N
	 kq+kr6GQbF0AbocdlkZJT5uXsdOPEGzzakBzYQcngUqHdNHH46ntfRL2HJ8Xu62VoeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GOr17mkG;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B66460A2612
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 15:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B66460A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GOr17mkG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792510264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F/xZ2QSRGTW4CINPeKVQ6TPwAJsUcgs4ci8OmxiBPkU=;
	b=GOr17mkG+hwEZRrIDfN4gfFMcL0e1IUhhIddbyGHcnGcMBYGq86DRpdMzp60gUl8NfYklQ
	wgWfqLdf4NNFDwH+1V0Qn2hnXhqjiVkOV73aCRxvv1tFoAy9lXulZX7sLNSM90YCmYBonS
	/7X+S+qDm+l0+/ZcX6Z7Ku3iZ6X9P64=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-VsceajMFOFW9-6NfSBEeHA-1; Tue, 20 Oct 2026 15:30:58 +0000
X-MC-Unique: VsceajMFOFW9-6NfSBEeHA-1
X-Mimecast-MFC-AGG-ID: VsceajMFOFW9-6NfSBEeHA_1792510257
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1d6db1d9eso26701625e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 08:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792510257; x=1793115057;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F/xZ2QSRGTW4CINPeKVQ6TPwAJsUcgs4ci8OmxiBPkU=;
        b=Z0FzcNYEv0dDd1PF3Sx0sIYjh6rzrPI6HNozOWQydgqx+hQagCybo573eA9VC986YH
         xmy4ioSyzD+RQltcat7p1Qhn6i/2ZVeLSxTWZDCPGD7qcZS6Sh8sbbgH9razL0LFuQuX
         k6fvFcQwvJn95l0TW1wWT5rfwy3gBVKH4bgmqcyXkvkqBBTUA243bX9Z2Vmsd5iMFolI
         C1GCUN1B1yyx/Ohv+yCBGVyUdVUG/wVbVJ6qKiA5Cm884goL6Ns8GiOyDRh94tnk/x4k
         r2LFnwKNEGX82LeI4AFPVp9UaIITnfjpWlmifYdB3J+J+QnAa7urAGWHPjvHIoARV261
         F9+Q==
X-Forwarded-Encrypted: i=1; AKwUvBz8ecBkKHDqmIs2x0Axi75XpjmmaFxW9XoZFacegODv6BxmCrZIyl4E21oOsIX5ngTryuTJo9ijHMxhSrX2I/wJ/D8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVQ0e3uqNF3gsjN9MZRQ5cWSG4hBBQ4vizCbE2Nk/L5J4VpJX3
	13M4Uivin6UUsSGpMVSfAl2YwDGNwo9ycMKKaiDUaDMG8KLA+9erbY97+NF+KQI5AYcEpmR8Zdd
	YTznYM16XP7Wb2EsszZuY2AnOs2hMdRuC5UCIFOfyVtmR8kQCuOn+ZX9CQVhuXO42tuWzaVhB8w
	==
X-Gm-Gg: AYBFou3CbwaNjSEL+ABg/D3oCNJt64FT4Nt3y56yWxF/HW5GD8wOC1RYrEXPDaX7A5e
	zbf/E9pm4DNzNKvsL1cX/OqzuQtgdIYVGYu0H5BawQCLWoXEuqKmvuz2nkZgMTbeP14GY7AsHaI
	jpKEZbTpI9lOFCrtkTXgQidO2o0Xt7FOL/UcJGHyFHjQ84AS7lUw56F2P6w39kFfpRIdsN+sH3q
	uUK6qTcckMbpdn4yLh7UsTkjWkyyDKfEEidWmiRTXs9fgh71rYiFOoy6EX1wKwnwrkqbLeGvWxu
	QDkfh/m/RAGpaSzRmgMHael56dz9PBuADPSwY9iAwR4S+vLF9W6QufdlWqXBA0ax8XOtJa7t0fl
	29pGgs97O4LmKl4dy/IboKXjI5w==
X-Received: by 2002:a05:600c:4f47:b0:4a1:e0db:8cf8 with SMTP id 5b1f17b1804b1-4a1e0db8f0amr236160355e9.3.1792510257057;
        Tue, 20 Oct 2026 08:30:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4f47:b0:4a1:e0db:8cf8 with SMTP id 5b1f17b1804b1-4a1e0db8f0amr236158215e9.3.1792510255803;
        Tue, 20 Oct 2026 08:30:55 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.134.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d85a9bsm90078985e9.15.2026.10.20.08.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:30:54 -0700 (PDT)
Message-ID: <8e13471b64e11218cab612e7662e8068c34e1219.camel@redhat.com>
Subject: Re: [PATCH v7 00/14] rv: Add task latency over budget RV monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 17:30:50 +0200
In-Reply-To: <6a8b5d26-37cc-4a8f-ab1d-0df2c2e6c2d3@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
		 <3eb0948c9ca67f64b3b311f823cd0f7628033c68.camel@redhat.com>
		 <6a8b5d26-37cc-4a8f-ab1d-0df2c2e6c2d3@linux.dev>
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
X-Mimecast-MFC-PROC-ID: x9wz4WxQ2xsa3YgCQxcgysJc4bokOuenAnA4pOa0g_c_1792510257
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-10-20 at 03:18 +0800, Wen Yang wrote:
>=20

> > there's been a conversation at the LPC conference about completely migr=
ating
> > RV
> > to BPF.
> > While we aren't sure of its feasibility yet, and it will take time, it'=
s
> > something to keep in mind for new contributions.
> >=20
>=20
> Understood, and I have been following that direction.=C2=A0 I spent the l=
ast
> few days reading the v2 "rv: Add support for BPF monitors" series in
> detail, so the comparison below is against that code rather than the
> general idea.

Great, I'm going to review your series when I get some time.

> > First of all, would dropping RV in-kernel support negatively affect you=
r
> > current
> > workflow?
> >=20
> Yes, it would.=C2=A0 Some concrete points, all from the current tree.
> (a) Event ABI.=C2=A0 event_da_monitor / error_env_* in
> =C2=A0=C2=A0=C2=A0=C2=A0 kernel/trace/rv/rv_trace.h are plain tracepoints=
, so trace-cmd,
> =C2=A0=C2=A0=C2=A0=C2=A0 perf and anything else reading tracefs consume t=
hem today with no
> =C2=A0=C2=A0=C2=A0=C2=A0 extra userspace.=C2=A0 The BPF series delivers e=
vents through a ring
> =C2=A0=C2=A0=C2=A0=C2=A0 buffer read by the rv tool, so the two backends =
are not
> =C2=A0=C2=A0=C2=A0=C2=A0 interchangeable for existing consumers.

Good point, you might have noticed a similar discussion is happening also o=
n the
RV-BPF thread. We cannot have the absolute same ABI in BPF, but we probably=
 need
tracepoints or anything that can easily interact with other tracing tools.

> (b) Build and deployment.=C2=A0 On the images we target, BPF is often not
> =C2=A0=C2=A0=C2=A0=C2=A0 compiled in or not permitted:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CONFIG_BPF_SYSCALL=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default n
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CONFIG_BPF_EVENTS=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 needs BPF_SYSCALL
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CONFIG_DEBUG_INFO_BTF=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 needed for CO-RE; depends on
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !DEBU=
G_INFO_REDUCED and pahole
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LOCKDOWN_BPF_READ_KERNEL=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 disables the probe_read helpers
> =C2=A0=C2=A0=C2=A0=C2=A0 Those are product constraints, not local build i=
ssues.=C2=A0 tracefs/RV
> =C2=A0=C2=A0=C2=A0=C2=A0 works in all of these configurations.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 There is also a size cost: BPF implies CONFIG_DE=
BUG_INFO_BTF, and
> =C2=A0=C2=A0=C2=A0=C2=A0 .BTF is resident in RO_DATA and kept in the boot=
 image - about
> =C2=A0=C2=A0=C2=A0=C2=A0 5 MB uncompressed on a full kernel, 1.2-1.6 MB c=
ompressed, plus
> =C2=A0=C2=A0=C2=A0=C2=A0 roughly 25% per module with DEBUG_INFO_BTF_MODUL=
ES.=C2=A0 On a
> =C2=A0=C2=A0=C2=A0=C2=A0 16-32 MB kernel partition that matters.
>=20

I've vaguely heard automotive folks saying they don't want to build BPF sup=
port
several times. Finally I get a proper technical reason!

Now I think this isn't easy to sort out, if that's a hard requirement, we a=
re
probably going to need to keep in-kernel monitors around.

> (c) Timing semantics.=C2=A0 tlob arms a per-task hrtimer with
> =C2=A0=C2=A0=C2=A0=C2=A0 HRTIMER_MODE_REL_HARD.=C2=A0 bpf_timer is fixed =
to
> =C2=A0=C2=A0=C2=A0=C2=A0 HRTIMER_MODE_REL_SOFT and the verifier states "b=
pf_timer callbacks
> =C2=A0=C2=A0=C2=A0=C2=A0 are never sleepable" .=C2=A0 On PREEMPT_RT the c=
allback runs in a=20
> threaded
> =C2=A0=C2=A0=C2=A0=C2=A0 softirq, so the expiry time carries scheduler la=
tency.

I haven't looked into this yet, but from what you say, the bpf_timers code
doesn't really support PREEMPT_RT.

> =C2=A0=C2=A0=C2=A0=C2=A0 For a budget monitor the expiry time is the outp=
ut, so this is a
> =C2=A0=C2=A0=C2=A0=C2=A0 semantic change, not just overhead.

Well, the expiry time you get from an hrtimer is what you configured + some
system jitter. The jitter here is just going to be less predictable but is =
it
really the output you need in your monitor?
Or am I missing your point?

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 What a BPF tlob would look like once those exist=
:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - model: still tlob.dot, with rvgen =
-b extended to the hybrid
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 backend;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - state: one record per task in BPF_=
MAP_TYPE_TASK_STORAGE (or
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the per-object hash map =
the series has today), holding the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state, the binding id an=
d the budget;

Yeah I wasn't aware of BPF_MAP_TYPE_TASK_STORAGE before, I have a draft V3
(coming some time after the merge window) using that.
But I'd assume this type of storage would simplify the design of your monit=
or,
which is currently using a PER_OBJ just to add more things to a PER_TASK.
I'm going to keep in mind your use-case where you essentially extend the st=
orage
(which is perfectly fine in BPF since we don't use the task_struct slot).

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - window: two uprobe programs attach=
ed to PATH:START and
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PATH:STOP, with the bind=
ing id and budget passed through the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attach cookie or a small=
 config map populated before load;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - expiry: a bpf_timer in the same re=
cord, armed on state
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 transitions and cancelle=
d on STOP, submitting an error entry
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to the monitor's ringbuf=
;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - output: the rv tool reads the ring=
buf and prints it, and the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reactor is linked in wit=
h bpf_linker as v2 already does.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 The DA engine and the ringbuf/reactor plumbing w=
ould carry over
> =C2=A0=C2=A0=C2=A0=C2=A0 unchanged.=C2=A0 The three missing pieces are th=
e uprobe
> =C2=A0=C2=A0=C2=A0=C2=A0 attach/configuration path, the timer and env han=
dling in
> =C2=A0=C2=A0=C2=A0=C2=A0 da_monitor_bpf.h, and the hybrid backend in rvge=
n.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 None of this argues against migrating.=C2=A0 It =
argues that the BPF
> =C2=A0=C2=A0=C2=A0=C2=A0 backend has to reach parity on (a)-(c) before th=
e in-kernel path
> =C2=A0=C2=A0=C2=A0=C2=A0 can be removed.
>=20


Thanks for taking time to assess this, it looks like the right direction.

Gabriele

