Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A94D489896
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787682452; cv=pass; b=LEQ7+kcgK6aE6QQ8GEDpeU0vYAWJpbWuOjyHZj6+mrA9B/P7UzKRYEDqwVEdoIb/z8deU6YgPSleLjEe+RiJxgTexcqYc4fCmC0EllL1Q6H+IEBsngOmFITT46YkzFhrZIWnNGujG1Q8sAEJ/v4l29m64oBzhxOMmFGhX/hzOlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787682452; c=relaxed/simple;
	bh=pjrV0fg8wzQcSqA/vlhGpXXq9/2wjhDE9WMxRk+zoWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1VvkkIqQeo7h1qPwR8ycdf/ai9U/fwTC+zlfoj3FTKOCjhT7Kayta5nKTJwv+nfUKM5nHbVOrCyrRXsvdbfp8q5Uv39BsI6R65TZpwuHzEm+Dc8ZFTTK71uLLlzW306F41pIZAaW/wSoqEUQVJkPFd0SbirqGqmmhwQcrE/05E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3In9U80; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3In9U80"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1bcdb3c4cso38448a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 11:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787682450; cv=none;
        d=google.com; s=arc-20260327;
        b=g+e+RUcal0xPFCX61aJ5wKEaDtFrZAlWaQ3jxFYA7twzhccrFiXPepMqAILy+5d7yP
         OfGk1q33QaKbF+1Dc7NaOruMQ0+CBQCKuRLV6GUMmKEGjoQdOb/Y107WoMPmOHUDKlMA
         gdstrlU1upHlhplw5+oF2o57okPNIJODnkk//59H/InijzYlp2ug1OO27pp8jNoYx/db
         l0QyjYEEq2E3UZNaqHruvIpH/boTZJEEr2rI6T6Hg0c7+e+fe052u/SL3NLVvNf7vi9+
         yGaP0eRZXvSdzAEG9e4X0vZ8JgMk2JKPXQy0GctbtqiY/ShbS/yx2a4Y8ymfRFpXipa8
         ZOjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pjrV0fg8wzQcSqA/vlhGpXXq9/2wjhDE9WMxRk+zoWg=;
        fh=0tQ5x3rxj36x9/dO0sA0H5BhKRdj4eJgWXi1ErqFpEQ=;
        b=ZZud/cLRNonFpjE853FxM0LH56iXecCiUBqYBHqegFfPEE48t4yb/tCygjdeGg1RwO
         9h1d/Rtx08rLEf42ZaP3F6YF1AY83qW30XNvB/3VDpbFzdzq6jFBkfR14PZozxYXf01T
         gmSvOgfdJHCFI+Td/9lp0NAVavjG7sKUIH4g8P0QgAfHcWk8i2EYk/84uWfhe+FT1nNH
         dmO3ymZcpz7XPCuEASTDo/03mRXAlqQF1UIlJ73uQpJYNUY50h3xpMMS56Z41bC6mNC5
         DFYO296wbA/aWc+rJeQ93hm9c+sfUBSzc/X20tWSTxf0HftLkNZOxMgaRDq80m5WzR5v
         908g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787682450; x=1788287250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pjrV0fg8wzQcSqA/vlhGpXXq9/2wjhDE9WMxRk+zoWg=;
        b=X3In9U80BKpQbeNg61vgbUs9CA+a1cg135fGIgEm3O2UMuK73+9jQKnn7SQFIUlkxJ
         ob8U1VCXRkIG+yu+uMkoVPk9Z+wgw5eDoX+7kXkYd99d3E1QhOgl+GaSpynJ8UtWANSd
         Z1BYU2bUxEAQjYX5rJg79izzLf5cowzGtmS+JqMhY+kjgIVaO0IKEMX6Zb+2Ym32Pi7P
         13RUX4PPkQasY/K4n7qcbNPESlgl/1vn+Wq0fFDKZ2cxC3dP4Di3d3NG/b7XS4kJZUQ0
         4YBtH7F13ecWUJge969Aw/ezoX0nYnWlBEYJjn4woAVHsXgEAjW2Tptr8+RncoR80tsB
         DNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787682450; x=1788287250;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pjrV0fg8wzQcSqA/vlhGpXXq9/2wjhDE9WMxRk+zoWg=;
        b=Jjc+2D1wDb3/gP0FoFVJf8+phjIORNk2SZbPcTg2GstrIFIyY2QnqiX1Dfe1n/dBJA
         aVgWs6GKTUPH6aKSazAXZWgfe/MCbYOq4V/XFbAqBWABzwghyFQYnuvhkorlvg34HgSC
         thL7Wo/hXBFkCuNe4dRHzOWEyhM4D6jsdXRVvrEJayGUmROMd+TsHI3zeMMc9hNrKTeT
         +xEeywt+sKm6FCBwAeQg1aThtRfCMtNSBAM3C1b0EoZjxi5gLAb4UWuteXHnIdM6qHAr
         F4s457BI2GD+T3GZWJ5lS+e1G+VIIgCGch6ghN7OYlMiZi2AlONGB1GsahGqflr6wiim
         1sXw==
