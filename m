Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795584921;
	b=HZbERQAe2x9XLvFsHAUnln26kj1YtxQOI+R+slMOPcUiT8OuisMy5/S/VhRFiCTQg8F2
	 Tw7hByxOnSpKXV1OGcruAn74W1+x4T5QgP5KyIr8Z50Fu+nKCIQibOAg4PQhOKlAcHVD2
	 hJTWvD06mRibje8tupQMB91/BglHjZG39ubgrr2rbKj2sbRbyyVQF3+ZULoX9FmOuHA0J
	 84aabvnzsdymEf6KJ7iIymuB5Kbyv+V3HV9FEI2DkibiIlthp5JDi5cxUTnxdCwFXWq5Y
	 +AnJyBOTMSVIqi2YJBG3sUMA3IU+MFcpfpPf966iszXr0gm9E2Yk9YJwuIl+zaqyGig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795584921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DIXlRqv/2z9juZ40YrnkT5CgsYY3lUKcwDePl9HeFiQ=;
	b=JwswWCZs7Ix/Z7LZJ5qZfgP75981sK1FGT8rGiDcjgf7umTg2gRADuFYwIeZZhn0WXEf
	 K0UWYZtk8+aE1ZpJIWvd8DbisXW4lCi/sPz54M3gTYe8z8vEDbYBtKMh9LTTLLJL6RHhQ
	 ld16nFzmrMdTC2h9M8a+HsAsH+xs0WN+KHZCgIcynu27gj0pnaDLlHRrC+/dkt4b3liiY
	 1PUTbN/hKgKZBmD1wQIbTfw/Lluxh9yP7+olS1GlWoPvJP+fwdteVKgRH/Dm1TSqAPRHs
	 qBwXd8KT+pjHms0vd95Ulm8qpEnE7NT4uzHxR9bBU47uNhoqsgt2VhylvxCSEUEkoVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o9EY6P+m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33320606A31E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 05:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33320606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o9EY6P+m
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4a9be758734so3312353f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 21:35:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795584919; cv=none;
        d=google.com; s=arc-20260327;
        b=YA6v80713KywS2CIN0oXJjDsZSkXbbQ0iusbrmUO/iKP1uB3+pOPLo+fByU1y5WNOU
         0sZIQ2u8Czy9WRKIAuwo6Azwq0EURIrGJLyqCG0GP7P1S5JYdCI4hR6eJBauB4Kq0WE1
         WipY8+QiLnHmwekCVM3NPU74LmZzR+C9194+JY87iKT5VqP3wgre2FwgOr+fz4gQOxh0
         /JtXnSu17xqZZEDynsF7r3ukrRtemMs+MwMoI8uCUxBxYXPQoSnerd88Rubj4N/CBCHY
         jUeCvOoqGdVN/xiM7+XpA+Kadm1GKZdQ11XKDKtpUQ0aVS933GpGM8H9GtDM+NSXHJaF
         A70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DIXlRqv/2z9juZ40YrnkT5CgsYY3lUKcwDePl9HeFiQ=;
        fh=OyMSudAFCWFrl8leZ5gVllDZ/J0hVx7WGlVBjKTjTXM=;
        b=LrgAwFNPdvY1F8RddK2uWCq59uRCbGrit3zcuH0dwRuJvISukpdH+GJOXFHXqxpk4Y
         KO0IPexeAinNnGsjfajr2cC62hLOvd7D/S+EZDArnBZUjbEv10onIEGFiNOp5TURHuL+
         orLJjICaWwDdNX4CadyOQZnTJb5gvICH+bB4v/R3D0B4CVm27k7YGwqKB+5sPXI/V1JY
         Cga7avj8c201OwGPqexpTJk8dEqKUTfPplh0003xbWWd3Iu6heSgXAc8ZAtj9xom7+ZA
         GX554k1L16wMB7wcAK8S5Zk30pVI/8mT4oH17gfgQNuLJV9kvEdYzAXJbnpUxdpnb10e
         JsBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795584919; x=1796189719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DIXlRqv/2z9juZ40YrnkT5CgsYY3lUKcwDePl9HeFiQ=;
        b=o9EY6P+mlgR+Kct33Mf3oZ0z1Oc0os21EYW2QyzW2/KNaGbvnLvNQ8sbCG5zDp9ueM
         u74Zm24oxxRQMNK8hqfFaWEdJFH0cN3a1TcZczjJ+aIs34Nsl6I4SwyHwsjmQQ9F0x+J
         OK6h9X81phhEYtjBsFd2navN8SjSL+p0LFwLU6L4ln0fwBt3dCRFnn3mfiHM6Km9sSgH
         JmscklCVftyGv/9ZF0tvRlyZkOao23jFBabCKvBC/8mdzxVOGENVkH3HPv3veqfyKrdW
         J9O+RFR7TCiRwUn5t+45pLuktAgdua12wVTdocQvIPwTjpkpwZIhpwOLoTqMOz3yzhLQ
         ERjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795584919; x=1796189719;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DIXlRqv/2z9juZ40YrnkT5CgsYY3lUKcwDePl9HeFiQ=;
        b=fwhFcEcS09XRWwxNDIPG3pCpdA11MoYc8Bu64pL7aacJrKs+KqtldWEnsrJiDLdVpR
         ZnReidAG+9lP3YZas6DTcOyjfNpOmkHmJroWj/GRy9KIXqHZtnnYA294MQyv6JIxAdbE
         J5f7TlheQ4XiCYq2HfmOw3jL1rjnZtZ7ySCz40z/WQQIPd6P+2i9f+g6zj/1Q6pnBSCd
         SQZPJRGp0pBR/frQzN0P0x2ZQlunrSRrnZIoTLlosUOyG/gVC1wJfBq+1kEI1vej3SWP
         Zkq0BDmbQ3ExEMxeVtuubb8dNfVowZhBmx8lRulH5vVf2YOOBsBPy1bcpkkBn1D17hcp
         lOxw==
