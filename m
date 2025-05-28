Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF25321A440
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 May 2025 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748445398; cv=none; b=BAaZEL58dFZl+ejz8HhgaS4VfjQBJYxFtaO0O25H7vVHzekeGlu6osINf3OJFNL9R1bjCYV4uKiaFR7fHwQm/8JQ40qIzbZ59lnx+LwumZhRSTCuZeulwAXc5N6eT0AbinIY9H+sZnTz5PIVwb3agfcA80F2hBsnMMOTL5Vz+Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748445398; c=relaxed/simple;
	bh=HKtMs1Z1xsEaiROa1YazGcStiDxVpMzzYhroj5kvTy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VqORs6R8F5Ws/r4fnS/rS6Xkbjy4Qoas1vm5WRqn5W53cyCdQf/A7SmekCcHF16QP+Rdth68584YJZrGmwXLRQfUpkWd+5OXXHfx7n/UsqdFdwvVW6wS1PkfPYH4VJetiCt0VUwDmSGLWMQtoj0yXWmMQHuIoHh7NtxIhXBvh9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=U5qcrL7i; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="U5qcrL7i"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-af907e48e00so318393a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 May 2025 08:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748445396; x=1749050196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RzDNT2OTFzwrTpW2QhZAxDyX5hWvQosjJ6d0+XM2Bo=;
        b=U5qcrL7ilLdxcqy7X0mEhyQavrsLee2GkQB7ndvERj4ynKgbc/vtpi3N9DkL0+FGax
         r9Ikp/ya2iN4l2y4xDxU+iAkBwA3iVt61qV1oN0IfdDprMDFyiHP/Jew4aNVrSQDXsn7
         3nvnN8r7I9RvJ2NoD1fbw0B8BUXmgkl/Ym7efdkO14J8ifc8Mv+xSs0xN0AZmnie26+k
         HkoD5VkQSL/HQN1xhWpSRyTaRJQTROXw9sFhUhyxWgB4MWsLmfRnQf3+G6DRFtyiV+3a
         UhLChLF9+vLplq35i4tdmPUTb/FS7SIXwwl/OCm+WBq7TBpDnIFLU5h8k4hC4+/obsra
         n54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748445396; x=1749050196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RzDNT2OTFzwrTpW2QhZAxDyX5hWvQosjJ6d0+XM2Bo=;
        b=rM2TlwqjiN8vvEkoKouZTmIk7+wXcrfg9BLMiNBJkbhg9OHqGbWRPPnzqeSMH/QZ8b
         brOZsiq9lPlcKVl8a5s5AC8+iapvg5QE7LFjTMFwXFDN4/GzZEkQ4uYtdy44KuHithYU
         qWL6WISjc+UUf0rWy2PUHgWb1raudWJOYXPrOzquWG8uY8E20wW10DmQCUUXnlbuCVAL
         bka16omqDLwyVQu+vUjWURPzUnxUm2EFeKpan142EiM/z1GAEQEUhfNqe6FwC8RJvoUI
         20klHkIgNTqtgLz4b5r0hfcGwyS4WbosmQh4Du2MPLV+VNMx8NAZJwa5SuqTqjqp2W4s
         8gAw==
X-Forwarded-Encrypted: i=1; AJvYcCXId0nczz7ruALyuTEy++flc9UGKrnWCRlRQZFfVfdDThgcL1ydgz0ewW/1Pxu5K8TxWEf4+S4JZHk41qQJHzT3HDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHkcYKFZ8ShsRj9S9qKG3+WTsapaVVtnSrJFI5uVqkknvZPQKa
	Rwcekn3zebeRW+VSriKWWBBLHAI0mI2nM653ig9PmQleGMPnbwxgr1vtyTsPnLQmC4p7qP9qmMq
	6MkcDokwPG/oaA4k9xt5f0Q7ueaMqw9LiuUCnh8LsBQ==
X-Gm-Gg: ASbGncuQSvMMExypfu/u1RT7E4wEj/6FGzHLSOgfMPsBdsF1dk8lxv1mehXZG5fJFSX
	TNMY7u9Tiy/RvM70CVrKcr2QERy/BarhLDWc5a+joJ+k2Wc76TkM+IX+2uhqo2vjc9WJUWi41rY
	eZMldU79WgIq2hrXoC1dbriaejDdCv8kqR
