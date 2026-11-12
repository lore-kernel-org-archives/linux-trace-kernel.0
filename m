Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794511490;
	b=n9tnK2Chl33rF3Z8ZLmuwGZYjJ3ag1oZUTJZPikpeuDypivbobnpRegNR/hNcnqkpxxT
	 bX4vPNZ7RlMOD4gzhloUdyNWObuzO4s1/WvkqH+t3FJgdMSs9wZsSHf8WbI9G9S+XM8KX
	 bH2ZjM2L1HVtP/I8n2vQcw1xFNKNirjTuCusNkruDoJw0w7hvhxs00RbKmtuqkxyvyM3c
	 FUggwPZbW3+knypK7dpvkcscRLat6NW52OGg1Q5+BSotk/eEkCgAMpcegusXimRRsw9PN
	 okOfk3pNZlXQL31/yS2yHiUAsl5iF/r2fJWgfAGyCl8JxIPSb/C7n6sPAJvmKd057Kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=jlygkzaiytXLTgXwrjQaRLpn1zirXNFAaFt+aJvGZ9Y=;
	b=0rUySOCxigtPeUXiub4K+v/hmgoJQItHsqbTMTBcqE4uzpE9CJvSulnEtQuZu0rBurBZ
	 NSsQbJHTSKtuVz8mrw9ShP8J/69R2FwMRUSkHWo1uYHqvQbpeZNgnJCthOCJEOb9hPQRK
	 zVwYb1vKf3rtmJRY+TVBtqC2j6wqcRsJNMmPOM/uVTrGvFHVp0ShLBPZVrUHlKnn4AVX2
	 H9iTwnr3dR4iJjajOEIcWHxI+u2+NFBwI9HAAbIY3Ak/+RjBrm8VLaMlZ+c9317uAvFMP
	 vfha0xIWHUUnzfrMYvLZUHER7caj0OvAMgaFUZOp7c077PBXyjpDYqlmFSSXjkuHcIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=YQikDXDn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6601A606A894
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 19:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6601A606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=YQikDXDn
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-89a837bf00eso4087b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 11:24:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794511489; cv=none;
        d=google.com; s=arc-20260327;
        b=ZdlLX3Z1rz6iOnlJDddSWvzuGoeC7CsquzAo/yO1+qCrFR5lDwdlKFlreU4FFs5aBX
         lN+z+ZIGLnfhY18oYo9FhR3Lz0qgYuq7QLbXMcLqpMb241x60Q3UDG3fc79YrtNaJxan
         WOPwqhxpJChkRtX113s1lFMU0kNN0rQWH1JbKLBglcxAz0yXsuOIER944BB3ypsNhjki
         ZKkVOh0/cGezjPeCMQA2QiTbxwakrH2hTjT1HjAUUcTqIYBPO5sSjmXloSt5sDRMRFnr
         wFuoaR3lnPuUsyKhpvtYmaPU2Mtrdo9VUautMtvNUztmGZydOj0bX+8cbtKoCnjYyqpL
         7WZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jlygkzaiytXLTgXwrjQaRLpn1zirXNFAaFt+aJvGZ9Y=;
        fh=+L/iSwDraKlwDpL2WMqdJYJ281m14S50wVSrQD1wVbA=;
        b=OPZmhC9mI6hhCci1aZ3dAph1vww8AkZ9FwUpc67YC3ESImXUKbk5HEnXfGqfKaoBBN
         BCIuXp9fIfC2128n3w2yCrlaxwPqTKO5cLpRU1hYP0Ps8ZqZpvHhdu9lOJNG5eqWXh0v
         ++BilhiYBNr4+MU4tFyU6ynDGRoBZE4xxZ3KSNmZlSYHcVXMDdqP3/H0w/Z4AJNKORFr
         ztj3qDL+NlDRV0YonYr0b3DLYX5V9a2mVBtpsBkxBr1Aj7VGTRM5TG5JtH6Wi+0mK6nB
         hMxm/VPny8mE+yR6KWcdbWAuUs45hn8rTSPTsJng1Q2bjsP4ib+ZVc4yFMdNY0tYvzTv
         lWdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1794511489; x=1795116289; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jlygkzaiytXLTgXwrjQaRLpn1zirXNFAaFt+aJvGZ9Y=;
        b=YQikDXDnkcXNSoppt0sTKONosWFPIbhd/LmeG8Bbp8TUsqZzeSNXv1AZw0SCqyHP69
         zxhZlkWGWOCikEGCKQF6poLCuTxFwnb1CeYYXNvrDr6Ky+eAXsaI5gYneSmFpyRtz4Ly
         DVWNnMo+PfYfBiMh1AjdstdZIj58YuG+jCvSpSu96HYt9+yqle+LwYqP4paX+Cn9+m+7
         vdpovau1a3G4WJbl9brgP7Qn2duB8fEFz4TFO6lQIXMB2+uYVoGFxNgeJgim3R0q2225
         cudwhQZLNxK7969rLcScmJGGc8ryJbks8ZvGNMYDxCfHafF0/jcXiuzDkzM3zyF4NII0
         NzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511489; x=1795116289;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jlygkzaiytXLTgXwrjQaRLpn1zirXNFAaFt+aJvGZ9Y=;
        b=SSgW9foAfWHqbdmQX0uOYtoEMs4WysLcicpJXueBvN9bMLeJP1dYeHaARNL8l3v1h+
         YntVnX53gcSK0AvR3DWGCY+fGzkgNGlfbE04wc58gVBDfTP+jLapI4NwiZlpnTaC5r9Z
         tZLMENYWo5xqoxJxQoxvytvbypdqzfeaVAh+bI9aWspfUhhqwKkXyaWDuCtmcJbyvwp5
         NB5Ra6e74hmUr81Ci6PqV8h/27LS+h6BjGxangKB11M128uA96m7hFajUA7xmbuHORWn
         jx7sgnqQbW7CudvlJvyhQdsVd2xMPqrQJ6zUs8j7SOzww6aJc+Rh+2M0RjgGkgfzuGli
         XiWQ==
