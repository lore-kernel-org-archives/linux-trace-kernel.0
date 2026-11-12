Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445473;
	b=JxjLmenfuIhm/SWNhELDXvP4GsxbRUK7+gfqZ2pjfzlnauSPmAFyb63ULQBdv/y8NhPk
	 d/qB3fkTY4COEhGRhNbCZgLyEJ1WapfbcfKYd5r9xmJFWGaEhKondH74bClH0HA9IxOVs
	 1J2j61UZaSDdVlYS0abPk1gXsZiY/Fs6lbdzovjI9+ZLiJv61PEqWoELNn/PzFbwgPnuC
	 zdukokS5yvA343RSOO843WnqeY/h129zPUTT2v8e06fWxtUa+NQinZbhuXph3R1hEX9ze
	 P7A2/VkusX7SXjon6TzOHxlc6Uzpry65UAwqxnV2DoHRrpvHFjtbQPjbnbZiuJuF+lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=ImXBWGlfZVszV/Tkddt3FR7QWzPa65TkJvi8WUZhBmU=;
	b=SnIp5v5h1pJT/PD2ai7QbRE48yKxP/hkWAKH6a6dawZKnfRVs+fd5Vo9lKLEOHMMT0te
	 Mor8XeGAKnD+8NZvcdd45SRFw7CcfvN0cNBaFM4vXMX6gslaArvNcQCf+Br+Rpg3OzxXv
	 3nou2oONGK2BfzSbAfWrSygErRHsMJVGkUVDySItdZ4XQmyIWP9nQaYp7PhgI7fp+C/u6
	 0qVasHG+VBUvUCY8Z21lMSc8QT/vE81l/BLrSNEcQImTFKSrAlYkkQ8dxbcWBaKJSzEe+
	 X5GmIUDmtst9KmR8hEQAvVbgTMGbT0ie1pnF8l7tMwoO2hRveq/Q0Uso/Pn+1HqEaDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AISAJ9bb;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30926606A338
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 01:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30926606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AISAJ9bb
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdba1bbde0bso1418922a12.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 17:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794445472; x=1795050272; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ImXBWGlfZVszV/Tkddt3FR7QWzPa65TkJvi8WUZhBmU=;
        b=AISAJ9bbeU8GfdfXc0hLt7sMbDWH+hMBgyUtmeidknJQeLdeCBSqQ++3Ab4McAJkWR
         cyjHGHKPWZzGDjet/7z2iDyQHRyGnIe0HOdif98bx4pz+lYySI0+lCGOf7CeW2pHWIzv
         tpEDH/VJX+VnjRJHCVZeNsYXOyzUXqAldn6kkUhTXMYZ+sWD0fa4Fc+tKpTZu0IWHlFt
         irjynHqGN/7GuyKtbmfM4Qje2w8qHPEyAIAcozxd1LS8veIrrThANyqqXGD3oVTjmZiB
         HOIJg46NX89zi+SYaRrcx29ZvLGnCEStm56k8tduYDPHOn//AwYmnhWpqU28Qgdby59I
         wSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794445472; x=1795050272;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ImXBWGlfZVszV/Tkddt3FR7QWzPa65TkJvi8WUZhBmU=;
        b=NC+D0/75Q4YbaBkL3Fo4a4vgUkO8wcmU8dKOZtkPAfcasdDijDiLF/MTWxqyY++tT9
         wJrvkMl67r+t4X3H0ic04nFhWB/hsPOTSJe4kjhVcfP2HG0fBNShOAqapL3fKjfYL9GC
         aDmlRheU9s91iWfYwSNxv3+/vwx9cbfMHESdVQ2qnovrxB+vpFnTw4YMsuRcU1N63Ao3
         FsmzMbIOu7c74r+2YU8FLTv+o1H7yrXjGldtqMg1GzcqxrMRgm7kOinDueftimEUq0Ur
         VbieKpXDq9byhSmoSQmleC4P1cb8yW6khKcSspcUz74iaT+f/xmUR9XTLXKqksdRswhP
         v+rw==
