Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7411A36604E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695802; cv=none; b=nNx/a7DBjFBo9o2ucuZSD7VKVlAb8Mqi4KA07B0XugsTSmuhz2SFxgk2ELz/A5mFtlcV39apDYTpuTONmE8aJjCo8InZB+z6/qlL3jT0gl4NCfvKWGZY2iE2/9gwB8lMq5sp8xa42U0ZCMLsiIzW4YWfXT/SpjMZp4gCC8iXbM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695802; c=relaxed/simple;
	bh=X/6PQErbVvlGjhxVgzYhhyWA9w62HgHh5Ubvund75Z8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFFVVUK1NnBk6PXlUSs5AF+xayN9cyenXx4R3iymEaeaRecIhXG3FuHmdVNvW6PJFjeUGLuniruHw/0kCF05fctrdmhWLaiFbl3gg2X7Y4/ojRYdfcUF6y2IcxcH92bwMfFGsefZkuPLiJnDZSaddkOfd09W3Q5w8J4KFzTFStw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcFkEzyS; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcFkEzyS"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439b6d9c981so86942f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 14:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773695800; x=1774300600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LYLCW034xV7iNfx7fErN9UQssmnH4zJ7PGgwbYUnjmI=;
        b=hcFkEzySySsVSe4afiBIOLk8cx53f0TJ2MpKun82alRMSTf89FWrWeVxdKpvGYFV9l
         isi4hbhLd6QoOKM9o54kL831WgKig+/zhKjYUoP77X9aPEPRxW0VdjaZ+JHtDv6HXBVl
         LuNDrX2mN2+CJJ4OMw0CDwPreDplu1nw9KLYmaiPyWHuytQ8qoDZvZbMWbZmpAhb+7Qq
         Xw1Ij1LUQOoo32H3NxrkOntwvVRBrpSt8F/LQ01XA/7EdcQ1FZVGLllj5uCzP0+gLO+Y
         +2LmwcpYo4Z7P7FhdBk4ODiQUzPtomnTQFi/zQk+r19d4Phdmu2vFA9/1DufAwc1NDqV
         YuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773695800; x=1774300600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYLCW034xV7iNfx7fErN9UQssmnH4zJ7PGgwbYUnjmI=;
        b=eM5XXgaJjED2ZQbGr4Kjw2ZM5+Y2S4rVx6s969obaE8b9cxxnACutCCCpkcICgWfpb
         z9sWpxbeiyDK25BUuRK9WVlDoTcRKHYjufXDalgtKSEpM/DRqUprKy6UFDGlU95ciG74
         nke5oUjZnNYv0jG8/L1I9EUtcQPUENK2P7QqqjFpzDv+ZAFTMMqD8ULEQgrl2Ee+qr6U
         kneCgsuoyp6zrt9IScafELK7YP/yc4xWuIbkoE+Gp9HhVCwtXUvzj+is+mx0GnaOrqKL
         X66yllAc1Quveeh/ilISnAwkYD9fMV72zgvOxFoj3TNlUsqaPWhCekVXZ5O7dihcye3g
         K2yg==
X-Forwarded-Encrypted: i=1; AJvYcCVl/RLrj0hj3+t8nyydGoiN8Bxc5Y9i4Bcq83OkN4Ll0rEPY6mKIHg7+862bsG/1ogZOXM0OeyHaBzQ3CSHKi3KYhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9cWu7ODkA548gls67gLfoAX+F6KmBi0fftWgupqxSb7iy3nkq
	AwOYDRwAho7bxRoeyiHlkwRs5FW3m2sh+QmnseDJAhbD+E0z6Byen8hk
X-Gm-Gg: ATEYQzwsXu9ZMmasHHx6NJtUIeFKK8SPebFgMtOQiDs7Ud9h0ePYI+bfa7R+QHz5+Im
	8J7y9+Z21X7ZN33m5HAWr2ijpHPBc7HrBwIxjW/Yw/SbM8QVGoLV67vNZ/aPf1Q813xGaiZsUsm
	YpHqpJjHliwJPaExA9pyCOHMDh6H3YjnrdMiNS+d0bUDJYp1H8oNx38TJHGycRhsqdnQDUE5Ixz
	EJxA5Kvh8q4qpB/B4BnTWpGczu/sLG68uxWFWy89WwkilPPVwIIaszWMhuj/wY8QK+3utnBqg0w
	TMPNfKT9NS+9bbY9NKs8yQGvQ6X4dpSt8a53+ZXDg8LoE8yTDxLAxoi1kCb93pei2XdIH6c7ToX
	h++Vm7GREy524D9x7fbZgjk+5ve+/972GCB59/NbTqXtqSDbOpO09wYxJXuits+g3xDFF7paCL6
	zwYDLfqL3iaE0=
X-Received: by 2002:a05:6000:310c:b0:437:7719:ca82 with SMTP id ffacd0b85a97d-43b49817ffdmr2211153f8f.3.1773695799447;
        Mon, 16 Mar 2026 14:16:39 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2186e3sm50480063f8f.26.2026.03.16.14.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:16:39 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 16 Mar 2026 22:16:37 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv3 bpf-next 02/24] bpf: Use mutex lock pool for bpf
 trampolines
Message-ID: <abhzNcbXMiNbX55U@krava>
References: <20260316075138.465430-3-jolsa@kernel.org>
 <31ae46274a3157f2b9840e1a09b2698d1ec0cfd461737ff460c2d3349a9f0054@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31ae46274a3157f2b9840e1a09b2698d1ec0cfd461737ff460c2d3349a9f0054@mail.kernel.org>

On Mon, Mar 16, 2026 at 08:35:14AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index f02254a21585..9923703a1544 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> 
> [ ... ]
> 
> > +/*
> > + * We keep 32 trampoline locks (5 bits) in the pool, because there
> > + * is 48 (MAX_LOCK_DEPTH) locks limit allowed to be simultaneously
> > + * held by task.
> > + */
> > +#define TRAMPOLINE_LOCKS_BITS 5
> > +#define TRAMPOLINE_LOCKS_TABLE_SIZE (1 << TRAMPOLINE_LOCKS_BITS)
> > +
> > +static struct {
> > +	struct mutex mutex;
> > +	struct lock_class_key key;
> > +} trampoline_locks[TRAMPOLINE_LOCKS_TABLE_SIZE];
> 
> During v1 review, Alexei asked to add a comment explaining both the
> pool size of 32 and why per-lock class keys are needed:
> 
> https://lore.kernel.org/bpf/CAADnVQL_Jpe_7a55HTn5CyYoxWcHahiK3+CDeOeURqZAuf+teA@mail.gmail.com/
> 
> The comment explains the 32 count (MAX_LOCK_DEPTH limit), but does
> it also need to mention why each lock has its own lock_class_key?
> Without that, it is not obvious that distinct keys are required to
> avoid lockdep "recursive locking" warnings when
> trampoline_lock_all() acquires all 32 pool mutexes simultaneously.

yep, will add

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23133791558

