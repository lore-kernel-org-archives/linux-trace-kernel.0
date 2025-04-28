Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF23F27978F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Apr 2025 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860338; cv=none; b=useDVXMjwS4+yIHgCIWbh0dc7d0RHjWsVLsRC18cAsvhEYkpEbwgVg875dX3lxec027FdGhlWyJo5AuyrIlkFsiRgHlUKOlv5atvr9gimX+WEhNPqlwP8kwwYIsD3WAsYvWH4HCtm6B0bs1Lsf1YZ+LTP6DF7jWu+Qi0tIDXZV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860338; c=relaxed/simple;
	bh=jULmZlWn/2/Vo/wWa1N1sU9KO7XMrfNbc0iy0j8QOUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sT2/BrDh2+gteJDsHXYvtIzz8qCFTo9FqbqLi3O6+U38W8quRcq3THqH8fWzqlfAw22+mkbEGBjMbJj07qvtgPmNWziNBQU0DdX+mpiCcIlfabQ1hWpDtQoz020G7DBTNoSBa0jqqR428uWSFbdq9USH17Bd2svqd+IXYr4q6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4B2qOue; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4B2qOue"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745860335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YlBurcqbe64ISpcElqVnUgzueWYOv8LWsAS36SHmzGE=;
	b=h4B2qOueyF/hwmmGTVyIFRkyfIF/vZ5AK3ke90qCeoKO+KSufp62P/MLsd8sS4R7rrpMsj
	vzey3+We8HfoUQ389MD0/j6ZotxSSeqLugip9Og2QC+aq1BFmCz/HlpEBWsPg6PfbcDqJo
	vaccYm3Q9Ev9N9rooUY3NgYBoC6b+90=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-pJiHXp6IN3Cf4PCm-NyXMA-1; Mon, 28 Apr 2025 13:12:14 -0400
X-MC-Unique: pJiHXp6IN3Cf4PCm-NyXMA-1
X-Mimecast-MFC-AGG-ID: pJiHXp6IN3Cf4PCm-NyXMA_1745860333
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so20251105e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Apr 2025 10:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745860333; x=1746465133;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YlBurcqbe64ISpcElqVnUgzueWYOv8LWsAS36SHmzGE=;
        b=xUYvpUxj5IDZirW8QlFbdckPeDx/R4fYb9Xz9IOX9Aio14AfHpOjS/rB1lehHMsgXh
         CJvBCebei5XavY3A6iMJPxwOXw5XqdhZfCa99eXn5cOumJ+ti4g9wVUGNokYdHPAkQnj
         EzjHZlyvejYSL1/pFCDxBN8bleGVdJWa4lmCblwp3w7yWGrQBuQ9BN51t0WtGZsIYBeI
         C5KdTTIidJ0Hi17ZAmPceAVxYySrfZyLyvxdSilT7F+z0bb8jU5nulBg3j+/mDtMBUpW
         kY5bCOZt2NdSPHMBQzOD8ytOSlZYGvlS1Or+HfGxGdm/Zu674msuueKymey0m2tvcxUI
         9AlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVkRNpdxsJRH5vryMQ6qtp/cVODcpdjGySFGzV+N0ccRPZtfiwH1x3UF7VL73qPRXSANQA7NU05WQISKG2p6oLJss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFsodYqCe4Tva64leRftYdmTWtN5EGfpFEVOGgLgfxcufKAD/h
	g6GZXCxFQIuCktw8KBumjHD1U0Gpv6IRczqgtkEUoJOnMuP8KdD0TKHDv7UMAe0q0EYKvTnuVcK
	k/RMSJcfs9ipqL5i+KzYrbKhuFuCwia93OJa8vEHjwaQDzi5bSjYmkLkrenx7GYULiy/9fQ==
