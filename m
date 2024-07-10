Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41041922E3;
	Wed, 10 Jul 2024 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720635722; cv=none; b=XsHo/YaBMpuNwc4hoVt44xmgVgjAcmmv9NkeV3HmqEzApFziwfbtnC4pqcpuVX50uS267mjz88/Mdm28AcuKWjmSQdKne5WlOqtnE8tYJcu4kAvAAGshZfV+19vcCNXpibwppTSQRBWOsuLCQuWLrVVCnkHmZ2S1QwX2RT80AKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720635722; c=relaxed/simple;
	bh=JhqOtN7Nt4JZLvleltSaa3gZnSb0/3zsfDrUcKoA6rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exdbhxyKyXgE5FmwUSnU6ajiZV6DiTKpnFbDRcUEYomzs/dPCyxUkB8zEsgE4geMuea66x2Gk0nV6/2svD223DuMAJW8arzH/EaJEG6Ubh2ov/KQz/hy/88gNsmp46uCGBHjJH+b4I+sflzeB2Mk9ybMQFsVGV1X6l4jYLWaMr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfsP4bjL; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfsP4bjL"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so4084a12.1;
        Wed, 10 Jul 2024 11:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720635720; x=1721240520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hijJCwlZElP88i4ewoTv3B36SaCunX2cH9w3pYqOHaM=;
        b=WfsP4bjLrtLSyx4ZDMI8l/J7qqTgALcgMPEciYB77UZsSAF8yY3IwxZSqybWLZiUWF
         UQm/pZhwOooxQoN2OPXilynYScqRSNJUFLNkYVszxAtYLj93YtCiraqwCxX7JNFY0N9a
         exkqiqrPGup5/nq/NTPABke51FQtG6xzLZeJ2iPEh8GpzPqSAd2ilZbm22VaC1a4HTxt
         mLF2BsYyweQT3kZ5KnfpvEtiVAp5ZUTW0t9E3S0x+p2VpAQR8EbEbYiAJ5iehBI50Knf
         GCx4prJg0ZvuMSk3Ebb+x2TJiKE+9W3n/nAupjqbJ2dytlnf8P+bvlSmuRWNq3nj2OlM
         3ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720635720; x=1721240520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hijJCwlZElP88i4ewoTv3B36SaCunX2cH9w3pYqOHaM=;
        b=k6CFdzVg/mIbCHoRl2Uh3g1G0ylCQ2o9GYczwozRUGpAbtr6b80hfLZURGh1VtMMz/
         O+Fcdw7+WlbbdxivaM1joKmMokDJZo/FQp+SrDBahwzieMjuSi6S/ZxVIiDEsOAe9pCw
         IFrSsPV8t859p4+b4mZwVKwHxT6E2AYzDfEOtP+DT4llYjoXuy4lxzZjvhWP2IT61lJ2
         /nbRWw2i55+aLp/cg5p3S2u0HiJWGukmmHzhi149Fn2QbjumdOXAh/RjFhkADbZ9HOcE
         uXcxbAtgczgjFOD9NTR9RTY7xjzT/of8l7VHOFo1pjiFT+Oyk4tLqpqbWgz+qjEckWBe
         AfxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvOARfvRlePMayMTvTyNHb6NzANgJh5pAS8fOhZSqNTnW6LQ+bA0mqAMCdrvCP57Y9KYl+tFFbubhBJNdox3y3Z/oBznTuYSnBl1skC3bKkZMnPnVQX0aUeF1ahcmGrJqwXA+ynqyw+dYFQFT16Wnd
X-Gm-Message-State: AOJu0YwYkHuO2LAMTMpViTPTIU76E9ZX0c9Jnxer3ErZzg+uZdA4c8zN
	qzLuMFY7C3PASVt/I1sf/UshQsrUmWxEORqF1oW92sS/Gv7hk1fFhQIzB5RASPzAa0KNl76/y/V
	arL7r5CTcPB79lpmMOEu1cH0kFA0=
