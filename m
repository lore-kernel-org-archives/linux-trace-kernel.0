Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279AE4503E5
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541884; cv=pass; b=NKrPQzGuvzBKpC/9c0XHIaxFBRkQ077I9nv6WIXIEdSml7SHc/M345AI3l1mJTu8T0TopfWvIwAqwEoooV852n3p5PhhrJfO6zZdEVcGUFinfqHCqq1moyCRaG6ICO5oAiF2JhzNuI95SNWPTq9I0NpWw/JU/v7ruwZ/e9Hphj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541884; c=relaxed/simple;
	bh=ogjpgBBuRJDVsJoOgismEb1l1STFPRdqrmOGMgUrh1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kILjdaJrK1QIZa1/Z1ogZnFcmSPygTO9JSjnDaV0vjQoAOKJ8ktSoWaU0jVxix2jnULPuSQsHLGa6F8mYf0IwIJFSR/HgRNZ0Av3JtHSM3aoj+TfBnIOCEHB/JEX9pqPaTwlrmQPzl1Mg3sMY7BmYz6pVEkzPyVoAfZooXCvf6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V8VOpEqz; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V8VOpEqz"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c15a5b265so229771cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 06:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786541865; cv=none;
        d=google.com; s=arc-20260327;
        b=DYy7eecB93tNQrN3G5j/nm4CJJq0WqsYLy5mk1URbcAgDYABV5vY5w9GUFz5x6iqcF
         yNWX/VQPi5+s2LE1gXbWuIrAo3IMiuF0U6flDHT6dLocPVB/KvlP1oKOzkA9R9fN3GmI
         DpHTX2kf3qXX8Nfa5UWLV4RJDlUdnWqIEPrRwMqlHxngmHjbP4oCf8GDwSQgHYDyak/x
         R65GEkCCu1tzjpVwcsXCDVfs2JVWsRbQmjSD86EFJ1xzMkAZ9EMMpeYAk8CBElN1lytK
         sDveE2UY9OQlSFGepqytl7o5zs/6C/6GVe3wx7iS4jL+XVPCRnzvu/ljMqyDmofVUONp
         Ac/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=S2/eW8js8WPIEzN4muuCXfZ23ENIccFKrP1Pa44pPgE=;
        fh=aej9LQOhE4NfA2Z76aRHxwiOjC72y2yRVMXYwNbbHkM=;
        b=KENnb292VN6wEC/Gs2nNfYsf6qJLgzepuoJeS9TWZWAPnlqmkhoS6P2Z7/XT7VQz1I
         Q0UlSAVdhY5PG9Mv7w6Ljwy8hndHrlqCrC0pE04VWYL1XQpak/d2Wn+UA0Nes2AM+Q0n
         xJoWufNEQapPT30FjNp4nwirPXeGPkGGgTeL+N2KEU3VkgkFCHAf7ckcurWV/4G4jcs5
         namOQ9+2aRphTIr7Lbo0UD/qJbeKPO3VQySyz7Ge8n/VTLXpq4gzi9uPVQAdcVYxqbdx
         ZWid1LDSp4s5VJoxNMDQDn0J2lkI9CxZK5p8Dmxb83rrs6+XSF4OkJSlim+v4ymcHU41
         H2nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786541865; x=1787146665; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2/eW8js8WPIEzN4muuCXfZ23ENIccFKrP1Pa44pPgE=;
        b=V8VOpEqz3osEnlzMrKdYwW/3jAtfaObPRoI1vUytjSzWtECYEFWQKBFAijoPGrxXJd
         ZZkdgrYeGrcJEDW6VvycXq6FvMVh48kDNSaCJiQLh7unhvG0PzW9GkiAeY5oA5K1yf3s
         azCh6vjGEyS2qcdzvzkWtYvF59uHSjWYSRFavJegrGrCEsM2g+rim/UGYbx8G2hFyzsc
         6JHKZgccoQAE7epjcNg0EA/rMTjL6WYBNhZ14Drt+FohEuyKlNMT/3w6ERWaZM7aQ0FY
         8QS3TAl88GGQYSFv2dX1xMGWtHy449OPlidlaNif7thiR8bspio9IWtHPMly8Ncc5fHX
         DWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786541865; x=1787146665;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S2/eW8js8WPIEzN4muuCXfZ23ENIccFKrP1Pa44pPgE=;
        b=LG/i1FDGc2Via+gj8ekRjhzhIcPrQnfbrMlqr9dLp94r2ldSX+P8yOY8NYlN7fN0nQ
         +bSYf2J2gLkf7dRMqLUKWJ66TFm1fJTQdZ7x8Ngx5rUgjohhWSv+vh0GkYrieJbRBYPX
         +q/RLJQ4AY2HrnuyUNspDT1CEPGBzjV2fSypvKn01xkwWu4rjmzLAH4peicxzqAsV5MJ
         GxbQR0eDkdZkCQY4+83TmoZ4r8bCgusGIOyU1SCDPazfHbrQ93Dh8giwW0uyV0VfeO9C
         ehA3yIDJaYPTqswsEcPCD0/Z3DtzJgWV7LVInMpdKr5qao/HwCEPZtsJJ3CJEkW9NoI9
         GtEA==
