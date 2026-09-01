Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E7649E5C0
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287719; cv=none; b=R6uFTRF5abB/yPjzizqc6J94BtP+vo/VKLV4W6GNxARsmQgeVrIoMMfJ6BesoSSCatIK1NXiIChEGEEVvKzT7krc4WEuONccUUmsrH2b0UymqfaeqbtDvyBM2H8X5KEGo6LqAlpU4MtWSVdUlo21Cn7gPONXuODs/RPlq8Z9nO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287719; c=relaxed/simple;
	bh=d6mWEdAbh3pA6h0kvJxTmQz3sCAdRZUVlyIUylbQoi4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jBve0MtMjUxA5MfMFkUVXaFKWMOSCCXa7dX0QH1A9oIDU+jO3f1WWgGIreEnKcPRIZtY5tWHw3JkK3OUn8QSu1f8SdJVuOrV97sghNJhkYZwPerbPg9qeEz2FiFOPBE9usOSwiZdh/CdRnZ0kPSnNQ2udlMf9KbzkuZSSZdFUzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aJ/i8hKe; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aJ/i8hKe"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1d85c012dso302589a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 11:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788287717; x=1788892517; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LA0MtyhL9+n6pP8AlY+vz7qS2JveEW6zRalGa05+rBs=;
        b=aJ/i8hKeU2jlhpAWK9sJzuUmkRVeSqRdCS/Lig6QNmblH4MuDa9c+UgAFgPjRbPKDN
         OPo+yFpDnfV0UDQnzFnUceEivvRvHRFJTqcHPzYHSmQ5POGpEc9kv0OgE/WsYJ6VMccc
         JwFMDVTiz9gFkUBsnorJqYL9LOlRF0/z9kvG4rylrasCO3J+5I/rlRR5F3ASsMjYSr8U
         Oi9MO4w1oQIqF7d6NitC9j/W64i55ErnuLaKHk2VYXSL9I1D/EYIYAzDAChBsxWjL9TN
         Npo8jE1cxufv7fZS2WwJJd9J9wUbrWMhjNxEsI1vRJbFHz3i5W8smZNMS52hIOm0MqqQ
         AP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788287717; x=1788892517;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LA0MtyhL9+n6pP8AlY+vz7qS2JveEW6zRalGa05+rBs=;
        b=WZBmhAWr/dISqXE/DkVncL7bNlN0vSdH9pW5juZvc2sr1n1V2OY36R6ddbOxzX6mnk
         G5JAxmJhw3/CjR4TFtw2oCKv9NSBr0+OCP6Tb6YpLqKLpyqCEeTeidJbzlVqOUQxqanz
         J8iLvnNQT4y4Q+GYyM7elXb3/UXvj0q9VOaVO82UC/jPzPmbgNeW8kPJ2Ce2bqdLFfPK
         d/Wje/Mbw3MAdATrj+uqn7Otq2KbBlA0BqSlvvpRoqxmo8xELiHIoMHP6ufBXoeUgWoZ
         +jYQx4uR/CQZTFTgu7XkWwG7FXkKuFhyoloxzOEB23ayJvUCsQ4VhpSaRZTlaXrHX5af
         ENlQ==
X-Forwarded-Encrypted: i=1; AHgh+RrO8Mcuy0xrN75tn/lH2Q8U/JC/HVmY/zXQyOIuFaOwGWmpotX1IxfP1VMf/DaJnru4w4tZLHgQPrzJoLLCLThJ8uI=@vger.kernel.org
X-Gm-Message-State: AFuF++lzIhd0ubcw3O3e6PXJgqYH/tDxi06TpiXKXALrl8HcULIALKSS
	vR5SLAjlUfKYUQ6BCpm/Ggc0zyGdvLx5pmUajZmJAy+VCxprG6SW6ja6ncI698+apD53e88olin
	JasQ+ww==