X-Forwarded-Encrypted: i=1; AL+hErGuvftKc3lOpzgeS05RIcZUt2HZwd/BUZSvS7UKTqghzreQn6IUAfzdJKVZu4/PekCn8CetFd9Sh4F3hjTtiIKnkdI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+790Rp8QuqNe2px2EqSTK0dHo7r9gn0zymAhMXqsXsxwqDnmT6
	6dH6NsOeCY2PlLBmXHFSBYl7dAOZ7qB/jdQF5ouxWBhIMLWrjZEApOIQkUe6Zc2QA7yjtpws4+B
	oByFDFTYnV15Ujd19OXESD9wUKlnk0M8=
X-Gm-Gg: AZFdTZc+1lG3J9ZIHrBfAgQh8MTeHEUuu6p0whqrhpRvb6mxMp5FHKAn7MD4K/zeTjK
	KWH0qgyAPDqv41rBYCOWwpLC69w4UStjbEGJddhK6v6AAscV6mAGKK1HyonGfRrKI2susGwIpzJ
	RAcCiW2zp2Sbk0QLARvM7lruW1KP+iTTaXk6Dm17eqQ7AcrakTmAOgvGPHn5y7Z/+QYomPNGlnx
	NcUGqDaZiK7b/VlZRc8X+sRKN5DMIejwFvRV5mYu9xyMPBws7OrdmZjLzrUeb4ak+E4YUyIVs1P
	bAOU3CWdgBJ0nim5RyxjzbUoe5LQ4fHvzfFp4zo1wa4m2j9+SCOppggFN1DPKqhXAZJQc8uT//B
	WFecsO3OzZINCJFM+hzfDwkuMRmi6QmDEDMF8nEh+E3PBRyvQ81Fgg7l7e40ciLV2LN09ir+sXs
	PFa54btk7yNMNJFHOXUmZgME9DoWwkEuH7QHeklU4=
X-Received: by 2002:a05:6000:1788:b0:492:3176:3d6f with SMTP id
 ffacd0b85a97d-4abb400aefcmr31101621f8f.47.1795584919374; Tue, 24 Nov 2026
 21:35:19 -0800 (PST)
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
 <DN38312WXPDJ.2KLUTCWSDFL3P@gmail.com> <CAEf4BzavErcSOZhGobqEo68d+2bCnJ8vFxxT_vqb+oQw1j1d7g@mail.gmail.com>
 <DN3X5OIRXSWR.2Y70DWFMPDXQF@gmail.com>
