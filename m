Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41497274FDF
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 01:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787189567; cv=none; b=rYpKwD5i8FNgwP2wDVfEJoK8AMMe5cHYWa4559wLOktqThL61qVnMTK5/NTEYDzliS2UJypUzNRQl6d/NT04ebH1wG4XRPzeZ1Dyq/6WjGJxA0KO8SCAdJYIka/PXsgjYjC6fQ1LP3Z1G0Gya/bQVzMfyiKHILjkCz2iP6Lqqro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787189567; c=relaxed/simple;
	bh=lKjf4Q4UMlUt5C3CIEUOsn+abatNb3k1w/wRQQtVAQY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qaSnypmYy+0svrqJIxchWoA2A/Rqmg7vPbJgpY7FD2pxZs+fFvcbkzeSlQfz+DULjxMN8Xil12QF+rKmTbURrmvOgNp3jWpU2xbttxmTltqA8u/DsUEuEJhPI0ckrAI2fW5VFWEh8NxUXahEnB1BozW6VGzTjAQ8DERhKpEe1wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v34TVm5H; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v34TVm5H"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cea6a46766so25245955ad.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 18:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787189555; x=1787794355; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PQeRam/aXC557IkHfkSAK7ZCCBwHdULqaqUlyhncFbY=;
        b=v34TVm5HF0Jku7xlwiw5Fgkt+MayOXPP8rvKzItaMGSQpKc+fAywrQiq1SHjlSkJ8p
         r63Y43pXAJ3L3W4uLHbJj4+m6OZTraR65hCtr+kB6NR/i7gVfYp88+fDKU0MQ52yPXNY
         2PUKFNgOgR+6pIks8d3oODCB0+cew/l0p2ECDbU76zW0b0FuR9Xj5cnfJkTI7uTb9QCT
         /0SOVyEh9MyonAt4dlmuxtBrV3dcPRgK0h+DJq1wGvuGwZ/K6RJTVzJCPLh9qUQP5ESv
         denMDT8rBl2zX7SKEYm9aFcIyWj2h7ne+EWIK8GOsL3DeCvPcIh3f+tn7slHT3UdDsCa
         GCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787189555; x=1787794355;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PQeRam/aXC557IkHfkSAK7ZCCBwHdULqaqUlyhncFbY=;
        b=NcHtJYogNymBTXr7c+hn9O1s7NF2irLDbl11DgUweyVWI9V9jhTQrxlfSMO3zAaK93
         KjkYGXb9FefeppbA0bVWZzd/NXxXv2mzZW7vHq7nZN7E2uzCI+TXw11AqWpoAmHK6E6g
         J4TdL3u5pmcfw5FHnxtAnrcwoMl+IMIGf7HFc0KI1yrQpy/jnuctKrLDZly1ODb1P3b9
         4DUCSeMAtDAgkMKl38PLu5zxvQGgTK5uWix8l8g1+Rm4Aoljj9kApUQEgu7iTVRbgcN8
         pa9lZRJ12GFa8sKcUChdS+RVsnSBeXSkNO8IYbqMse4lPiabH4URy/+wGPT2B6ZnOPrK
         i7UQ==
X-Forwarded-Encrypted: i=1; AHgh+RpPkJ/16joYAJBbcoktLQK6jTLlcCSoI98re8pK4iED9ujcvnJcLkuDmt4m1bvBFarwyyzRBIModZNwE+tYF53dhbQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l7+G1XXTsAd8Hr3OJBfGF7WCt8n5l5F1SYlwHLk+GAJRIHuojm
	lPsxOqURf8dH7aexUZuhvOGV5vbZw95TNpBH5gfehBfMA8r0IgE4E5tYQBbdC2nMc8rmVhHZHPw
	dQ8Rz0A==
