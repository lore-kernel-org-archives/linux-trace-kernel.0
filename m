Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485801E1C36
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373621; cv=none; b=VwpHebXb+FQzFzPqyakbg8VMDRna7zk8RsE1A4Hk30/7HP64BjUmGb9eZKSBlLULHEws5lFCZQ0hxIdSLjbQs6+RKKnp11U0gr8ladqjM+EsE3/5Eab+vZt9EVRhkHAPRkfC0w2BChtwtohsXfQB42s9Bszw0nuy7RisZs9c4V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373621; c=relaxed/simple;
	bh=b+jhDLJHkKgFXrTkFBiIp+BoRVdVS3VlkME1F7fWwlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6pC1tMJEh1tmFvUGXeoGENYV3HQuUK1Y1j7xK963h33zI9IjlnX9HdZO6v096Xb660wikpyg46eTsAiP3+hMLverOUQnv2Bgu3kLZO3bQ6vpSVjtGbWD2N8yJpiFX2DaW9EoN+VgAAiNxjq9hWnodZnqqDCL7KlVDmhB4JYL1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/NQ+KPe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/NQ+KPe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753373618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gaIkxu5fgz8fIF+B9EOhggJazywKUE0YQPSwT8mMoTA=;
	b=F/NQ+KPef+ctpCytyczcTcNxAp2wiS8KGXv7ibSfn9JDBP3p1DWjGSCwLvTVCYWDH85O2R
	DWoRgTSmhaU9ERHiVUQN6yM8SP2npdFGLM4WIFiJL49QrBO2mLtDz6nnqMDNgin3y6PZjh
	Kfe5adMisgVjTQRehBwXrrYSJGicOmo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-6LphEz5bMb2Z6pp_CalBLA-1; Thu, 24 Jul 2025 12:13:36 -0400
X-MC-Unique: 6LphEz5bMb2Z6pp_CalBLA-1
X-Mimecast-MFC-AGG-ID: 6LphEz5bMb2Z6pp_CalBLA_1753373615
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-458709feac7so6471735e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753373615; x=1753978415;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gaIkxu5fgz8fIF+B9EOhggJazywKUE0YQPSwT8mMoTA=;
        b=F+YRwrk3l8wSHs2KNQ/99JllydF9gbbBYaUSiNXhLS9N8PqAhAJA1ENNItHTck6NDe
         GcXm4g89zO6nZU9klC4QNexpt+I2A8sGkVmklyTIcc0jkgkozF4v4O0HM3nJGF9wxm17
         kpHElRLfZ/Jd5hVO0tOuOx4MecNcAbOSdAuEMtGm1s8X2rfe3Utun/t13cQ75p9o61R7
         JvBcSPVBqBnsRxlaJ+t8XEMYKKkzBTBGPaC+AgtzfKdgVKW4VWCKqeAN6N0O4NjC/7IZ
         B1I+8ymqseoroJHMUmYklpun5GQQSXTjZ8rvdbbXzVn+ncuRJl3pbDE2cp1V9HiK/z/H
         xMAA==
X-Forwarded-Encrypted: i=1; AJvYcCUi6BT+jjgb2U7LUL8NwWBGtWOC4DXdzyx+scbQV/jOT3ClZObaebp/cEt46jLgmeqjTMdSRj/rF5cLeRkzFSviAgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNjbt+Opwe5gY81gzPbtGT38RWengch77eAlmVXJk0GmI9zGWR
	HGDIM2V9jujWzEFlWH454t/zpJPyD/Bin1MfEHFOVVTo5ysJlq8DtVTSJoaWUFBaspd6q+1znIW
	0xZsq/kdk9sR3u1AgYIiJx0i8/4JGNrS40QbLwKJSV2gCn67otm3qhdIMkArg6nrAJZ68PJ3rXA
	==
