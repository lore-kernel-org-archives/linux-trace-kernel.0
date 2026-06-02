Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA431B80E
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390677; cv=none; b=OuR57EJRIxmyFBOpEvCgAfs1Y+LwolsxDc5O6fQULQcfl5IYcvHjlI77cBFH0xuGVlX+iJ+s+Je0DSUUNDNZYqvUihIZrVBAqbmvmJsXgpHQBe2Sqnw5Y6/s3gNH8vTjFW2v6mNsFVlNXTlNzCUnWA4zdTNo7Vu1Mbq8pB2qQfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390677; c=relaxed/simple;
	bh=02DEH1RNeabzh34kxStDmLoX6DGXErAolWL5BXl6jBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwoSRr615TZV38kw393DzQUyCr50r06y9Gw5x4A5C3DXgudUH/j3iEALgNvMSJ2WygkYSFDRlB7nbqJeEw6Hm+Y7WgHceWVoE+YDVVmr4yJLvjjeLj21wCryvvvyut0ancCavcB/YM53HOMpqOkII2FoKTLT5LV0nLiSORpjH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gU1ml9NI; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gU1ml9NI"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490ac10e337so10982385e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 01:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780390672; x=1780995472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/m/AOq0MzWCa7qNuImbU6Sf3NfKogr80Anbl3dKp5VQ=;
        b=gU1ml9NISOhcy+km3kg+NwiZgFqta5GJX8mUC/fZ7NINj6JHkjnsIas4HTPzOQI+J+
         t5ALTwEQfB1xKxLnG4QvfzY8jQX7A3JGGcLex91Ha1VpAe48Fmt0w7mTcDxZzHxY2sXr
         VAITYpjTuotJx7ZxDDGKc9mS7mCLj/rDUnS8IWvjcpZ+yxuLhUUdJ2zUgQ8NkFG8C57Y
         B+Ih4bQBn1G7Rkvcv0Mko3TYQV41em9n2TK4cKaaFlORSnx138FKX3RaSlSh2ciLnFk9
         TmvPGqGaiXa4RSgzOMLFsZ7KqSKp/xi16XRTXNfl26OHk4rV8G9EiGk5PTAU6+1vxsx2
         imzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780390672; x=1780995472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/m/AOq0MzWCa7qNuImbU6Sf3NfKogr80Anbl3dKp5VQ=;
        b=EH3RxEVhduQOu7Qvgu6d6LYx2Cr2vVam/BFHmLitG63XzMqM+JZT6fAnQSOS5GzCHY
         JF3H2+IYDYh+HyLOCaI4vC8yWuhE+sn2FHXFR0PcEBMFGm+BSgT4VsGE78lC0kjjD8fj
         BZJX9uQWKik5BTy1MiGfTTl9kO5OZdiLU0TUWLuQxPnJ6+m4vsd4i5BU+gUG40TkXh2L
         rGUOmPgvOLm6ee2b7Kfol4hmnjSssuk7OW9YnAwcuPciluIEgAy9+bY1JPoWPoPFT1kX
         pn9rx9ve3BXXFXuO/kO1DioSWfEPpxM675YnoXQjk6Lvbqnr9si/F0vx0VOJ4+Ft//5R
         5DLw==
X-Forwarded-Encrypted: i=1; AFNElJ8UtKObMYSc2n9S++ZbT6rTiPGLE94/MkhBitR3IKWVwxo1ANs0GnM0OqRqacIZ+7PG1qkbzU1NiakL6/L5kcHJ8E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAq+bUN8joyQNE7HnRNkGaUfIvuD+VYMCtJA+peHOD/TYMVz1x
	b4PmQq1Mhpp/Bh+NlJII89G9mqDGwkBqqD6+Duwj1MYLOjeWJIVjJQIj+9iTsjK+qkM=
