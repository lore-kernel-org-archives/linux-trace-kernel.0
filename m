Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9112D9491
	for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758197239; cv=none; b=jo6Ulw3hEhZPILDGEza456UVOuRT9MgI8J4xKYOp6hHFP/0dwISk5tUoI3DhL/pcZQdnYivXbwCks5PyrPONNa+v/EXWaA03/LNdt/tWnmfDGZ3ZBBAImujeX0i9SY2xUwmu5Bp10nq+9qS3Q6rTheCVrkYBQY6896p7qlLiCq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758197239; c=relaxed/simple;
	bh=jR2z4/Ns/toqEftPGwsWqkvDKxdd+Tns4ocJdbX6gEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/E8DRp2PrVdKhKmOVQwChMylSEBYptZpk8zAImVF49rdiNunFk2hvAJO6y0B+OCHZUWKkKzl6XTK0/QnWTNwe4urfjhNqFOufSTrCrMyY5JMu5f3S89DD0hnC1Aeno9BkrJ7s+zm8ljZXzNeLT7LAtux5nMjTpzaUcx/lj0fCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBHcFR0s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBHcFR0s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758197236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2DOPYjdyI/uAYvwMzh9uSYuRR4ZAJRzMcD+yFLiyXXI=;
	b=FBHcFR0sHYPDRTLkK29Xp55L4rA28SIS2Z0cR+ew6bY78KrGK8AjSU2RKG0rxo7Kwlnfyi
	zap5wMxdJUxLdcgPTidddDVo/k8vYvazZgX7w2SA4cO4bRxKAw47EaLDSVsnqq7o95s0WV
	oIeNfhfN7FXkOa03ABJSw/gjtnDXrJk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-h3axb-O6ODWsTrE3U-2sVQ-1; Thu, 18 Sep 2025 08:07:13 -0400
X-MC-Unique: h3axb-O6ODWsTrE3U-2sVQ-1
X-Mimecast-MFC-AGG-ID: h3axb-O6ODWsTrE3U-2sVQ_1758197233
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3e997eb7232so384131f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758197232; x=1758802032;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DOPYjdyI/uAYvwMzh9uSYuRR4ZAJRzMcD+yFLiyXXI=;
        b=ULOZ3bvkFohmVMSTG9ftrKq8D9uxisx8zaOPgu1zln2zOBovwdgBcGUy17WkB+5IMI
         AW9A1DBfWDTboBR+r3+iER/EPv12xUOXw9qR51iVeWZVIBLYaq3qfU0NJ2+1LG98efO9
         h7XclIAbWoiTTVkXKEzolt8vUKN+ZWVU/r214h7VyYVoJNvJlW8Q5N+VNJS2g9cxkoSo
         fOKNxuY3t224ecJQntgG5RjKjXrTx6EmTxrIgSM6Xc6dmKMDgTvfj7hHbgzLOheWv3mW
         K49Z8TSwlkoskEJtw/fMgW+Is3pDsMPCVwgcRjOZYGWUt5o9+fRdnD0yW2Uvhe8wKISZ
         mNqw==
X-Forwarded-Encrypted: i=1; AJvYcCVRu+9ut2p38YBlxH3Ytumvu+4LlgHaYInQb8x8uZoCMo8sWo8oohSKlxdpfR8E+Vu04zh7CQm6700h/jJ6bZzXS8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW5guURVFsN0DVhWDNGA9oTj1vrc5mbJWKC1erJWWlAaYQvIIN
	8nRTlJ3bcSkfVWAOGSQ2a4OQY8gH2afn8CcNQisZVrZAnBkbo28kDAAgFOxtvqoTjFBecLhBblu
	20z6WUG/972lkc9OKILKZRkyb+msjZM4ZcfVq99bvE6WUhlHkmCjZdnNYXJe56KMRb/wnjT0Y/A
	==