In-Reply-To: <DN3X5OIRXSWR.2Y70DWFMPDXQF@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Nov 2026 21:35:07 -0800
X-Gm-Features: Aa3M54pxoPCdtejSbeLTFS7uA2H68O1zStyUPispdlpA_6QwbCBs5gPBT8bsyj0
Message-ID: <CAEf4BzYxBM3R1s6XDSpN5htzMho4Jp2uBsx9ZBKTPNBvmEffxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: mikeba@sentinelone.com, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	JP Kobryn <jp.kobryn@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 6:00=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 24, 2026 at 01:47 PM Andrii Nakryiko <andrii.nakryiko@gmail.c=
om> wrote:
> >> +       for (ctx =3D old_ctx; ctx; ctx =3D ctx->saved_run_ctx) {
> >
> > do you mind checking if unlikely() around ctx improves performance?
>
> Mike,
> pls try it on respin.
>
> > So basically to opt out from this behavior BPF program would need to
> > stop using any per-CPU maps and just implement its own poor man's
> > per-CPU storage?
>
> poor mans's per-cpu with bpf_get_smp_processor_id() shouldn't work
> as an opt-out. See section 6.

it's hard to weed through that verbiage in section 6, are you
proposing to mark "needs per-cpu protection" if BPF program is calling
bpf_get_smp_processor_id()?

>
> > And even using SEC(".percpu") would still be detected
> > as per-CPU usage, right?
>
> This one is pretty much brand new, so there is no data to make
> a decision. I can see arguments both ways.

.percpu is backed by PERCPU_ARRAY, so we don't need any data to say
that it will trigger the protection, do we?

>
> > Should we give a way to opt-out of this protection explicitly while
> > still using per-CPU maps?
>
> After looking at the data, I think we shouldn't allow it.
>
> An opt-out is for a prog that protects its per-cpu data on its own.
> In the v1 thread your example was stack_trace_scratch in wprof.
> It doesn't work. wprof is broken today, without this series.
> An event gets args or a stack of another task. wprof 8dd41e18 on
> bpf-next, corrupt events / all events:
>
>   -U                             what's wrong  lazy      full
>   -----------------------------  ------------  --------  ---------
>   u:func (arg:0, arg:1:str)      args          1928/16M  9111/17M
>   u:func (..., stack)            stack         683/15M   3419/15M
>   raw_tp:sys_enter (arg:id) and  args          3491/48M  16673/44M
>   tp:syscalls:sys_enter_openat
>
> utrace_scratch has no protection.

yeah, I was lazy :)

> stack_trace_cur handles nesting, but not preemption:
>
>   task A                task B                task C
>   idx 0, st_cnt =3D 1
>   preempted
>                         idx 1, st_cnt =3D 2
>                         preempted
>   put, st_cnt =3D 1
>                                               idx 1    <- slot of B

yeah, this is true, just a stack-like approach doesn't give 100%
guarantee (though in practice it has been good enough so far, though
perhaps I just didn't heavily run into new preemptible kernels), but a
better approach would be to use bitset + find first unset bit
approach. I'll play with it.

>
> With -S offcpu task C is wprof_task_switch. Then the utrace event has
> a record of kind ST_OFFCPU.
> uprobes have no protection. That's what an opt-out gives to raw_tp, tp
> and fentry progs:
>
>   -U, lazy                 today     preempt off  opt-out
>   -----------------------  --------  -----------  --------
>   raw_tp only, args        0         0            2849/45M
>   raw_tp only, stack       0         0            4081/27M
>   raw_tp and tp, args      3491/48M  0            3166/54M
>
> The series doesn't touch uprobes, so wprof needs its own fix for them.
> The default mode of wprof, without -U, is fine.
>
> Now the bigger question: do we need preempt_disable() at all?
> We do. Without it progs of 17 out of 69 projects in [1] corrupt their
> data. 12 of them have progs that are clean today.
>

"Can corrupt in rare circumstances (in practice)", but sure, sure :)

Still, choosing between handling all events and having bugs (fixable)
of handling per-CPU data in my BPF program, I'll choose the former.
Even if we don't want to make that a default, that's fine, but please
at least give me a way to opt out from the kernel's
over-protectiveness :) and not using per-cpu maps is not a way to opt
out, it has its valid uses even with preemption. Think about simple
per-CPU stats/counters updated with atomic operations and aggregated
across CPUs in user space, periodically. E.g., I believe BPF
selftests's bench uses this approach, why would it need preemption
disablement just for this?

[...]
