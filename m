Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E1B49EC51
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288108; cv=none; b=ZpOuFNF/LDx0iCGQMKlNgsB3QFd9OfsQphFGw8dS1fKKTvbL9lo4L9NtogWde4i9MgqgD+KmzdP/VBILhp/hPdQOQD8IMwTY9mqid3vVFcqnJG2lPBN/+BbZP85bAQQJfTRcdgeV1S+Q1gLg9NDrk+pIZMND85sq+3fFNSrrDmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288108; c=relaxed/simple;
	bh=uVDf/Azs+Y2fNINbjdp5g3ddn/BJ/MorxkRf22rpgFo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c7wMgnjd1nlLMdvplr1k1nkqmGQVxyqrXspotSOa9SWanxTQlt+yPobRPxLVGrboihf3cS43ECETsLp7IOpZxPnAss7uA2oWzfPr6P5403FB2G2O9czoezeyQ+sqIQt84Axm+IJEIypIE2w3HAwj89KO6aZqRXCkCyAYP9F2Yl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tGfaEMjP; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tGfaEMjP"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-853d0d87123so98991b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 11:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788288106; x=1788892906; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T0nDJQnfFlnDLvDCZVuLzJX537jxkgQCnIHPdf7AiK4=;
        b=tGfaEMjPuDzdeYIuXqDVqbgEHDl/qAa6HamdMl6CjYdq0DFtFXA0q7E14PzIps2cqG
         wn9kSsxKcAnLVP3msnNDulTXefo5PrzBEnUPQhIP9j0TbSFVYa0gt6fkUXZDSvF2iF8p
         /58Tz2A45lnIdeJAhRo5H9Sk8J6Qq28CxzUkmth4Usr4U/MZQ2bmOvoS8Hlt/+lR99EY
         arWGyKTNDimSB17bj3eCuXy5h6hU+ZxwaMs+bbMZgIURj8ue7Sx23m/+Jz/jdivNeJml
         W3kPJ2UWu6frvWVaYy7CTzxyaPqXiF2rzSxWw4pd194YekDi5RGKogOAiN/G9u4Ueifj
         c36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788288106; x=1788892906;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T0nDJQnfFlnDLvDCZVuLzJX537jxkgQCnIHPdf7AiK4=;
        b=eqJgsTJMfPTFC8s5dzAtw+RZjF3kkTfn25NlL0kdoJbGppxcKuqI4tDroLu/lDnTOL
         ui9ql9tPbdLb5xecL7GonrN6TvO6LUhdy7tISUzDS3iDcRHrKNO63vCs6cpj5JI+VCfl
         D4mpSNND9y3QOLT8LkNKGIHdu+RFxw4YvPIWf6mm0q/biAcSsbWVbTYo0f7vUGjQpM5r
         3nxnEKjhzrkePcX+zTWhzwlz2IcTq6ywcHM1vwVva0zvzlxLglyDRZq26T6wA8XU69Dd
         EKznXVf5BXLHdA8mKsl7LD326bcqQjoVEz4WlEG5GXJHL5+rs/48EtNJOVO4l1TDHS86
         YytQ==
X-Forwarded-Encrypted: i=1; AHgh+RotGw79xluhnqwH/QmvciiQNaCkEGpqYlYV1eARx9BvW3k6UZBu7YdX0dfHJJ+YCmxylrp9pus1bthnEens2L0t0bY=@vger.kernel.org
X-Gm-Message-State: AFuF++k8njFhatFhFpjkdsg0EjhhrXt9laNRksK91KCgLKBTLwNKYUOx
	e6IEshB1ATMgC0i3YyYfgm1c4/+w+Qnp+yeMy7brxwVuf+Q3ll3Ut3PbfrTmGG6jgMro3SYrIcb
	+B7p1CQ==