X-Gm-Gg: Acq92OEj+Jjyw0WcnI5hTRWZCEwzm4WqBU8YEJ67KQwreSwPA3mdmVdrdPX6Sn01APe
	zHerhsaScc9BrARUhfItx1DKFJOkhIA+Pju8Bzt8kN36tUe02Ca6Wdzqvh1CgeCxoIEbxFgeMCc
	v0lP7SKx2hq+RoRxen9rCAvi3aIwdMSbLDX1afvtp/XHaE/g4ajkP7Zv5Fb5i/wcWzqswHD3qZz
	KeBz2nIzwEzF55tkyjk3YegVyMxBNHUqu25HQUrD+SAIXZ15AewpF3FUnYcp7D4Hj8Jn89eRoyM
	JPOwSzjN7+VdUIks9lzQpgd1xDZWK9Cpn2SNV69YYFHSRXqfCTMaK8Hp2PiRjiTAfjLQ4iIbB/l
	il6W9CmtSEGtCP2GWrW0GwxPn7srjX7KKIGPxaUw0KxOKf+C/QmJv7zQjMy5gS5RZ/iOArxdOjY
	nMk4jvSE/x7Fgzlx0w7cW9NxQDs5U4+kEIpd/aVodxVQ==
X-Received: by 2002:a05:600c:a009:b0:490:ad8e:11bc with SMTP id 5b1f17b1804b1-490ad8e1279mr109459155e9.31.1780390672385;
        Tue, 02 Jun 2026 01:57:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::6:6dc9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354c682sm30647541f8f.23.2026.06.02.01.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 01:57:51 -0700 (PDT)
Date: Tue, 2 Jun 2026 09:57:48 +0100
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
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
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
 <ah47NNhuiClgGCdn@parvat>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah47NNhuiClgGCdn@parvat>

On Tue, Jun 02, 2026 at 12:16:50PM +1000, Balbir Singh wrote:
> On Sun, May 24, 2026 at 09:50:06PM -0400, Gregory Price wrote:
> > 
> > I'm debating on whether to include OPS_MEMPOLICY in the initial version
> > if only because it's not intuitive how it interacts with pagecache. That
> > needs more time to bake.
> >
> 
> It makes sense to look at it and then decide if it makes sense.
>

I am thinking i will ship without any OPS flags at all for now and the
have the introduction of ops as a separate series.

> > alloc_pages_node() is the kernel interface
> 
> I was think we wouldn't need explicit flags and that allocations would
> happen from user space using __GFP_THISNODE to the node or via a nodemask
> based on nodes of interest. Is there a reason to add this flag, a system
> might have more than one source of N_MEMORY_PRIVATE?
> 

There's a few things to unpack here.  I discussed this many times on
list and at LSF, but to reiterate.

1) __GFP_THISNODE is insufficient to enforce isolation and otherwise
   not particularly useful.  Additionally, from userland, it's not
   something you can actually set.

   for node in possible_nodes:
       alloc_pages_node(private_node, __GFP_THISNODE)

   In fact it's the opposite semantic of what we want.
   THISNODE says: "Do not fallback back to OTHER nodes".

   The semantic we want is "Do not allow allocations from private
   nodes UNLESS we specifically request" (__GFP_PRIVATE).

   __GFP_THISNODE does not actually buy you anything here, AND it's
   worse, in the scenario where a private node makes its way into the
   preferred slot (via possible_nodes or some other nodemask), the
   allocator cannot fall back to a node it can access.

   __GFP_THISNODE cannot be overloaded to do anything useful here.

2) We're trying not to expose *ANY* userland APIs for this, at all.

   The ultimate goal here should be one of two things:

   1) fd = open(/dev/xxx, ...);
      mem = mmap(fd, ...);
      mem[0] = 0xDEADBEEF; /* Fault device page into page table */

      In this case, the driver is responsible for doing the
      alloc_pages_node() call.

   or

   2) mem = mmap(NULL, ..., ANON);
      mbind(mem, ..., private_node);
      mem[0] = 0xDEADBEEF; /* Fault device page into page table */

      in this case mempolicy.c is responsible for doing the
      alloc_pages_node() call via the _mpol() alloc variants.

Addition OPT flags (reclaim, compaction, whatever), would
(optionally) allow mm/ to operate on the device memory with, for
example, mmu_notifier callbacks to tell the device to invalidate
whatever it's caching about that page.

This would all be relatively transparent the userland, all userland
"knows" is that it's getting memory from a device (/dev/xxx) or a
node it's otherwise aware of hosting device memory somehow.

~Gregory
