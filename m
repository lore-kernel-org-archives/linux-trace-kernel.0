Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30D018DB02
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 20:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745612060; cv=none; b=qvuq9X83ko/Zk0NotKOpAesmivRMB41H1Pvc/h7XojGShMDWFpM0OEK54BRGZpbf6PwNCYVkS0XrmM/yr/nEnCJNEDdWKmIevILxCjQkNqLPwzewcjr0uGgnDZgkjJji6+KYc94Nqmz+NpJl0znh7iHWbEPbxbYO1R1Sk2bBv44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745612060; c=relaxed/simple;
	bh=E/Aft2dHub0/sExaRpozUMqkpqxK+gbpyLTSA+lbtoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvDmBu4VmF5sVhPPcBuJK0NOElY9CNixg3U587Yj7N2446dr8RL7vrTs4S3m6YCd5L3m3w0/xaVi+bCcWnvjV+jv3IQOjSHfk+P63byUS+uGtn9n/hciiYeCT2ZCtdRAvqcg7TvfB7TLwhmTKrm6JXvq75KaFew+US1233/RIjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8p4N45w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8p4N45w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745612057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IDOXsLnBlG5Gf4KYJyCVXRBkPrSN1fTR4Oi8KAMotgA=;
	b=T8p4N45w3qr5LiPRCYjSsu64EdatZoYq6C4GpZ+CQfEKnJ2dYbyJ8wQbDxBwXAsxxDLpWe
	TOl0No3oxdbTiHH8le0cNbfndFbRgjmZjgDVu2aI3m1cRRBTitgJjtaZyh6yya1Bic+HSx
	uAkHp3Wwg2T8dDpJIXpbVPbsRkYqSa8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-D3EkAZfUN6SZzzWBPsVRMQ-1; Fri, 25 Apr 2025 16:14:16 -0400
X-MC-Unique: D3EkAZfUN6SZzzWBPsVRMQ-1
X-Mimecast-MFC-AGG-ID: D3EkAZfUN6SZzzWBPsVRMQ_1745612055
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39141ffa913so1253749f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 13:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745612055; x=1746216855;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IDOXsLnBlG5Gf4KYJyCVXRBkPrSN1fTR4Oi8KAMotgA=;
        b=ct13hMhwkFG1Pchg0RmjfPpJEKwD6/w8r62Emi11vj/T9l6bhKU54D5BO2wkhNtDPI
         2z7f18ljt7tX6LBXC9o3OHGQH4X1OHmA/MnwD2C7s0/FJMDkeF5qBw2A5N7f1tCiJdPV
         49TRHhzTpSgBh+NxvrCVZwp+4B6C9+7gW5mlU12QVmrMq4+DaqCvcG+JNrg+NUQBhRQj
         dfunnZM6mnsuzmbZS42/aZF3nUTW830qQ7/HygZkq9se7rcGd9VUUwsz9DNzGQmTfACR
         QOrBqnNeGXXevbbyG/+4LK3BbV3lGrbN/NxETVBOxahTHCzQO484ytEWWXqb/AKJpCR1
         hIOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbUgjguSOi6VQxTjT4mdH7ZeNDhr/QdqwzdhyXDwKXIBk2NxqAiaFEllcjBmr82zWexKhFLvBdnJrhy55+rv+XeFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnwFrmN1NelTSZTJWe2rJfd2DD4Dofnp5Z+G8UpfndXe2266Rj
	7VIu/HUoZXeUoFTtOM9j3HEJfpgINhYk2dO/5sz1jBLQxZ/7n7di6tUPzdfWEG8JUM6W6Aa2z24
	deOZnAZokv7dg5rgJv3qFKEUxEeDN7Aq0F9NFnj52Xn8xZcnSNV8DNISHuQ1Bpy/oo+E/Og==
