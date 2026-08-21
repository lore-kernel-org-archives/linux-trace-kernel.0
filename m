Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511AE3126B2
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Aug 2026 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787334393; cv=pass; b=C4ZgcxtCQDbmNhVWJelw11T5xPAuKqTZJIXFHA4I6qPLR+GqUCQE9ss7bG0FfFuq0aspTZsuzueyYk+JCVR7kpYI8JrsjbEKOfcnm3QOlzEO1b4L12SuZRf9op1qe6Dxe1e1gtlH1/tA3jNZQhwhnbyoqTTymGBXoIBJ3agQMEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787334393; c=relaxed/simple;
	bh=N1CqxOoc6U2kU5znDg7gBtNDaZLRUzOAxkKRKjyq/Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4t+6GXdxCBCL8B2uQtRdkcur+PlT5Ooim6ZuS6HlEykajor+GNeSwVYjppcJTeo8+3XHsxjDv/H5nP7044/mR2Zntc7mflE4ZXLfbRSQWVx4xw71NHI4VJPCNifKOEUR9zTYJxTZAsv3C/B/CJo46mj/idJdiVPpze8J+C2FZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiCQMsy0; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiCQMsy0"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso986909b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Aug 2026 10:46:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787334391; cv=none;
        d=google.com; s=arc-20260327;
        b=FAtRhGSGgJy2MbJvvP7YDA4+9EGjfk1+kDyNbdDqlBsVGm63TdVMhDfbvZEzl+dMy0
         gsbHTXtoZ//PMIOs5fyhMhkKq5R6b06sfhEZomgy36yDTdBm6dTL1DPs//tH4B196jQe
         3Mj8ZpvtnxLd29FVv1rQlSKaJ4buR10cEcs+8yxG8K8f3mfce8MfNam03DzdqMSCydNI
         fdoSgaRkB0HCY2qaSpjQbO15penYB7QiX2Y0XP9LtbK742vlJ3cWJ+QwBT8X11zCmLAQ
         MzhaGY3BhP0koNERVey4dlZw1BsNGKIqXmFi4tqvOscj661w0REGg2tWoTKXUpzkozHF
         0/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7dUZE8HJUuZFjgDPUW4CLHxeTqHrJZbnD3PitORWMx0=;
        fh=ECTwcc4P0eTf/sphH0oJdcfIVUmjAzF1oTD4p/CeTJw=;
        b=njY7H/MU5QVbGfrsp5bHg5PN1UC9pGbB/8ac/l2SzFriuIfPXpMQFb79VpYrVFYRmE
         I9nqGvXHLnUSjNCmq35e7GbXcr6wr4QBDFzRtpewT+D0A2oRI0n8Hhw4doMiulSQ/buA
         97/IDTiXgLtzBFdZOrV4gaod6c09g36X5UmRj09sa0KEyYwjg8ZxlUeIVcjybMbvmz2S
         kiH5Pzz9/QfTlkpFIiDwsat48NDnVflXzCfa8sJ6eFl3j5o/u1N9aMGKnXANfFtisQu7
         4voNttNt137CE1IPCIJVQ1Vi+n4Xn8MHyKsx387UCEYKWBC39mc/Ph2h3XmZtOiBODIi
         gJcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787334391; x=1787939191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7dUZE8HJUuZFjgDPUW4CLHxeTqHrJZbnD3PitORWMx0=;
        b=GiCQMsy0WC1QiA/N/HrQL6hJSwG40uF0axRlVsRJt0VFtw6l1/4k7qrSdTfh2sXM2V
         NIN8T5nsX8kBThuXAPpKbw0i7lhZhq634EH4KVM2oextFbY6tgc5T4nLiGH7uHfyVSuJ
         4RBu6zM7/7S84OTYP8HeD6vn6LPmdi0FO3LmFod85xwD+SqOmBo/CGUiHjxFZSe/ibEg
         thwLRvjGK0bm1rf6O0GI4XAr+Od37OzfEJcffA8/I6RRGHilWMobqq4hk/jTU+1hDy+i
         /1WVy3/Sz+aOyMe9wG9H92C3wFyKlSYrFHgxtEoD2T3MWAW1j7H3zQLQZD4c8aDD51Ww
         rAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787334391; x=1787939191;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7dUZE8HJUuZFjgDPUW4CLHxeTqHrJZbnD3PitORWMx0=;
        b=UYA7r+wdvbptQeCRh+EkDNh/0A6xfobf0dvYB2inZX2fEnX7DGVISzfLfPU4zlOpSY
         +TEJXEifrUpnyl+fG/ZPuHAyrc4nBgLnotR1//rghEl38qIriMboAMv+TbC0QtqngLMq
         za5WmqVBOxtvOxcnZKbDgmTE5IXpbV0pXENHd5HS5FrbpuxuMB7ZCVG+kWJgKeN1zrnQ
         ZegYL06+3M1/YcHwIlfOayavoi3SKpqxKR3+OQ6J9rqxHdbYE6VFe3vnMKarAm76FAIQ
         1zVsAYcoOsvKTNe6lonuAodkdycTExsqGbcNNwGu/HfnX2b3MBYfCfVTjYDkws3f9TQ0
         7l+w==
