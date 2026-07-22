Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED3C49550B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Jul 2026 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714298; cv=none; b=S7gthnx5aNXTh9feNpnoWOF/eSP1twM9k9Ud+cVvhuzOm3oTM7hyU/ptp5R8TmJLyKbB+M/bNNSmd5Tth/WALoDXwcq3mOowI/jwZ9ViHL1HDEq2nx9MT+a+bil0f7aUn/Law3y3gW3jCDqIQyzG/L9aWBFPvclwW1DpUny4wjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714298; c=relaxed/simple;
	bh=akDU7xYh0IgyGRFadM1zLtDJvjoGFRPfM3elobo9fME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jlFwYlJpicvFvUmorSilA4uzEwd5759xpb0uBpbK/4g5lP6ZmxTAoskLNoR12r3vCOwsbu1L/z77W0t1/U9vdrgAq3DerdZB9pIFAh7RN8PsojZPQgsIYNnzt+8j7qa6y627C2dS/m1PxrY72YNV2EnZ1vbuv1AkG8kSxVRXHi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeUtFaBI; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeUtFaBI"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-cbb818e57c9so897331a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Jul 2026 02:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784714296; x=1785319096; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ijy/gLpb1NwFXbgR00G1evfvLl/4vAA++YOqxk207ZE=;
        b=JeUtFaBIjK/Zxm7YniW0ZoW4x/1vuNH26eGK15X0gw8M3j/Atr2xx8FKpwsUqGOLE1
         CbUbgG+Vfx3j9w4jwtZz7eOKcQ41lxd/j3vlmttq6zVwb5er8bPwxqgnWZ5VJUQWHDs2
         cH/70vzh510NKbVKuKrnRrgnkaTzLCOBacaP7ZPymrU5kHeqnj4Vhl8eoUCD/SJpHKM7
         wduAQVXvAj/3erZsoKvltTV07OR4L0kUzFhFKr1Km3tHcMMd/O3caqs9otR9Xv0+rq7s
         n6ct89b1zPhnX5AW2H/gxgsE+o1srorr+1FQbzp18IfkDiNG+ZcmJa1JGozRQrG9LoY4
         samQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784714296; x=1785319096;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ijy/gLpb1NwFXbgR00G1evfvLl/4vAA++YOqxk207ZE=;
        b=VkdCZv91B1uPnsX4YmmMrw+s7/Sb0e2kgQcUFLBsvlPvcz4rXC1cPByQMQd7DtOcrl
         jvdyKhYyxKWHsFXlJg5b9YcnSHGkP7CLtyHkKxN8T7vOK99ChYSCWWiM3wCzZfw2TNrW
         9g7wEVaIKcX5AwIsYQKTUQ6fTLuPy8KYEmFPjy8uWveMCk0aYGiY8dDXoS9ns9bAGq8P
         zDx6+KNfdXVmuaVbcoxqpi+U9YA0nxXvoE1RNDNbaESgqFLCmwWGdy3A780mBGM61/4V
         84O/mo/nEhOxhb8Cvos6vV0UL23RWQYmIr29mKMdWmw843tDfU8Tw4/wZG9GXx3xJu/3
         1IIg==
X-Forwarded-Encrypted: i=1; AHgh+Ro2hX/WuF1yNPuoOdBjf1gH5v1z6DQGqDF4u9EDioCRur8q357LOE5hMDfJ8Iqobd66cv0D7D/rFSHskOEx0fYagis=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvJ4hVgXXvz5LdXS2nVb2AUgw4k0D7rDxLe0QO6ZBphd+/j9TG
	uaZAz0+/zUiySs2xGoLeeVQRU24YLga/0QQf+/KS919nXLz6wkEbBxxX
