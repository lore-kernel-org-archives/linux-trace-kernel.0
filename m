Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795608216;
	b=UPpVKjsevxkqgoeoWoieVDtm2s7ZBIbRyNqEVLPb9GBh1AKXWJ00z8sEj+n5uqVUTTI2
	 MFvOHolczZ90a5MVeEzHUFrzOs7xx8a9R2G5yzvO9VKcmiAbS2mRMYESeZ94xOic5Xa6O
	 LjY3YXaCgzZTc3KgOwWOkmX1fL2kGLyny/3dhwqLIussIUMeZwTyzwedAP86I+RpQgxoo
	 3hHbqU5uvZ2TBT9MLuEmDNjQMZWoqhQhW2R7gSJldMkJx4NwuV7x6Mpa6prcLxhGksVy0
	 xe/RndghykkanlhIkIacvsUILDGVqlaXiyukGObPmzCQVFbY/rLEetfaypZijY97uHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=tup9wrbU8nf0eWmfjcOGu/NZ/iv8Wqyf43zvkmJl048=;
	b=Z/nIK2QwVSpnnS6hWZ43jhC8lWsgcFmp8BDSLwdnBDXIHGWS2r0wGcPNfz+DjRJkQ5fy
	 n1oDn62a/OqZ0+3p/pWZQWgnXhCtF7eE5cu53rd9yojw7xCOhNA1I0sjWgvAfkTivX/PZ
	 AXgq0TjJCNvVIKBc73r1y5aCu4A+AibtEXmnlwWBadK5u+JSoJ8F7GakbmKZmnNn0EB/U
	 XUcGYF5nRCqBqVQXhzTcY7kq6tYk35axs/vJRJMAOOO4xRdkeIDPpFDX+l/JaVdF4znem
	 Fr1QyUmGot3gEe6xe9EhjKjMHG35hsYsXXrPX+ykBUientMKehXbgjBr51up8qD98pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b="Vs6Ga95/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBB8606A33B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 12:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DBB8606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=Vs6Ga95/
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b4ab53a966so518075a91.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 04:03:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795608216; cv=none;
        d=google.com; s=arc-20260327;
        b=T5RFfqf3f0rKxZ6lFWpJxoSg/8OqdlQvKuaJpP0ysz4fpOpHmot3dJ5peNbjOiIB+3
         YnEudNrCEMswP98+TBogm9ffLyzL/6+xMnQNsA6EcmgDPj+PJ4OneiPlyv2bawCLAbZR
         egwz+YvCLbTMODCr3CuMH4I9DDCGrb7SZ70kJ51M3r9vYx684FA7oW43oL8oC4YFJuaK
         +pRn9reSRyXesGqYx8fjruwOcraq9QDJLpsvv+5JEaFXQO9V5vTRqzmwnMgUtyZZUYLK
         jFJS8PP/dZSELy5QEpZH/4FSZhmYvabgVDMKVozP7qYujodvuc0wM6ficSssCgUy7xrH
         k1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tup9wrbU8nf0eWmfjcOGu/NZ/iv8Wqyf43zvkmJl048=;
        fh=a2WQ2y3v82Oz/JFsO4Cp/ANe3N3QRKE7+vIX6rU34sU=;
        b=G4WfhSkXojmmQBmgWo2tSVn8LjKX9gyDY2R6FQn/dcTveXGouYwf1l1jl2IjnRF8qb
         HivuSgmaP6NXJzDTRH5BuhBO5kc3mY7u0gIzB7s2DuIRqhyaBBIEd3F8X03BhqTVV5xL
         Bym8JNjXLHIw7tGzYxPzKMzJMSpZJgEZxHVvFjk8iIkDs/e+n0c+0KCTpcQB1k9CKP90
         CYKNgvJ1Jh7BAT2+UXPQJv90VKY1Xh32xkzisDZGt98xgh19sq992gQoBom49R3NcIs9
         ks6i/2V50upoOkoQS49q51rzTpvCOpdrl9FSUfDBLtIruZ2bTk8b0iAngZcE1FCDszFM
         +g8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1795608216; x=1796213016; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tup9wrbU8nf0eWmfjcOGu/NZ/iv8Wqyf43zvkmJl048=;
        b=Vs6Ga95/mRaUREGKXZ9E4vdoMP0K1u9J5ZpXSDocWX2J/AeqvLDgfwj209rKQRafb1
         p7Seom0kCONOkXHyUXxIOsSFwZ1qfTJxeAhYpEamQvZwu5PW8C3lKiMG3FjLgBoAmfrs
         A7E5+JIuzjNhhWEm+MRBVT/DvhQ1+uzse5Po9d8OXJ+D1ivxlOQMIk7y0hB4Gif2fLBD
         GS/uTRxI57SYIJj6HSKCfeJpH2jzpzvyyLwi1eeS5DX91EWIT92HC2J+HL8OBbXrNbIH
         oTys+Rzp14daPGst8Cc5CAkfolTWfg/wAy7f25XrKdYcDwKGF+2u2m6JC2/AkZLvM7fk
         3cBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795608216; x=1796213016;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tup9wrbU8nf0eWmfjcOGu/NZ/iv8Wqyf43zvkmJl048=;
        b=kqIF2GjndBTT4b9GKhOAg5Lth0lvLCQH7jk7Wg4sVwTKeccJb1I5GE7oLEXiH/GwSl
         zaSC4rtJ94vK8afblUq1jSBtX0McvPiOH8658rp12MJTnmRBurf1ZUTHoHRdvfAAw6ou
         TFKVfopTgcvPgcuyFoqhoAbPD3Bk2WZyP+8nc12rFKej5j04M6Anvg8pDXyO+qN5FnCL
         vGX0VV5A/clbHXK8d+aBo/ENu+VY74ukUdxygk9/eaMrZJtk+Tctku6vN+H4mpXp1wpv
         Oii47jJCRAvvTJOMl05FLhZa+62IQUOqja8yH6IIiAHctov5kSjWJf7fsr6jkGyXo7iO
         ni8g==
