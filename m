Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F9401A29
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470166; cv=none; b=R+gOBTGWcJRtCogNDJH/Bfh6AW+r4dHlXQBuWiVDGyZQFfad4Zjpxriw0RPptIpdjuDAjd5phCevGaygLcnR7a7+7hIhx6hsQwQ6BbRiUbBD4XFIt0B8i48+VY0yiLeWs1tsWJj0LtX8t80vggbByyrAFC179z4/diefC9TrJJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470166; c=relaxed/simple;
	bh=8oIl+9E5+ZYyjQyOzSkIqpOdnbcSGnOo1+PhoaP0ooI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgANGq72TE+T4ZjX8yOvbtdOCer+EAzewHSXBxGYmMVse5rXkSjdxXK6kl9FoSn9LtV/0WZHP8T55JJWpPgdX8w1Ro4CVtxm1OZSbO8QX+rWP2+pByuswO1/4dWw8YpmvyA/gRMzu+Mi0kxQfdnUi3WmoNbcAKXbl1OEt9xi05c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kl5j43ji; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kl5j43ji"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so217917905e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 06:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1777470153; x=1778074953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZN8aaKgJ1Zzt3TUYPWuZx8THycU/Bmtyi8+XL6pyqc=;
        b=kl5j43jipWlzoMiuKwgkQuv15hdLYwnEsARemamzlnZihHXd82ZyMWQjzI+PVtPlLn
         FVA2L6BidrMR+akGvPmTzkescnXF1bVWkVTvhqsivS9lx5C1aBs6y/d3yy+sAcDcSxM+
         DI1fBKpO5dw0Vhi/jKTuXylQ3Wl9uYYNf7JF2CMMcw7LIBzXnXYZ/Kw+QYFXgH+fQ5LS
         KdQM/8dYR9pyYig2r7iD2s+AJB28MYuK+f5e06Gh9DppL5yt2VCGVnjXAwZ2TX8MBpU0
         TtBfZnGBX1xytCDWRnBCTJ97yjy3hfIEyug+yYBMtbq2N21WqpHMVZ7dwVtodprdsGzW
         fmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777470153; x=1778074953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZN8aaKgJ1Zzt3TUYPWuZx8THycU/Bmtyi8+XL6pyqc=;
        b=dgf6SIgU2V4ZAwFC6w2beDVPrZoO17v+sBuw4r3frHMmipLpveG9JyLTfGtRZ2zvex
         U/0iZ/vaq+ekRgNzC724L1G1R9g5r0U4xwSgwPuBHvej6GvaTMPs9yzzcaRR2TuYDR5k
         2zuXST9/kfjooFEB2j1rEqQrovkTdWJZUbZX27AzFPjX3dnwDne3UJZ3zR85ZBPeVC63
         SflXK/oKzwyWptRH4/FiJRleGzZj/0TuTnx4+LaM7oIUuuwPObEXomUUURqFo80Hj4o1
         NQEAfcJEJCrGCSCoJzk2n+AtdvPNww3PgD9k4WvjWhQUUtJvGBNImLM6VEjkExiU97Lb
         s+lg==
X-Forwarded-Encrypted: i=1; AFNElJ8thfFjyCJkLcrsEYfxtSsIiezmnRpDFmf915YBtPAoMSueuq4fPzqCInz9ggX5KbIl9QZOkaN/OOfAEUpa445y6iU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwWeib5Rrfa2GLDvyl8BIPNEtTuq5vxB8eiMU75vw8C4tctCzl
	0rvtK2TfV6Wypw4K724qzHCfvSXjeGDuJs8pqfn1ahPOQSIt9PfZPLzjHjtztQymseQ=
X-Gm-Gg: AeBDieul25ao8AcSq/9yl1rUIAf6ZBJGcpl+KIU35DkVODVShHR4iCExPY6BfMZEgWX
	HEbpIodzthzXiiS8lNuOGbRBxoJDsHUFBdKdCZaWmY76mIL40otXKOOKUpCv8ObWNCWZbEMbjpH
	c8Ph51Q7a2KrEL8JRFpzoIFaGKhv4nCYEDe98K2NU83rUByJz/wdcYXdg0lZ4n9apHrk12O426w
	L/fRjciEzOyQsFb1JRnnCgvleTuYm3YuEuubVo/AYfAq+WBizlVXy8tvJCptJxBHjVCaz+PGaDT
	hpAQMurvPE8bOMi3ndMeVv6I3EhGVoCZymN5AB5A3mnXgoYBhbnyeGejdF4pXjS4uOgt9oBVWGF
	i6XjFsP3pR5UfnCa2EiXvspHCsC4gAlkC1b1J78STYdXZqqyLOaYIf2labvLmepn8x3M0+BrzPq
	wT5+NH2ka3uR7xj6q8FhQ62pQ9wayFuZ+6urx+ALI=
X-Received: by 2002:a05:600c:4e4b:b0:488:be58:bb5b with SMTP id 5b1f17b1804b1-48a7b547375mr70345885e9.24.1777470152259;
        Wed, 29 Apr 2026 06:42:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2a00:23c8:67a7:3101::e3b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7bc79ab4sm59981745e9.9.2026.04.29.06.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:42:31 -0700 (PDT)
