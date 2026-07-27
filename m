Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCA641C30F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Jul 2026 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164313; cv=pass; b=ihPzfWqj+09BMv8/WvkcjKdrxrwBqertIKoEu4Lm4vQyZaErh+dOu9trSypEIGqiguz05ZUuRmdhyil7324vTRlFx8aSMBCanTSONB+7hMUvVwqwiZz9CKoC3XNxxH/wz1QEJFKCo+hHg27CbHgWh2sJss4+8zBBrQ/yhOYbamE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164313; c=relaxed/simple;
	bh=kxz4JCp1zmCPK54Re1R/GOtYTqklGG1iLssdkACD0Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4+SkwY2IZptCioPf38lSuMF8oh7qB6ye8QoTFxKtrt7oyZL/UFgRwbcA1CvJP5glhkU/t/qQ6rD3eSQpGMU9NYoE7uok2eyUyrtJ5yQVGcyFA4818IP/gvXg37Ur2cWywzs/F01gkAtpcB73NAz90rJ5m//XxKhqkQ9q0P2MF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OhCV6X0v; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OhCV6X0v"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c15a5b265so474301cf.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Jul 2026 07:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785164311; cv=none;
        d=google.com; s=arc-20260327;
        b=A3cr8NT8ON+LAtb9QAhOJ//Zucv4GwAKugqvM2K8rxXfdPJb2WI3Xj/mabCVrHSuzE
         NNu41VI8XcEcfDMiKMkW5WFTT7DcO5CSYbj9kd1RKA3fLltRZJ2taBS7ijJwJIkUXj8c
         ywk1KnG/rVx+z5mfJ3bVLTwL1r8QmcXY71RO8uVYXSClS5zUFSR7POr9vLRN6r70ouHr
         OwgCFPc3HnRoaSBHWCQmApa+EJ+VkF/pmE8iBuY0d9yUTM0H6xoLn22gYsbt5M4BAhrl
         JnXVCmLA6A2TyJ1SPwgY6qgpiuxFhTWycVIFR8ekNPejTimeCnsaSKKNfIF4GJi3zmto
         cnWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HdV/tdQspG4IJMEgA5ul46Qg1OBakRGkf1HYdrRgQRg=;
        fh=uS/ERePQKfGSzXFv95akbhNv3pCa+AsuDPxZFSrZNqM=;
        b=n4dVCT0LWkqWTw6MGG0kGFmcD4mMxuJRKk85757+tggA//600Nqp5qTJsurJdI2FWU
         5FRJuJUO2IBBdhLAahhnl4JaJ20YfGh0oaXhFl8OkfvWirCqdb3HTg1C2ImbWLZ51n+w
         PtQXHXIv9TILz6PISir6tN6HSkwCeTPA3g4wQYIlhzQUYEsQA6GQSWS7aul5LkiNLK2I
         wt96LZM4W55UcY5aR1e/rvJDkjC5ySS6w0cwiWJcnohxU1ZgXLTOZY/tBCEz9uBUUC/7
         KyO1pzZ4DVYO9Lz9rKTRf70xzTt6z+Wtb60+ZMZShUO9ue8e7kR7Ooq6f4eL/zu1BTdC
         glKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785164311; x=1785769111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HdV/tdQspG4IJMEgA5ul46Qg1OBakRGkf1HYdrRgQRg=;
        b=OhCV6X0vfh3z2il0QvepqGRCKQhPj+i6xipuaBYO8A66GbwpFQ+4FiuydvA2psgYLm
         K3BcLvFh8tI7asD5HbSTnodCsJzPRNoN0/QhS6cuWdeFmMEX9r7zL2dhfWvLuVgTRjTA
         oJp9cyxOom7NUxtmwfk4Y/Y2NCctHvZkp3DNs2kuua6vtEtx1hZylEJTuuF49x91EY50
         cfYHnHPW8VFyaiRP34Of3/KUZRNVXpXMZ7WU5M104jQqzGwG9IdL/4YNOPIDFEobdA35
         0pKCV9wHHmbeXTzyFJX4AVXg1kI0jt/JdjB1Q2Rm+DWsX7CGwWVYk20cYf7d7dF96znW
         ROmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785164311; x=1785769111;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HdV/tdQspG4IJMEgA5ul46Qg1OBakRGkf1HYdrRgQRg=;
        b=Jd7CWNTODTHmAkXU8QXFW0TmxacEjmEuZ3r2Wr8simN2z7bHTU/Wxd2pR7MlLjn4xm
         /0LdlCAKaI9sUAxxT3+GjUom2GmghCpjTORDNrrWk+0WbLjCtTSLKzB3rqYb0tGTetIq
         QZK+NgvFPqmBur0eiSC9RsPgvtCrL/dTg4G7+CgqZLG/ZYifHuwQS5D3ufn1ZrCM8QSK
         Hf4HvH6zOPOAKH4qcywPXTTBWFP+fUA6QSZ1XBTkx9zqTo8CbUMGAOhclTOMh1LCh3aG
         pV3SgKcMSz2NiLYi6TmZjp4zBiYrhYMF26qarW6GeIWFpEszbkLqXvo69yKmQO7fZZVa
         SV+A==
