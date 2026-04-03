Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FC73BED22
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Apr 2026 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775226388; cv=pass; b=ksKPfHi9sUpzz3yhY3hZPPLqKmaVbawkugJ4cIK0p+AGeTqqLjifb3sF6iRiuHgvv3tR9vQUuS25/XpsCrmBtCc0TGDws9I3dqomoxl+lOppkmGse0Di+0m+xAgLxcFNIL0fF26f9m7HlLq7MWJVmJbDXpv+DGu0pc6vTJhBAqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775226388; c=relaxed/simple;
	bh=aTlV4pdjF0A3x3G2ruVJgTbo99ALv2Bdf7K5KuSGaA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjlqSPAeS+OGDbA2Vu4A/PMFjxSWEE+mZ3biuFfBN92Mxt1Fy22iLhJjlVBLOI40usPVvYwIcH+d9eZ9rrwWj0pV7016tm1UlHUG2ePbIfrnMPaBLLGB5qZJrOJTZdag0KMnGwDJY+XNmQgqd1tmJBgQCoFBA9T2DDtK5vHrYrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyWNstTk; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyWNstTk"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b949bf4easo2095315f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Apr 2026 07:26:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775226386; cv=none;
        d=google.com; s=arc-20240605;
        b=WymPcC5aySP+fwwkH/Xo3mneeIKNzm+lbH/AmvkRlyV1iD/D2pBAlrEg99IQBNyTjj
         WvHv7jLzgXirUWeQ12Otf1rH4c0zHFcyE9GOgTAz1UiHCj2/32UuVeV20SSHbyu8uo4E
         XPa5WYyYrwLGwXnIDBjVu42WBCXtm8a/z90FzibuIFWT2c9pOxCuN9s7HD7ROLym0TSj
         BtDewXM1bOyNU2TETbr2jH6mQbvUgUaWnpr4kX+RvAfswq8EDV9B5h/I7K2QRm4ZoFPz
         MJ4/6ZS4ElGzIaYEluYtKNv18YWgjobCJfXsJirpd+O2U8Vo33pHXZ8O/DM0EARwIFFr
         0bQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EQG9ormSZqinIg4NJRtHRTZzS9AQV9/8RBCkndY0t44=;
        fh=QZuExiUI0P0CDwhXr62ZkglFXL7cQoBgzC7bk07RA54=;
        b=Zh74n9uNvKG/x1E+SWaLjxHwzF7BjzvZSOlM8p0MuJouwrHimz/oqcxpc1jcfh/WZq
         U+LcipAu/8rXo+7Gd76/FezyYxce8to5Sh21zb4rYq+oDWXGE0mmqIXUM2mcNgQFkSgt
         bYKBwpM4LFmGnXGoEoFNI8RSeJuXtKS94Fs0y5suRcQF160cdMkUHdDzCUH0OYi+XzEu
         p2DSsEZAPA9JfOTqJlgJR/Mu6I4SRUm4ccKdAPLd3vQO+SM4BDRWU7DIkXKyo3e2B8H8
         EoPq4fVuhfa25oasPZDoP48KT8YBlMtR1fMrJTntm7LQVimZwyf6CtSiZaA4y4NazISL
         goWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775226386; x=1775831186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQG9ormSZqinIg4NJRtHRTZzS9AQV9/8RBCkndY0t44=;
        b=TyWNstTket7k93kf2CSUZNM3DacCpy86gyKAGSleu8FB3WkuZ8QpXceC3hGg+tZOv/
         pTMNrv2ld/xq6G9W7jDoLNvc/e5DHI2eZj+8wtFXF9o+49AdYy9TdHxHamlvUhtMT5dg
         K3F96DNamKnOjz7Jqpydy7AZtQJc6x7BdyL0JbFpY01mnNfSN10Ron3HEr6rVVr/c1lk
         G1jGdKOMByI2giCQUaVPrNw1s8KvwTdNWhgUK/puHhk8QpIgbWKI39LXTpfFtT1L3ucv
         CE0lGHMbkb5TS6fdnkmyUZecsP+lwS6qb0otlp4T4t4c5bXtGtJ+QsVYLnxd1hduiaLR
         K2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775226386; x=1775831186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EQG9ormSZqinIg4NJRtHRTZzS9AQV9/8RBCkndY0t44=;
        b=jnxnLNP6yHlpxV5FaviIG7F7BuAuqVx9Fwjr+gwv141t9UU5nDskpzBcwaacYJrQ9t
         ujIloRjL0lOnzz5oloKRki3pLFvzo+0G1uBj+2r+999L6NoaDhAXjLQFVqdOfDhPGwR0
         Tz8SdBwFXJpS3vyRWl8CssZNNINrz8E7NNCXnz5mKiRuGNojumjW+Xchlx9NM/iw9Qe/
         Q4lxR130y7jczaVrB7woJwzzMpMs/U6QslWDtg81LSXN3mhTZp3azeF1/UyfxfA/2Fmr
         csHOIdwyNKo5QIXNYf5FylVzPa7Fk/ZC4OZNs6MczEW9YwXJzdj76ZuLsGBAMykaR1rJ
         o5Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWfRGIdZOIggcI+UHDv77+XfJihPogW+itei0TYqs/4hrfWA/MMVT0aC4hd0KCXS2M0XAeGwFpjWoPOMlTSmmp5ccA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4VFY+1hZNTMfeAByGmaf0fyh3yEim1jBbjXYm3m9kJh2q4n2F
	ZhIbwh7WpoSpKSUyUoemySFSowDra1D2JFXXJX+bfK+ibmGxg9+QWkMVmFIfHPtYFc0ew3tvxoG
	DbafOi5ZaszLWsmG8wPAmdrhg2C6s9BQ=
