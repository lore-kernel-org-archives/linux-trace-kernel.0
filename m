Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD3F22126C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 01:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782177349; cv=none; b=rXTXVCg32sOu/EElAHjGzI69If43WuUzbiEMwBh4Dtn2rX7mBEFPQg06lCBvYFHnNOeQt0LL6V74y+oWaq83Vr7FeXCIOZ91eDuEA/HxPywxXw6dhilWPjbvLUY75QvMWVEvQRtH5K1qDNRTmCktMxuQtEFbsO0/ENrip7UWyhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782177349; c=relaxed/simple;
	bh=CJC2eEAu9a9FSgizYGmOPBhbJTloZgwrRUlwAxJ41/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ofqWr28OOjZjB5OCPajguE+BeonHShOIdP2dh15WLPNKyjD4RXWrc7NZDbx4pcfQ6z4neaKm4FIeHEtolw1ZbYR+LjovNZmjZ00b0J7PqGuSvGGGRjuoH/65mCEONI95Zn0vBc/Z7Qog/6kIX/vA525qhZqd+pq/5ZEpZm9nSCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cdno2SBN; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cdno2SBN"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-842446a3851so2570869b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 18:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782177347; x=1782782147; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cIaeqJX/r6ONezV3RTMNlvuGHs6v4DCaJbK0FNFaqOE=;
        b=cdno2SBNB9DpXRN00nZKja+FMHqRnIpYgfaHVnysBzv/RtkarjGmq/2gryLAW/W3oQ
         qY3hjgKZzhZcZrEFJlOb84R5zz7Lr8kIVYp9m5k4kyxxxJ1s6JyJTUUOjF1KESGr1tYD
         laUgFKB7WoN+cu9XGQEigVb+o27F1a/twJ2MwraRrs6szoGSlDgk2Pz6aOZ1f3mCf5Dv
         AwWwXsXlSAshXdU9Fnlhuk03ut/NgiUGRlEPzXyL/HH2SPUvYMEP0xrSAqulk4woQbLq
         pofg6HTXLZzRDrITf2yxSrQglLdwNraR8uUtdWJWqLJ1pvsgv3/edp0o2mG1LQ2ISpcE
         wY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782177347; x=1782782147;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cIaeqJX/r6ONezV3RTMNlvuGHs6v4DCaJbK0FNFaqOE=;
        b=NgbIgMFMmSbH6nZnEA7V+eYa37ysyfn/N4mBcxn7ikUX1mngNnPMsW93rIzC7PyML2
         oj/KQZgkzOFmxP2mZ8WBeWXDAncgrGCLFGcu4Uvjy6sFv+MgYe1+5revrt01RzY8n9br
         49UcKB5Xcnta4M0BKD2wBXgNOVSBXnhHPNTePRkFWeN3DZXEp7wJLvReB/1J1ABGfnVW
         El5HPyGpxR9mTSAWt37eMrzJGP+go1PoQ/KIT3MbsRGhAOHFEHEjA210QBwuNDipYTU/
         oC6XfMblWA2n6fsbAkCmWK/w+pILpjRzcBVkYKQuI8gpuMLoLc2O6SU4Fqz4y+xqyQNz
         gyIg==
X-Forwarded-Encrypted: i=1; AFNElJ+j5qEYTYB7NwxEZNrf57szUWdeKRoV5aSxPHAq6YRu8kUc0BCCDDIS1n8UL7h3sHWE9w1DBmdL3CxFSCEPqrQelyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx928ng0ekPdOHWR6gqbTlswR02NO0+QOT+h8A/Bo0N5WSktv1w
	XDAueODGd+imRdbjy+otBsjTBX/3ozhXCKICg5bfr1MrzamIM6AB2TU2laJsO9qkJY/doE9pU5T
	4T2SObQ==
X-Received: from pfbim3.prod.google.com ([2002:a05:6a00:8d83:b0:845:2f64:1f67])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:22c5:b0:82f:38df:681c
 with SMTP id d2e1a72fcca58-8459704a890mr377593b3a.6.1782177346471; Mon, 22
 Jun 2026 18:15:46 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:15:45 -0700
In-Reply-To: <CA+EHjTx+3U++dnhGEkwh2SO82xMugAvvJ9ee1O__sxZCKL_X5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-15-9d2959357853@google.com> <CA+EHjTx+3U++dnhGEkwh2SO82xMugAvvJ9ee1O__sxZCKL_X5A@mail.gmail.com>
Message-ID: <ajneQVLriUshjFIO@google.com>
Subject: Re: [PATCH v8 15/46] KVM: guest_memfd: Call arch invalidate hooks on conversion
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <tabba@google.com>
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
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 19, 2026, Fuad Tabba wrote:
> On Fri, 19 Jun 2026 at 01:31, Ackerley Tng via B4 Relay
> <devnull+ackerleytng.google.com@kernel.org> wrote:
> >
> > From: Ackerley Tng <ackerleytng@google.com>
> >
> > When memory in guest_memfd is converted from private to shared, the
> > platform-specific state associated with the guest-private pages must be
> > invalidated or cleaned up.
> >
> > Iterate over the folios in the affected range and call the
> > kvm_arch_gmem_invalidate() hook for each PFN range. This allows
> > architectures to perform necessary teardown, such as updating hardware
> > metadata or encryption states, before the pages are transitioned to the
> > shared state.
> >
> > Invoke this helper after indicating to KVM's mmu code that an invalidation
> > is in progress to stop in-flight page faults from succeeding.
> >
> > Reviewed-by: Fuad Tabba <tabba@google.com>
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> 
> Coming back to this after working through the arm64/pKVM side. My
> Reviewed-by here is from the previous round and the patch hasn't
> changed, but I missed an implication for arm64.
> 
> kvm_arch_gmem_invalidate() is now called from two paths with the same
> (start, end) signature: folio teardown (kvm_gmem_free_folio) and
> private->shared conversion (here). For SNP/TDX that's fine, conversion is
> destructive anyway. For pKVM the two need opposite content semantics:
> conversion must preserve the page in place (same physical page, the point
> of in-place conversion without encryption), while teardown must scrub it
> before returning it to the host.
>
> The hook gets only a pfn range with no indication of which caller it's
> serving, so arm64 can't give the two paths the behaviour they need. It
> would help to signal intent on the conversion path: a reason/flag, a
> separate hook, or not routing non-destructive conversion through the
> teardown hook.
> 
> arm64 isn't here yet, so this isn't urgent, but the hook is gaining a
> second caller now, and it's cheaper to leave room for the distinction
> than to change a generic contract other arches depend on later.

