Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B731C544D5E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Sep 2026 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180641; cv=pass; b=RYHVdBdqEEXrJ4rkYoMZ3ua/5gsmT2egTB13BPP9K4qL4bAG9CIvzdeHimE8YgpePZ3G3BtDkTgxn6Jpy9P7Pb5QzS0jwiR+JbRkrozzOYL9ovfxcwKz5vmkkEGVLGpE/4L4/iMKMK7WtodV2AblGeEz/lBwkA6YH2lkJ7g5uiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180641; c=relaxed/simple;
	bh=2Oteq2LQAfmMQohvmzQdfax4JBAWgMtdwlOqmBNmox8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brHBK4HF5OfUCyRDkJXZ1URkm993Y8hanuOSXuIRKIfFo0qj9IifVKEZlus9pvdDp2VvFYFiWUQuQ6vcJynw5XHnwpqHNdH2jUZRl0TB7NDUyInQ83BsHSNlEdrDolZQyZTQloE9sOiTEsynDqLJaF5AX29AABmPN44/9Q6mMSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEd/4zx7; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEd/4zx7"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-530e8c6fb80so277041cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Sep 2026 09:23:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790180637; cv=none;
        d=google.com; s=arc-20260327;
        b=Ng3LAPKvRwM3BnwsLp7SJCWC0cgFh+xkB2sV93LdbzdbIKQUK6vHIUv+abxDG3I1Kw
         rnkh1tjXhq9WuEBGfhCkdkJqnx13MKTdVOJErqYIl+2o++koS1W7Q0qWCITz6N82cWds
         Vs/+x6kQJkL82GEAmd0/LPe9TzkYsWHfjZABWt8Ll72uFYb/9ztd/iOdprBieSuTC3OY
         yf1PlYcTH3cZpACFRDEh5/a0hg/B/Q88bdWFCTyRv1dNCNxZDOiybqiUDcuG35xcWMI0
         56IT9GFis2zP7vj4Wxn1evSaMk+L/Ba6I9g61fhxIMrW58twsjqW+XEVtd0R3B/9SOeJ
         gGxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3FzOqkymgnKp+HaLHwhofGZjaEcw2lbzuDYsddlgiEM=;
        fh=S24zLscub1Q3ZO5Em4mQ8dPQpVE25Ki0fy5uo0bVrqI=;
        b=QEkcWTXuRJnXp8Zf5lUP6WID2zIzIjLmEzabRbhNJHeeYSNNpUsPb5PAzCqDoyoIps
         GmjgEXazbeDzuDn7qLfvDPAxT8Pg3Coi4kz6TDtb0//44n0b6rXMMcYgrT9bg2rQk31N
         VGsUFstgFWQIUqR0PxJL0m0uurtuAHmKhRseOem0Yu0amPGD2isQr1B2oYjpa7gyPep9
         mWyaE2gwhNswZJH3Vs+N6EkroB78fZpzc0r8VMQWByfEErkK7TQygRXE8YJlsLGEugWm
         DGHNHdXDIeuhLtfWjhCjZAJC1E2Ofuv/oAaZ4E02QJL49oaLWQ3tFHzIY9CqH7CxyenU
         FZrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790180637; x=1790785437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3FzOqkymgnKp+HaLHwhofGZjaEcw2lbzuDYsddlgiEM=;
        b=WEd/4zx7Jaw6N2UvE9ErsDRPD2W5F8+AuDISUgXBRyBoK9r3OWGBweIAd8Z/UpZzKH
         p05za8XzaClAZW0REIguKzHb6Mxk1fy/wRxHFqwg4CfxETMqi1r41NObDpo6bjY0UfKs
         Jyu4Po4SIkpeEBrcoPTQ5EK/lNGPcMVFGXgDnxUpUNjw9ZS+EFtfCGF/4BEtwtQiu07P
         oyksd3surmOtyTiMVQzbuT2zgiB+VpgdJUB//IdsXOUSubfFgtpwt4uMdYFkhPGsaa91
         StwUEYOtRyaHQXj4MdOBzhoLCYsqD+D2lAdGKqOpAnNG1gun5Gx3CL0lLu2mkVa/r81B
         VwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790180637; x=1790785437;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3FzOqkymgnKp+HaLHwhofGZjaEcw2lbzuDYsddlgiEM=;
        b=WLzyLapjpGRE6J5WWa6tLGwXoy1KLevcfyBQc6T3uEDeZLiF3LvmPBRmi8DoPOnoJP
         eFW7wqltU9cX5BP7qSLWdE/e4DAWhuQulU5llEknje/GQbnTCi/oIt5fZJILf8LD6cEG
         RSu0fEZS0/asIQglFe3wY1bzukfm3aviLOxVpcs7TxnS76P5T1+c0Hqts1yGXNOvB0Sn
         1T2e154nPQXuNKFjw6oQrlTlTQzFq6MWXe5SySzPCA9CQxwrkEf1wzsQUVhw34e/J1XV
         a1ewvkPeo/emElFJweMYSYYUUrlQvEV6KRmoSuFz7VfDaM05dhcSkAcOyojirrwHDGSp
         LXDQ==
