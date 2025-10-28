Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25C9221D87
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675444; cv=none; b=WfVWHhiaUHm6WT/05jxFYLnAQkWkOscnO8wXuhxwga2+yfbbcbPDrKsowvUtqqDzM0qT0AxuKsACxZM5o4D4+jIKPOAzDa5xdeGOYBsX1szVVUPqz/7ADkyTopXFemmvDJzgyqt1DOhDrdKUaxdvkqgH7gu/I7a5kZJfKqMuXEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675444; c=relaxed/simple;
	bh=i3SzW3VPWqdsqxV/FDxjAOEQpxm7li/WGvnttm4POTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YvqWOl8d8uqpKTOT+u2WBaK/vioSNeDzOdTxxyT1ihRP9js0M2PX+G1ls3rLJrPknM6rrxzgOMHOoIZxhugGpN5gimPB8xWRGreeqfs7YvWBQEEv+0psX49Y4h8xD77n/FL+27p+5PsQZ+ANfK5f0YUIgjvMwjKGI/1EtkZA3gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4JKQqs2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4JKQqs2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761675441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ySxbOqqI4HJUHGwdFmdvZDlaPAKPqm3FO8qJrHqBgvw=;
	b=T4JKQqs2NUSnSZO64V0iGUDvORJrKn+lr21+fUtazpR6tLfQqD7XkIxjNu0frYa9QkOsaA
	AY9E5DPJvDhpCaT+2GFh6tYPDBA6BMlkKihBSVshve+otqPW9nWG+ISGqf+J2NCErLdFER
	6PMRvdogUoSm2OWeL7qplrMiwnAbF1c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-a86DV4ZMOC-4ngSwzR80_A-1; Tue, 28 Oct 2025 14:17:20 -0400
X-MC-Unique: a86DV4ZMOC-4ngSwzR80_A-1
X-Mimecast-MFC-AGG-ID: a86DV4ZMOC-4ngSwzR80_A_1761675439
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471168953bdso1625345e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761675439; x=1762280239;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ySxbOqqI4HJUHGwdFmdvZDlaPAKPqm3FO8qJrHqBgvw=;
        b=jxT0eZGsWMywMXMm4j3q2ZJfEZ39j6pcFRSUG55WvFVznRhSk+eUSyyc9LKEZ2YkCg
         yG3/sjVv3AObHubAdWcQ6xA8QIDvk7XsGRgTcH3tZuRDpvoTQYYMDpFzeDy1h4KtSKlB
         dHjrBS9cpAmwK3bY1ytVbnP7H6VgkzWGoTchGrIDxa7CI38Nb7XEVb4YmvMrkbbLPtYk
         O1WXoudrWl2WuVqinIyDxkYQpNFnCUs1WizqlMdpukpr+A38PwDrfXULnjXaS3i/8Va7
         v0s3ngjNAfIPIWKMhm0KzTOUNYTSd3zCIRWsLJaXh4dIe5vEZnQ1etzcRdioc09Jt8zI
         g1eA==
X-Forwarded-Encrypted: i=1; AJvYcCWQN+JOKqSzuzyYclohT7KnaouynQ6AL6v3/YYLAB6MOfD6ydRn8H9lSpvrV5rYZ1o2TgQaXQEs3obXi9aNgJzfIr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Xq+bJ2sl9kwdVBG6nYr3hDRZfxXWvWMYcgbOFFUh1NfakiQC
	eGGjTsCUouh/YrD1Je1g3RhnjN9pAkeixSpcvVvMV63FtFOhJvO7yUa7+PMS7bwfSELBCX0Ri/c
	2FjE2cGhbVbNyZf+/oIPrxezAHO9hzUQGFZ3iEngahJxrGFCcfv7WGKf+Yfc5DCGe6j1r4AKsIQ
	==
X-Gm-Gg: ASbGncsgtUe0EYG7cFLRVCrp+p3yfPe8Yk1XAy5yaHl0YyGK+mOXkKTDd3pp9Dr0CEM
	Rvh2pBLVzaqRIKXJzIHLroi8wBeu7yremwo/76lldbB3gBEmNKIQeBMwCFsYMIZUhZdp/DYqSv2
	ZaxuMKPhh/NTf/RUfqm2Xl/X9wKFHDBdpiUNEuyKQ2WtTc3aqCdmxTmtECDtj+V4jNOMVhfmM40
	CobmY+gECLsU6ei5N+nN+gF7e/kgcKCeXF+4+5UfTWHNCfwsh9Hl4897BrjbrT0Gt0iCYDOKLrM
	fQaobBIL2gYc6B30ZSQ69uZT6LX7kfi3M9pZVt75GWNT7P6S06f8ox405knNJ7VM9TzP6Z4wk8k
	PKIMgiLPhRqcgjeIt9FqQjbRB+EJyNtPLnj2pL/Q=
