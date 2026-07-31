Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8041F2D5408
	for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Jul 2026 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534852; cv=pass; b=RStme065kYIbdXahUPkx2twvrLhgoGAHpMFfikOPpBiRcBK5G+o5+zSww+aMLz5NMZAv2No/A1tUT+ZDFqyCyOsnrnb6Y/s63N6SYfS+ETHcpV4ezoQ5khptpVgLnVHC20nkHbEvV8RIHbbh/giGF17PHXs6LhgbeXirHEONdWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534852; c=relaxed/simple;
	bh=Pnq7zcb7OBStwmFk/cMGV9jIpASQJAMtNs9n3iP/UR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQlDdAPeS8SSxKHAL3yWP6yTiv0I+kWcvlVOCtq26UB5wHhx1EpvcSAymVbCfzr+rFE6vvEpVZd685V5bgudEMuoCDOmz+dv7yN5ueessf3aJRbtxMJ+JTZ3CU5AeMzGiK3P2ecT/pjEo0cL+EjIwZ9r8wWZISsF3R+gTylBVbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WPw5QrVl; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPw5QrVl"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c01c79467so76891cf.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Jul 2026 14:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785534849; cv=none;
        d=google.com; s=arc-20260327;
        b=eKlKZxPfGbfYr3VW2aLYX3bIe9dgMKXdWcRXtby5x8VH6gfeLCfGTH+hHoCl1Aip9p
         hAJ4Lrs5tNNmXM2N1Kl9qcVEuuiB7uuDYI+fOLkEJLYv/o2CzxCdhb4qxFDVpkOywdD7
         ZP4Y3ugp58ufQNrFXnBf+5UWW2/c/cTj+Tbp5oXRJAs+4V0V8k3rXI8dCWjA3us2VnTC
         NVr2sVXJ0jlvbrxzeX9sDS3ee6eT9qj5euNPUBm4MGbXA8uEPb4nwMCzWygGtSxGnTwQ
         dIsLQaU/uLQBNsrTgz6wo/Li6Hqbk75PjgiAxoF+UfQwt0AcCiyKOYU2Cylcd9e5umd1
         VQVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8gIfdsfjbn1z2tePFkfGVAXUb4NElj5vr2DMSWId60A=;
        fh=zDZaW0+w6DiZeJZ7e7YHxJfj5ufMH18f0wWXPrgVY2Q=;
        b=ia7A3J7SAocaC5IGBbgI8k31YiHXCdsNaJhyKZX+KuIilrLPmgIIr+RaAfq3dbFvLq
         ZkyaLJwKsAVSL3nz/LA+NLamdWd3CG/NxsQxyWJdRWXhpCTCUBPwAWTG6AcmtVfJpdRW
         fgFGiAQ5NKg/jYqbwy0J5PRc1jn9dVbHH6CFXIF0RTqLIZHMpeNVSWOgc/sAKBH+aRtI
         XFOgmGwryb4ZcEjyq1dg0x0XpMdE00pdNZefdXsD1Mh8e4my56e8IvJjh8ou3c7cwOci
         5tE7X4MeEaWA5eyf+NQUxzwIAQYqntWOu8TgrbJn0h4oYh2gF9ZRcv++rO3Ks3ZbCXkY
         a/pQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785534849; x=1786139649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8gIfdsfjbn1z2tePFkfGVAXUb4NElj5vr2DMSWId60A=;
        b=WPw5QrVl7wHiUNdO+wBqIIEWBieujcatT2sfJbBqWtYP3xOu4FbZ0lBZ+GF7UDpayT
         zuJtPDoW8JLrijBwY9lL9lKYvbEwUSaLeaI5tPUIXSowpkEyKh4nQkPZbVcEMYVAJJQp
         FHdFOWH2Xm1s+/dNnBe7P5/Vnwppfu+Fm9wlQEj7yH6cwKO1WZ17KknlGr/a5ONi+hT6
         5gmykv4B8quSjIvQe3SISP1xgMufD47BRuwpTr2gZtzAncOQWaHCNzejcWKHE/xkL86c
         vs7G/bi8DEod4D2MFlHYWw2B6guzsJDKwjbnNVWYZNHi/nsU4V5BgCKAFYqOwL3vf+yc
         axVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785534849; x=1786139649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8gIfdsfjbn1z2tePFkfGVAXUb4NElj5vr2DMSWId60A=;
        b=dRumnuUV6jST72B7b8thTUBCgXykv4bkf4Vm/mZ68c40qZYlicUXloEt32FEKDu6ZI
         ZONL5HI+AfzZI7r5coXu1tGFX1HR9jiJAhLkPOUwL6W5IYYcd35iFjRME5YDntYJS+gY
         /Wj2L8v9MS5iOsgqK7wZssNFdmrcwkAWW3ynQiyGUfrWdtkyIFw6wv78v7MpaLQ+L/rc
         UyfgxZYE6Zq22nGqrV+9POL/ErdLnyk5d6c8SNRueqERj56/8dMjX/dQOZV7z/2DpJII
         YZQrsWumRW2IMkQyhEQV7D5NC7OP2lKHWkonZVi1xFs7BOjsymiuFLCno4pgzt5zopDd
         KGwA==
