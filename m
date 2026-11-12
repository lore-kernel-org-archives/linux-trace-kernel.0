Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446325;
	b=sC3D6GMotVdEpAZsJpbGynelS3jw7YcXvtl5HE98xIvpmy1skUBhLCVRNZ1LsDwnvYIk
	 5zu1DeKTMJS4/dCv7rf47Q2VgFOGu5BnzxZdSwpzEr4tuLXoyWQtzbkHEU2dxx6ki9KG3
	 tqby/CyVSTmlbgQb1luLY5WNO7MQiqGFtXMuGbRFoEZCc9FmFpyIpX30RECDWdh4JhDb9
	 KVWVGxwUd+NVV70tBmYYVR8CzKzAoH0HWqj2X3NtQfUVvRBTkcLmseaPN1ZvX/CrtXvTH
	 d+G1+qrsjgV3QkZnmmCtnCwJESGIkMobTGO8gG0I6tb4MzFsGHjgecjZpCigxA3xPNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=BbOODuGG0FNPjmT+T9b+kLN1Jw1z3hyQyq3dad9XfLI=;
	b=PM9XT2QS/i9ZXfPZWyQOHMDZxqIxBhcEXNKxW/Ot53fJQT6TrGPbLk2RCqlHQLoktrYV
	 w7UUIO0urpvCYceDqyEEWzND5PLv0NxHViLzGLhCOO2zFW/7DNz+y3OS25InGhX3Q4MJ7
	 8my2be4kaSKv/pS+LD0Meqit1KjKekv6hduK0jGvboU3Mcu+qiaHKFQfW7gUDZi6lowEw
	 WAzHkiUm+l5nsFPW00bbnpuaLsSjUZ9J/AOJ/DKbreFPrVuTjk87rK8Q/f0WdePzdO3sj
	 m4VGc4Gmk8+q27jbyNM4uvQ8p+E3qM/uKsY/ANdKrBtfG5n+PvFbLzIIy9aJWa/mXMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="x/N4LmaU";
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4390606A331
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 01:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4390606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x/N4LmaU
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ed1e9ae5a8so12157905ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 17:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794446324; x=1795051124; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BbOODuGG0FNPjmT+T9b+kLN1Jw1z3hyQyq3dad9XfLI=;
        b=x/N4LmaUUINrFgwptBM8QAlvbesRfu4BGD9yFRk/riBmXpTFAwL8LzBrtMivIx/h5M
         nnokgp4EAATpf3aI/KwuCHbZyiVUYrODGsx2gtQV/ThZX83DqA7Eb/P+fukzYMu6Gw7K
         XRqNTLL2ANJwV2q/XTaTBREHRukfZvTGYYmw8wU8EzmrLlMae4xXOqn1E7oDo2eAEvHF
         LHMMehFrGb1dJCVfV4StrJ5qftCuWhMd4iBMU8LC7pCNY6O7EaiqWXaclHbgUjralz8V
         R5SwrqA2tY47XgsCnvTJH2xUTV5REZbP7tX9Mseb+JP+Vb4EABFuxvzNc0K6WCp21vKb
         bunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794446324; x=1795051124;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BbOODuGG0FNPjmT+T9b+kLN1Jw1z3hyQyq3dad9XfLI=;
        b=DYZc2+Xae5SXHRS+F6dIaKyGc15Q48VGtVL5PzqHl8v4IOk+SYFBdKPwG/aZ5vFLsk
         dQjafkyYPbYenPozYxjiYmiU9eahQe8Z1nkUqQSR8rjeR3qwaMJvr3Tm+ToSSwg3qxKo
         Huwql2ANlersUYP6RX6XbJZ9nM/SeeLx2Tp1DkJlLlKpDnfxyO32RHllo1qvt38NtVa+
         vFnokIiIxT/CzCpgnRqGEVXrRD6cmNkkoHNVyl4X1cGhSRImJDIsDZWjVcLDRxLd+oeG
         P2n2g7yqCQGTmgs9Zs69bnCL7OOU+URQlWkRLUGwx9AbeGnF1oqDqmZkfFYppEOMXTy/
         Y+FQ==
X-Forwarded-Encrypted: i=1; AL+hErGo2xoQXxOSbV7K0EOxXxdZuqxVv/Z5UhzJtKHafCWTh2rlBVwzzXuHSXqT9AEaxOR3CcqYgM1QPbAYRy74ShMA/lE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9To8jOZYC6rMyDaP6vTZsu79K48SmHJTv5ivswACNzk+DbZ3Bx
	fG2ZDAZK5sTPpybebmUnXV6wrjWucPKFWmJN30zirnrq0DmAPp2YJUEv
