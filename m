Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83C6184E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Apr 2025 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745861007; cv=none; b=BtDB1TakziGZyeq8i/g4FiqtJbEKst1sexCmzGVsobLmSenIv8vaBVWgEE5mZnRlXtdomunhczz7vX3CCcxnxAA/SywOsX9Eec7EApApDowlyuGC35lpobm1juveaDcuzlqQxvYzRHxjNllVmkGwZYEqk3XL40esQznHsmVOinU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745861007; c=relaxed/simple;
	bh=UnQslq6Nx8NALIhTnrfcxpjimXFinlYSvQAjOQuu+QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWVKCWua9+8dagFyDp0VW4Pl4yG2sZh6VSH45t0wBK0LXtXTNfyDnV7lcuMkthA14Q/sPVqO1x5TJAxiL0py/6yD4IQC2WSiIdQN/SObexF2rpnYRdB5KW46ozgH8k42iAzfUUelDr8k3nUIxwR/xiWlDWQkIVq6CMsrL+KHzS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HVyg9HAy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVyg9HAy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745861004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wY4CVzX+uN3IX3vcq1iWMePW9o5nKkePYfy/0EKsFFQ=;
	b=HVyg9HAyVUuVBmGvQdxvtQ5+JFVp0Nsj0ZAthEVY/B+K2vQXm33fqkUXIwjdP7iTOT/VuJ
	pqrWZ2fPUl1qaGF9ClhPhsrC3b2m6TPGglJJW2Vy4lSGdZV1+dDoYtDYsFsbOjDpHLm/j4
	XQkubRpTALTS+/ow43S5/3MT6J/vlDg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-mGnwqYQhNnSxx2_WpeBctA-1; Mon, 28 Apr 2025 13:23:22 -0400
X-MC-Unique: mGnwqYQhNnSxx2_WpeBctA-1
X-Mimecast-MFC-AGG-ID: mGnwqYQhNnSxx2_WpeBctA_1745861002
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3913b2d355fso1385232f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Apr 2025 10:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745861001; x=1746465801;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wY4CVzX+uN3IX3vcq1iWMePW9o5nKkePYfy/0EKsFFQ=;
        b=I7Avt5namlaur+8t2UlaTqxJnYNr7AWw8fhT5wP1gK75zyD4B/VPbsS9HFwlCougiu
         gbfzR2cOTAPvS1aYaH5em0qakKigmAWy2VceCiN0F8f8aJLnVmN8cmoyYHmmxNEs/uJ0
         jzvP1URqmJMLrD58PTRwRThm3Wg7+T9089v32KtptFghOD+O4lDBagahdPi4CLWmcxJ2
         i+MRbMsFBAXb9a8sHF2ZxiLsx2F+kWLSfoI91W+GRu985no7IE9NLWskIqnRnN+G1Wis
         wbD9sf1s7XXwfwt5sFQjTWSUQDdtLwjFc6B7B9EX0oDTHm0ZNOxwwBjUsGZNEhgUMMfH
         hngw==
X-Forwarded-Encrypted: i=1; AJvYcCW5VIL0APL+cGmA6YDaZAb0TjKAAGi3caBM6H6Y4Bfsu0lnfs9uHYoiENiQdcDRbhfSCbXXhYmsgRxO0K3T+7wouQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Hwt4M8IqoaxKI8IQAmfD23P8mfrgvEKalxh2hscXmKbsSctD
	S9hDRezCwG8BUenXHy65JHLY1UVImTEB/t1OTuHff5E7eF1WaUazjxms4ewiouhb8msBkjrzp4m
	oqev5C8BtwD+T/DKSpkaUBMdhQZreGLLUq4xgUBEzOnRpbOOY03oOHSRPTk/VHVGyKDN5rA==
X-Gm-Gg: ASbGncvrOq9D5qOvhTsphSFEyUDhdvsfnEZTTf/AhLb49yXqaty6DKO5zU2jPjaYQpW
	jPqeWDc2ojDv1eqD3A6V4/WKaJoVYzkKybDRMWYWrIm74nQtCTnEheIry4GF6cVvlfiVDbRGjTc
	IOpiAwQpbrYDTIhYhgWgbNoL8soef/8eI6wLNZM+AYF11jZ1ozyp4g+li85HdPb9isO7wE/HE4h
	tvFXWVCkqGUkUzF2zTwbfpke9e9XwAn+EdCgCSvgFqKe1rqsHhj/I72II70kZhKu2+SZADODh1x
	izSguFiyxf1y4t9p5+amz0i3SwYwyiXBBWiQP7rWxIfQthQpttrzFLTCT8kc7DvH7I0f7EOCGfV
	250nigs92PMIRMeBMjK27HHJhsEla9F5Xr/uMEg==
X-Received: by 2002:a05:6000:40cb:b0:390:f394:6271 with SMTP id ffacd0b85a97d-3a07ab85dc3mr7533527f8f.43.1745861001681;
        Mon, 28 Apr 2025 10:23:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIb09GQKvUWlrzMymYxayYtDPK47jESgQU5kjQqNoI7xzmODDrJ7lADPOND7gNymtIw+O2CQ==
X-Received: by 2002:a05:6000:40cb:b0:390:f394:6271 with SMTP id ffacd0b85a97d-3a07ab85dc3mr7533500f8f.43.1745861001273;
        Mon, 28 Apr 2025 10:23:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f32:c200:9add:4a7a:46aa:f740? (p200300d82f32c2009add4a7a46aaf740.dip0.t-ipconnect.de. [2003:d8:2f32:c200:9add:4a7a:46aa:f740])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4408c80174dsm135486465e9.0.2025.04.28.10.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 10:23:20 -0700 (PDT)
Message-ID: <884fab29-e16a-4663-8e33-885bc70ca2f7@redhat.com>
Date: Mon, 28 Apr 2025 19:23:18 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/11] mm: convert VM_PFNMAP tracking to pfnmap_track()
 + pfnmap_untrack()
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
 <20250425081715.1341199-6-david@redhat.com> <aAvvQ1h9bg11hiqI@x1.local>
 <bbadf008-9ffc-4628-9809-2d8cf104a424@redhat.com> <aA-n9hvSX9JLsRM-@x1.local>
 <7a26e29c-d889-450a-a5e1-ce671f09e4c8@redhat.com> <aA-rtji7ujQgckbM@x1.local>
From: David Hildenbrand <david@redhat.com>
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
In-Reply-To: <aA-rtji7ujQgckbM@x1.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b0P9BLOptaFLNbUPgs8UTIFwu-BRFDrkvaGdq-P1AlU_1745861002
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.04.25 18:24, Peter Xu wrote:
> On Mon, Apr 28, 2025 at 06:16:21PM +0200, David Hildenbrand wrote:
>>> Probably due to what config you have.  E.g., when I'm looking mine it's
>>> much bigger and already consuming 256B, but it's because I enabled more
>>> things (userfaultfd, lockdep, etc.).
>>
>> Note that I enabled everything that you would expect on a production system
>> (incld. userfaultfd, mempolicy, per-vma locks), so I didn't enable lockep.
> 
> I still doubt whether you at least enabled userfaultfd, e.g., your previous
> paste has:
> 
>    struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   176     0 */
> 
> Not something that matters.. but just in case you didn't use the expected
> config file you wanted to use..

You're absolutely right. I only briefly rechecked for this purpose here 
on my notebook, and only looked for the existence of members, not 
expecting that we have confusing stuff like vm_userfaultfd_ctx.

I checked again and the size stays at 192 with allyesconfig and then 
disabling debug options.

-- 
Cheers,

David / dhildenb

