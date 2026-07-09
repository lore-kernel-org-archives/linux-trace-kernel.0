Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9E3E6DCE
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jul 2026 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585546; cv=none; b=XJ+pHyoiFrLQTEab/dES/wxlnvSY/XU1bv7UpcogSmgnaxE+k+tbuSMeF65sL4rNzNer2MKVcys1V2VfxxS3N7Kbff9YNzHx01dUkYLxNx21gBmLyVLqTCKpQ/alDqPvZy/jpj//fi4KU2b/gaWfu/feXMftkn6JbMw78gI0WCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585546; c=relaxed/simple;
	bh=CXsGzIgzV3sRPSTOEGw9Lqhhm88ADy61b/U4jpe4ahU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WOMFPl+iPkE4Gi9o8WAjHGFMoZ86wI0eG6IqrJFq0LDCWiC/0MLyQ0dEi5XG4a07pjbCGWbYmZvc6LOa/OFDZYRdDxy9/MwfrGOTDD6B8j67qkQbd3Ow5sKI6vtYz3EsTDUAS3Lw9rlwXGt+u6YWXBx8qPU7luLY5bnKJpcSNtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVmTiU0H; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVmTiU0H"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-381a094c43fso1066192a91.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Jul 2026 01:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783585544; x=1784190344; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fZYBoXNfxRtgISWI6nwLbyRJgOnKdbrwsBmGvBXyyQo=;
        b=HVmTiU0H3T9z/Kpj17T2/b0jP+HeQcvvRxWbzD+N4ym0OL9oG3V7WwrvDMrby2j9p2
         xdP4LKk2ZX5mArnEKZ0xeDo7P2YLqUp6Q5LNxgMxohAJkq67I+4yRTVjJb0DNpOp5NIJ
         eI+FBaI2H/sQsRj79j9A4Rc1EQtPqsQMP3DFbQF5vTEC2bLoSTwGvKqBWs1WWLdPA8hi
         HtxGb5Yrv7ixGfO6LtrTCv0EN2hbDPSouXotx6gcL9ta3MvK0YOV9rgsFJxvldup1eXT
         oj09S4a/FmzHdeRSx7aWZ5Hi77znorEAr8Ac9L4YDpkMKaqceuLF2gNyjZYgECRoy/1C
         3K7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783585544; x=1784190344;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fZYBoXNfxRtgISWI6nwLbyRJgOnKdbrwsBmGvBXyyQo=;
        b=Lk1ydmNPSCNX3qbCMV0AGCNYhWyFfvJBpRc12qpkm1a7ui5M3L3aTne3DlooJWypdj
         Ou9vCJb1UjzXkf1Dqv88FqPQlc8P4dY/HOXQ5gWLzzikSCtPIsjPrSSDxc5xl/anBkOW
         hi/koJzqiq3SdMilwEMkmGHIMbCdiqBOBTOiqHG4hW58AlXYsRAwnDk2UqK7vlix/ODD
         Jm8EanAMArypa3oebv6fsGOk2LOHrqtCP+6RawBWY56DjEarpSku8uHLiunnlRAIxflI
         HFbtny4GsRCbR9qTr/aXDus/cB1bU9BTBamFboZQVmDSavYthrZ7ZOXLlwVlQkpgLNlz
         5LqA==
X-Forwarded-Encrypted: i=1; AHgh+RoS6ltFv+vbjujpFK+MI9+6y/CwlGpt2nl2WzEaa5JRMv1TGPnpCU9mrNDT9JsH45II7k2pU2tZzJBoTZaYLDlRDPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1NyrWSHaor45jfjLOqHI4BVaXnFdFUWHsf3MygucbM4gPhKPO
	mxl0UdCEh6F1PnZfRS+qG9m7TTpm2GKFsq8Ldxoz+SvB9zw7cJhGQSzj
X-Gm-Gg: AfdE7cn3DM2UtIXu8PDTwDlgfQnYqEm6J2yrdnVLi0hVmIHQE2cR2Cn6VaxnAoclElM
	jRAApRJHNpFTZ7WKgwxoVCMf5upTol8xlQup5W9zA4/ViNTbwLHteo826OBcWKbfFHFz0+r73Eh
	MYavLa3Poz3ngifuQ6E6NpZVdf03MhIQ91GWkBvTtBDvyHGZPcBgWfjeDD5bUbS5VyMne6QRw2N
	Kx5VDKwJh3oN702PimRpzdqOQAJ96v7INA3FQ6eVoLRVNpJfEKYNfRUDWe8H3TVGm9k8YS6R4KT
	CQHL8aSZRSKNz28tGrdoJBrptIpS78ptNMEX5Oojmk41kcwIZflQmwwbz2jOW9oqzAcqVYXCYkA
	GxzLsPNnXDmMD6UfmR5HbJnq46WnVQf64NjuvrBGLYHS5deejLtkynQ8v3FMXUt293PFNvgAVCv
	oqAurdMfZXS49bKrLUjJhEM3hNLbdXbHM=
X-Received: by 2002:a17:90b:3b45:b0:387:e0db:3d89 with SMTP id 98e67ed59e1d1-389434634f6mr6128019a91.36.1783585544240;
        Thu, 09 Jul 2026 01:25:44 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5574c513sm786919a91.5.2026.07.09.01.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:25:42 -0700 (PDT)
Message-ID: <f33a9dca-03d6-45f8-bd25-717b9033c75c@gmail.com>
Date: Thu, 9 Jul 2026 16:25:27 +0800
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
 <ak0EsCeucJarlI7G@lucifer>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <ak0EsCeucJarlI7G@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/7/26 21:55, Lorenzo Stoakes wrote:
> On Tue, Jul 07, 2026 at 02:44:50PM +0100, Lorenzo Stoakes wrote:
>> See above about deduplicating.
>>
>>> +			ttu |= TTU_RESPECT_MLOCK;
>>
>> Hmm. I don't love 'respect mlock'. I guess we only know about the reason
>> being compaction here.
>>
>> But I'm confused anyway. We have the folio, why aren't we just checking for
>> PG_mlocked() here instead of getting the rmap to see if it's mapped
>> anywhere with VMA_LOCKED_BIT?
> 
> Also, since compaction_allow_unevictable() is a function that is accessible
> elsewhere, you could literally just have a TTU_MIGRATION here instead and have
> the rmap logic call compaction_allow_unevictable() instead rather than this.
Do you mean:
1. change TTU_RESPECT_MLOCK to TTU_MIGRATION, that'is OK.
2. move call compaction_allow_unevictable() to try_to_migrate_one? but as you suggested
   migrate_mlock_allowed function, it already called compaction_allow_unevictable()
   in order to determine whether TTU_MIGRATION needs to be added. Did I misunderstand
   something somewhere?

> 
> And then you could adapt the function I suggested before not to take a reason
> parameter but rather a 'is_migration' one instead possibly and then pass (ttu &
> TTU_MIGRATION) in.
> 
> BUT. I still question whether this is at all needed since you have the folio you
> can check for PG_mlocked...

I described a race scenario at this link:
https://lore.kernel.org/lkml/c372e68f-2bfc-45b6-a431-01bf55717247@gmail.com/


> 
> Cheers, Lorenzo