X-Google-Smtp-Source: AGHT+IHk/hFwszn+lGW4RY3KI45JUHzvCbI/GU7IlZ6KImluQy2hWku6LQLjd67CNr1rcUJjul/qPMYZDMndG3LG9Mc=
X-Received: by 2002:a17:90a:e7cd:b0:311:c5d9:2c8b with SMTP id
 98e67ed59e1d1-311c5d93147mr3267754a91.5.1748445395685; Wed, 28 May 2025
 08:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411161746.1043239-1-csander@purestorage.com> <3ucksa6coiwco3wpmcjtfwezqjigzm2zwvdvkt2ryvefzojtqy@4lda47c236uz>
In-Reply-To: <3ucksa6coiwco3wpmcjtfwezqjigzm2zwvdvkt2ryvefzojtqy@4lda47c236uz>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 28 May 2025 08:16:24 -0700
X-Gm-Features: AX0GCFuDb9gBXu2ZIGF6ICRVSiBRQ0nrfOWmiTmw7s1LAbIKsh9w7lElDPYOc0M
Message-ID: <CADUfDZpPGQEY9u3p3MCU2S3qmDyKmE1JnSQ6G2jO4_J40rQeeQ@mail.gmail.com>
Subject: Re: [PATCH] mm: remove unused mmap tracepoints
To: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Eric Mueller <emueller@purestorage.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi MM folks,
Would you mind picking up this patch to remove some old tracepoints?
Liam has already given it a review.

Thanks,
Caleb

On Fri, Apr 11, 2025 at 10:23=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Caleb Sander Mateos <csander@purestorage.com> [250411 12:18]:
> > The vma_mas_szero and vma_store tracepoints are unused since commit
> > fbcc3104b843 ("mmap: convert __vma_adjust() to use vma iterator").
> > Remove them so they are no longer listed as available tracepoints.
> >
>
> Thanks for doing this.
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>
> > Reported-by: Eric Mueller <emueller@purestorage.com>
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  include/trace/events/mmap.h | 52 -------------------------------------
> >  1 file changed, 52 deletions(-)
> >
> > diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
> > index f8d61485de16..ee2843a5daef 100644
> > --- a/include/trace/events/mmap.h
> > +++ b/include/trace/events/mmap.h
> > @@ -41,62 +41,10 @@ TRACE_EVENT(vm_unmapped_area,
> >               __entry->total_vm, __entry->flags, __entry->length,
> >               __entry->low_limit, __entry->high_limit, __entry->align_m=
ask,
> >               __entry->align_offset)
> >  );
> >
> > -TRACE_EVENT(vma_mas_szero,
> > -     TP_PROTO(struct maple_tree *mt, unsigned long start,
> > -              unsigned long end),
> > -
> > -     TP_ARGS(mt, start, end),
> > -
> > -     TP_STRUCT__entry(
> > -                     __field(struct maple_tree *, mt)
> > -                     __field(unsigned long, start)
> > -                     __field(unsigned long, end)
> > -     ),
> > -
> > -     TP_fast_assign(
> > -                     __entry->mt             =3D mt;
> > -                     __entry->start          =3D start;
> > -                     __entry->end            =3D end;
> > -     ),
> > -
> > -     TP_printk("mt_mod %p, (NULL), SNULL, %lu, %lu,",
> > -               __entry->mt,
> > -               (unsigned long) __entry->start,
> > -               (unsigned long) __entry->end
> > -     )
> > -);
> > -
> > -TRACE_EVENT(vma_store,
> > -     TP_PROTO(struct maple_tree *mt, struct vm_area_struct *vma),
> > -
> > -     TP_ARGS(mt, vma),
> > -
> > -     TP_STRUCT__entry(
> > -                     __field(struct maple_tree *, mt)
> > -                     __field(struct vm_area_struct *, vma)
> > -                     __field(unsigned long, vm_start)
> > -                     __field(unsigned long, vm_end)
> > -     ),
> > -
> > -     TP_fast_assign(
> > -                     __entry->mt             =3D mt;
> > -                     __entry->vma            =3D vma;
> > -                     __entry->vm_start       =3D vma->vm_start;
> > -                     __entry->vm_end         =3D vma->vm_end - 1;
> > -     ),
> > -
> > -     TP_printk("mt_mod %p, (%p), STORE, %lu, %lu,",
> > -               __entry->mt, __entry->vma,
> > -               (unsigned long) __entry->vm_start,
> > -               (unsigned long) __entry->vm_end
> > -     )
> > -);
> > -
> > -
> >  TRACE_EVENT(exit_mmap,
> >       TP_PROTO(struct mm_struct *mm),
> >
> >       TP_ARGS(mm),
> >
> > --
> > 2.45.2
> >
