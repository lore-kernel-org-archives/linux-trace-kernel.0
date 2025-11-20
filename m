Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253C130B51B;
	Thu, 20 Nov 2025 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645739; cv=none; b=UMeBjg67jpcs2cqIj6HL89N5Cw+eW/C3mHAxdy0zxpqV29TKdtC7FArwoNwBnAbFHN7Ej1BUsJdb09P+SxO1AAWFfgaop8jizqJt/BAAV0ZIpuiez7CLT5LVOObB0UMAZKEKJwnGq6SG6LtGGCokkoatb5u0PM1bY8zXVKAc9pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645739; c=relaxed/simple;
	bh=7fOQWOlDa/yWJfdxMP4b/quIC4jTVVkZpbyue8xkZUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhgUpMzX6lH7rBlO96OWcVcEa5M4u2TzLtzBg9zqWAUoI6nP5xVTBAbK6Rhtdd+QbN3eQ9MDm7tuVd8NZixc05FvRYzg6QEje1cQ+N+tplJpovvXsC83xV/IJQI9mJ1lGG4APDjpKERFET4k7qRT76OGkQk/Flw1/lGc2teCKFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knQ3E4Fj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knQ3E4Fj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A494EC4CEF1;
	Thu, 20 Nov 2025 13:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763645738;
	bh=7fOQWOlDa/yWJfdxMP4b/quIC4jTVVkZpbyue8xkZUo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=knQ3E4FjFLvlIBk5Vj1nqlfGxz6LM/OkrjtqrPhjawaq7swVpXiOv9gqhzHsVnJtx
	 0r5rujNQ2NvwVHZtqa6cb6ArDqIpyu9xNFcTjiAMSz6JgiXjs8hCzI/NhtGgcgvey0
	 4Ge6vzXaavWScRr7gtsJaU62ZrwGvN92xjuLy1zu/4vkZ9P2fGj0KDl8P879JL0yR7
	 vBBXjPeN0N1hUdp47kYlDr5kul04dWk2cIwmWqC3ujfwrRkdkygdxlDuBO829RYEsN
	 xe85Pf3Qpykdreik1mg2SvxHeGVikch5HSlNNWMSUGPpwQW5hNYDpERSaWsMP5b9Pm
	 SBXqTwTvzRVUw==
Message-ID: <be698a14-c292-42d1-9a85-109a9072a0b2@kernel.org>
Date: Thu, 20 Nov 2025 14:35:32 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] mm/khugepaged: do synchronous writeback for
 MADV_COLLAPSE
To: Shivank Garg <shivankg@amd.com>, Andrew Morton
 <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Branden Moore <Branden.Moore@amd.com>
References: <20251120065043.41738-6-shivankg@amd.com>
 <20251120065043.41738-8-shivankg@amd.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251120065043.41738-8-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/25 07:50, Shivank Garg wrote:
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
> +

Hm, so we always do that, without any indication that there actually is 
something dirty there.

Internally filemap_write_and_wait_range() uses something called 
mapping_needs_writeback(), but it also applies to the complete file, not 
a range.

Wouldn't it be better do do that only if we detect that there is 
actually a dirty folio in the range?

That is, if we find any dirty folio in hpage_collapse_scan_file() and we 
are in madvise, do that dance here and retry?

-- 
Cheers

David