X-Forwarded-Encrypted: i=1; AKwUvBxpilKrMY4LiWe9UUv3Uy+hE5N5XHhzA2yyEm2wkIb3Fwo3LQ7bfZT1JkDvRX1skorzRZ90ZK493J2xKcUKYz/rJ1I=@vger.kernel.org
X-Gm-Message-State: AFuF++kL0BXGbrNlfPJ759tGuSJ66P8sN/DiM50Qjli863s/qjbx0PP0
	+FlnPKqxwxvtXit9ie4pabZai9oBuZHHD7b0FukFlc+J8eERrkYqazxDR2SGY6aAZbm2OBfTkDO
	sJhlJgVaDXqavVW3LrnWU0zsnOgRTdtUlofJOH6/o
X-Gm-Gg: AYBFou2O0L/eFxzl30K94S5xy3b5EF+t01qjv/9gTF2JUFHgQJ3rL31nzaz52MJbUGc
	t3zHHMdKaHUw6mPfmY0AClTfVtPXB/7F2hjwfOgDtI5BacUL9Fnrp0tZwE+ITG3BSq19n07zyxB
	kcnnzWI8JGl9M82V4oz08ZNhdcMVd03AtKxAbPFi5lVKzBZi5HhHuSvqTX9AW83erAoW1os7bKU
	YUVNy9ZeMci2/zMFD65Ea74oTuwio8LzbUvfo7nnYRaGowkvXKfYal00LODQuC3UitLhHoTNMbW
	WeYS+QGl5KfF0WBod/6CCAyRvBj9JLQQ3/So2Lc2o4dxmeiz/SHGQPBb/n6wOH/aqESSDknwrEm
	obDKdWVhwbw==
X-Received: by 2002:a05:622a:609:b0:531:282:6560 with SMTP id
 d75a77b69052e-532f9d4a86emr439391cf.15.1790180636277; Wed, 23 Sep 2026
 09:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Sep 2026 09:23:45 -0700
