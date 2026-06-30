Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E147B413
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 20:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782852309; cv=pass; b=qaLfH+fJmaoSuoWkQn4qQOpwSO0d2EKcwFACizhPj8V3Idu3DZc7P3j4UQP9BdhYhW20kfo5nIrluosDMFoa9CbHMqx6E/s1kdY/WfAW2TXS+grJE8a1pMyL3Tl4SFn7op5kOCzDMOEBY3GTy25ErOCBiXzsTRVCTjflMCXZY44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782852309; c=relaxed/simple;
	bh=MtwX6PfEP7vLJDdIVNKheHf5WKk2ffhaPsYXNf4Tj2g=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCsZ439leZq2OW5SewMuJ1QdRCmFrGFs2b1ELOxyzwdEL3656Yco+2XW9xk/DEu5E5UqQkE+RnAchCtpC0sKfpFhMa/9roULn/SG/lzo6hsq/xmgly3hCUYFewHTvzvisUPckMdsVPyECYklFv3CS5wcLVXpsSLR7GMG6FyLxm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkcYD9pZ; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkcYD9pZ"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80cebd41372so32912367b3.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 13:45:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782852306; cv=none;
        d=google.com; s=arc-20260327;
        b=L0ZNM0bAgTxxErQRS0mxJlvFV8boBUYmbFUvnti0BogY+NmsWnQGjTdHppsW56Jbxi
         WElXdOfRnoAm28RX7bpyHyklLx9W7leD4Zg6AXe1/L260MS+cHeXwtC12f3cLgsy2USE
         y4flcYB4l6+wVGIuxG7umhTZ4+C2ynq9xZeHluwzs/Qo+r6ibcTAxXcpIHem/3yOYnWZ
         BXGrElHVDYsfYwRqQrY+ju03lG5w1JFx6HoaLxi+ToNFdbixRfcsrDSRv5MtWp90oseo
         GtCHMB1nzOUeVK3iUBFPlZcVSVZ6onTVSWzbQ2AdX2Y2sGLPhUV2YYFhBoyy0RaFuo3Q
         BVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=MtwX6PfEP7vLJDdIVNKheHf5WKk2ffhaPsYXNf4Tj2g=;
        fh=ALiLldveXUy0qUBRALW1ZadvMnZ0H9XhwdzNO1LsAMk=;
        b=H2lDb1aELWOvTprqpR+QJuaDyJj4CoZnEz9nMBkS46plUdCj82/D7bihr1PTss3ptd
         5wNSy5o1Xfl9c3jvOhjkQaU+CSxzkGHEhiWnHJL+6ls6AFt98m8Y5WSZrt56Tc7Z6Df4
         tSgwA3x9HUp7wGGPOPLlz4vCDMy+NsUh7BN9WBQIDx/SEgAaXU61TI6k/snbVGwWJ5kY
         jmM7UXPE56FLV0xqTlWd+5HQV+xAHVtB+idpmBCnOhEXElSyxOOr/jb21BzeQqQ+q3lg
         vN4vk6Y+QUkOmR6uM02q6m8GXNfsGt76HeFd9D4jjTEbJpkXZvOS/j4Bl3uQuHyVugfk
         f0tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782852306; x=1783457106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MtwX6PfEP7vLJDdIVNKheHf5WKk2ffhaPsYXNf4Tj2g=;
        b=jkcYD9pZaWwoHtM7XJTFnvXYHcm6oLeNEg+Wp/0BoljdGPLBm4rnI5hX+RCL6yA/PL
         0pDf3BxhLwOz5AVACz8wbk/gbIEXoyS16qpvi7/4QO1TFE6lblkjwKNwKFzQc753oJyI
         ZM9nlthBaYtJtU6pYoE1g2aw7XDpD2qEWRHiQSF87zGyZ+2eMgIiUz8gn8ahvKbrKLyX
         zAESAdjGWdh3cZGSmp/ifeIolSc/p+NqDpQyD5/fq8fVOgY7EaRsRmgU77wQaaxcWxWy
         WqEteKtCeO9uRnMJbCs7n3PfSKp4yKtAy5uiWm6GMlUCEbnwAcStgigUov6Kk24I196E
         twow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782852306; x=1783457106;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtwX6PfEP7vLJDdIVNKheHf5WKk2ffhaPsYXNf4Tj2g=;
        b=NKBuPF18HHXkQFpKN2kyD2pbwh+TP9mu2wTVO0lnvFQ1ISUBPfWZWtTygJhGJhyNJM
         PhHkmnrfu54hDmWMDveP1flmcDvg0LllhbHVK9cVIFDjiZ0GslGeXzVXPgCxKDDRaOTM
         uwIfCq4nXDHWypZW1PTQ6M9FN0hvgwvmP5s8m++DwjrUOvQFdXpXXT72/EXQ51/7Ah8D
         cg7EF10NEREPB/ryMs+wJiMh2Ttts8LKbX5PnikfvachkmrpE7q9LjI+BenUKzTTOEnw
         tGw7WHFqb9hjne+YwLvFnRAoEH2dRg/GIJoMLlcQ6SKXCoF8jrLQ67ELm0D6TXwaghRl
         hPgg==