X-Forwarded-Encrypted: i=1; AHgh+RrIvkINMWoYjRaoIBKr7jYG93jW5Io+P+roEcl8xfAOjhdIguB1wOvfrrpwT52Gi+LiP/3KFxKCBokB/buHBwjjJZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQsDVstSvkxuvKRSM8g5OhvD8HfXbtjVlcC0hwtt6wu3q+XnSU
	NOWGzdijD3EJ/bAXetZcgiF0Fw8D9B7vcpnCvYe74RBZ2QnT3HH/0Ppacf1R96O/U2BkE7kA6ZS
	w/ENH8NcheJmvgLW+TJuvzRDeCqkONLSmgbVwgz2t
X-Gm-Gg: AR+sD11EfU3mDsJFQJ8eaTYdk2BY6l3YQ6NFnlH15ngoYTOAtio0KXy52mqdOzZ+R5d
	oUMbifwEj0l8v3FHtjssrSxo28k2NtwAMLDKx6/ihCSehwb2kCa7pGZ5MGFfxpKOKVIJNeoxYfd
	dv3eWR2VkOXuBaA7vdDSb8fUtwQ/A68no4g1xBQeL201NfyNXn1435D27crC3dbyapcL4g1hIpG
	q7vgNuWvJHpl2FRMzX/Y1rSBeHloC77KSFCtCKS6dO2y+IKJzpcb5e+jW/qRc0oweWn95IGOlQF
	WF0CHA==
X-Received: by 2002:ac8:7dcf:0:b0:528:3186:5781 with SMTP id
 d75a77b69052e-529a5f158a7mr36339991cf.6.1785164309856; Mon, 27 Jul 2026
 07:58:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724222934.1463812-1-riel@surriel.com> <20260724222934.1463812-4-riel@surriel.com>
In-Reply-To: <20260724222934.1463812-4-riel@surriel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 27 Jul 2026 07:58:18 -0700
X-Gm-Features: AUfX_mzxNfG3avju6LxEy4p22U_xIz6TPcKe25YvyW5akGfhtZSIh5B3OYp7U2E
Message-ID: <CAJuCfpF8S1=S7TkAuQ58OWiUhnf481YvwsamwvVfa7tfVNH3JA@mail.gmail.com>
Subject: Re: [PATCH RFC v4 03/12] mm: rename get_user_page_vma_remote() to get_user_page_lookup_vma()
To: Rik van Riel <riel@surriel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel-team@meta.com, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Usama Arif <usamaarif642@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
	Lance Yang <lance.yang@linux.dev>, linux-arm-kernel@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, Usama Arif <usama.arif@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 3:31=E2=80=AFPM Rik van Riel <riel@surriel.com> wro=
te:
>
> get_user_page_vma_remote() faults in the page at @addr in a remote mm and
> also looks up the VMA that covers it, handing both back to the caller.
>
> This cleans up the namespace for adding a get_user_page_vma() variant whe=
re
> the caller already has the vma.

