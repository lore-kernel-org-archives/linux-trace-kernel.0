Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819C937E309
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Apr 2026 02:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776653787; cv=none; b=avM4/7D//PkSjmWAMbeSk8gsGOf6vLQ2zjJeTg/CqbHsEWdmpFS9iWgD5TINOyI4cAzW1bI01eRWW3yz3eQylgXK8/Rxmwp/oT8Q4rLUVI/5d90/HZ9tZaHOYmo29PBI0LpxwOLl517MD4O297UUrkjq42bItNi9KJAKqOjk3xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776653787; c=relaxed/simple;
	bh=Gy7C5LgAy0+dNJVh3a/spG3LUsjag46Tvhe61CPzqjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrZVNCpOw4JvkAjPQOBFD/QhH88CZo4BWg5lo7AtjbTsWRZsUixD6p0NncfOtL5LagRt6Y8IiDkbpuHC0tvb3/FZM+O+sohQz1Np5sqtDYPAqnORfhSUms6uVGmtqrSsRrDFhW5w+tKhAJtml59pQKLwJNZrdTN/vyMr49M+g30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=t1b3S+bk; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="t1b3S+bk"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8eb5ad01402so36880585a.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 19 Apr 2026 19:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776653784; x=1777258584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tugQt2aIOJgoqj0Ob37lQ1a1TrVKhZ7jSIgjv7qjxfc=;
        b=t1b3S+bkTXE3j00v5UNCH8rPHlmuEMJsB+F6lwv8trpr/PskjdnmsL4XxF9lpDjdF0
         hzhD9hJ/y1a/SqHQ9k6S04uBN6tyzhw5ddh6/Dr0Efbu75Z1tYBl2rwLwqjXkXjwnWgi
         zo99c5KrKmAg31ptTacy0m7WGoFP2qXpCPOewg5RUjcFmBnHyEsPkQ3CXu4Ap0yWF8Jp
         y2Tsuja+wRqOw1p5f5NtBwF5g9oGJSKcc6UHi76irOasuXa4l6PJP9bbsi4xnRWezIZd
         Dv7TbLaOn+YYUq/YkJ20RultXKWF5eKRrsoyZjlEXfxwcliifnoOs3LV8VCvxdCBCLUA
         uHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776653784; x=1777258584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tugQt2aIOJgoqj0Ob37lQ1a1TrVKhZ7jSIgjv7qjxfc=;
        b=eppPJPIZF+1QhIIouEEmTER0YoSHbt7TLPcS6JXTOLkpVTijlLS78BmJ5PTljU0Z3/
         x7oJx1ERJgeD9MFMMyZN9p94x4FpEVs63hu3NDQZGAzEXkFF6QMEe5KLATe7WMWIBj53
         QhxdyNTX6A7pb/soAtZv1XBtccHlHaNWIgNS18IoOealOgqxjNA0cU0PPEiIjLYjzlA3
         O5Do3hSFwnD0prBxTAC76nOswNgYV/R34RVHZ4rlScn+wneZtm//E4IldEyabGoIvmPi
         Rzn5AIiqghWSh3gWAjACnI2RPq8wdosjulo+gvQPqg64wFaELT7hrWbg/z7RfF8a49es
         n3lg==
X-Forwarded-Encrypted: i=1; AFNElJ8wYypgurhVdzgGMC8o4blge5bz3aQcb5yf7Pr10JCzeRFT6UXds7S/nXG2daclxgcA1TS6cIEkrb+h5HY5qmKViBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyybvM1Ozgv2BU4URVpvebm2/SDx1vQqhkIvHBZLViGEFtsT1UP
	1n3IFyWiZs648SZkjDibogjDym7aQK2iGg5dZicn6KeNuzVwRa97+SWtr+UU3A44RLM=
X-Gm-Gg: AeBDieuQrzTNJZCPfeRqa2lKc29tpvm4wohlxnBxs1IGjSWew6jYi3N507lRgDMaLgx
	UO6J1IU/7dV5DoSYB7nNDygloN3ArcWHthGYbuLkJ8dnS5r88Q1U7CSMFuqOrrWcuDSImmkBtMp
	I4SlYAlHXg+X1/hhjaCZF/uLtF21UXJOIJBLJQI9PBe40/O70AemuyOxKm2Y0xGMJ8CLkPHJjvH
	gJ2jpPTZ9JiH1xnD1b+4DNntK8s8B8XBeuWBIH1mRk74S43HpePZ5eN24eLpftS9dAqSWf9fYcx
	JXvvWtD8ye9R5x6zR9N7lVLYfKXbm/+/UjvAVh7+aS7h4DUGnlod5NKwyUUnSn9N4BtJhnD7Oym
	PjA+WmyllDKX0gxZiR4AdmNV870YwN+gv8mS5rS3046hQ2rkQ3+3ejWWC9SZdFYTDzvPOgo1cRG
	gEuiR1uRr6zE2nHtmUBhy9e8yN9NNcT7s25LtAqzWQSeSrXag6f/m8/JsCt3MAaVnQM9LZl4k0w
	jidpMZrlfBDGE+R/0hxVFw=