X-Received: by 2002:a05:600c:8418:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-4771e68adc4mr1427225e9.16.1761675439204;
        Tue, 28 Oct 2025 11:17:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh9w3CR7oqv8SD+DpRc304K1YwGmWnUOlNNN0GFBUn5BuV/oHlq0iG3kt+3RHe9DOoKNgvDg==
X-Received: by 2002:a05:600c:8418:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-4771e68adc4mr1427045e9.16.1761675438722;
        Tue, 28 Oct 2025 11:17:18 -0700 (PDT)
Received: from [192.168.200.155] (host-80-81-2-50.customer.m-online.net. [80.81.2.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e18bd92sm5763515e9.2.2025.10.28.11.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 11:17:18 -0700 (PDT)
Message-ID: <dc002ef9-53ee-4466-b963-baadfd5162b7@redhat.com>
Date: Tue, 28 Oct 2025 19:17:16 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 mm-new 06/15] khugepaged: introduce
 collapse_max_ptes_none helper function
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
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
 <063f8369-96c7-4345-ab28-7265ed7214cb@linux.alibaba.com>
 <9a3f2d8d-abd1-488c-8550-21cd12efff3e@lucifer.local>
 <e2a89e74-1533-4a83-8d0f-3f4821750e25@redhat.com>
 <64b9a6cd-d2e4-4142-bf41-abe80bf1f61a@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <64b9a6cd-d2e4-4142-bf41-abe80bf1f61a@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hFXQ1Y-MT1IOp8nIydnq4ZR0pcNW70bjFPX0K3AbGiw_1761675439
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.10.25 19:09, Lorenzo Stoakes wrote:
> (It'd be good if we could keep all the 'solutions' in one thread as I made a
> detailed reply there and now all that will get lost across two threads but
> *sigh* never mind. Insert rant about email development here.)

Yeah, I focused in my other mails on things to avoid creep while 
allowing for mTHP collapse.

> 
> On Tue, Oct 28, 2025 at 06:56:10PM +0100, David Hildenbrand wrote:
>> [...]
>>
>>>
>>>> towards David's earlier simplified approach:
>>>> 	max_ptes_none == 511 -> collapse mTHP always
>>>> 	max_ptes_none != 511 -> collapse mTHP only if all PTEs are non-none/zero
>>>
>>> Pretty sure David's suggestion was that max_ptes_none would literally get set to
>>> 511 if you specified 511, or 0 if you specified anything else.
>>
>> We had multiple incarnations of this approach, but the first one really was:
>>
>> max_ptes_none == 511 -> collapse mTHP always
> 
> But won't 511 mean we just 'creep' to maximum collapse again? Does that solve
> anything?

No creep, because you'll always collapse.

Creep only happens if you wouldn't collapse a PMD without prior mTHP 
collapse, but suddenly would in the same scenario simply because you had 
prior mTHP collapse.

At least that's my understanding.

> 
>> max_ptes_none == 0 -> collapse mTHP only if all non-none/zero
>>
>> And for the intermediate values
>>
>> (1) pr_warn() when mTHPs are enabled, stating that mTHP collapse is not
>> supported yet with other values
> 
> It feels a bit much to issue a kernel warning every time somebody twiddles that
> value, and it's kind of against user expectation a bit.

pr_warn_once() is what I meant.

> 
> But maybe it's the least worst way of communicating things. It's still
> absolutely gross.
> 
>> (2) treat it like max_ptes_none == 0 or (maybe better?) just disable mTHP
>> collapse
> 
> Yeah disabling mTHP collapse for these values seems sane, but it also seems that
> we should be capping for this to work correctly no?

I didn't get the interaction with capping, can you elaborate?

> 
> Also I think all this probably violates requirements of users who want to have
> different behaviour for mTHP and PMD THP.
> 
> The default is 511 so we're in creep territory even with the damn default :)

I don't think so, but maybe I am wrong.


-- 
Cheers

David / dhildenb