X-Received: from pfcy6.prod.google.com ([2002:a05:6a00:93c6:b0:848:49f6:6f5c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8016:b0:857:4dea:e20e
 with SMTP id d2e1a72fcca58-85b5693e833mr15207248b3a.0.1788288105188; Tue, 01
 Sep 2026 11:41:45 -0700 (PDT)
Date: Tue, 1 Sep 2026 11:41:44 -0700
In-Reply-To: <apca475JqemLUjlb@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com>
 <20260830-gmem-inplace-conversion-v12-15-85e5fd25252a@google.com>
 <CA+EHjTzJbC=ZvB3Mopw-TLf=13-iqxGw5RfTp6Gt5S1hi8WRRA@mail.gmail.com> <apca475JqemLUjlb@google.com>
Message-ID: <apccaNCJ2lH5mbaY@google.com>
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

On Tue, Sep 01, 2026, Sean Christopherson wrote:
> On Tue, Sep 01, 2026, Fuad Tabba wrote:
> > > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > > index 803c7cdbbe0f6..fe02c47c85fb5 100644
> > > --- a/virt/kvm/guest_memfd.c
> > > +++ b/virt/kvm/guest_memfd.c
> > > @@ -538,8 +538,46 @@ static int kvm_gmem_mas_preallocate(struct ma_state *mas, u64 attributes,
> > >         return mas_preallocate(mas, xa_mk_value(attributes), GFP_KERNEL);
> > >  }
> > >
> > > +static bool kvm_gmem_has_outstanding_references(struct inode *inode,
> > > +                                               pgoff_t start, size_t nr_pages,
> > > +                                               pgoff_t *err_index)
> > > +{
> > > +       struct address_space *mapping = inode->i_mapping;
> > > +       pgoff_t last = start + nr_pages - 1;
> > > +       bool has_outstanding = false;
> > > +       struct folio_batch fbatch;
> > > +       pgoff_t next;
> > > +       int i;
> > > +
> > > +       folio_batch_init(&fbatch);
> > > +
> > > +       next = start;
> > > +       while (has_outstanding && filemap_get_folios(mapping, &next, last, &fbatch)) {
> > 
> > has_outstanding starts as false, so the loop never runs and the function
> > always returns false. The outstanding-reference check is dead at this
> > patch, so a to-private conversion would not be rejected even when a page
> > still has an outstanding reference.
> > 
> > It's fixed later in "KVM: guest_memfd: Handle lru_add fbatch refcounts
> > during conversion safety check", which changes the condition to
> > !has_outstanding. I think that fix belongs in this patch, so the check
> > works when it is introduced and the series bisects cleanly.

Wait, why are there even separate patches for this?  For all intents and purposes,
"Ensure pages are not in use before conversion" introduces a bug and then the bug
is fixed by "Handle lru_add fbatch refcounts during conversion safety check".
Just don't introduce the bug.

I also recommend splitting the export of lru_cache_drain_for_folio() to its own
patch so that it can be more easily Acked by mm/ folks.  If we want to squash it
with the KVM change, then that's trivial to do when applying.

> Why even bother with has_outstanding?  Avoiding it requires copy+pasting
> folio_batch_release(), but it's less code and IMO the end result is a lot easier
> to follow:
> 
> 	struct address_space *mapping = inode->i_mapping;
> 	pgoff_t last = start + nr_pages - 1;
> 	struct folio_batch fbatch;
> 	pgoff_t next;
> 	int i;
> 
> 	folio_batch_init(&fbatch);
> 
> 	next = start;
> 	while (filemap_get_folios(mapping, &next, last, &fbatch)) {
> 		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> 			struct folio *folio = fbatch.folios[i];
> 
> 			/*
> 			 * Outstanding references are anything other than those
> 			 * from the page cache, plus 1 temporary reference held
> 			 * by filemap_get_folios() in the folio batch.
> 			 */
> 			if (folio_ref_count(folio) != folio_nr_pages(folio) + 1) {
> 				*err_index = max(start, folio->index);
> 				folio_batch_release(&fbatch);
> 				return true;
> 			}
> 		}
> 
> 		folio_batch_release(&fbatch);
> 		cond_resched();
> 	}
> 
> 	return false;
> 
> and then we end up with:
> 
> 	enum lru_cache_drained drained = LRU_CACHE_NOT_DRAINED;
> 	struct address_space *mapping = inode->i_mapping;
> 	pgoff_t last = start + nr_pages - 1;
> 	struct folio_batch fbatch;
> 	pgoff_t next;
> 	int i;
> 
> 	folio_batch_init(&fbatch);
> 
> 	next = start;
> 	while (filemap_get_folios(mapping, &next, last, &fbatch)) {
> 		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> 			struct folio *folio = fbatch.folios[i];
> 
> 			if (__folio_has_outstanding_references(folio, &drained)) {
> 				*err_index = max(start, folio->index);
> 				folio_batch_release(&fbatch);
> 				return true;
> 			}
> 		}
> 
> 		folio_batch_release(&fbatch);
> 		cond_resched();
> 	}
> 
> 	return false;