X-Gm-Gg: ASbGncstSqTeJ1n8uHLuFGU4fy8sSqAVQkBxaGYWtYFMgc6/hQzaVTmHl2kiA+Np1Tv
	ILiH0y4DMAQgrQmLGXrh9k2uI/WjnjZPx3zlegv6f0PMkNpZ/n6A87Mt5nkWWxzKlA3MU+I0pfV
	+D6pr/YU+iFfA8/h5YSIS6/NiGu2wmZSOnTuq/4GGUs2ZH7JQTK+yK/DwUT0AYEM6Hg+Du4h/eb
	NDNRSfS8Up91gxQfjh1UNX2hn3/eqCI6oh2FpNX+okl6aeyDIQsYMImsn5pdq2jS6R5odvUFzWn
	4mbeV8vIiDSfF3/RnglvwkzaXYCcaB+lOc8fIr8LM4EMrhaV5YvbkZUSw8sv9gISeig2F27C+j/
	peVUFuhf2RmEbOF6Pauq9I4AoDsmcxDR9/qzddhy5htxPRhD/9iffu/oldhQL4C+Hy3hP
X-Received: by 2002:a5d:5d10:0:b0:3da:e7d7:f1e0 with SMTP id ffacd0b85a97d-3ecdf9e6289mr5690008f8f.27.1758197232587;
        Thu, 18 Sep 2025 05:07:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIyAUyV0RX8DkIW+uDkvTX0Rh9rKHG8DzLg3Q/ZTX8yNIVuNU0lPJSNOJoMqZHCKyGphxyiQ==
X-Received: by 2002:a5d:5d10:0:b0:3da:e7d7:f1e0 with SMTP id ffacd0b85a97d-3ecdf9e6289mr5689931f8f.27.1758197231973;
        Thu, 18 Sep 2025 05:07:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:dd00:ca9c:199e:d2b6:9099? (p200300d82f07dd00ca9c199ed2b69099.dip0.t-ipconnect.de. [2003:d8:2f07:dd00:ca9c:199e:d2b6:9099])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f64ad359sm45788935e9.22.2025.09.18.05.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 05:07:11 -0700 (PDT)
Message-ID: <0c068e35-0954-43fd-b3b3-20786a6a12fe@redhat.com>
Date: Thu, 18 Sep 2025 14:07:09 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] vma count: fixes, test and improvements
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Kalesh Singh <kaleshsingh@google.com>, minchan@kernel.org,
 Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de,
 kernel-team@android.com, android-mm@google.com,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915153401.61cbd5120871ee7a4e5b9cae@linux-foundation.org>
 <aa95777a-8012-4d08-abcf-7175f9e2691c@lucifer.local>
 <20250916191645.15aae276992acafe7f7e723e@linux-foundation.org>
 <e85d0b14-28dd-418f-872e-57c0127ad572@lucifer.local>
 <20250917163231.b5f7b8012367f033a91e6f9b@linux-foundation.org>
 <cfabded7-442e-40d9-963a-597a42da581e@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <cfabded7-442e-40d9-963a-597a42da581e@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LD18uGSUzVESB9rBuVgOyxFaC9EwxRoPbx3BKyXVbpU_1758197233
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.09.25 12:29, Lorenzo Stoakes wrote:
> On Wed, Sep 17, 2025 at 04:32:31PM -0700, Andrew Morton wrote:
>> On Wed, 17 Sep 2025 06:36:34 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>>
>>>>
>>>>> Perhaps being less accepting of patches during merge window is one aspect,
>>>>> as the merge window leading up to this cycle was almost the same review
>>>>> load as when the cycle started.
>>>>
>>>> I'm having trouble understanding what you said here?
>>>
>>> Sorry, what I mean to say is that in mm we're pretty open to taking stuff in the
>>> merge window, esp. now we have mm-new.
>>>
>>> And last merge window my review load felt similar to during a cycle, which
>>> was kind of crazy.
>>>
>>> So I wonder if we should be less accommodating and simply say 'sorry it's
>>> the merge window, no submissions accepted'?
>>
>> hm, I always have a lot of emails piled up by the time mm-stable gets
>> merged upstream.  That ~1 week between "we merged" and "-rc1" is a nice
>> time to go through that material and add it to mm-new.  I think it
>> smooths things out.  I mean, this is peak time for people to be
>> considering the new material?
> 
> I'm confused, why is the merge window a good time to consider new material?
> 
> People have the entirety of the cycle to submit new material, and they do
> so.

My view is that if you are sending a cleanup/feature during the merge 
window you cannot expect a fast reply, and you should not keep sending 
new versions in that timeframe expecting that all people you CCed that 
should have a look actually did have a look.

-- 
Cheers

David / dhildenb

