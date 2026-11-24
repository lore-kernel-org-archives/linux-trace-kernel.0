Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552010;
	b=vGkBa6Dlks0fir068Qctw+fw1YJauvYn3IXNrUVKFmAOtELpm2ZbbDBEJ/2Xj4VODtay
	 m+lb2i1F6rmjLC/5u56o/HJNpX33yqmOlcbBJa0OgQLEyA1vlCV60lOlNQ/+hJuf4Zegg
	 VWBOqTCXNfe/R+VcVzYvyXTMdEBrwO1He4MHZfqST3GJDJnESnpjer0i2IL+SkULAtaAv
	 U6OpL6z8KMzW/OgJ9dxUP+aoLc1m2pmCNBMYtJ1qd/2JIAi3e+drDxW7+iusHUTB8jdxM
	 2SA+VS+6T15JaFU+vD3CsBRRVeYlhIE9PanMknUnUATnJ6KVX5XcIyylFzgOVArcn+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=TpDTZc9RdjJDO+TUClWKBIl76LjEpAqHQHkgkZyC8Kk=;
	b=QcDMbc4/Aq02T50mTBh/uoV3iAoWr/Q2DsLYmyerdddcce5j6JFE+9U/EGXm+Oet4w36
	 IdHAkzDc/9L3Hn8OsnLBkOBLro/ZXqjPKiERZMG5NrVaY/y0DvTOBWtr7KB4CO8W38lWk
	 M7L0537EctV3J0EZ7Mdxd+ZvTIP9USLRws3yHNna3wN9cr5kRJIc/eg9jZc1o9roXm+50
	 jqX2AENZ52CzFJzerOHquHQvFtC6dpuYJipPhqePC8ACEWdqb3AkZ4CZSyYhjlhiauaxd
	 5nT+lBszSbUdSW69//6iKrQN8Mx86W9ucL5mVCR41L62JIgqMqpAn1sQPCVVb11V7rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RH3wZrOn;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA746606A329
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 20:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA746606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RH3wZrOn
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdb9f760337so2970596a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 12:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795552009; x=1796156809; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TpDTZc9RdjJDO+TUClWKBIl76LjEpAqHQHkgkZyC8Kk=;
        b=RH3wZrOnD8/J5IZZJGeH0hoDkDf988zkanaCwA1Tsncfd6yJLnI7GT8VASabnTVm3n
         cu9khA+ifG54cQwXUEXrgimg9Z53nRntZJ4klgrJxDo/u3wXAOrhsXl1I/xtHOwCD0e1
         fH6eYKUGPepX02V/2Pk7q5l7y2P6luUm1io1ge6A+6JDbDu2/RPEyQ0yKFVAHkQy95VK
         vZcyY57Er4XzGaqFd47a5VDn89fr4Eox+KjRAw1MGg/Op1Ccl00Rp0HSClnrZXbJxifE
         +ZGAVFkcspa1m/W4E+RegDQcutmUhxkS3jwk9WF1ymVKmRI0J7+9j3+IEX40mxlmGmVL
         BaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795552009; x=1796156809;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TpDTZc9RdjJDO+TUClWKBIl76LjEpAqHQHkgkZyC8Kk=;
        b=x4PfY36c/zn4pAMevuQ2aFcbuSIkMZWmy/RdAS+3ZS6dHiJHDSvTEZKIV9oZKu/l6C
         4tFCasdzec5dI0lafcn8hUK5ztayjBDcoO4liGe3LONsj5BXdM9ocevo+tiR/KY9T+lV
         OM83MTrJAMvVE9ut5utFsOJHg0my8x5ygG5GASjwj0stlskWWMxWtJ7vuKW5cDhRBrke
         qeWU/NF48ONWteAEGtxP/D1Jdo5xaKuX6HnHNqShEHkYut90h7fOQI8h2v2ZXJb8+6Wb
         a2J5er5/Xv2itlabPm4EK6Oh01UMp9PTENbpIMXfZ5uEzTqSNSyKPxd9HwOgDzGg4bKZ
         EAPQ==
