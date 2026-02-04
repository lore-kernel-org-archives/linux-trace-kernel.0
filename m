Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D4442314B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221226; cv=pass; b=nutRILLJOfIhk8U215IA2pb2SYEXGPkfvsJyU2K/F+z4iyeYuO9bEju6EQdxhrwd/Op/pSqDoJ0FE02z6/iPuklSjFjhxZoMnh3XRo0ne6zBFoKpEZLXiOLGYCcKlOwNBIy9zIFS5q3N5PLS6v43acD9SpFUYuN249cYYzQT1I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221226; c=relaxed/simple;
	bh=VFCK34v1D422aldVA5ktiMUDtY/jZRvdezQa8B13quE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boKfH2R9lyw1kum8mpSjcf+BTgAoDYnVNEGR8v71Jf5MGNBDnJ9XH07dTBVTXx11Npru8NAQDpX59US0deTuUkZPyb7ck9Fi4AKRaZZ6uIdH4T10ezpTLqO3lRwUCi9rpr8E7/CLD/hwIWCtfwvsgRWTTLMDS6hKEdfeoiGtHak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFrmsTa+; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFrmsTa+"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fbc305914so29442f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Feb 2026 08:07:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770221224; cv=none;
        d=google.com; s=arc-20240605;
        b=XZil8X4nLfTfz+G6tC5F8w9NNXZZz0F0vUL3b1WFiC4uRF6W6MtYSu5VnWvS+pGrWz
         wHjDABQ5HBaRcSMOKqDK2FmkpB+56nBQpdg2X4ljop6ZLDOmfXdrWhSdxz6r1iO8LwrF
         /9D6FnhY7VV/f3V7ixvag27AnS+cBSKTp8U76LybO84NKhznxd8nGMqLI1FOl3So7xMj
         V5OEcxFt3GlP6looXFrL8n2QKGcPk26kj0GEF8V9W8DepUeA/jycDoAjJVjlp8xTU7pZ
         8lWMqxJkRznrL6qhQXU5JW5dszfrDe16wAlweXD/7dUntYIVBiBPnMFVaBv+SQChZTZP
         +FHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g3KyJo8YATugesAfXcKf+1b+zK4Bs92mhLlJFwblWSM=;
        fh=h54H4kjODCFge5aUPNEVHK+/FhcbA7S0cPUL7Fdr0ZM=;
        b=lwSlVQ+UlsKn5TN96di5GzJI67q64AbzLwx1900SVNN+fn7gVcBkVeOOUOQN+07ds5
         2QLV8g1a+biO0Vl4lVnNLLCrjsri680xWglEPAdJ5SbmrY1gM80FkpGZJTCuaZeIt+Aa
         YMu5HH/h5E4ANWhYE0FI/DpBJV0is4HinwX/vJCfht26FfPM/2zvDKZPqX7AFQ8Z623I
         W7fZhEPjGQX1rDgDoE1MYfHZJb3/irVYP8SKv80k18o1FExvHlT9mkaHl1ZR+5CtBd6f
         iww3228smhFqd8/0YTu8ESyP+YDi1b/fcLNNB5AEqRJ60KuWTxFY3k26HaDdbYVyjjRz
         PhdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770221224; x=1770826024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3KyJo8YATugesAfXcKf+1b+zK4Bs92mhLlJFwblWSM=;
        b=FFrmsTa+GCl3ztGEusr0qqHOuyzDce+1vvF0milYxsyRGgwUAFS7c1ecuGaRA0ptlI
         /0Xu6xXBNZlQdYXAl4K7XkvWxMPTQOL2y/H0iiANZJlPrOTcdWSufH4lh1F3glA/gHQX
         1nSFKMN2bGYgdH0cWctczjeq+zzytdvM8TqdvuQ1VQEhjzkt1f4lqzao1whcZ7As617f
         Et1Ik3eBF1Ny7XFgF4uJNC/hpomKiRWVxO5KozHZwH1vWBVTCYpbnBuoyuXNRI4G5hoc
         PNpiZV3T3EoqJn3HKqyEAIF/4lByIilzn7smpJwajLOKq5qXFL2DJYds4ulmLGcizC0d
         A4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770221224; x=1770826024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g3KyJo8YATugesAfXcKf+1b+zK4Bs92mhLlJFwblWSM=;
        b=hqkXwG4zKle3V5Wm/tX/JeAwDogy8cpx02GiVDQQCPMSSHZBvHtFWg+G4Y/LRpqJU8
         GehoQ2lxHWbx1t9FwC2qIivm+Kp5+KCzpftxGIVMZAejM5uLDKaSi4Jqn7xO7FtOKzi1
         ETmdgk9bF0ayzsuHXPWjMuxAgZyOGeL9S3eqNtv4SzcBghGxPyDPlSyDCstRK/110127
         TPavxvMxXilmcZxah40qctcxtpkA1y+UY/8vxXlMWxPTeB14k0h2woWk/FZLw0UEJcOU
         3vjA7bE+gzT4qR20JVWr7Xt6Z7NJoMRrPfdQm25sjsqGd7+dvqel6lFxjBigCjpbXbGJ
         pzfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3RnoA2kkRzJ+srNo6VvLFOuiZPXYpqMpfO0G/Zr5dLf8VLi9+wJJTXp/OqEQsnn6bIyjYqVxPIL0+6iNm7h8Fg6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjgI33d6VLee8v8jt20ORGnmgWMpX5eLHnvgrcLRbVDJCTNIPt
	zaRMBmJWyGfU8xxsZOXGyxj9iAogaWhAqz2E0G7vg+KqWSN5qTRRU+Fx2nZwN8H9jPWbnc8iY2K
	CUFjO6ZvpC/le9HSPMqJxNDwYjb1vTVE=
