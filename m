Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF7B3C7DF1
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Apr 2026 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232059; cv=pass; b=eUNlVj+9pCNl1A8kmIdJwfl0w3tKt6FLQlU6A5WCWE9our8s3V86hJgdBRKCiTxUn25tfsiccu9S53mxYA8nDimyYNZHK8BmkRvt/EK0dhIQHRwffz/veH+AMuzMrd73duFXf1BZUoTVrWv1OIUsxO4IOs5ctOy2rRZTs1YoWsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232059; c=relaxed/simple;
	bh=4J8XcLhyQNpn4ct//tlB3JgTqU1q9N+kL/BF7kTxfb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGk/vjijo9sI/E8VUmCQZvFISiVF0LpEQW2C8iC/Me8zL0O/T9bcjLxKYTYW5YXZ4EdEb8mg1fCeQvRr/+jYJDhRLAQHHH8FNyqXB1nyRiAO6gcD8P3QrSNa681x2RyXoUeTmVNhyXrk7LBD81FVxEja2l7ZAallGPM8LjAiP/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1f5lNwJ; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1f5lNwJ"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6501c4857b2so1043630d50.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Apr 2026 09:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775232057; cv=none;
        d=google.com; s=arc-20240605;
        b=FAmoNkErh78a2Lst1W7cKWl0yKRA2a1WOt1jc3W2hPYYXgaO4B6pOV0K36uCKyfNqa
         Br5e4GxuYraXgkqi1K9rsOc0+Rd197t1e1cQlfi3zqnWryTQBKp4tPkkh9D9cnxIYkvc
         r4INLOtY8xmGwHBsHeGouqgOBRzKuIqItkQXem0PLZWJVn5YaAQwPO1mfKosFij5vm/7
         2pLE6Y5VQCqyqL4HSr3qv1paHMLFbq6pt06b0q9YmNKff5d6PlZlgwpcHjJWtjiP9A1p
         P2xdguQq7YDC5jommKZ0caZWytTszNZNkrvPIMGkB/66A3r4dz2BvLIGnMvHSsLn79wZ
         VNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=smlalJP6W4oXJb7plM4HOYk8mDYdhNOc9XE7DYiHv4c=;
        fh=83ye7qyfrZog/5H/1j1dtVp0jhFbdGyQVxdIV1HO5u0=;
        b=g3ZIAqFjYv5ZXHao4meU+jdA38cNt2VXxUiV52SFgrmQ/iC5neHmtjBBcCoTsbTwTT
         nuDF/Xx2pyyKlwESkmiZsEXRDylrMbuUoY62WZ3NbRjYgj0EJyfi3RQTOWQo1XSiX+yA
         FySEbYut9WWqnkphCZVGRa8SjUCJRvzb9GCLczRznUpX2Oo1bvf7IXkhfF2G0/2Jcrg+
         HJPQND6cL7pmcH38kaCUNye6dyWD31Y2YQuvjAKsa51UzbpU/UNnsYyPjJ/TaygnkYsk
         vSZO87gbyBa9yR3QKwDTXm9bN0jsLAQRg5TV9tpZ0UWO6oiLutLfky7Xqfc4EyB6S+X6
         tCtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775232057; x=1775836857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smlalJP6W4oXJb7plM4HOYk8mDYdhNOc9XE7DYiHv4c=;
        b=a1f5lNwJiAm0TGs+sEWU6QfG2WtDoFox/x/qmgvsumuMWIYC9S6+T/cIQX3T1Y1duX
         lId1pWuHWQSyO9v2RgjofvPo0/vdceanEvNpb7zVV49TLxz0HqqW12CpxNV8z/rKdMME
         5j4+5pcx83XncSRS09GllTtDVmiZRq+TJUOf+Vqi3ZKMkH2WfTdXit4m1T+Cgp6dToHK
         ZJ1NTfsLmpFsosakca71KXC7iVl4ex13VfGLmDRsEheEnfwacl8mn/Egl8rEJQpWuxSA
         GcKpHHzuhFp1IIMxa8rLvEnvOVlu0Ro6huIEh7Pm7fsYRv4bUb8dljHYdtOfKRO8rhnI
         nmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775232057; x=1775836857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=smlalJP6W4oXJb7plM4HOYk8mDYdhNOc9XE7DYiHv4c=;
        b=mdUlE0iDnUeR98AjDwMFC7syioyS4Yb+vGb5OfPIH7U7oEx/U52gQXoiYTWT3Dsa2q
         UAT4xVAyXCg8hzFu0Sf39iqDx8HCNWDmv7gc7MQ8rZ/LtYVvYd6FJumVgAPstqh6amEk
         4DwNKoG4Y0yfr+kjl9UGYptZqAaBZQkCBvPPFY1jVh5o6LjEhfpHuPQAQPgmEiqCNpPh
         iJdupEgsOBJ8l0lPYH4zJNx87MW4/2/XsLJQU3pJ3++SiV4sFV2RvWtsmdD21zI0WFx5
         fZWwsSM2HodlNGcNhOJlbwK5HTu7h75sRUvTRdj4yiqzjREx2GInkkDi7eHOdNN1QcO/
         7SUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYeauPn66E2D/D2p3SgoQPA3+9ql20EZBQ7+rPi24XpAPlV7pa4N8TvM7NLAwGPFNm0CrfgTU2RYC4c5l+xfnqffw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNtNBXWbgtpcc1Li2fK807sh6OQxmFMQ7xqu7RUBSVHotcNKca
	WEmZpvV6Hyl024088HstpqLu19YydHSj3gVTdHZnY/eXcZ78ZRDiZyZud1k0B2kRVbpEBJ6KuOw
	pHozfctQLnPth3D/GdpddfZpjHtBN9ec=
