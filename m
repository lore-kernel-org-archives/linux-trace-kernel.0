Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7542B15ECFA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972408; cv=none; b=HW9TEo/BJgWRW3KuZCYPE8OtjsV7CzUsvYYuzTniDpA1DOaymaIKua+bGE3DT9OfKr8Ls9V4ofbWiI+tcb6ah0FeH/tDDP4Uz/46nbt3rS6a0VeWZK1WHXKFk3KwOl8Ke4DzUXZWkUjhDFH6AxoifigZDRhTOhi0jmq3y1UWOio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972408; c=relaxed/simple;
	bh=7aN5+WZTQsvFt0EKUQ5R5htwyE97gElyhQRvXJr9D7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZE79Ace/93qrmW48O4yq9Nnf25nxmAVyx3oUDFRdAHLf9fYcDrx0n425jvcHGRhjXVRrA+PxbcOur1up8PmVrbYo+99ADORAsGisu5OBHgrx9m12c2XXMSFME0bfB6wTPc44CpxGFrHqOg0vvAyrBF05r16goByhSvWNHRCp3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JkNl31wY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JkNl31wY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713972405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vIOHYmmLFUfNRGCfxVwrEQGqKQoMWtovNxl0ZVRiCbY=;
	b=JkNl31wYx/8Mru+pplvtfKc4sgWVzvcPVWpjpq1pt8uDB0a0CJgM7w/GsNrHeAo9u1JM8b
	oblDiRlRLhMU1I/Jis1i3z1EJlfutzjJ1KlSdXoFRR4XHC5e7hnfN8nRDyQO6xzGVwg3H7
	TKgnA7bfDzuVWmoPrV3RM1mXEWQUXiY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-lGd3r_UiNleWATD6shgDTw-1; Wed, 24 Apr 2024 11:26:43 -0400
X-MC-Unique: lGd3r_UiNleWATD6shgDTw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41895b0a62cso54045765e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713972402; x=1714577202;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vIOHYmmLFUfNRGCfxVwrEQGqKQoMWtovNxl0ZVRiCbY=;
        b=r6EdKWnAoV7JLcct5c+vwDJJsue3rLJniYNLIZHcYDQp5bOc/OsGJC23rk6QDOiNbc
         5B91yvabDDK3iu0ySTVukGFs5PB6CnY/D/9+/yD/vFGxWX9/qnrC2X8s1HY2W24cUcok
         uGHGuXOFGYygmG95GWcQHWFxzNk7fW++IRp5ex3+h9uA/MSfi0xIu/flbbr5RdRBdURM
         hxHyBKa0NcgoociWdOPy8F4IWblh9nMhvwvXB5ZzI1xagfPNNYdf0vjLLoNTT1CldvOo
         SoT2IV+5uO8Bv8RWmR1nLeGX6p6hpDlA2lITOzTLqkxiRf0NpvJ7tNyhUM5eeigsRR5J
         VGHw==
X-Forwarded-Encrypted: i=1; AJvYcCU6BbDPBpzLSripFCkQQObdC18W6phdyZaGu1wf9tOvO0Ug4Cu0ZIfI1xz4an9WH1ef5e76TfHEG6Ol/7d73FrRWf8JMyrtbNUtk6a9zm4f371H
X-Gm-Message-State: AOJu0YxIdBOHzAVK/Z9vMxNrsm3A3ipbldy2DHfxBSOB4tdr7Sp87AdC
	zufipWbyUBmM5COaSElTYdfJ5wokLkgqlC99p7VhWiVhxzY3fCX8pyHdkbXO0eThMhm/MxW8m68
	iHFk6EgXCERIu4WAXonNnpktSwklK045osyz8MyRCshnbgmM1bVkZ3tuF47Lb7IH7RklXOw==
X-Received: by 2002:a05:600c:45cd:b0:41a:6edd:6c1d with SMTP id s13-20020a05600c45cd00b0041a6edd6c1dmr2413717wmo.32.1713972402503;
        Wed, 24 Apr 2024 08:26:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwN3kJujen3ohtp8mNC6cAKgj8nycOFMrwXudufoGOKuEgp5PFHZ09Raq1v/2NQUEMEi253A==
X-Received: by 2002:a05:600c:45cd:b0:41a:6edd:6c1d with SMTP id s13-20020a05600c45cd00b0041a6edd6c1dmr2413694wmo.32.1713972402041;
        Wed, 24 Apr 2024 08:26:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:1f00:7a4e:8f21:98db:baef? (p200300cbc70d1f007a4e8f2198dbbaef.dip0.t-ipconnect.de. [2003:cb:c70d:1f00:7a4e:8f21:98db:baef])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b004186f979543sm28257764wms.33.2024.04.24.08.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 08:26:40 -0700 (PDT)