X-Google-Smtp-Source: AGHT+IEOEXFcihCKMkga13FImtABbjE3JVDkFjywdAZCA6bcksqB7C829APoE+r8J/9VoRjRiwurJuvc1T+BQC/f6JM=
X-Received: by 2002:a05:6a20:918d:b0:1c2:911f:4d30 with SMTP id
 adf61e73a8af0-1c2982163cemr6971863637.3.1720635719815; Wed, 10 Jul 2024
 11:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710140017.GA1074@redhat.com> <20240710163022.GA13298@redhat.com>
 <20240710163133.GD13298@redhat.com>
In-Reply-To: <20240710163133.GD13298@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jul 2024 11:21:47 -0700
Message-ID: <CAEf4BzZa0Ye83QfTbw6Sw3ERg2PJ7ioN_pEFHYui6JGEHhOg4Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] uprobes: make uprobe_register() return struct uprobe *
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org, clm@meta.com, 
	jolsa@kernel.org, mingo@kernel.org, paulmck@kernel.org, rostedt@goodmis.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 9:33=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> This way uprobe_unregister() and uprobe_apply() do not need find_uprobe()=
 +
> put_uprobe(). And to me this change simplifies the code a bit.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  include/linux/uprobes.h     | 14 ++++++------
>  kernel/events/uprobes.c     | 45 ++++++++++++-------------------------
>  kernel/trace/bpf_trace.c    | 12 +++++-----
>  kernel/trace/trace_uprobe.c | 28 +++++++++++------------
>  4 files changed, 41 insertions(+), 58 deletions(-)
>
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index aa89a8b67039..399509befcf4 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h

I don't see struct uprobe forward-declared in this header, maybe we
should add it?

> @@ -110,9 +110,9 @@ extern bool is_trap_insn(uprobe_opcode_t *insn);
>  extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
>  extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
>  extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_st=
ruct *mm, unsigned long vaddr, uprobe_opcode_t);
> -extern int uprobe_register(struct inode *inode, loff_t offset, loff_t re=
f_ctr_offset, struct uprobe_consumer *uc);
> -extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprob=
e_consumer *uc, bool);
> -extern void uprobe_unregister(struct inode *inode, loff_t offset, struct=
 uprobe_consumer *uc);
> +extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset=
, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
> +extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *u=
c, bool);
> +extern void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consu=
mer *uc);
>  extern int uprobe_mmap(struct vm_area_struct *vma);
>  extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long star=
t, unsigned long end);
>  extern void uprobe_start_dup_mmap(void);
> @@ -147,18 +147,18 @@ static inline void uprobes_init(void)
>
>  #define uprobe_get_trap_addr(regs)     instruction_pointer(regs)
>
> -static inline int
> +static inline struct uprobe *
>  uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offse=
t, struct uprobe_consumer *uc)
>  {
> -       return -ENOSYS;
> +       return ERR_PTR(-ENOSYS);
>  }
>  static inline int
> -uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer =
*uc, bool add)
> +uprobe_apply(struct uprobe* uprobe, struct uprobe_consumer *uc, bool add=
)
>  {
>         return -ENOSYS;
>  }

complete aside, when I was looking at this code I was wondering why we
even need uprobe_apply, it looks like some hacky variant of
uprobe_register and uprobe_unregister. I didn't dig deeper, but think
whether we even need this? If this is just to avoid (for some period)
some consumer callback calling, then that could be handled at the
consumer side by ignoring such calls.

callback call is cheap, it's the int3 handling that's expensive and
with uprobe_apply we are already paying it anyways, so what is this
for?

>  static inline void
> -uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_cons=
umer *uc)
> +uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
>  {
>  }
>  static inline int uprobe_mmap(struct vm_area_struct *vma)

[...]