X-Forwarded-Encrypted: i=1; AHgh+RpghTDQZYLLCulKRLPpf5GRJGc5S4lKNXLBXmXLy75FOVOjeVE4dqH2EfCTHIF3iIjOWOOpOc+Y05oYjA03j1e8vBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDeRv5NdtjqRGRq0gsBjm3mh+plQ0/PmlmQsESqYsbzrW0JPQg
	gqEwkJ0b50q+EhCe5Y/AOctPL46xVtFGkktih5/xlmLPxi00hM2ejce2dQXIFWtvmrgLuKK570x
	vwHGl9Ima+2vgI4jdic0/4kyVQU03c8FOnrMf7OWz
X-Gm-Gg: AR+sD10NlYNahRiRHrA5qapM4DI7kvFn/WulJ96oCTpQaUSoyby8AN9n8dwjlchaYm9
	4aT2bw4KnkZ9F0Y9RLAmSKStgOAI3TKA0FhW2kUtUAh040v1koETY+3iijtviDZsqfW13UtFmB7
	tK55CjoA3RRXgqj6dZsDnNTOTrPH3mVJYA9c8Pl9Gi4mIwvI7kWdnboSZ2Sb68Ystfxf8YJnaB8
	+dUwN+9OuUHOG5PvAPtaK2NcpN6+KO3rY2y3jrrOwnToewTv50ng1Op8b5yjQ9HE4kunrRXUluA
	UA6M6+P3ko2ben+W8/NSWs/UgR4LKRfdqyDos1lj3P9GyNjesGW4XV8COHzE7diZ+YL4bYZzCnU
	=
X-Received: by 2002:a05:622a:134f:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-52b59a19ea6mr5408341cf.10.1785534848971; Fri, 31 Jul 2026
 14:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-rfc-nt-demote-v2-0-452dbe3b5073@zptcorp.com> <20260730-rfc-nt-demote-v2-1-452dbe3b5073@zptcorp.com>
In-Reply-To: <20260730-rfc-nt-demote-v2-1-452dbe3b5073@zptcorp.com>
From: Huan Nguyen <nhuhuan@google.com>
Date: Fri, 31 Jul 2026 14:53:31 -0700
X-Gm-Features: AUfX_mydSrv99P-U14w6L8Rc9PDoTTKUxRYzjtIKVF_wWri1fRV1Nci3jK142jQ
Message-ID: <CALwWd5usu+e=MgX95zGPUeqRjEu_SARLoiMPQpyMYBoUVQkk_g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/3] mm, x86: support copying a folio using
 non-temporal stores
To: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Rientjes <rientjes@google.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <nifan.cxl@gmail.com>, 
	Frank van der Linden <fvdl@google.com>, Jonathan Cameron <jic23@kernel.org>, Raghavendra K T <rkodsara@amd.com>, 
	"Rao, Bharata Bhasker" <bharata@amd.com>, SeongJae Park <sj@kernel.org>, Wei Xu <weixugc@google.com>, 
	Xuezheng Chu <xuezhengchu@huawei.com>, Yiannis Nikolakopoulos <yiannis@zptcorp.com>, dimitrios@palyvos.net, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Alirad Malek <alirad.malek@zptcorp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yiannis,

