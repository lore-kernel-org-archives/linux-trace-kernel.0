Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17AE37106A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 01:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993522; cv=none; b=pZC6rls75ElnEeiFav+eU9Sgouf+KwyQPLSh3iSmyj00+MR1B/MSXr5BIw0rtc1B8Pbn6mkTlYVZAVo0C/HpEwgx6KOL2uv5y2WD7Pippi3/QR9SJeqx1Mlb3d9VmPUU+2giIbi1J8XtA2s2eJT3hxOK3cvK+EeQ3rKje8bCG4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993522; c=relaxed/simple;
	bh=okAnVsVly5jc+yei4Wz48daP/zuQ/yq+djt9pIOtyYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bXMGc3dIStnzXpWRfL2DUk/vQ9RHbc/a0Etjr7+SKOo6rQk8fkbMxT1vWJv7BiPbJTkDRZV6Ni65rPhgOERtJjfGBC5pnmqcKOu05BB4us8rAHDJakHHIzb4gT1QHNP0DxJAqs3WMYlKr1da5xuZ3b/j51tgQDjAazPwbLq3L28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5MU3MAN; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5MU3MAN"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cabe9335f1so21871825ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Jul 2026 18:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783993516; x=1784598316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=73xB3qrx3acG77JE8xn8xw37lKaovvRLQMvPzLm4bDo=;
        b=c5MU3MAN5/4kkNjHSNAyNceo8P48EpROS5R9q41IwlTr8HuHWgxnShQaXd5ALHlcYR
         rMGpTGKDuRLxUiNN34Y77oZ6enrXhqNABIGcoQZDodhJUxAd1+iVqMvR6mkfGuXnHOTZ
         RSEiGG1RQrbujR/4Q/7gGFuOenq5sRct6g8NPCilWRFh7PQV2P+Y6eXkuLj7pe661G8s
         OuagphRpMxzP6aMnhtfTQKeY1ATwX0SiRfjtk60jNe0uaZTS+cB51hj66pHc2QiSgToh
         +FeHQ4eInL3khh76NbYOqyXkH43oVXI5T/QjLVywJYM/o1x1DqB1RS9feOJcCkAktX+X
         BfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783993516; x=1784598316;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=73xB3qrx3acG77JE8xn8xw37lKaovvRLQMvPzLm4bDo=;
        b=J+uwYmFeo2SWy7rcUPt/N8WW6EAYIfpxh7qOxkVEaDi6Lp2zo7Tq3T4/Duf/rJnpcG
         I8jdsopHDE74MDlguKq8ZmGflnbkINFL64lXoa16OIgMHgDZ9AtpYNbe6CVzO8WxcBNw
         FOpsvavjdB8QqdN2EpmKY4KRw9R+IsppNfqf2wmOEmuHoW9KmDqch22lpa0hDTEd9NTm
         JVajKzoid7jhkOtPecQh9W0phSdqpjM8srj7isXfjR5SDTTKyfl3KTesOuyYZybUDRea
         10inZoI9e9dwZHMBzVIiJyW3E5dbYBZ82l+fg9VvFvHdxTr2O9tiwrIlR947KPgGmI8P
         mBIw==
X-Forwarded-Encrypted: i=1; AHgh+RqdeaG27rRhA9tD74m67kJiIt9gy7/KawnLPUwcNaClPecMB1Cd3jTZ9r+u9gOOzB/omKBTkKX1xfiTzHTOraE5XAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5g9eVam7tHaCQYXrLZYDZv58FLrLgizn9poQyBMEQX2eSIxwC
	bd42h0RbzbVx7sP/ScElXdiCKlo+oS0JS6yXzCMdA9NlTDb7yJ3YhrVX
X-Gm-Gg: AfdE7cnrrTGFU45P/E1sIyn0mno6rEb7+gU2cRpXAJ9osHIGeITe4Y8W0xTZB61YkSX
	+FUngRhRVoV31Fr8qlScnS2Av8iTlpiG6eIVxxgIvhlhb9KrKvzE2k4V2YafJ+MWSF0gzeqKgC/
	/aHKavYvpx++gdNFl76QzWsqHn2/RGTgX3j8+gwoJ9Ws0sHpTlOcGuKSRn2q3QENhGpGC6Ym2wP
	AW+6XIa5+yqOvD4nnuM1skbXsYfe1JG6KAN4EcnlSRsAN8UZNZi3WR4MLQGGGMECDKj3nx9TAQK
	V3DckaBsGC+/OFrwgJwCWnxSoExc5+nzF8kEbb64GxUYQp2E2ovGu9NMgU1Nmj+2ccfXgUT4Mub
	QBOWEHGH9XGzdZ629D1ev9ZSXcjYO7vI6kYKG8ovw4iXfCSI7HBY3RHXhES6Fmn9Qmx2mmpRle8
	ckkLzfQefwHf1KcC66qyg2
