Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1E02FF66B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Jun 2026 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781278185; cv=none; b=dJiyKCk4Yz5X4yan1Qj9JtK8QTnpXjbMD0SvQDrMPXxHwcZYMOcrV7dBWfkLgdixllLfbDrZR+9IcAioiSZbzi2Mn+DPw9OK5R58/E0fmgcl1wrSjYQCx1sUeUQ3A5ytFHad/UOh2TXPC+VMSi15OItQUkKzZIqKh0YFK1n+L18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781278185; c=relaxed/simple;
	bh=mVnLEdPsEZ4bwU/Ei3LWYtLLBe2x/ajf/pLUxSqCLVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IffscQIzDT6vXBQ+effGVsNDnRhtE3vdo3/2i/L5ewCPk5gUgklGb5DsSBvPB/8TPztY88/rlyzZnweTmz3kvoYcVDqVsinRF2KCYZbgs//itidI/AC9KEaGGPYI7Rn0v36Rz4p5mbqpEHEFY8XoX5Xoj3PvKQ1lOoOauOALC40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=K1bIzaql; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="K1bIzaql"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51776b4de37so9180611cf.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Jun 2026 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781278183; x=1781882983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dGTIoUK/OWYjJAAY1+ZmAOAhqsOqMD1OUbmAHjFef1Y=;
        b=K1bIzaqleRmv6I9IUmhsv2jcoLba2fJJFC1vzoGElN4JNWQYZSY2iw6COwt9IpCVPi
         HceY2zcM6PrcDrijB787Yg50WsXLzVDns/vEeg+pV1yiJHIhdEH2IxRuAI2XyCSw0ay8
         gLUsl3pFsW5nPQx2MN48OeZrS+hC6A0brcTkSli0VejhkElL4j/FvIwGq6GlWhL114cC
         EsnqwZLFOeT2xwgBInMmxMlB3z858KT+BMyNILpcdDJms151iSH79ih/dLELmVKzTGT2
         KV9Ztq1twFuWtXoqOi7xa7+QBLAN6x4tc0oubXkXSdsrrFKn+Ol2HMVdH5CJBAX+wK6+
         zv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781278183; x=1781882983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGTIoUK/OWYjJAAY1+ZmAOAhqsOqMD1OUbmAHjFef1Y=;
        b=pGU1kKLh6diwp6foG09EBAmiVB+u9vDbp6hTrBCkujb7r61P62RsLOMXiqAS87rTCJ
         NWVFjn0mzzk6xDS3JIBMTxABiSCGWShY9atBnzvMwL6H4qKDrwMxgSoCHZ0TaBT2yyNJ
         kHSVfs0Vf45PSPM/sqN4beLV9LdIzLpcMGY+ZH6mRu2FxveXsTnWG3Xp0alMFAfHK/zo
         DIH5Wzho+HgHxi85uN1BU3FNBKdVLaFoJjTU29UYtN64+5KwY5eKd7O4CIcse+/O2tmN
         Z1ID/vu69uoCyP8bl9ErprfcJI7IFpajLsHNUeNJZH41hBGFXxYlUZjX7sgB39f9mwBy
         ZapQ==
X-Forwarded-Encrypted: i=1; AFNElJ9hQZxt0x2idL91owD8H90/XHg8aHfxOdGD8gv7H2i53+GjC/rFympJypjztRWVp5eXRdpZZHRNa92iDJoPM5wBcyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUdvzta99dgINnqnVlT8ArZxFtC1qLMbABIZyb63D1UddyGssi
	Gx1GfoOTPB77Y0X6yGcu3I7ftN2uDMQ+fMBfDcGb5CPPzsakssvPemCD9NknSqLyphQ=
X-Gm-Gg: Acq92OFZmuXqp32DhtA+UjCdCxrx/xmZQpyphWGg86w844gO/2ngs6iAnmdDFcisPpr
	TFo6rHEGjxcaHWSVHloUkV2P2U4ZUQSWy2/QDWnS/tDNEYicY88cwpJsKv2iJum4UwmxWaipJVr
	jrdWpWtzrsyoKc6FvIPFt7zFRVBRExzlT372uDLtDWuDgoqho/kpDgmG6LxWNjoYQJFDOVIfnYO
	8pEaEeeo6wnM+7sVfYw2rwLFpSeI6XOpVImNUG/w/Lp62KvhDDaKTCNpArA/8xCCbOUQvRZMfuM
	DoS/D3LqqO0udrWyPpo9kzgZR5xJdtHflpKyD0QoKRfDlmOl896eIzB/ac/+OLCZeHEzeh24ci/
	c+jcNqTMGRVzbo8n6TDtj3yCZnjHGsc0q3SIXVuPUX05pB58oqRENbCdC/jifpgfBBANhMGpW9j
	GrC8jJJqYmcUi07u8yZN2N+MOyQLzF9DyHHacKCkVQi9vN2JR/4GABMv04DsUMZIXrtWYYFLO2f
	6blszE=
