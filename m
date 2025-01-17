Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7CF1FDE3A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jan 2025 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737115466; cv=none; b=Sl1xOzgCZYyRPKE6jv3P6yb/cLfuUuFymiZC2nAdK5vK/ujtGq2FS9iSmyCBk9jKL+ZNZnYEtsKesd0s3oUyvRmlx59t4SwOy4SkYSQKLM2LaH4/QRKXh0GnyIzX9BdBimUFYccQWRiSFQCpoXbRvqsH80p3TmLyAQxBlRS1H7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737115466; c=relaxed/simple;
	bh=um1cIuwcKYR4dDHSZ1eGNc8aj5Nh4QC/WAaJGqoEfj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SriVJv0Zafxe83ItP6p+C3A8BIJv+niI8Icp9Hp7nyKZXnI19u8NvNYWz4Z2LO5PCKz0/RJEPGGVLPpZAlIzNeb/LHrXOcwm77CwmjkVMe8CjPRlJCdPSJEDKDUKc3riHmpGsiw3TWk6wp4pNR8KqbFKaEvQ7tpapYxhK22p3X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cIWiHiL8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cIWiHiL8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737115463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qV1bfckSPRiKVA6q4XPglXM9sdFvWj/dMX/MI4GU2y0=;
	b=cIWiHiL8bGcVPlk1M1XqqBwYRcH3QHQkbGR82ZuoztGMp2noI97KbdXqlfd8K5EYViQJgZ
	T0PtMLa/HU9DqZwJhICOdvVYCAkVMSe6wyBI1d7I4Q8/EmQgFbrH9vOk8azYVkMicYd0DX
	4p5Zaj89slkhji01+O2SFEuXXVY4qao=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-_w8AtERQN-6NNx_V_hBSZg-1; Fri, 17 Jan 2025 07:04:20 -0500
X-MC-Unique: _w8AtERQN-6NNx_V_hBSZg-1
X-Mimecast-MFC-AGG-ID: _w8AtERQN-6NNx_V_hBSZg
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa66f6ce6bfso179619966b.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jan 2025 04:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737115459; x=1737720259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qV1bfckSPRiKVA6q4XPglXM9sdFvWj/dMX/MI4GU2y0=;
        b=skYV5WgFZypFmH0bZv7kvlfwB07Sm+oIUG07dDSI9C6N+Oh05FNcSSnqzKUC0monMT
         6t6fGSYWAHyFxG+3ojxb6JhyITqjXwKaChZ1FlEMiXkighPpXcPjAvwr2t0OsCLZgc1t
         TJ8bA1UrXkPCy04kQVWV6OLtQP9ZDUNi3+AB3HrZiZ6LlqnXY91T6NVilFgtTaSW9EA+
         03jI/2tD66SjGCrDFv+6fqeYdoZe64VUkJYV7NK0gAkVgqnhkO3ue9H4BiCxbSEUPqaI
         fj0MRXdnaD00yjzMdNTxJ25+Rl+qiiltswDWnxh/HWIxmsnbgLKheELDqxDwMuj2QtYb
         TTHQ==
X-Gm-Message-State: AOJu0YwSpTknNLE9K5KB6NOFpmtb8YocEqhpoJgzVlBRYZ8s0QlPEZ4r
	Fu6kvAZH/6gczZ8C8nE9oy3c6DihxieAU7rX/B0Kt8u7+BYpXNX676Ir3j6sgtz/bSGyADv+7JU
	AlWIk0WxuidKWnl6hKieBcz2x44BfHFWN7abSQs/Xq/MIKKRF7W1XyIDsUlAD3txeCzo0uAbYa0
	7+c1KqKBCkGNuOzOqVoLWjq7R4zFGLvUyCTscr/AUBt5MS
X-Gm-Gg: ASbGnctbFlQNhduBwtjr/m5u9PjIjIVRkpw+R3mELbhmGx8dlb72BV3gPk4rd9KabxM
	PYMGeJmkOnLN8BfD3x2ar/3yJJMljpJ9GbqurKLOOVsNsBL7Yvn+AUG8/QP2sD2ijezGLnQ==
X-Received: by 2002:a17:906:c143:b0:aa6:8cbc:8d15 with SMTP id a640c23a62f3a-ab38b10bacemr198174266b.14.1737115458970;
        Fri, 17 Jan 2025 04:04:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBl7ZGW9HOEjoWYa05zh018Ho2MbaM/AfkHkLAFNAuE5mjbhSBNSXFS+g5RY1IbZ3JefO51Avocs7e/XtntjM=
X-Received: by 2002:a17:906:c143:b0:aa6:8cbc:8d15 with SMTP id
 a640c23a62f3a-ab38b10bacemr198171166b.14.1737115458576; Fri, 17 Jan 2025
 04:04:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116144931.649593-1-tglozar@redhat.com> <20250116194621.7b309aed@gandalf.local.home>
In-Reply-To: <20250116194621.7b309aed@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 17 Jan 2025 13:04:07 +0100
X-Gm-Features: AbW1kvarp1S6IEVpeDLex4QcWzYr0RxWPE2JuiSZuu4pawGu-KQYF1SHCCSApvk
Message-ID: <CAP4=nvQpS20ubNspE0PPhiyWb3-ARV=gmQzFCA7WwAT8+rxMjg@mail.gmail.com>
Subject: Re: [PATCH 0/5] rtla/timerlat: Stop on signal properly when overloaded
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Gabriele Monaco <gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jgXExDo6HRHhQY8sWsn2gTu50JvzwBB4KNjuaS6w-64_1737115459
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 17. 1. 2025 v 1:46 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.=
org> napsal:
> Hmm, I wonder if timerlat can handle per cpu data, then you could kick of=
f
> a thread per CPU (or a set of CPUs) where the thread is responsible for
> handling the data.
>
>
>                 CPU_ZERO_S(cpu_size, cpusetp);
>                 CPU_SET_S(cpu, cpu_size, cpusetp);
>                 retval =3D tracefs_iterate_raw_events(trace->tep,
>                                 trace->inst,
>                                 cpusetp,
>                                 cpu_size,
>                                 collect_registered_events,
>                                                     trace);
>
> And then that iteration will only read over a subset of CPUs. Each thread
> can do a different subset and then it should be able to keep up.
>

That's a good idea, I didn't think of that. But it doesn't help much
in a scenario where rtla is pinned to a few housekeeping CPUs with -H,
which is used for testing isolated-CPU-based setups.

I was thinking of turning timerlat_hist_handler/timerlat_top_handler
into a BPF program and having it executed right after the sample is
created, e.g. by using the BPF perf interface to hook it to a
tracepoint event. The histogram/counter would be stored in BPF maps,
which would be merely copied over in the main loop. This is
essentially how cyclictest does it, except in userspace. I expect this
solution to have good performance, but the obvious downside is that it
requires BPF. This is not a problem for us, but might be for other
rtla users and we'd likely have to keep both implementations of sample
processing in the code.

Also, before even starting with that, it would be likely necessary to
remove the duplicate code throughout timerlat/osnoise and test it
properly, so we don't have to do the same code changes twice or four
times.

Tomas

