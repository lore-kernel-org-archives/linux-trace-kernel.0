Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DF028E576
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 May 2025 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747142274; cv=none; b=pY6ct6AiIgXNc1qEnj9F8P7nKtSMEjAfHglydVvZuMGarpbT08z2fSRTQ6BXIdGAW/iN+PFZZ91xaXvSyMi8TvYk9rfZwfNQdk1sUM8+GgZ0SFZDa2BD/pOey1tcQ9s58kfAG0zYX7DaMwj0SVQyLxvYM+aAYj4fYCLGJKc1VbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747142274; c=relaxed/simple;
	bh=+IIeoefvax3z2R5UYJE415V8jYsDaKdQT79nFLsrOxk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NnhI76/isT22CLEWjMUm7+ZXbeRrShqDkl2JumIahwZ9GGSl6Qu89n0rvCv5qlY0gwGt789l0uheBbNff+k0FCQ+F0RkUXbNuAF/C3WohXYkSX/LQGdvKvvWt4KHJgvKmCqPTzJA4l286oa7Bi2AwpOdmH0Vt0f2IlrpOJmwpp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VRoUVt53; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRoUVt53"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747142271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HxxQXVVSK4rEec2wlzYJRfWIp4Ihbr4/ZHGnPtMfr/8=;
	b=VRoUVt531MvB2uok0u1owLwJwzNI3/fFXKzDJ4yreRfhpwSmMUKZU03fTcLfkR4GgoOMZQ
	lKY6prSrvJRJM2dCa3nz1+pKgaQzaFr5qENcMNUGU19Pu8nIVxg0vPJZeEKiZz/k3hydO7
	XQGLO1ESjgsSn4FA6D9TnWYFwlCYa90=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-sjweNs9uMNm1IrVVvA-MgQ-1; Tue, 13 May 2025 09:17:50 -0400
X-MC-Unique: sjweNs9uMNm1IrVVvA-MgQ-1
X-Mimecast-MFC-AGG-ID: sjweNs9uMNm1IrVVvA-MgQ_1747142268
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso28608685e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 May 2025 06:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747142268; x=1747747068;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HxxQXVVSK4rEec2wlzYJRfWIp4Ihbr4/ZHGnPtMfr/8=;
        b=Kvx9Z9g+Sf0qLOTJtO29wIZhPOqXANbnEMGGlSJGlxJq3OMhQuRgY2RMlOW9FxIvTz
         Aer5OqdptnqmwHvUxtIyHwFcMWgHZoHWsSI9gD2R+/zuZ4vIZllD1mRIEWBJEiP4LWvH
         SD4PPOZsO3GGAAjvtgkJUlSJTEDB4V42NsOXNo0q/O0DCfNLr6eUYpeMfRqMKQsu/fmU
         jZ9dEPLGJqsnIHBmaefiiaM3exJDcz7apSGVPebI/8/QakZoERlD+MV856d1AlVUkQES
         MmNrvx6iuJ0/f3jzfnjiqVoa8/z+lKgClxu0DgrAUm8uENh5MJBgoSsxcJNuDP7+VLkN
         jDNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsZLOsoR8TdI6VimfvBQD9UZMaXofm/MmQgUHvZvu9OVYgKYFN0gq+pRwmeasaioteVihn3ZI1IRwbBa91Pck9DxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YynEbhNV200zWIn10QmUtN49uQvmno5WPcagiBpOjcVZRKEpuqQ
	sGvXhPEWZmatgsb9xYjGnidSQ4gWxLTw2MiBOuAIwAsn73O+5gVpKH/5xJqauqaBZm1veQw67yh
	aVWc5Cy+pSA2/kA0NdazbNUPXCMkUSZM2EaNBettdV13/er/azb94yWASxEAO+cYRngwlIg==
X-Gm-Gg: ASbGnctdKI/BK+HAFlJc+3P6fyJK5hKCeMNQ7omatBQzIfmKEK1872a2/W68cfjtgcW
	IdMqCvb/KF2rBSZCL0d0hB49FVUCXzhBw9VA7hUtp/+vFWFJlhKP0UFDBMA0P4aMlKPPhagNxuX
	1/7260AzWS0E5wdTWTHFjDZ7nwS7TgLL/jaJh/Lc+m+c/zaWGm8pq8cedcogGYhwEYL8JWnKwYV
	INhNwn51lrvs/m9pIZl9MS2eQ5izKRSpf8wATmTTsdFj+aK4Uw/zuMDRuQuvqI96b+8qBt+vFI0
	panCB8nAwmL0P7brXi+QO19XWs4orEZUCMynbjVmlQhiOCCUNmMKmxLGbBn8zDm3H22eIFJ19IC
	gCMikD2YisxatVDWeQgKPiCSOmmhoU7OQS63Gqn4=
