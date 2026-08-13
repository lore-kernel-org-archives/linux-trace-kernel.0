Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD57248F82D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636525; cv=none; b=TKsV6CYOBKkwm+V0KhHDiGdXr9kB4veXrQ6GY3F0tXbgNJhz2vJfOoke7XswfWD5SxpvKpWqHqh7Wx6IvqA975BIPXjl7OPi07EJ7krMTa8bzSVwFzinPpvVOHYWRR/0l8nov97rs0z/HdvHKBQoXa+5uW2KpU3yOtg5WLlopI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636525; c=relaxed/simple;
	bh=KjvD0FYtibQe8DPB7+KaUJitoRzCPmTVRI1ZUYReScM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I2ttFcnmXVDYkXi0L5Cf1JurwNfHcwd1Xlr40fFj3edQhwEb+YvV/FqsZ7zsh6Gvyr08UyZtQGTS2LVfqLVXvZiGfZTCcRG+8N9u9sLnFsJwyT/46QwzDJIq6zR7HlvdEU7YN7e0DIqmViYepmBk/YdrEnm6Pf1DzoXlQv031IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HcNZfx6v; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HcNZfx6v"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so1614440a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786636515; x=1787241315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NWd+efJbNRhMQi4tFuFF6oho5IzekPVE1UiVHSpD6zk=;
        b=HcNZfx6vLVC9BEDC8pXA2hcsv1hw1DlxI8tikd0v/Vo9/mx/VfXMUd77bFcBKP9q+m
         dfHxlzZ6qZ2Nck2sQdH4hN+EwNi3vHEUVF4XsK9AEDm9hlSToITJ56mHWxhopD39isb+
         RawwSZUj7w65cysAh7SIYq+F2CSM9zJqI97fIchtzcIpG9ezxz9PDQ4Ta266yFHlU3Tg
         JVetymie04n7vw2meuI/o9dyatD/0p0LHk9FMUi4RN8eLF5rsdLyvncUg3xuxqJK1V7I
         ecuUQ1PGX5WvTDb3Y7wFXusJ/cJYPgf0CHQmqBF6xDq5r27hlL9DEgnfeGudigfVR9mH
         SmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786636515; x=1787241315;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NWd+efJbNRhMQi4tFuFF6oho5IzekPVE1UiVHSpD6zk=;
        b=aGWZwViuCqDFrZX5qTi5DaGIjFq532IL5A797stLZU2IRAxzGyc5jUko1ujqiLNw7H
         ZJcpu99CDPuCqRY6FyoqWJ5jjjhSHQ96DQOx3hTEV4Mqs0qBC68t5G0ruM9LrvbfbdVU
         ojfPUpf9ODYu38iVFxszRQ9nUfjUKrlpN8Rxiz3kQJigY+1bmL3LAKlmHrK5m+kAMlOn
         VvuiAPPfkHyzS6Sjd4eqz0/5E+DHzNPNvNmYarGGRuDSI3dYt6aNehVEUD02HJy/YY8p
         WE0q2DIhYa8zfLgDW2DfPyyS7MZkMzDRIagpPyToxWNkZtW9WYAp1p3tnhkJjK13tQq6
         hpZQ==
X-Forwarded-Encrypted: i=1; AHgh+RoGt1V27iSe/n3ZYnjCiGKbPvBL2n2sVm/e9YVN/UQi3Wr9ErOeSHo+LVUhMYfubnb553Fm7u3S1q8W9AakQBSUbiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwLYP+3r6SesNDoMDAjEXzb4sAK+RYAkWVrvpliNkEK71YXL7t
	bgjJWh1QVqNzx7CGNNgpLrF2Xf/IlphcoIplnFQk5rDi+iyWFQgLc/d9hV73kNY9MjG4RBrYEsy
	x9aKLHg==
X-Received: from pjbmr22.prod.google.com ([2002:a17:90b:2396:b0:381:1d7f:b8db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a8d:b0:36a:8240:2477
 with SMTP id 98e67ed59e1d1-3931e31a6f4mr7349226a91.19.1786636514937; Thu, 13
 Aug 2026 08:55:14 -0700 (PDT)
Date: Thu, 13 Aug 2026 08:55:14 -0700
In-Reply-To: <1ec08cd8-3072-4753-ad5e-cd34956647f8@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-12-2fc18ee6d3ba@google.com> <1ec08cd8-3072-4753-ad5e-cd34956647f8@linux.intel.com>
Message-ID: <an3o4h-E8mj6CUaM@google.com>
Subject: Re: [PATCH v10 12/41] KVM: guest_memfd: Call arch make_shared
 callback for to-shared conversion
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Fuad Tabba <fuad.tabba@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026, Binbin Wu wrote:
> On 8/8/2026 5:52 AM, Ackerley Tng via B4 Relay wrote:
> > +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> > +static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, p=
goff_t end)
> > +{
> > +	struct folio_batch fbatch;
> > +	pgoff_t next =3D start;
> > +	int i;
> > +
> > +	folio_batch_init(&fbatch);
> > +	while (filemap_get_folios(inode->i_mapping, &next, end - 1, &fbatch))=
 {
> > +		for (i =3D 0; i < folio_batch_count(&fbatch); ++i) {
> > +			struct folio *folio =3D fbatch.folios[i];
> > +			pgoff_t start_index, end_index;
> > +			kvm_pfn_t start_pfn;
> > +			kvm_pfn_t nr_pages;
> > +
> > +			start_index =3D max(start, folio->index);
> > +			end_index =3D min(end, folio_next_index(folio));
> > +			/*
> > +			 * end_index is either in folio or points to
> > +			 * the first page of the next folio. Hence,
> > +			 * all pages in range [start_index, end_index)
> > +			 * are contiguous.
> > +			 */
> > +			start_pfn =3D folio_file_pfn(folio, start_index);
> > +			nr_pages =3D end_index - start_index;
> > +
> > +			kvm_arch_gmem_make_shared(start_pfn, nr_pages);
> > +		}
> > +
> > +		folio_batch_release(&fbatch);
> > +		cond_resched();
> > +	}
> > +}
> > +#else
> > +static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, p=
goff_t end) {}
> > +#endif
> > +
> >  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t star=
t,
> >  				     size_t nr_pages, uint64_t attrs,
> >  				     pgoff_t *err_index)
> > @@ -599,7 +636,12 @@ static int __kvm_gmem_set_attributes(struct inode =
*inode, pgoff_t start,
> > =20
> >  	filter =3D to_private ? KVM_FILTER_SHARED : KVM_FILTER_PRIVATE;
> >  	kvm_gmem_invalidate_start(inode, start, end, filter);
> > +
> > +	if (!to_private)
> > +		kvm_gmem_make_shared(inode, start, end);
>=20
> If both KVM_AMD_SEV and KVM_INTEL_TDX are enabled, HAVE_KVM_ARCH_GMEM_CON=
VERT
> will be enabled and the logic in kvm_gmem_make_shared() introduces unnece=
ssary
> overhead for TDX.
> Not sure about CSPs, but in a standard distribution kernel, it's very lik=
ely
> that both are enabled, right=EF=BC=9F

Yep.

> Should kvm_gmem_make_shared() do some optimization or the overhead is rel=
ative
> small in the conversion to shared path so that the optimization is not wo=
rth it?

I assume it's relatively small, but it's probably a good idea to gets numbe=
rs so
that we can make a semi-informed decision.  E.g. if processing 1GiB work of=
 4KiB
folios is <100 cycles, I think we generally don't care.  But if it's more l=
ike
tens of microseconds, then I think we do care enough to optimize the walkin=
g for
TDX.
