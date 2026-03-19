Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5434E31F981
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Mar 2026 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930607; cv=none; b=UFJFCEl7CoYOMH4PiqIvrrmeVpsl5qeNQ2MBfa+zOYyTPYejSACajIg2J8VvtIeFUUbHo3Y70cCYZes5JlOhKl7kMHuafiOE2HNn090VLMEhDUsWtlIa8fAU5v55UxGolGltV/HiNa38xYfEXtR/1kY1ZABSbawMynEdfNKURzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930607; c=relaxed/simple;
	bh=BArAqxuNOMZmZ3DFzVkEiSDUW/6K7+Jdphve/CIcCPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfN2MfZjm1SpMtEz35hTTg82f66r+Lylat/tHApd8QFuEuo2cYCNKBKTG2RfGz2oRL7l70NwMYZAjHNoyH2zKd6XX2FpJ+yA7+ME7AddViJGfI5D2GsE02EWVziujJPMDlJROeb/tucsjKOlcDH7mZqAIs/nhPOkgyN0FeV05+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=twd9D5QT; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="twd9D5QT"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cfc3ca1922so34572885a.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Mar 2026 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1773930601; x=1774535401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZ62zRGDMh84ev+ADivtxhXkIe87cWoaQL4WKudvzqg=;
        b=twd9D5QTV+/09D1m8dWBXwC+k4zz/klk9ygEPnE7kaQ3jMDwY2JDJX7QOlF/Y2tBsS
         P8C7lf+4F2tdOenzTlWmc3kH5GhHdB0iLZzybt8SROcnrmfTdGWvu5ID5HvwLUCujeCG
         6a60XL3y6R+skrRmRzesHu9ui+3wbNnmBgJqmnZ2eQIiOPc0cxiXUbiY5TZIiyUKo1zh
         PtEtQIM9wBpfBlJtCy/or1Uw8buUZzVxLcWikstswAax3uE5bgBr6N7rxWiJjLkSuxFY
         C9mtP46Hr8W6I8ZnK/4AWpB5+Jm/DVJHRmJlvDF3V1AFlxVmCQw+YDdN2zg1I7DL273W
         DyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773930601; x=1774535401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZ62zRGDMh84ev+ADivtxhXkIe87cWoaQL4WKudvzqg=;
        b=gEp+s7FRPgwULz62JL0Oj+7sK+4DzyJbrHFFMBmcJVwe0+Wn4j8h1cpZhURduhTsSe
         TY2fOO7B1ZGshPr8kzI+VEpPCqgdmMcEuubyNOlYOwWZtOdYs1OA2bx1c5aXGljeo5BD
         TktyaFP71Bp/HvpoOM9KB9AmBNj67HvE6xrSbe1szy8FXR6L4pXi/xLyTv33vHRtcnEh
         R0ynf/RLdJ3oYOX7t+n7bV3ZI1sAGvwmBTmvQ7aujmR6RZAA/M+t3rg3QEPc30EqC6ls
         mU8Dfi/IwIDnVRMR5lU81uBDB4e6rEGmIVLVzVrACMEuM/qLycOY1ynP14aeJZU6oyT6
         JWWA==
X-Forwarded-Encrypted: i=1; AJvYcCUpLOJp3IkIh2s+2G72BwSvUeB91YqFrd43gO/R8xvViDfsQ3NKor8v7wgTaiSr+RBydTkBu4C/kc3Rd58jSLSZTq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWW7p3khcz3WILMmQaWmWuNGnAoxKbJWG2wxzRrau4i46uwCVU
	9aWT8Fzv+QNd0yvfOs0qobNOMHIiT6e6sUFztOc9DKDNzCpvw6WzWHzY6fBzFlgld5M=
