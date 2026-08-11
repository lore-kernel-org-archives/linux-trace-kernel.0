Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1434E33556D;
	Tue, 11 Aug 2026 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786471038; cv=none; b=nMglGDRI1rxK1HNrfStN3L8P8AltGMuHSFzu5ZUWwvZs/bR8uWyQVCy/8RPx/ci9as+7aK4PeqYF2H4KPSZ4BdizeIpdOaHuV1nCYTFy8qfWggH6ffM/xPVHAgc7P5gYo2TOQIPyJKj6y+tc9n4HyPxhM86SzVADU4dbA/Qit8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786471038; c=relaxed/simple;
	bh=lc6nlfL/TgrlC747A3IEU0ciMhetr5c6SQFU+wpDSB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHSOObfUnUBLX2Nwc4DxY04WWPNYgua55Z9OBODhiDTt/C6CJQ6JzgWAkoKwGkLFdMVLONcY4rrUNOnCxvVNB/pi8j/ujrzs2DNkrALn43c1a4UyDw//l24eMpD8ulnttoT1xWAOM/N397qixLEHDRzLSueEng27nMyD0a59OR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4emHB7M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4emHB7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086321F000E9;
	Tue, 11 Aug 2026 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786471036;
	bh=g/k363n5Lvqavno9fCoFoqYAurRBI/pjeBdWiyEPQAI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=X4emHB7MFkge8y440tlJsYBHJo5+N8Li59e/0ORXOxym8rC+y/HdLt15DOSVbQWZ1
	 4HO9ZhlCXXfzjkUtIBxtAGmKsTbVUwax3Osp2lGhzk5U6PlORe0UqDJZF2aS14FEkG
	 AncR9K+gj0URdsSSUZaOsznpEDLwe/cJqEhunPqw+hFAeWd3SOCySFNhesYu2UURLH
	 3x+CVp0x/ZkCUXlvWC5Vm+AnAcaZt7I+AF0LdrdCIhLZoEehItGo3B1D8Zo7s9HOQL
	 KUGYasF/2xyLJJbsiIa9x3ecW1a3ytFa0oB+z3tdXlL8ksBKDj0DPO6yA1//U+UCRc
	 A8CF2e7vWz+TQ==
Message-ID: <4c638fc5-5a74-43d0-b5bf-d7ef893cb994@kernel.org>
Date: Tue, 11 Aug 2026 19:56:57 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 11/41] KVM: guest_memfd: Ensure pages are not in use
 before conversion
To: Sean Christopherson <seanjc@google.com>,
 Ackerley Tng <ackerleytng@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com,
 brauner@kernel.org, chao.p.peng@linux.intel.com, jmattson@google.com,
 jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org,
 pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com,
 rientjes@google.com, shivankg@amd.com, steven.price@arm.com,
 tabba@google.com, willy@infradead.org, wyihan@google.com,
 yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org,
 suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
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
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, tarunsahu@google.com,
 Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-11-2fc18ee6d3ba@google.com>
 <eb1b5763-37bc-4cb3-890c-1e619e5a8ae4@kernel.org>
 <CAEvNRgHyRdt7rp=5e5FMbTT=fXNfB=np7VWd_GdmJcPOQgps4g@mail.gmail.com>
 <anpQJvFw9s-XP3pW@google.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <anpQJvFw9s-XP3pW@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> helps the reader understand what's being checked without having to look at the
> details, and also helps communicate the ordering dependency without needing a
> comment.
> 
> There are definitely times where the usage of a function bleeds into its name,
> but usually that's because the name and the usage are on and the same.  E.g.
> get_user() describes both the usage and the "what".  And it's easy/possible to
> go too far in the opposite direction, e.g. by giving a play-by-play of what a
> function is doing, but that's why we have bikshedding sessions :-)

Note that the problem I have with kvm_gmem_is_safe_for_conversion() that it is
all about *conversion to private*, not *conversion to shared*. In that sense,
the function name is just confusing.

> 
>> Perhaps a little ahead of its time,
> 
> Ya.
> 
>> but later with restructuring for huge pages, we also need no additional
>> refcounts other than gmem's own so that restructuring is safe, hence this
>> function name was meant to extend there as well.
> 
> Given that I've read that at least five times and still don't understand the
> nuance, I think it's safe (ha!) to say we'll need to revisit and review those
> changes no matter what. :-)
> 
>  
>> In this case "unexpected" (especially since the next patch adds checks
>> for maybe dma pinned and unmapping), begs the question "unexpected in
>> what way"?
> 
> Ya, that's why I like "outstanding", it succinctly captures that one or more
> references have been "loaned" but not yet "repaid".
> 
>>>
>>> I'd rather add a comment than have this filemap_get_folios_refcount.
> 
> +1, the local variable just made me scratch my head.
> 
>>>
>>> /*
>>>  * We expect one reference per folio-page in the pagecache and one
>>>  * reference from filemap_get_folios().
> 
> Nit, please no pronouns in KVM code.

Whatever floats KVM's boat :)

> 
>>>  */
>>> if (folio_ref_count(folio) != folio_nr_pages(folio) + 1)
>>>
>>
>> This comment explains what's "unexpected". I can do this and switch it
>> to kvm_gmem_mem_has_unexpected_refs() unless people have other
>> suggestions.
>>
>> I wish there was a folio_pagecache_refs(folio) that
>> folio_expected_ref_count() can share with this, and also
>> folio_swapcache_refs(), to solidify the definition of refcounts taken by
>> the pagecache.
> 
> ...
> 
>>>
>>> I'd add a comment here for the "why are we unmapping".
>>>
>>
>> Does this sound right:
>>
>> Unmap here to ensure that userspace page tables have no mappings, which
>> also ensures refcounts from those mappings are dropped.
> 
> How about:
> 
> 		/*
> 		 * Forcefully unmap the pages from all userspace page tables,
> 		 * and then verify there are no outstanding references, e.g.
> 		 * acquired via GUP or similar.  Tell userspace to try again if
> 		 * there are oustanding references and hope that whatever has
> 		 * pinned the page will put its reference "soon".
> 		 */
> 		unmap_mapping_pages(mapping, start, nr_pages, false);
> 
>                 if (!kvm_gmem_is_safe_for_conversion(inode, start, nr_pages,
>                                                      err_index)) {
>                         mas_destroy(&mas);
>                         r = -EAGAIN;
>                         goto out;
>                 }


Sounds good besides the function still not being clear about *which* kind of
conversion.


-- 
Cheers,

David