Although copy_mc_to_kernel_nt() asserts both "mc" (machine check exception)
and "nt" (non-temporal store), the implementation fails to deliver both:
1. copy_mc_fragile() is MCE-safe, but it does not use movnti.
2. memcpy_flushcache() uses movnti, but it is not MCE-safe.

Additionally, according to the Intel manual, since movnti uses the WC proto=
col
(a weakly-ordered memory model), a fencing operation is required. Because
memcpy_flushcache() lacks an sfence, it can result in reading stale or corr=
upted
data after folio_unlock().

Furthermore, copy_mc_highpage() is unoptimized for page migration operation=
s
because it reuses copy_mc_to_kernel(), built to handle
variable-length, unaligned
memory. As copy_mc_highpage_nt() follows copy_mc_highpage(), it inherits th=
is
flaw. In contrast, copy_highpage() is optimized for page migration by lever=
aging
copy_page(), dedicated to 4KiB-aligned memory.

Therefore, copy_mc_highpage_nt() should call a dedicated page-copy assembly
routine that provides MCE safety, movnti stores, and an sfence, rather than=
 the
generic copy_mc_to_kernel_nt(). We can name it copy_mc_page_nt(), following
the naming convention of copy_page().

What are your thoughts on this direction? Any feedback or suggestions would=
 be
greatly appreciated.

Huan Nguyen

