Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4208047AF65
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851915; cv=pass; b=GT1mRb+IYBQHFd8YTw8qpDvtQys5oTaUC5w/KLjGcbN2rk9Lq3dYKrH1Dls+w++vcWZZSXVtMAcGJ3OLiubiKR1jkgTZhhyc+b7g2LsP+BNDllSVe2HrrSIg2LqVfi3KiSrb6AE0anvXeQI5eka5nf5rDxG54QdNatuz6YrZaOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851915; c=relaxed/simple;
	bh=3C8MIv9sxF63rRvOttJhdisDNERH0wDhryvv0IhAoUQ=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXjTABww4hRagg8TvPS+9iqzgretVJY2nQm2bFY4WU3GaT3daiCUa1hU4BPCXRtQR44IHm5Z/lNjFkFtyLUPanpeVGgX0iAzdXHOGgG/3zIAd4QQbgBJqmKjDtAsXOaWb8Fyu8Yank7xElT39mnhK4Qk85+kz8JxRDj7WaklRKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwGDLMvd; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwGDLMvd"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-80bb8287d99so50180267b3.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 13:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782851913; cv=none;
        d=google.com; s=arc-20260327;
        b=RlqLZmJjnqpdZ7VAcYRrB/bBPQN9MojlJMGbnSfIm1lxepJQli62LBRAhePBhtTmgO
         yifaxkBy1qSH3Yr8HNUUPhlOTqoPgR45142Q2UYGtT8kRRuk55Y4kqMLk/VF/YbM8nmH
         3aLdQJ0zgQxnT3yGaGQFk8kMgXD/YPW0u18Q9z+6ElB+87eCwN4/20FySouyXCodKApo
         alCL7BOmJ8cXoMcdNNWIxFCeG+lTZ9CEUSbl2mIJbMfZugecMD7AJEM/CxnSzjNGjnvD
         sm4kWHRtFazn8Jqe7SicRgcak5vNH2/cMlsmcXY5kR9Ys+ONVVlJUTNze8fPmQnhunW4
         Klmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=3C8MIv9sxF63rRvOttJhdisDNERH0wDhryvv0IhAoUQ=;
        fh=bYzlg9zWARFUEA3GQ2a9HyOt6DvVEJ9D8wXGQSfMyYE=;
        b=fzRj4a4ZyZzH8pdgY+CbF/VNJLZckpMpMHna+bc2LW8qdfzchUU7SYdO/QoRRUFYsV
         pBTFb3KlZyRiA9SmAHfQ/Nek0mr24EoB0UnoAr9jxMCUfLENWl1HUsJu81O33mcOkwHh
         HRtS5l+WaoYsyUIP30W7itWLVVUSpx2jFc2OtWm+TwScvYIOV7kQ9BLAMs1WtIfRQvCF
         Nxh8uo4tbI6iDekY5lXK+Q7Jmb4VY0BKwue9ILYcdJw6bWfyTi2eoiYi3TCh2CSkZxSP
         EVhkg3LHckadS7YIhz86OQKPqOom1zxxJtaHTeenhdjKf3ChZB8S5xADDqseU6uXhKL2
         g5+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782851913; x=1783456713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3C8MIv9sxF63rRvOttJhdisDNERH0wDhryvv0IhAoUQ=;
        b=fwGDLMvdzzBt3FH9mVhy+4VG1AFgQMlcCH0f5rRrIpBGDXqKQdz8S9PZ0gqa7x5poh
         zdqz0N68ZoweYDmKHG34YlSbVM0mDvdxcr/DJ5V3pUGK325QTEUfZtX/dRZTFzO+HYQO
         Ftl56EuhD1zGTn6y62iGRd7hsDjCNe7IAk3groTrV1cAnLQjlw4c98uqojkKDJme0s+p
         0FKEuqvGPOqEVYsaIh343CUjrCZUaPj6WcgqmjlitwiodDPAiYAFEwnvh6HuSCqRvmGq
         eIiObxwnDa//dTE4frNoaq3+D7qHgihTatJxg+2fdyGUQ0PIwdvQvmgwKPb7fBnjuTuw
         E1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782851913; x=1783456713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3C8MIv9sxF63rRvOttJhdisDNERH0wDhryvv0IhAoUQ=;
        b=sZISUjHLQiVMqtHw8NrbJeHQCSZSMbcAGU/f3qZFz/4ZZqzzM+T2B7NR7wbbtYpZ1k
         JrjP7vk77834MuzWbmX8s5nixZeGfmSmRx9v0SIyvGIC/SYSVLoz1VhZ2fAiC1MWTGCI
         VpPJt1DwTiX2mjJ4IJOoonPnwD3rJeWUC0rmdjq1vsvXcZABWytD43Ii943LH6zTxeTC
         3PjYidT5D28CgRjB/eDP5rRHrADL2zLUzsHAEPmZbliK6QeK6Nm1kMnT/rVUoC0KQRjg
         ypT23vzZKP/A0kgS9XIXkXNJrmkd6bNYTHAPfed3JLHG5GtSGShYSvLNnqC9QtRWfJr6
         LG7w==
X-Forwarded-Encrypted: i=1; AHgh+RoImleP/Jfywo0YsbueQDvIHus4qlRH7ozHbg4K+alCq8mtx9eH80znL2wOCOv5dNBAIAtP+a0xYyesc7IFgx14SyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYCU7skeUqYaKSavtncP7J/N0oDHtTyW4DHbtAyrKaS27U2w9h
	fYaUJSjMufO7oeSpZzazGZ/7QyKvlwj0xRUsLj+L+m7HIXEYS/B+gxJEJudwgWU3Y/ZSaPsY2rz
	G9Ju6pCYnIp+p49u1jCdfX5AgaR3Y+UI=