X-Forwarded-Encrypted: i=1; AHgh+RoQqVPRH9GJ2x/UnGwRXmr4BmVUrwjIF0jogbHWFmkJEdOdkRmKH2iXYX9m86iU779OJYruseePtgPFKjABs+maH6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ8/6hy0afC+1xdzB2fsKoV9h0ztwue0pnLpXmBXrhp5lBjrIm
	dlsh6EIDLYcBHN7cfJdWBYhsGddmgzqgNTD+hP2e90JkNXKyPEwzayPmg6KJsL7Bx5po3RB+QsS
	41mIea12moWu1SqcsisSPqJozN9W8ZbFw1o2LOivD
X-Gm-Gg: AR+sD10z6BoW4MJdq+fccGAXKcE96BtTjDHl07D7I8LF3R8UJ/Qj553qe/FPlhE2vWL
	T0H3PDC1agVJwaDkfA/nbr+XRKosE2WXelAnqBSnwn0jIfkWcUPVdmxxpj2gDXcSuPt4d5xvBZS
	Bq0/W3jpb3posm/IugZiNaXAQQzaTRrpkRby7nju3IndHbRox6zpIFnpg1deWUW7ZsY5MJeqyOI
	Qrd5kGwt+BwcS0Pr4wQgWP3O9Qp/blCXJB4Qax3Ia8tN0gdCM+LANRcy5tRQpilen9MoW8ocyFn
	bnplR70H+qJOp9+a/RcryaJgHwQoC4v5TtQ6HVOdoFdmDw==
X-Received: by 2002:ac8:5716:0:b0:51c:ca9:3d17 with SMTP id
 d75a77b69052e-52d61f7a0e7mr18935971cf.12.1786541863881; Wed, 12 Aug 2026
 06:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com> <20260807-gmem-inplace-conversion-v10-14-2fc18ee6d3ba@google.com>
In-Reply-To: <20260807-gmem-inplace-conversion-v10-14-2fc18ee6d3ba@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 12 Aug 2026 15:37:06 +0200
X-Gm-Features: AUfX_mzUD6PeEtmKkDfteoyWkYyMiizOHZtVOuf49kBLBevxhRMZd8gNAqxz5ac
Message-ID: <CA+EHjTy83rq0m5=QyPKmxPfFkc+kHzzuY4mV9nThdguW41Ws6A@mail.gmail.com>
Subject: Re: [PATCH v10 14/41] mm/gup: factor out LRU cache draining for folio
 into lru_cache_drain_for_folio()
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Aug 2026 at 23:52, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: "David Hildenbrand (Arm)" <david@kernel.org>
>
> KVM with guest_memfd wants to remove any folio references due to LRU
> caches, as it really must only allow to convert folios from shared to
> private when there are no unexpected folio references (e.g., from GUP
> references).
>
> So, to drive the refcount down, it needs a way to flush the LRU caches.
> Let's factor out what we have in lru_cache_drain_for_folio(). Document
> it, and also mention that concurrent folio (un)mapping might, in theory,
> miss detecting LRU cache references. Keep obtaining the expected refcount
> twice to minimize the possibility. For the current and future user that
> should work, and we don't really have a better alternative: we could
> detect if the mapcount changed, but it would still be racy and add more
> complexity with questionable benefit.
>
> Maybe there is a chance to avoid the draining entirely in the future,
> by avoiding extra references from the LRU cache: Hugh thinks there might
> be a way. But for the time being, this handling is unfortunately
> required.
>
> Make folio_may_be_lru_cached() accept a const pointer so
> lru_cache_drain_for_folio() can accept a const pointer as well.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad

