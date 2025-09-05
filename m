Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A971CD2C;
	Fri,  5 Sep 2025 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757075489; cv=none; b=W3QhLbpKEI6EX3YV8p/hlT3aijdplWAIitKTUoUup51gCxnWj8lG+hivi+FEZhEd+p/RyVu0LigZL3M6jhIFeCUIoAO0Fg9BHVTaHKWaG5YIScZzOiX0xfTxKRDPKbWulv2M/kF3FAhDmN7tK7dv5/OCe33dxWnKDJDylNJdbQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757075489; c=relaxed/simple;
	bh=ruCCB+HXYNDqzl61jtH2VjoKINqluUJciforkruMtVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUPGKToSbyQ+aNotZZS1oCuPGrgfakmIAOUYPVNKuPvZGGY7IQ4Gy8q2SkFJIFhPJK1ng3hyWp1MBRhC3r0OKxXkx9GGg6SbxuFE5Cwnl0kU+CGX/8YSdj/UN3e0aXQlE9q99rFfBO3j7qg/GrP+kxoSUAApZ73j4pobyKTj/aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hz3VODHY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hz3VODHY"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b79ec2fbeso14732715e9.3;
        Fri, 05 Sep 2025 05:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757075486; x=1757680286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kHonkD4Us1QO9Yt7U0Xd3LOspvgSrKo2EvCfpECpyzg=;
        b=Hz3VODHYHuT2W66f1WvAAhsHgUQlQPjKvEahFjU4spGHFR+jtrPw7631YIjhK/0yVP
         FLc+pxhTXydAqhQbUw8aw7N54WBeurYdr0g82ST7YMQJUv9m/2brNm1VGMQxHPB+L1dC
         DWYF3tJrK/+mSvfTfH69JPG4thv4SvXV/cOQdzk761EEwKHKGy898VrAmFUQPtHOrSKp
         TOj/QXiTZ58Ad6p65wLWZyDZ4XOKC/azPbk/miLPdhlWofuzweDbaPzAC2sfuXH6vP/I
         6XpH0N/8M5V6abhSO6AIAhkWpeRSeazfy7uVqkudaXkMr9Y4C0HqhxYTGAflclR5YVon
         H1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757075486; x=1757680286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kHonkD4Us1QO9Yt7U0Xd3LOspvgSrKo2EvCfpECpyzg=;
        b=FL78jKEg/B3cRwuB49cp6SMp9bz7oWsED7PmOJWnoQAEujgDZiQcFBn5GNd2/a7jZL
         lQHNk/Z6/vEfGIyJ9qqyAEEcKvOob5W5CYrSy5S4Y0Zd9R3HE905RJ6jXQLqDygQb2jW
         IhbsbuE9VErYE1zvxTzNo3yKlTfQaKCOo6QDy9q0j5LPMco0b0GnlTjnpyRf1wDzc55b
         YA6KcZNbikWICkWWXuIegzePI4FhWcfmRAWjnoQavZGX7Sc23sX2TMdWOROUVHtIEq42
         jpAtUQZLmNP7HQHUzOuSe64wX3FtMU7wUgZaXDUSKHuRbDLzMHZ9KPCASdUWHTqWGXLW
         uYuA==
X-Forwarded-Encrypted: i=1; AJvYcCXDH34mG2H2aYLw6ebA5zcFnJItJKqxqvfXV5zadZgj2xmtR4y4aahT3QP6PYkDApx+D1GzizTDwvc=@vger.kernel.org, AJvYcCXV+jDQyL37r6Hj6LLCe4znZXG1Jphf/zYsvWbJW7qfToqKTc5oQyMcar6DqgVfsOH4GGi2fWzz9kMipOVvkUr9bvbF@vger.kernel.org, AJvYcCXz2pdne196lLpFFo4jukEqJBXSJNilIIhXtULCv6VJcAaqmX663i36cXZ68gfeipWH2G1aJ7TbQUTox0BV@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4FxU+wW+6rNaM8VbI+w3nR0g2x+Vy+CPtA9KfCytIqPLDgeh
	fR59/mif8tlcJ6P19v21OxrrgJD89Wtq8KkHBBLrFdJqLLEnhuKsTMrp
X-Gm-Gg: ASbGncvcHlly0x47ymhZxrWyr/MX+Wp2nyix3H8VKui9Uzx+LAZbCKuJt8hziUYkr2V
	gfF2U56++DusMcM2uYGMdFnv8w0f5gPxzKpMnztsVAehR4eGQxN/+yD72bHEuoOaXZ5XlggjoTx
	brl8sbEk5bi4ugVg+v7QK6kfF6+ivviwkIx8MdCj3uLbWKdVy0ic6jKlK50reztSMx9VVxHQgRO
	ix5HJnYPZYu9C7DedNU6Nxlpmwp8+Z6SfRd8v07YckBss0PR+KT8jdWSBKlNTTN3banmSQndIQ3
	11pBFZNVkZaQnqwzoJdfwFHqiiOq94M9AJ9phja3XIZ0uDgdmxhJI3s4J502D7p5OpakA0X2rmU
	KIumetQFV9yuUaMJ5phCQAzlK+C8wHmpYrAN2Zp/ekH+rDlqFTkyLHHDEOcB1mVbyMKq47/Y=