nit: Before explaining the results we usually state what this patch is
doing. I know the title alread says "rename get_user_page_vma_remote()
to get_user_page_lookup_vma()" but it seems appropriate to say that
here too.

>
> No functional change intended.
>
> Assisted-by: Claude:claude-opus-4.8
> Acked-by: Usama Arif <usama.arif@linux.dev>
> Signed-off-by: Rik van Riel <riel@surriel.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  arch/arm64/kernel/mte.c   | 2 +-
>  arch/x86/kernel/uprobes.c | 2 +-
>  include/linux/mm.h        | 2 +-
>  mm/memory.c               | 4 ++--
>  mm/rmap.c                 | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 1a9aad6ef22a..7a6ecc3d9294 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -459,7 +459,7 @@ static int __access_remote_tags(struct mm_struct *mm,=
 unsigned long addr,
>                 struct vm_area_struct *vma;
>                 unsigned long tags, offset;
>                 void *maddr;
> -               struct page *page =3D get_user_page_vma_remote(mm, addr,
> +               struct page *page =3D get_user_page_lookup_vma(mm, addr,
>                                                              gup_flags, &=
vma);
>                 struct folio *folio;
>
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 3af979fb41d3..329efac0cfb3 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -1036,7 +1036,7 @@ static int copy_from_vaddr(struct mm_struct *mm, un=
signed long vaddr, void *dst,
>         struct vm_area_struct *vma;
>         struct page *page;
>
> -       page =3D get_user_page_vma_remote(mm, vaddr, gup_flags, &vma);
> +       page =3D get_user_page_lookup_vma(mm, vaddr, gup_flags, &vma);
>         if (IS_ERR(page))
>                 return PTR_ERR(page);
>         uprobe_copy_from_page(page, vaddr, dst, len);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 485df9c2dbdd..24ead14b4790 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3238,7 +3238,7 @@ long pin_user_pages_remote(struct mm_struct *mm,
>  /*
>   * Retrieves a single page alongside its VMA. Does not support FOLL_NOWA=
IT.
>   */
> -static inline struct page *get_user_page_vma_remote(struct mm_struct *mm=
,
> +static inline struct page *get_user_page_lookup_vma(struct mm_struct *mm=
,
>                                                     unsigned long addr,
>                                                     int gup_flags,
>                                                     struct vm_area_struct=
 **vmap)
> diff --git a/mm/memory.c b/mm/memory.c
> index ff338c2abe92..3b86eeaf084f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -7039,7 +7039,7 @@ static int __access_remote_vm(struct mm_struct *mm,=
 unsigned long addr,
>                 void *maddr;
>                 struct folio *folio;
>                 struct vm_area_struct *vma =3D NULL;
> -               struct page *page =3D get_user_page_vma_remote(mm, addr,
> +               struct page *page =3D get_user_page_lookup_vma(mm, addr,
>                                                              gup_flags, &=
vma);
>
>                 if (IS_ERR(page)) {
> @@ -7167,7 +7167,7 @@ static int __copy_remote_vm_str(struct mm_struct *m=
m, unsigned long addr,
>                 struct page *page;
>                 struct vm_area_struct *vma =3D NULL;
>
> -               page =3D get_user_page_vma_remote(mm, addr, gup_flags, &v=
ma);
> +               page =3D get_user_page_lookup_vma(mm, addr, gup_flags, &v=
ma);
>                 if (IS_ERR(page)) {
>                         /*
>                          * Treat as a total failure for now until we deci=
de how
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1c77d5dc06e9..b36f2e219b8f 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2838,7 +2838,7 @@ struct page *make_device_exclusive(struct mm_struct=
 *mm, unsigned long addr,
>          * (non-device-exclusive) PTE and issue a MMU_NOTIFY_EXCLUSIVE.
>          */
>  retry:
> -       page =3D get_user_page_vma_remote(mm, addr,
> +       page =3D get_user_page_lookup_vma(mm, addr,
>                                         FOLL_GET | FOLL_WRITE | FOLL_SPLI=
T_PMD,
>                                         &vma);
>         if (IS_ERR(page))
> --
> 2.53.0-Meta
>
