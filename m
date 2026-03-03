Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5819234C81E
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Mar 2026 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772570184; cv=none; b=eFQr9c3TVjWSEVukmlCQ9QJC6Or0i9wQnOcUJzdiDwZbomhvnj9pKdX+44eGmGJNk/z4J5+J5DlSAVxa3YihetWoH/JhUuDR8B56f1ziWUTOpRHskFLfOE9nFIAGFxPMu/+v89KQoT81AFYGuP4HOTXAkBrxOJ8c0mi1lvjxHxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772570184; c=relaxed/simple;
	bh=0WXiDpchtAH8bVqvBLab1zkx9xLMSEgnhOTNf0nXPyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADzIJaaaxTmwI1tppUEOU/VIrtHAsYGSd9TVDUS0pwSKOKriu24SIMet96rLf6ZjAq0GUTbzQy8s+6dJaBKoV5KvFaZcdaLoZERdS/kCPhuthL41WTpeMG8lf3aewNuI137lQO4dEQ/7+po6/i6wiR3U50TGBDeHUY6n1fu2rcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jPoPJmvq; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jPoPJmvq"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb38e6d164so791824585a.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Mar 2026 12:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772570182; x=1773174982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HSMo5+Ht+OJv6fxlprT7RhyGGgmGe3zydeGluTTF1Sk=;
        b=jPoPJmvq78g+dz55Aepd7ikVipZMlI0Osa0jjLmZQsj15+VwqhnnAUONGn6cG5gzTu
         in0FpfpwHh+R+csZOndc80iKq0zo1NTn9NaX+MMzho/4eQVzKPUdvRHWC5jKYBd2CfHS
         BI/fg5l1zHRzVwCUd1R5+taqm1bSHLUM6kmibt4G7VxLG1aEX6nXqIXrK2GRkx7n3d7Z
         xu80v5DghZda3D9hSaRTm7hk6ieiZpshjkd22fpYTazE9xAzYVYtMgSVe+a1WXTLJBnq
         XDzLBpxqyfwuoZkSzS1BU0dcUBNfDcgNi5IoblPgSy6WVFjPxnzwX4CmvtE1qk0xoYAj
         27fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772570182; x=1773174982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSMo5+Ht+OJv6fxlprT7RhyGGgmGe3zydeGluTTF1Sk=;
        b=NNYhZGOHc+i6BoT56XvbaLg38RyAzeskUeSmGuh5EOU/koCWBj4tgHyxPOnXXIx2rh
         vjoLdeHRE5NDSgJ0D+vtDCr0gCgMTXeySfrNKArk3NZ5aa5ev6OWp1iZ9nptev0TuHwq
         0DqfwvYCCVKQcGIq4X4OkVL8hpWGAJ3C4MbjWNEL1CJbG3laSVwEV+wjUr3T0GWxtiuA
         mn+DITQxGvVEa4EWt7k6blzJg79h8pZ1h2Pe2YYW2Sp3em8A5pRCLvoe1cJpGq3SqO8Z
         PJp64mJdS6o2y0K4eEVYqyZgpaIXa545tB+hrnI3nqFG3JOgXWN4yeY2VxjOxyby1m0r
         cM0A==
X-Forwarded-Encrypted: i=1; AJvYcCVOvyWQ6E7W7edM2sv+K+m+OCrIMkDLEYMDXQn8/dzQuO70DEkhY1zSK24WOmLwW4QkRwID5+UebE442z/YQeGhkrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHARzMs6TZBrDyTXmvfUGNeE5nK11Wtr/UCSWx52Qy5A16PQVA
	KW5coCUWsdB4GT+Y78Erd6fnH6mTQXPoJdwWpm/KG01pawHAkfPgtFuqmhTjMvMCJO0=
X-Gm-Gg: ATEYQzzwHCcWZabppFJlHNtpBZ3lyNikr2vd3417vZiXfxcqfOGwp/Ibllv2xch9bp8
	khAY2+xZ+ViFyea+0KOe4rlne+0Sk6lYOhxBTuPVtjXmJdZI1yQLfYsH2hmVEZ7dc7UjDc87QJC
	daYiGmCV9vpULaMmJD13OUQAgutSkWWmHvpF7o7I5wMZ3Rh56PK/rGhNnWRO6BoVmydzZLXlnQG
	Eb+WHIOedJ7O7HQi38ncgxNDJexxS01Q4hQ9I4knEeW8xJaElmay/vNSnAqZzhFe/vr9/dh81xE
	GK6o4ACkXSxkJnw+vTzfzpvVoWy+dl8isRTagCceEJMTF7kvQ0vPfDb+tfDlIYGXM3cnEkiq9gS
	uhyG2qDVip5NXERN95AD2jYTL7lgxwvUQZ7eSOvyp268I3Fgyd9Rgqvdq5Lq9FYQ80HOi6e0Jsw
	nTt/3yzulHopAWy+XLRdeTyTcVftIO/ocagrEjDUHSIeH9v63rZIUoqttJUsdUvitpraahMcb58
	YbVO5AaXA==
X-Received: by 2002:a05:620a:4720:b0:8cb:5442:d539 with SMTP id af79cd13be357-8cbc8dc28b1mr2313709285a.2.1772570182058;
        Tue, 03 Mar 2026 12:36:22 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899e89bf39bsm79243066d6.18.2026.03.03.12.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 12:36:20 -0800 (PST)
