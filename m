Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185D1363C6E;
	Thu, 22 Jan 2026 11:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080082; cv=none; b=HqHVZKrp2W2HFaMeCDQqQ8rHKObchNfZRHQI4zETEvgG4mz9FATdJYA92UXTXi5wf50l/z9NSDbavD68/Paknn0pzgzB0uiMU2m0+zzf8zwj4b69lo5qpnfjMV7K5GcapSBFwLxOkW0zGf/FiiYalwo+XN/pE0sSKXz5Ph2/rXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080082; c=relaxed/simple;
	bh=hgpDkh2v8iqAT1V2jdsYmt94LE57iPmLaWXsiqgUzlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVleAJy1awOW4+6bdK9oSKhWwc7LA1NKSVeAlnIrRGL9PdhHFYxYgu/gQKDVWjEjIzLmr00UdXkroQEu+0i5ZhPhXjDGl8vkMdNdyfhojWh/ts+FcEPW82KfuwpxAQz3HwHRCj6c6eZCrEFErWvQ4pi4tlRYMtrJ5GAu1T9jBMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DF911476;
	Thu, 22 Jan 2026 03:07:52 -0800 (PST)
Received: from [10.164.18.63] (MacBook-Pro.blr.arm.com [10.164.18.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD5E93F632;
	Thu, 22 Jan 2026 03:07:53 -0800 (PST)
Message-ID: <3aaa3e5d-7f66-40fc-a5b0-ea6a384a88a8@arm.com>
Date: Thu, 22 Jan 2026 16:37:50 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 2/2] mm/khugepaged: retry with sync writeback for
 MADV_COLLAPSE
To: Shivank Garg <shivankg@amd.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Branden Moore <Branden.Moore@amd.com>
References: <20260118190939.8986-2-shivankg@amd.com>
 <20260118190939.8986-7-shivankg@amd.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20260118190939.8986-7-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 19/01/26 12:39 am, Shivank Garg wrote:
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
> Tested-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  mm/khugepaged.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 219dfa2e523c..16582bdcb6ff 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -22,6 +22,7 @@
>  #include <linux/dax.h>
>  #include <linux/ksm.h>
>  #include <linux/pgalloc.h>
> +#include <linux/backing-dev.h>
>  
>  #include <asm/tlb.h>
>  #include "internal.h"
> @@ -2788,7 +2789,9 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>  
>  	for (addr = hstart; addr < hend; addr += HPAGE_PMD_SIZE) {
>  		int result = SCAN_FAIL;
> +		bool triggered_wb = false;
>  
> +retry:
>  		if (!mmap_locked) {
>  			cond_resched();
>  			mmap_read_lock(mm);
> @@ -2809,8 +2812,20 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>  
>  			mmap_read_unlock(mm);
>  			mmap_locked = false;
> +			*lock_dropped = true;
>  			result = hpage_collapse_scan_file(mm, addr, file, pgoff,
>  							  cc);
> +
> +			if (result == SCAN_PAGE_DIRTY_OR_WRITEBACK && !triggered_wb &&
> +			    mapping_can_writeback(file->f_mapping)) {
> +				loff_t lstart = (loff_t)pgoff << PAGE_SHIFT;
> +				loff_t lend = lstart + HPAGE_PMD_SIZE - 1;
> +
> +				filemap_write_and_wait_range(file->f_mapping, lstart, lend);

So we don't care about the return value here because this is best-effort.
I really wish we had in our coding-style.rst to typecast such things to (void),
so we know explicitly that we are ignoring the return value, and not that the
function itself returns void.

Nothing jumps out at me,

Reviewed-by: Dev Jain <dev.jain@arm.com>

> +				triggered_wb = true;
> +				fput(file);
> +				goto retry;
> +			}
>  			fput(file);
>  		} else {
>  			result = hpage_collapse_scan_pmd(mm, vma, addr,