X-Forwarded-Encrypted: i=1; AL+hErF4uDeTWyAvaWJut21F9yYCymnOnWG9PBeph1hIcI/rMbc5IcnLCOBT9nZCtI5338RgtytXJMXE8lsz64qge4oLfI8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qBJFokVNTWlkQiQewbg1T3FvgV8F7jvlzwF7yPXDZEnjPE0zq
	FUKO8qUk/opmw3wJs7Z6gSeH28m2ogrRoC6JYhtznvWH+Z25k+E447+U
X-Gm-Gg: AZFdTZftzDCRvfquJjv6B8LgPKOVQ9lXxhE/fi6eHvoV+bd2MJBmNc7WmydJzWuSCPh
	PGLMD+H+M4qM5jJOfXyFWNXHmiI3CPWFQDcM/ng1ZjcMSOjrEu+/g7N4noyBegoFm/N+bIwlvVn
	JvAitY7VrC/fPQmR7cpEWiBzjDd1N8F2pLMehlq9ISVSR5R/2pxL3u7T8Y8wdyPMi8h3K1QSS0O
	DAeQ85kjgkp5ISAvuCnDSkNEBpT33JUUQl7/ruscIYhIDSWjChzecXdwVNYlasSVtYWhCfMF/Z7
	pUhW86beD5uz4fbq2BMtqKawEKK4sbNeDYOtP8wQ8l9o68r5wcMe1uLSEtrIV4RncTqHsbTgxP1
	zEmN6Nl7kbbIOojy0/C9xSQkImomVEuNoOzmwhMqt+CRj9FfOfBXdvCivBISxGpaDJR2BTuJO5I
	9zhQlTWNLT7NpoTKLHTc/copAqzB8v1HdHKReggbkwkHLHvyUEhvTVPEf21trU78v1VANj9vW3a
	tnAZ8BoK5st2A060MftermiNlMlDBDfXFYF25poKr9tkNIcdaElekeWwyi8z+jAeEGyqZO/+hh0
	/GCQyv4vvTPcvuP1sLECPdrw5gt73tbNP0v3OwRQq9Q/dpmKlp7M23shg+5zd8IFF96gTF8DvCk
	Yw3cQaGCzHDvoJlCL9l5Byl+qT6FM3XKC1Lk=
X-Received: by 2002:a17:90b:5289:b0:3b0:9bfa:72ac with SMTP id 98e67ed59e1d1-3b41c908147mr10850061a91.21.1795552008788;
        Tue, 24 Nov 2026 12:26:48 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecb486sm26712524a91.16.2026.11.24.12.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 12:26:48 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 20:26:47 +0000
Message-Id: <DN3Q2CZJSC2C.IM2EYLF1NR9X@gmail.com>
Cc: <bpf@vger.kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "JP Kobryn"
 <jp.kobryn@linux.dev>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mike Bazov" <mikeba@sentinelone.com>
In-Reply-To: <CAPnbwjpP9Fin=CyD0WiA2c4sxqbfyK7AziE64PCX4w9kbz55Kw@mail.gmail.com>
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com> <DN38312WXPDJ.2KLUTCWSDFL3P@gmail.com> <CAPnbwjpP9Fin=CyD0WiA2c4sxqbfyK7AziE64PCX4w9kbz55Kw@mail.gmail.com>
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

On Tue, Nov 24, 2026 at 08:10 AM Mike Bazov <mikeba@sentinelone.com> wrote:
> Timed may_goto sets the mark, so a may_goto loop would run with
> preemption off for up to 250 ms, which you ruled out on v1 ("with
> may_goto they can take 1/4 sec"). Move count and timestamp per
> invocation, in bpf_run_ctx, so that may_goto needs no mark?

Well, since you brought it up, let's fix may_goto overwrite issue
as part of this series.

may_goto's count and timestamp cannot really move to bpf_run_ctx,
since xdp, tc, perf_event progs and async callbacks
don't have it. In bpf_timer_cb() current->bpf_ctx is NULL or belongs to
the interrupted prog. 

Keep count and timestamp per-cpu. Call bpf_timed_may_goto_save() in
bpf_prog_enter_run_ctx() and bpf_timed_may_goto_restore() in
bpf_prog_exit_run_ctx(), like bpf_timer_cb() does.
Then the preempted run gets its count and timestamp back.
For progs that enter this way skip this store in bpf_do_misc_fixups():

  insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, owner_off, 0);

With it cur->owner == saved is false and restore does nothing.