X-Received: from plbi9.prod.google.com ([2002:a17:903:20c9:b0:2d5:ca58:37e1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:40c9:b0:2c9:b396:1a55
 with SMTP id d9443c01a7336-2d60197c4c5mr178024025ad.12.1787189554412; Wed, 19
 Aug 2026 18:32:34 -0700 (PDT)
Date: Wed, 19 Aug 2026 18:32:33 -0700
In-Reply-To: <CAEvNRgGOyQHnF_b8dk8E0d7_=CcwXtYUdU3ko7Qbep+_O7UC0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-9-2fc18ee6d3ba@google.com>
 <13ca60c6-e154-4397-8092-09f861e90fe0@kernel.org> <cbf5f7ca-a960-4fb8-a760-2d2794eb6864@arm.com>
 <CAEvNRgGOyQHnF_b8dk8E0d7_=CcwXtYUdU3ko7Qbep+_O7UC0Q@mail.gmail.com>
Message-ID: <aoZZMQ3Uc8yQWPNA@google.com>
Subject: Re: [PATCH v10 09/41] KVM: guest_memfd: Filter both shared and
 private when invalidating
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, "David Hildenbrand (Arm)" <david@kernel.org>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 10, 2026, Ackerley Tng wrote:
> Sean, do you know if looking up attributes in gmem to feed the KVM MMU
> the smallest set of pages to zap will improve performance significantly?
> Or if there's any other reason to do this lookup (more complexity in
> gmem)?

While working through this with Ackerley, I realized this patch is buggy.  When
in-place conversion is NOT supported, then as evidenced by the current code,
invalidations are guaranteed to only affect one of SHARED vs. PRIVATE.  And if
we change that to zap both, we risk overzapping.  I.e. it's not just the cost of
the extra MMU walk, it could also be a functional bug.

Specifically, if KVM zaps both when SHARED vs. PRIVATE is tracked per-VM, then a
PUNCH_HOLE operation on a PRIVATE guest_memfd will incorrectly zap SHARED mappings
that have nothing to do with that gmem instance (because they're mapped via a VMA,
not a gmem fd).  And vice versa, a PUNCH_HOLE on a SHARED gmem (if userspace is
using an INIT_SHARED gmem for the shared branch of a memslot) could invalidate the
PRIVATE mappings (of a different gmem instance).

That latter case in particular would be a functional bug, as spuriously zapping
PRIVATE SPTEs is fatal to TDX (destroys the memory contents).

So, for the initial change, we want this (full patch below):

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 75979c885e03..8ff2ec148614 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -138,6 +138,9 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 
 static enum kvm_gfn_range_filter kvm_gmem_get_invalidate_filter(struct inode *inode)
 {
+	if (gmem_in_place_conversion)
+		return KVM_FILTER_SHARED | KVM_FILTER_PRIVATE;
+
 	if (GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED)
 		return KVM_FILTER_SHARED;
 

And then in the main in-place conversion patch, have the conversion flow to only
zap tap the "previous" types (with prep work as needed).  Ideally, that would be
done *after* the main conversion patch, i.e. as an optimization, so that we get a
nice bisection point if it's somehow buggy.  However, Ackerley pointed out that the
conversion flow invalidates the entire range if the attributes of any gfn within
the range is changing.  Addressing that would be rather annoying, e.g. there would
need to be multiple invalidation ranges to deal with interpolated conversions,
so going straight to a "zap only the previous" is probably the least awful option.

---
From: Sean Christopherson <seanjc@google.com>
Date: Wed, 19 Aug 2026 18:06:38 -0700
Subject: [PATCH] KVM: guest_memfd: Invalidate both SHARED and PRIVATE mappings
 for in-place conversions

When removing one or more folios from a guest_memfd instance, invalidate
both SHARED and PRIVATE mappings if in-place conversion is enabled, because
stating the obvious, KVM needs to ensure that all mappings to the folio(s)
are dropped.

Opportunistically rename the helper to capture that it returns the a filter
for all gfns in anticipation of zapping only the previous mapping types on
conversion.  I.e. when doing in-place conversion to PRIVATE, only SHARED
mappings need to be zapped (ignoring that KVM would ideally not invalidate
ranges whose attributes aren't changing in the first place).

Note, precisely zapping only the possible mapping types when in-place
conversion is disabled is important for functional correctness, not just
for performance.  Specifically, if KVM zaps both when SHARED vs. PRIVATE is
tracked per-VM, then a PUNCH_HOLE operation on a PRIVATE guest_memfd will
incorrectly zap SHARED mappings that have nothing to do with that gmem
instance (because they're mapped via a VMA, not a gmem fd).  And vice versa,
a PUNCH_HOLE on a SHARED gmem (if userspace is using an INIT_SHARED gmem
for the shared branch of a memslot) could invalidate the PRIVATE mappings
of a different gmem instance.  The latter case in particular would be a
functional bug, as spuriously zapping PRIVATE SPTEs is fatal to TDX, as
doing so destroys the contents of the memory.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_memfd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 75979c885e03..7ae05ce3cd14 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -136,8 +136,11 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 	return folio;
 }
 
-static enum kvm_gfn_range_filter kvm_gmem_get_invalidate_filter(struct inode *inode)
+static enum kvm_gfn_range_filter kvm_gmem_get_all_gfns_filter(struct inode *inode)
 {
+	if (gmem_in_place_conversion)
+		return KVM_FILTER_SHARED | KVM_FILTER_PRIVATE;
+
 	if (GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED)
 		return KVM_FILTER_SHARED;
 
@@ -188,11 +191,9 @@ static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
 static void kvm_gmem_invalidate_start(struct inode *inode, pgoff_t start,
 				      pgoff_t end)
 {
-	enum kvm_gfn_range_filter attr_filter;
+	enum kvm_gfn_range_filter attr_filter  = kvm_gmem_get_all_gfns_filter(inode);
 	struct gmem_file *f;
 
-	attr_filter = kvm_gmem_get_invalidate_filter(inode);
-
 	kvm_gmem_for_each_file(f, inode)
 		__kvm_gmem_invalidate_start(f, start, end, attr_filter);
 }
@@ -344,7 +345,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
 	 * memory, as its lifetime is associated with the inode, not the file.
 	 */
 	__kvm_gmem_invalidate_start(f, 0, -1ul,
-				    kvm_gmem_get_invalidate_filter(inode));
+				    kvm_gmem_get_all_gfns_filter(inode));
 	__kvm_gmem_invalidate_end(f, 0, -1ul);
 
 	list_del(&f->entry);

base-commit: 620f8362aaec3848ee8f465949a0701175fe0896
--
