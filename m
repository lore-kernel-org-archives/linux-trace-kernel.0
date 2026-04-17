Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7562A3C1977
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Apr 2026 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776438479; cv=none; b=VMxfxmfJixskTaJjLQwP74Csv52jrUDMJ4y710S0AEOjyB4BqxrEJGVYefZFktdNI5YvtiHfREUiHFRsKh6wMloUaMDA8/iqLq05NXTcHKqGMjy14Q+QJ46/1gMIcCRC9aQxLteAVJ0Se+3RIZEcAhT0xkMWBtLRXMkzyUqUavU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776438479; c=relaxed/simple;
	bh=4pOvxWvA/yj5xSsYSUbpCo6Kkeq+uF64q1hqZjlP4T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9lIOu9e/zTGFvkKY95ixFv/68d6qiW4Ju0XvZBgmQQrQD1je7JXkH/cMqm1dYTeRbK8LTMOoC/9kHGqdsyVGksml1EacYh8LZAc0PS8GIutelbS4o3/Y5cWxjEBaNehah/fQtc6QBFkWKTac1od2YKAWMk2qEl1ed+7vDTywjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MuXvucRS; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MuXvucRS"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-60fd9b71745so294435137.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Apr 2026 08:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776438477; x=1777043277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8hmn8cP8J8LvjQAqTAHhf9pkwu4llVl8k7YZT9Lr2w=;
        b=MuXvucRSPryIvwYoaQCiGTb9aT275yNFutcZ8S6ZOCNgBzvAKq7D9d+rhXkd2xbJqZ
         FWEK6FwCH8erIvtPT0O7vKzSm3Rr4npcFBMD/omrKxxHttXdAoMZ1CU2NbexWyfowXXY
         BK1I/UOka5u3OVfPDrWoxsEjUED2U+CStdw/czC6gqtUMv+huF8cu3wC42LVGI9zBeP9
         t++KjE5+/VVnbuTtP8Vhgc/c8oIjrO8Pml5joMhi1D1gMIA3QspaijVqGmC9oDPKeroO
         ubS/lBY7qL8QVEDbun0mNhpoSOZDZyCEIYgM5XoHlYIf+kkcyhnXT7HPY6yvprnf7qQ1
         E2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776438477; x=1777043277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8hmn8cP8J8LvjQAqTAHhf9pkwu4llVl8k7YZT9Lr2w=;
        b=qG+FO4u+QIKnPENKHXVNv2e+1my9/G7xfbw5dJSYkggTheivXTpC2Z5zfOG0RCRDaL
         HQyyENeLF+8G7db3KWMhHqdGERzl3oKKg7rPFgLJqHfqBg/R3seO1VRhhOVI+oZQDrhW
         Ae6keTwSe15AzyIK+8PyVKhodXHmIbLNhyntvcUcIQz2GFSbNAOBGJ5B0tfzI0uYN88D
         mQqztn5YCznYXQ/A70q3JGinARNBicR8hp2ZC43a67U+jqOiulZF6ZWxhTZQRnJyGV1j
         q4dlHOvNV3dKWfA5GsXOTo3dXkWgokolLpb2qYuXkZat6nc2gXV//idwXxSo7EJVruCu
         FvSw==
X-Forwarded-Encrypted: i=1; AFNElJ+TebwrW5Uc+x4MUs2b/gSRTVR5ptFq9Mx8rXcNLrrAXxbfDAypC45UFfeWeXvg9JGNFCff0U/Kgmd3SlFRLnNqnRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkAH8honJazTWhN78eURIPqtJ41MzZDTbgDYrt9j3xFNBsh8EP
	tl8SF8w9nfKKqS2wCa3iqmy4oGAm8u9AdGfXi8h/kO5xt+0YATf6qqxlnZqWlOLo9dE=
X-Gm-Gg: AeBDiespRbuJWiXCYtL4LYQ0bbwKAeb8/Qkv2w+1vm2HDC8ZhqNxCXkiLobfXOS3FYF
	Zyzyh1S8OkLyIuDr/eJf4lVIrckqf8JixaJrrn5Eq1kBZhYDPpCBz9nkxQ78/Qs9VgiEDYT0JN7
	gnNlOdNlz+vY2tEL6uo9Dm+TyC/P3Cp8yvQHVmMug0azJs+7TnP9Je88NFJ3m2LVnGKdAga0cRT
	fpwDg9d8mc+bk5Mr0uD4O+YZN3m2qbocVELvKYwgcMLlFreO9TLIcxKmm+KtEzVdmoidtc8clIn
	/LrA1UM4rsIjp71fytrbKviIAhVE8GePlr9eOWgAaFNApRyEtvxBJ7mVN6MY/GX3h1iNPsegWwR
	6X6TIJ7pURIYmHbh/4GvZW8vEUiu87W2dRlwmiT+3I7EnnRT+/CRMbZ0zPHk3u0xjLLenTSrP1R
	LOx2b71C/Y+f9VMCcCmf3woXK7TjgwJj9bn1r3YVNqwaUVsa6w+ecgX7DbLKCzc3LW9rGkNzR0b
	SrSc5VkHfVcd9LWACW4