X-Google-Smtp-Source: AGHT+IHnlMwLin4RCPEC9ey4bGMrukJ3tHOz0H3ZwM/jse7eJzjGnYjTKutrVbK8gWD+JLEh2OHSYA==
X-Received: by 2002:a05:600c:4f0c:b0:45c:b6d3:a106 with SMTP id 5b1f17b1804b1-45cb6d3a2afmr84182015e9.11.1757075485900;
        Fri, 05 Sep 2025 05:31:25 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1449:d619:96c0:8e08? ([2620:10d:c092:500::4:4f66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9bcda91dsm158752795e9.6.2025.09.05.05.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:31:25 -0700 (PDT)
Message-ID: <71d11a43-e9ff-46e5-988d-b39905e10f61@gmail.com>
Date: Fri, 5 Sep 2025 13:31:21 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Nico Pache <npache@redhat.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ziy@nvidia.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
References: <db2320ee-6bd4-49c1-8fce-0468f48e1842@linux.alibaba.com>
 <c8c5e818-536a-4d72-b8dc-36aeb1b61800@arm.com>
 <2a141eef-46e2-46e1-9b0f-066ec537600d@linux.alibaba.com>
 <f34b5fcb-6a97-4d97-86a8-906083b53be6@redhat.com>
 <eb02c281-6d41-44af-8eaf-8ffc29153a3a@linux.alibaba.com>
 <286e2cb3-6beb-4d21-b28a-2f99bb2f759b@redhat.com>
 <17075d6a-a209-4636-ae42-2f8944aea745@gmail.com>
 <287f3b64-bc34-48d9-9778-c519260c3dba@redhat.com>
 <ad6ed55e-2471-46be-b123-5272f3052e01@gmail.com>
 <CAA1CXcCMPFqiiTi7hfVhhEvHs4Mddiktvpmb7dMe4coLDF0bgg@mail.gmail.com>
 <61afc355-1877-4530-86b7-e0aa2b6fb827@lucifer.local>
 <65ce71c1-72a5-415e-9059-027167abf129@redhat.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <65ce71c1-72a5-415e-9059-027167abf129@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/09/2025 12:55, David Hildenbrand wrote:
> On 05.09.25 13:48, Lorenzo Stoakes wrote:
>> On Wed, Sep 03, 2025 at 08:54:39PM -0600, Nico Pache wrote:
>>> On Tue, Sep 2, 2025 at 2:23 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>>>>>> So I question the utility of max_ptes_none. If you can't tame page faults, then there is only
>>>>>>> limited sense in taming khugepaged. I think there is vale in setting max_ptes_none=0 for some
>>>>>>> corner cases, but I am yet to learn why max_ptes_none=123 would make any sense.
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> For PMD mapped THPs with THP shrinker, this has changed. You can basically tame pagefaults, as when you encounter
>>>>>> memory pressure, the shrinker kicks in if the value is less than HPAGE_PMD_NR -1 (i.e. 511 for x86), and
>>>>>> will break down those hugepages and free up zero-filled memory.
>>>>>
>>>>> You are not really taming page faults, though, you are undoing what page faults might have messed up :)
>>>>>
>>>>> I have seen in our prod workloads where
>>>>>> the memory usage and THP usage can spike (usually when the workload starts), but with memory pressure,
>>>>>> the memory usage is lower compared to with max_ptes_none = 511, while still still keeping the benefits
>>>>>> of THPs like lower TLB misses.
>>>>>
>>>>> Thanks for raising that: I think the current behavior is in place such that you don't bounce back-and-forth between khugepaged collapse and shrinker-split.
>>>>>
>>>>
>>>> Yes, both collapse and shrinker split hinge on max_ptes_none to prevent one of these things thrashing the effect of the other.
>>> I believe with mTHP support in khugepaged, the max_ptes_none value in
>>> the shrinker must also leverage the 'order' scaling to properly
>>> prevent thrashing.
>>
>> No please do not extend this 'scalling' stuff somewhere else, it's really horrid.
>>
>> We have to find an alternative to that, it's extremely confusing in what is
>> already extremely confusing THP code.
>>
>> As I said before, if we can't have a boolean we need another interface, which
>> makes most sense to be a ratio or in practice, a percentage sysctl.
>>
>> Speaking with David off-list, maybe the answer - if we must have this - is to
>> add a new percentage interface and have this in lock-step with the existing
>> max_ptes_none interface. One updates the other, but internally we're just using
>> the percentage value.
> 
> Yes, I'll try hacking something up and sending it as an RFC.
> 
>>
>>> I've been testing a patch for this that I might include in the V11.
>>>>
>>>>> There are likely other ways to achieve that, when we have in mind that the thp shrinker will install zero pages and max_ptes_none includes
>>>>> zero pages.
>>>>>
>>>>>>
>>>>>> I do agree that the value of max_ptes_none is magical and different workloads can react very differently
>>>>>> to it. The relationship is definitely not linear. i.e. if I use max_ptes_none = 256, it does not mean
>>>>>> that the memory regression of using THP=always vs THP=madvise is halved.
>>>>>
>>>>> To which value would you set it? Just 510? 0?
> 
> Sorry, I missed Usama's reply. Thanks Usama!
> 
>>>>>
>>>>
>>>> There are some very large workloads in the meta fleet that I experimented with and found that having
>>>> a small value works out. I experimented with 0, 51 (10%) and 256 (50%). 51 was found to be an optimal
>>>> comprimise in terms of application metrics improving, having an acceptable amount of memory regression and
>>>> improved system level metrics (lower TLB misses, lower page faults). I am sure there was a better value out
>>>> there for these workloads, but not possible to experiment with every value.
>>
>> (->Usama) It's a pity that such workloads exist. But then the percentage solution should work.
> 
> Good. So if there is no strong case for > 255, that's already valuable for mTHP.
> 

tbh the default value of 511 is horrible. I have thought about sending a patch to change it to 0 as default
in upstream for sometime, but it might mean that people who upgrade their kernel might suddenly see
their memory not getting hugified and it could be confusing for them?
