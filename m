Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59BC3B38BF;
	Thu, 27 Aug 2026 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818236; cv=none; b=DiRDaYgdwoLuGRabC//7PrlOaVGim/UsLyntH4g+gtnYqBhkpyia4DGPIly0p2EISx0a8sDXxEbeEII4JsL0uiGTXNULyc2y114x/h4ndJcsVZ6oce6u+5Z1bin3zVBSTOJaYn1+RFN0uoESo8GaG83WgnG7lOaOwJRhahfZ63Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818236; c=relaxed/simple;
	bh=f2YLykpxlpJ4GMyj8KmbX12yBlJxyZunxPtC+70Jdy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WH4uN43a+NV0qbLtVhQWkK7HkeM2jC7q99MFiyjLUaF4T4zUzp3Bp9tiImir7bXTd8cvSqhxk37Mq0rjW16fwbzPk5acSX9h1PZqFm7QUxpGt8NcoN/4FTU41xvim/968dWLk8mIX9vkJyxWYXNVok3FkPAYyVKsyW4gCXsIGMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AODPS2N8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AODPS2N8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850CF1F000E9;
	Thu, 27 Aug 2026 08:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787818235;
	bh=HwBoRCj9MIATU2Qil8eVnmnQigb4zkTVmy3cTirRlBk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AODPS2N8Z6i40bV0jaUFc2PuvLy4MqHjmeqaz4bIOilDBIarfveD10jTbTdIkd2iQ
	 td7570nLQ0oCM7k5JCPCOMM4nYs/HUuVSnY7FjRcD5phtnS6eXpkJG2rTe671lm6RI
	 coQQZWHQV6DQ22IS7lhT2hTwxa/SQsVzogDIvAvHM7e3TGvPmCV+jy0j/bRVCrn4DB
	 +D6NjQcrY1HKk31ONHwzhCcVH1OmkqlNutD4cj45ua7LpeiJ+9OVN2VrbkoMMue4Cd
	 iSMdxUiqVZvku+Su9hCtOaGBeZVtoEdxYentNKnACiFe+45NXWKaMtpYXCZkSQeNgf
	 GxMfYHTbrqzCw==
Message-ID: <e8aaddde-0a07-4197-9874-5ca0ea8af43f@kernel.org>
Date: Thu, 27 Aug 2026 10:10:24 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] userfaultfd: decouple fault reason from VMA flags
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Hugh Dickins <hughd@google.com>,
 Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Lance Yang <lance.yang@linux.dev>, "Liam R. Howlett" <liam@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Nico Pache <nico.pache@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>,
 Usama Arif <usama.arif@linux.dev>, Vlastimil Babka <vbabka@kernel.org>,
 Zi Yan <ziy@nvidia.com>, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
 <20260823-uffd-vm-flags-v1-v1-5-3086981b33cf@kernel.org>
 <5bb86e34-6196-4b50-b553-be2ff7c1fa32@kernel.org>
 <ao_sCh5zP0IC9H2S@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <ao_sCh5zP0IC9H2S@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/26 09:49, Mike Rapoport wrote:
> On Mon, Aug 24, 2026 at 04:46:14PM +0200, David Hildenbrand (Arm) wrote:
>> On 8/23/26 14:17, Mike Rapoport (Microsoft) wrote:
>>> Introduce enum uffd_reason to define reasons for user faults rather than
>>> overload VM_UFFD_* VMA flags for that.
>>>
>>> Using a dedicated enum makes the code clearer and decoupling the fault
>>> reason from VMA flags clears the way for moving the uffd mode bits out
>>> of VMA namespace.
>>>
>>> No functional change.
>>>
>>> Assisted-by: copilot:claude-opus-4.6
>>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>> ---
>>>  include/linux/userfaultfd_k.h    | 16 ++++++++++++++--
>>>  include/uapi/linux/userfaultfd.h |  6 +++---
>>>  mm/huge_memory.c                 |  6 +++---
>>>  mm/hugetlb.c                     | 10 +++++-----
>>>  mm/memory.c                      | 10 +++++-----
>>>  mm/shmem.c                       |  4 ++--
>>>  mm/userfaultfd.c                 | 30 +++++++++++++++---------------
>>>  7 files changed, 47 insertions(+), 35 deletions(-)
>>>
>>> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
>>> index 45355bdb4ec7..f401623f315d 100644
>>> --- a/include/linux/userfaultfd_k.h
>>> +++ b/include/linux/userfaultfd_k.h
>>> @@ -9,6 +9,18 @@
>>>  #ifndef _LINUX_USERFAULTFD_K_H
>>>  #define _LINUX_USERFAULTFD_K_H
>>>  
>>> +#include <linux/bits.h>
>>> +
>>> +/* Fault reason #PF handler passes to handle_userfault() */
>>> +enum uf_reason {
>>
>> Can we just call this "userfault_reason" or "uffd_reason" ? Maybe the latter is
>> actually what we want?
> 
> userfault_reason sounds better to me.
> 
> It describes what kind of user fault we are handling and the 'fd' part has
> nothing to do with it. 
> We do use uffd as a short name for the subsystem, but still most if not all
> userfaultfd "external" APIs use userfault_ prefix.
> 
> uf_ was an attempt to make it wee shorter :)

Yeah, I got that; while uffd is a known acronym, the uf_ not so much (and also I
wouldn't suggest it to become a thing, lol :) )

I've been wondering for a while whether it really should be called

	handle_userfault()

And not instead

	handle_userfaultfd()

Or maybe even better

	handle_uffd_fault()

And then have

	uffd_fault_reason

... but just a thought.

-- 
Cheers,

David