X-Received: by 2002:a05:6102:162a:b0:613:6b44:3fa9 with SMTP id ada2fe7eead31-616f71ff8c8mr1462957137.20.1776438477197;
        Fri, 17 Apr 2026 08:07:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-108-18-109-80.washdc.ftas.verizon.net. [108.18.109.80])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac6c3e7sm13032726d6.13.2026.04.17.08.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 08:07:56 -0700 (PDT)
Date: Fri, 17 Apr 2026 11:07:53 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Frank van der Linden <fvdl@google.com>,
	lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
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
Message-ID: <aeJMyYMQWLyiGTRb@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <3342acb5-8d34-4270-98a2-866b1ff80faf@kernel.org>
 <abwRu1FNqI3dVyqL@gourry-fedora-PF4VCD3F>
 <2608a03b-72bb-4033-8e6f-a439502b5573@kernel.org>
 <ad0iT4UWka3gMUpu@gourry-fedora-PF4VCD3F>
 <38cf52d1-32a8-462f-ac6a-8fad9d14c4f0@kernel.org>
 <ad-r7hwIdnvKsrh9@gourry-fedora-PF4VCD3F>
 <CAPTztWajm_JLpp9BjRcX=h72r25ELrXeGkOXVachybBxLJGS=g@mail.gmail.com>
 <aeA6aNDpQ-U5UJCs@gourry-fedora-PF4VCD3F>
 <6d4f702c-5ad6-4f84-a73e-c9e34965be98@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d4f702c-5ad6-4f84-a73e-c9e34965be98@kernel.org>

On Fri, Apr 17, 2026 at 11:50:58AM +0200, David Hildenbrand (Arm) wrote:
> On 4/16/26 03:24, Gregory Price wrote:
> > On Wed, Apr 15, 2026 at 12:47:50PM -0700, Frank van der Linden wrote:
> >>
> > 1GB ZONE_MOVABLE HugeTLBFS Pages is an example weird carve-out, because
> > the memory is in ZONE_MOVABLE to help make 1GB allocations more
> > reliable, but 1GB movable pages were removed from the kernel because
> > they're not easily migrated (and therefore may block hot-unplug).
> > 
> > (Thankfully they're back now, so VMs can live on this memory :P)
> 
> Heh, but longterm-pinning would fail on them (making vfio with VMs
> angry). Similar to CMA hugetlb.
> 

Yeah, depends how you configure things.  As long as you expose those
pages on a separate memfd and online it in ZONE_MOVABLE in the guest
to avoid vfio from touching it - you can have your cake and eat it too.

It's a bit of bodge but it works.

However...

> In the latter case, we should have a way to identify "this allocation is
> actually from the CMA owner, so longterm pinning is perfectly fine".
> Checking the CMA alloc state would be one approach, but that's rather
> nasty. I guess there would be ways to make that work.
> 
> I'd assume that people barely rely on 1GB ZONE_MOVABLE HugeTLBFS Pages
> (iow, mixing kernel-cmdline ZONE_MOVABLE creation with kernel-cmdline
> hugetlb reservation).
> 
> I'll note that there was long long ago a proposal of converting
> ZONE_MOVABLE to "sticky-movable" page blocks. It wouldn't really solve
> this problem, though, where the early boot code just does something
> that's rather stupid.
> 

I have been toying with hotpluggable CMA regions.

Interesting opportunity:

  Hotplug on a private node w/ (RECLAIM | DEMOTION | CMA | HUGETLBFS)

Now you have exactly two enabled consumers:
   1) HugeTLBFS
   2) vmscan.c demotion logic

In this regard, HugeTLBFS is the only one that can reach these pages in
a way that could result in the pages being pinned.

All other pages on the node are - by definition - movable, because they
can only reach the node via migration (demotion).

The system can't do fallback allocations to the node, so it operates a
bit slower as a general purpose memory pool - but if you decide you want
to optimize for that you can unplug/hotplug the memory back to a normal
node in ZONE_MOVABLE - without rebooting.

~Gregory
