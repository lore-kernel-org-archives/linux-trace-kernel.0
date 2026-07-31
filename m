Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976A42E8FD
	for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Jul 2026 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503001; cv=pass; b=OheCE/0rTbk+jwU6Y8e/4NUOjmS9CnzPIuVDg0VbRAVm3TZ3buB30l99tSkbNaEMmacJ/LY/EqpmWFdbSHeMU1tOAVPX/8R2/2Q4LDoixR7ppnuTAGoBGWu6Kdfxshlv0Oy/01tISPtguENR8aA8JlgjbthNg6grwSyxV/EtKkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503001; c=relaxed/simple;
	bh=IMWMnLbQOy6b9tEx6TPxB/pT3EmTOMY8ss6oX8Lyp+A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqDalm37v+GxcQpsCma228a/s/Yy70id2biLcseuk34e9seI5cMkKVk8yDf8vxmob7N5UfXsPVl9WihERFLfLw/GCBMEWVmErbz0/ji19EmcA/ziL05+78ivGmmZmO8pogIfzl7c7YUtxHGAMyQo7wsmsYDNgHFwj5kP7eReb4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fwvZ3Eda; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwvZ3Eda"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso1209814a91.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Jul 2026 06:03:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785502999; cv=none;
        d=google.com; s=arc-20260327;
        b=PslPyP6knnadrbgyCz4XIoN5H30oyTptCYyItuOQWHd9UBP7uQW360jrnVnTsQYDOZ
         Lf+/57nWWXcgudGbyWhjC3MRqgYzwaG0Vx6RPSsM1GrOLBHNqWDyOJWiUow0WHnorfhn
         tBM9uZ3omC8ZNIVMNZ34hw7zbEWqXuQP1kn5cnVL0WEbzSe7YA/9aONv3Z38i2oyw8oF
         WPKdaJ5VZZ13NYWYQX7ZhEzRs/p5+dVV1UhKpyBYpApiawkyQk2W2K0kCqtAXHGlwkoD
         vlKIxomyST6IW0yQ3Xqse3Dl2p34exYVv/iwFcLrqmupYkVpWicmQdx5dqQUJL2Tr5Sl
         BVnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=J+eugezfVQYSMU5tvUvWbSgw3mM0uud+rXMj1ASY7rI=;
        fh=dHDb3PuYoIbXY3KLEzrUYKXYgV2KCa9HR8zyDLCueWI=;
        b=QgO3GXmcPbuYZ1h+W7mPQB5oPDmnkTXZMNw5+athPv34xHese3q3my44odmjcwBjvr
         QpPkLObQ5pBOuWA3YzntGBZ3fEJ0HMVZOX5IVydRVHA+7wHqyjbYf8vpEyewe8MH2EAe
         IBzziZLs6CPZjjaGOvf8haOtVH8LAxOIv0P3ABAJhZpuu52T/M40+xsrsdDj7k19vIOU
         OXPJxYTpfdNq5qCXSUcyIpuaMEXh4YS0Ti8J+RVBNGMV9e3APvgJbrfNUOyXc1PGi6ye
         4NeAtJAyxtmWL7dXDIzRIupetl7jbjqXX9JUsQEMkK5mHsWhePrcH2iz9FJ4OtBsrqQe
         5I2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785502999; x=1786107799; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J+eugezfVQYSMU5tvUvWbSgw3mM0uud+rXMj1ASY7rI=;
        b=fwvZ3EdanYTcZntQg6z5shQh35bHMua2dGwtzgsNtVN1L35Ca+5jn+1clB3d+LYIaY
         2tnwbzAC6BXPwagaN9gBMq3A6igRT1JBvctvagRW8irJ3iiVVFWzF4hToJrNY/J/P8PX
         MxtNu44klSDkXSlNu8SAPZxAeAE4C0lcygMDe4swh4vwz6YS0rWN3p2mHyFQOBfvJwfS
         gwotFjae0HUhjyvC4kweshgj7u7WAQWcfl30sWKh1LaCQVdg7oi9JoiYAwVoDu6xoCWI
         wIg9eoLw8FC5vqT4jfLR/B2qLMqFct4yNrtGhCL4V0oUXCtZoCapXg9Fh+8TSOPZeCHB
         Rbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785502999; x=1786107799;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J+eugezfVQYSMU5tvUvWbSgw3mM0uud+rXMj1ASY7rI=;
        b=BE0jHiDlQCbNB0WpQe+vmq212bcdKSGqjRogv7v6cYd6m72Wn/LAoaO/LHlrTUDzu2
         j3KiKEZ+6NRXBjT84VwreHXCRU45FjWMB51oO6Z075GwZ2hHMQ3NHJYFuYj5Df/fPGMV
         stRUPVlHVhdjn/fXwyKBsL6iRyZpbft5ei2gQz3Q4qfaWmBBKfH1fxNE4sTV0X+dj753
         eD4JZAMUPuTgY2M9LmW2PQLlfha9EAL1olNPjSX6xZ/9e5G28xnRjQ3UL6blIYN5vkTn
         hx15aDhtCE0SL6EybiQ2W0hOZ5d0bhXZ1bx6lJPpvwi6kSGRo94cMF0L7R8W/d2QONzX
         y92A==
