Received: from mta1.migadu.com (out-32.mta1.migadu.com [95.215.58.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F1A3A6F0B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560086; cv=none; b=LBdueEAc9CbBgLtBK5Xes7qgc23ivHtq2QarFAKQsr+NhBpdQV/fWSm0wvu2uyGjZ3ZLuXRdyIh6Pix0uqBxc1qvp7HpHyaovWjJ/thDkB3sCyaiEsHfBn8fyBEBqQ5gW67634aI+ZV+QsNmVYGzkNpoWKe3Z9fgk4B7gcisU0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560086; c=relaxed/simple;
	bh=8Pl7rmcIvwX+tzegpkwJKg5akKbpn9WU8gbrZ1f0X8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trmSpn9kPkr9LNL+iSOhoTz8O7Pd4OZBeF/9TbCb1CqpXRzRtBcFIi3PCQCJKRMNxvW6dqpv9jX1vWgPSnwGeC3rfL67qJSKR6l3/1/5isW3xdFfpcwa1j5Ef2YD5ug0ae/ObrC4iQG00Bm8EoQSleQsSNyqhJHOqT6Uikkfu1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LjJ6LwxO; arc=none smtp.client-ip=95.215.58.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LjJ6LwxO"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8Pl7rmcIvwX+tzegpkwJKg5akKbpn9WU8gbrZ1f0X8M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787560081; v=1; x=1788164881;
 b=LjJ6LwxO2XPMd9oUysjq8G0CYOWF4VzDt09U8RGs0WH8lFAhfhCHNMnUTeQ9JE83869mX1TK
 EWbZLkG1UPpibY/1ZklwKooBXY18Nt44P586BiTfw2lnPLEfxfMBS2E71xXXxoPUwK4t3VHGXSd
 huWKoKD2Z72W8xJ1K0wdXGvU=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from [10.244.244.3] (2602:fce1:44f:115e::)
	by smtp.migadu.com with ESMTPS id 8e0a79e38506ea9a;
	Mon, 24 Aug 2026 08:28:00 +0000
X-Mizu-Trace-ID: 8e0a79e38506ea9a
X-Migadu-Flow: FLOW_OUT
Message-ID: <cff17006-b534-440a-8be7-651fb0a940cd@linux.dev>
Date: Mon, 24 Aug 2026 16:27:39 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] userfaultfd: collapse VM_UFFD_{MISSING,WP,MINOR,RWP}
 into single VM_UFFD
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org,
 baolin.wang@linux.alibaba.com, baohua@kernel.org, dev.jain@arm.com,
 hughd@google.com, jannh@google.com, jgg@ziepe.ca, jhubbard@nvidia.com,
 corbet@lwn.net, liam@infradead.org, ljs@kernel.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, mhocko@suse.com, muchun.song@linux.dev,
 nico.pache@linux.dev, osalvador@suse.de, pfalcato@suse.de,
 peterx@redhat.com, ryan.roberts@arm.com, shakeel.butt@linux.dev,
 skhan@linuxfoundation.org, rostedt@goodmis.org, surenb@google.com,
 usama.arif@linux.dev, vbabka@kernel.org, ziy@nvidia.com,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
References: <20260823-uffd-vm-flags-v1-v1-6-3086981b33cf@kernel.org>
 <20260824071126.41979-1-lance.yang@linux.dev> <aov9_DIHLHynm7tN@kernel.org>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <aov9_DIHLHynm7tN@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/8/24 16:17, Mike Rapoport wrote:
> Hi Lance,
> 
> On Mon, Aug 24, 2026 at 03:11:26PM +0800, Lance Yang wrote:
>>
>> On Sun, Aug 23, 2026 at 03:17:43PM +0300, Mike Rapoport (Microsoft) wrote:
>> [...]
>>> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
>>> index 83587d34b189..193f6e65d875 100644
>>> --- a/mm/userfaultfd.c
>>> +++ b/mm/userfaultfd.c
>>> @@ -50,10 +50,10 @@ struct mfill_state {
>>> 	pmd_t *pmd;
>>> };
>>>
>>> -static bool anon_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags)
>>> +static bool anon_can_userfault(struct vm_area_struct *vma, unsigned int mode)
>>> {
>>> 	/* anonymous memory does not support MINOR mode */
>>> -	if (vm_flags & VM_UFFD_MINOR)
>>> +	if (mode & UFFD_MODE_MINOR)
>>> 		return false;
>>> 	return true;
>>> }
>>> @@ -462,7 +462,7 @@ static int mfill_copy_folio_locked(struct folio *folio, unsigned long src_addr)
>>> }
>>>
>>> #define MFILL_RETRY_STATE_VMA_FLAGS \
>>> -	append_vma_flags(__VMA_UFFD_FLAGS, VMA_SHARED_BIT)
>>> +	append_vma_flags(VMA_UFFD, VMA_SHARED_BIT)
>>
>> Looks like this drops registration mode from the retry snapshot. Assume a
>> shared shmem VMA is registered for MISSING and COPY reaches
>> mfill_copy_folio_retry(). While locks are dropped, the same userfaultfd|
>> can re-register the range for MINOR. VMA_UFFD, VM_SHARED, ops, file and
>> pgoff all stay unchanged, so the old COPY can continue instead of
>> returning -EAGAIN ... no?
> 
> Good catch, thanks!

Cheers!

>   
>> Maybe something like this?
> 
> I prefer to add mode to the retry_state:
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 193f6e65d875..a0377f7ecc69 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -471,6 +471,7 @@ static int mfill_copy_folio_locked(struct folio *folio, unsigned long src_addr)
>    */
>   struct mfill_retry_state {
>   	const struct vm_uffd_ops *ops;
> +	unsigned long mode;
>   	struct file *file;
>   	vma_flags_t flags;
>   	pgoff_t pgoff;
> @@ -482,6 +483,7 @@ static void mfill_retry_state_save(struct mfill_retry_state *s,
>   	s->flags = vma_flags_and_mask(&vma->flags, MFILL_RETRY_STATE_VMA_FLAGS);
>   	s->ops = vma_uffd_ops(vma);
>   	s->pgoff = vma_start_pgoff(vma);
> +	s->mode = uffd_mode(vma);
>   
>   	if (vma->vm_file)
>   		s->file = get_file(vma->vm_file);
> @@ -493,8 +495,9 @@ static bool mfill_retry_state_changed(struct mfill_retry_state *state,
>   	vma_flags_t flags = vma_flags_and_mask(&vma->flags,
>   					       MFILL_RETRY_STATE_VMA_FLAGS);
>   
> -	/* Have any UFFD flags (missing, WP, minor) changed? */
> -	if (!vma_flags_same_pair(&state->flags, &flags))
> +	/* UFFD registration mode or VMA sharing changed */
> +	if (!vma_flags_same_pair(&state->flags, &flags) ||
> +	    s->mode != uffd_mode(vma))

I assume you meant

s/s->mode/state->mode/

With that, LGTM :)

>   		return true;
>   
>   	/* VMA type or effective uffd_ops changed while the lock was dropped */
>   
>> Cheers, Lance
>

Cheers, Lance
