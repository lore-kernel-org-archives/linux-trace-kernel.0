Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F35C434E50;
	Mon,  6 Jul 2026 22:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377345; cv=none; b=falLtvaWw1H4raV7TIIFmjUVL1eBelD7yH/822MQWPvL8y6x+VYj7VDvJ49grjIYGb9DzhqE6LDFG9aM9qlGBxPcvTN91crGmXCyrcm81svtnd+4/wsVgZSQ1EhAG0SIDWnNWJY5dfrBeFgHMDSsl4AS6Czc45vJDfpyObaGXcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377345; c=relaxed/simple;
	bh=5xW0Je1r/s8tU9FKAdzH8VS2dCLUKRAZPS9x3TJeUEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tECa9P3bnYgmVXs7BhDWuoCiAXWUaeQ5i7VhsLtEV70zNHVmLWcdCcij/RxOnHB7bzHfUN/QdI2l+C0iPrw5yi26KWMwQ9K4PNNtUxCH6tYAqFCYasBmxOFnus+EGfvPm+IH4w6R0bnjK6VFEYvsmf6u1JK5R3LrreMfBxwnR5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iq1mSIOf; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iq1mSIOf"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2FC81C01;
	Mon,  6 Jul 2026 15:35:36 -0700 (PDT)
Received: from [10.57.37.79] (unknown [10.57.37.79])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17BE53F905;
	Mon,  6 Jul 2026 15:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783377341; bh=5xW0Je1r/s8tU9FKAdzH8VS2dCLUKRAZPS9x3TJeUEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iq1mSIOfXLG3hXRFL9Kzv3yFJEcMbbMa8QmqTZzQVZz0ukxoYCO9wIEiV1IhNjKF2
	 JiQVfDNJORA0W4vyoEAG9Nv9JW4K9btsU/AGo0ZlZ8x2kv+Mcd5RWNMOyYQOn4y5fc
	 wcc/AlC5LPxEhlwBgbOmsH+v7PRJKr3UQqfOja48=
Message-ID: <6835134e-7f45-4d2c-b825-b45120e53d57@arm.com>
Date: Mon, 6 Jul 2026 23:35:30 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/46] KVM: guest_memfd: Add base support for
 KVM_SET_MEMORY_ATTRIBUTES2
Content-Language: en-GB
To: Ackerley Tng <ackerleytng@google.com>, aik@amd.com,
 andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org,
 chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com,
 jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org,
 pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com,
 rientjes@google.com, shivankg@amd.com, steven.price@arm.com,
 tabba@google.com, willy@infradead.org, wyihan@google.com,
 yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org,
 aneesh.kumar@kernel.org, liam@infradead.org,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>,
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-13-9d2959357853@google.com>
 <114e2488-97ed-4740-a8e8-1edd991f26c5@arm.com>
 <CAEvNRgFKbKfTMkqh_XF-igm07qYWfRwYJ5SH7wHcLZnqesCzTw@mail.gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAEvNRgFKbKfTMkqh_XF-igm07qYWfRwYJ5SH7wHcLZnqesCzTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/07/2026 19:17, Ackerley Tng wrote:
> Suzuki K Poulose <suzuki.poulose@arm.com> writes:
> 
>>
>> [...snip...]
>>
>>> +static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>>> +				     size_t nr_pages, uint64_t attrs)
>>> +{
>>> +	struct address_space *mapping = inode->i_mapping;
>>> +	struct gmem_inode *gi = GMEM_I(inode);
>>> +	pgoff_t end = start + nr_pages;
>>> +	struct maple_tree *mt;
>>> +	struct ma_state mas;
>>> +	int r;
>>> +
>>> +	mt = &gi->attributes;
>>> +
>>> +	filemap_invalidate_lock(mapping);
>>> +
>>> +	mas_init(&mas, mt, start);
>>> +	r = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
>>> +	if (r)
>>> +		goto out;
>>> +
>>> +	/*
>>> +	 * From this point on guest_memfd has performed necessary
>>> +	 * checks and can proceed to do guest-breaking changes.
>>> +	 */
>>> +
>>> +	kvm_gmem_invalidate_start(inode, start, end);
>>
>> I added support for Arm CCA KVM patches with the inplace conversion and
>> I am hitting the following issue.
>>
>> 1. I am supporting INIT_SHARED + MMAP flags.
>> 2. VMM creates the Gmem_fd with both the flags above.
>> 3. Uses the shared gmem-mmap to load the initial payloads (kernel, dtb).
>> 4. At the VM finalization time, Populate the loaded regions one by one
>>      by
>>       a) copying the images to a temparory buffer - Since CCA can't really
>>          load the contents in-place.
> 
> Sounds good :). I see that you blocked this in the kernel by returning
> -EOPNOTSUPP if (!src_page) [0].