On Thu, Jul 30, 2026 at 8:03=E2=80=AFAM Yiannis Nikolakopoulos
<yiannis.nikolakop@gmail.com> wrote:
>
> From: Alirad Malek <alirad.malek@zptcorp.com>
>
> In x86, use memcpy_flushcache (that uses non-temporal store
> instructions) to copy a folio. To achieve that, starting from folio_mc_co=
py
> down to copy_mc_to_kernel, create a series of helpers (named with an _nt
> suffix) that have similar behavior to the original counterparts.
>
> Signed-off-by: Alirad Malek <alirad.malek@zptcorp.com>
> Co-developed-by: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
> Signed-off-by: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
> ---
>  arch/x86/include/asm/uaccess.h |  4 ++++
>  arch/x86/lib/copy_mc.c         | 26 ++++++++++++++++++++++++++
>  include/linux/highmem.h        | 32 ++++++++++++++++++++++++++++++++
>  include/linux/mm.h             |  1 +
>  mm/util.c                      | 17 +++++++++++++++++
>  5 files changed, 80 insertions(+)
>
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uacces=
s.h
> index 367297b188c3..2d0938d3e372 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -494,6 +494,10 @@ unsigned long __must_check
>  copy_mc_to_kernel(void *to, const void *from, unsigned len);
>  #define copy_mc_to_kernel copy_mc_to_kernel
>
> +unsigned long __must_check
> +copy_mc_to_kernel_nt(void *to, const void *from, unsigned len);
> +#define copy_mc_to_kernel_nt copy_mc_to_kernel_nt
> +
>  unsigned long __must_check
>  copy_mc_to_user(void __user *to, const void *from, unsigned len);
>  #endif
> diff --git a/arch/x86/lib/copy_mc.c b/arch/x86/lib/copy_mc.c
> index 97e88e58567b..5a2ee5c2211e 100644
> --- a/arch/x86/lib/copy_mc.c
> +++ b/arch/x86/lib/copy_mc.c
> @@ -81,6 +81,32 @@ unsigned long __must_check copy_mc_to_kernel(void *dst=
, const void *src, unsigne
>  }
>  EXPORT_SYMBOL_GPL(copy_mc_to_kernel);
>
> +/**
> + * copy_mc_to_kernel_nt - memory copy that handles source exceptions
> + * if enabled, otherwise uses non-temporal stores
> + * @dst: destination address
> + * @src: source address
> + * @len: number of bytes to copy
> + *
> + * Return 0 for success, or number of bytes not copied if there was an
> + * exception.
> + */
> +unsigned long __must_check copy_mc_to_kernel_nt(void *dst, const void *s=
rc, unsigned len)
> +{
> +       unsigned long ret;
> +
> +       if (copy_mc_fragile_enabled) {
> +               instrument_memcpy_before(dst, src, len);
> +               ret =3D copy_mc_fragile(dst, src, len);
> +               instrument_memcpy_after(dst, src, len, ret);
> +               return ret;
> +       }
> +
> +       memcpy_flushcache(dst, src, len);
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(copy_mc_to_kernel_nt);
> +
>  unsigned long __must_check copy_mc_to_user(void __user *dst, const void =
*src, unsigned len)
>  {
>         unsigned long ret;
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index af03db851a1d..a5cb435b9ffe 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -468,6 +468,32 @@ static inline int copy_mc_highpage(struct page *to, =
struct page *from)
>
>         return ret;
>  }
> +
> +#ifdef copy_mc_to_kernel_nt
> +static inline int copy_mc_highpage_nt(struct page *to, struct page *from=
)
> +{
> +       unsigned long ret;
> +       char *vfrom, *vto;
> +
> +       vfrom =3D kmap_local_page(from);
> +       vto =3D kmap_local_page(to);
> +       ret =3D copy_mc_to_kernel_nt(vto, vfrom, PAGE_SIZE);
> +       if (!ret)
> +               kmsan_copy_page_meta(to, from);
> +       kunmap_local(vto);
> +       kunmap_local(vfrom);
> +
> +       if (ret)
> +               memory_failure_queue(page_to_pfn(from), 0);
> +
> +       return ret;
> +}
> +#else
> +static inline int copy_mc_highpage_nt(struct page *to, struct page *from=
)
> +{
> +       return copy_mc_highpage(to, from);
> +}
> +#endif
>  #else
>  static inline int copy_mc_user_highpage(struct page *to, struct page *fr=
om,
>                                         unsigned long vaddr, struct vm_ar=
ea_struct *vma)
> @@ -481,6 +507,12 @@ static inline int copy_mc_highpage(struct page *to, =
struct page *from)
>         copy_highpage(to, from);
>         return 0;
>  }
> +
> +static inline int copy_mc_highpage_nt(struct page *to, struct page *from=
)
> +{
> +       copy_highpage(to, from);
> +       return 0;
> +}
>  #endif
>
>  static inline void memcpy_page(struct page *dst_page, size_t dst_off,
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5be3d8a8f806..d07ce478582d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1644,6 +1644,7 @@ void __folio_put(struct folio *folio);
>  void split_page(struct page *page, unsigned int order);
>  void folio_copy(struct folio *dst, struct folio *src);
>  int folio_mc_copy(struct folio *dst, struct folio *src);
> +int folio_mc_copy_nt(struct folio *dst, struct folio *src);
>
>  unsigned long nr_free_buffer_pages(void);
>
> diff --git a/mm/util.c b/mm/util.c
> index b05ab6f97e11..e09e9b5f8eee 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -749,6 +749,23 @@ int folio_mc_copy(struct folio *dst, struct folio *s=
rc)
>  }
>  EXPORT_SYMBOL(folio_mc_copy);
>
> +int folio_mc_copy_nt(struct folio *dst, struct folio *src)
> +{
> +       long nr =3D folio_nr_pages(src);
> +       long i =3D 0;
> +
> +       for (;;) {
> +               if (copy_mc_highpage_nt(folio_page(dst, i), folio_page(sr=
c, i)))
> +                       return -EHWPOISON;
> +               if (++i =3D=3D nr)
> +                       break;
> +               cond_resched();
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(folio_mc_copy_nt);
> +
>  int sysctl_overcommit_memory __read_mostly =3D OVERCOMMIT_GUESS;
>  static int sysctl_overcommit_ratio __read_mostly =3D 50;
>  static unsigned long sysctl_overcommit_kbytes __read_mostly;
>
> --
> 2.43.0
>
