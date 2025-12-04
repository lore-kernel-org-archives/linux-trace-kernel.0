Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5885FBA3F
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Dec 2025 06:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764831256; cv=none; b=GL7sEzaRkvkogTUkMU1X7epjIlxaWzWOa+ztXDMkvwp8ymp/0scShQ8Ssdp1jaPN5NcYW++mgdxgPdScrKQvxje3IXV55NZ4yq1mO2M0s5EkGvhdJPgKGpUrqNmOvpmjt4aVIN66edtbJjHn7HoHMqa94I31Ol5Wn8YKxSF0Y4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764831256; c=relaxed/simple;
	bh=tRBVklhxxOTXOTIgNwsBOMaGwNDHSLCZ5nl/Qhdc7Bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GecxUZ00kiJQaKjoPB5HiTaJ4COBmuJB5S7+Y9bfvJH9BFzXoG+trrNI53Y8b3QZVWGtlBKFinIRYmdlT/V4tSivacBFReiTfB4kQ/Drd6Qep+RRH+oKrxOaeLCXj5VKpHYo55ghoL/m5Vp/NjgjJBqYM+Em/XwFHoUQU1CPNYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SADPPVIe; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SADPPVIe"
Message-ID: <c20c2b82-cb43-4ecb-b48a-c19b8dbf5c3b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764831250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFoVMIVhgIIxPNZ4zkeUCbud6dwogH4VwdPLXp1GrzU=;
	b=SADPPVIePzv0Ee5PfeaBSq3VtAbpWjbIpKl8jabC5a3qqjXFLo12bef844hS+SeIomC5Mt
	9IzRLVCwAE+q0zXGn3Uv6sK8R01F/InIzR8xext9zmIoFgzKSlpZSGDRcgMs3V/Nqzdz20
	bvQHk81ffhC57S91A82jS+sudPokp2Y=
Date: Thu, 4 Dec 2025 14:53:59 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH V3 2/2] mm/khugepaged: retry with sync writeback for
 MADV_COLLAPSE
To: "Garg, Shivank" <shivankg@amd.com>
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
 <a8cf9fd2-4521-4068-b436-9a251a6eb15b@linux.dev>
 <26e51398-02e1-4ca7-80f0-0cd76a966188@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <26e51398-02e1-4ca7-80f0-0cd76a966188@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/12/4 02:25, Garg, Shivank wrote:
> 
> 
> On 12/2/2025 10:20 AM, Lance Yang wrote:
>>
>>
>> On 2025/12/2 02:56, Shivank Garg wrote:
>>> When MADV_COLLAPSE is called on file-backed mappings (e.g., executable
>>> text sections), the pages may still be dirty from recent writes.
>>> collapse_file() will trigger async writeback and fail with
>>> SCAN_PAGE_DIRTY_OR_WRITEBACK (-EAGAIN).
>>>
>>> MADV_COLLAPSE is a synchronous operation where userspace expects
>>> immediate results. If the collapse fails due to dirty pages, perform
>>> synchronous writeback on the specific range and retry once.
>>>
>>> This avoids spurious failures for freshly written executables while
>>> avoiding unnecessary synchronous I/O for mappings that are already clean.
>>>
>>> Reported-by: Branden Moore <Branden.Moore@amd.com>
>>> Closes: https://lore.kernel.org/all/4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com
>>> Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
>>> Suggested-by: David Hildenbrand <david@kernel.org>
>>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>>> ---
>>>    mm/khugepaged.c | 41 +++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 41 insertions(+)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index 219dfa2e523c..7a12e9ef30b4 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -22,6 +22,7 @@
>>>    #include <linux/dax.h>
>>>    #include <linux/ksm.h>
>>>    #include <linux/pgalloc.h>
>>> +#include <linux/backing-dev.h>
>>>      #include <asm/tlb.h>
>>>    #include "internal.h"
>>> @@ -2787,9 +2788,11 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>>>        hend = end & HPAGE_PMD_MASK;
>>>          for (addr = hstart; addr < hend; addr += HPAGE_PMD_SIZE) {
>>> +        bool retried = false;
>>>            int result = SCAN_FAIL;
>>>              if (!mmap_locked) {
>>> +retry:
>>>                cond_resched();
>>>                mmap_read_lock(mm);
>>>                mmap_locked = true;
>>> @@ -2819,6 +2822,44 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>>>            if (!mmap_locked)
>>>                *lock_dropped = true;
>>>    +        /*
>>> +         * If the file-backed VMA has dirty pages, the scan triggers
>>> +         * async writeback and returns SCAN_PAGE_DIRTY_OR_WRITEBACK.
>>> +         * Since MADV_COLLAPSE is sync, we force sync writeback and
>>> +         * retry once.
>>> +         */
>>> +        if (result == SCAN_PAGE_DIRTY_OR_WRITEBACK && !retried) {
>>> +            /*
>>> +             * File scan drops the lock. We must re-acquire it to
>>> +             * safely inspect the VMA and hold the file reference.
>>> +             */
>>> +            if (!mmap_locked) {
>>> +                cond_resched();
>>> +                mmap_read_lock(mm);
>>> +                mmap_locked = true;
>>> +                result = hugepage_vma_revalidate(mm, addr, false, &vma, cc);
>>> +                if (result != SCAN_SUCCEED)
>>> +                    goto handle_result;
>>> +            }
>>> +
>>> +            if (!vma_is_anonymous(vma) && vma->vm_file &&
>>> +                mapping_can_writeback(vma->vm_file->f_mapping)) {
>>> +                struct file *file = get_file(vma->vm_file);
>>> +                pgoff_t pgoff = linear_page_index(vma, addr);
>>> +                loff_t lstart = (loff_t)pgoff << PAGE_SHIFT;
>>> +                loff_t lend = lstart + HPAGE_PMD_SIZE - 1;
>>> +
>>> +                mmap_read_unlock(mm);
>>> +                mmap_locked = false;
>>> +                *lock_dropped = true;
>>> +                filemap_write_and_wait_range(file->f_mapping, lstart, lend);
>>> +                fput(file);
>>> +                retried = true;
>>> +                goto retry;
>>> +            }
>>> +        }
>>> +
>>> +
>>
>> Nit: spurious blank line.
> 
> Ah, I completely missed this. I’ll fix it in the next version.
> Hope the rest of the patch looks reasonable. Thanks for the review.

Apart from that nit, nothing else jumped out at me :)

Confirmed that the spurious EINVAL is gone, and it works as expected ;p

Tested-by: Lance Yang <lance.yang@linux.dev>

[...]

Cheers,
Lance