X-Received: by 2002:a05:622a:1445:b0:516:ce43:f4ee with SMTP id d75a77b69052e-51953395db3mr1534991cf.20.1781278182636;
        Fri, 12 Jun 2026 08:29:42 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7ec47asm23782211cf.24.2026.06.12.08.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 08:29:42 -0700 (PDT)
Date: Fri, 12 Jun 2026 11:29:38 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>, lsf-pc@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
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
Message-ID: <aiwl4kCG814dpX7L@gourry-fedora-PF4VCD3F>
References: <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
 <ah47NNhuiClgGCdn@parvat>
 <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
 <aik_ddHymus2DJ6D@gourry-fedora-PF4VCD3F>
 <c1b66e7a-bb95-4295-8193-55ceadaaa578@kernel.org>
 <aimSzvoJDrpeQsmM@gourry-fedora-PF4VCD3F>
 <d01fb1ed-2418-42ee-aea2-37f9a5c5729c@kernel.org>
 <ainFROZ3WrGioyuY@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ainFROZ3WrGioyuY@gourry-fedora-PF4VCD3F>

On Wed, Jun 10, 2026 at 04:12:52PM -0400, Gregory Price wrote:
> On Wed, Jun 10, 2026 at 08:59:59PM +0200, David Hildenbrand (Arm) wrote:
> > > 
> > > I understand this question in two ways:
> > > 
> > >   1) Can we disallow PAGE allocation and limit this to FOLIO allocation
> > 
> > Yes. Can we only allow folios to be allocated from private memory nodes. So let
> > me reply to that one below.
> > 
> ... snip ...
> > 
> > At LSF/MM we talked about how GFP flags are bad and how deriving stuff from the
> > context might be better. I think there was also talk about how the memalloc_*
> > interface might be a better way forward. Maybe we would start giving the
> > allocator more context ("we are allocating a folio").
> > 
> > The following is incomplete (esp. hugetlb stuff I assume), just as some idea:
> >
> 
> I will still probably send the next RFC version tomorrow or friday,
> as I want to get some eyes on the __GFP_PRIVATE-less pattern.
> 
> Also, I made a new `anondax` driver which enables userland testing
> of this functionality without any specialty hardware.
> 

(apologies for the length of this email: this will all be covered in
the coming cover letter, but I just wanted to share a bit of a preview)

===

Just another small update - I am planning to post the RFC today once i
get some mild cleanup done.  It will be based on the dax atomic hotplug

https://lore.kernel.org/linux-mm/20260605211911.2160954-1-gourry@gourry.net/

But a couple specific details regarding the memalloc pieces that i've
learned the past couple of days playing with it.

1) memalloc_folio is required to ensure non-folio allocations don't land
   on the private node, even if it happens within a memalloc_private
   context.  Since memalloc_folio may be useful in contexts outside of
   private nodes, I kept this as a separate flag.

   If we think there will *never* be additional users of memalloc_folio,
   then we could fold _folio into _private to save the flag for now and
   add it back when we actually need it.

2) memalloc_private is needed to unlock private nodes, but in the
   original NOFALLBACK-only design, you also needed __GFP_THISNODE.

   This is *highly* restrictive.  I found when playing with mbind that
   MPOL_BIND + __GFP_THISNODE generates a WARN (valid WARN, it normally
   implies a bug). 

   That leads me to #3

3) If a private node is opted into something like Demotion (the node is
   a demotion target) or mbind(), such that normal kernel operation can
   place memory there - it's *pseudo-private*, and should actually land
   in it's own FALLBACK list (reachable without __GFP_THISNODE, but not
   reachable as a normal fallback allocation target).

I'm still playing with this, but I think we can even omit the
__GFP_THISNODE requirement (my initial feeling that __GFP_THISNODE
didn't buy us anything in particular seems to have panned out).

At the end of the day, this makes the whole memalloc_private_save()
pattern a heck of a lot cleaner than trying fiddle with GFP.

I think you will all enjoy how clean the code ends up, and how easily
testable it is.

As a testbed I've implement an anondax (we can discuss naming) that
adds some sample NODE_PRIVATE_OPT_* flags so you can do the following.

I'm including this in the next RFC - but we can hack the entire thing
off (including the OPT flags) if we prefer to just get the base set in
without a new driver as a start.

echo 1 > dax0.0/reclaim   # kswapd and reclaim run normally on this node
echo 1 > dax0.0/demotion  # it is a demotion target
echo 1 > dax0.0/mbind     # mbind() can target this node for anon-vma's
echo 1 > dax0.0/madvise   # allow madvise() to operate on its folios
echo 1 > dax0.0/numa_balance  # allow numa balancing for this node
echo 1 > dax0.0/ltpin     # allow GUP longterm pin to operate normally
echo * > dax0.0/adistance # set the adistance for hotplug time
echo * > dax0.0/hotplug   # same as kmem/hotplug

This also means *existing hardware* can leverage private nodes if
they're capable of generating a dax device.

I've even gotten it such that you can put a private node above dram in
the adistance heirarchy - which means demotion flows downward from
device to CPU, but allocations don't default or fallback there.

This seems *immediately* useful for a variety of use cases.

~Gregory