X-Forwarded-Encrypted: i=1; AL+hErH0LtCnPFqHOIVrfjCR4UuFriCJMKZLGHDGOH/y/b9s9NU5UyjnEIxKN9ZCuvFM8hstZAIUI7TJVIwEgHN9L9w3bz8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XYWm8w98SEMgG0N8buz3TdfJBMM+dBkgVEWiM6668sYMzH7j1
	BzmRFBWPQBmC+eUzXdT7VhVBoslGBrHptkrJYlB7UZI8UKKKauwD84s7drVrYQ==
X-Gm-Gg: AYBFou0/fN/QHDDFUczqsK4k7GvETqHhzPoC95GPS6oMgTzctpFyBVpnp2VTuLvQa63
	Hd3cUDvWEp19nOBUcSXOJFy4RZIGjrRyJA2bENQtsKgzjO4gkvVGL/LbtYvx4hAJXMfvfd7A05w
	FdSJNr63OYX+NzZ4ue0hRE5AbPrMqC6JLkZhWzDmAv8wdFVqrDFUpEd2JjWlhrAH4/wmD0OvAYC
	EPVH0OA3a07gG9Nbej0wgSe4ewd/9nVfYjpK3Zke7oRkh/+azPY6GFe4GJ8K2OSiMaNY9rUX9BZ
	Xyoc83Zl7cIg4wRq8NW+SpI723j15i7/x1UJoAxah0+2mkHtSPmbTCy+esAH2IMWU+UvC9qYi6w
	/W5ALQo0FwNFmwaShKw+PRxWCHztoG9oNwZRynYPUwY6and60vcfcy9GapUycRDs9lU84AfyCsZ
	skA1LzbY25UZbdyYgNWCZte/YtHFukjR2LYrh4btJwZk1/0jhavVSV0p+mYIsAaJdYKlW21ytlv
	+Wv/Gk3IjCgxk7nRHV9umQ24OCPL/PTDgHuUW6w9SgLfursJW2eDM9aP4NO2UItNPiMkwA9+FrW
	BnZPj6GoJxGMAW+PU+zxWXhoG1Vq/4r0JEeEfn8/FNtARolA+afxm4vIyf/7EJrs9/pYb8n1XD1
	4nVxqlVb/gNsBF5AQi6G+W3mSwjlB0cgFxA==
X-Received: by 2002:a17:90b:590c:b0:3a8:699f:959d with SMTP id 98e67ed59e1d1-3b182f28bd7mr3487343a91.31.1794445472226;
        Wed, 11 Nov 2026 17:04:32 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d7a26e5sm2247647a12.18.2026.11.11.17.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 17:04:31 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 01:04:30 +0000
Message-Id: <DMSTTWR4MAET.1VEV3R66S7ZFY@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "JP Kobryn" <jp.kobryn@linux.dev>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 2/5] bpf: Check program recursion per task
 via bpf_ctx
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <mikeba@sentinelone.com>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>
In-Reply-To: <20261111-bpf-preempt-v2-r2-v2-2-9d8f6b952ad2@sentinelone.com>
References: <20261111-bpf-preempt-v2-r2-v2-0-9d8f6b952ad2@sentinelone.com> <20261111-bpf-preempt-v2-r2-v2-2-9d8f6b952ad2@sentinelone.com>
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
> As a result, the same program can now run in two tasks at once on one
> CPU. Programs that use a per-CPU map as scratch space across helper
> calls may see another run's data, where the run was dropped before.

The kernel has such scratch space too: bpf_raw_tp_regs.
bpf_get_stack(), bpf_get_stackid() and bpf_perf_event_output() of fentry,
raw_tp and tp_btf progs take a slot of it with get_bpf_raw_tp_regs().
It doesn't disable preemption. Three tasks on one cpu:

  task A              task B              task C
  level 1, regs[0]
  <preempted>
                      level 2, regs[1]
                      <preempted>
  put: level 1
                                          level 2, regs[1]
                      uses the regs of C

B sends a sample or a stack trace with the regs of C.
This is an existing bug. Today it takes two or more progs.
With this patch A, B and C can be in one prog.
Doesn't hold the series, but I had to mention.

> Fixes: ca06f55b9002 ("bpf: Add per-program recursion prevention mechanism")
> Fixes: a46023d5616e ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast")
> Fixes: 439ebd5b5708 ("bpf: Add sleepable support for raw tracepoint programs")

I don't think we will be sending them to stable soon.
This is a big behavior change.
Backports only after next merge window.
