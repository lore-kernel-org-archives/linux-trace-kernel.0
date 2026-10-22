Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792710697;
	b=x4JCwADuyhZZDfI2U6EEGZh6sV6/50Tp0psj97Jv3pYjpRJ2dy0wPf9BLO6/dNkQD23v
	 9R7Q3zkQnK4Y3lKNjAYg3UwD0Dvat9yYfPNfhG8qVxY2aBVyHQLqSnlfVPIuFQaKzeTe8
	 Lp3h0lcRgmmYdGgyHoAiYXkSLe0n1IWSXO4E2GGogEi0khCXFVLqic+CcPdRR5NuxJwrH
	 qkcyK854Kgr1Xz6G/eKtWSbf7w6jeJmRyAV9enSLE5ylj0KXNHp98zK/pJvjBnsY8wQWp
	 AsyomT1W4OwqoKITPZZdugVLWsPanBqzeVVsqwMUu33Ssk28S5vsC7u/6Wu8k/dVQaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792710697;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=u9FF5OWfzsi4DyrpW60LLUMz1VcIwydXpbxb65LGd/A=;
	b=KKx7RvNgV2z0k0k6QLFwrZNYvu0ih9WpWOur8eUPac/AgJfNo26JI61yaIfP9TLSaQOS
	 SpxXggjyc/uXUpGvezCSWl/Ipn4YiW4ldv5GiwBsT6v0R6m4jAueVWE2qso2HidbLJrGe
	 scc20AwIVwvqsIssNyrvW5HIx5ZLZ2w7XUFPn3z+Bn8nFVHHPGS3+CLUVJaeuEthLp2cn
	 Hpoev4k9D9LCodbNAxbn4unqaatasGIA3Z3qGmLxTr2pM18NKbCSFBlOtacC5RnmTcMt6
	 Zd+TtQG2SVM8sRV2JRXJcef1DHMyX5rXhUkPIRqIZ0479entynXHPGGwI22OrIMPnCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="L/tELMm6";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD41606A31A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 23:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AD41606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L/tELMm6
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so244055a91.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 16:11:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792710696; cv=none;
        d=google.com; s=arc-20260327;
        b=HEwevFcDEjhA1jZX6TWNANMLPQggBWRiw1yXI2i8GtvrNxKproqqwea8upA5A3a1yu
         lZcEwv9PE63K2PuFcffKnbgeV3PwjtnCnITxSLRWhAG0cmSOkatDnWEkaxRp8qCQsAhk
         CLgOFBH4Af5sShppzb+iwfybSBZ5p/G7owJcWFheJX79Q9U1BhJbZbkCwl9rGBU+553c
         tEebqgmD4l5Kxq5blBD7IuuD+rW/XqGsi7UiEz1zYqoc7/yYLlDIkp0Rlprqrm7l6chr
         bmDgCRhE9cWO96s+sPIZETWY4zLp+qZQNxls1rcQvgxufcNXRr+wkXx+IPup9CW/rFF4
         3oyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u9FF5OWfzsi4DyrpW60LLUMz1VcIwydXpbxb65LGd/A=;
        fh=fMRP4fYh/9bWKr56/v/ZE8RU4yU/urH0YBOXl2EdGTE=;
        b=ZugkK2lxvmcvvyewy8WPDrF6xux1foU2QKrY+3/xOV+/iJttL7J4T5hR1fgBiR+k/W
         82EBaQXerwSOYCBOv7JzoKoJYWPIZ0dm7bV0iNa/1cGCB854fmOuJ6zvPgCcx2ARE7L8
         UtZnXIJz93bXVsEHOxajMMIw/uPIFAf9og5kUtmwMuDll0vYFWZotbSlbWvtC9OdnWhj
         KzZOWMdFzS8ppqgrsTWhVPbOQ5BG30LWKlYe2H8308pWYDFD12LjmPvX9MWXQYzFPY/+
         UNZ37NMLUgnwvbfOJPGqPVjjCAeCkU074k5zobCZ+RlwNHAAT+FPVkvbj+GgtQi+b3AS
         O/og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792710696; x=1793315496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u9FF5OWfzsi4DyrpW60LLUMz1VcIwydXpbxb65LGd/A=;
        b=L/tELMm6jIUKzclV/xG4I2WKyVgupyfttBTneMTpnZLJvyszCXMB2wwnwH152cnFVs
         dpSEiFHs6xNYQfcv9A+ZV2tYBlmvDJAq2r3g/YNI8FUSpsXE/iXzKvNLmqDwEk5idJFU
         x9LIynNIIh0OkXHLLn3NZRvjV8su2mXrQp/LaKFaPLqkVQuZQ2YsWMyFOeSlJgDv0NZ/
         qm4hhC9sW2wNv5YQah5Dk/vdEkNJOu2lcDfXkvAW3OmFjb+zyoJJFpRNSa0g/7mvdCQO
         sO2a1U8zOsimUFUOhO9TEOEWozPst2Kr0SW+O5YVsa9//xIIAelVbuyfCgiuXtYtHFQo
         3AWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792710696; x=1793315496;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u9FF5OWfzsi4DyrpW60LLUMz1VcIwydXpbxb65LGd/A=;
        b=F8HE5S+mXih04hkrmLwSFa55+B+IYvGySeP/chv4FT/+ppMuRjqtpAp8Znb9K/2DvW
         WQ+eLUTwy9w3KBGoiptMF6bWAyxBe1h8xj/Z86C0RaWVEKLJRWkpuAPgzA+FxIztQ2KM
         JSjWnOzSU8Z7KBBW904fvPAhGtoxidf/6F5qVQJuZrQdSgmV5aH4tdjs5MfAWFrddXWz
         TAXWTx6t7PRwOWG2A1UyaayTZg/oznc8s/TWove6wqy2ucEzkLFOU3wb8tkHjAmCs6RE
         CjM4LSK4kpmvoYfUOmmi10ZbVmixN3EONW2C9gyWnbKbUno1SKYmCf5X/prSA0wxIpV5
         FloQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXQhwafgQxkGM2ZuIh/B0VihptV59pa5obfVNdJmx5CxsqS+reHVeWSk4NuL0Y5Z7Om3N+t4VwYA8cmY+xBUgH2dU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFOlWtzRjxsq5OPNxa8QgrbV2vxZE+OnqAk1/4S/R/zH6vicmH
	+epp02kglajn3/M8qVcmvdm0kAMm5cyTcK7qaeCgqk1hO2n496Iob4lcpPiVeyiLvIgROH4wyaE
	jbQ9NtKvJ7LOQSzB1Ix4sT7TgUzfIuxk=
