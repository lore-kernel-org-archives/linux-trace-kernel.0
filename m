Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A0D3002B3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475531; cv=none; b=MyyEUOgwUSbyu/jDEdOITiIfhJBKw+Le1v3RG7tG6A9LkGqWoRrQI+ib5Iisv++x+EXkicsSGOlAUttDKJDIFI5iov+O116YjsjqmevN3PkEAXxWFQBpP+gmYchjdKThFoiqWOrb/4psPvkq27qlglY7NJdKAOMTfdY5LumWSxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475531; c=relaxed/simple;
	bh=+lpPzjQpVZqw2IwxWBU2dFkaVwLI04UBASsRDnxmpQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JvzWbvF71r8QKl8Q4D/09EWbapQSjRuZU5Kq6alhayirQlP3tDXY3c5H7VoiiHAiG9dap8kDBNhXE0JDXE5p3utKbZPN9MhA7PMwlhY2FQUCRMs3EzdknUqFZSKf80Z9xWDqVOfmeTpRUiuxqwOAdspZ6U+U2BYDNzMFwqS8ves=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xb0AmrT3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xb0AmrT3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777475528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MIFsdpU37KWnRnOSzyREX6cnqaju9TfHn4yZ6utUnI4=;
	b=Xb0AmrT3q3rxVLkl9yXgJjNEalsbfi9yZE61CJluMJbXZQ7WwNw/5IiM1p1W0FJGCz+X6X
	V84kcZHgx2OecR8nz6noD0roO0nRMNOLFJfM27/RUKkuaHY2iT5+Zoy1yHe1lIq9YGH5Q0
	Yh1m3/gduvGplFem+Dp1lOHau6atmcA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-KrbgFv1iNN-1CMF0JdhDFw-1; Wed, 29 Apr 2026 11:12:06 -0400
X-MC-Unique: KrbgFv1iNN-1CMF0JdhDFw-1
X-Mimecast-MFC-AGG-ID: KrbgFv1iNN-1CMF0JdhDFw_1777475525
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-39111be8447so27112251fa.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 08:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777475525; x=1778080325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIFsdpU37KWnRnOSzyREX6cnqaju9TfHn4yZ6utUnI4=;
        b=JXlS/7GIcdRUui6a4WXEuREVMfsNyNHP/4MheQTgP/jDesZgP3+UwYsVe3SBGEHzhs
         5CBDJ3Qzt0lFsw+88zoj1dGRdaJ7a4GcM2kKNpQpdPbKjtsEQx7Ue8Ggu0T/+ABqTew9
         1iEwvI/ZiCbXsv5Ku3OIQudZVaZ29aw3fH2gvx4Tf0WKvNXcdcjZy9tqZEaAT/2xcruo
         /ATo9dLXAgpKngTKW0gGHxQ5wQHjiC85v+lbYqTIPWHGBEvsXAhRSQaYYB6EJlMimSb/
         Unb2HN+lUtm0bufMFcpCVP38WLZNztUxSGK0SJN3K2n5knmmBJYvd/EcUeLUZMNcvryf
         NWfw==
X-Forwarded-Encrypted: i=1; AFNElJ+TvWC+a274/kTTXw5WCEMXVdrnL0heE0pwazNk9VgSEJzn19edtj6BQ42cvsJTPMCenm7N/W71niVJ8gdp7NHUkOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMw6hgv9n3Xct38bBDjNLyFtfsKR1whN/ExeBfiA6NqhCjDbAD
	nNdbGP71eQSqc9/xZjqZACggS60wBr041ldwMeKEqxOFGsD8VNfihCtn3LyTegXLh65AKfnQWv/
	kJ5JD742KqKaaN7sIVXDUVBwxWsx4dsFTyLOrelNTzlaSKVVfB7VC/XAP1PiOkvgUXqKC97rvgN
	qwtgKQ/N0Z+AxLUy6WuygJc3c+XnhQDVH11AWGhHSFFX59AGIF