X-Received: by 2002:a05:600c:37c8:b0:43c:ef13:7e5e with SMTP id 5b1f17b1804b1-442d6dd1de7mr130325475e9.26.1747142267989;
        Tue, 13 May 2025 06:17:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHantouXqVhTL24de5TQ1dXzQkhUda30erwWtCLKJNo5hGRQspQ1sW+fpX8kF19xdrg7cbZww==
X-Received: by 2002:a05:600c:37c8:b0:43c:ef13:7e5e with SMTP id 5b1f17b1804b1-442d6dd1de7mr130325295e9.26.1747142267655;
        Tue, 13 May 2025 06:17:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:1a00:4fdf:53e2:1a36:ba34? (p200300d82f4d1a004fdf53e21a36ba34.dip0.t-ipconnect.de. [2003:d8:2f4d:1a00:4fdf:53e2:1a36:ba34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd34bef4sm214544335e9.24.2025.05.13.06.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 06:17:47 -0700 (PDT)
Message-ID: <8323f942-52e1-44b4-b599-e275f1c66ede@redhat.com>
Date: Tue, 13 May 2025 15:17:46 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-stable] uprobes: Revert ref_ctr_offset in
 uprobe_unregister error path
From: David Hildenbrand <david@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250513122125.1617722-1-jolsa@kernel.org>
 <60b3386e-dbb1-4fe9-bc38-d62eba4d9c50@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <60b3386e-dbb1-4fe9-bc38-d62eba4d9c50@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z5MqHfDHUpQ1su3gI_MZCjbGX3DaMsJyn7SGTgWa9c4_1747142268
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.05.25 15:16, David Hildenbrand wrote:
> On 13.05.25 14:21, Jiri Olsa wrote:
>> From: Jiri Olsa <olsajiri@gmail.com>
>>
> 
> Thanks for debugging.
> 
>> There's error path that could lead to inactive uprobe:
>>
>>     1) uprobe_register succeeds - updates instruction to int3 and
>>        changes ref_ctr from 0 to 1
>>     2) uprobe_unregister fails  - int3 stays in place, but ref_ctr
>>        is changed to 0 (it's not restored to 1 in the fail path)
>>        uprobe is leaked
>>     3) another uprobe_register comes and re-uses the leaked uprobe
>>        and succeds - but int3 is already in place, so ref_ctr update
>>        is skipped and it stays 0 - uprobe CAN NOT be triggered now
>>     4) uprobe_unregister fails because ref_ctr value is unexpected
>>
>> Fixing this by reverting the updated ref_ctr value back to 1 in step 2),
>> which is the case when uprobe_unregister fails (int3 stays in place),
>> but we have already updated refctr.
>>
>> The new scenario will go as follows:
>>
>>     1) uprobe_register succeeds - updates instruction to int3 and
>>        changes ref_ctr from 0 to 1
>>     2) uprobe_unregister fails  - int3 stays in place and ref_ctr
>>        is reverted to 1..  uprobe is leaked
>>     3) another uprobe_register comes and re-uses the leaked uprobe
>>        and succeds - but int3 is already in place, so ref_ctr update
>>        is skipped and it stays 1 - uprobe CAN be triggered now
>>     4) uprobe_unregister succeeds
>>
>> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> 
> If it's in mm-stable, we should have
> 
> Fixes: ...
> 
> here
> 
>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>> ---
>> Please note it's based on mm-stable branch, because it has the
>> latest uprobe_write_opcode rewrite changes.
>>
>>    kernel/events/uprobes.c | 4 ++--
>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
>> index 4c965ba77f9f..84ee7b590861 100644
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -581,8 +581,8 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>>    
>>    out:
>>    	/* Revert back reference counter if instruction update failed. */
>> -	if (ret < 0 && is_register && ref_ctr_updated)
>> -		update_ref_ctr(uprobe, mm, -1);
>> +	if (ret < 0 && ref_ctr_updated)
>> +		update_ref_ctr(uprobe, mm, is_register ? -1 : 1);
> 
> 
> Hm, but my patch essentially did here
> 
>           /* Revert back reference counter if instruction update failed. */
> -       if (ret && is_register && ref_ctr_updated)
> +       if (ret < 0 && is_register && ref_ctr_updated)
>                   update_ref_ctr(uprobe, mm, -1);
> 
> So how come this wasn't a problem before?

Oh, or was this a problem before? Then we should find the corresponding 
commit that needs fixing.

-- 
Cheers,

David / dhildenb