> ---
>  include/linux/swap.h | 11 ++++++++++-
>  mm/gup.c             | 15 ++-------------
>  mm/swap.c            | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 8f0f68e245baa..e625d64c9e13d 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -317,7 +317,7 @@ void folio_add_lru_vma(struct folio *, struct vm_area_struct *);
>  void mark_page_accessed(struct page *);
>  void folio_mark_accessed(struct folio *);
>
> -static inline bool folio_may_be_lru_cached(struct folio *folio)
> +static inline bool folio_may_be_lru_cached(const struct folio *folio)
>  {
>         /*
>          * Holding PMD-sized folios in per-CPU LRU cache unbalances accounting.
> @@ -344,6 +344,15 @@ extern void lru_add_drain(void);
>  extern void lru_add_drain_cpu(int cpu);
>  extern void lru_add_drain_cpu_zone(struct zone *zone);
>  extern void lru_add_drain_all(void);
> +
> +enum lru_cache_drained {
> +       LRU_CACHE_NOT_DRAINED,
> +       LRU_CACHE_DRAINED,
> +       LRU_CACHE_DRAINED_ALL,
> +};
> +void lru_cache_drain_for_folio(const struct folio *folio,
> +               unsigned int extra_refs, enum lru_cache_drained *drained);
> +
>  void folio_deactivate(struct folio *folio);
>  void folio_mark_lazyfree(struct folio *folio);
>  extern void swap_setup(void);
> diff --git a/mm/gup.c b/mm/gup.c
> index bde05664fe9a9..1bd8915517196 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2266,9 +2266,9 @@ static unsigned long collect_longterm_unpinnable_folios(
>                 struct list_head *movable_folio_list,
>                 struct pages_or_folios *pofs)
>  {
> +       enum lru_cache_drained drained = LRU_CACHE_NOT_DRAINED;
>         unsigned long collected = 0;
>         struct folio *folio;
> -       int drained = 0;
>         long i = 0;
>
>         for (folio = pofs_get_folio(pofs, i); folio;
> @@ -2293,18 +2293,7 @@ static unsigned long collect_longterm_unpinnable_folios(
>                  * but also to remove any other folio references from LRU
>                  * caches.
>                  */
> -               if (drained == 0 && folio_may_be_lru_cached(folio) &&
> -                               folio_ref_count(folio) !=
> -                               folio_expected_ref_count(folio) + pin_refs) {
> -                       lru_add_drain();
> -                       drained = 1;
> -               }
> -               if (drained == 1 && folio_may_be_lru_cached(folio) &&
> -                               folio_ref_count(folio) !=
> -                               folio_expected_ref_count(folio) + pin_refs) {
> -                       lru_add_drain_all();
> -                       drained = 2;
> -               }
> +               lru_cache_drain_for_folio(folio, pin_refs, &drained);
>
>                 if (!folio_isolate_lru(folio))
>                         continue;
> diff --git a/mm/swap.c b/mm/swap.c
> index 588f50d8f1a8c..8e965c8ce9aa9 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -950,6 +950,52 @@ void lru_add_drain_all(void)
>  }
>  #endif /* CONFIG_SMP */
>
> +/**
> + * lru_cache_drain_for_folio() - drain LRU caches if the caches might hold
> + *                              folio references
> + * @folio: The folio.
> + * @extra_refs: Extra folio references held by the caller.
> + * @drained: Drain status for batch folio processing.
> + *
> + * Drain LRU caches if the caches might hold folio references. Start
> + * with a local LRU cache drain, to then drain LRU caches on all CPUs if
> + * local draining was insufficient.
> + *
> + * This function detects LRU cache references by comparing the folio refcount
> + * with the sum of the expected folio refcount + extra references held by the
> + * caller. Note that we cannot rely on PG_lru to reliably detect all LRU
> + * cache references, and there are rare scenarios (concurrent folio (un)mapping)
> + * where this function might miss detecting LRU cache references.
> + *
> + * If @drained is not NULL, the function will avoid re-draining LRU caches
> + * when processing multiple folios in a row. In that case, the variable
> + * @drained points at must be initialized to LRU_CACHE_NOT_DRAINED before
> + * the first invocation by the caller.
> + */
> +void lru_cache_drain_for_folio(const struct folio *folio,
> +               unsigned int extra_refs, enum lru_cache_drained *drained)
> +{
> +       if (!folio_may_be_lru_cached(folio))
> +               return;
> +
> +       if (!drained || *drained == LRU_CACHE_NOT_DRAINED) {
> +               if (folio_ref_count(folio) ==
> +                   folio_expected_ref_count(folio) + extra_refs)
> +                       return;
> +               lru_add_drain();
> +               if (drained)
> +                       *drained = LRU_CACHE_DRAINED;
> +       }
> +       if (!drained || *drained == LRU_CACHE_DRAINED) {
> +               if (folio_ref_count(folio) ==
> +                   folio_expected_ref_count(folio) + extra_refs)
> +                       return;
> +               lru_add_drain_all();
> +               if (drained)
> +                       *drained = LRU_CACHE_DRAINED_ALL;
> +       }
> +}
> +
>  atomic_t lru_disable_count = ATOMIC_INIT(0);
>
>  /*
>
> --
> 2.55.0.654.g21b8a5bc05-goog
>
>
