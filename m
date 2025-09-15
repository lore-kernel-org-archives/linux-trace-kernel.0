Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28DB24A044
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938612; cv=none; b=NTPgqRbTqjRup+lRKin8JBdQW/IFuAuvOJjBm87akYc76YMwQ5PcJxQ9Fll16CxZK5tzN4v+RiX4Uf3ifqzfep97kC2f7XK+oIOIVJ7ZEOQW+6rV+PpPZjoL6sLPgEAoauOfL5X3YKikEHSeUHwJH7mDTtQ3veKvx270UATGBrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938612; c=relaxed/simple;
	bh=++dZYV/juMI5pl6UTOl5lGiPaGz60jWMWAPjOPQh934=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecnokd3asgSC3GXY3pSU/bmBdnURUeNyGIskR/d6StQlCdpbR2SwvUAKelJxWlW6ZxgX4VuSve0ajkzvt+nz86PnLJ+6cDKxKDigJuIEMAwFepnsrthIdwzKlu4r242wE3RfcLeZvs8Qv4LboQHBrOMzkEIbZHLRB6meBQKqbps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVj+RNSj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVj+RNSj"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45f2c5ef00fso10111745e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757938609; x=1758543409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hkh90FvShjKuQpnhzVfehnVtCnrky/4Hn2fBZ8wL670=;
        b=lVj+RNSjqxDyJAhTcfPQzJl+DcmHpkBwiSK4bth/MseJZpIGD3rVM4e0NLt4u354uf
         hve9JkMN1+aatCJgicCLwScHi6K38mzBw+RgW2zdYD1JiXZ5Vv7kOaLBQZWLshiJrkYO
         qOk/PucYsYttxw8kbyU3FVOih9e+RGEGseyidf21Vyai6Z5hr7ETd1QHv+XNfGFTQNLl
         rfiOB0MmGjsunRrlHON1ibuq6tcVHtORzaMM3pnkGg3vUa6E9jZGYGFAfoT17fjoUARI
         ntuTFbJWHQGCVWwB3wQpZxgOFka50qsB59aVwfin25dHteSaj819ElxdFv1+XImbmXgG
         wLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757938609; x=1758543409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkh90FvShjKuQpnhzVfehnVtCnrky/4Hn2fBZ8wL670=;
        b=V7J4jZyTZCff02aiR9LYCNN2bsO8oYNA4E3MR3/zaZtME3AwEF50ojvrqyLBE3jphY
         vkBOnzY9Vs7APT5qudu0Vs3++6ymWeNGGwEBYcRSZolpLueVRZkUVZA39fkLhUSnrdDH
         YBvM9XbBEjTiYTwlZQo6wB4BI/YeKHdrUjzzvFhT8dZsFcfY/QpVT+jLtwrfNctCAX4l
         7gLyVVgpG0081bgO4QOPSZ7z7LhaUExgS/aZqVLfFeOqY0oz+5nUxsTfGeJuB55SNpeT
         jxrbHW+G917VRerlh1bOzhQ2I4YzUq5t7eTJjgYtSE2f2Wf3YohTAV7w8JbYPejwnjZn
         QCjA==
X-Forwarded-Encrypted: i=1; AJvYcCWlwBa9p0gbFJghgq4354YmMPGPVA4/dfuFvOdkONQQsW6Jw1/tcwOOllMYJWomPKo72/DAnNxLUE6R4F1ogXJ4T1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzww2M9pl/xS2B1iKrMTpd26Z6qOYBYsxFVafWAu11j8anhEzrM
	S3DYxGXgtnatB3+9XmlMGXJUqNaHy5oauSAUN91gMXxLi69/mh9Xt4cc
X-Gm-Gg: ASbGncv7NBdH0UwkhJfu2vFeYxaBtPfbngEt5VUZHuNwcdChJEZNW4I7KvCmAZfQsls
	JrppNcWo2JICCjydJ3lOpz47nymZJodrRlsrq8YzU/mq4JQq5rqNC5CNpgQwQ6PYIvwU2WlsCdG
	aIfUmWlivZrFmArv0XVxOzr3BdYVf4sZd2TM5/FsNhaM5f2LR41/yXJ4rjOZK8W92uFIoq1XzXv
	kAeCTKWbPDUE6R6LthMo3gQ6Fj0O9o/thTepwDwkifpi1FqVz9km7diDoCPekln7LcF2giwCYK1
	AAf03bVrSyWeAmHpmLI9Ykgqz7l6e4h2AQga4qL+1gey9Twoy+mDunreOICbmTx7vOo8f/2um9k
	koN/A6oXMgp639EhLkZpcNXhQJVmAt1saDwwdd+3tjarrbHrMoj0FeC3kfryVZp0v6w4dlRDqAT
	7pmvksMA==