Message-ID: <f972ce5a-0351-450c-98a2-38188eae5001@redhat.com>
Date: Wed, 24 Apr 2024 17:26:39 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
To: Vincent Donnefort <vdonnefort@google.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com,
 rdunlap@infradead.org, rppt@kernel.org, linux-mm@kvack.org
References: <20240423232728.1492340-1-vdonnefort@google.com>
 <20240423232728.1492340-3-vdonnefort@google.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240423232728.1492340-3-vdonnefort@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


I gave it some more thought, and I think we are still missing something 
(I wish PFNMAP/MIXEDMAP wouldn't be that hard).

> +
> +/*
> + *   +--------------+  pgoff == 0
> + *   |   meta page  |
> + *   +--------------+  pgoff == 1
> + *   | subbuffer 0  |
> + *   |              |
> + *   +--------------+  pgoff == (1 + (1 << subbuf_order))
> + *   | subbuffer 1  |
> + *   |              |
> + *         ...
> + */
> +#ifdef CONFIG_MMU
> +static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
> +			struct vm_area_struct *vma)
> +{
> +	unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
> +	unsigned int subbuf_pages, subbuf_order;
> +	struct page **pages;
> +	int p = 0, s = 0;
> +	int err;
> +

I'd add some comments here like

/* Refuse any MAP_PRIVATE or writable mappings. */
> +	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
> +	    !(vma->vm_flags & VM_MAYSHARE))
> +		return -EPERM;
> +

/*
  * Make sure the mapping cannot become writable later. Also, tell the VM
  * to not touch these pages pages (VM_DONTCOPY | VM_DONTDUMP) and tell
  * GUP to leave them alone as well (VM_IO).
  */
> +	vm_flags_mod(vma,
> +		     VM_MIXEDMAP | VM_PFNMAP |
> +		     VM_DONTCOPY | VM_DONTDUMP | VM_DONTEXPAND | VM_IO,
> +		     VM_MAYWRITE);

I am still really unsure about VM_PFNMAP ... it's not a PFNMAP at all 
and, as stated, vm_insert_pages() even complains quite a lot when it 
would have to set VM_MIXEDMAP and VM_PFNMAP is already set, likely for a 
very good reason.

Can't we limit ourselves to VM_IO?

But then, I wonder if it really helps much regarding GUP: yes, it blocks 
ordinary GUP (see check_vma_flags()) but as 
insert_page_into_pte_locked() does *not* set pte_special(), GUP-fast 
(gup_fast_pte_range()) will not reject it.

Really, if you want GUP-fast to reject it, remap_pfn_range() and friends 
are the way to go, that will set pte_special() such that also GUP-fast 
will leave it alone, just like vm_normal_page() would.

So ... I know Linus recommended VM_PFNMAP/VM_IO to stop GUP, but it 
alone won't stop all of GUP. We really have to mark the PTE as special, 
which vm_insert_page() must not do (because it is refcounted!).

Which means: do we really have to stop GUP from grabbing that page?

Using vm_insert_page() only with VM_MIXEDMAP (and without 
VM_PFNMAP|VM_IO) would be better.

If we want to stop all of GUP, remap_pfn_range() currently seems 
unavoidable :(


> +
> +	lockdep_assert_held(&cpu_buffer->mapping_lock);
> +
> +	subbuf_order = cpu_buffer->buffer->subbuf_order;
> +	subbuf_pages = 1 << subbuf_order;
> +
> +	nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
> +	nr_pages = ((nr_subbufs) << subbuf_order) - pgoff + 1; /* + meta-page */
> +
> +	vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
> +	if (!vma_pages || vma_pages > nr_pages)
> +		return -EINVAL;
> +
> +	nr_pages = vma_pages;
> +
> +	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	if (!pgoff) {
> +		pages[p++] = virt_to_page(cpu_buffer->meta_page);
> +
> +		/*
> +		 * TODO: Align sub-buffers on their size, once
> +		 * vm_insert_pages() supports the zero-page.
> +		 */
> +	} else {
> +		/* Skip the meta-page */
> +		pgoff--;
> +
> +		if (pgoff % subbuf_pages) {
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		s += pgoff / subbuf_pages;
> +	}
> +
> +	while (s < nr_subbufs && p < nr_pages) {
> +		struct page *page = virt_to_page(cpu_buffer->subbuf_ids[s]);
> +		int off = 0;
> +
> +		for (; off < (1 << (subbuf_order)); off++, page++) {
> +			if (p >= nr_pages)
> +				break;
> +
> +			pages[p++] = page;
> +		}
> +		s++;
> +	}
> +
> +	err = vm_insert_pages(vma, vma->vm_start, pages, &nr_pages);

vm_insert_pages() documents: "In case of error, we may have mapped a 
subset of the provided pages. It is the caller's responsibility to 
account for this case."

Which could for example happen, when allocating a page table fails.

Would we able to deal with that here?


Again, I wish it would all be easier ...

-- 
Cheers,

David / dhildenb

