Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36AC3A4F26
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772146160; cv=none; b=LKYuN23KJfOrK9sWu+IrXIMi9OL5ZBw1MV9EkP4GAuhTu48gKcLcW+oWzIjKIxWUYbck9lr3l9uQvC7rNCkZkNfU53P/jYz42LiFo/EAeUzEpj++z8Ge/JhpJXFLz5+nswIgR/jeGviv/SFEsE0qrIf8VY4o/VebVkvilPsvi+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772146160; c=relaxed/simple;
	bh=9XJprUJHH+fYbJ7JRjThngQYjlckG3iYgJf41aqrPaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLAYffIjxfmDQ6Oj2kcWwrSrHfboWWcmkhTEjKwWGw06qxkTftrb0jUlsvYbhOaMyO+PvVifYzKVDKjTmXlfH2qOfTYH+7+afYCjFp+aAbezcVANnBRzKyIlLtz5/geJBG1rP7F2ePo2Lcy/G6+ESPypNzaxyrtu8KhpE89mIbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=D2J2ejrd; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="D2J2ejrd"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506a6cf8242so10497731cf.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 14:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772146158; x=1772750958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oYDaj+HYxxwd2SoII0inXN8E5ab2WhHpXFva2vqM1nA=;
        b=D2J2ejrdhnArACxLg9uAeQ9+NW5S58YpyCDQaZzSokmaJcfCXRGYy436PIK29mgmtu
         cx4dA240xqdH99Lqtyty1l/UHS+QiMTCJ5lBHUFmehAIddTtEAESjsz1AA1FovL8m8Ha
         Yp0QUrFqZp/kzwVMJ3ihV5z37VwNSmpv83VYfN8XfU+OzVz7dUk+xTkEFkLxmQcOogMB
         +8pQ4g6zOtVqZUnsIXZ+DvndxzGO3sSgEe2z/JUQ4GLOESFfCF5YFAHKNzpcK6wbEWx0
         QXILWTf/u2qZQirY+fTysy5oe3z7emyye3x8fU5gSeNEvCBGImKazCPHekFy/ga5/uRE
         8rNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772146158; x=1772750958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYDaj+HYxxwd2SoII0inXN8E5ab2WhHpXFva2vqM1nA=;
        b=Aj2dmsZWmsTxGlbuPnEUC0epWO8BWumHZ5lTa6f73E5KPVr1tNMkS7n+pJbXlLPILO
         F52JChBy3Lz5MuvRNJKUa5dt2fN4itA7RSZN3aKn/AyayumDDVEnZXIAMw0oqOgLoOjf
         mdavddKqPNU8bTz/YY+EtccX8EbeNXJ1LYa7E3eTex3D7G5weCI6gw8jm6KxOzFLzIvI
         2CJ+3G1Mxl4pha2/ba5bc6NBZBQqIDqBs5+OrzWSXY30LNFItIQ08RtN9SX+PCKMCGJ9
         xapAK1gfFPwjWaUD0O+obK6SywTRUwPnRJO4f5DY6sq+guFMgPvACOuYPUmBGpsTpIDW
         PORQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFFVz7LSRKC7gWn6uaOXv5A/0yBX+aK5w5qZFHFep/LQRMFZbUz5tek+xpzzJQE6LEyyRJZJ17K5jncVTTxcn0zLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwivzmAtYF3WC3Gv1HFuyul+HSwcGX0QF9U/HCGxGcB3gWJ+vbF
	kFfgrhuRjlVpqQABebUDwZIe+y288qLie01+pVzNe87BXxezLa3aPBTPy9PdiduRQQY=
X-Gm-Gg: ATEYQzx/fc31vI0U2zCqiuDbeyYALRfbb5I18VxnUdKs9mta1o4004wQL/oqcG8KJwz
	NpxFFCUw5rNsVA9swr2YU88T/Krq7Mcvt2hYZrSzrYlVmdl36i84xkH9RLAnv8p15dyI4ZfOZ2J
	lzEJRaKIQ0FXcI6kf+FWPqpKYYGMtoHlVW3zr2+kWdkLXvDJ8UNkjqlxJyoKLCY2ji960XNKoz1
	qXQZUHe1Wv87G6/eoNOnyvikUW6qprL0IHpOBGnw2b+pp0VrxievgdzXUxAcrVjP0lWB0d8ISl4
	0szdZkNdDhK/4yDs4dBHblZYvS2ID7tvXAdlIBm3chOf6j8ecoTL8c9N+c6XgOW+wGQwutMdzgY
	9VRGy+OGcZM0jZcqmweIct/jq5gcNigZ8O5ZSBw7bmHwTQZzKq2qTUT9RZWdHTUhlemwasmBZ/c
	18+GpPYWmpsx+owcBUcClnxKBPvG1n7fKpND+CCAtuKx5lVOr0Q0wRuTOZxxfS+W/y7acqpvhMY
	oVKF4MKzg==
X-Received: by 2002:a05:622a:1984:b0:502:a100:4054 with SMTP id d75a77b69052e-507528c1f89mr8534231cf.23.1772146157581;
        Thu, 26 Feb 2026 14:49:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7159b72sm29449326d6.7.2026.02.26.14.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 14:49:17 -0800 (PST)
Date: Thu, 26 Feb 2026 17:49:14 -0500
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
Message-ID: <aaDN6ocubzGUz6zc@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <fzy6f6dpv3oq3ksr2mkst7pz3daeb3buhuvdvcw4633pcl7h6u@mxjgiwpg5acv>
 <aZ3BEn_73Rk8Fn7L@gourry-fedora-PF4VCD3F>
 <a6izpi2wlqro72erhbvxhlx2lwdnae7my3ghfs6t33ivtixo4h@bi2u4x6qv7ul>
 <aZ_gALm7aE3d4IcP@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ_gALm7aE3d4IcP@gourry-fedora-PF4VCD3F>

On Thu, Feb 26, 2026 at 12:54:08AM -0500, Gregory Price wrote:
> On Thu, Feb 26, 2026 at 02:27:24PM +1100, Alistair Popple wrote:
> 
> > > If NUMA is the interface we want, then NODE_DATA is the right direction
> > > regardless of struct page's future or what zone it lives in.
> > > 
> > > There's no reason to keep per-page pgmap w/ device-to-node mappings.
> > 
> > In reality I suspect that's already the case today. I'm not sure we need
> > per-page pgmap.
> >
> 
> Probably, and maybe there's a good argument for stealing 80-90% of the
> common surface here, shunting ZONE_DEVICE to use this instead of pgmap
> before we go all the way to private nodes.
> 

Out of curiosity i went digging through existing users, and it seems
like the average driver has 1-8 discrete pgmaps, with Nouveau being an
outliar that does ad-hoc registering in 256MB chunks, with the relevant
annoyance being the percpu_ref it uses to track lifetime of the pgmap,
and the fact that they can be non-contiguous.

tl;dr here:  a 1-to-1 mapping of node-to-pgmap isn't realistic for most
existing ZONE_DEVICE users, meaning a 1-op lookup (page->pgmap) turns
into a multi-op pointer chase on and range comparison.

Not sure that turns out well for anyone (only on ZONE_DEVICE / managed
node users, all traditional nodes still have a simple pgdat or page->flag
lookup to check membership).

There's an argument for trying to do this just for the sake of getting
pgmap out of struct page/folio, but this only deals with the problem on
NUMA systems.

For non-numa systems the pgmap still probably ends up in folio_ext
(assuming we get there), but even that might not be sufficient get LRU
back.  Might need Willy's opinion here.

~Gregory