X-Forwarded-Encrypted: i=1; AL+hErFAQYayVrys9ub6KkSlpfCjFq6Spi5YVgFuZuGqDVhKmUYNKUPmDM3uKecH1/pgBlL0msW96PRaYpdntCpoFDqYnuY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/H51jnThjy7Ay32axSrjzGyN8jsFY6dpXWNZd+KMpdAR35hUJl
	HPIx0cmiap7k1tUpu+ZLrDO8eNDJYV4xWdyCE9BuVai7R3ZqBGJHIOuiVsXORr0bLZXjDhPRxwp
	JAic4+E6Qimb+4isBz9XUxDlrJwEhKqHkY3NuuT16pA==
X-Gm-Gg: AYBFou2VQnFW7jAFb8XjIghrF2x1NUAtkMHdYCGlTZyf4CgxEcz37UQfhwXIKIn3m84
	rxzq6u2SicuxST9Vw+vH8PassqPDO9WbVRHIrGW2XSSTteFkhQZTmXt9RVtShY0sXNqpgHTNihA
	z2sNq4EMJSnnmsXlGy9ybsp2u0Jzft0SwcAaZTHiTHKT1XE16hPZHATB3vrEceZq49yENd2dYt6
	8zONUqo8FcwQPv7wwX6kpa4TDWhJPqR+B13HKiOXtIGrZAWblc2fn/OojfXO8v24OCkIl8vIInN
	1/pYHzuDATtTbc6GZFK3a71K0YC149ErZgXBmRr9uhucs74RgyeIjr9EMhy96ww9vFf1L2VAmdX
	v38onTmm0DkIGB0qNRwk9kyWWkY+Hda4j5w==
