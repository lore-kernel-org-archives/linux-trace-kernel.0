Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6464611E5
	for <linux-trace-kernel@vger.kernel.org>; Wed,  6 May 2026 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078632; cv=none; b=OfTPBm2YxUHpqxGiJdyfWKPciq+X5zmEhvb8HZ2GD6p4W/M/PjdsXJujuZmvcruwmkrZeQvLa3nVV2oUQ2enQ41k+TNx0fFApO6x0TT+4bdYqlAPA8LF4Zfcms9ZOEUb4yV3NvO9gq3W1C/eJUngR+qmZlgrcVOvHiGQa1mE6QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078632; c=relaxed/simple;
	bh=8rYhAkFOKY6K/j1/wpxkQvi3y7Z+5CCbQC0nxatTUIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVH6q0/3xED/ld39HZ3+asuqJS+FjV5cJ9ilTf3/MWPAx2Caq3GunSX2NuG0gSPN9d5oo8tj03DekeEMXiwJxC00hqSxHbVjmMOP6U30GvgkjVVEOZicDHGPxjwTQc7LPVeolqk9XSiQFdhhqhcpoCptzsMwKBBBH8qp3lfmJXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tseGfhns; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tseGfhns"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4526a8170ceso148815f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 May 2026 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778078629; x=1778683429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0yrKfSuIFibBSjAR8E2oWzOhR6JQ9Zhv+MqRJc3mpQs=;
        b=tseGfhns4w+9L4TQ8ZT857uRRltMFzAQPmLZhCRY+EGmJq0t6AvhRuFIS2LcdgEwPw
         IWWfpzomqpb0AW+jcMqK3qZCRTT8gRjmbviSTyqQ9dMYRHQFRW81+DujnCHOO82yJrHH
         A7OG/wPvOgIRDnKkRY3WkOYZb6YW3Z4q0qxKjyamqlQJHbSw+MaIKDosfAiIEjx3/L36
         ca3De28TBjvihOBZqV3zY6GzNWXzsQYt7aLjFeVdNuIBq9wBxCiI0VNz/TLwO9dtHXlE
         gwXigjF6RVNMwLpkFJ53l9nzqb/23+nhDiUX5xhcdKIgKb31heeP4FOx84OfNNVTOGQi
         2rtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778078629; x=1778683429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yrKfSuIFibBSjAR8E2oWzOhR6JQ9Zhv+MqRJc3mpQs=;
        b=atlBsag5DQmu1aWbP1qNfnRthZeu4aBtZKYrsjCs9p5kbLNb0jqMf2TU5RFTbPfY0e
         RwR3RadpTl2y9Tu/ly+JyI3qm5yzKGtF6RPzLmZuAe8k/M/BaUMG7g6cDLhus9vrSqW9
         7g4MO2KFHUxJhjVoxTXTZcPOxp0r9uS1EFMn4OdVn9R+tPGmaZ6AK2SccuAHhk8ohSwZ
         uqt10GzLNnlPvJTdOqCiInAs1lMUQyfawneTD+sGRj/LIAHPVxI3bVT0HX2RmtgnWZT9
         TwhAIaUXd8wsRg5PXVvJfkTYRV+Q67Tts5f8BMiL5AQndUe+f6lx7OWJ2JsFcCYfmmxL
         ULNg==
X-Forwarded-Encrypted: i=1; AFNElJ8ptaPLN1ot6neEK08VLWcQzYwuJHbg0ZTfbPO/5/M9Lt3ZDPQaSSwVzeNnxvMYWo+KMk92kX11qVTmK/2wYuLgGac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmu1Sud5b05drEg6ZLP1m6UPR6vaf4MzYfUp6GCFzWGo9yH+j3
	Cfc/MlegmHuAUMORrJgCx7AUoM1j4fyM0V3zhFXBEdJV57X/N7tNWVmBUwWuJRj2YBg=
X-Gm-Gg: AeBDietYuwZPwEAL1liL1k8EvqjMq+yvOFx184xqGjdL3pYDoRZvDWucvSb/6UPYO25
	+OkzLqT/WIJlQBKPRUA+11ykSqIRqnu/7CAyM2P0oCjbLh43Nr6Qbp0PgiQ28fgOefUVAgn8rC8
	tUNx2pXvsH4pbOWR2nyTnK/nwUYMe9aaGOJU1JPx8eSJV53iYDMOj95rFP9XDeW8J9WVlJdi5Mj
	JZN+fwvW0otZICftZFpkOUMxGU2o8Nr8h8At0XBrybkm14vJohdsLTkXkpVrSotUk4t1shSHJMw
	FUrQjoVepx+/6n0gdlj+D0NvqbxGBsKE5BtUBXnL+oZtBgGb3z+SmN4szBQuzPmysLQdrHsw0X+
	jo7YFXE/p3gN5qJ1Uo87TWGUzEs8JAP4ddl4WOlC3Gd/91PkLmT8AsCgPRNRBd7S20pJ86DlOrm
	hr6wZt2HlqC7CQ4D9LTwZNLPKg0Ns60o4ctEPBlmiqdyYC1w==
X-Received: by 2002:a05:6000:3106:b0:43d:300b:2285 with SMTP id ffacd0b85a97d-4515b524457mr6633850f8f.11.1778078628705;
        Wed, 06 May 2026 07:43:48 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([185.194.185.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960fd6sm13732451f8f.31.2026.05.06.07.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:43:47 -0700 (PDT)
Date: Wed, 6 May 2026 15:43:35 +0100
From: Gregory Price <gourry@gourry.net>
To: Alejandro Lucero Palau <alucerop@amd.com>
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
Message-ID: <aftTlyHYNr0B9yL3@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <b704b05e-3e65-4a73-84c0-21557b0cc38f@amd.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b704b05e-3e65-4a73-84c0-21557b0cc38f@amd.com>

On Wed, Feb 25, 2026 at 12:40:09PM +0000, Alejandro Lucero Palau wrote:
> 
> I can see the nid param is just a "preferred nid" with alloc pages. Using
> __GFP_PRIVATE will restrict the allocation to private nodes but I think the
> idea here is:
> 
> 
> 1) I own this node
> 
> 2) Do not give me memory from another private node but from mine.
> 
> 

I mildly mis-read this question, apologies.

Multiple private nodes in the nodemask are ignored, because the nodemask
is a filter function for the fallback lists - and private nodes never
show up in the fallback lists (except for their own).

So for example

Nodes:  Normal(A,B), Private(C,D)

Fallback lists:
   A:   [A,B]
   B:   [B,A]
   C:   [C,A,B]
   D:   [D,B,A]

            combination                       |  possible result
----------------------------------------------------------------
__GFP_PRIVATE + pref_node(C) + nodemask(NULL) = (C or A or B)
__GFP_PRIVATE + pref_node(C) + nodemask(C,D)  = C
GFP_PRIVATE + pref_node(C) + nodemask(ALL)    = C

Basically private nodes are completely ignored in the nodemask, so you
cannot do fallback allocations to other private nodes.

There is no good abstraction (that I have found) to communicate
multi-private-node allocations simply because this would imply needing
private nodes to be in the fallback lists for other nodes.

Maybe there is a possibility of modifying fallback lists explicitly, but
I think that is out of scope for the first implementation.

~Gregory