X-Forwarded-Encrypted: i=1; AHgh+Ro7Ec7cwD2FGe9DldJ15Y7N4xbc//eMMBSZQXoubfDl8V2D7OK5YgoxXL0eNAfF6AThzuVk07w93+75k1dKt0ZPD5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPVpOthuq4e9CU2XpEzG+9pFYYeSR824EYA00dicOlJBadfpis
	AOn0eKfVzD6Fcu9lrojpDcOp3X0A4xUEE0kDWeYdnwHFWphN81R/0XUGRC97vssQsR/6whKcOGZ
	qLFoA2bj4tUZvjBcasJLwGQfkp2yARpSQBQlf6lVb
X-Gm-Gg: AR+sD12rPXrtbVqdMCOq34nxU7NfXbtXwGerEkaXoedB4SdZCdkHw+2yMkLt4ie77y4
	KAAF69ReGaaM5ygUwg/7eTOwpAzqNj4iAxSGXQEBCBkqV3eV4UlHIJ1paDV7HT6TXeOjsL293up
	sMR7doXiFAChH6fy5s6Mn5GruY7/Yifpapyb7LvpZYebppsbKD9ZtQXw0w6YvSw9UH2F3yPdw9L
	lGjDlICJuOgFxY0TMpjGK0D1PMBl2n3bnVKXiD1vB3AnGPjwt61/tEMVH1IBDXhTxzGNJ93mnjZ
	9qPqM/yqCWzKb34dlTw1awBoDfLfqZl6o/rXYYXH96Sp9otagMhPOvg7dVRi8+zPS2ZbD1vhyYt
	h
X-Received: by 2002:a17:90b:1345:b0:38e:655c:6516 with SMTP id
 98e67ed59e1d1-38fb0e7d036mr2121478a91.0.1785502996836; Fri, 31 Jul 2026
 06:03:16 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 31 Jul 2026 06:03:15 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 31 Jul 2026 06:03:15 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <edc3566b-370c-41a0-a71d-2e4a0e1a94f7@kernel.org>
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-14-35f9aec2aed2@google.com>
 <4460e252-b6de-4df3-bea8-0368a9d0f4ff@kernel.org> <CAEvNRgEUQSju2tW_1zMk2=QmveZNtmkjjCZdqVBgBD2JPh0k4Q@mail.gmail.com>
 <a823e3d2-8acf-49d9-a812-ac1bb2136d7f@kernel.org> <edc3566b-370c-41a0-a71d-2e4a0e1a94f7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 31 Jul 2026 06:03:15 -0700