>
> @@ -1133,41 +1126,39 @@ EXPORT_SYMBOL_GPL(uprobe_unregister);
>   * refcount is released when the last @uc for the @uprobe
>   * unregisters. Caller of uprobe_register() is required to keep @inode
>   * (and the containing mount) referenced.
> - *
> - * Return errno if it cannot successully install probes
> - * else return 0 (success)

mention that it never returns NULL, but rather encodes error code
inside the pointer on error? It's an important part of the contract.

>   */
> -int uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_o=
ffset,
> -                   struct uprobe_consumer *uc)
> +struct uprobe *uprobe_register(struct inode *inode,
> +                               loff_t offset, loff_t ref_ctr_offset,
> +                               struct uprobe_consumer *uc)
>  {

[...]

> @@ -1186,35 +1177,27 @@ int uprobe_register(struct inode *inode, loff_t o=
ffset, loff_t ref_ctr_offset,
>
>         if (unlikely(ret =3D=3D -EAGAIN))
>                 goto retry;
> -       return ret;
> +
> +       return ret ? ERR_PTR(ret) : uprobe;
>  }
>  EXPORT_SYMBOL_GPL(uprobe_register);
>
>  /*

this should be /** for doccomment checking (you'd get a warning for
missing @uprobe if there was this extra star)

>   * uprobe_apply - unregister an already registered probe.
> - * @inode: the file in which the probe has to be removed.
> - * @offset: offset from the start of the file.

add @uprobe description now?

>   * @uc: consumer which wants to add more or remove some breakpoints
>   * @add: add or remove the breakpoints
>   */
> -int uprobe_apply(struct inode *inode, loff_t offset,
> -                       struct uprobe_consumer *uc, bool add)
> +int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool=
 add)
>  {
> -       struct uprobe *uprobe;
>         struct uprobe_consumer *con;
>         int ret =3D -ENOENT;
>

[...]

> @@ -3180,10 +3181,8 @@ static void bpf_uprobe_unregister(struct path *pat=
h, struct bpf_uprobe *uprobes,
>  {
>         u32 i;
>
> -       for (i =3D 0; i < cnt; i++) {
> -               uprobe_unregister(d_real_inode(path->dentry), uprobes[i].=
offset,
> -                                 &uprobes[i].consumer);
> -       }
> +       for (i =3D 0; i < cnt; i++)

you'll now need !IS_ERR_OR_NULL(uprobes[i].uprobe) check (or just NULL
check if you null-out it below)

> +               uprobe_unregister(uprobes[i].uprobe, &uprobes[i].consumer=
);
>  }
>
>  static void bpf_uprobe_multi_link_release(struct bpf_link *link)
> @@ -3477,11 +3476,12 @@ int bpf_uprobe_multi_link_attach(const union bpf_=
attr *attr, struct bpf_prog *pr
>                       &bpf_uprobe_multi_link_lops, prog);
>
>         for (i =3D 0; i < cnt; i++) {
> -               err =3D uprobe_register(d_real_inode(link->path.dentry),
> +               uprobes[i].uprobe =3D uprobe_register(d_real_inode(link->=
path.dentry),

will uprobe keep inode alive as long as uprobe is attached? If that's
the case we can get rid of link->path (have it only as a local
variable which we put as soon as we are done with registration). We
can probably do that clean up separately, I'll defer to Jiri.

>                                              uprobes[i].offset,
>                                              uprobes[i].ref_ctr_offset,
>                                              &uprobes[i].consumer);
> -               if (err) {
> +               if (IS_ERR(uprobes[i].uprobe)) {
> +                       err =3D PTR_ERR(uprobes[i].uprobe);

we can NULL-out uprobe on error for bpf_uprobe_unregister() to handle
only NULL vs non-NULL case

or maybe better yet let's just have local struct uprobe variable and
only assign it if registration succeeded (still need NULL check in
bpf_uprobe_unregister above)

>                         bpf_uprobe_unregister(&path, uprobes, i);
>                         goto error_free;
>                 }

[...]
