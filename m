Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369972F5A3B
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 04:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764651026; cv=none; b=VU4nhRa+9tR/4DxTXcVFqyJGJ2et0H/8W2rnyCBj/Hh8ZjqNwjSIzvznM7Hn2rW52aMMhBOG9d6ls0Z/4KwJqHAh9/OsLh7PYx1s22v17xF+Ca79bNm8+TmM+DjOaTki35LJFMwWApetOUoR6f3TeZEzDNlV16XjgoWkMcWIUfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764651026; c=relaxed/simple;
	bh=k4H9fK6qG3Sv9HHzmLZL0QomcRdBJMDXXDfhZROR2cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1GWI08jE1PItCJRRxKBL422iyjND+NvpWtZakT72oaw0KqmlUOZ6ShZaXgKLsulFt3tJrOCFzy3eLhpWsP+J0EvD/l3h5cekPBkTSXhbXZ4UfhxT9q5j5YGweP3VTIwBJh9X7JtUOCUo7M2RDM/uIYJRAdGVZwHkWpmFzacnOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vhf4fPTv; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vhf4fPTv"
Message-ID: <a8cf9fd2-4521-4068-b436-9a251a6eb15b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764651021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGcwHsaLozazj4k3fLuhDAgiJq4CZqWj7W2bZnDVz00=;
	b=Vhf4fPTv9xrM0TVReTjEl9+EMYLp0tEVePWzanveohCdmTef90eIKFHknogXNKZ6Le/z0o
	I61Y4XwSd4fu3+0t7bqLxX3HSqN+jT8VusYx/USEQ34m668NGVbuciyZShZdeDO+u2yYS+
	H1D/xZ5EkUmxb/QqNVzS6uP7R+KOe2U=
Date: Tue, 2 Dec 2025 12:50:04 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH V3 2/2] mm/khugepaged: retry with sync writeback for
 MADV_COLLAPSE
To: Shivank Garg <shivankg@amd.com>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Barry Song
 <baohua@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zach O'Keefe <zokeefe@google.com>, David Hildenbrand <david@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Branden Moore <Branden.Moore@amd.com>
References: <20251201185604.210634-6-shivankg@amd.com>
 <20251201185604.210634-10-shivankg@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251201185604.210634-10-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/12/2 02:56, Shivank Garg wrote:
> When MADV_COLLAPSE is called on file-backed mappings (e.g., executable
> text sections), the pages may still be dirty from recent writes.
> collapse_file() will trigger async writeback and fail with
> SCAN_PAGE_DIRTY_OR_WRITEBACK (-EAGAIN).
> 
> MADV_COLLAPSE is a synchronous operation where userspace expects
> immediate results. If the collapse fails due to dirty pages, perform
> synchronous writeback on the specific range and retry once.
> 
> This avoids spurious failures for freshly written executables while
> avoiding unnecessary synchronous I/O for mappings that are already clean.
> 
> Reported-by: Branden Moore <Branden.Moore@amd.com>
> Closes: https://lore.kernel.org/all/4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com
> Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
> Suggested-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>   mm/khugepaged.c | 41 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 219dfa2e523c..7a12e9ef30b4 100644
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
> @@ -2787,9 +2788,11 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>   	hend = end & HPAGE_PMD_MASK;
>   
>   	for (addr = hstart; addr < hend; addr += HPAGE_PMD_SIZE) {
> +		bool retried = false;
>   		int result = SCAN_FAIL;
>   
>   		if (!mmap_locked) {
> +retry:
>   			cond_resched();
>   			mmap_read_lock(mm);
>   			mmap_locked = true;
> @@ -2819,6 +2822,44 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>   		if (!mmap_locked)
>   			*lock_dropped = true;
>   
> +		/*
> +		 * If the file-backed VMA has dirty pages, the scan triggers
> +		 * async writeback and returns SCAN_PAGE_DIRTY_OR_WRITEBACK.
> +		 * Since MADV_COLLAPSE is sync, we force sync writeback and
> +		 * retry once.
> +		 */
> +		if (result == SCAN_PAGE_DIRTY_OR_WRITEBACK && !retried) {
> +			/*
> +			 * File scan drops the lock. We must re-acquire it to
> +			 * safely inspect the VMA and hold the file reference.
> +			 */
> +			if (!mmap_locked) {
> +				cond_resched();
> +				mmap_read_lock(mm);
> +				mmap_locked = true;
> +				result = hugepage_vma_revalidate(mm, addr, false, &vma, cc);
> +				if (result != SCAN_SUCCEED)
> +					goto handle_result;
> +			}
> +
> +			if (!vma_is_anonymous(vma) && vma->vm_file &&
> +			    mapping_can_writeback(vma->vm_file->f_mapping)) {
> +				struct file *file = get_file(vma->vm_file);
> +				pgoff_t pgoff = linear_page_index(vma, addr);
> +				loff_t lstart = (loff_t)pgoff << PAGE_SHIFT;
> +				loff_t lend = lstart + HPAGE_PMD_SIZE - 1;
> +
> +				mmap_read_unlock(mm);
> +				mmap_locked = false;
> +				*lock_dropped = true;
> +				filemap_write_and_wait_range(file->f_mapping, lstart, lend);
> +				fput(file);
> +				retried = true;
> +				goto retry;
> +			}
> +		}
> +
> +

Nit: spurious blank line.

>   handle_result:
>   		switch (result) {
>   		case SCAN_SUCCEED:

