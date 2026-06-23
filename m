Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A201C3C584E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205166; cv=pass; b=UWpxtfJAIiW8M87UgQrpytoXlVG2C1Hmp96qh0deIwzCZEw5hErzDNiYtQHtqUNAe3ebc1SEkFasRdulzZa2IE91Ui+h7znR2QrudY3/KjNPxRt6ktcgnFMc336M8dZEszRtp07ujE+peYkWs9nZ5D19msurongBAvgd2KRhq7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205166; c=relaxed/simple;
	bh=UGoqUAYtBwcvOzvzqQVEOAUHdQNj4ggDmWvOp55PxNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gto04Q87gi5W1rYXc89PK8asc46mLPs5eDHTcsx6CnDm01JdKfksGhqz+o73IQejVzsT+8PEadgGjQIMDe0bZDu6fxWGBBWH49aU+9VxcQRUtXeogzetUvUZh6s5phrAm4DfBQyCBZPEuH1LLvQww4jOeRxXNKcZoZZ2UqbSK9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=adgwLlag; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="adgwLlag"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51765331535so162761cf.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 01:59:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782205164; cv=none;
        d=google.com; s=arc-20260327;
        b=knKhOMPhFZqHAcvGvvUSORULVyOaz+Z6gjAOcqnrcwZ74YghXXZzdgHuxP7DTr35J0
         xuIO5PdSxLY+h1d6IgBha4G+4+Nu5phPazdZC2qHRm8c1gS6hECA8YPY+J3gwPdFBtJt
         FX1nxyQggVdt94LZTyL83TOgpYEt81xw1vQ57+5L8D2/Ol0Fe6Gh8wi5jgMXszh3ldQq
         kKOD/IAYRPsa/jvyMhYo+lkjHIiUhtQqOEa86gPnXMAUN6t8NZDUFFhbyYhoxqYoU9eT
         lLFFFEvVGBwh8sJ0niLFH5/odwYMbCdWCcAghU+T3akYQsPWQQhKpSv7dsZ1Z0Rxfb3s
         HxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1CwxGLz1a/U/PZjtJKb6pMN6pB5nXMPtX6D0w5J8tac=;
        fh=vGj8NvBMbJcQiS01oyCM7LmmJkKZhWKRx8irxSyaARA=;
        b=EuOcXGogZ9ZT/ejSwNDq6CQW1cKIzkK/PDhn5SuVX3zziH/3fPZ9CIGp2zEemcA80V
         wk7NzULerTupwSRwwy1/aZObUCxKI6DiATdx8wNirG776pd0BSeaTFFvRHQ+F0teYFfK
         tMiUlGH5k166dktpd8gUsL7K0wzsUrMYfwmPHW07juVzp2EUYVVmcRvypA9xZ0dip5B3
         wdg1fcFA+hi075l/wnK6Pc9kNs8nOFVJZr1Xn5FccOXb1XJrkP68HNnnGKQDqTr68xRG
         K0gKi8on0JL2BliFi7ZsvZhJ7NxBKE/bTSUPpIrx5STLlDk8cdDY1CXRaIVsufWz6e70
         D7oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782205164; x=1782809964; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1CwxGLz1a/U/PZjtJKb6pMN6pB5nXMPtX6D0w5J8tac=;
        b=adgwLlagVRlojKzJd0KmcYFm1rXo3tobPaahyuJDszoXdkSwIdzHIfbNieiineOht5
         zFDW7nlu+aRRU3yUJGF6VqJ30IC+ToJxm7E0y6+yoTUfqVoU3HE/LxoOJZo9cYn1c+Uc
         1KWQ7DU7iOIlXSIRyULe+xT+K9L2oVaOPprfwczDCk4ZWSenMAvJj/gXn3qWjOZrrRwu
         wtH6F7T92gDBYV7qrc1dm8Cz6c4jtuF1fjlJEuw183ShOaXBsZ2POzecwmfwqZC7z0kJ
         Jf+WK9EosyFvJAiOdKT43CX4Iaywxf+J0cMtXQPkKkq8yUwcdW2qQ2uraDb+R3UgyNxz
         huLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782205164; x=1782809964;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1CwxGLz1a/U/PZjtJKb6pMN6pB5nXMPtX6D0w5J8tac=;
        b=nJPkUrXg7/enZY+p6albVN0C17tExCr+n39O1fqARJKOmhpaYchLdo23tsPwvac4sf
         z3bk1+C5cKCU21Bgj4udFyJ2COH1Qs9WvDwUsyrjhkqieBsx/rgKhCZb9dz5tl1n1E1G
         uCpsNzkaWQS6/GhnSXkwGnTEG6Er39atNjdsRZeC9PRHpHSenRnBXbh2AndevfTs4p/x
         ES2y1Bs7U8Ki2FRPY+LbZGrHhvmTMjcUUw2gxby0/rCtjWROnuA9Jz9kQDI+CG97UKC9
         Qk+iBhQRU2r9aefFVILS1LfJzv4rF/MyUIy9an5KIUK7BpYhZWNnJUyM6/1NClivgMat
         kbYQ==
X-Forwarded-Encrypted: i=1; AFNElJ8uTigTw85uJ8UtFNnWLKnfmZQw2EjFF5JptUumAK4BjhIFw4VcD8FETdH0JmDf8cJgltDrb1p1+xbKy/+CWWUiaS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAISY1iAGTkyiyT+lK8Uj5TxiQ9sGm0E5ML4vVuTWrrSTXsONK
	kWqeabVV//ck9QrGOpqvzBxNz8bo3HNApSC/JjBZgsTUqFi28MHVKs5wUXYcbwWpc4L/Bbk5x0g
	v15NdUwwZh8MBVGYWRCWv/XCcc4qLEQaYqc5NwAQ3
X-Gm-Gg: AfdE7ckbteCBClUvY4o6d9P/eIZXDdtt987HcT4iVnpx60wNvfkWKmsL+IvhM8TTXXA
	v0mEHNaDOpf/NslLOVK6Wprv1I/8tP9egNIZQUdlYffYyQs93wVLOLhfOU/6UpB657n1WDMBpMA
	L3NCvQsUthRUSgV3bsWLR9PIIYy3nPYodR+3Gwxkx7pCmAulqHL7EhWpUqXAVV2tNW2dHmIKJKV
	8alkxS8lMY575lRQVEc9v2gfvkyKhQMt5ui6ztTScfN9CewE83WeGR2tn97jTMMlXSsWInSnA==
X-Received: by 2002:a05:622a:53c4:b0:4ff:c0e7:be9c with SMTP id
 d75a77b69052e-51a52188357mr9231071cf.0.1782205161783; Tue, 23 Jun 2026
 01:59:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-15-9d2959357853@google.com>
 <CA+EHjTx+3U++dnhGEkwh2SO82xMugAvvJ9ee1O__sxZCKL_X5A@mail.gmail.com> <ajneQVLriUshjFIO@google.com>
In-Reply-To: <ajneQVLriUshjFIO@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 23 Jun 2026 09:58:45 +0100
X-Gm-Features: AVVi8CfpDJy0J3C5-XoMAIo3UWrVbaFO5KPC7yjpf-92k1Ny5C4dioD7azy2jvM
Message-ID: <CA+EHjTx-1J0sEVxL8EB=j=y2Sd9mZ1eos1RCmAwj9eKjJsEcqQ@mail.gmail.com>
Subject: Re: [PATCH v8 15/46] KVM: guest_memfd: Call arch invalidate hooks on conversion
To: Sean Christopherson <seanjc@google.com>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Sean,