X-Gm-Gg: AfdE7cnZb/nX0dIWd9wLWiAiydVR6ghsCaRviT6EajzIzOknAPLJWJ82/FENJ5O3yys
	l+gZJ3AiLBR++SGlOQHiyoH7hk+Ye4sZKf0F2HOVKcnjptEh+ibTzA4jLSudwSZafeT5tRmTAoM
	XCglBlstZ76M1mJuCf+Qp6RjCSM++I64Ttcq8ZN7hoTFTmog+94Q8dABRb58nAi7slznPQG8vY6
	UbdctsvbEUgKHXdXrqe0TO1NCqoBwa+YgrjNudfigO0/mJFkqgaBTvrMmj3FbZUCyjuL4xR
X-Received: by 2002:a05:690c:c4f2:b0:80c:85b6:75b0 with SMTP id
 00721157ae682-810dad04909mr51464367b3.57.1782851913113; Tue, 30 Jun 2026
 13:38:33 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 30 Jun 2026 13:38:32 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 30 Jun 2026 13:38:32 -0700
In-Reply-To: <20260630101425.2f7cfbea@robin>
References: <20260628004653.28065-1-alhouseenyousef@gmail.com> <20260630101425.2f7cfbea@robin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Tue, 30 Jun 2026 13:38:32 -0700
X-Gm-Features: AVVi8CeS9MpWXcK6oMQlhJxchQ6987C-gKuaNCMr5pFvOCnqWrfkAXq0VUAhg4A
Message-ID: <CAMuQ4bWwnbr_-sTJwMFvGrU+a0A_FdGutiBAAadgokEPEMTEmQ@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: serialize read-page order with subbuffer resize
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, petr.pavlu@suse.com, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Steve. Moving the order reads under the existing per-CPU locks
is much tighter and avoids extending the allocation critical path.
I=E2=80=99ll compile and test this direction and send v2.

On Tue, 30 Jun 2026 10:14:25 -0400, Steven Rostedt <rostedt@goodmis.org> wr=
ote:
> On Sun, 28 Jun 2026 02:46:53 +0200
> Yousef Alhouseen <alhouseenyousef@gmail.com> wrote:
>
> > ring_buffer_read_page() checks that its spare page has the current
> > subbuffer order before taking cpu_buffer->reader_lock. A concurrent
> > ring_buffer_subbuf_order_set() can change the order and replace the
> > reader page after that check. The reader then copies a larger subbuffer
> > into the old allocation, causing an out-of-bounds write.
> >
> > Keep spare-page allocation and release under buffer->mutex, which alrea=
dy
> > serializes order changes. Move the read-side order check under
> > reader_lock, the lock used by resize when replacing per-CPU pages.
> >
> > Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub =
page")
> > Reported-by: syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D2dd9d02f60775ce5c1fb
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> > ---
> > kernel/trace/ring_buffer.c | 9 ++++++---
> > 1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 56a328e94395..eed5d7cffdee 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -6950,6 +6950,8 @@ ring_buffer_alloc_read_page(struct trace_buffer *=
buffer, int cpu)
> > if (!cpumask_test_cpu(cpu, buffer->cpumask))
> > return ERR_PTR(-ENODEV);
> >
> > + guard(mutex)(&buffer->mutex);
> > +
> > bpage =3D kzalloc_obj(*bpage);
>
> First, do not grab locks around allocations unless the are really needed.
> This is bad practice, as it extends the critical section and may even add
> the allocation locking to the lock chain.
>
> That said, just moving things around the current locks should work.
>
> Like this (not compiled nor tested):
>
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 56a328e94395..8352f935a223 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6954,11 +6954,11 @@ ring_buffer_alloc_read_page(struct trace_buffer *=
buffer, int cpu)
> if (!bpage)
> return ERR_PTR(-ENOMEM);
>
> - bpage->order =3D buffer->subbuf_order;
> cpu_buffer =3D buffer->buffers[cpu];
> local_irq_save(flags);
> arch_spin_lock(&cpu_buffer->lock);
>
> + bpage->order =3D buffer->subbuf_order;
> if (cpu_buffer->free_page) {
> bpage->data =3D cpu_buffer->free_page;
> cpu_buffer->free_page =3D NULL;
> @@ -7007,13 +7007,13 @@ void ring_buffer_free_read_page(struct trace_buff=
er *buffer, int cpu,
> * is different from the subbuffer order of the buffer -
> * we can't reuse it
> */
> - if (page_ref_count(page) > 1 || data_page->order !=3D buffer->subbuf_or=
der)
> + if (page_ref_count(page) > 1)
> goto out;
>
> local_irq_save(flags);
> arch_spin_lock(&cpu_buffer->lock);
>
> - if (!cpu_buffer->free_page) {
> + if (!cpu_buffer->free_page && data_page->order =3D=3D buffer->subbuf_or=
der)
> cpu_buffer->free_page =3D dpage;
> dpage =3D NULL;
> }
> @@ -7091,15 +7091,15 @@ int ring_buffer_read_page(struct trace_buffer *bu=
ffer,
> if (!data_page || !data_page->data)
> return -1;
>
> - if (data_page->order !=3D buffer->subbuf_order)
> - return -1;
> -
> dpage =3D data_page->data;
> if (!dpage)
> return -1;
>
> guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
>
> + if (data_page->order !=3D buffer->subbuf_order)
> + return -1;
> +
> reader =3D rb_get_reader_page(cpu_buffer);
> if (!reader)
> return -1;
>
> -- Steve