X-Gm-Gg: AYBFou0PnWIrGYzNJn9FtmUEg/57olxKPhIulZY4HoY8UukZhWZQPPtMKPUsekijJuO
	Fsdl/8wmbGF1ixcGqMCTg2VkVsbzOdX7bXu8xM3DfpudK57d7tJXCsgfB5EYzxdJ7el153ripdF
	7q7ylPsF8lUnWnluH6L0lTjjOqVZk900VP443QMy3RJJd2sbinuzZeV/sN3k4Aim3oRvBodjRvq
	RG/h93Pz0QzqpMuj3vL9FvD5bCUJPJxIQZogWlTslmNEh4WrEsoXcbCbfp7RqqhhtcSyqVXqQBd
	7AJeLslW/343g5jUpby7O9YjeY00zfM6qvKo834tx74TTXdrMPCfTRlpVUKL5GZKfvNo/vlJujA
	m+BGCQrHUqvcpKTMFFAIvSs/AWWKPhC+Ls2/l8fd3R5Tjau84fE5CtwuxxT80Xd2VJMo1eKQmvn
	uyz1ME8sYGPbpgQmxIsS4CL0KGmO82HrALn9SC79csR0XVFIS+avokXbUK0vzNvB7mtS6vle2bi
	oiA7Lv51x5k3gTjB64B3lrf1Z/7Tm8V0/e1eNBM8slzHzQdZy66v0WMXmPCBWtHSWVEbysdvaoA
	cQv6wjcs3zDk7Eu0uhHHXkAqDqAPdLey6V3mmHaVphKeCzy7pFJTYd6VjAJ2U5ElzOrE+0vSsco
	Vcu1gfnvJPgMhkvKjNzJLVZYZuRkG3wDNuA==
X-Received: by 2002:a17:902:cf4a:b0:2dd:ad74:ac28 with SMTP id d9443c01a7336-2edd7752fa1mr45783595ad.26.1794446323913;
        Wed, 11 Nov 2026 17:18:43 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d7d964sm25621155ad.32.2026.11.11.17.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 17:18:43 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 01:18:42 +0000
Message-Id: <DMSU4S7392QQ.357Y29RMDZ8BJ@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "JP Kobryn" <jp.kobryn@linux.dev>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 0/5] bpf: Check recursion per task for
 preemptible programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <mikeba@sentinelone.com>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>
In-Reply-To: <20261111-bpf-preempt-v2-r2-v2-0-9d8f6b952ad2@sentinelone.com>
References: <20261111-bpf-preempt-v2-r2-v2-0-9d8f6b952ad2@sentinelone.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 11, 2026 at 11:39 AM Mike Bazov via B4 Relay <devnull+mikeba.sentinelone.com@kernel.org> wrote:
> This series checks recursion per task instead. Each run already links a
> run context into the task's chain (current->bpf_ctx); the run context
> now records the program, and the check walks the task's chain.

The link walk doesn't look too bad,
but pls share bench trig-fentry/exit/rawtp numbers.
Maybe we should do a per-task array of progs instead to detect recursion?
It's likely more cache efficient than link list walk.

Just for the record here is the illustration of
the case I was concerned about earlier:

  task A, cpu 0                     task B, cpu 0
  buf = lookup(&percpu_scratch)
  fill buf
  <preempted>
                                    buf = lookup(&percpu_scratch)
                                    fill buf
                                    output(buf)
  output(buf)   <- data of B

               today              with the series
  -----------  -----------------  -----------------
  run of B     skipped            runs
  event of A   correct            has the data of B
  who sees it  recursion_misses   nobody

A prog with a scratch map of its own is correct today and
that's what plenty of production bpf progs use today.

This patch set will make them send corrupted events, and nothing counts
this corrupted events. Today, at least, you have a miss count.

Please add it to commit log, so that trade-offs are clear.
Commit log here and in cover letter talk about 'what'.
It needs 'why' and 'trade offs'.

Also should we add an verbose warning to the verifier that
when the tracing prog that uses per-cpu maps might have corrupted
per-cpu data? I know, no one is reading the warnings unless they
are verifier errors, but above scenario really worries me.
I thought about automatic insertion of bpf_preempt_disable() for such lookups
and bpf_preempt_enable() in epilogue.
Maybe that's the way?

> - Timed may_goto keeps its budget per program and CPU, as before: a run
>   in another task can renew the budget of a preempted run.

Not quite.
Today prog->active rejects B before the first insns of the prog.
These insns set count and timestamp.
With the link list approach every B gives A 250 ms more:

  task A, cpu 0                task B, cpu 0
  spins on may_goto
  <preempted>
                               enters the prog:
                               count = BPF_MAX_TIMED_LOOPS
                               timestamp = 0
  spins for 250 ms more

On a hot function A never ends, and it holds rcu_read_lock.
So the promise of may_goto that I just fixed a week or so ago
will be borken again.

pw-bot: cr