Date: Tue, 3 Mar 2026 15:36:17 -0500
From: Gregory Price <gourry@gourry.net>
To: Alistair Popple <apopple@nvidia.com>
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
	ying.huang@linux.alibaba.com, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, mhiramat@kernel.org,
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
Message-ID: <aadGQXXpayvFOZpy@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <fzy6f6dpv3oq3ksr2mkst7pz3daeb3buhuvdvcw4633pcl7h6u@mxjgiwpg5acv>
 <aZ3BEn_73Rk8Fn7L@gourry-fedora-PF4VCD3F>
 <a6izpi2wlqro72erhbvxhlx2lwdnae7my3ghfs6t33ivtixo4h@bi2u4x6qv7ul>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6izpi2wlqro72erhbvxhlx2lwdnae7my3ghfs6t33ivtixo4h@bi2u4x6qv7ul>

On Thu, Feb 26, 2026 at 02:27:24PM +1100, Alistair Popple wrote:
> On 2026-02-25 at 02:17 +1100, Gregory Price <gourry@gourry.net> wrote...
> > 
> > If your service only allocates movable pages - your ZONE_NORMAL is
> > effectively ZONE_MOVABLE.  
> 
> This is interesting - it sounds like the conclusion of this is ZONE_* is just a
> bad abstraction and should be replaced with something else maybe some like this?
> 
> And FWIW I'm not tied to the ZONE_DEVICE as being a good abstraction, it's just
> what we seem to have today for determing page types. It almost sounds like what
> we want is just a bunch of hooks that can be associated with a range of pages,
> and then you just get rid of ZONE_DEVICE and instead install hooks appropriate
> for each page a driver manages. I have to think more about that though, this
> is just what popped into my head when you start saying ZONE_MOVABLE could also
> disappear :-)
> 
... snip ...
> > 
> > You don't have to squint because it was deliberate :]
> 
> Nice.
> 

I've had some time to chew on this a bit more.

Adding a node-scope `struct dev_pagemap` produces some interesting
(arguably useful / valuable) effects.

The invariant would be clamping the entire node to ZONE_DEVICE
(more on this below).

So if we think about it this way - we could just view this whole thing
as another variant of ZONE_DEVICE - but without needing the memremap
infrastructure (you can use normal hotplug to achieve it).



0. pgdat->private becomes pgdat->dev_pagemap
   N_MEMORY_PRIVATE -> N_MEMORY_DEVICE ?

   As a start, do a direct conversion, and use the existing
   infrastructure.   then expand hooks as needed (and as-is reasonable)

   Some of the `struct dev_pagemap {}` fields become dead at the node
   scope, but this is a plumbing issue.

   There's already an similar split between the dev_pagemap and the ops
   structure, so it might map very cleanly.


1. "Clamping the entire node to ZONE_DEVICE"

   When we do this, the *actual* ZONE becomes completely irrelevant.
   The allocation path is entirely controlled, so you might actually end
   up freeing up the folio flags that track the zone:

   static inline enum zone_type memdesc_zonenum(memdesc_flags_t flags)
   {
        ASSERT_EXCLUSIVE_BITS(flags.f, ZONES_MASK << ZONES_PGSHIFT);
        return (flags.f >> ZONES_PGSHIFT) & ZONES_MASK;
   }

   becomes:

   folio_is_zone_device(folio) {
       return node_is_device_node(folio_nid(folio)) || 
              memdesc_is_zone_device(folio->flags);
   }

   Kind of an interesting.  You still need these flags for traditional
   ZONE_DEVICE, so you can't evict it completely, but you can start to
   see a path here.


2. One dev_pagemap per node or multiple w/ pagemap range searching

   Checking membership is always cheap: 

        node_is_device_node()

   Getting ops can be cheap if 1:1 mappings exists:

       pgdat->device_ops->callback()

   Or may be expensive if range-based matching is required:

      node_device_op(folio, ...) {
         ops = node_ops_lookup(folio); /* pfn-range binary search */
	 ops->callback(folio, ...)
      }

      pgmap already has an embedded range:

      struct dev_pagemap {
        ...
        int nr_range;
        union {
            struct range range;
            DECLARE_FLEX_ARRAY(struct range, ranges);
        };
      };

   Example: Nouveau, registers hundreds of pgmap instances that it
            uses to recover driver contexts for that specific folio.
	    
	    This would not scale well.

	    But most other drivers register between 1-8.  That might.

   That means this might actually be an effective way to evict pgmap
   from struct folio / struct page.  (Not making this a requirement or
   saying it's reasonable, just an interesting observation).


3. Some existing drivers with 1 pgmap per driver instance instantly get
   the folio->lru field back - even if they continue to use ZONE_DEVICE.

   At least 3 drivers use page->zone_device_data as a page freelist
   rather than actual per-page data.  Those drivers could just start
   using folio/page->lru instead.

   Some store actual per-page zone_device_data that would prevent this,
   but from poking around it seems like it might be feasible.

   Some use the pgmap as a container_of() argument to get driver
   context, may or may not be supportable out of the box, but it seemed
   like mild refactoring might get them back the use of folio->lru.

   None of this is required, the goal is explicitly not disrupting any
   current users of ZONE_DEVICE.


Just some additional food for thought.

As-designed now, this would only apply to NUMA systems, meaning you
can't fully evict pgmap from struct page/folio --- but you could
imagine a world where in non-numa mode we even register a separate
pglist_data specifically for device memory even w/o NUMA.

~Gregory 