X-Gm-Gg: AeBDieuKRYwTQImDrlGbukYzW6qR1Fg2LLyYfW1DlGfCGyMxP7mDA4NMYVeewgn+8kF
	wmYL/NodnpdC0XVOHXWX8LeMakDNTixLGyELXzt7HqLnYSFupDeFsW9mmTLfbGSygj+8I6Z/ttM
	uZ8ejY/XL2Mr0YSazOIPpe8M1nJCfY0619EhPWc4Evg9zjGsxbOssuvOIl4bqOw+1cXaaLi7ety
	BYTiJIeykGjhFlc1atGusjtq7j3I4b5afIeA9bVff1vl//rdAMgmUcrEOqXPxcnY2k2o1x+wF+D
	mZ9Wr9nWqNoRtzdudhGwiqG6LyProrptHU6NTulCehcvu1HDXemNibw+Mp0fsmsx1f3w02UxF2K
	KTJckkPOFpkDQ8ji92STYl+Fn+A==
X-Received: by 2002:a05:6000:25c1:b0:43c:ffd8:e25a with SMTP id
 ffacd0b85a97d-43d2115ae92mr12434422f8f.5.1775226385615; Fri, 03 Apr 2026
 07:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <2261072.irdbgypaU6@7950hx>
 <CALOAHbDnNba_w_nWH3-S9GAXw0+VKuLTh1gy5hy9Yqgeo4C0iA@mail.gmail.com>
 <3036842.e9J7NaK4W3@7940hx> <20260403073055.031275d9@gandalf.local.home> <CALOAHbBBf_vWcwZp9kdXhpFOq_oG87X-7Nj2yurZ6LgBpDHwwQ@mail.gmail.com>
In-Reply-To: <CALOAHbBBf_vWcwZp9kdXhpFOq_oG87X-7Nj2yurZ6LgBpDHwwQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 3 Apr 2026 07:26:14 -0700
X-Gm-Features: AQROBzDV9yg9kswgmI7b9-0JLFkgfn3BK6Co2WBzJ6xPcvBEERBNPVdO--RgW8g
Message-ID: <CAADnVQJobMwH8Q0LtCrwbD2TkzFaLfRaw9gyVnhDpMWGmLFVvg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] trace: Allow kprobes to override livepatched functions
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Menglong Dong <menglong.dong@linux.dev>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
	Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	live-patching@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 6:31=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> >
> > If this were to go in, I say it would require both a kernel config, wit=
h
> > a big warning about this being a security hole, and a kernel command li=
ne
> > option to enable it, so that people don't accidentally have it enabled =
in
> > their config.
> >
> > The command line should be something like:
> >
> >   allow_bpf_to_rootkit_functions
>
> The feature is currently gated by CONFIG_KPROBE_OVERRIDE_KLP_FUNC. In
> the next revision, I will rename this to
> CONFIG_ALLOW_BPF_TO_ROOTKIT_FUNCS and introduce a corresponding kernel
> command-line parameter, allow_bpf_to_rootkit_functions, to control
> it.

No. Even with extra config this is not ok.
