Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07B4381AE3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486941; cv=none; b=XqhzerKyrUp5vokM/S7Os5oo/8+d/1Uj8EWH/gUBAGQ4KQQXz2Hw2/J2iHvabaZtn/mKdV1EDMVd6NXBbdQ5I8RoMeE6XZ8rcmB63R2+/lpYtlN9n5IPFvvQ7e+ARka95gz538x1Oh4UG+wCXZQVPFY/+y8LP+gPbZhAt+wCP8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486941; c=relaxed/simple;
	bh=3OYO2OiYtwBthWhyxo59K+FiM1KtEV3i++46RR5OLxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wm6HftW9EN6qWV+nd7vLWWFklZTc8quI1HCvp8CHJno+i/t+s3lWx0tZWvBuY0UvYehksapQCI2GZI2CDYvs3qphf6mTWgpOK0mJeVeKyl+9B5Q2PzgSYEjqE9mGSlDlDJiq54d5q/qa8S+VxbbBbL2CzjQZvqaWuV3KxcPNlCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U1Y+nWWl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1Y+nWWl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777486938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gY7VJIEyO/W3nZC3qbRdfDIZ/AzOw1XW+8RhXie+zvE=;
	b=U1Y+nWWlBVl6Ahe7CdidsOI2htWInblIJ5qbn/hQ4ifPfSJ0MY6zteYL+RAc0MygZEM7Lt
	n4iaAiDwMOaKj8Z2XETfGE/bM8NvfEqsQSekunNRNsghIUQrK6KWo8j0XLYaSbP67RDVNJ
	8eU5f0LHwF0a6YhjB9a7ChWbbrVTPnY=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-4LKcn0hXPjSAHRmjqxHyVA-1; Wed, 29 Apr 2026 14:22:15 -0400
X-MC-Unique: 4LKcn0hXPjSAHRmjqxHyVA-1
X-Mimecast-MFC-AGG-ID: 4LKcn0hXPjSAHRmjqxHyVA_1777486935
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-652f73f73cdso63024d50.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 11:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777486935; x=1778091735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gY7VJIEyO/W3nZC3qbRdfDIZ/AzOw1XW+8RhXie+zvE=;
        b=AG++VHU/BhvXPSPH5MXV0EkO5q5H84iNU3xTeGGXJI0G7UMVUaQoSvdci8pkPCmpdz
         muq4uT4NrW8ACgSauQ5Wqe/foc3Ar0OcEYoFaEhNerID5AXO/CPyAfCj34l2vOAfG8x0
         8lW5SBhHKAx6HJyDFynEypnnHQOSGHNi2XiKwXQSXMI2g85kJY0sLhxnWKKqlDwQi9fN
         IkrftMjC+7EEUQToUkVE17cmKAaG8+UX7N+CRSqddSkOkcGvsfaeNO3OVBPyNLNbB2mF
         coA5xDva79b73gR5xBF/0aY9Cg+gopUzm83hpqbnt3Ktmqj9FLud7e5iSJlsvm7ooDvT
         mcCw==
X-Forwarded-Encrypted: i=1; AFNElJ9rPVGVTB9UN/CTv+Odw/tBNRy2eNASVP9JXJyYYdAPmTTZ5WqxPkEzO+oao5aP7DeHUTcIPKkAhkJWVhqPC0A11KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoVksgcwx0XzxXaNhzYrz+T3IAUZ5Unxef41FqpwAi/e+Mb4X9
	gwX4TWsvBKxN9xj8/ouG4bhKO6lEyznEi6j8BxUEaNRqonOAEOPB/p3/nPH6T2+iMqAkztul1iA
	mJ+MtbcYQZ44BOvqx4fSIG6YvIlHRYQj61jEoA9+eldYNMgL4MHtFH3yciS+CBnpjSsllxnqb8V
	xmis2/g6EgECnIpUtay8ItyvYypXWZ4sIWNPVjHjNhSCqWwL01
X-Gm-Gg: AeBDieuzRQAAaKz5yIhXSfvh4B5PM49WZvF/khVixEvsUWasFva+TqL/VO1C86DcHKK
	q+Ph2qOmCR03B3teKEmnU/fIbQt+CQWGrAWrBCgeh2/qIWEqzHYNfNuE4jhwQL4I4vaPU3SylhX
	ZTymFdFcdnDVTmIarRSvBPjjmq2gZ0CHmslqI6+pdsExmNcz26XUImSocUtSzGpNq4ZRRbnKG1M
	uh+R7N0XZEdkxTNLtos4YXEXbQ85BPDXjKfCUudQCvr4R4QwhI=
