Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0E7360EDE
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779347650; cv=pass; b=isUOnPpm5kfCB4R+uT5tVjb4/ApRR5vxnLk1i5rMRj6Z7V+SOoLKuVLrqqcEt07kIFbdjrxkaHzCwCGGs+Y4A23ZbXdWIdZw2FNb/Bo1gEQrjD4JrTYZsXEQxFkjf/83/kh/RlptW7DEN5CKRMzKiDdTan362tRXqD7t12Kj2qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779347650; c=relaxed/simple;
	bh=FwszKxRTkU5t0/z62X07EaM8UOUdI3Szs5D9p5DC8sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMwry4S/rVilK+uZ4Nl/E7dGuCcshj3ojRl1MgP+our4q0MnvaVD9Rb9fR7Ve2W3HSDsAoK72/uqsiZBtsHG9SOwaLwLDEDHouYgNcsxXVlY3iINpWXyYt0WdH6V7Qv0ylcSSEAqk3IqDnvPHM/7h/4vfIkUB5bCX+SK8i8dzRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CkNZIYT/; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CkNZIYT/"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e61648f10so15411cf.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 00:14:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779347648; cv=none;
        d=google.com; s=arc-20240605;
        b=g1E4MiRAg9wWDy8LgFo8rvVE5D8Ij5MGEVKBlcGPW4XeyslLfEg8RrVhrSuGxvOLJO
         PRWh3IXh2h9FG91yUtz4/yvVfu6uVbZEvTHShwOLxWt6+GAkWDwkwLtuKSCC2jd48jpp
         slBCiemoue1KUA64fU9lYOExeu7HkKT+1nAYUVbBr69a6V0LJohRM5a95HxU6bk3EdAT
         mVuVueaVGndTDRzg11cvVa+CJIa3YBKCafMob2y4oqgY48xWCOni8xbMEOxXqOwk7K0T
         iycf5+3NVt5+LPZFu9e1EXP0EdN89dote39wgCzc8+HMyx469LMjtPNbGv3MnFKUfibv
         wesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uNOn4o9NVeTi7pLeKizYhzgihd3OKpoLohhH00DuQC4=;
        fh=t0xBQyiCevpLPdDtQ5Ah06jILpTyh7KSsqb6pjd2vNk=;
        b=C1w1pq94/ZssMhBi+FzPIpjiAE0Lp3dU1iqP5qh+LOLaFzhcxv5yePYT2eXHarVkV0
         nEonrkqSKpzcJn8teyRnk9ykGbdMpYgkD8hWdSLF1mCrWVqZEDlRspqZs9zqreh2a+9B
         5Ej47aFoaJBMdhsfCfNTrfnNQhDUOgnAAnZnvp/bFuKSIyrPYQ4FCUmgXrEXuaWUsj9u
         Q8h9bYldN1vSikx0x0ZDPDl3rkNF8MG03yXE1LqwU4ah9LhD+OpdML+ADPZXxoe7WFf6
         YLsv3mlc6M1rBSja9IGm05twXX3rmg9Rf8dMbW7GDorYXb0ZOkv7eOLcstkyDzCCksGk
         10SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779347648; x=1779952448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uNOn4o9NVeTi7pLeKizYhzgihd3OKpoLohhH00DuQC4=;
        b=CkNZIYT/mfQbtyB9kjgvAN8ysRT7XeJ8RfwxAf0k8YBYFRm1kUI5LtllPusWOw5oPH
         40MJQndnz5V4/HvdveowpqLg4iPIg4p4hDvp3jbscIw6JKq1WDQZ7noD84MDcMVXKkco
         cr6AZaLQoeZ4UGHwuYV9Hj5r2she3ZkJ3HvgwIv3+5Ne0J4FU174YOCA2ul8e+dWGUfl
         tapM4OZNOJOFjQF/kC8DrY5Flc1MwQGnr7rvUF+qWEgq39VMt9f0/7EkkolhzN7llH46
         XkkzWMvb/Bg4XJH0Fls1w6mqAmbN+s0pKZCDclGa0gC5b3DHfFbqdL/ZRRJbQdTuodpm
         cJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779347648; x=1779952448;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNOn4o9NVeTi7pLeKizYhzgihd3OKpoLohhH00DuQC4=;
        b=dNJ7uIFd4TGTnmnqd5RWu51q7RQQD+o4P19706qjlTdnoJ6fejRLGDLxaTYbmAVrt1
         LctagJRc4MHO62+pAHFXV6gRM4aAiyFIIYQkPr15A4J3av3zAthnt0pS9H02uxat/saQ
         3iQBM9o+i9zzt++5+cjeC30NhREDZazYCZL0YRmC7IN56DN42UbmLBUmTM9fedyi3ks0
         d2iEdqDjm96ME4g/evQpNJlWLUGes9HL+e2veUAAdLbMbY47NRsFLh6FsLOJ3X1OiP+R
         TOJkuBut+mP8sRhiXaU7KACUr+qupE5oawCSBw8p0B4lQ0IC/+A1D8jXkDIbi8l+QG9s
         oIZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/OmZe6/mFtGKglUDDB4wR+moQzZwu4h5cEp8ZqocsmC6F5g0urV7p22NQdMOhAkbz8VVPyy7QX323sBH26e65CGyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMl/12W7MUBvhC2CFKyMVjp1fnrKgxXVmFGr84r2SE32R1mmzt
	NZqlmko7qtcGL1YV72fDLMdVKzENxHe7tlz9hoqGkK6UJE1XLS6TH9GZvsn4Y0a11OOMPK39aZs
	LxukF5A0/8gmPA99up+V5CB3w1qi3JGMPMdSQ/cI4
