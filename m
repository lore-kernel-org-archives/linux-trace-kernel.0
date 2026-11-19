Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795087400;
	b=ualMDzLMNV/v/9K2LWa6lRv7DNnAZPUBJc5NhOC/Eeoma15JkVloXqQqFL0LxR6ihqr6
	 Zj/QbL/1rjxCH5X51Vtej/usPUzaxIllkMEKNKLaO7bUID/GkK6gltuwHS9OcusT9USZ+
	 oMcRi23zesmBRV2ker8/35N6SKF5pTZE2zbezo2eyduoa02fmFli4AZBPr0ht7fiHmvJb
	 j3LUjCaM7REjpYhCT4GJroMNZsQBLxqSvfOBHcf5bicj8/fHcrkLbGAM0zgdNyIUQTkjr
	 R4JIrrS/gfLF25DayglxmgujzrMYoZKrPlxazCvGcCUv4OIODQBOK79QrDP5XN97szw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=CNGbqnTZ1olkQY7Z2o/JWgpP8+K0KLvFPBkRnaSJ2gU=;
	b=PYO1ed1cypcp/5zn2gN8OJaR1Y9QeBS/mKEdIJuNWFUc6JMbUyrB3B/QVjh7AZh7Q2Rh
	 /qAfROml7ZfKrFW9v9eu8S8A8tvwBqm8XfsqPx/yx2SV4WsjmAZdv/1UU/JdGO+/8q2Kc
	 vW8M55L26sECTDMdYTOI87juBmqMiNUHEP85F/3+AM6NaavfLIf4kEY9TA3ByO4fX1HmS
	 j/dqjIcGVgaUfKkXmlWbNpzxZ7mw+cofSC+GUzxXki2aOAUsuU+QP4E9F2ewUhDtZbLRM
	 mBao7sdxQCCT6a+uEhOXQAJ7/aGUtKSS9C+/9NSZRQc9OLYkrSpzlel/k1Y+5mujw4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=l37DDBeX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F55606A32A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 11:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96F55606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=l37DDBeX
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cddaf52317cso87928a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 03:23:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795087399; cv=none;
        d=google.com; s=arc-20260327;
        b=RlLZcyWPmcno5URmC41VS/T2WOvF0Be3J1jIZEW1eHWO28xq3uEDyIwrQeruTdHdQG
         JNCJ9FAWNAZEFAwIUm80hzBfbNqPVZpHMDqKC9QOPAAUo3dQZgzkPavMQqLliL8JM/FB
         dcuLleT9cTBro+nvbVB7UC7xdBoIed2u7t6KdLAUgbdO5fqVCOiKVbq3i93Ekh5aM6iy
         nKWf/op/7Cvg0thOzaOMmqHmJaTAvH1b6o2DZd0kUoxehkPZSri96a8tp7LqDZFEMbQv
         mSPjzfkbxf5Hf8Hh+4FbamzV7g0kNLdtNNzvoCTtJaEagZPfEDuFck+i68/mzZJD+lr2
         I72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CNGbqnTZ1olkQY7Z2o/JWgpP8+K0KLvFPBkRnaSJ2gU=;
        fh=GRIDr8f/wxAr84oa+3KlmG7Yn13cA6W60rWa7JFine4=;
        b=kyyNkBARgODGwrfLCpflcK/HsPvvns2xmH7D7Rwx/Eq3zgFlsikX3IIM+D6zZPr9rU
         z34P0lYuLsEyrPTgWrp5lR2KDh8wTBa7ansrP+7lPnQSvUEEs8kgTibmrpd1vSii06NC
         MRRuKdDeuih+zbpkji5K8XBQlooKzss7lc7ycmzO/UFhQuVit4wV5YcAuTAA2eaq5R2V
         pnHi4AZsvPHqk8SMalYfZo9fBK2CBHbBRtLh1zozU/rm1wxE097dn1/XBzLoRw++bFPD
         W9LEDJmK36YNZpcm6Oust/lUFCSNna/GBQTZNkPH7qZk7x2Y5p0PIginakqxxB7dUAXj
         o4GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1795087399; x=1795692199; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CNGbqnTZ1olkQY7Z2o/JWgpP8+K0KLvFPBkRnaSJ2gU=;
        b=l37DDBeX6BLHDrkTWQMXuxzojs056iL2RxA5zvzDgwUEMIqnfYNY0TRkfHchtXJmeO
         VKpH3cgTQ58pMyY6pvZ5HqOZi9xa696QKQviWaPGo2N9/9aY2AHUwchwBP8gQwsGsuC9
         CYdg8iPsIs3G2A0YH5TjC480+PYSZbTcwf/VJVB+mGylkKGmvjy8QMbHRzfMexzoeP5i
         D1LYI3p/14q06ICAkRJQsOltmONqwAiyQ9QiRhHvwxzwC4nx9qmrDRGr/WB0F+ge3OMt
         fOeQuFmNfsPprwWcClxJfLxoOwq17T/luu4kb/19RkleCSw2F6AA6zuYj3QEZsgBdUy5
         VIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795087399; x=1795692199;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CNGbqnTZ1olkQY7Z2o/JWgpP8+K0KLvFPBkRnaSJ2gU=;
        b=HMz/QS9tIlgNm4vkPq8uc+HzAPh8XiV96Qkscw0r0zFvgtzw8qWuKYPrNHcHme5x4W
         gXIIEpvMPoUguZvdaumYeUIj7dnRc4NUFqfV138PrRJQR5ddr8yGmHkLXw5jC9hg3sck
         hEDkSzfm8HNqXzm/quFE6Ryt9Dxjxd9zzvcVbhGz8Hu0aoVNxDd3Na8Ki+TzdPvITHjE
         ee//MWoGqgrWpSSPUcANGknus5QT9rMxfcwfq/aQpIMwfUeLomybc7Bihx/R0aPnS7qJ
         sgyDqQYeoHI+BinD1U1v1aLmVDrLvHk833mq7MZ1OOQQ21THVz364Nqxj5X3YIgY9xyx
         0cSA==
X-Forwarded-Encrypted: i=1; AL+hErF7j6oad/kSB/0TCrlX0XfpDsoGCKpuv5qzZKSermbQDruktdTNY7ym+46x8WSBUl2sY+YZZZLyfx7ozTaUleUCWZo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nxo4f9l0R7aVZUsRX4V+UeTa/sA2vH5JHbEYrDju00Odqn6I7
	mVTk846BrFmVOSi37ELmVDhUzabZscfqOfJS9cJhfnhAKiyQlTT0DcPi6vfkosdtBvC9SNbze/o
	mQSjMsF/L4gLBqqlK3IHlus0e04YbDkWOTiFqln8+Cw==
X-Gm-Gg: AZFdTZeQF9szfGqURYXQDHE8mbl5kkNUIhiUL+VeBQnfOtW6iHBjw7zqa0bgOjyMaCf
	8FP7Orae7AmM2Ha3qQIuNn/7NWmHaof2yHy5V6p7zlbGk3Imv010agn40xh7hdqGa3Jda1DNGzQ
	F/RbLi/axDcYCgVyotV+TXIhWJtjmZTfex6uCY2gl1NVPHJK/mOZAKe3FegTLST5Itn19bOj+1q
	Yf7/lu1c0ebtVlBpemwi1vWQfXWdbg3xIjbyDRtdBLg7YnvUqQH/6bZFGLrO9wmhGJz86XbpeD/
	NTy+7FIyIEFCC+v8sfJudePrFKcTtz016NS7X3gAfwJZJpe0ZUSKQFp4/DM1oy1NgE4+efWd9ri
	lEV+zE2mMiKDcb/LDmYtJXXxdm3WFyEBFlroeLYPpG9SwfeNp/iv/rBY=
X-Received: by 2002:a17:90b:4c11:b0:3b0:9e2c:9b55 with SMTP id
 98e67ed59e1d1-3b3d06bcc48mr9846006a91.2.1795087398721; Thu, 19 Nov 2026
 03:23:18 -0800 (PST)
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
 <20261117-bpf-preempt-v2-r2-v3-2-586376ec3672@sentinelone.com> <a51c74ab-35c4-4b7f-b269-cd650700a632@linux.dev>
In-Reply-To: <a51c74ab-35c4-4b7f-b269-cd650700a632@linux.dev>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Thu, 19 Nov 2026 13:23:20 +0200
X-Gm-Features: AclHuK-d4tp1E6L1c3S28pHL6JMWNb87DDYIA46WIXFDMbqGTV_so9pDSZPVRWI
Message-ID: <CAPnbwjrDV4nSyvL5cXEkdFZw+cq9RjWJN+mrs-vJu_M63x6EOA@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH bpf-next v3 2/4] bpf: Mark programs whose
 runs must not overlap on a CPU
To: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Martin Kelly <martin.kelly@crowdstrike.com>, 
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, tyler.wilson@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"

> Would explicitly opting in avoid unexpected regressions?

Yes: a new kind of per-CPU state needs a new mark, and an opt-in flag
avoids that. But existing programs keep losing runs until they are
rebuilt with it. That is the question at the end of the cover letter,
and I'll do what the maintainers prefer.

> would it make sense to make it visible via bpftool?

i think so. I'd add it once the marking is agreed.