X-Received: by 2002:a05:6a00:3d89:b0:8a0:92ec:5f1c with SMTP id
 d2e1a72fcca58-8beaf2a4d6fmr712148b3a.0.1794511489473; Thu, 12 Nov 2026
 11:24:49 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-bpf-preempt-v2-r2-v2-0-9d8f6b952ad2@sentinelone.com> <DMSU4S7392QQ.357Y29RMDZ8BJ@gmail.com>
In-Reply-To: <DMSU4S7392QQ.357Y29RMDZ8BJ@gmail.com>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Thu, 12 Nov 2026 21:24:52 +0200
X-Gm-Features: AclHuK-ZDEUJCai-MX-vK2KnyCinEohrdaF3lHXe5jxxeIvqToo4i-MZUdaZeSs
Message-ID: <CAPnbwjrBnhnJt7BC-QBEJNh9Jp3bP7WXVnT38mLv9txFrftcZA@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH bpf-next v2 0/5] bpf: Check recursion per
 task for preemptible programs
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

> The link walk doesn't look too bad,
> but pls share bench trig-fentry/exit/rawtp numbers.

Got the numbers below, bpf-next 0fb18ce8a2e9 with and without the series,
x86-64 VM with 4 vCPUs, lazy preemption. Each value is the median of
10 runs of:

  ./bench -w2 -d12 -a trig-<x>

  (M/s, median of 10 runs, min-max in brackets; non-debug kernels from
   the same config; bpf-next #2 is a second boot after the series)

               bpf-next             series               bpf-next #2
  trig-fentry  39.71 [38.75-40.43]  40.35 [39.74-41.12]  39.75 [39.10-40.08]
  trig-fexit   35.67 [32.67-37.56]  36.70 [33.26-37.79]  36.56 [31.69-37.60]
  trig-rawtp   41.07 [40.43-41.73]  38.15 [37.78-38.87]  40.30 [39.86-40.92]

In these runs, fentry measured about 1.5% higher throughput with the
series. The fexit difference is comparable to the variation between
the two baseline boots.

raw_tp is 5-7% slower, outside the run-to-run variation. Its run
context is a C local in __bpf_trace_run() that grew from 16 to 32
bytes, and bpf_trace_run1() now zero-fills more of it, realigns the
stack, and checks jits_use_priv_stack, which a raw_tp program can't
need after patch 1. I'll try to trim those and send the numbers again.

> Maybe we should do a per-task array of progs instead to detect recursion?
> It's likely more cache efficient than link list walk.

I think it would bring a different set of trade-offs rather
than a clear win:

- I believe most of the time the chain is empty, so there is nothing
  to walk and an array wouldn't save anything.
- A fixed-size array would require choosing a capacity and an overflow
  policy. Its setup cost would depend on the generated code; the extra
  stack initialization in the raw_tp disassembly is a reason to check
  that cost.
- The chain reuses bpf_ctx and the existing stack-allocated contexts,
  without a capacity limit.

do you think it is worth doing?

> A prog with a scratch map of its own is correct today and
> that's what plenty of production bpf progs use today.
>
> This patch set will make them send corrupted events, and nothing counts
> this corrupted events. Today, at least, you have a miss count.

 agreed, can we consider keeping today's per-CPU guard for
 the programs that depend on it?

- programs with a private stack (as in v2);
- programs that use timed may_goto;
- programs that use per-CPU map values: lookups, bpf_this_cpu_ptr()/
  bpf_per_cpu_ptr(), and bpf_for_each_map_elem() callbacks;
- programs that can reach a tail call, since a tail-called program
  skips its own guard.

Only the remaining programs would get the per-task check. Extensions
(freplace) of raw_tp and tracepoint programs still need a rule.
Preemption-disable, as you suggested, could later remove the drops for
the guarded programs as a separate step. The commit logs will spell out
these trade-offs.

> With the link list approach every B gives A 250 ms more:
[...]
> So the promise of may_goto that I just fixed a week or so ago
> will be borken again.

right. The proposal above keeps the existing per-CPU guard
for the relevant programs.

Thanks,
Mike