X-Gm-Gg: ASbGncuyICKVXnIhKbcriochcunG1THGVErAw2qWlBDL3ilwbYfR0ZvPUgxrBjg8sgW
	AtxPMSY2ruMZUBr84d9iL2dqLy9zi7CNoL0mldK5lrMQtKYkjQEtIL/h/rZ8l24+fqX+ypZorxk
	QrpaE1ZooZ8aBp6l4WN6pzLwg38KSKEul0YTUxiAtBnZiOBjZFJMPP9GTptwkE3flwN+Zo5wnjO
	sB2PT43GYOReZxyNEnP8JfX7Ovx132YKI5eQCJT6J3YAj5nwFK1D36DHiLlU+5kvlo+sd1GnXws
	WoJ5tkbR8Aq2XPnyBPN4VyeuZpqZHyO5M8Yc7RdtWbmgb7ZxHekwnygOHEYkGw44f73Os0tJnRw
	GYK0jP1/yuDKPBS81NrZCauLFXfbWcs77Op/Hhw==
X-Received: by 2002:a05:600c:4e4b:b0:43b:b756:f0a9 with SMTP id 5b1f17b1804b1-441ac8eb213mr763615e9.11.1745860333367;
        Mon, 28 Apr 2025 10:12:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI3eEGBKgI0g/a7m3l8hddD1u69DnS0ugwSS0KDQtTLhljvtnZJ97Ojpq6J+GchDMn+0V3FA==
X-Received: by 2002:a05:600c:4e4b:b0:43b:b756:f0a9 with SMTP id 5b1f17b1804b1-441ac8eb213mr763265e9.11.1745860332996;
        Mon, 28 Apr 2025 10:12:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f32:c200:9add:4a7a:46aa:f740? (p200300d82f32c2009add4a7a46aaf740.dip0.t-ipconnect.de. [2003:d8:2f32:c200:9add:4a7a:46aa:f740])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4408d0a7802sm127236275e9.1.2025.04.28.10.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 10:12:12 -0700 (PDT)
Message-ID: <fc8117d9-57f8-4c28-9c46-328e4a3c4613@redhat.com>
Date: Mon, 28 Apr 2025 19:12:11 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/11] x86/mm/pat: introduce pfnmap_track() and
 pfnmap_untrack()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>
References: <20250425081715.1341199-1-david@redhat.com>
 <20250425081715.1341199-4-david@redhat.com>
 <554a6063-268c-49a7-883b-c39cf541c146@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <554a6063-268c-49a7-883b-c39cf541c146@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FYNUNwEPDMiYTr9JO0CW2lV3teSRHzawtL1Q4BOLsF0_1745860333
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>
>> +int pfnmap_track(unsigned long pfn, unsigned long size, pgprot_t *prot)
>> +{
>> +	const resource_size_t paddr = (resource_size_t)pfn << PAGE_SHIFT;
>> +
>> +	return reserve_pfn_range(paddr, size, prot, 0);
> 
> Nitty, but a pattern established by Liam which we've followed consistently
> in VMA code is to prefix parameters that might be less than obvious,
> especially boolean parameters, with a comment naming the parameter, e.g.:
 > > 	return reserve_pfn_range(paddr, size, prot, /*strict_prot=*/0);

Not sure I like that. But as this parameter goes away patch #8, I'll 
leave it as is in this patch and not start a bigger discussion on better 
alternatives (don't use these stupid boolean variables ...) ;)

[...]

>> +
>> +/**
>> + * pfnmap_track - track a pfn range
> 
> To risk sounding annoyingly pedantic and giving the kind of review that is
> annoying, this really needs to be expanded, I think perhaps this
> description is stating the obvious :)
> 
> To me the confusing thing is that the 'generic' sounding pfnmap_track() is
> actually PAT-specific, so surely the description should give a brief
> overview of PAT here, saying it's applicable on x86-64 etc. etc.
> 
> I'm not sure there's much use in keeping this generic when it clearly is
> not at this point?

Sorry, is your suggestion to document more PAT stuff or what exactly?

As you know, I'm a busy man ... so instructions/suggestions please :)

> 
>> + * @pfn: the start of the pfn range
>> + * @size: the size of the pfn range
> 
> In what units? Given it's a pfn range it's a bit ambiguous as to whether it
> should be expressed in pages/bytes.

Agreed. It's bytes. (not my favorite here, but good enough)


-- 
Cheers,

David / dhildenb