X-Gm-Gg: AeBDietvYA9AaNeof+qBsEdx4j6cfWHIcbMTXPBHiyBlx/JnxA/7wPU8HMqSC4DREIh
	j2BV8lSablqbJbyiSkMP3Sp0iWYYQOSPdQcGZ6g/AF6hTudj6/jq/BwgeUE1qBnMEzsKztfkLWT
	uQPj0eKotUZY4O86moMBwq+qq4wIMVVELQi8ZPOypnJdaxwtB6zCEU4baKr1+SuX7WfjaaZfae8
	zEso7T9bly26BENj7ELBZzRGmFH4lTc2OAvUmZfoIpLjzTSYj3jS84m+9XASnqdTJ98QWQ8QBVr
	2nRx3TDywxzVFuTIHqUHD+aYrsiJOSm7o415TO0=
X-Received: by 2002:a53:df06:0:b0:650:b0d:f4bd with SMTP id
 956f58d0204a3-6504874d4e6mr2666334d50.24.1775232056866; Fri, 03 Apr 2026
 09:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <2261072.irdbgypaU6@7950hx>
 <CALOAHbDnNba_w_nWH3-S9GAXw0+VKuLTh1gy5hy9Yqgeo4C0iA@mail.gmail.com>
 <3036842.e9J7NaK4W3@7940hx> <20260403073055.031275d9@gandalf.local.home>
 <CALOAHbBBf_vWcwZp9kdXhpFOq_oG87X-7Nj2yurZ6LgBpDHwwQ@mail.gmail.com> <CAADnVQJobMwH8Q0LtCrwbD2TkzFaLfRaw9gyVnhDpMWGmLFVvg@mail.gmail.com>
In-Reply-To: <CAADnVQJobMwH8Q0LtCrwbD2TkzFaLfRaw9gyVnhDpMWGmLFVvg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 4 Apr 2026 00:00:20 +0800
X-Gm-Features: AQROBzAveI_l2DNpt7U84Ib2Mv4Qw04LElhCVGE816Jd6EhbLPSjW1ZrRCTxVQU
Message-ID: <CALOAHbAiNQaVYO3WeNvUBzw+4zAM-ZjgxYWKX5e_0Fw+KX-ZPA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] trace: Allow kprobes to override livepatched functions
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Fri, Apr 3, 2026 at 10:26=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Apr 3, 2026 at 6:31=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > >
> > > If this were to go in, I say it would require both a kernel config, w=
ith
> > > a big warning about this being a security hole, and a kernel command =
line
> > > option to enable it, so that people don't accidentally have it enable=
d in
> > > their config.
> > >
> > > The command line should be something like:
> > >
> > >   allow_bpf_to_rootkit_functions
> >
> > The feature is currently gated by CONFIG_KPROBE_OVERRIDE_KLP_FUNC. In
> > the next revision, I will rename this to
> > CONFIG_ALLOW_BPF_TO_ROOTKIT_FUNCS and introduce a corresponding kernel
> > command-line parameter, allow_bpf_to_rootkit_functions, to control
> > it.
>
> No. Even with extra config this is not ok.

I will send patch #3 and #4 as a standalone patchset to upstream the
hybrid livepatch first and then figure out how to move
allow_bpf_to_rootkit_functions forward.

--
Regards
Yafang