On Tue, 23 Jun 2026 at 02:15, Sean Christopherson <seanjc@google.com> wrote:
>
> On Fri, Jun 19, 2026, Fuad Tabba wrote:
> > On Fri, 19 Jun 2026 at 01:31, Ackerley Tng via B4 Relay
> > <devnull+ackerleytng.google.com@kernel.org> wrote:
> > >
> > > From: Ackerley Tng <ackerleytng@google.com>
> > >
> > > When memory in guest_memfd is converted from private to shared, the
> > > platform-specific state associated with the guest-private pages must be
> > > invalidated or cleaned up.
> > >
> > > Iterate over the folios in the affected range and call the
> > > kvm_arch_gmem_invalidate() hook for each PFN range. This allows
> > > architectures to perform necessary teardown, such as updating hardware
> > > metadata or encryption states, before the pages are transitioned to the
> > > shared state.
> > >
> > > Invoke this helper after indicating to KVM's mmu code that an invalidation
> > > is in progress to stop in-flight page faults from succeeding.
> > >
> > > Reviewed-by: Fuad Tabba <tabba@google.com>
> > > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> >
> > Coming back to this after working through the arm64/pKVM side. My
> > Reviewed-by here is from the previous round and the patch hasn't
> > changed, but I missed an implication for arm64.
> >
> > kvm_arch_gmem_invalidate() is now called from two paths with the same
> > (start, end) signature: folio teardown (kvm_gmem_free_folio) and
> > private->shared conversion (here). For SNP/TDX that's fine, conversion is
> > destructive anyway. For pKVM the two need opposite content semantics:
> > conversion must preserve the page in place (same physical page, the point
> > of in-place conversion without encryption), while teardown must scrub it
> > before returning it to the host.
> >
> > The hook gets only a pfn range with no indication of which caller it's
> > serving, so arm64 can't give the two paths the behaviour they need. It
> > would help to signal intent on the conversion path: a reason/flag, a
> > separate hook, or not routing non-destructive conversion through the
> > teardown hook.
> >
> > arm64 isn't here yet, so this isn't urgent, but the hook is gaining a
> > second caller now, and it's cheaper to leave room for the distinction
> > than to change a generic contract other arches depend on later.
>
> Crud.  It may not be urgent for arm64, but it's urgent for other reasons that
> I "can't" describe in detail at the moment, and even if that weren't the case, I
> think we should clean things up now.  More below.

No problem on the parts you can't get into. Agreed it's worth cleaning up
now, and worth doing in this round rather than landing the overloaded
hook: reworking a generic contract once SNP/TDX (and eventually arm64)
depend on it is the expensive path.

>
> > >  virt/kvm/guest_memfd.c | 41 +++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 41 insertions(+)
> > >
> > > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > > index 433f79047b9d1..3c94442bc8131 100644
> > > --- a/virt/kvm/guest_memfd.c
> > > +++ b/virt/kvm/guest_memfd.c
> > > @@ -607,6 +607,42 @@ static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
> > >         return safe;
> > >  }
> > >
> > > +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> > > +static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end)
>
> Not your fault, but kvm_arch_gmem_invalidate() is badly misnamed.  It's not
> "invalidating" anything, it's much more of a "free" callback, as SNP uses it to
> put physical pages back into a shared state when a maybe-private folio is freed.
>
> As Fuad points out, (ab)using that hook for the private=>shared conversion case
> "works", but not broadly.  And it makes the bad name worse, because it's called
> from code that _is_ doing true invalidations.  For pKVM, it may not even need to
> do anything invalidation-like.

Agreed on the name and the overload, and for pKVM the split is more than
cosmetic. The free/teardown path is where pKVM has to scrub a page before
it goes back to the host; conversion has to leave the page in place with
its contents intact (no encryption, same physical page in both states).
Keeping scrub on the free callback and off the conversion path is what
preserves that, so this helps us, it isn't just tidying SNP.