X-Gm-Gg: ASbGnctI4tgOL8XP9prDVscRJrnrLTOpflv3raeYauY7xvkKrj2roEw/epsTU06t0AD
	fRgxgFDgqDpkM85Pa+8nXUmBUtCiixMcFZjsNn/ERz9eT0Xno/AO4CzPDcRTgxeiPRSc9OBd0g2
	AFwwDT3BqxI5hBPF7VQfGNhMqA55yPPQSkScppR6BA4WHuuu1krZGMEMrK8jVfpFtdJwtEOA23N
	/4QP+0uBlUBLrcNwTx3GHyBMsSdStVSInXidsF1heUoqZev7UOb+n7Pqv8g74lmkr64IHeQMWmZ
	6sWNTSuTja+URDHJEzhKSCJX2DpdB6ixCLhBM/HPw6UiGT6F+Gg9NqyacPAEp9ioW2pE1YYe58t
	sSvu6gqRJ53krWfmfW8Y7LYKnYAQIIB590Fpi
X-Received: by 2002:a05:6000:248a:b0:39c:141a:6c67 with SMTP id ffacd0b85a97d-3a074f2f48amr3041215f8f.45.1745612054799;
        Fri, 25 Apr 2025 13:14:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6wu++VR5yLUa+Bh6ZWzjR0kuzX9MeXtfpoEa38XdStVWFYJa2gmbZFdVy3f4E0U4OoDuw6g==
X-Received: by 2002:a05:6000:248a:b0:39c:141a:6c67 with SMTP id ffacd0b85a97d-3a074f2f48amr3041180f8f.45.1745612054338;
        Fri, 25 Apr 2025 13:14:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70f:6900:6c56:80f8:c14:6d2a? (p200300cbc70f69006c5680f80c146d2a.dip0.t-ipconnect.de. [2003:cb:c70f:6900:6c56:80f8:c14:6d2a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca511asm3210623f8f.26.2025.04.25.13.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 13:14:13 -0700 (PDT)
Message-ID: <6e88cf7c-3d1c-461a-acff-4d6ef01671d6@redhat.com>
Date: Fri, 25 Apr 2025 22:14:12 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/11] mm/memremap: convert to pfnmap_track() +
 pfnmap_untrack()
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-trace-kernel@vger.kernel.org, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
References: <20250425081715.1341199-1-david@redhat.com>
 <20250425081715.1341199-5-david@redhat.com> <aAvp6umyw1AF2DbN@x1.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aAvp6umyw1AF2DbN@x1.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OnQ7QfL9YaBTIT3LGuCSZuailSs59EMrRXbY5qU0OdA_1745612055
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.04.25 22:00, Peter Xu wrote:
> On Fri, Apr 25, 2025 at 10:17:08AM +0200, David Hildenbrand wrote:
>> Let's use the new, cleaner interface.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/memremap.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/memremap.c b/mm/memremap.c
>> index 2aebc1b192da9..c417c843e9b1f 100644
>> --- a/mm/memremap.c
>> +++ b/mm/memremap.c
>> @@ -130,7 +130,7 @@ static void pageunmap_range(struct dev_pagemap *pgmap, int range_id)
>>   	}
>>   	mem_hotplug_done();
>>   
>> -	untrack_pfn(NULL, PHYS_PFN(range->start), range_len(range), true);
>> +	pfnmap_untrack(PHYS_PFN(range->start), range_len(range));
>>   	pgmap_array_delete(range);
>>   }
>>   
>> @@ -211,8 +211,8 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>>   	if (nid < 0)
>>   		nid = numa_mem_id();
>>   
>> -	error = track_pfn_remap(NULL, &params->pgprot, PHYS_PFN(range->start), 0,
>> -			range_len(range));
>> +	error = pfnmap_track(PHYS_PFN(range->start), range_len(range),
>> +			     &params->pgprot);
>>   	if (error)
>>   		goto err_pfn_remap;
>>   
>> @@ -277,7 +277,7 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>>   	if (!is_private)
>>   		kasan_remove_zero_shadow(__va(range->start), range_len(range));
>>   err_kasan:
>> -	untrack_pfn(NULL, PHYS_PFN(range->start), range_len(range), true);
>> +	pfnmap_untrack(PHYS_PFN(range->start), range_len(range));
> 
> Not a huge deal, but maybe we could merge this and previous patch?  It
> might be easier to reference the impl when reading the call site changes.

Yes, I can do that. The important part to me is to split #5 of, to keep 
that patch somewhat reasonable in size.

-- 
Cheers,

David / dhildenb

