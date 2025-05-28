Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95354268C5D;
	Wed, 28 May 2025 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748435964; cv=none; b=OcdpfxFGNp8A5D/pKMxfq3+pKdTqRs0uxs23rTWc4bmLrJwg+MAEvzzqaGnavWQ07++2FW5g+5f+uLcPtRe7w8ar4q2c7FEWe17DghB+ELVlDZC+jHx+5et6WBf8t9akltN70M/jNclab+A1KFd3iGY9xEGoXUC9y1mUINozA7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748435964; c=relaxed/simple;
	bh=SZRvMbdu3wATDJKn6o28yDXSyhutEhb2/FkYHiV/SkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C23yh0AxrlzFW8R7wPBE7GcEImEWHcq93ufALs1xmvEBoiR6d6k1IVnzs+5I7vWqkzi17UhUR9Ww2UgzL8ZYhkyn0Qvy01lWsICFo3wV165y75352DcHkvuaFDzagQMWUZVyjDA/w/4laAWWphkOadinYSZwIfwdHrdkfsUzC80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DAjFohPM; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DAjFohPM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748435956; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aVWN/MKmTQqqGKE7GEueaj4Por9dh45wCyBCzff0Izg=;
	b=DAjFohPMPfziz+CPqLGjrrMaCadeDulKisLUn2hGkCiK+tX2g24nL7e6xvrz4DrwWSS0tCmKCzTiRxEzAl/Uimuk7I0HBh+rPP+q4oXhoU5UO/Iazkl0eE0Q3odBaraym1+b7LKocr9qpUgFSC6sPVeiHasiu+aaq4/gLvcLXSc=
Received: from 30.15.230.171(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WcDSnsn_1748435951 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 May 2025 20:39:12 +0800
Message-ID: <a956379a-7472-4972-bf3d-fe2b2b6715b5@linux.alibaba.com>
Date: Wed, 28 May 2025 20:39:10 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/12] khugepaged: mTHP support
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org
References: <20250515032226.128900-1-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250515032226.128900-1-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/5/15 11:22, Nico Pache wrote:
> The following series provides khugepaged and madvise collapse with the
> capability to collapse anonymous memory regions to mTHPs.
> 
> To achieve this we generalize the khugepaged functions to no longer depend
> on PMD_ORDER. Then during the PMD scan, we keep track of chunks of pages
> (defined by KHUGEPAGED_MTHP_MIN_ORDER) that are utilized. This info is
> tracked using a bitmap. After the PMD scan is done, we do binary recursion
> on the bitmap to find the optimal mTHP sizes for the PMD range. The
> restriction on max_ptes_none is removed during the scan, to make sure we
> account for the whole PMD range. When no mTHP size is enabled, the legacy
> behavior of khugepaged is maintained. max_ptes_none will be scaled by the
> attempted collapse order to determine how full a THP must be to be
> eligible. If a mTHP collapse is attempted, but contains swapped out, or
> shared pages, we dont perform the collapse.
> 
> With the default max_ptes_none=511, the code should keep its most of its
> original behavior. To exercise mTHP collapse we need to set
> max_ptes_none<=255. With max_ptes_none > HPAGE_PMD_NR/2 you will
> experience collapse "creep" and constantly promote mTHPs to the next
> available size. This is due the fact that it will introduce at least 2x
> the number of pages, and on a future scan will satisfy that condition once
> again.
> 
> Patch 1:     Refactor/rename hpage_collapse
> Patch 2:     Some refactoring to combine madvise_collapse and khugepaged
> Patch 3-5:   Generalize khugepaged functions for arbitrary orders
> Patch 6-9:   The mTHP patches
> Patch 10-11: Tracing/stats
> Patch 12:    Documentation

When I tested 64K mTHP collapse and disabled PMD-sized THP, I found that 
khugepaged couldn't scan and collapse 64K mTHP. I send out two fix 
patches[1], and with these patches applied, 64K mTHP collapse works 
well. I hope my two patches can be folded into your next version series 
if you think there are no issues. Thanks.

[1] 
https://lore.kernel.org/all/ac9ed6d71b439611f9c94b3506a8ce975d4636e9.1748435162.git.baolin.wang@linux.alibaba.com/