X-Forwarded-Encrypted: i=1; AHgh+RrRG1Kw2voYmU54ooP7GIFFj5TVJOO1N6n012tdlFuFgIrCNVhF4FJra3upA6hJ69TsinX4+0t+JZAQxR8p8auqZ/A=@vger.kernel.org
X-Gm-Message-State: AFuF++nrcut2PPnLvasZLbH5to0uARPP517A0Vyqs9+d+m5BpYW4ipC6
	gXa5LxZ1wf8ZrXJls3j6xB+CGnSc5/Y3Te/7FxpeM/47YrmBKmPLcnGeK93ASqomm86Kgra+/kd
	OCVklUNf0nNrcg62+7Jrztzeqd6N8kT0=
X-Gm-Gg: AR+sD11N0mmUkLgrsoGRLCu5BOOdb22+Z4zsp2E3zJ2bGkeRCOsvYGZe3OMg+Zuiuuj
	Xf+xJRo/b0oiz+zxgsBW3zX3DlF7LC8u83KtIBGFioDuvrpdzZhfzXP3VFlx2Nj9izOmsBUjp6P
	oG6n54ZTAnTIicoDDnK4SjmlFexp0wR9aZqXHZhvCxws6OLghK/UWvT0jtUorCrvhxE1MkZ3igG
	3/pPUzrbahjzZpWkhwNENA/DWnfU6sXroWL0yp//7kQ+J+g5wMgQ7bxKI1Ar3dx0QNJgThc+dTi
	CuyeIBoRkb2q1RNvO3Hr4nPK64IYqJ3k/Sr12JyWu0TUSFOVcpHkIbVYZnfUmwuEMg/XcKxSJ3o
	sk18pRwl1g49q5zrYVo849e1sjVar2ip7PVxR6+TQcA==
X-Received: by 2002:a05:6a20:eec7:20b0:3cf:a7a5:e310 with SMTP id
 adf61e73a8af0-3cfa7a5e417mr148047637.9.1787682450200; Tue, 25 Aug 2026
 11:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809150111.45000-1-leon.hwang@linux.dev> <CAEf4Bzam=0V6n4_vBahhYh2Qn9KfriDKXSz58L4L+teHJRWfPQ@mail.gmail.com>
 <0b30bc97-2ecf-46eb-a863-94e706e18c6b@linux.dev> <CAEf4BzaXaLLqs6XXCG_02c7UcvNWfbGUAJTYosr22oaD4iokuQ@mail.gmail.com>
 <c71d27ab-ec59-4b72-855f-7bf437095cd5@linux.dev> <CAEf4BzZpB-qkhu3SAu5MrYYAT2+ZN8WaXqpmnKruOOdjJOLK2A@mail.gmail.com>
 <7f18980c-0c15-4862-af1f-f451ca12dac5@linux.dev>
In-Reply-To: <7f18980c-0c15-4862-af1f-f451ca12dac5@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Aug 2026 11:27:14 -0700
X-Gm-Features: AcwNN1X2RE3UG00GfCM7tcLMBWO7FTBVU9F1ssGpubHcRFwnWfxEEW3QwlAbcZ0
Message-ID: <CAEf4BzbS8enxXg7YfWXssBg4jPHr2Z6L9cAigpfUNxiOep3BJg@mail.gmail.com>
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

On Mon, Aug 24, 2026 at 10:15=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
> On 25/8/26 04:02, Andrii Nakryiko wrote:
> > On Sun, Aug 23, 2026 at 10:00=E2=80=AFPM Leon Hwang <leon.hwang@linux.d=
ev> wrote:
> >>
> >> On 22/8/26 01:46, Andrii Nakryiko wrote:
> >>> On Sun, Aug 16, 2026 at 11:20=E2=80=AFPM Leon Hwang <leon.hwang@linux=
.dev> wrote:
> >>>>
> >>>> On 15/8/26 04:14, Andrii Nakryiko wrote:
> >>>>> On Sun, Aug 9, 2026 at 8:01=E2=80=AFAM Leon Hwang <leon.hwang@linux=
.dev> wrote:
> >>>>>>
> >>>>>> Similar to the tracing_multi link support for kernel functions [1]=
, add
> >>>>>> support for bpf progs.
> >>>>>>
> >>>>>> When attaching to bpf progs, it must attaches to the target by tex=
t poke
> >>>>>> way.
> >>>>>>
> >>>>>
> >>>>> Please spend a bit more human effort on justification for the chang=
e
> >>>>> and explaining your use case. In what case you'll be attaching to a
> >>>>> large amount of BPF programs such that attachment speed-up (if ther=
e
> >>>>> is any) matters.
> >>>>
> >>>> Will update the cover letter with justification and my use case.
> >>>>
> >>>> Here's my use case:
> >>>>
> >>>> I'm planning to enhance the function-graph feature of bpfsnoop [1]. =
It
> >>>> will trace all bpf progs, including their subprogs, to draw a full
> >>>> function call graph including bpf prog call sites.
> >>>>
> >>>
> >>> fair enough, interesting use case, definitely outline that in the nex=
t
> >>> revision (and provide before/after attach time as well for such use
> >>> case, please)
> >>>
> >> Will include my use case.
> >>
> >> Implemented the attachment micro-benchmark. Here's the result on an
> >> x86_64 16c16g VM:
> >>
> >> ./bench tracing-multi-attach-progs
> >> Setting up benchmark 'tracing-multi-attach-progs'...
> >> tracing-multi-attach-progs: prepared 1000 identical BPF program target=
s
> >> tracing-multi-attach-progs: fentry created and attached 1000
> >> programs/links in 679.324ms
> >> tracing-multi-attach-progs: fentry.multi created one program and
> >> attached one 1000-target link in 470.042ms
> >> tracing-multi-attach-progs: fentry.multi creation/attachment speedup i=
s
> >> 1.45x
> >>
> >> The speedup 1.45x looks good. But attaching to 1000 progs via fentry
> >
> > I'd say "meh". If 500ms is ok, 700ms is not that much more noticeable.
> >
> Besides the attachment speedup, this series provides a way to attach to
> multiple bpf progs via one link. The current revision reuses the

that's mostly a convenience which is pretty trivial to abstract away
in user space, not really a hard requirement for kernel to support
this

> ftrace-based attachment, which relies on
> CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS. In the next revision, it will get
> rid of CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS with its own attachment
> implementation. Hence, this series will be able to run on those arches
> that have trampoline support.
>

sure, post a new version, but it's a bit less motivating to add extra
complexity to the kernel if the only outcome is slight speed up and
user space convenience of having single FD

let's look at new revision and see how this goes

> Thanks,
> Leon
>