X-Forwarded-Encrypted: i=1; AHgh+RqMgrkp84YOdC435KvOHJ82ts+0Z/PBBOQEAvi+oB9+w4X3Nq1k192TbcqtYN2xEl9/5B/baykUW+/6E4QQsJ+/EG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAv8oKgC2nDbxf5Ep/wOlI02TJkVRY2A+t2fEznVPU1NB3fctc
	LCVuVLg+QNX8JiDyF5g7wO7M6xa4QmONcJ4gFlEw4Ggwwjz6Y3eZEyRV9ARtEuZty7E6MqwDDrx
	3XA/r2JHqus1e6n93RM6CqMI9SqF3jt3x2yiH
X-Gm-Gg: AfdE7cl+XtHi8Qi6lmsu42QeCr0hlKulEnERnfqwp7lsPMgsYTe+1pK/khW3tU2m7cs
	jYjXnOxh/qIvVVtq+X8G3Eqr9FUjzKnlbrVFWRraoc9LQU0D0ZIaBIiXvDXQS4PklMzfL125aTU
	FlnPhML6gtGE80BHt7uaPmh4pyLoCb1S9bEiPePyDcB1FAmuOsjkkfBuQDav7VoSA4SDneS0C8m
	iXjdz3eA5IwukuhdFQ2niD5UFMuMySAhPcC8sOld6dqdEL/tRu0JxSTDmp5rB95vp91OSDkLdpU
	+qsxzM0=
X-Received: by 2002:a05:690c:6912:b0:80f:b0f1:920c with SMTP id
 00721157ae682-81203a60facmr20422467b3.53.1782852306018; Tue, 30 Jun 2026
 13:45:06 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 30 Jun 2026 13:45:05 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 30 Jun 2026 13:45:05 -0700
In-Reply-To: <20260630101425.2f7cfbea@robin>
References: <20260628004653.28065-1-alhouseenyousef@gmail.com> <20260630101425.2f7cfbea@robin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Tue, 30 Jun 2026 13:45:05 -0700
X-Gm-Features: AVVi8CfPpykxJeh9g49b2nCgR12RbQluTGo5GKFcbxCkdcVQKbYEtKEQr2I9N-Y
Message-ID: <CAMuQ4bV-HJWbS7NHPGtoyKz-_+LR335phbXeOi83EbV6kn+3gg@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: serialize read-page order with subbuffer resize
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, petr.pavlu@suse.com, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

One issue turned up while checking the suggested locking:
ring_buffer_subbuf_order_set() writes buffer->subbuf_order before
taking reader_lock and never takes cpu_buffer->lock. An allocator can
therefore take cpu_buffer->lock after the new order is published but
before resize clears the old-order free_page, tag that old page with
the new order, and return it.

I can keep the allocations outside buffer->mutex and hold the mutex
only while snapshotting subbuf_order and taking or returning
free_page. That removes allocation from the critical section and
serializes the order/free-page pair with resize. Would you prefer
that, or should free_page and the order transition be synchronized
another way?

On Tue, 30 Jun 2026 10:14:25 -0400, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Sun, 28 Jun 2026 02:46:53 +0200
> Yousef Alhouseen <alhouseenyousef@gmail.com> wrote:
>
> > ring_buffer_read_page() checks that its spare page has the current
> > subbuffer order before taking cpu_buffer->reader_lock. A concurrent
> > ring_buffer_subbuf_order_set() can change the order and replace the
> > reader page after that check. The reader then copies a larger subbuffer
> > into the old allocation, causing an out-of-bounds write.
> >
> > Keep spare-page allocation and release under buffer->mutex, which already
> > serializes order changes. Move the read-side order check under
> > reader_lock, the lock used by resize when replacing per-CPU pages.
> >
> > Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
> > Reported-by: syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=2dd9d02f60775ce5c1fb
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
> > @@ -6950,6 +6950,8 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
> > if (!cpumask_test_cpu(cpu, buffer->cpumask))
> > return ERR_PTR(-ENODEV);
> >
> > + guard(mutex)(&buffer->mutex);
> > +
> > bpage = kzalloc_obj(*bpage);
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
> @@ -6954,11 +6954,11 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
> if (!bpage)
> return ERR_PTR(-ENOMEM);
>
> - bpage->order = buffer->subbuf_order;
> cpu_buffer = buffer->buffers[cpu];
> local_irq_save(flags);
> arch_spin_lock(&cpu_buffer->lock);
>
> + bpage->order = buffer->subbuf_order;
> if (cpu_buffer->free_page) {
> bpage->data = cpu_buffer->free_page;
> cpu_buffer->free_page = NULL;
> @@ -7007,13 +7007,13 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
> * is different from the subbuffer order of the buffer -
> * we can't reuse it
> */
> - if (page_ref_count(page) > 1 || data_page->order != buffer->subbuf_order)
> + if (page_ref_count(page) > 1)
> goto out;
>
> local_irq_save(flags);
> arch_spin_lock(&cpu_buffer->lock);
>
> - if (!cpu_buffer->free_page) {
> + if (!cpu_buffer->free_page && data_page->order == buffer->subbuf_order)
> cpu_buffer->free_page = dpage;
> dpage = NULL;
> }
> @@ -7091,15 +7091,15 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
> if (!data_page || !data_page->data)
> return -1;
>
> - if (data_page->order != buffer->subbuf_order)
> - return -1;
> -
> dpage = data_page->data;
> if (!dpage)
> return -1;
>
> guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
>
> + if (data_page->order != buffer->subbuf_order)
> + return -1;
> +
> reader = rb_get_reader_page(cpu_buffer);
> if (!reader)
> return -1;
>
> -- Steve