X-Google-Smtp-Source: AGHT+IHLdvnlzkDOd7uXK6UlLVGn66En8B0SEaqf+MBMTOLNt+IzT6bYlms/O5Yrrl4aVtgHa35tlA==
X-Received: by 2002:a05:600c:4691:b0:45f:28d5:fae with SMTP id 5b1f17b1804b1-45f28d511f7mr65042655e9.4.1757938608737;
        Mon, 15 Sep 2025 05:16:48 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1449:d619:96c0:8e08? ([2620:10d:c092:500::5:94b0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037d62besm173987755e9.21.2025.09.15.05.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 05:16:48 -0700 (PDT)
Message-ID: <f34dbfd0-2291-4a19-bbd8-b61fe7754e55@gmail.com>
Date: Mon, 15 Sep 2025 13:16:44 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Nico Pache <npache@redhat.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
 <CAA1CXcA+pb5KvEnJJqdf1eSjaFiBZ82MRB+KDmyhj3DbiQqOxg@mail.gmail.com>
 <enrgrocqajwu5d3x34voghja7pbvau45oobxgabawrly44ld4u@ahch3xn6rtq5>
 <cd8e7f1c-a563-4ae9-a0fb-b0d04a4c35b4@redhat.com>
 <2c5328ee-fb6e-45cf-a151-868cc8e7ff97@lucifer.local>
 <4508810d-7645-4f57-a0c5-2ee9f44206fc@lucifer.local>
 <34754ca4-fced-4a3c-8ff8-c00967d487de@redhat.com>
 <92352257-5be4-4aaa-b97f-c4e879ac6959@lucifer.local>
 <de3f5502-ef81-4f44-96a9-995e512301a3@redhat.com>
 <5099d9fe-4a07-4acd-95c8-782ffc74df37@lucifer.local>
 <1312fa3e-88dd-490a-9e07-9749c625933b@redhat.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <1312fa3e-88dd-490a-9e07-9749c625933b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/09/2025 12:10, David Hildenbrand wrote:
> On 15.09.25 12:59, Lorenzo Stoakes wrote:
>> On Mon, Sep 15, 2025 at 12:52:53PM +0200, David Hildenbrand wrote:
>>> On 15.09.25 12:48, Lorenzo Stoakes wrote:
>>>> On Mon, Sep 15, 2025 at 12:44:34PM +0200, David Hildenbrand wrote:
>>>>>>>> Mapping that to actual THP sizes (#pages in a thp) on an arch will be easy.
>>>>>>>
>>>>>>> And at different mTHP levels too right?
>>>>>>>
>>>>>>
>>>>>> Another point here, since we have to keep:
>>>>>>
>>>>>> /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none
>>>>>>
>>>>>> Around, and users will try to set values there, presumably we will now add:
>>>>>>
>>>>>> /sys/kernel/mm/transparent_hugepage/khugepaged/eagerness
>>>>>>
>>>>>> How will we map <-> the two tunables?
>>>>>
>>>>> Well, the easy case if someone updates eagerness, then we simply et it to
>>>>> whatever magic value we compute and document.
>>>>>
>>>>> The other direction is more problematic, likely we'll simply warn and do
>>>>> something reasonable (map it to whatever eagerness scale is closest or
>>>>> simply indicate it as "-1" -- user intervened or sth like that)
>>>>
>>>> I don't love the idea of a -1 situation, as that's going to create some
>>>> confusion.
>>>
>>> swapiness also has a "max" parameter, so we could just say "override" /"
>>> disabled" / whatever?
>>
>> I don't love the user being able to override this though, let's just nuke their
>> ability to set this pleeeease.

Do you mean stop people from changing max_ptes_none? I am not sure if thats a good idea,
Its existed for a very long time and even a few release warnings might not be enough
of a warning for sysadmins that might not have a kernel team to notice this.

If the eagerness solution is just a logarithmic mapping of max_ptes_none at the start, I do
think we need to keep max_ptes_none completely supported. As eagerness isnt really doing
something new? Once eagnerness diverges from just setting max_ptes_none, only then
we should start thinking about deprecating it?


>>
>> Because if they can override it, then we have to do some deeply nasty scaling
>> for mTHP again.
> 
> There are ways to have it working internally, just using a different "scale" instead of the 100 -> 50 -> 25 etc.
> 
> I am afraid we cannot change the parameter to ignore other values because of the interaction with the shrinker that easily .... we might be able to detracted at wait a bunch of kernel releases probably.
> 