Date: Wed, 29 Apr 2026 14:42:28 +0100
From: Gregory Price <gourry@gourry.net>
To: Arun George/Arun George <arun.george@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com,
	gost.dev@samsung.com, arungeorge05@gmail.com, cpgs@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <afIKxG5mJZE6QgpR@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <CGME20260427123800epcas5p1e1a2fed257091b31e2e6c3a7d1b0c2b0@epcas5p1.samsung.com>
 <1983025922.01777297382206.JavaMail.epsvc@epcpadp2new>
 <ae_i9IlIndumJWN3@gourry-fedora-PF4VCD3F>
 <1891546521.01777455002601.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1891546521.01777455002601.JavaMail.epsvc@epcpadp1new>

On Wed, Apr 29, 2026 at 11:45:26AM +0530, Arun George/Arun George wrote:
> On 28-04-2026 03:58 am, Gregory Price wrote:
> > On Mon, Apr 27, 2026 at 06:02:57PM +0530, Arun George wrote:
> >>
> >> Any particular workload you are targeting with
> >> this (which can tolerate this latency)?
> >>
> >> Any deployments you think of where the goal is a capacity expansion
> >> with a compromise in performance?
> >>
> > Primary use cases for us are any workload that benefits from zswap -
> > which is many, many (many, many [many, many]) workloads.
> > 
> A curious question please. If the primary use case is swap, can't we 
> handle this problem statement by re-using the zsmalloc allocation classes?
>

I'm using swap semantics for allocation ("demote + leafent") but otherwise
on-fault rather than removing the swap-entry, we leave it cached and
replace the page table entry with a read-only mapping (if Read-fault).

If there's a writable budget, and the node is under that budget, we may
also allow upgrading the read-only page to be writable (at which point
we would reap the swap entry).

This requires careful reverse-mapping in case there are multiple mappers
of the same folio.

Since otherwise the allocation is just alloc_pages_node(), and the fault
patterns differ from typical swap - i didn't see the need to overcomplicate
things by cramming the logic into zswap/zsmalloc instead of just making
it its own vswap[1] backend that sits in front of zswap.

vswap makes it easy to writeback a cram page to swap in the case where
the device is over-pressured and we need to make room (close the node,
disallow new cram entries, writeback existing cram entries to swap).

[1] vswap: https://lore.kernel.org/linux-mm/?t=20260320192741

> A separate size class can be reserved for non-compressed pages in 
> zsmalloc. And this interface could be used by zswap, zram etc. (We have 
> been using this implementation for testing btw.). This does not require 
> additional book-keeping or buddy allocator.
> 

The other reason not to overload an existing mechanism is because these
devices (that i've seen) cannot provide per-page compressability stats,
and so it would end up just looking like a bunch of either
uncompressible capacity or unknown compressed capacity.

That makes it harder for those components to reason about what to do
with their normal software-compressed capacity (for which they do have
that data).

> So write-control part need to handled in the specific back end driver of 
> private pages while the allocation control is a generic front-end sort 
> of, right? (Ex: zswap cram back end for compressed devices case.)


write control is handled by the OS in three ways:

   1) No file memory (no page cache)
      We get this for free using the swap semantics
      This prevents buffered i/o from bypassing page table controls

   2) User allocations only (or at least swap-eligible only)
      This prevents catestrophic system failure if the device fails

   3) Page table mapping control (disallow direct writes)
      This prevents uncontended writes to compressed memory by the cpu


allocation control is handled via private nodes - the driver which
hotplugs the private nodes hands that node to cram - and cram is now
aware of that capacity and will use __GFP_PRIVATE to allocate from that
node.   Removal of the private node from the fallback zonelist and the
lack of __GFP_PRIVATE in all other paths prevent normal buddy allocator
users from accessing that memory.

> 
> Great! I believe "writable budget" could be an interesting idea which 
> can solve the 'bus error' sort of scenarios due to device not capable of 
> taking any more writes. The write budget could be replenished using the 
> control path and writes will not go ahead without the budget available, 
> right?>
>

Write budget is simple

budget=1  (up to 1 page can be writable
   1) swap 1 page ->  cram alloc 1 page, put VSWAP_CRAM in PTE
   2) read-fault  ->  cram upgrades VSWAP_CRAM to R/O PTE
   3) write-fault ->
      a) if (writable_cnt < budget) { budget++; mkwrite(pte); }
      b) else:  normal swap semantic -> promote to normal memory

The catch with the writable budget is we may not always be able to catch
all frees of the vswap pages - meaning we get zombie pages in the vswap
tables.  But this is ok if we run a regular kthread scan the vswap entry
list to reap zombies.

This also gives us a great place to TRIM/FLUSH those pages to release
the capacity without zeroing them.


Meanwhile - use ballooning and a simple shrinker to dynamically size the
region to respond to real compression ratio.


All said an done - you get something close to zswap but with R/O
mappings for all entries, and optional R/W-mappings for administrators
who know something about their workload and can afford to take the risk
of some amount of capacity being written to uncontended in exchange for
performance.

The writable-budget is a risk-dial:  How much do you trust your workload
to now spew un/poorly-compressible memory?  The write-budget is a direct
measure of that. (so take P99.99999 compression ratios, and you can make
a good chunk of that writable).

~Gregory