X-Forwarded-Encrypted: i=1; AL+hErESwLf8ThjKzvmKhMx/6vTk58zqflGU4S1CmR7d4d3H0HYVTaqnEBNwAwQyfsK3gdrstuOOKU7OVZgA3RZoh+WPiC8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TPC80XGQ6AQVsngjPkDexQG5+rSqpYHQnpxV8J8IDltv+07E8
	XeVJcyKljbipnnuTG/pefcwSbNebBW2QL7ZqY9tLo1PcTYA89eSvZyyUDlhl69XsFySHnQvKQnN
	Kuug34kJOgXcdiARza7jYIAcRpGraRag0mohbgQFF3A==
X-Gm-Gg: AZFdTZeb8aQnU2TP27IXSiqNmeISEUue83AjOkbeZrUnhYRCtGe257WMW9N/WymLaiG
	nBwtuVzmXg1rrBtB/SzMWhtazVBoLyGVN7OdGWNDLlHqX0ZJk5p8vvLFUTzoQa7s0aYUYrBiDHa
	LGOK2lbKAFTzjnUslmvJoaIqSsZTgrkxMX15JZJ9W3VqHj9sFTGxyI1l3alYAjknysATas015tt
	VVg1iS+ow5twiKcWHbYsgtHUZQfTUL6/jqzhfE3C4PvaOtzKtPQ91pgKeJOhe8kNTlG5dCp19wQ
	drKlfTUdZBVYCgF6IFpPvXNFSFdoHt+yTZ+qoxnxrTWx03c8MQ5izpbA/3WyoQKHlyQlwAEjJbH
	to3/CPT5zfdl5uXXlG/1s5d5cVJQ6VmpvXZ0=
X-Received: by 2002:a17:90a:c10e:b0:3b3:c92e:f523 with SMTP id
 98e67ed59e1d1-3b41c917320mr29094246a91.3.1795608215341; Wed, 25 Nov 2026
 04:03:35 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
 <DN38312WXPDJ.2KLUTCWSDFL3P@gmail.com> <CAPnbwjpP9Fin=CyD0WiA2c4sxqbfyK7AziE64PCX4w9kbz55Kw@mail.gmail.com>
 <DN3Q2CZJSC2C.IM2EYLF1NR9X@gmail.com>
In-Reply-To: <DN3Q2CZJSC2C.IM2EYLF1NR9X@gmail.com>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Wed, 25 Nov 2026 14:03:38 +0200
X-Gm-Features: Aa3M54oy1asy-clEA0aiBgUJI2wZjpNvBPoFr8M2_NvkO6W7Ay5C4UmmNBOTtyg
Message-ID: <CAPnbwjpLcyJF70D5j-q23L3TQSFXebB_RndQRmDe+_5h02YazA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	JP Kobryn <jp.kobryn@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 24, 2026 at 08:26 PM Alexei Starovoitov wrote:
> Keep count and timestamp per-cpu. Call bpf_timed_may_goto_save() in
> bpf_prog_enter_run_ctx() and bpf_timed_may_goto_restore() in
> bpf_prog_exit_run_ctx(), like bpf_timer_cb() does.
> Then the preempted run gets its count and timestamp back.

i tried it, it works when the run that preempts finishes first, as
with bpf_timer_cb(). With preemption it can be preempted too, and the
preempted run can go on before it ends:

  task A, cpu 0                  task B, cpu 0
  loops, preempted
                                 save: A's budget into B's stack,
                                 fresh one in the per-cpu struct
                                 loops, preempted
  goes on with B's fresh budget
  exits: owner is B's, no restore
                                 goes on, exits: restores A's,
                                 which nobody uses any more

A fentry prog spins in a can_loop loop, 3 SCHED_OTHER tasks on one
CPU, 4 runs each:

  kernel              runs  dropped  longest   over 500 ms
  bpf-next            4     8        250 ms    0
  save/restore        12    0        1253 ms   7 of 12
  save/restore        12    0        1752 ms   9 of 12
  save/restore (*)    24    0        2263 ms   22 of 24

  (*) 6 tasks instead of 3

You can see it in the run times: they land near multiples of 250 ms,
one extra 250 ms for every fresh budget a run picked up from another.

An lsm prog has no prog->active, so the same test gives the same
result on plain bpf-next: 1253 ms, 8 of 12 over 500 ms. The overwrite
already exists for all progs that can be preempted (lsm, cgroup,
struct_ops, uprobe, iter, sk_msg, syscall).

A fix for all of them has to change how may_goto keeps its budget:
lsm, cgroup and sk_msg progs never go through bpf_prog_enter_run_ctx().
I'd rather split it out of this series: v4 takes may_goto out of the
mark, so tracing progs behave like lsm ones today, and a separate
series fixes the budget for all prog types. Does that work for you?

Thanks,
Mike