Crud.  It may not be urgent for arm64, but it's urgent for other reasons that
I "can't" describe in detail at the moment, and even if that weren't the case, I
think we should clean things up now.  More below.

> >  virt/kvm/guest_memfd.c | 41 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index 433f79047b9d1..3c94442bc8131 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -607,6 +607,42 @@ static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
> >         return safe;
> >  }
> >
> > +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> > +static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end)

Not your fault, but kvm_arch_gmem_invalidate() is badly misnamed.  It's not
"invalidating" anything, it's much more of a "free" callback, as SNP uses it to
put physical pages back into a shared state when a maybe-private folio is freed.

As Fuad points out, (ab)using that hook for the private=>shared conversion case
"works", but not broadly.  And it makes the bad name worse, because it's called
from code that _is_ doing true invalidations.  For pKVM, it may not even need to
do anything invalidation-like.

To avoid a conflict with patches that are going to have priority over this series,
to set the stage for arm64 support, and to avoid avoid bleeding vendor details
into guest_memfd, as if they are core guest_memfd behavior (only SNP needs the
"invalidation" on this specific transition), I think we should add an arch hook
to do conversions straightaway.

Unless there's a clever option I'm missing, it'll mean adding yet another
HAVE_KVM_ARCH_GMEM_XXX flag?  Hmm, especially because IIUC, arm64/pKVM doesn't
need a callback for this case, only the free_folio case.

> > +{
> > +       struct folio_batch fbatch;
> > +       pgoff_t next = start;
> > +       int i;
> > +
> > +       folio_batch_init(&fbatch);
> > +       while (filemap_get_folios(inode->i_mapping, &next, end - 1, &fbatch)) {
> > +               for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> > +                       struct folio *folio = fbatch.folios[i];
> > +                       pgoff_t start_index, end_index;
> > +                       kvm_pfn_t start_pfn, end_pfn;
> > +
> > +                       start_index = max(start, folio->index);
> > +                       end_index = min(end, folio_next_index(folio));
> > +                       /*
> > +                        * end_index is either in folio or points to
> > +                        * the first page of the next folio. Hence,
> > +                        * all pages in range [start_index, end_index)
> > +                        * are contiguous.
> > +                        */
> > +                       start_pfn = folio_file_pfn(folio, start_index);
> > +                       end_pfn = start_pfn + end_index - start_index;
> > +
> > +                       kvm_arch_gmem_invalidate(start_pfn, end_pfn);
> > +               }
> > +
> > +               folio_batch_release(&fbatch);
> > +               cond_resched();
> > +       }
> > +}
> > +#else
> > +static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end) {}
> > +#endif
> > +
> >  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> >                                      size_t nr_pages, uint64_t attrs,
> >                                      pgoff_t *err_index)
> > @@ -647,7 +683,12 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> >          */
> >
> >         kvm_gmem_invalidate_start(inode, start, end);
> > +
> > +       if (!to_private)
> > +               kvm_gmem_invalidate(inode, start, end);

E.g. instead make this something like this?

	kvm_gmem_set_pfn_attributes(...)

Hrm, though that wastes folio lookups in the to_private case.  So maybe just this,
assuming pKVM doesn't need to take additional action on conversions?

	if (!to_private)
		kvm_gmem_make_shared(...)

Actually, if we do that, then we don't need a separate arch hook, just a separate
config.  It'll still bleed SNP details into guest_memfd, but it'll at least be
done in a way that's more explicitly arch specific (and it's no different than
what we already do for PREPARE...).

E.g. this?  There will still be a looming rename conflict, but that's easy enough
to handle.

diff --git virt/kvm/guest_memfd.c virt/kvm/guest_memfd.c
index 9ce5be7843f2..8aead0abd788 100644
--- virt/kvm/guest_memfd.c
+++ virt/kvm/guest_memfd.c
@@ -648,8 +648,8 @@ static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
        return safe;
 }
 
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end)
+#ifdef CONFIG_KVM_ARCH_GMEM_FREE_ON_SHARED_CONVERSION
+static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, pgoff_t end)
 {
        struct folio_batch fbatch;
        pgoff_t next = start;
@@ -681,7 +681,7 @@ static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end)
        }
 }
 #else
-static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end) {}
+static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, pgoff_t end) { }
 #endif
 
 static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
@@ -729,7 +729,7 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
        kvm_gmem_invalidate_start(inode, start, end);
 
        if (!to_private)
-               kvm_gmem_invalidate(inode, start, end);
+               kvm_gmem_make_shared(inode, start, end);
 
        mas_store_prealloc(&mas, xa_mk_value(attrs));
