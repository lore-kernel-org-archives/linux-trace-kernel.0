Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09DD41C307
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705033; cv=none; b=S5VyFzQc40kH+ADz6Qj2N3ZVi4TGDz8jl2FrTPMjWG5AWyHf6ksjBew1wpaIS+jf3f/Q+gCA7We79VhzaL33vpiizZhnWhlzcG7z4Ycu4RfK9QpmCGPcRtpepvdwMAr9poaP1VLx1tT7GZHB72vjw2cUd+SgycO3I02iC1OIiSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705033; c=relaxed/simple;
	bh=95TSTVQlWc9XEmLQ5CRQKISimsK3+z9mzOJYVfT8u2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiJRDw+wcAifpKCGK/r199tqZ/oCTQafPpugzSeE1gWPyX+KleCNBilglxo7pGnKCeLBVN+UuBMzftK2q6raVF7oU4dW16cxF6tD0tMaI9uUzbqVsLhRseHiuoDMcVegfhCtpRKCVCXNseJEbFGF8LgkV7fdAjK7+UEr5dG3mTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VKY/uljc; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VKY/uljc"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-516d0db9372so48670141cf.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 07:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781705031; x=1782309831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=21pxQXdsUMGW+bGknxxPyRxRyaJDV62jMRhp5DnWHkk=;
        b=VKY/uljcfnKh99zo5ySSTpXVX7+PQXcN9dydeIP3wAjLilTe7GyGtIKsWKRXaqjfcj
         V60zh+FXk43C01MtPyaBVrkkdpfCl05MVgB8i39okjylUDiUNSlSKaXk2ht/jc3PilPZ
         HhjWrtpiTDxksxAS3zbmbcxNEToz6Ha9CTeE3/wQBXkraKZvoeYV3B9KQ5R6VSzel+xv
         AdZ6a5EFmVMuU9exqmP7Cb3moiTHWGs8es23xSFCEbinplwlXICueJo9ReoXUb2Ee4nR
         1tRIZrraIrLJCu/UJBEc9RMu9dylL1GP0EbKXIj5hprozLZDygg1KuOwmHEoAInY5eOX
         yThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781705031; x=1782309831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21pxQXdsUMGW+bGknxxPyRxRyaJDV62jMRhp5DnWHkk=;
        b=bhKTy7jpaLd1vHs9lpFhFU8RxNkrqhoGcae0T6zuz1JAEVqUeCv7nx0laICynpwtaX
         r9xNFxkU49LyZ1Uk0K0O0j830gmNhFnXV3lk3cZLr2A2dRKwNp6MvAVVajsRuMFvWNrY
         /4Z+yjqM9IeTryV4zMuaYwuUaHz+NoeEwDNnKMz5UWANL00Bsp4N4vYlZNZxx7HcPEDa
         2wApTC8wFrjX0rUZgcKFsVv2lmYTXaMkdmnuTCwvfnRIEJPcaW4r0WNi5q6iw37Dcv1k
         SB6CMWzzFd6xy/gT6My4vSy5LKeFsqVzuLuCFlojpqP5e0RKTO11Ru+58haC6WRjX/uD
         4/dg==
X-Forwarded-Encrypted: i=1; AFNElJ8D/Em+G5Vhkdjm2n8lS9H/YsRHg46QysgKdGduV2zkZf+6VQ82RV3FaakM/xCGLLcUww5zm5QTNgJlfNbuiHZifbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCelsuFId7JsgtIM3rOrX9v8ew5YXY1ZDCZm3lwdpKTOh6jidB
	0IKRnlmFQOD20JW5Scl05wTc0X4+I3aKbavJczRu7fqOkX8H5zNtqbbH2CcNHJrKM7g=
X-Gm-Gg: Acq92OEJzXDPHyHjFlWOxi3CNyUCrlb4gys9UINV4GURTdjy3j5BIHzqDlQLg/6rn4E
	Kku93Enn3LSX87Z311gW+qJXtO7yjAUlomUu+jmRGI3pmQwNZ+FZ+imIC/RqFWMSQq0Zo4XQL/6
	ROyUmyZn9i5+pgD9L2Zt1A1IjuHKjyvndMLlqeQNzg7ichlmBgsXDLP6CDTZG/BuSzyvSRWYwCr
	3B77gGsYf07OHMbe70FMu9TV5KKmz3h3QZO52rOL8Vz2zDqB5sXmNeqhIdC/g6aTzZ+9zjFdkUO
	XIFb/4Q/tURbVstIjif3W8Xq3+dFMJ8L6FzU27Dp9JvQ5mEBOGkBb/ONmYa/JRa9UjxSKc4tpzI
	KgixcLAMae8Uu2wwIgQA2wuVgIh9BTRETcm5I3lOgWn1UfsVmlUF5lY+tYfHP5pf9hR7GaDenEY
	v6xtYbEdmoNTHFeB/tYoaC
X-Received: by 2002:a05:622a:4a89:b0:517:82a1:adf1 with SMTP id d75a77b69052e-519a8de2756mr65756641cf.15.1781705031230;
        Wed, 17 Jun 2026 07:03:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::3:ce0d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51955b271fbsm134106091cf.22.2026.06.17.07.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 07:03:50 -0700 (PDT)
Date: Wed, 17 Jun 2026 10:03:46 -0400
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
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
Message-ID: <ajKpQgfimm-ztnHv@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
 <ah47NNhuiClgGCdn@parvat>
 <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
 <aik_ddHymus2DJ6D@gourry-fedora-PF4VCD3F>
 <c1b66e7a-bb95-4295-8193-55ceadaaa578@kernel.org>
 <aimSzvoJDrpeQsmM@gourry-fedora-PF4VCD3F>
 <ajIb4DJdLGPbMB4V@parvat>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajIb4DJdLGPbMB4V@parvat>

On Wed, Jun 17, 2026 at 02:02:47PM +1000, Balbir Singh wrote:
> On Wed, Jun 10, 2026 at 12:37:34PM -0400, Gregory Price wrote:
> > On Wed, Jun 10, 2026 at 05:00:33PM +0200, David Hildenbrand (Arm) wrote:
> > > On 6/10/26 12:41, Gregory Price wrote:
> > > > On Wed, Jun 03, 2026 at 03:00:01PM +1000, Balbir Singh wrote:
> > > > 
> > 
> > For mm/slub.c we can choose to do one of thwo things
> > 
> >   1) 100% refuse slab allocations on private nodes, i.e.:
> > 
> >      kmalloc_node(..., private_nid, __GFP_THISNODE)
> > 
> >      And will fail (return NULL).
> > 
> 
> Doesn't this iterate through N_MEMORY only? N_MEMORY_PRIVATE should not
> be in the regular for_each(...) loops
> 

If a node is in neither FALLBACK nor NOFALLBACK - it is *completely*
unreachable in the current page allocator.

Next RFC I've reduced this to create a ZONELIST_PRIVATE separate from
the ZONELIST_FALLBACK and ZONELIST_NOFALLBACK, and an explicit folio
allocation interface that selects which fallback list to use.

the feedback in the past week has been helpful in honing in on a
solution that I think is generalizable.  Have just been taking the time
to test various behaviors to make sure I haven't been regressing any
userland API/ABIs (mbind, mempolicy, etc).

~Gregory