X-Gm-Gg: ATEYQzz3QynV5fvKqnm2oCJkNs3DGuj34ElX71EUsIEYYZV4jepHKNEo0n9/Caf9h+N
	RmVrJKQqsIdgHk6mj8amSbiOaBc193bdCLmdfCal/xKprTzsP/5AGpoERynz9T/zpJtSEOlY0Cp
	ZYe/kMBgBo46xlo2F9qluBl1dOL3egRNLZzwZYsiArznReHA5DXzwpItgb5ciACDVd/mG71DBeG
	X0tiPG6Xi25ENfGT79x4prh25J50dpocNtnWtER8pxf0WCx/H/wG3F5irUUrp84adlZwSwoJ0Dg
	md3FDxkKRQ5e42NjtrxxhEZq5YZd7rGILcx/hou1t6CeTb8CAYe+keBFNcOkw6NfeWq//m+EBA5
	bONUkC6NnzEDT59JxbJBtvG1A8JqpCJE7Rvlwbm64tw4GMLaUCrtF0nw6NcxKhhFq6jH8cvihDM
	a2pIUUVR/FUvBebC/ZWhJ56RLSsSJwxMQPfjH2/lXcwoEVPc0bJsetuaXA8QV6j6T8Ossw8x9Cq
	qZkCJQRUw==
X-Received: by 2002:a05:620a:1a21:b0:8cd:b024:114d with SMTP id af79cd13be357-8cfb9ea6bb2mr485207585a.40.1773930600903;
        Thu, 19 Mar 2026 07:30:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc25f0340sm87627185a.1.2026.03.19.07.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 07:30:00 -0700 (PDT)
Date: Thu, 19 Mar 2026 10:29:57 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	kernel-team@meta.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, osalvador@suse.de,
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
	apopple@nvidia.com, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, jackmanb@google.com,
	sj@kernel.org, baolin.wang@linux.alibaba.com, npache@redhat.com,
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
Message-ID: <abwIZd7FNPj5YYXQ@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <c10400db-2259-4465-a07e-19d0691101a4@kernel.org>
 <aZxqP7J1kOClQUPQ@gourry-fedora-PF4VCD3F>
 <aZx7hsVNU0XOCCiG@gourry-fedora-PF4VCD3F>
 <049d056b-844b-4480-b90e-bf4c850fc70e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <049d056b-844b-4480-b90e-bf4c850fc70e@kernel.org>

On Tue, Mar 17, 2026 at 02:05:53PM +0100, David Hildenbrand (Arm) wrote:
> On 2/23/26 17:08, Gregory Price wrote:
> > On Mon, Feb 23, 2026 at 09:54:55AM -0500, Gregory Price wrote:
> >> On Mon, Feb 23, 2026 at 02:07:15PM +0100, David Hildenbrand (Arm) wrote:
> >>>
> >>> I'm concerned about adding more special-casing (similar to what we already
> >>> added for ZONE_DEVICE) all over the place.
> >>>
> >>> Like the whole folio_managed_() stuff in mprotect.c
> >>>
> >>> Having that said, sounds like a reasonable topic to discuss.
> >>>
> >>
> >> Another option would be to add the hook to vma_wants_writenotify()
> >> instead of the page table code - and mask MM_CP_TRY_CHANGE_WRITABLE.
> >>
> > 
> > scratch all this - existing hooks exist for exactly this purpose:
> > 
> > 	can_change_[pte|pmd]_writable()
> > 
> > Surprised I missed this.
> > 
> > I can clean this up to remove it from the page table walks.
> 
> Sorry for the late reply -- sounds like we can handle this cleaner.
> 
> But I am wondering: why is this even required?
> 
> Is it just for "Services that intercept write faults (e.g., for
> promotion tracking) need PTEs to stay read-only"
> 
> But that promotion tracking sounds like some orthogonal work to me. What
> am I missing that this is required in this patch set? (is it just for
> the special compressed RAM bits?)
> 

Yes, this was specific to the compressed ram bits - it allows for a
service to control where/when writes to the device can happen.  In this
case, I've limited writes to just the demotion step. (Although I have
since realized i need to not allow file-backed memory to be demoted).

There may be a better way to do this, but also it may very well be the
case that such a hook is just a bridge too far and isn't wanted. I think
this debate is warranted.

~Gregory