X-Gm-Gg: AeBDiev4ipNFodiPrvEV83G7xOmNQWGBoDlIcohzEQClFrfh0JhiO2kIX/IsyCqM9bR
	btPVEhH+i06cVA9NK0uOp8AtFKLzg8Jq/rSwqnEDZzBLoZSNi0Ro35Hn/cBAuReVQs5v4qvPxU/
	sIlnXC7iVtP2u58kcyhzrT7ADpcZjmQHflq4RsO/c5gUBNUY1uw7k7Q/POEh7ZelSVPmybs2ZKf
	AfGnf1JR8U0WRJdTwciTAp0btIYwlHgUso2eTJjPs3HX7YeNnA=
X-Received: by 2002:a05:651c:41d6:b0:38b:f0f0:e3f7 with SMTP id 38308e7fff4ca-39240cac934mr29426591fa.7.1777475524876;
        Wed, 29 Apr 2026 08:12:04 -0700 (PDT)
X-Received: by 2002:a05:651c:41d6:b0:38b:f0f0:e3f7 with SMTP id
 38308e7fff4ca-39240cac934mr29426101fa.7.1777475524415; Wed, 29 Apr 2026
 08:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419185750.260784-1-npache@redhat.com> <20260419185750.260784-5-npache@redhat.com>
 <e9dbe863-d125-4fe5-8ecc-91ad7293e5cf@kernel.org>
In-Reply-To: <e9dbe863-d125-4fe5-8ecc-91ad7293e5cf@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Wed, 29 Apr 2026 09:12:08 -0600
X-Gm-Features: AVHnY4JWHIajx86OyyAW4xEABiDRXdIc8my5jlzqHRFOcHufFZGfWfjdV3YP0YY
Message-ID: <CAA1CXcBfFcaXRvx0UnutjDV_ozcRXUmVCXZ6E6HH0buX=BYntw@mail.gmail.com>
Subject: Re: [PATCH 7.2 v16 04/13] mm/khugepaged: generalize
 __collapse_huge_page_* for mTHP support
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Cc: aarcange@redhat.com, akpm@linux-foundation.org, anshuman.khandual@arm.com, 
	apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com, 
	jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, 
	lance.yang@linux.dev, Liam.Howlett@oracle.com, ljs@kernel.org, 
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com, mhiramat@kernel.org, 
	mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, 
	raquini@redhat.com, rdunlap@infradead.org, richard.weiyang@gmail.com, 
	rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, 
	surenb@google.com, thomas.hellstrom@linux.intel.com, tiwai@suse.de, 
	usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O5t1S0LQUzpdXlLdkH7CElXoA6LV-JuFckUSxe_M4y0_1777475525
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On 4/27/26 2:07 PM, David Hildenbrand (Arm) wrote:
> On 4/19/26 20:57, Nico Pache wrote:
>> generalize the order of the __collapse_huge_page_* and collapse_max_*
>> functions to support future mTHP collapse.
>>
>> The current mechanism for determining collapse with the
>> khugepaged_max_ptes_none value is not designed with mTHP in mind. This
>> raises a key design issue: if we support user defined max_pte_none values
>> (even those scaled by order), a collapse of a lower order can introduces
>> an feedback loop, or "creep", when max_ptes_none is set to a value greater
>> than HPAGE_PMD_NR / 2.
>>
>> With this configuration, a successful collapse to order N will populate
>> enough pages to satisfy the collapse condition on order N+1 on the next
>> scan. This leads to unnecessary work and memory churn.
>
> You could add a link here to previous discussions.

Ack, not a bad idea for historical reasons.

>
>>
>> To fix this issue introduce a helper function that will limit mTHP
>> collapse support to two max_ptes_none values, 0 and HPAGE_PMD_NR - 1.
>> This effectively supports two modes:
>>
>> - max_ptes_none=0: never introduce new none-pages for mTHP collapse.
>
> "introduce" reads wrong in this context. And I don't know what a "none-page" is :)

Thats a page that is none duh ;P Ill clean that up

>
> "never collapses if it encounters an empty PTE or a PTE that maps the shared
> zeropage. Consequently, no memory bloat."

Thanks that does read way better!

