Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BD52D2391;
	Wed, 29 Oct 2025 02:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703800; cv=none; b=Zcgwyz0iDY/KwyjpAt04QWjgK2oZcit8mdDq/N/9vU/SbFX0tTpmoNq6OecVhMlZcj+62R+l35MYP+sGKSaYE2DWZ8vU/xdvYGMLQkET2t0wlRfvebOzjNMW0zWlN5CUm5vrPcMNdfXWaxeISnpmSPOXGjBCPMrKZ4N7UCW2j7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703800; c=relaxed/simple;
	bh=kUA3shJUPxu4UNd/ekdRjoLclUx/oGZIXpLINmTl8aI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaH0puj/84RGdPIV6uvY+CqwdGKBaiyM1eaO6SCAd5AvNd7gtejyN0pLg55xo3dfCTzoL2IzJc+MFrnmtL3pgS2RpPNKI5iLB0RQtL0IKyoCa4P/G4LIVPQFRwJoa98QJvKU2X9Hr4bkl1a7Dt5HM88vE1sNSbT5li+eUBzOz+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lJg5im0/; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lJg5im0/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761703788; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wZ1yjYC/dgXU0FjIkqKm9KU8zUcua/YDv5tCcHYwZT4=;
	b=lJg5im0/8KPsq82ZHZUxNAmDrQLr2AGw4iViwxICnK4QCV8I/l0F16Z4uvf36qM8exPLT9ssJBplZEkZfO7Kg5QhLwx1q7+ioB44PsWPYSRso128/ZUoIpTreFeSv8tW0BqBEVMb1kBkBc4e7vETeB2t9Sf9Ylgxyyjoprifzcc=
Received: from 30.74.144.125(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WrDxfxu_1761703783 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Oct 2025 10:09:44 +0800
Message-ID: <b1f8c5e3-0849-4c04-9ee3-5a0183d3af9b@linux.alibaba.com>
Date: Wed, 29 Oct 2025 10:09:43 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 mm-new 06/15] khugepaged: introduce
 collapse_max_ptes_none helper function
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>
Cc: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, ziy@nvidia.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-7-npache@redhat.com>
 <5f8c69c1-d07b-4957-b671-b37fccf729f1@lucifer.local>
 <CAA1CXcA4AcHrw18JfAoVygRgUZW3EzsN6RPZVrC=OJwSNu_9HA@mail.gmail.com>
 <e69acbc5-0824-4b07-8744-8d5145e2580b@redhat.com>
 <e66b671f-c6df-48c1-8045-903631a8eb85@lucifer.local>
 <74583699-bd9e-496c-904c-ce6a8e1b42d9@redhat.com>
 <3dc6b17f-a3e0-4b2c-9348-c75257b0e7f6@lucifer.local>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <3dc6b17f-a3e0-4b2c-9348-c75257b0e7f6@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/10/29 02:59, Lorenzo Stoakes wrote:
> On Tue, Oct 28, 2025 at 07:08:38PM +0100, David Hildenbrand wrote:
>>
>>>>> Hey Lorenzo,
>>>>>
>>>>>> I mean not to beat a dead horse re: v11 commentary, but I thought we were going
>>>>>> to implement David's idea re: the new 'eagerness' tunable, and again we're now just
>>>>>> implementing the capping at HPAGE_PMD_NR/2 - 1 thing again?
>>>>>
>>>>> I spoke to David and he said to continue forward with this series; the
>>>>> "eagerness" tunable will take some time, and may require further
>>>>> considerations/discussion.
>>>>
>>>> Right, after talking to Johannes it got clearer that what we envisioned with
>>>
>>> I'm not sure that you meant to say go ahead with the series as-is with this
>>> silent capping?
>>
>> No, "go ahead" as in "let's find some way forward that works for all and is
>> not too crazy".
> 
> Right we clearly needed to discuss that further at the time but that's moot now,
> we're figuring it out now :)
> 
>>
>> [...]
>>
>>>> "eagerness" would not be like swappiness, and we will really have to be
>>>> careful here. I don't know yet when I will have time to look into that.
>>>
>>> I guess I missed this part of the converastion, what do you mean?
>>
>> Johannes raised issues with that on the list and afterwards we had an
>> offline discussion about some of the details and why something unpredictable
>> is not good.
> 
> Could we get these details on-list so we can discuss them? This doesn't have to
> be urgent, but I would like to have a say in this or at least be part of the
> converastion please.
> 
>>
>>>
>>> The whole concept is that we have a paramaeter whose value is _abstracted_ and
>>> which we control what it means.
>>>
>>> I'm not sure exactly why that would now be problematic? The fundamental concept
>>> seems sound no? Last I remember of the conversation this was the case.
>>
>> The basic idea was to do something abstracted as swappiness. Turns out
>> "swappiness" is really something predictable, not something we can randomly
>> change how it behaves under the hood.
>>
>> So we'd have to find something similar for "eagerness", and that's where it
>> stops being easy.
> 
> I think we shouldn't be too stuck on
> 
>>
>>>
>>>>
>>>> If we want to avoid the implicit capping, I think there are the following
>>>> possible approaches
>>>>
>>>> (1) Tolerate creep for now, maybe warning if the user configures it.
>>>
>>> I mean this seems a viable option if there is pressure to land this series
>>> before we have a viable uAPI for configuring this.
>>>
>>> A part of me thinks we shouldn't rush series in for that reason though and
>>> should require that we have a proper control here.
>>>
>>> But I guess this approach is the least-worst as it leaves us with the most
>>> options moving forwards.
>>
>> Yes. There is also the alternative of respecting only 0 / 511 for mTHP
>> collapse for now as discussed in the other thread.
> 
> Yes I guess let's carry that on over there.
> 
> I mean this is why I said it's better to try to keep things in one thread :) but
> anyway, we've forked and can't be helped now.
> 
> To be clear that was a criticism of - email development - not you.
> 
> It's _extremely easy_ to have this happen because one thread naturally leads to
> a broader discussion of a given topic, whereas another has questions from
> somebody else about the same topic, to which people reply and then... you have a
> fork and it can't be helped.
> 
> I guess I'm saying it'd be good if we could say 'ok let's move this to X'.
> 
> But that's also broken in its own way, you can't stop people from replying in
> the other thread still and yeah. It's a limitation of this model :)
> 
>>
>>>
>>>> (2) Avoid creep by counting zero-filled pages towards none_or_zero.
>>>
>>> Would this really make all that much difference?
>>
>> It solves the creep problem I think, but it's a bit nasty IMHO.
> 
> Ah because you'd end up wtih a bunch of zeroed pages from the prior mTHP
> collapses, interesting...
> 
> Scanning for that does seem a bit nasty though yes...
> 
>>
>>>
>>>> (3) Have separate toggles for each THP size. Doesn't quite solve the
>>>>       problem, only shifts it.
>>>
>>> Yeah I did wonder about this as an alternative solution. But of course it then
>>> makes it vague what the parent values means in respect of the individual levels,
>>> unless we have an 'inherit' mode there too (possible).
>>>
>>> It's going to be confusing though as max_ptes_none sits at the root khugepaged/
>>> level and I don't think any other parameter from khugepaged/ is exposed at
>>> individual page size levels.
>>>
>>> And of course doing this means we
>>>
>>>>
>>>> Anything else?
>>>
>>> Err... I mean I'm not sure if you missed it but I suggested an approach in the
>>> sub-thread - exposing mthp_max_ptes_none as a _READ-ONLY_ field at:
>>>
>>> /sys/kernel/mm/transparent_hugepage/khugepaged/max_mthp_ptes_none
>>>
>>> Then we allow the capping, but simply document that we specify what the capped
>>> value will be here for mTHP.
>>
>> I did not have time to read the details on that so far.
> 
> OK. It is a bit nasty, yes. The idea is to find something that allows the
> capping to work.
> 
>>
>> It would be one solution forward. I dislike it because I think the whole
>> capping is an intermediate thing that can be (and likely must be, when
>> considering mTHP underused shrinking I think) solved in the future
>> differently. That's why I would prefer adding this only if there is no
>> other, simpler, way forward.
> 
> Yes I agree that if we could avoid it it'd be great.
> 
> Really I proposed this solution on the basis that we were somehow ok with the
> capping.
> 
> If we can avoid that'd be ideal as it reduces complexity and 'unexpected'
> behaviour.
> 
> We'll clarify on the other thread, but the 511/0 was compelling to me before as
> a simplification, and if we can have a straightforward model of how mTHP
> collapse across none/zero page PTEs behaves this is ideal.
> 
> The only question is w.r.t. warnings etc. but we can handle details there.
> 
>>
>>>
>>> That struck me as the simplest way of getting this series landed without
>>> necessarily violating any future eagerness which:
>>>
>>> a. Must still support khugepaged/max_ptes_none - we aren't getting away from
>>>      this, it's uAPI.
>>>
>>> b. Surely must want to do different things for mTHP in eagerness, so if we're
>>>      exposing some PTE value in max_ptes_none doing so in
>>>      khugepaged/mthp_max_ptes_none wouldn't be problematic (note again - it's
>>>      readonly so unlike max_ptes_none we don't have to worry about the other
>>>      direction).
>>>
>>> HOWEVER, eagerness might want want to change this behaviour per-mTHP size, in
>>> which case perhaps mthp_max_ptes_none would be problematic in that it is some
>>> kind of average.
>>>
>>> Then again we could always revert to putting this parameter as in (3) in that
>>> case, ugly but kinda viable.
>>>
>>>>
>>>> IIUC, creep is less of a problem when we have the underused shrinker
>>>> enabled: whatever we over-allocated can (unless longterm-pinned etc) get
>>>> reclaimed again.
>>>>
>>>> So maybe having underused-shrinker support for mTHP as well would be a
>>>> solution to tackle (1) later?
>>>
>>> How viable is this in the short term?
>>
>> I once started looking into it, but it will require quite some work, because
>> the lists will essentially include each and every (m)THP in the system ...
>> so i think we will need some redesign.
> 
> Ack.
> 
> This aligns with non-0/511 settings being non-functional for mTHP atm anyway.
> 
>>
>>>
>>> Another possible solution:
>>>
>>> If mthp_max_ptes_none is not workable, we could have a toggle at, e.g.:
>>>
>>> /sys/kernel/mm/transparent_hugepage/khugepaged/mthp_cap_collapse_none
>>>
>>> As a simple boolean. If switched on then we document that it caps mTHP as
>>> per Nico's suggestion.
>>>
>>> That way we avoid the 'silent' issue I have with all this and it's an
>>> explicit setting.
>>
>> Right, but it's another toggle I wish we wouldn't need. We could of course
>> also make it some compile-time option, but not sure if that's really any
>> better.
>>
>> I'd hope we find an easy way forward that doesn't require new toggles, at
>> least for now ...
> 
> Right, well I agree if we can make this 0/511 thing work, let's do that.
> 
> Toggle are just 'least worst' workarounds on assumption of the need for capping.