X-Gm-Gg: AR+sD128Pp9r0/e1kw4iWWVVDAFEiOzOOTHSNBdy9OXf0X80I9W+DK6ZfPOLhrhE7Nl
	YypKKJF9OpF1ZdtT41KClax4DTPh/iKSeaBD+beA8B22RMBL6Go98UJnOm5oslzBouH5MzPHQYb
	xBfPEy7u8T+QPiBbxDAQVA43kslcN2q5xfoZmarfxoI9o7CyK8q+i3maGa2wZSv2G52m2cpsLyc
	5CgrfujA8VVvNKPZS7kfJCdr4c/DrySsOb1lu6LaClcJtk26ZtAxGnn36aTLZOMkGONPsMpvb2g
	AOSG3z6J3wHebiOx4NrtUnPNZmeQFtjx+YlWgEiGVhu3yS5Y7zl7qXfE2+G6itJFpt2JRVoLh8n
	1d/ToKV+pFrd5CQrs6zWaqpP8G8XNQfw/ZA19QgddUUXNNuE7l7aiSP43g6sf/2qFfTEGxGwW7U
	3ENMc+RoUPuw==
X-Received: by 2002:a05:6a00:23d5:b0:848:4754:28e5 with SMTP id d2e1a72fcca58-84c292393e8mr21888359b3a.16.1784714296477;
        Wed, 22 Jul 2026 02:58:16 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e172862d3sm1045545b3a.22.2026.07.22.02.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 02:58:15 -0700 (PDT)
Message-ID: <2e9902e7-3f40-49d5-afb0-e710fb01ab39@gmail.com>
Date: Wed, 22 Jul 2026 17:58:00 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm/mlock: migrate folios out of CMA when mlocking
 a range
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: vbabka@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
 Alexander.Krabler@kuka.com, hughd@google.com, fvdl@google.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 akpm@linux-foundation.org, surenb@google.com, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, ljs@kernel.org,
 riel@surriel.com, liam@infradead.org, harry@kernel.org, jannh@google.com,
 lance.yang@linux.dev, mathieu.desnoyers@efficios.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, pfalcato@suse.de
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
 <20260707125925.3725177-5-chenwandun1@gmail.com>
 <9b227263-56d9-41d5-ba8e-c969d8d68785@kernel.org>
 <20260709131509.iIPP2VBh@linutronix.de>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <20260709131509.iIPP2VBh@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sebastian, David,

Sorry for the long delay in getting back to this, and thanks a lot for
the review.


On 7/9/26 21:15, Sebastian Andrzej Siewior wrote:
> On 2026-07-09 12:04:33 [+0200], David Hildenbrand (Arm) wrote:
>> On 7/7/26 14:59, Wandun Chen wrote:
>>> From: Wandun Chen <chenwandun@lixiang.com>
>>>
>>> The region covered by mlock[all] may contain CMA pages. cma_alloc installs
>>
>> What about ZONE_MOVABLE where memory is supposed to be migratable?
> 
> Would it be bad if the pages would not be movable anymore? Does this
> effect just memory-hotplug or something else, too?

ZONE_MOVABLE does not need the same treatment as CMA.
1. On RT compact_unevictable_allowed is 0 by default, pages in ZONE_MOVABLE are
   never migrated by compaction, so no latency spike, no problem.

2. For the scenario of memory offlining within ZONE_MOVABLE, because of offline
   is an explicit administrator action. Any jitter/latency is expected and
   acceptable, the operator chose to offline memory and would not do so
   during an RT-critical phase.

3. cma_alloc() runs at runtime, triggered by drivers as part of normal operation,
   and isolation path hardcodes ISOLATE_UNEVICTABLE, so it migrates the mlocked
   pages and installs migration entries. The fault-and-wait latency hits the RT
   task unpredictably during normal operation, which is not expected, and is
   exactly the spike this patch targets.

> 
>> Also, what about drivers that mmap() CMA memory to user space, and
>> __mm_populate()->populate_vma_page_range() would actually try mlocking them, and
>> they actually must remain on CMA areas?
> 
> It should be safe to skip those. They belong to device and they
> shouldn't be affected by anything including getting swapped out.

Agreed. Only LRU folios are ever isolated for migration here
(isolate_folio_to_list() -> folio_isolate_lru()), and device-owned CMA
buffers are not on the LRU, so they are left in place. I'll double-check
the mmap paths and make sure this holds, and state it explicitly in v3.


Best regards,
Wandun

> 
> Sebastian

