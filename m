Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888BB3AE193
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Apr 2026 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775223069; cv=pass; b=TmwwNarkjp3ezLg0SOTCZZ6hfJ+CJr1oqP+dFitvWgetbfhO9eSTAHPsByqUo/ZjTqEnIChY+uNwXn0VwU3K/x8AMimjHf5NBsFcLpdyfD22wRZCR1q9sLZZdEWNV0RO5fsmJX6zYjsjcL7gGrCBBI1F3VVJCqNsdlTkuVrrclk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775223069; c=relaxed/simple;
	bh=c2L62QsoV95txLA+XVc7yZbDzuoSFBDOFQIxHtl34Bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ti5tD8VcliC2h86HGasnBP7fZV7+TC6U2U/DjYlT1cYZfmh5OYytpO4SV2N0G9FSFcBPdaxrpN/ccpPJXM6GT1Bk0u4DAXthhehSJQ6KmvE85CScwI+0E/Zsr/72DVnBMdKTb4VDQvdN7X+YFkuYXzM7rPYhW9WrWWbcm3HYT48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ST8A+n/h; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ST8A+n/h"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79a2ee65171so28241517b3.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Apr 2026 06:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775223067; cv=none;
        d=google.com; s=arc-20240605;
        b=BkPbZFj93rfHw42hgCMTkcoZcC2Z52Km/inAOtC4Npn6zurndEUjkLHiwZdTwOlBPb
         OlavLpEQFykMdzLQrsE3gwPDOMNnZ2S3qkiLGWYr24cjzP9jZYpYFpn67uzqItNv/n3w
         mo5CXaSRkx4Va41mhTGvsTiLlT8yNyAxmoX+/qLNOky7T2qZQbkpns7imVDkUqWV+ACB
         gziOskfT3sPc9bpRQEQDicq/faJ2z0l1XSyIGlEYUVX+JqffEfaQI8LObOQjFA+okNzV
         PSizSp6FtZQ15zQ3I77VwYbmlq2BQmJFmEObh+M/we6P+9aAGcZPbpNQW/PKdhWLxFMF
         VqAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YLrHKhwlQGiXbkZ8zYh4kD8n6Ck1PfmwiVDlhPHBfN0=;
        fh=zGHASpwjA7kIATOJ7xQ634BCGenNK5L5rU9B8/pjjME=;
        b=Z+4Pizc0f+ybmf0b/0tHLEIHRUGCbC2p7KfUOO3Ec0fEw2D1U98YdzrZsZjimxzx9w
         zJaWCfsM8E4eDdFsmDWdEm+c0GRXmWQEIVowA3uasNpC1l0LAL2F4RoBpkW/CB9JULnw
         xMtxRUZbUs4crsfuDrv3+PcBxGrhB2rbx4vjPWzuqnr4AVmG/1qG6ZP2oDubNuZeZmPc
         zpAJ1l1gqI9lBjJx8XaavlSdxwQkj6atzRvnzJJxCpxLDStjVmmpPq2urSb3aOs2Tb9s
         T1Qsy+MaSJ0l6jaeuPHOfS6UK/kKUerb9rVNDsE/bP0CoWGRy/Izph15VlWq2CkECw6o
         eq1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775223067; x=1775827867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLrHKhwlQGiXbkZ8zYh4kD8n6Ck1PfmwiVDlhPHBfN0=;
        b=ST8A+n/hsRReq3zeoPUE7unK/HASRKTU04fkVjW3LQMlUsb2r90FiDzwkQz2mlCxor
         IBqEfxBZ6Rz3kv6UtnGK3bQFHbZWvIbTSaGCFUai+MZvDZW0eD9Bmt8fwlc21O4i5yQH
         eEwPmKb5VCvZd6LHZ5u0g8RflyBFOhYU25y2L1W9CMi9cE8EAE3H2uZKZcpI/t72t1pc
         ZBf5JGgVLb2BjZrQpZWNsapYXY7XggCiFVi6cYXdJDCr21jgFns9El8S8sLgNNtchZMm
         phSdfEvrvNs4rbH9FP0l7z+S8zZZQzWOymZ4Yyrdis6kZxCV/3diICzlQjnR7h43l6Rw
         3frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775223067; x=1775827867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YLrHKhwlQGiXbkZ8zYh4kD8n6Ck1PfmwiVDlhPHBfN0=;
        b=X+eqUm+2P/LY4qb0W0BbrNi1HnL9+oHCss36d2fMVTW7vaDvzHdrezSk6qgvI6V/8L
         pvX2aOkrsDZJNT+ir0o5dSm4zC9sPqEOpuV7n0maf8jYYnUo1gqp0bEy4Hw2P1B+cfFl
         WY8iuwSV2VMPcO+uKsbDl7eR6IJZAwatMimqDDlQPtoVHDCoj3G4ZaGPmsAodh5FeytS
         1K7tW3vTlqGM3PKRCgxHwXy0uCnxJoKr4/w2iskbU/fiyhP+vOEMUArQIz7hkOHgE8px
         xCZMababPYz8e6D2yEOxtWRw2cIC47N3mgrGB+q0lyMRUEP6HRCNnDiAL77V5hwyubul
         L4Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVM0qZKITlmcTpJDiMLIIyQs0rnn1VYrOxWx/Ff0uCXxoYCsqWtlRE5Yg7WcWEdMjZ/Km/A3gRoPRQv24xhwaeuE1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoGFmGLj76KTMTDL/6/GVPMTFU4dqjCFO13I6tOcx+ZLJJOXkN
	zM1Av9k3ZyZXn+qenuI6cV/h3u2gw5dlZml82l5McqOjdj+GyOy1bzy0Pf2XF98FeL+D1VF0mW2
	PkNMM7V0KAorc60H9qMrSeL7yfaxWnug=