I finally finished reading through the discussions across multiple 
threads:), and it looks like we've reached a preliminary consensus (make 
0/511 work). Great and thanks!

IIUC, the strategy is, configuring it to 511 means always enabling mTHP 
collapse, configuring it to 0 means collapsing mTHP only if all PTEs are 
non-none/zero, and for other values, we issue a warning and prohibit 
mTHP collapse (avoid Lorenzo's concern about silently changing 
max_ptes_none). Then the implementation for collapse_max_ptes_none() 
should be as follows:

static int collapse_max_ptes_none(unsigned int order, bool full_scan)
{
         /* ignore max_ptes_none limits */
         if (full_scan)
                 return HPAGE_PMD_NR - 1;

         if (order == HPAGE_PMD_ORDER)
                 return khugepaged_max_ptes_none;

         /*
          * To prevent creeping towards larger order collapses for mTHP 
collapse,
          * we restrict khugepaged_max_ptes_none to only 511 or 0, 
simplifying the
          * logic. This means:
          * max_ptes_none == 511 -> collapse mTHP always
          * max_ptes_none == 0 -> collapse mTHP only if we all PTEs are 
non-none/zero
          */
         if (!khugepaged_max_ptes_none || khugepaged_max_ptes_none == 
HPAGE_PMD_NR - 1)
                 return khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - 
order);

         pr_warn_once("mTHP collapse only supports 
khugepaged_max_ptes_none configured as 0 or %d\n", HPAGE_PMD_NR - 1);
         return -EINVAL;
}

So what do you think?