X-Received: by 2002:a05:690e:4808:b0:653:1b1c:1df5 with SMTP id 956f58d0204a3-65bfb618207mr3992069d50.22.1777486934827;
        Wed, 29 Apr 2026 11:22:14 -0700 (PDT)
X-Received: by 2002:a05:690e:4808:b0:653:1b1c:1df5 with SMTP id
 956f58d0204a3-65bfb618207mr3992031d50.22.1777486934364; Wed, 29 Apr 2026
 11:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419185750.260784-1-npache@redhat.com> <20260419185750.260784-10-npache@redhat.com>
 <5564e170-d052-4445-9914-70bfd852d3b1@kernel.org>
In-Reply-To: <5564e170-d052-4445-9914-70bfd852d3b1@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Wed, 29 Apr 2026 12:22:21 -0600
X-Gm-Features: AVHnY4L3X4jVTb8LgOcxKjQeysiycYOCHFfdu1rzktXVmJtNDEVN92iFQ6rxy7s
Message-ID: <CAA1CXcAuD0EfrNro0VGupeMQTXMLzutfQAdP942YbQ0AJQA5_g@mail.gmail.com>
Subject: Re: [PATCH 7.2 v16 09/13] mm/khugepaged: introduce
 collapse_allowable_orders helper function
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, ljs@kernel.org
Cc: aarcange@redhat.com, akpm@linux-foundation.org, anshuman.khandual@arm.com, 
	apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com, 
	jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, 
	lance.yang@linux.dev, Liam.Howlett@oracle.com, mathieu.desnoyers@efficios.com, 
	matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, 
	peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com, 
	rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com, 
	rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q5v83d43vjPIXPiYttRsA4-jq00NlbIFpDjS75vaHKk_1777486935
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On 4/27/26 2:24 PM, David Hildenbrand (Arm) wrote:
> On 4/19/26 20:57, Nico Pache wrote:
>> Add collapse_allowable_orders() to generalize THP order eligibility. The
>> function determines which THP orders are permitted based on collapse
>> context (khugepaged vs madv_collapse).
>>
>> This consolidates collapse configuration logic and provides a clean
>> interface for future mTHP collapse support where the orders may be
>> different.
>>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> ---
>
>
> [...]
>
>>      cc = kmalloc_obj(*cc);
>> diff --git a/mm/vma.c b/mm/vma.c
>> index 377321b48734..c0398fb597b3 100644
>> --- a/mm/vma.c
>> +++ b/mm/vma.c
>> @@ -989,7 +989,7 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
>>              goto abort;
>>
>>      vma_set_flags_mask(vmg->target, sticky_flags);
>> -    khugepaged_enter_vma(vmg->target, vmg->vm_flags);
>> +    khugepaged_enter_vma(vmg->target);
>>      vmg->state = VMA_MERGE_SUCCESS;
>>      return vmg->target;
>>
>> @@ -1110,7 +1110,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
>>       * following VMA if we have VMAs on both sides.
>>       */
>>      if (vmg->target && !vma_expand(vmg)) {
>> -            khugepaged_enter_vma(vmg->target, vmg->vm_flags);
>> +            khugepaged_enter_vma(vmg->target);
>>              vmg->state = VMA_MERGE_SUCCESS;
>>              return vmg->target;
>>      }
>> @@ -2589,7 +2589,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
>>       * call covers the non-merge case.
>>       */
>>      if (!vma_is_anonymous(vma))
>> -            khugepaged_enter_vma(vma, map->vm_flags);
>> +            khugepaged_enter_vma(vma);
>>      *vmap = vma;
>
> Are you sure that in all cases, vma->vm_flags already corresponds to
> vmg->vm_flags / map->vm_flags?

I reviewed most of them and nothing stuck out, but I can go over them
again. Lorenzo may also have more insight into this as he is more
familiar and has been working on this stuff.

@lorenzo?

>
>
> That's a change that makes this patch unnecessary hard to follow, in particular,
> because it's not documented in the patch description.

Thats really weird I could have sworn I did update this description...
There was a lot of changes this round, so it was hard to keep track of
everything. Sorry.

>
> If you think the change is fine, you should better move that into a separate
> cleanup patch where you only drop the flags parameter from  khugepaged_enter_vma().

Yeah thats a better idea. Ill separate it out, thank you for the reviews :)

>

