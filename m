Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D8C3E4C73
	for <linux-trace-kernel@vger.kernel.org>; Tue,  5 May 2026 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967160; cv=none; b=Io61DRI40l5ueLOfrPyi2UqN63kjcuqXqkiOmUTr2K6lGZmD02LJLClggfgyiwG6vHA+7ILXfw8mUUQKC1mRz/okUXKMcNtGH9tCyYYU1Urce3zP+VhW0ZGXLstJITYB+pwD3fRGXhlrKeIAJWszwTVSGmuGAl9x2KWUjXzlBqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967160; c=relaxed/simple;
	bh=nHnlIoIYgby//JTQJ23HCL1ahPlq53pZkc5FnZs96GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Apd9YtvaOI/zPITs7c0YFCRK6WJfL9mLnQOaTY6tjGMLSPx8oNurXdf1ZG3lwgwsurOxzo+LPAm2dBQmIEi4u0mGcK8jKc/VwbU8by7UUJ0qzH6gPgB1AN/PrHXtfq3Rffi+1R5Jr8JZsQ63DCByMlhTTru9lzEHZfxIgnIZYpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=RCxXV9LX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="RCxXV9LX"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44c350a5b87so1335178f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 05 May 2026 00:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1777967152; x=1778571952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pZn9gNDq1rFBKVWAUdRINblw7hBlw9EDaJdQ6N5Sg9E=;
        b=RCxXV9LXriGz7JRe2657MNsE9158pU5CsAEXPaH9YbbRZ/cfEQ97T8nzjxqQjQr5Tn
         cDofYN/4NWz7D6fQ0XyKzFFVvPjtjBQlZHA3QbOgUBs8QtP4K+9gf8/fsKCBnqxH/TK1
         X4iWCPRpvJFKG+JvKL9st/yXEg+fRWRqnYMnJfGqCpTSaO/ibNLdZvUcr1bkSbuQZ/RT
         XYonchiGOgElt7+ZCAfg5bUasPzSmjsXzu+ZyL8JwvG44CpBF5GENiDxbTsee6+s0d9g
         jADSjFrbF2OEvx3nBUEynYfZo0W1FQcf3mu4y0whLlt21Yk+xCcDIIosGizPIqBT7eUF
         77FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967152; x=1778571952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZn9gNDq1rFBKVWAUdRINblw7hBlw9EDaJdQ6N5Sg9E=;
        b=FgOCsHYzr1heK9MGbUjAWgivklFyswcgOdTreUC0CMMV3axUpT6xxn3f5GnLGfuXv8
         gBPB3X0ghswnOfZPIc4dggo1BRcu4YaN9HAg9zbr/8UR7SqLdEqFjh6dddn3z28KyhyE
         0Q8EVSAuyyh3evavL7SGE5AMH9l2OVQUgDCL89rNkLWH3/U5kgxppitTasy2QlgXkks0
         T2TyP5vMP/cukvIvXvcPmtEofpjvIMogwQR9Mgnm0uoWGuclFcgcOpa3tI71yliZZvdn
         oCFKKRCMcKlmdzVes1HJ06n6B8QETZ9z3QypVQKDZC4t62dEPUUKG+DM88gMIbJAtmFU
         oSPg==
X-Forwarded-Encrypted: i=1; AFNElJ+oeger2ZjqZzaPZ/gfwnNKcY/P+Ooq+7GB3NA4QgHgEn2gacK3zqG/D9M/x4x93bFPOqLT9qjezMR6RchzEk1oipA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCUilWoLpkR/+bG7W+3Nf0ViMQ/+X2SHyeyDxKqJyL4ylNnVZI
	qv5SQ18DUSaBb2QI3r5MzhDTEBOg/MjQWf2jG9Zbjeh3NFQNQt9XfOWA+LxelNvOPBQ=
X-Gm-Gg: AeBDiescYCZP0g9bQvUC91gy0V0sxbD8bltre3kUVX9gWL9+eLqjpcs+xSeoZ8Kw2/b
	tXYVkakjSnFQGTh17mDBV9ctHAaFgmJoxdqF+R7Czn+q3MrAmdpcME0/56OEMqFnJTqpEeZKFCB
	7uB9keDeJYp8hcPQwPswD1uXOOTB7SVuijl0x1U65QplDdg8h9H+YubzDkp3sYwyCh1Wmtel9Jn
	gKG+bfA/kVkqLxuLAUftrv8XQqQOJRJ+ICyERiBrSHFvpz/qjCNsTh77Uvwmvp7SxtICta8fTWM
	Gu0dS67kfbMlp1XBv/eMSzetbXgThV/yx+ltlySruQ+fOuG1EcLISPDI5dDSob4lJsb24fS8HBp
	r2BEy2zL2QAPwnjpKqlAZdFBqCibkfLorZuDESB2qkRVJxAykNR78MskUAP8zMIJjXqeEJHspS8
	fqUN/raGzuXGxCbzvFzRTFTX2hBF61gKGu6C/lCXvNyxXI
X-Received: by 2002:a5d:5d87:0:b0:44a:2f78:e873 with SMTP id ffacd0b85a97d-450041b08d5mr3594275f8f.17.1777967152279;
        Tue, 05 May 2026 00:45:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055d36dacsm2455028f8f.32.2026.05.05.00.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:45:51 -0700 (PDT)
Date: Tue, 5 May 2026 08:45:41 +0100
From: Gregory Price <gourry@gourry.net>
To: Arun George/Arun George <arun.george@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, longman@redhat.com,
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
Message-ID: <afmgJcFUjQLYxkb5@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <CGME20260427123800epcas5p1e1a2fed257091b31e2e6c3a7d1b0c2b0@epcas5p1.samsung.com>
 <1983025922.01777297382206.JavaMail.epsvc@epcpadp2new>
 <ae_i9IlIndumJWN3@gourry-fedora-PF4VCD3F>
 <1891546521.01777455002601.JavaMail.epsvc@epcpadp1new>
 <afIKxG5mJZE6QgpR@gourry-fedora-PF4VCD3F>
 <1891546521.01777901881625.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1891546521.01777901881625.JavaMail.epsvc@epcpadp2new>

On Mon, May 04, 2026 at 06:38:54PM +0530, Arun George/Arun George wrote:
> On 29-04-2026 07:12 pm, Gregory Price wrote:
> 
> But I see this 'write budget' (budget in terms of number of write 
> operations that can be handled by the device, not capacity) to be 
> provided by the device in control plane; not by the workloads in the host.
> 

In the scenario i'm talking about, a "write budget" is defined as a
number of pages that are allows to be mapped writable in the page
tables at any given time.

>   1) We can modulate the write budget depending on the actual 
> compressibility in the device (and so workloads data). We don't have to 
> do estimation based on the workloads.
>

Barring the device causing backpressure to increase latency and slow
down writes, modulating a write budget doesn't actually do anything
useful.   Once a page is mapped writable - the CPU is free to write to
that page uncontended.

I think a write budget is "doable" but maybe a bit optimistic for an
MVP.  There are many corner cases to handle, and I would prefer to see
that as an experimental optimization.

>   2) We don't have to do the capacity modulation - as in ballooning or 
> shrinker.
>

You still need capacity modulation in some way to respond to drops in
compression ratio.

~Gregory