X-Gm-Gg: AYBFou1dfZhOUUSyfloJXbRSACtoc/CJ7X5tI9+tRMx0A+7YE+Gnb4p6Js3L9OJyAlc
	WjxMBfpiI/oRdWSKjtF2QmXs52l2jixvcDLZgV8OiasO+9I9osSnAImsy9y5BoVFxF/6TavJx8N
	DfWqq5KhC8WwL6rB7h6oGamzfQrSEhjpk1GLrVzSvOSzeCN7vJi6YeX4SqfPOh42i1FKrOVOljI
	/Z6hRZt9ry5y61EVHVLHWuoS3gLlSkdjOsoriLvdA4U+DXKFMxi60BBh7solIHj3feNDvNFMcrY
	tEIK0jjQV34KjPSwhtee9AGwxsBW54r6jdmk5hNWY+Yji7ttQFIelfzvr62VDNFxAYKObLPZjT+
	R7S64zlNfEZYffr1Z9FZjZNheSts+EFuGmQ/IZx7Ymd+e1dKsXQRp3wqqOkY9dxhJjoQPepOFVW
	OPe9aVQxyEB9uuKTVx9HJaz9nqxOvu+O4y3g==
X-Received: by 2002:a17:90b:3fcc:b0:3ac:7377:fd48 with SMTP id
 98e67ed59e1d1-3adce14f242mr304117a91.56.1792710695710; Thu, 22 Oct 2026
 16:11:35 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com> <20261022015712.1297331-6-alexei.starovoitov@gmail.com>
In-Reply-To: <20261022015712.1297331-6-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Oct 2026 16:11:20 -0700
X-Gm-Features: AclHuK8s6DwZCvueetumGiOa-ygE3J-xVZ2OzdSVggL1R0XHASR0IqYhKSbBJKQ
Message-ID: <CAEf4BzYs_Kis9ghhwnM3qWSCWRBwEtaZy5Xk+CJjYH3q0E9bNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/9] uprobes: Don't sleep on mmap_lock under dup_mmap_sem
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, oleg@redhat.com, peterz@infradead.org, 
	mhiramat@kernel.org, jolsa@kernel.org, akpm@linux-foundation.org, 
	liam@infradead.org, ljs@kernel.org, surenb@google.com, david@kernel.org, 
	vbabka@kernel.org, jannh@google.com, hughd@google.com, kees@kernel.org, 
	mingo@redhat.com, tglx@kernel.org, x86@kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 6:57=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> register_for_each_vma() takes dup_mmap_sem for writing, collects mms that
