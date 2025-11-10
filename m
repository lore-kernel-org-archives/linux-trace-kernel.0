Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF3523C516;
	Mon, 10 Nov 2025 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781110; cv=none; b=iL1w0wl5/6T+Iq3jumm8snHUpYbydPCUxgcENSyRJPuQcMjPGWF/BTRGCXv9IMgRgRDirjtLK4Cc8G/CVH6M+gLGMyj2evX7p/maRssyud0QSCeumx5ar1CXqTxqH6EYSvCmGLiAqB3ozwi7FY8+4zFf92i0I8xGmu2ITEtKtNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781110; c=relaxed/simple;
	bh=KgVBkMXWtTRD5CdPecRsv2QlZ+DcPeksW4yC29jCPuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XvH4TAn3oRpOMrqhr3h/nvYt6kVKYouAbm6Xcmx444/nvH/35wxVnt7R3bvzDMPc3ylwWgsn3iGE+Kwi/fYiG3FoZ7t4yFfpIVMx09tY2QeLUPYOFRk1Y1J2BVNQPyLM8ieJ00yCeqLywJcQfkbON40rBIhEh+aYk5aWTE6Yk98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5247497;
	Mon, 10 Nov 2025 05:24:58 -0800 (PST)
Received: from [10.164.136.34] (Mac.blr.arm.com [10.164.136.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E21ED3F63F;
	Mon, 10 Nov 2025 05:25:00 -0800 (PST)
Message-ID: <3f5f8a48-fa3b-4985-95e1-dd0ac21b5dcc@arm.com>
Date: Mon, 10 Nov 2025 18:54:57 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/khugepaged: do synchronous writeback for
 MADV_COLLAPSE
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Shivank Garg <shivankg@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Branden Moore <Branden.Moore@amd.com>
References: <20251110113254.77822-1-shivankg@amd.com>
 <f21b37bb-7a2b-412b-be76-e8968b4c375d@lucifer.local>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <f21b37bb-7a2b-412b-be76-e8968b4c375d@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/11/25 5:31 pm, Lorenzo Stoakes wrote:
> On Mon, Nov 10, 2025 at 11:32:53AM +0000, Shivank Garg wrote:
>> When MADV_COLLAPSE is called on file-backed mappings (e.g., executable
>> text sections), the pages may still be dirty from recent writes. The
>> current code triggers an async flush via filemap_flush() and returns
>> SCAN_FAIL, requiring userspace to retry the operation.
>>
>> This is problematic for userspace that wants to collapse text pages into
>> THPs to reduce ITLB pressure. The first madvise() call always fails with
>> EINVAL, and only subsequent calls succeed after writeback completes.
>>
>> For direct MADV_COLLAPSE calls (!cc->is_khugepaged), perform a synchronous
>> writeback using filemap_write_and_wait_range() before scanning the folios.
>> This ensures that folios are clean on the first attempt.
>>
>> Reported-by: Branden Moore <Branden.Moore@amd.com>
>> Closes: https://lore.kernel.org/all/4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com
>> Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>> ---
>> Applies cleanly on:
>> 6.18-rc5
>> mm-stable:e9a6fb0bc
> Please base on mm-unstable. mm-stable is usually out of date until very close to
> merge window.
>
>>
>>   mm/khugepaged.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index abe54f0043c7..d08ed6eb9ce1 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/shmem_fs.h>
>>   #include <linux/dax.h>
>>   #include <linux/ksm.h>
>> +#include <linux/backing-dev.h>
>>
>>   #include <asm/tlb.h>
>>   #include <asm/pgalloc.h>
>> @@ -1845,6 +1846,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>>   	struct page *dst;
>>   	struct folio *folio, *tmp, *new_folio;
>>   	pgoff_t index = 0, end = start + HPAGE_PMD_NR;
>> +	loff_t range_start, range_end;
>>   	LIST_HEAD(pagelist);
>>   	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
>>   	int nr_none = 0, result = SCAN_SUCCEED;
>> @@ -1853,6 +1855,21 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>>   	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
>>   	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
>>
>> +	/*
>> +	 * For MADV_COLLAPSE on regular files, do a synchronous writeback
>> +	 * to ensure dirty folios are flushed before we attempt collapse.
>> +	 * This is a best-effort approach to avoid failing on the first
>> +	 * attempt when freshly-written executable text is still dirty.
>> +	 */
>> +	if (!is_shmem && cc && !cc->is_khugepaged && mapping_can_writeback(mapping)) {
>> +		range_start = (loff_t)start << PAGE_SHIFT;
>> +		range_end = ((loff_t)end << PAGE_SHIFT) - 1;
>> +		if (filemap_write_and_wait_range(mapping, range_start, range_end)) {
>> +			result = SCAN_FAIL;
>> +			goto out;
>> +		}
>> +	}
> I feel this is the wrong level of abstraction.
>
> We explicitly invoke this oth from khugepaged and madvise(..., MADV_COLLAPSE):
>
>
> khugepaged_scan_mm_slot() / madvise_collapse()
> -> hpage_collapse_scan_file()
> -> collapse_file()
>
> ofc you are addressing this with the !cc->is_khugepaged, but feels like we'd be
> better off just doing it in madvise_collapse().

I suppose the common case is that writeback is not needed, and I don't know what
is the overhead of filemap_write_and_wait_range() in that case, but your
suggestion will force that unconditional overhead and skip all the early exits
possible in hpage_collapse_scan_file()?

> I wonder also if doing I/O without getting the mmap lock again and revalidating
> is wise, as the state of things might have changed significantly.
>
> So maybe need a hugepage_vma_revalidate() as well?

The file collapse path (apart from collapse_pte_mapped_thp) is solely concerned
about doing the collapse in the page cache, for which information about the mm or
the vma is not needed, that is why no locking is required. The get_file() in
khugepaged_scan_mm_slot() seems to be serving the same function as maybe_unlock_mmap_for_io().
So I don't think this is needed?

>
>
>> +
>>   	result = alloc_charge_folio(&new_folio, mm, cc);
>>   	if (result != SCAN_SUCCEED)
>>   		goto out;
>>
>> base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
>> --
>> 2.43.0
>>
> Thanks, Lorenzo