X-Gm-Gg: AZuq6aJ8ApUv9KI7j52ZgDrxi6vuJo/XBT/EssDEN8gZBGV3w0edi/4MIURFt89kjox
	RGftsGh6iYJrcpHu0e7aFO75LvN06MoaWY5GQR/oPNB3UGZVFoKNX7yRyVLSULh6/RoS3OpjF01
	IzQkvKWeGe9ZMwqUgVEXZyl6frC6fWBseHTObp/GtvofueU5HPqoqEJ//AJpUUjuC6EH4qiM2JY
	LTPAeQInOLCmzxEhmcgrq2rGOEi33ZyWt63HorNcWaFz/pg5gxY3Edex0qgWP+06+pYVTHcxAvS
	DhNJEp8zLBOP0ay1lYU1cWedwL0qEpmFpRvox7WDO/UPxqDlYQJaFxEcJHzbfQ4fybxkotdfKom
	jUIg/BlF6sV3gyg==
X-Received: by 2002:a05:6000:608:b0:436:1516:4faf with SMTP id
 ffacd0b85a97d-43617e30129mr5407282f8f.10.1770221223749; Wed, 04 Feb 2026
 08:07:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203093819.2105105-1-jolsa@kernel.org> <CAADnVQ+EU_f4LVDQkqkB0Q+QYMBH5ynXU3+rGZA2XCGmYMcFqg@mail.gmail.com>
 <aYM9YUl6xf9I2x4c@krava>
In-Reply-To: <aYM9YUl6xf9I2x4c@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Feb 2026 08:06:50 -0800
X-Gm-Features: AZwV_QiYCIvOKIgNbC9t1KZ1fUnzpyrPVQ58tyi_XhyB3WAfGc73HFZJPGO5tzc
Message-ID: <CAADnVQJPbnVEDYAAy4mUP7NmsGkUmeV9B73V+Bc=LYb8r8Zrow@mail.gmail.com>
Subject: Re: [RFC bpf-next 00/12] bpf: tracing_multi link
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 4:36=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Tue, Feb 03, 2026 at 03:17:05PM -0800, Alexei Starovoitov wrote:
> > On Tue, Feb 3, 2026 at 1:38=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wro=
te:
> > >
> > > hi,
> > > as an option to Meglong's change [1] I'm sending proposal for tracing=
_multi
> > > link that does not add static trampoline but attaches program to all =
needed
> > > trampolines.
> > >
> > > This approach keeps the same performance but has some drawbacks:
> > >
> > >  - when attaching 20k functions we allocate and attach 20k trampoline=
s
> > >  - during attachment we hold each trampoline mutex, so for above
> > >    20k functions we will hold 20k mutexes during the attachment,
> > >    should be very prone to deadlock, but haven't hit it yet
> >
> > If you check that it's sorted and always take them in the same order
> > then there will be no deadlock.
> > Or just grab one global mutex first and then grab trampolines mutexes
> > next in any order. The global one will serialize this attach operation.
> >
> > > It looks the trampoline allocations/generation might not be big a pro=
blem
> > > and I'll try to find a solution for holding that many mutexes. If the=
re's
> > > no better solution I think having one read/write mutex for tracing mu=
lti
> > > link attach/detach should work.
> >
> > If you mean to have one global mutex as I proposed above then I don't s=
ee
> > a downside. It only serializes multiple libbpf calls.
>
> we also need to serialize it with standard single trampoline attach,
> because the direct ftrace update is now done under trampoline->mutex:
>
>   bpf_trampoline_link_prog(tr)
>   {
>     mutex_lock(&tr->mutex);
>     ...
>     update_ftrace_direct_*
>     ...
>     mutex_unlock(&tr->mutex);
>   }
>
> for tracing_multi we would link the program first (with tr->mutex)
> and do the bulk ftrace update later (without tr->mutex)
>
>   {
>     for each involved trampoline:
>       bpf_trampoline_link_prog
>
>     --> and here we could race with some other thread doing single
>         trampoline attach
>
>     update_ftrace_direct_*
>   }
>
> note the current version locks all tr->mutex instances all the way
> through the update_ftrace_direct_* update
>
> I think we could use global rwsem and take read lock on single
> trampoline attach path and write lock on tracing_multi attach,
>
> I thought we could take direct_mutex early, but that would mean
> different order with trampoline mutex than we already have in
> single attach path

I feel we're talking past each other.
I meant:

For multi:
1. take some global mutex
2. take N tramp mutexes in any order

For single:
1. take that 1 specific tramp mutex.