> map the file and takes mmap_lock of every mm. fork() takes dup_mmap_sem f=
or
> reading. When mmap_lock of one mm is busy every fork() in the system wait=
s
> for it:
>
>   A:       mmap(MAP_POPULATE) -> mmap_read_lock(A)
>   tracer:  percpu_down_write(&dup_mmap_sem), mmap_write_lock(A) sleeps
>   others:  fork() -> percpu_down_read(&dup_mmap_sem) sleeps
>
> Only trylock mmap_lock under dup_mmap_sem. Leave mms with busy mmap_lock =
in
> the list, drop dup_mmap_sem and then wait for them.
>
> dup_mmap_sem makes sure that mm doesn't fork between build_map_info() and
> install_breakpoint() or remove_breakpoint(). Otherwise the child misses
> the breakpoint, or inherits the breakpoint of uprobe that is gone and get=
s
> SIGTRAP. Now mm in the list can fork. dup_mmap() holds mmap_lock of
> the parent, so uprobe_dup_mmap() does what the walk is going to do to thi=
s
> mm before vmas are copied. The walk sees info->done and skips it.
>
> The error in uprobe_dup_mmap() is the error of the walk, unless fork() is
> being killed. Such fork() fails in copy_process() and there is no child, =
so
> leave mm to the walk. With ref_ctr_offset the walk can update the counter
> twice in this case.
>

fwiw, none of the above blurb was really helpful, I had to read code
to actually get the high level idea of the patch. If anything, commit
message would be more helpful if it had less technicaly precise
description of what is being done, but rather a more high-level idea
to get the reviewer started. I don't know how much persuasion you'd
need to make your AI do this, but I think it would be helpful going
forward, especially for some dense stuff like this uprobe
registration/unregistration piece.

But as for the fix itself, it feels like the real problem is global
dup_mmap_sem lock, no? What if instead of one fancy (per-cpu) global
rwsem, we just have a per-mm rwsem. register_for_each_vma() will take
each mm's uprobe dup per-mm rwsem first, and keep it for the duration
of uprobe registration. In dup_mm() we only ever take mm-specific
rwsem, while register_for_each_vma() does a more heavy multiple lock
taking. But other than that we don't have a global uprobe walk list,
we don't have to handle registration/unregistration in two places,
etc.

I might be missing some remaining races, but I thought I'll propose
this and see if this idea has legs?