X-Received: by 2002:a05:620a:a2c3:10b0:8e8:bedd:14b2 with SMTP id af79cd13be357-8e8bedd1701mr799144185a.43.1776653784400;
        Sun, 19 Apr 2026 19:56:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-108-28-184-223.washdc.fios.verizon.net. [108.28.184.223])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe9638sm706089185a.1.2026.04.19.19.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 19:56:23 -0700 (PDT)
Date: Sun, 19 Apr 2026 22:56:20 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
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
Message-ID: <aeWV1CvP9ImZ3eEG@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <3342acb5-8d34-4270-98a2-866b1ff80faf@kernel.org>
 <abwRu1FNqI3dVyqL@gourry-fedora-PF4VCD3F>
 <2608a03b-72bb-4033-8e6f-a439502b5573@kernel.org>
 <ad0iT4UWka3gMUpu@gourry-fedora-PF4VCD3F>
 <38cf52d1-32a8-462f-ac6a-8fad9d14c4f0@kernel.org>
 <ad-r7hwIdnvKsrh9@gourry-fedora-PF4VCD3F>
 <46837cea-5d90-49d8-be67-7306e0e89aa3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46837cea-5d90-49d8-be67-7306e0e89aa3@kernel.org>

On Fri, Apr 17, 2026 at 11:37:36AM +0200, David Hildenbrand (Arm) wrote:
> On 4/15/26 17:17, Gregory Price wrote:
> 
> >> Needs a second thought regarding fallback logic I raised above.
> >>
> >> What I think would have to be audited is the usage of __GFP_THISNODE by
> >> kernel allocations, where we would not actually want to allocate from
> >> this private node.
> >>
> > 
> > This is fair, and I a re-visit is absolutely warranted.
> > 
> > Re-examining the quick audit from my last response suggests - I should
> > never have seen leakage in those cases, but the fallbacks are needed.
> > 
> > So yes, this all requires a second look (and a third, and a ninth).
> > 
> > I'm not married to __GFP_PRIVATE, but it has been reliable for me.
> 
> Yes, we should carefully describe which semantics we want to achieve, to
> then figure out how we could achieve them.
> 

Ah, I finally dug up my notes on this.

If we overload __GFP_THISNODE - then we have to audit all gfp_mask's
with THISNODE against the use of any of the following *forever*:

#define node_online_map         node_states[N_ONLINE]
#define node_possible_map       node_states[N_POSSIBLE]
#define for_each_node(node)        for_each_node_state(node, N_POSSIBLE)
#define for_each_online_node(node) for_each_node_state(node, N_ONLINE)

  or

cgroup.cpuset.mems_allowed / mems_effective


Anyone that attempts to do:

    for_each_online_node(node):
        buf = alloc_pages_node(node, __GFP_THISNODE, NULL)

*will* get incidental access to private node memory, and it won't be
obvious to existing tooling that this should be considered a bug.


rate of occurance in the current code:
-----------------
node_online_map       -  21 instances
node_possible_map     -  25 instances
for_each_node         -  346 instances
for_each_online_node  -  67 instances
GFP_THISNODE          -  58 instances
(notes don't have mems_allowed/mems_effective instances)


But it's not always going to be obvious - since nodemasks and gfp_masks
get passed around as variables all throughout the kernel.

I ultimately determined that auditing this in-tree is already a fools
errand - and suggesting we try to validate this never occurs for all
future code moving forward is just not realistic in any sense.

I could not come up with a way to remove private nodes from
node_online/possible_map - and private nodes must be added to
cpuset.mems_allowed to allow cpuset control (otherwise all userland
access is blanket denied).

So I moved back to __GFP_PRIVATE.

=== TL;DR:

The core premise of private nodes is isolation first.

So we want this code:

   for node in cpuset.mems_allowed / online_map
       buf = alloc_pages_node(node, __GFP_THISNODE, NULL)

To explicitly fail - so that the caller knows they can't use these
masks this way anymore (it was already potentially a bug, but could
have been masked if all online nodes had memory).

~Gregory
