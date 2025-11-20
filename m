Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34B83074B1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Nov 2025 13:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763643690; cv=none; b=TuwlU3Eci7skY4SDrRzEJZ3WfA4GU9Igsu/9HFPIyfh16FIK3hoe38qizhlRVt0ePy7MQelAjRxri+XsK/B2TBoy1lnkhQGHyzQGeSaLynEOaeF16JMwES+wBEjv5kU5m78xMY9BxWP3UNxA2e/HGjHqHCdae6P6qAGMcIAEWrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763643690; c=relaxed/simple;
	bh=Ftl+qpQGrT5RpptKkItPeER581J88Xp+vWYHK5zRZgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghuF6M8OU6xXUKKZdwWjGcxCYsfeSUgdrwedzbV3TXyP2WxXdRbA17QQ9BjIlqy97GOYWAPYU6iFLQb6FGXAu4WRoOfL6phZoJB7RFCXqzYA8QIwk04nn1Qe5kj9xG0DcKiTaHV9crM7maKGik+d0ymbH912VBP0iEww3NC+bms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=usJJd61n; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="usJJd61n"
Message-ID: <f4652d26-a0f0-4ffe-ad53-74a3418c75e1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763643685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Appw5O9xn9vKWf0A+16v30yLtvA63IpanK+xECauBoM=;
	b=usJJd61nfgOrgJv9VkEZ3PMKtrtJaJEjNlVH8RWyyQmyKQb+9SiV7pZ0w1OZPZ1n9HBCc9
	xoFEYp8owtU2QvVmNzWY2cX9h/gQJ517YAyli+xGAvQDmkG+LAEU3kpCek5pkniDCNt3vG
	saFS6TwzqYvcFwtasFMFWmyOzqAjkI0=
Date: Thu, 20 Nov 2025 21:01:11 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH V2 1/2] mm/khugepaged: do synchronous writeback for
 MADV_COLLAPSE
Content-Language: en-US
To: Shivank Garg <shivankg@amd.com>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, David Hildenbrand <david@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Branden Moore <Branden.Moore@amd.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
References: <20251120065043.41738-6-shivankg@amd.com>
 <20251120065043.41738-8-shivankg@amd.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251120065043.41738-8-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/20 14:50, Shivank Garg wrote:
> When MADV_COLLAPSE is called on file-backed mappings (e.g., executable
> text sections), the pages may still be dirty from recent writes and
> cause collapse to fail with -EINVAL. This is particularly problematic
> for freshly copied executables on filesystems, where page cache folios
> remain dirty until background writeback completes.
> 
> The current code in collapse_file() triggers async writeback via
> filemap_flush() and expects khugepaged to revisit the page later.
> However, MADV_COLLAPSE is a synchronous operation where userspace
> expects immediate results.
> 
> Perform synchronous writeback in madvise_collapse() before attempting
> collapse to avoid failing on first attempt.

Thanks!

> 
> Reported-by: Branden Moore <Branden.Moore@amd.com>
> Closes: https://lore.kernel.org/all/4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com
> Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
> Suggested-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>   mm/khugepaged.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 97d1b2824386..066a332c76ad 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -22,6 +22,7 @@
>   #include <linux/dax.h>
>   #include <linux/ksm.h>
>   #include <linux/pgalloc.h>
> +#include <linux/backing-dev.h>
>   
>   #include <asm/tlb.h>
>   #include "internal.h"
> @@ -2784,6 +2785,31 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>   	hstart = (start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
>   	hend = end & HPAGE_PMD_MASK;
>   
> +	/*
> +	 * For file-backed VMAs, perform synchronous writeback to ensure
> +	 * dirty folios are flushed before attempting collapse. This avoids
> +	 * failing on the first attempt when freshly-written executable text
> +	 * is still dirty in the page cache.
> +	 */
> +	if (!vma_is_anonymous(vma) && vma->vm_file) {
> +		struct address_space *mapping = vma->vm_file->f_mapping;
> +
> +		if (mapping_can_writeback(mapping)) {
> +			pgoff_t pgoff_start = linear_page_index(vma, hstart);
> +			pgoff_t pgoff_end = linear_page_index(vma, hend);
> +			loff_t lstart = (loff_t)pgoff_start << PAGE_SHIFT;
> +			loff_t lend = ((loff_t)pgoff_end << PAGE_SHIFT) - 1;

It looks like we need to hold a reference to the file here before
dropping the mmap lock :)

			file = get_file(vma->vm_file);

Without it, the vma could be destroyed by a concurrent munmap() while
we are waiting in filemap_write_and_wait_range(), leading to a UAF
on mapping, IIUC ...

> +
> +			mmap_read_unlock(mm);
> +			mmap_locked = false;
> +
> +			if (filemap_write_and_wait_range(mapping, lstart, lend)) {

And drop the reference :)

				fput(file);


> +				last_fail = SCAN_FAIL;
> +				goto out_maybelock;
> +			}

Same here :)

			fput(file);


> +		}
> +	}
> +
>   	for (addr = hstart; addr < hend; addr += HPAGE_PMD_SIZE) {
>   		int result = SCAN_FAIL;
>   

Cheers,
Lance