X-Gm-Gg: Acq92OFeOtf+AHvLU5KOMiHgPZ/U0fbJQUjEmvuBkALoSsQx+NBhDHHAT498r4Ihm2d
	wH1yRoYdECOrBl5dgYuh3NrVQG9sw/7qvLse6NR4/zKICCBeFCCpyzvFYrT9NCx5kYZNLtg0soa
	zdF9thV1Mbjna4GX/nR7yLm/j2eNrV7mB+qOhNb9nl7QhzhVmwPeBpp1jQG9KOyK8YZ7wsquZJf
	sl/JswaEPsV4vaRgnwdR3az+1TsEAq6Doa/SzQ0gJd4dPOOyeQBi6nJ2O0Nly/GHefUK2sabusi
	2gB36V8T74bV27b+45MKSCwAv1C9/Q==
X-Received: by 2002:a05:622a:9d8:20b0:516:4f62:85ea with SMTP id
 d75a77b69052e-516c553b726mr5238111cf.21.1779347645271; Thu, 21 May 2026
 00:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-15-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-15-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 21 May 2026 08:13:28 +0100
X-Gm-Features: AVHnY4I5mlImmNgj6VU9Np6tF4MeIY8QXPe0q5_43DkzSppchE88oaKE6aKRKpA
Message-ID: <CA+EHjTyZx88qAjKc=W1GOTMLdDFpTjuJkAPJ3W6Snnyn3ta8tg@mail.gmail.com>
Subject: Re: [PATCH v6 15/43] KVM: guest_memfd: Handle lru_add fbatch
 refcounts during conversion safety check
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 May 2026 at 21:22, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Ackerley Tng <ackerleytng@google.com>
>
> When checking if a guest_memfd folio is safe for conversion, its refcount
> is examined. A folio may be present in a per-CPU lru_add fbatch, which
> temporarily increases its refcount. This can lead to a false positive,
> incorrectly indicating that the folio is in use and preventing the
> conversion, even if it is otherwise safe. The conversion process might not
> be on the same CPU that holds the folio in its fbatch, making a simple
> per-CPU check insufficient.
>
> To address this, drain all CPUs' lru_add fbatches if an unexpectedly high
> refcount is encountered during the safety check. This is performed at most
> once per conversion request. Draining only if the folio in question may be
> lru cached.
>
> guest_memfd folios are unevictable, so they can only reside in the lru_add
> fbatch. If the folio's refcount is still unsafe after draining, then the
> conversion is truly deemed unsafe.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Not an area I've worked with that much, but it seems right to me:

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


> ---
>  mm/swap.c              |  2 ++
>  virt/kvm/guest_memfd.c | 18 ++++++++++++++----
>  2 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/mm/swap.c b/mm/swap.c
> index 5cc44f0de9877..3134d9d3d7c30 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -37,6 +37,7 @@
>  #include <linux/page_idle.h>
>  #include <linux/local_lock.h>
>  #include <linux/buffer_head.h>
> +#include <linux/kvm_types.h>
>
>  #include "internal.h"
>
> @@ -904,6 +905,7 @@ void lru_add_drain_all(void)
>         lru_add_drain();
>  }
>  #endif /* CONFIG_SMP */
> +EXPORT_SYMBOL_FOR_KVM(lru_add_drain_all);
>
>  atomic_t lru_disable_count = ATOMIC_INIT(0);
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 034b72b4947fb..050a8c092b1a3 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -8,6 +8,7 @@
>  #include <linux/mempolicy.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/pagemap.h>
> +#include <linux/swap.h>
>
>  #include "kvm_mm.h"
>
> @@ -596,18 +597,27 @@ static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
>         const int filemap_get_folios_refcount = 1;
>         pgoff_t last = start + nr_pages - 1;
>         struct folio_batch fbatch;
> +       bool lru_drained = false;
>         bool safe = true;
>         int i;
>
>         folio_batch_init(&fbatch);
>         while (safe && filemap_get_folios(mapping, &start, last, &fbatch)) {
>
> -               for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> +               for (i = 0; i < folio_batch_count(&fbatch);) {
>                         struct folio *folio = fbatch.folios[i];
>
> -                       if (folio_ref_count(folio) !=
> -                           folio_nr_pages(folio) + filemap_get_folios_refcount) {
> -                               safe = false;
> +                       safe = (folio_ref_count(folio) ==
> +                               folio_nr_pages(folio) +
> +                               filemap_get_folios_refcount);
> +
> +                       if (safe) {
> +                               ++i;
> +                       } else if (folio_may_be_lru_cached(folio) &&
> +                                  !lru_drained) {
> +                               lru_add_drain_all();
> +                               lru_drained = true;
> +                       } else {
>                                 *err_index = folio->index;
>                                 break;
>                         }
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