X-Gm-Gg: ASbGnct7fiXqiCimMUuBEzk3T7SVCYeYs2OHdOHqxyZqB+r8xN8DNwn5DaCJAKUGJAZ
	zQPh7LliQmoMAKpt/t+seBAtg4vjxbPWYnYFPL9/tOiDj8nWYSqqxIdTmZir+EyDbMvcDFfCj5K
	kn1sn4Eg2P3C/8YxCBFcD2rqCtVVqWK0HxvUSLs8Gr4BkfmIO+aFzAI5HCMaBnAV0MeEuA49xOg
	xrTBsJvaW7lUKNdjlCOcxfc0buk++6qNu/zsmh56STxDNkbPioVeolEaHZhzfO9bZgx0n8Q1rUL
	H63Z84i4Qsh3DuJquWL6eruy2fFiCevQYDcakcqy7yDUPxBMS9FfcL9EJoHKuPRhzLXJURP8N2f
	QM9eZoH9JinAn9K//UJtmTQFU1t/3ts+tg5esnW2WlFr7czGLMDHICktRN7F8VwN1
X-Received: by 2002:a05:600d:1c:b0:456:1204:e7ec with SMTP id 5b1f17b1804b1-45868dcee77mr64687645e9.10.1753373615156;
        Thu, 24 Jul 2025 09:13:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQzVab87ZyVdyPevqksyrADz+0j6DkLsR0citfF/5aTnOZXNGfrIPOMWvb8uUpl/UzSJwzCg==
X-Received: by 2002:a05:600d:1c:b0:456:1204:e7ec with SMTP id 5b1f17b1804b1-45868dcee77mr64687315e9.10.1753373614628;
        Thu, 24 Jul 2025 09:13:34 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:5e00:c941:d6fb:3e30:b42? (p200300d82f1f5e00c941d6fb3e300b42.dip0.t-ipconnect.de. [2003:d8:2f1f:5e00:c941:d6fb:3e30:b42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fc78f23sm2601100f8f.36.2025.07.24.09.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 09:13:34 -0700 (PDT)
Message-ID: <20325814-43fd-4509-b4e8-56f169e50e2a@redhat.com>
Date: Thu, 24 Jul 2025 18:13:33 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/thp: tracing: Hide hugepage events under
 CONFIG_PPC_BOOK3S_64
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <20250612101259.0ad43e48@batman.local.home>
 <20250724092847.1aa83756@batman.local.home>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250724092847.1aa83756@batman.local.home>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: STFxGENLofeA1vy05lRGzWJTP7xQTyJvhvBO4coWkjM_1753373615
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.07.25 15:28, Steven Rostedt wrote:
> 
> Anyone have any issues with this patch? Should I take it in my tree?
> 

Huh, I was CCed on the patch but cannot find it in my inbox.

If it compiles, all good:

Acked-by: David Hildenbrand <david@redhat.com>

> -- Steve
> 
> 
> On Thu, 12 Jun 2025 10:12:59 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> From: Steven Rostedt <rostedt@goodmis.org>
>>
>> The events hugepage_set_pmd, hugepage_set_pud, hugepage_update_pmd and
>> hugepage_update_pud are only called when CONFIG_PPC_BOOK3S_64 is defined.
>> As each event can take up to 5K regardless if they are used or not, it's
>> best not to define them when they are not used. Add #ifdef around these
>> events when they are not used.
>>
>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>> ---
>> Note, I will be adding code soon that will make unused events cause a warning.
>>
>>   include/trace/events/thp.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/include/trace/events/thp.h b/include/trace/events/thp.h
>> index f50048af5fcc..c8fe879d5828 100644
>> --- a/include/trace/events/thp.h
>> +++ b/include/trace/events/thp.h
>> @@ -8,6 +8,7 @@
>>   #include <linux/types.h>
>>   #include <linux/tracepoint.h>
>>   
>> +#ifdef CONFIG_PPC_BOOK3S_64
>>   DECLARE_EVENT_CLASS(hugepage_set,
>>   
>>   	    TP_PROTO(unsigned long addr, unsigned long pte),
>> @@ -66,6 +67,7 @@ DEFINE_EVENT(hugepage_update, hugepage_update_pud,
>>   	    TP_PROTO(unsigned long addr, unsigned long pud, unsigned long clr, unsigned long set),
>>   	    TP_ARGS(addr, pud, clr, set)
> 
>>   );
>> +#endif /* CONFIG_PPC_BOOK3S_64 */
>>   
>>   DECLARE_EVENT_CLASS(migration_pmd,
>>   
> 


-- 
Cheers,

David / dhildenb