>
> To avoid a conflict with patches that are going to have priority over this series,
> to set the stage for arm64 support, and to avoid avoid bleeding vendor details
> into guest_memfd, as if they are core guest_memfd behavior (only SNP needs the
> "invalidation" on this specific transition), I think we should add an arch hook
> to do conversions straightaway.
>
> Unless there's a clever option I'm missing, it'll mean adding yet another
> HAVE_KVM_ARCH_GMEM_XXX flag?  Hmm, especially because IIUC, arm64/pKVM doesn't
> need a callback for this case, only the free_folio case.
>
> > > +{
> > > +       struct folio_batch fbatch;
> > > +       pgoff_t next = start;
> > > +       int i;
> > > +
> > > +       folio_batch_init(&fbatch);
> > > +       while (filemap_get_folios(inode->i_mapping, &next, end - 1, &fbatch)) {
> > > +               for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> > > +                       struct folio *folio = fbatch.folios[i];
> > > +                       pgoff_t start_index, end_index;
> > > +                       kvm_pfn_t start_pfn, end_pfn;
> > > +
> > > +                       start_index = max(start, folio->index);
> > > +                       end_index = min(end, folio_next_index(folio));
> > > +                       /*
> > > +                        * end_index is either in folio or points to
> > > +                        * the first page of the next folio. Hence,
> > > +                        * all pages in range [start_index, end_index)
> > > +                        * are contiguous.
> > > +                        */
> > > +                       start_pfn = folio_file_pfn(folio, start_index);
> > > +                       end_pfn = start_pfn + end_index - start_index;
> > > +
> > > +                       kvm_arch_gmem_invalidate(start_pfn, end_pfn);
> > > +               }
> > > +
> > > +               folio_batch_release(&fbatch);
> > > +               cond_resched();
> > > +       }
> > > +}
> > > +#else
> > > +static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end) {}
> > > +#endif
> > > +
> > >  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> > >                                      size_t nr_pages, uint64_t attrs,
> > >                                      pgoff_t *err_index)
> > > @@ -647,7 +683,12 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> > >          */
> > >
> > >         kvm_gmem_invalidate_start(inode, start, end);
> > > +
> > > +       if (!to_private)
> > > +               kvm_gmem_invalidate(inode, start, end);
>
> E.g. instead make this something like this?
>
>         kvm_gmem_set_pfn_attributes(...)
>
> Hrm, though that wastes folio lookups in the to_private case.  So maybe just this,
> assuming pKVM doesn't need to take additional action on conversions?

You're right, and we expect it to hold for both directions, not only
private->shared. pKVM conversions are driven by the guest's
share/unshare hypercall: EL2 makes the stage-2 ownership change (grant
or remove host access) on the hypercall and exits, and the host
records it via KVM_SET_MEMORY_ATTRIBUTES2 afterwards. So by the time
guest_memfd updates attributes the EL2 side is already done in either
direction, and the ioctl is host-side bookkeeping. The only arch
callback we expect to need is the free/teardown one, nothing on
convert, and we wouldn't want a make_private hook either.

>
>         if (!to_private)
>                 kvm_gmem_make_shared(...)
>
> Actually, if we do that, then we don't need a separate arch hook, just a separate
> config.  It'll still bleed SNP details into guest_memfd, but it'll at least be
> done in a way that's more explicitly arch specific (and it's no different than
> what we already do for PREPARE...).

Doing it config-only (no separate convert hook) works for us, and nothing
about it constrains arm64. If connecting pKVM conversion to gmem later
turns up something we need, we'd add it config-gated in parallel, not by
overloading the renamed callback.

Cheers,
/fuad

>
> E.g. this?  There will still be a looming rename conflict, but that's easy enough
> to handle.
>
> diff --git virt/kvm/guest_memfd.c virt/kvm/guest_memfd.c
> index 9ce5be7843f2..8aead0abd788 100644
> --- virt/kvm/guest_memfd.c
> +++ virt/kvm/guest_memfd.c
> @@ -648,8 +648,8 @@ static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
>         return safe;
>  }
>
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end)
> +#ifdef CONFIG_KVM_ARCH_GMEM_FREE_ON_SHARED_CONVERSION
> +static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, pgoff_t end)
>  {
>         struct folio_batch fbatch;
>         pgoff_t next = start;
> @@ -681,7 +681,7 @@ static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end)
>         }
>  }
>  #else
> -static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end) {}
> +static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, pgoff_t end) { }
>  #endif
>
>  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> @@ -729,7 +729,7 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>         kvm_gmem_invalidate_start(inode, start, end);
>
>         if (!to_private)
> -               kvm_gmem_invalidate(inode, start, end);
> +               kvm_gmem_make_shared(inode, start, end);
>
>         mas_store_prealloc(&mas, xa_mk_value(attrs));