X-Gm-Features: AcwNN1U-1rGp6GFHFrF0qqhOHTzivX5krrdmfBch0hMHABT_yaCwm6D93D-Dyz8
Message-ID: <CAJuCfpE0WCr1Kp=+4EVJB7UdbH22HuCouOEtGMNCL+a8TnCQPQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/40] mm/vma: introduce and use vma_[flags_]can_merge()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 9:24=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> Replace the open-coded VMA_SPECIAL_FLAGS check in the VMA merge logic wit=
h
> two new functions vma_flags_can_merge() and vma_can_merge() and update th=
e
> merge logic to use the former.
>
> This abstracts the check and expresses it in terms of the desired behavio=
ur
> rather than an arbitrary and confusing VMA flag.
>
> This also lays the groundwork for making further improvements in VMA flag
> usage.
>
> Also update the userland VMA tests to reflect the change.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/mm.h              | 21 +++++++++++++++++++++
>  mm/vma.c                        | 19 +++++++++++--------
>  tools/testing/vma/include/dup.h |  5 +++++
>  3 files changed, 37 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 969594074fd2..68250ece4219 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1612,6 +1612,27 @@ static inline bool vma_is_shared_maywrite(const st=
ruct vm_area_struct *vma)
>         return is_shared_maywrite(&vma->flags);
>  }
>
> +/**
> + * vma_flags_can_merge() - Do the specified VMA flags permit the VMA to =
be
> + * merged with another?
> + * @flags: The VMA flags to test.
> + * Returns: true if the flags permit merging, false otherwise.
> + */
> +static inline bool vma_flags_can_merge(const vma_flags_t *flags)
> +{
> +       return !vma_flags_test_any_mask(flags, VMA_SPECIAL_FLAGS);
> +}
> +
> +/**
> + * vma_can_merge() - Do @vma's flags permit it to be merged with another=
 VMA?
> + * @vma: The VMA to test.
> + * Returns: true if the flags permit merging, otherwise false.
> + */
> +static inline bool vma_can_merge(const struct vm_area_struct *vma)
> +{
> +       return vma_flags_can_merge(&vma->flags);
> +}
> +
>  /**
>   * vma_kernel_pagesize - Default page size granularity for this VMA.
>   * @vma: The user mapping.
> diff --git a/mm/vma.c b/mm/vma.c
> index 4b74b48c29b7..05d2c676672e 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -924,13 +924,14 @@ static __must_check struct vm_area_struct *vma_merg=
e_existing_range(
>
>         vmg->state =3D VMA_MERGE_NOMERGE;
>
> +       if (!vma_flags_can_merge(&vmg->vma_flags))
> +               return NULL;
>         /*
> -        * If a special mapping or if the range being modified is neither=
 at the
> -        * furthermost left or right side of the VMA, then we have no cha=
nce of
> -        * merging and should abort.
> +        * If the range being modified is neither at the furthermost left=
 or
> +        * right side of the VMA, then we have no chance of merging and s=
hould
> +        * abort.
>          */
> -       if (vma_flags_test_any_mask(&vmg->vma_flags, VMA_SPECIAL_FLAGS) |=
|
> -           (!left_side && !right_side))
> +       if (!left_side && !right_side)
>                 return NULL;
>
>         if (left_side)
> @@ -1152,9 +1153,11 @@ struct vm_area_struct *vma_merge_new_range(struct =
vma_merge_struct *vmg)
>
>         vmg->state =3D VMA_MERGE_NOMERGE;
>
> -       /* Special VMAs are unmergeable, also if no prev/next. */
> -       if (vma_flags_test_any_mask(&vmg->vma_flags, VMA_SPECIAL_FLAGS) |=
|
> -           (!prev && !next))
> +       if (!vma_flags_can_merge(&vmg->vma_flags))
> +               return NULL;
> +
> +       /* VMAs with no prev/next are unmergeable. */
> +       if (!prev && !next)
>                 return NULL;
>
>         can_merge_left =3D can_vma_merge_left(vmg);
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/=
dup.h
> index 16c09dac59d9..2fd422789717 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -1647,3 +1647,8 @@ static inline bool file_is_dev_zero(const struct fi=
le *file)
>  {
>         return file && file->f_op =3D=3D &zero_fops;
>  }
> +
> +static inline bool vma_flags_can_merge(const vma_flags_t *flags)
> +{
> +       return !vma_flags_test_any_mask(flags, VMA_SPECIAL_FLAGS);
> +}
>
> --
> 2.55.0
>