X-Forwarded-Encrypted: i=1; AHgh+RpJ00b47ZN28ybql22ekOC35dhZYvspZFm10NDDa+uzZyjbPw+Jr4TXKIhhRBX3seBAK4DXtLJUzEdRa5ArvKlF45E=@vger.kernel.org
X-Gm-Message-State: AFuF++kl5iVEbbSi/N39ZDyVDU3NvTMPAZ7Nv26sgOMSQQb54y2kMe09
	p6qc3eyuJCx59Tfu/H8mDaRPvj6YNA7vkKADYuxYlu+V3JuGEVI7C+0e/xt+iNV1Ah5pPeiz7Ez
	1iBSAxmaGjIDb2NDtl5wYIBfeUCeYqJYmyQ==
X-Gm-Gg: AR+sD10ikFO0jnlB51LgeRzUw+q7xFfjuKqgplPSzQ2b7SN0y9ro1cgzfQmcELI8MJO
	Sn7F/FZVv/kvfKFdJjzX2QJlv3c5teIrwHmuNkgqsGoC16a/dlMKegxT8je76aJK39/xDR5XM2w
	TvMf6j9QKOU6P6fVao+KX7x60VOp9chzBwe+CS2jqgBQN/PGPmqez5lzFkeFtqa4Thu0NAHN4yF
	pAd9PjpU+acHLfj/tR9LYMltAFseqigmAnLLMkJSRNuO+/GL7DYOBqMcQ8xaqCyWFIwMBeSDTNm
	ASw9qPyraLP4gCYu1e3b75AYMFZeLAmEByWIvcfUqCH6PwWVe89Z7pq9KpT9ctEiHSGCBrpZJgc
	pjC+wvk6vqgtarGn1ay2Bj8xulg==
X-Received: by 2002:a05:6a21:6010:b0:3c3:f371:1ea9 with SMTP id
 adf61e73a8af0-3cd3009ca00mr15085565637.10.1787334390580; Fri, 21 Aug 2026
 10:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809150111.45000-1-leon.hwang@linux.dev> <CAEf4Bzam=0V6n4_vBahhYh2Qn9KfriDKXSz58L4L+teHJRWfPQ@mail.gmail.com>
 <0b30bc97-2ecf-46eb-a863-94e706e18c6b@linux.dev>
In-Reply-To: <0b30bc97-2ecf-46eb-a863-94e706e18c6b@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Aug 2026 10:46:18 -0700
X-Gm-Features: AcwNN1Xg-yG0Fv7ODt5_iE6N3PFD76zwe1BQccZKRb-mklj66Zkk_VDYn1pDVc8
Message-ID: <CAEf4BzaXaLLqs6XXCG_02c7UcvNWfbGUAJTYosr22oaD4iokuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] bpf: Add tracing_multi link support for
 bpf progs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Avinash Duduskar <avinash.duduskar@gmail.com>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Amery Hung <ameryhung@gmail.com>, Jordan Rife <jordan@jrife.io>, Rong Tao <rongtao@cestc.cn>, 
	Eyal Birger <eyal.birger@gmail.com>, Pu Lehui <pulehui@huawei.com>, 
	Jingguo Tan <tanjingguo@huawei.com>, Lin Ma <malin89@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 11:20=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