X-Gm-Gg: AeBDietUwFsGktTq5bfkoRXN3t61ISwRP4WrQA9ZtyIqu0z35Heo2VHn9FY2ECvlnY8
	IAyELEPLhMdf11d0uBxGy+ESz3qjIJ4piLyhtJLhuRK1vVH72Oi5O0Bxjk/zaRkqdEfFVw8uyxz
	K9dd9jrRtCXGrCgeD+NuZ5aXbYuU4xNhtxLdVQctgH4j8uQZhVKo23DI+0WfqSZcsMSkodG+5qm
	/rAE7kXkNKeWoatPmO1LyRgzKMpuZlWYS+iY7DSd2RJd4S5vlTSana0AgqDOKUzyarTMHjWpjFd
	YT/1z2TB
X-Received: by 2002:a05:690e:4197:b0:650:146c:8784 with SMTP id
 956f58d0204a3-65048887999mr2345797d50.54.1775223067525; Fri, 03 Apr 2026
 06:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <2261072.irdbgypaU6@7950hx>
 <CALOAHbDnNba_w_nWH3-S9GAXw0+VKuLTh1gy5hy9Yqgeo4C0iA@mail.gmail.com>
 <3036842.e9J7NaK4W3@7940hx> <20260403073055.031275d9@gandalf.local.home>
In-Reply-To: <20260403073055.031275d9@gandalf.local.home>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 3 Apr 2026 21:30:31 +0800
X-Gm-Features: AQROBzC0mSPveSQN9--WA0G0y_aVn1mFQhL-xBcxwejlBO_z72oaRKJrd1eJo-I
Message-ID: <CALOAHbBBf_vWcwZp9kdXhpFOq_oG87X-7Nj2yurZ6LgBpDHwwQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] trace: Allow kprobes to override livepatched functions
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Menglong Dong <menglong.dong@linux.dev>, jpoimboe@kernel.org, jikos@kernel.org, 
	mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, kpsingh@kernel.org, 
	mattbobrowski@google.com, song@kernel.org, jolsa@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, yonghong.song@linux.dev, 
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 7:29=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Fri, 03 Apr 2026 18:25:59 +0800
> Menglong Dong <menglong.dong@linux.dev> wrote:
>
> > I think the security problem is a big issue. Image that we have a KLP
> > in our environment. Any users can crash the kernel by hook a BPF
> > program on it with the calling of bpf_override_write().
>
> Right, livepatching may allow for rapid experimentation but that is not i=
ts
> purpose. It is for fixing production systems without having to reboot.
> Using BPF to change the return of a function is a huge security issue.
>
> >
> > What's more, this is a little weird for me. If we allow to use bpf_over=
ride_return()
> > for the kernel functions in a KLP, why not we allow it in a common kern=
el
> > module, as KLP is a kind of kernel module. Then, why not we allow to
> > use it for all the kernel functions?
>
> Right.
>
> >
> > Can we mark the "bond_get_slave_hook" with ALLOW_ERROR_INJECTION() in
> > your example? Then we can override its return directly. This is a more
> > reasonable for me. With ALLOW_ERROR_INJECTION(), we are telling people =
that
> > anyone can modify the return of this function safely.
>
> If this were to go in, I say it would require both a kernel config, with
> a big warning about this being a security hole, and a kernel command line
> option to enable it, so that people don't accidentally have it enabled in
> their config.
>
> The command line should be something like:
>
>   allow_bpf_to_rootkit_functions

The feature is currently gated by CONFIG_KPROBE_OVERRIDE_KLP_FUNC. In
the next revision, I will rename this to
CONFIG_ALLOW_BPF_TO_ROOTKIT_FUNCS and introduce a corresponding kernel
command-line parameter, allow_bpf_to_rootkit_functions, to control
it.

--
Regards

Yafang