We could do the copy in kernel with src_page == dst_page, but that would
affect the batching of Granule delegation (and at which point we might
need a temparory buffer in the kernel as big as the vma_pagesize)

> 
>>       b) Set the "region" to Private in the gmem_fd (via
>> SET_MEMORY_ATTRIBUTES2)
>>       c) Invoke CCA backend to populate the private memory via
>>          ioctl(KVM_ARM_RMI_POPULATE,..) [0]
>>
> 
> This flow sounds right.
> 
>> [0]
>> https://lore.kernel.org/all/20260513131757.116630-27-steven.price@arm.com/
>>
>>
>> 5. Additionally, VMM can mark the entire RAM to be private before the VM
>>      starts running, again via SET_MEMORY_ATTRIBUTES2. On CCA, this
>> action is measured and doesn't require the Host to "commit" memory to
>> the VM.
>> Instead the host can lazily donate memory on a fault.
>>
> 
> For both TDX and SNP, the host can also lazily donate memory,
> guest_memfd supports this.
> 
>> But step (5) triggers the invalidation of both private and shared
>> mappings of the gmem area, from the kvm_gmem_invalidate_start()
>> above.
>>
>> This is because, the entire DRAM now has, some portions PRIVATE (the
>> loaded regions) and the rest are SHARED (from the Gmem_fd creation).
>>    Thus, kvm_gmem_get_invalidate_filter(Dram_start, Dram_end) causes the
>> invalidation of both "PRIVATE" and "SHARED" regions, which results
>> in the destruction of the already loaded data and things go south.
>>
> 
> This destruction will happen for TDX as well. I think we managed to get
> around this because we didn't apply conversion on the already-private
> ranges.
> 
> IIUC on SNP, zapping pages in the stage 2 page tables doesn't destroy
> the data, so that's probably why it has been fine for SNP.

Additionally, the Guest at boot, will try to mark the entire DRAM
as Private (RIPAS_RAM in CCA), which would trigger this anyways.

Suzuki


> 
>> When we know that the kvm_gmem_invalidate_xx is triggered by a
>> conversion, we don't need to invalidate the existing pages that
>> are in the requested state. i.e., the following patch on top of
>> this series does the trick for me :
>>
>>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index a97fcac34a0e..62e0427a49f4 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -250,16 +250,23 @@ static void __kvm_gmem_invalidate_start(struct
>> gmem_file *f, pgoff_t start,
>>                   KVM_MMU_UNLOCK(kvm);
>>    }
>>
>> +static void kvm_gmem_invalidate_start_filter(struct inode *inode,
>> pgoff_t start,
>> +                                            pgoff_t end,
>> +                                            enum kvm_gfn_range_filter
>> attr_filter)
>> +{
>> +       struct gmem_file *f;
>> +
>> +       kvm_gmem_for_each_file(f, inode)
>> +               __kvm_gmem_invalidate_start(f, start, end, attr_filter);
>> +}
>> +
>>    static void kvm_gmem_invalidate_start(struct inode *inode, pgoff_t start,
>>                                         pgoff_t end)
>>    {
>>           enum kvm_gfn_range_filter attr_filter;
>> -       struct gmem_file *f;
>> -
>>           attr_filter = kvm_gmem_get_invalidate_filter(inode, start, end);
>>
>> -       kvm_gmem_for_each_file(f, inode)
>> -               __kvm_gmem_invalidate_start(f, start, end, attr_filter);
>> +       kvm_gmem_invalidate_start_filter(inode, start, end, attr_filter);
>>    }
>>
>>    static void __kvm_gmem_invalidate_end(struct gmem_file *f, pgoff_t start,
>> @@ -724,9 +731,14 @@ static int __kvm_gmem_set_attributes(struct inode
>> *inode, pgoff_t start,
>>           /*
>>            * From this point on guest_memfd has performed necessary
>>            * checks and can proceed to do guest-breaking changes.
>> +        * Also, we don't have to invalidate the regions that
>> +        * may already be in the requested state. Hence, we could
>> +        * explicitly filter the invalidations to the opposite
>> +        * state.
>>            */
>>
>> -       kvm_gmem_invalidate_start(inode, start, end);
>> +       kvm_gmem_invalidate_start_filter(inode, start, end,
>> +                                       to_private ? KVM_FILTER_SHARED :
>> KVM_FILTER_PRIVATE);
>>
> 
> I think this makes sense. Thanks for catching this.
> 
>>           if (!to_private)
>>                   kvm_gmem_invalidate(inode, start, end);
>>
>>
>> Thoughts ?
>>
>> Suzuki
>>
>>
>>>
>>> [...snip...]
>>>