X-Received: from pgcv12.prod.google.com ([2002:a05:6a02:530c:b0:c96:acc6:54d6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3944:b0:3d3:aec2:4dcb
 with SMTP id adf61e73a8af0-3d7b075b26bmr19293744637.23.1788287716571; Tue, 01
 Sep 2026 11:35:16 -0700 (PDT)
Date: Tue, 1 Sep 2026 11:35:15 -0700
In-Reply-To: <CA+EHjTzJbC=ZvB3Mopw-TLf=13-iqxGw5RfTp6Gt5S1hi8WRRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com>
 <20260830-gmem-inplace-conversion-v12-15-85e5fd25252a@google.com> <CA+EHjTzJbC=ZvB3Mopw-TLf=13-iqxGw5RfTp6Gt5S1hi8WRRA@mail.gmail.com>
Message-ID: <apca475JqemLUjlb@google.com>
Subject: Re: [PATCH v12 15/45] KVM: guest_memfd: Ensure pages are not in use
 before conversion
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Randy Dunlap <rdunlap@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 01, 2026, Fuad Tabba wrote:
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index 803c7cdbbe0f6..fe02c47c85fb5 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -538,8 +538,46 @@ static int kvm_gmem_mas_preallocate(struct ma_state *mas, u64 attributes,
> >         return mas_preallocate(mas, xa_mk_value(attributes), GFP_KERNEL);
> >  }
> >
> > +static bool kvm_gmem_has_outstanding_references(struct inode *inode,
> > +                                               pgoff_t start, size_t nr_pages,
> > +                                               pgoff_t *err_index)
> > +{
> > +       struct address_space *mapping = inode->i_mapping;
> > +       pgoff_t last = start + nr_pages - 1;
> > +       bool has_outstanding = false;
> > +       struct folio_batch fbatch;
> > +       pgoff_t next;
> > +       int i;
> > +
> > +       folio_batch_init(&fbatch);
> > +
> > +       next = start;
> > +       while (has_outstanding && filemap_get_folios(mapping, &next, last, &fbatch)) {
> 
> has_outstanding starts as false, so the loop never runs and the function
> always returns false. The outstanding-reference check is dead at this
> patch, so a to-private conversion would not be rejected even when a page
> still has an outstanding reference.
> 
> It's fixed later in "KVM: guest_memfd: Handle lru_add fbatch refcounts
> during conversion safety check", which changes the condition to
> !has_outstanding. I think that fix belongs in this patch, so the check
> works when it is introduced and the series bisects cleanly.

Why even bother with has_outstanding?  Avoiding it requires copy+pasting
folio_batch_release(), but it's less code and IMO the end result is a lot easier
to follow:

	struct address_space *mapping = inode->i_mapping;
	pgoff_t last = start + nr_pages - 1;
	struct folio_batch fbatch;
	pgoff_t next;
	int i;

	folio_batch_init(&fbatch);

	next = start;
	while (filemap_get_folios(mapping, &next, last, &fbatch)) {
		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
			struct folio *folio = fbatch.folios[i];

			/*
			 * Outstanding references are anything other than those
			 * from the page cache, plus 1 temporary reference held
			 * by filemap_get_folios() in the folio batch.
			 */
			if (folio_ref_count(folio) != folio_nr_pages(folio) + 1) {
				*err_index = max(start, folio->index);
				folio_batch_release(&fbatch);
				return true;
			}
		}

		folio_batch_release(&fbatch);
		cond_resched();
	}

	return false;

and then we end up with:

	enum lru_cache_drained drained = LRU_CACHE_NOT_DRAINED;
	struct address_space *mapping = inode->i_mapping;
	pgoff_t last = start + nr_pages - 1;
	struct folio_batch fbatch;
	pgoff_t next;
	int i;

	folio_batch_init(&fbatch);

	next = start;
	while (filemap_get_folios(mapping, &next, last, &fbatch)) {
		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
			struct folio *folio = fbatch.folios[i];

			if (__folio_has_outstanding_references(folio, &drained)) {
				*err_index = max(start, folio->index);
				folio_batch_release(&fbatch);
				return true;
			}
		}

		folio_batch_release(&fbatch);
		cond_resched();
	}

	return false;