>
>> - max_ptes_none=511 (on 4k pagesz): Always collapse to the highest
>>    available mTHP order.
>>
>> This removes the possiblilty of "creep", while not modifying any uAPI
>> expectations. A warning will be emitted if any non-supported
>> max_ptes_none value is configured with mTHP enabled.
>>
>> mTHP collapse will not honor the khugepaged_max_ptes_shared or
>> khugepaged_max_ptes_swap parameters, and will fail if it encounters a
>> shared or swapped entry.
>>
>> No functional changes in this patch; however it defines future behavior
>> for mTHP collapse.
>>
>> Co-developed-by: Dev Jain <dev.jain@arm.com>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> ---
>>   mm/khugepaged.c | 124 ++++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 88 insertions(+), 36 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index f42b55421191..283bb63854a5 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -352,51 +352,86 @@ static bool pte_none_or_zero(pte_t pte)
>>    * collapse_max_ptes_none - Calculate maximum allowed empty PTEs for collapse
>>    * @cc: The collapse control struct
>>    * @vma: The vma to check for userfaultfd
>> + * @order: The folio order being collapsed to
>>    *
>>    * If we are not in khugepaged mode use HPAGE_PMD_NR to allow any
>> - * empty page.
>> + * empty page. For PMD-sized collapses (order == HPAGE_PMD_ORDER), use the
>> + * configured khugepaged_max_ptes_none value.
>> + *
>> + * For mTHP collapses, we currently only support khugepaged_max_pte_none values
>> + * of 0 or (KHUGEPAGED_MAX_PTES_LIMIT). Any other value will emit a warning and
>> + * no mTHP collapse will be attempted
>
> Not sure if we discussed it (and maybe I had a different opinion back then ...),
> but could we simply to fallback to max_ptes_none=0, so we can avoid returning
> errors here?>
> max_ptes_none=0 is ok, because we will not waste any memory. The warning clearly
> tells the user that this combination is not supported as is.
>
> ... and it would make this function a lot easier to handle. In the warning, we
> can just state that "falling back to ... "max_ptes_non = 0".

We'd then be "violating" the uAPI expetation and is the whole reason we
have this 0/511 behavior in the first place ;/

If it wasnt for that issue I would have a completely different design.

>
>
> [...]
>
>>
>>   /**
>>    * collapse_max_ptes_shared - Calculate maximum allowed shared PTEs for collapse
>>    * @cc: The collapse control struct
>> + * @order: The folio order being collapsed to
>>    *
>>    * If we are not in khugepaged mode use HPAGE_PMD_NR to allow any
>>    * shared page.
>>    *
>> + * For mTHP collapses, we currently dont support collapsing memory with
>> + * shared memory.
>
> "do not"
>
> "shared memory" is misleading, as we do support shmem. What you mean is maybe
> "collapsing with anonymous memory pages that are shared between processes
> through CoW" or soemthing like that?

Ok ill clear that up thank you!

>
>> + *
>>    * Return: Maximum number of shared PTEs allowed for the collapse operation
>>    */
>> -static unsigned int collapse_max_ptes_shared(struct collapse_control *cc)
>> +static unsigned int collapse_max_ptes_shared(struct collapse_control *cc,
>> +            unsigned int order)
>>   {
>>      if (!cc->is_khugepaged)
>>              return HPAGE_PMD_NR;
>> +    if (!is_pmd_order(order))
>> +            return 0;
>> +
>>      return khugepaged_max_ptes_shared;
>>   }
>>
>>   /**
>>    * collapse_max_ptes_swap - Calculate maximum allowed swap PTEs for collapse
>>    * @cc: The collapse control struct
>> + * @order: The folio order being collapsed to
>>    *
>>    * If we are not in khugepaged mode use HPAGE_PMD_NR to allow any
>>    * swap page.
>>    *
>> + * For PMD-sized collapses (order == HPAGE_PMD_ORDER), use the configured
>> + * khugepaged_max_ptes_swap value.
>> + *
>> + * For mTHP collapses, we currently dont support collapsing memory with
>> + * swapped out memory.
>
> "do not". Given that this is also used for the pagecache, can we make this clearer?

Yeah! I originally didnt plan on using these helpers for the file
collapse operation but figured hell, why not clean them both up, might
end up helping (hopefully not hurting) when Baolin goes to add mTHP
shmem support.

Cheers,
-- Nico


>
>> + *
>>    * Return: Maximum number of swap PTEs allowed for the collapse operation
>>    */
>> -static unsigned int collapse_max_ptes_swap(struct collapse_control *cc)
>> +static unsigned int collapse_max_ptes_swap(struct collapse_control *cc,
>> +            unsigned int order)