> dup_mmap_sem protects the list of walks. mm in the list is kept by
> mm_count. The walk takes mm_users only for the visit, so the process that
> exits meanwhile frees its memory.
>
> Busy mms are visited last. The tracer that is killed while it waits for o=
ne
> of them has installed the breakpoint in all other mms and cannot remove i=
t.
> "uprobes: Don't leak the breakpoints if the unregistering task is killed"
> fixes that.
>
> Process A loops over mmap(4G, MAP_POPULATE) and munmap(). A and 10 idle
> processes map the file. Process B calls fork() in a loop. 32 cpu VM.
> Median (max) of 15-25 runs, msec:
>
>                          the longest fork() in B    attach
>                          before      after          before  after
>  uprobe_multi, 1 uprobe  197 (209)   0.33 (0.70)       210    233
>  uprobe_multi, 4 uprobes 421 (429)   0.38 (0.60)      1467   1532
>  perf_event, 4 uprobes   422 (439)   0.43 (0.59)      3135   3289
>
> During detach: 264-423 -> 0.35-0.47. Attach and detach still wait for
> mmap_lock of A. B doesn't.
>
> The tracer pays when traced processes fork all the time. mm that forks
> holds its mmap_lock, so the walk sleeps on many mms in turn. Fork storms =
of
> 1200, 2000 and 5000 processes, 6 cpu VM, msec, without and with the serie=
s:
>
>  enable uprobe event    105 -> 205   201 -> 481   207 -> 784
>  disable uprobe event   225 -> 294   354 -> 579   407 -> 893
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/events/uprobes.c | 178 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 143 insertions(+), 35 deletions(-)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 6792004be6fa..a9274016c55d 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1192,8 +1192,29 @@ struct map_info {
>         struct map_info *next;
>         struct mm_struct *mm;
>         unsigned long vaddr;
> +       bool done;
>  };
>
> +/*
> + * Every fork() waits for dup_mmap_sem, so register_for_each_vma() must =
not
> + * sleep on mmap_lock while it holds dup_mmap_sem. It leaves mms with bu=
sy
> + * mmap_lock in ->busy, drops dup_mmap_sem, and only then waits for them=
.
> + *
> + * Such mm can fork before its turn comes. dup_mmap() holds its mmap_loc=
k, so
> + * uprobe_dup_mmap() does what the walk is going to do to this mm, and
> + * the child has the same breakpoints as the child of mm that wasn't bus=
y.
> + */
> +struct uprobe_walk {
> +       struct list_head list;
> +       struct uprobe *uprobe;
> +       struct uprobe_consumer *new;
> +       struct map_info *busy;
> +       int err;
> +};
> +
> +/* dup_mmap_sem protects the list and ->busy of every walk in it */
> +static LIST_HEAD(uprobe_walks);
> +
>  static inline struct map_info *free_map_info(struct map_info *info)
>  {
>         struct map_info *next =3D info->next;
> @@ -1242,6 +1263,7 @@ build_map_info(struct address_space *mapping, loff_=
t offset, bool is_register)
>
>                 info->mm =3D vma->vm_mm;
>                 info->vaddr =3D offset_to_vaddr(vma, offset);
> +               info->done =3D false;
>         }
>         i_mmap_unlock_read(mapping);
>
> @@ -1271,26 +1293,79 @@ build_map_info(struct address_space *mapping, lof=
f_t offset, bool is_register)
>         return curr;
>  }
>
> -static int
> -register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new=
)
> +/*
> + * mmap_lock of info->mm is held for writing. info->done is set under it=
.
> + * The walk also tests it without mmap_lock, to skip mm.
> + */
> +static void register_one_mm(struct uprobe_walk *walk, struct map_info *i=
nfo,
> +                           bool in_fork)
>  {
> +       struct uprobe_consumer *new =3D walk->new;
> +       struct uprobe *uprobe =3D walk->uprobe;
> +       struct mm_struct *mm =3D info->mm;
> +       struct vm_area_struct *vma;
>         bool is_register =3D !!new;
> -       struct map_info *info;
>         int err =3D 0;
>
> +       if (info->done)
> +               return;
> +
> +       if (is_register && READ_ONCE(walk->err))
> +               goto done;
> +
> +       if (check_stable_address_space(mm))
> +               goto done;
> +
> +       vma =3D find_vma(mm, info->vaddr);
> +       if (!vma || !valid_vma(vma, is_register) ||
> +           file_inode(vma->vm_file) !=3D uprobe->inode)
> +               goto done;
> +
> +       if (vma->vm_start > info->vaddr ||
> +           vaddr_to_offset(vma, info->vaddr) !=3D uprobe->offset)
> +               goto done;
> +
> +       if (is_register) {
> +               /* consult only the "caller", new consumer. */
> +               if (consumer_filter(new, mm))
> +                       err =3D install_breakpoint(uprobe, vma, info->vad=
dr);
> +       } else if (mm_flags_test(MMF_HAS_UPROBES, mm)) {
> +               if (!filter_chain(uprobe, mm))
> +                       err =3D remove_breakpoint(uprobe, vma, info->vadd=
r);
> +       }
> +
> +       if (err) {
> +               /*
> +                * fork() was killed meanwhile. This is not the error of
> +                * the walk. See uprobe_dup_mmap().
> +                */
> +               if (in_fork && fatal_signal_pending(current))
> +                       return;
> +               WRITE_ONCE(walk->err, err);
> +       }
> + done:
> +       WRITE_ONCE(info->done, true);
> +}
> +
> +static int
> +register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new=
)
> +{
> +       struct uprobe_walk walk =3D { .uprobe =3D uprobe, .new =3D new };
> +       struct map_info *info, *next;
> +
>         percpu_down_write(&dup_mmap_sem);
> -       info =3D build_map_info(uprobe->inode->i_mapping,
> -                                       uprobe->offset, is_register);
> +       info =3D build_map_info(uprobe->inode->i_mapping, uprobe->offset,=
 !!new);
>         if (IS_ERR(info)) {
> -               err =3D PTR_ERR(info);
> -               goto out;
> +               percpu_up_write(&dup_mmap_sem);
> +               return PTR_ERR(info);
>         }
>
> -       while (info) {
> +       for (; info; info =3D next) {
>                 struct mm_struct *mm =3D info->mm;
> -               struct vm_area_struct *vma;
>
> -               if (err && is_register)
> +               next =3D info->next;
> +               /* If install failed the caller is going to undo it */
> +               if (new && walk.err)
>                         goto free;
>                 /*
>                  * We take mmap_lock for writing to avoid the race with
> @@ -1299,38 +1374,56 @@ register_for_each_vma(struct uprobe *uprobe, stru=
ct uprobe_consumer *new)
>                  * is_trap_at_addr() true right after find_uprobe_rcu()
>                  * returns NULL in find_active_uprobe_rcu().
>                  */
> -               mmap_write_lock(mm);
> -               if (check_stable_address_space(mm))
> -                       goto unlock;
> -
> -               vma =3D find_vma(mm, info->vaddr);
> -               if (!vma || !valid_vma(vma, is_register) ||
> -                   file_inode(vma->vm_file) !=3D uprobe->inode)
> -                       goto unlock;
> -
> -               if (vma->vm_start > info->vaddr ||
> -                   vaddr_to_offset(vma, info->vaddr) !=3D uprobe->offset=
)
> -                       goto unlock;
> -
> -               if (is_register) {
> -                       /* consult only the "caller", new consumer. */
> -                       if (consumer_filter(new, mm))
> -                               err =3D install_breakpoint(uprobe, vma, i=
nfo->vaddr);
> -               } else if (mm_flags_test(MMF_HAS_UPROBES, mm)) {
> -                       if (!filter_chain(uprobe, mm))
> -                               err |=3D remove_breakpoint(uprobe, vma, i=
nfo->vaddr);
> +               if (!mmap_write_trylock(mm)) {
> +                       /*
> +                        * uprobe_dup_mmap() compares info->mm until list=
_del().
> +                        * Keep mm_struct, but not the memory of the proc=
ess.
> +                        */
> +                       mmgrab(mm);
> +                       mmput_async(mm);
> +                       info->next =3D walk.busy;
> +                       walk.busy =3D info;
> +                       continue;
>                 }
> -
> - unlock:
> +               register_one_mm(&walk, info, false);
>                 mmap_write_unlock(mm);
>   free:
>                 /* exit_mmap() of the last user must not run under dup_mm=
ap_sem */
>                 mmput_async(mm);
> -               info =3D free_map_info(info);
> +               kfree(info);
>         }
> - out:
> +
> +       if (!walk.busy) {
> +               percpu_up_write(&dup_mmap_sem);
> +               return walk.err;
> +       }
> +
> +       list_add(&walk.list, &uprobe_walks);
>         percpu_up_write(&dup_mmap_sem);
> -       return err;
> +
> +       for (info =3D walk.busy; info; info =3D info->next) {
> +               struct mm_struct *mm =3D info->mm;
> +
> +               /* Don't wait for mm if its fork() did it or if install f=
ailed */
> +               if (READ_ONCE(info->done) || (new && READ_ONCE(walk.err))=
)
> +                       continue;
> +               /* All users are gone, like in build_map_info() */
> +               if (!mmget_not_zero(mm))
> +                       continue;
> +               mmap_write_lock(mm);
> +               register_one_mm(&walk, info, false);
> +               mmap_write_unlock(mm);
> +               mmput(mm);
> +       }
> +
> +       percpu_down_write(&dup_mmap_sem);
> +       list_del(&walk.list);
> +       percpu_up_write(&dup_mmap_sem);
> +
> +       for (info =3D walk.busy; info; info =3D free_map_info(info))
> +               mmdrop(info->mm);
> +
> +       return walk.err;
>  }
>
>  /**
> @@ -1841,6 +1934,21 @@ void uprobe_end_dup_mmap(void)
>
>  void uprobe_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm)
>  {
> +       struct uprobe_walk *walk;
> +       struct map_info *info;
> +
> +       list_for_each_entry(walk, &uprobe_walks, list) {
> +               /*
> +                * fork() that is being killed fails in copy_process().
> +                * There will be no child. Leave oldmm to the walk.
> +                */
> +               if (fatal_signal_pending(current))
> +                       break;
> +               for (info =3D walk->busy; info; info =3D info->next)
> +                       if (info->mm =3D=3D oldmm)
> +                               register_one_mm(walk, info, true);
> +       }
> +
>         if (mm_flags_test(MMF_HAS_UPROBES, oldmm)) {
>                 mm_flags_set(MMF_HAS_UPROBES, newmm);
>                 /* unconditionally, dup_mmap() skips VM_DONTCOPY vmas */
> --
> 2.55.0
>