X-Gm-Features: AUfX_myvtAX7kCr1AZOI0RcjaLMvHuuJT4jX9i2y3E3Aj03MfOs1jY1iA4ExW_o
Message-ID: <CAEvNRgEas_9BEV-cNxXu4_wQx8sR2M4_OaW6DEd4=fszALMV0w@mail.gmail.com>
Subject: Re: [PATCH v9 14/41] mm: swap: Introduce lru_add_drain_progressive()
To: "David Hildenbrand (Arm)" <david@kernel.org>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Vlastimil Babka <vbabka@kernel.org>, "hughd@google.com" <hughd@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> On 7/31/26 12:22, David Hildenbrand (Arm) wrote:
>>>
>>> I didn't really like this either, the drain_state thing is really
>>> awkward, but in both usages (collect_longterm_unpinnable_folios() and
>>> guest_memfd), there's an outer loop where if the draining happened on
>>> the local CPU before it should skip straight to just draining on all the
>>> other CPUs.
>>
>> Just nasty :)
>>
>>>
>>>> I was hoping that we could embed more logic in a helper. The history [1] of the
>>>> refcount check is rather sad:
>>>>
>>>> https://lore.kernel.org/all/c5bac539-fd8a-4db7-c21c-cd3e457eee91@google.com/
>>>>
>>>> ... primarily because of mlock() handling.
>>>>
>>>
>>> In the original code in collect_longterm_unpinnable_folios(), I couldn't
>>> find anything that handles folio_test_mlock(), so I was lost for a while
>>> until I realized mlock() doesn't add a refcount to the folio.
>>
>> mlocked folios in the mlock cache hold a reference as well.
>>
>>>
>>> Are you kind of proposing an optimization to
>>> collect_longterm_unpinnable_folios() by adding a check for
>>> !folio_test_mlock()? I hope we can put that in a separate patch series,
>>> I'm still hoping to get this series in for 7.3!!
>>
>> I was trying to avoid messing with the refcount for ordinary LRU cache pages.
>> mlock() should be a corner case for guest_memfd.
>>
>> Relying on the refcount just means that one unconditionally performs a lot of LRU
>> cache draining even though it doesn't make any sense.
>>
>>>
>>>> For guest_memfd(), would mlock() ever apply on a path where you need that check?
>>>>
>>>
>>> For guest_memfd, if a folio were mlocked, unmapping it would fail, and
>>> so the refcount on the folio would be elevated. The
>>> kvm_gmem_is_safe_for_conversion() check in the patch after this one
>>> would fail, correctly.
>>>
>>> I really wanted the caller of the lru_add_drain_progressive() function
>>> to control whether to do the drain (see below), which would solve the
>>> mlock problem by not assuming the use of folio_expected_ref_count() to
>>> determine whether to do draining.
>>
>> Again, the problem is that on *any* raised reference you would drain. I
>> was trying to limit the harm.
>>
>> [...]
>>
>>>> + */
>>>> +static void lru_cache_drain_for_folio(const struct folio *folio,
>>>> +		enum lru_cache_drained *drained)
>>>
>>> The main thing I wanted in the proposed version
>>> (lru_add_drain_progressive()), was to let the caller determine whether
>>> to try or to continue draining.
>>
>> Why?
>>
>>>
>>> I wanted the caller to have full control over whether to drain or not,
>>> so I didn't want to pass folio into the function. I thought the caller
>>> should first determine whether to drain, then call the function.
>>
>> Why?
>>
>> That's literally what the existing refcount check tries to do: figure out if
>> there are LRU caches.
>>
>>>
>>> This version assumes that the caller wants to continue draining based on
>>> something to do with a folio, and the folio may or may not be on the
>>> lru_add fbatch at all, which is a little strange to me.
>>
>> I really don't understand what you are trying to say.
>>
>> Draining only makes sense if something is on the LRU cache. And there are
>> better ways of checking that than relying only on even less precise refcounts.
>>
>> If someone wants to do an early refcount check to abort the overall
>> operation, that's fine.
>>
>>>
>>> Also, this version enforces a certain definition of "expected" number of
>>> refcounts on the folio. I guess in this case this definition works with
>>> guest_memfd, but guest_memfd doesn't support swap so the swapcache check
>>> in folio_expected_ref_count() isn't necessary.
>>
>> ?!
>>
>> That's why we have the universal definition of expected references and the
>> common helper.
>>
>> Because pagecache pages commonly don't support the swapcache.
>>
>>> Also, if the definition
>>> folio_expected_ref_count() changes, then guest_memfd is implicitly
>>> affected. Not sure if the "expected" definition is the same for all
>>> callers?
>>
>> It must, because that is used all over the place. The only thing it
>> cannot deal with is references held by the caller (which could be supplied
>> through and "additional references" parameter like we do elsewhere).
>>
>>>
>>> I guess if there was a function named
>>> folio_ref_counts_indicate_presence_only_in_the_filemap() instead of
>>> folio_expected_ref_count(), then it'd be the perfect function for
>>
>> You're not seriously proposing such an abomination I hope?
>>
>>> guest_memfd to use. The current definition of folio_expected_ref_count()
>>> also includes page table mappings, but in this check guest_memfd really
>>> wants to make sure that there are no page table mappings.
>>
>> You can just check early for mappings.
>>
>> Remember: this is about LRU draining, *not* about your final
>> "unexpected references" check.
>>
>>>
>>> This version folds folio_likely_lru_cached() into the check, and I
>>> adopted the check for guest_memfd because it'd help with huge pages,
>>> though technically guest_memfd is always 4K now so the check is also
>>> pointless.
>>
>> Who cares if we end up with a common usable helper? We have usless
>> checks *all over the place* in common helpers.
>>
>>>
>>> I tried a macro version of this where the macro caller can pass in a
>>> full condition, which would look like this:
>>>
>>>   lru_add_drain_while(folio_may_be_lru_cached(folio) &&
>>>                       folio_ref_count(folio) != expected_refcount,
>>>                       drain_state);
>>
>> Yuk.
>>
>>>
>>> but I thought that just created something people have to jump to, to
>>> first understand how the macro works, so I left it as an explicit while
>>> loop instead.
>>>
>>>> +{
>>>> +	if (!folio_likely_lru_cached(folio))
>>>> +		return false;
>>>> +
>>>> +	/* Try local draining first, if not already done previously. */
>>>> +	if (*drained == LRU_CACHE_NOT_DRAINED) {
>>>> +		lru_add_drain();
>>>> +		*drained = LRU_CACHE_DRAINED;
>>>> +	}
>>>> +	/* Try draining all CPUs next if still not an LRU folio. */
>>>> +	if (folio_likely_lru_cached(folio) && *drained == LRU_CACHE_DRAINED) {
>>>> +		lru_add_drain_all();
>>>> +		*drained = LRU_CACHE_DRAINED_ALL;
>>>> +	}
>>>> +}
>>>> +
>>>>  /*
>>>>   * Returns the number of collected folios. Return value is always >= 0.
>>>>   */
>>>> @@ -2266,9 +2316,9 @@ static unsigned long collect_longterm_unpinnable_folios(
>>>>  		struct list_head *movable_folio_list,
>>>>  		struct pages_or_folios *pofs)
>>>>  {
>>>> +	enum lru_cache_drained drained = LRU_CACHE_NOT_DRAINED;
>>>
>>> I also considered an enum, but it would be another thing to export. I
>>> was thinking to have drain_state just be opaque to the caller and the
>>> only thing the caller needs to know is to initialize it to 0.
>>>
>>> Perhaps there's a better way to "make it opaque"?
>>
>> Putting an enum into a header is a problem in which universe? :)
>>
>> Ackerley, please stop making up stuff. Having generic helper is not a problem. Doing
>> checks in common helpers is not a problem. Putting enums in headers is not a problem.
>>
>> Your version is just bad.
>>
>> I can later try something that keeps the questionable refcount checks in place,
>> maybe that could do as a temporary solution until Hugh possibly finds a way to
>> remove the need for draining entirely.
>>
>
> And looking at it, the current folio_ref_count() in GUP is entirely wrong
> and always makes us drain local+all.
>
> Let me fix that first, which will also modify this code.
>
> I'd say, to unblock gmem we could have something minimal that I would clean
> up later, but I think the problem is that lru_add_drain() / lru_add_drain_all()
> is not exported, right?
>

My bad, I totally mixed up refcounting to drain with refcounting for the
safe conversion and didn't have a complete understanding of mlock().

The problem for gmem was that if there was an elevated refcount on some
folio in the range, it might be because the folio was in the lru_add
fbatch.

If it were in the lru_add fbatch, it would be fine to just drain the
lru_add fbatch and proceed with the conversion.

lru_add_drain() isn't sufficient since the conversion might be handled
on one CPU when the folio is on another CPU's fbatch, so I had to do
lru_add_drain_all(), but lru_add_drain_all() causes IPIs which are
expensive.

In an earlier revision I exported lru_add_drain_all(). My understanding
of the discussion at guest_memfd biweekly was that Sean didn't want us
to export lru_add_drain_all() now, and then end up exporting some other
function and unexporting lru_add_drain_all(). To avoid exporting and
unexporting, we then said we should refactor now.

Happy to go with your proposal too.

> --
> Cheers,
>
> David