X-Received: by 2002:a17:903:3205:b0:2c7:f4bd:91b5 with SMTP id d9443c01a7336-2cee98446f9mr17408505ad.0.1783993516159;
        Mon, 13 Jul 2026 18:45:16 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb86bsm107793465ad.11.2026.07.13.18.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 18:45:15 -0700 (PDT)
Message-ID: <97c1dccb-8f17-45f3-8058-023da96620c8@gmail.com>
Date: Tue, 14 Jul 2026 09:45:01 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm/migrate: do not migrate folios mapped into
 VM_LOCKED VMAs under compaction
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: vbabka@kernel.org, david@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, Alexander.Krabler@kuka.com, hughd@google.com,
 fvdl@google.com, bigeasy@linutronix.de, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, akpm@linux-foundation.org,
 surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, riel@surriel.com, liam@infradead.org, harry@kernel.org,
 jannh@google.com, lance.yang@linux.dev, mathieu.desnoyers@efficios.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, pfalcato@suse.de
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
 <20260707125925.3725177-2-chenwandun1@gmail.com> <akz7ythMxfIZeT0d@lucifer>
 <ak0EsCeucJarlI7G@lucifer> <f33a9dca-03d6-45f8-bd25-717b9033c75c@gmail.com>
 <ak-2VAwNNuCD98Jv@lucifer>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <ak-2VAwNNuCD98Jv@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/26 23:00, Lorenzo Stoakes wrote:
> On Thu, Jul 09, 2026 at 04:25:27PM +0800, Wandun wrote:
>>
>>
>> On 7/7/26 21:55, Lorenzo Stoakes wrote:
>>> On Tue, Jul 07, 2026 at 02:44:50PM +0100, Lorenzo Stoakes wrote:
>>>> See above about deduplicating.
>>>>
>>>>> +			ttu |= TTU_RESPECT_MLOCK;
>>>>
>>>> Hmm. I don't love 'respect mlock'. I guess we only know about the reason
>>>> being compaction here.
>>>>
>>>> But I'm confused anyway. We have the folio, why aren't we just checking for
>>>> PG_mlocked() here instead of getting the rmap to see if it's mapped
>>>> anywhere with VMA_LOCKED_BIT?
>>>
>>> Also, since compaction_allow_unevictable() is a function that is accessible
>>> elsewhere, you could literally just have a TTU_MIGRATION here instead and have
>>> the rmap logic call compaction_allow_unevictable() instead rather than this.
>> Do you mean:
>> 1. change TTU_RESPECT_MLOCK to TTU_MIGRATION, that'is OK.
>> 2. move call compaction_allow_unevictable() to try_to_migrate_one? but as you suggested
>>    migrate_mlock_allowed function, it already called compaction_allow_unevictable()
>>    in order to determine whether TTU_MIGRATION needs to be added. Did I misunderstand
>>    something somewhere?
> 
> The next paragraph addresses this.
> 
>>
>>>
>>> And then you could adapt the function I suggested before not to take a reason
>>> parameter but rather a 'is_migration' one instead possibly and then pass (ttu &
>>> TTU_MIGRATION) in.
> 
> 
>>>
>>> BUT. I still question whether this is at all needed since you have the folio you
>>> can check for PG_mlocked...
>>
>> I described a race scenario at this link:
>> https://lore.kernel.org/lkml/c372e68f-2bfc-45b6-a431-01bf55717247@gmail.com/
> 
> OK thanks. You really have to spell this out in the code in a comment, this is
> really non-obvious.

I will address these in the next version.

Thanks,
Wandun

> 
> I will try to look at your reply in due course (am between jobs atm).
> 
>>
>>
>>>
>>> Cheers, Lorenzo
>>
> 
> Thanks, Lorenzo

