Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497CD403129
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088129; cv=none; b=KtAnQRUqda93uGtcTUNlZyxQ5k+HnMEEx2dCv4PTLXZGyhxIVe5OqkI1l3jQ1IHdX0NoZB5c/EManiysCEMGWNXWYP377WtKTqcjKQC2opSMThHZuy9N9Cy/4NPzYAiIo0PeUpbjlze8OuOcd4ROYCCcakqmkIGTtl2Pno14mCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088129; c=relaxed/simple;
	bh=rLAKx7oZEBl4l8VQ6/vsIVEV/nqRO6+w6w+1NuugFRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIz9OG+NQpQ8bxTmEdPJTXgmQdvqhAtQQ4tTnSxrIgRVkZN1KgPBGKLjv5dsm8XTaS2YFvGhFBIaAPzJggDMYOC36Jtb02jO1QKppxlqOOm1MKg4szLeDugOtJNH8kBJYRc17HI4HR5qKMiTtupffoXDA3OhlNF3jZdyXOUBWXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gpUTAXO7; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gpUTAXO7"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ccf6a63a45so81822416d6.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 03:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781088121; x=1781692921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pgx1xgYrFcSjqIUoyhFqGxYUzhtvYzBpQalCqkbKQaU=;
        b=gpUTAXO7LYj55vqZytrIq49IGLWTJvLT+xAvLnjZFi7gjoGYGbTGjCIel1PHtM67TK
         fKtSbxARYH8l3bdsI1eQaDqaPVFqfZgLqYp2Hdz3Q8F9NJfn1/AGnBpOnXQl8Xp6HqVM
         fnpXPMJnuDMbGNyVvoklwWlIeAEsE40/bq+oK7DemyY/a4CJkZnYYCXzsxU6HbjjFEmF
         yzdeFiW+XXjOVaS62j0zEFozPv75geuKQhBJ/bx6qUvXD7YWWOSsFxDd+UVh+le0AZBv
         CIwPnI/Y91RzF+4pup0vWYBvUqDzBYJFSLPYs+DWujHYLHVfYs0K/EJP/e5pF7mytowE
         sOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781088121; x=1781692921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgx1xgYrFcSjqIUoyhFqGxYUzhtvYzBpQalCqkbKQaU=;
        b=MfdngWwjMwi7dKHjsUndnMosjdINDUcCGnDDhlIzwLurK9IIaUhvf44JdjM3/Ob87p
         NHvLJLWNjjJOEX4dU4hLTWkmB8H5Ck4RgQC/t5b1KNHLoYM4y6Kl37tqCw8k24Xv7yOv
         rLrFe2GAHzN7hZpqNnuFuP05EEJHt55Jc1GJtWAvPWEF0ysOSQyt3ZwVUgt8w5pWubcx
         IuyFrF8FBIVTZI4Mut/LOcXwJVONJHSstW+sfI899LjAaLFxqBp3vsv53Nit2qDvpiPh
         lDZtEDyvfB35j/VxaTufTmQko0qQqR8dzOINmbNuTbD2LElOz6CwBvFmR/mKQN8RW/jI
         JHYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+b3xBJvDPLWrprNbeLnvUj2iyoI9TlBo9m3vavQ1O/1ctKdryAJy5h/29c/Iw7BcbwtsCXDhbot6uNOoYAyGPRb8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1vspzgxUsdJCUGkiXkUBNrfDszV1cir70iOolbTEqigJ9LQrv
	Cs9nI+iqSMbG6PODMacdPfQcCTOAeVeyh7juFIuo0k35d6dNz8cBLBRCi1mom2g6akg=
X-Gm-Gg: Acq92OFfBX+4yDgYCYP6H6Xwqv+ZzlZGCiKD3CTYnVX8CIFlEVN+tT0L82L6nvSj7ZV
	PM4bfdaUul26XXECgRhb3WRsy7Kzj3xY1ohRzVX2ghI1vY5iTovaRfTn+AD2mJ3JIJujc/OFqGo
	AUPOd0D11rKyTYwxaL4Zw8LCMC8MmFt8ANXMGUzl/rElU5V5nZMfLbEz8u5E3/dktUpDM9LlR2Z
	t35km1slKJBBYMogf7IkAxAImdJ9iGq5bgyynpohyUWnzjD+dhNFcLAnVDiphXLYEtibOs7x8EK
	1+qQAuVJ75E3QeetFN/j0x58LTFCxzf9ISR/ePXLB96IepLpot4MzlfRKfGC41UjFRjwOS7SrPV
	9uLihNWdu2MCUR9kf5JjmHqd1NCOf4eJmVjYkVYiwPJGIMXy2f1BruwXqyjl3oj1robI7vY89/S
	tcQISlK0E3ypzmc97MAOfjVuMeodqKGbbErHxG7hFkg+B/FdiBy1jP8fLq6cK+EtbhFIa4pjNzN
	hy30SBDEsmc3SrCTw==
X-Received: by 2002:a05:6214:c68:b0:8b5:6654:7556 with SMTP id 6a1803df08f44-8cee63e377emr394580386d6.42.1781088120984;
        Wed, 10 Jun 2026 03:42:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd06e4d6sm231860136d6.36.2026.06.10.03.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 03:41:59 -0700 (PDT)
Date: Wed, 10 Jun 2026 06:41:57 -0400
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
Message-ID: <aik_ddHymus2DJ6D@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
 <ah47NNhuiClgGCdn@parvat>
 <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah-0CyZurn5D1ezY@parvat>

On Wed, Jun 03, 2026 at 03:00:01PM +1000, Balbir Singh wrote:
> > 
> >    __GFP_THISNODE cannot be overloaded to do anything useful here.
> 
> Let me clarify, I meant to say, let's use a nodemask for allocation
> and __GFP_THISNODE gets us to the node we desire, if that is the only
> node. My earlier comment might not have been clear.
> 

I've been tested an stripped back patch set where I drop all FALLBACK
entries for private nodes (including for itself) and only keep the
NOFALLBACK entry for private nodes.

This effectively isolates the nodes for any allocation without
__GFP_THISNODE.

This also precludes these nodes from ever using non-mbind mempolicies,
which I think is a completely reasonable compromise and something I was
already expecting we would do.

Notably: slub.c injects __GFP_THISNODE internally on behalf of kmalloc,
which causes spillage into private nodes because slub allows private
nodes in its mask.  I think this is fixable.

I have to inspect some other __GFP_THISNODE users (hugetlb, some arch
code, etc), but it seems like fully dropping the FALLBACK entries and
requiring __GFP_THISNODE might be sufficient.

~Gregory