> On 15/8/26 04:14, Andrii Nakryiko wrote:
> > On Sun, Aug 9, 2026 at 8:01=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev=
> wrote:
> >>
> >> Similar to the tracing_multi link support for kernel functions [1], ad=
d
> >> support for bpf progs.
> >>
> >> When attaching to bpf progs, it must attaches to the target by text po=
ke
> >> way.
> >>
> >
> > Please spend a bit more human effort on justification for the change
> > and explaining your use case. In what case you'll be attaching to a
> > large amount of BPF programs such that attachment speed-up (if there
> > is any) matters.
>
> Will update the cover letter with justification and my use case.
>
> Here's my use case:
>
> I'm planning to enhance the function-graph feature of bpfsnoop [1]. It
> will trace all bpf progs, including their subprogs, to draw a full
> function call graph including bpf prog call sites.
>

fair enough, interesting use case, definitely outline that in the next
revision (and provide before/after attach time as well for such use
case, please)

> The attachment could speed-up when there are hundreds of targets. For
> example, on high CPU core count servers, it probably runs 200 tc-bpf
> progs as Kubernetes CNI, and each tc-bpf prog might have 4 subprogs.
> Hence, there will be 1000 targets to trace for bpfsnoop's function-graph
> feature.
>
> With tracing_multi link support for bpf progs, bpfsnoop will be able to
> attach to all targets quickly.
>
> [1] https://github.com/bpfsnoop/bpfsnoop
>
> >
> > Please do your homework. Generating code with AI is easy, reviewing
>
> Sure, will do my homework.
>
> > and making decisions about whether it's the right approach (and
> > ultimately supporting it long term) is still a human process, so let's
> > weigh that in.
>
> Will keep it in mind.
>
> Thanks,
> Leon
>
> >
> >> [1] https://lore.kernel.org/bpf/20260606123955.345967-1-jolsa@kernel.o=
rg/
> >>
> >> Leon Hwang (13):
> >>   bpf: Initialize ftrace_managed in bpf_trampoline_get
> >>   bpf: Factor out update_fentry_multi helper
> >>   bpf: Drop unnecessary ftrace_location() in update_fentry_multi()
> >>   bpf: Add tracing_multi link support for bpf progs
> >>   libbpf: Add tracing_multi link support for bpf progs
> >>   bpf: Add tracing_multi link fdinfo support for bpf progs
> >>   bpf: Add tracing_multi link info support for bpf progs
> >>   selftests/bpf: Add tracing_multi bpf prog attach test
> >>   selftests/bpf: Add tracing_multi bpf prog attach failure tests
> >>   selftests/bpf: Add tracing_multi bpf prog cookie test
> >>   selftests/bpf: Add tracing_multi bpf prog rollback test
> >>   selftests/bpf: Add tracing_multi bpf prog link info test
> >>   selftests/bpf: Test tailcall with fentry.multi
> >>
> >>  include/linux/bpf.h                           |   3 +
> >>  include/uapi/linux/bpf.h                      |   6 +-
> >>  kernel/bpf/trampoline.c                       |  87 +++---
> >>  kernel/bpf/verifier.c                         |  22 +-
> >>  kernel/trace/bpf_trace.c                      | 212 ++++++++++++---
> >>  tools/bpf/bpftool/link.c                      |  59 +++-
> >>  tools/include/uapi/linux/bpf.h                |   6 +-
> >>  tools/lib/bpf/bpf.c                           |   1 +
> >>  tools/lib/bpf/bpf.h                           |   2 +
> >>  tools/lib/bpf/libbpf.c                        |  39 ++-
> >>  tools/lib/bpf/libbpf.h                        |   4 +-
> >>  tools/lib/bpf/libbpf_internal.h               |   1 +
> >>  .../selftests/bpf/prog_tests/fill_link_info.c | 170 ++++++++++--
> >>  .../selftests/bpf/prog_tests/tailcalls.c      |  62 +++++
> >>  .../selftests/bpf/prog_tests/tracing_multi.c  | 254 +++++++++++++++++=
+
> >>  .../selftests/bpf/progs/tracing_multi_bpf.c   |  61 +++++
> >>  16 files changed, 869 insertions(+), 120 deletions(-)
> >>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_bp=
f.c
> >>
> >> --
> >> 2.55.0
>
