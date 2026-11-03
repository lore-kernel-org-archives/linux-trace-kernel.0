Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730540;
	b=BHnrdvW5nBDSTfdIO2uxnS7r2jblGv7hZUjewez9V8Pus4lQzSNDUNg4UyFMdb6h2Ein
	 Gq/arm/IrSdrTcUkqLflckiFBhXdvTqfaPVcdCWa5JX2TmhQRLCPkK2EVaRBqCkaDs6DT
	 zoNe+EYSLVLAuFj+ZGUiox1AxdpIhSp53Bggi/0RsA3WFfqeDknfU4YLUbX1q7B8lmaFi
	 xmVdkZzeQQB152OBJO9C+ktCdDfV/F2d2gL+7GsjiYUq9QOUIKPA5+P3G7+buTXsjKn9z
	 ThrA2naUA1f2tsw5gTJlf2qD1DtOx7FpIC1zrflA7eex78yVtnPm27CyblivBixWyyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730540;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=A2SxbtdInviKmhuZ6qhITPKihTTKCU8zqlv1zCWXFFY=;
	b=Vq3uNUxtLJ4cSjFii+Bgtc9RVpmNo41x2RqRGMbpbJeF//3NG+2nOHBeN9Y4PG8+mPrl
	 uuVdaNfQUjb0W0fmZTlWvu9P31KSTDm8i29D8/zwvCw6g4tWA3JfJLp7TpqPJ+NY2AdcL
	 w7fZY53utGYea78oc/53DUB5pLysZcR+PDy1Qc1MiTk/5TZn37ToluPAPuIuCbNMmfpno
	 g6u321irPhKn9d6+KOKG5DANEHkqLQDQ1Mz7xmXWbFXVH7u0VFHyNiANq1Tr8RJyw8PDT
	 jqfPKaSKWiie0ncrpyNC0c2f37RWMf177Cc0+QqDTM08hhCSRDifZtUYKoyIptpiAHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDktR5oa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F2D606A328
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDktR5oa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3951F000C1
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 18:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793730539;
	bh=A2SxbtdInviKmhuZ6qhITPKihTTKCU8zqlv1zCWXFFY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DDktR5oa1crRuyfuFtCMXUU+k3OQICXkZMzNhtqUWIUnC+D6gpAMnTCG+3xL8tQ9h
	 IyfsZZmGsReNSr7/nnuAHWF5Mn478r2mULPN2L+rH6Q3YqgBtIy+SCpylEZn5g3NdZ
	 /z80fsdCVKdRFOmpfO0U2owkg7PiT4fGszZdjTrpCDmRHl1Wto/C/vV/7ZMjhEGNAF
	 rsTwgck41zXLVg/9ZT4ruE+tmYJSkqMg3Umnc45jj/04V9JT1Z+FHOOc6UKKMqmJk3
	 aNgBu84nKY0A6Eor7WoiC/jusDJrj4pyJLhjdleXxLbtGjGgaTwvn293D6wEzUIPs5
	 dW4km++/0Ghmw==
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93efc0452b5so292227885a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Nov 2026 10:28:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBy1rwXWTZ0R9fNR1MUwiCi/2T5AHVCD14wm3xZ76V1xIvuWzVgCf0K0U4F4yBOCpuDqiAWW+HLCikf7I1Fx1wnxR58=@vger.kernel.org
X-Gm-Message-State: APuU4Z+p5mZpGQFImloFhs9i0Vf62c1vQoxzz5oVuG3h1annD+M3QDU8
	906vdPOwZp4t0gr7mcmJxwg9yYk3/9B5OkFDsAE0WkcaVZAZyp9HmCYv/XbB4ASKC7wcbXMBMZb
	/lYG10lNGsxzaQ9Bb0rG6DsQIYWyToCg=
X-Received: by 2002:a05:620a:3196:b0:93a:824:ac8d with SMTP id
 af79cd13be357-944216b1afemr2371370885a.27.1793730539153; Tue, 03 Nov 2026
 10:28:59 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103025610.3738894-1-ridong.chen@linux.dev>
 <20261103025610.3738894-8-ridong.chen@linux.dev> <CAGsJ_4xCTSctcPcC7X6Dx4zYaOycaPqs0DG7AaxB55wx1Afwpg@mail.gmail.com>
 <9cabcddf-d807-4a36-84f1-5bb06ea72aac@linux.dev> <CAGsJ_4xXDZjhN+NkvtN+vAp8Bokack_JdNgP=nGPQtHUX8_rqg@mail.gmail.com>
 <f5137dbb-b0ed-44ea-a23f-5c848315a68a@linux.dev>
In-Reply-To: <f5137dbb-b0ed-44ea-a23f-5c848315a68a@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Wed, 4 Nov 2026 02:28:46 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zNZynkZn1mb+nT1n6dq4n399VC8Lbo5Sv92gioDfPxUg@mail.gmail.com>
X-Gm-Features: AclHuK8ocj8au7qeT_BVvieNJJ4o0s2vwCrhyBoxk-38BXmuY8mPvZOfmLABhGE
Message-ID: <CAGsJ_4zNZynkZn1mb+nT1n6dq4n399VC8Lbo5Sv92gioDfPxUg@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] mm/mglru: add tracepoint for inc_max_seq()
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Dave Chinner <david@fromorbit.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>, Ridong Chen <chenridong@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 8:23=E2=80=AFPM Ridong Chen <ridong.chen@linux.dev> =
wrote:
[...]
>
> Hi Barry,
>
> Agreed, I'll go with option 2. Two things I'd like to confirm first:
>
> 1) To report the reason, should_run_aging() would need to return it
>   instead of a bool, e.g. an enum like:
>
>    enum lru_gen_aging_reason {
>         AGING_NONE,
>         AGING_NO_EVICTABLE,     /* eviction is not possible anymore */
>         AGING_MIN_GENS,         /* better to age, eviction still possible=
 */
>    };
>
> Or just report sc->priority, swappiness, max_seq/min_seq and the
> per-generation nr_pages, and let users derive the reason from them?
> The former is more direct, the latter keeps should_run_aging()
> unchanged.

Right. We can let users infer the reason from max_seq,
min_seq, and nr_pages in each generation. This shouldn't
be difficult, especially since should_run_aging() may
change. We don't need to spell out the exact reason.
Just present users with the overall state of the lru_gen.

>
> 2) try_to_shrink_lruvec() has changed quite a lot recently, e.g.
> Kairui's reclaim loop rework, and your swappiness series also touches it,
> including the aging part. Is it stable enough now to carry a tracepoint t=
here?
>

Yes, I think aging will always be needed, regardless of how
we change the code, so this should remain stable.

Best,
Barry
