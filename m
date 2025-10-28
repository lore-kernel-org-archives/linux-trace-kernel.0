Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A6134B419
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673799; cv=none; b=gd5+8n2kPGnQPMbTIYVr1ihU4uAWni5vXwMhUXczcOKwKIWFbOpI9ptCgn8yQOtLXiSvAr2pI7r55ABEJ84CzLPNvasOxyqtaMLMfjd81z6tPhs1YIRuOIQZ/Vk8fVcAflvHZoVxaXQ70zSLLsXSjXBvPochK86k33hP17ib07o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673799; c=relaxed/simple;
	bh=HNDUMYeo/L/RCwN82toFe06UY4HVw5LK/Mt12pX+Xkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYEh5Dhcs8NJTvseNaI/wg+XPz19mOWuWU/CJUefmRoQORgSlB6//FAY2yZWkXsM1yh6gZHqFzLPxHupVh+LzTzS8ZeMNOzChJA9zWOw4UAd/5lJqazTpoafLRJX7Ucll6D8XWMzE+uOHPsfgq+sjLf7H6m5pXSEd3A+o6KOeWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IuRHJVrh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuRHJVrh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761673797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0wjUs/xTYbM7Fdac3xo6xGaBum9uo0673qS9j9wmfiU=;
	b=IuRHJVrhtFzGlySiVW3KmaaxDIa60D1vhHr4RYV9cklcjRUNIs1AARCyEW2QypOrUzyr+9
	5HpF547tyEzKRB7Om6Mhl0IUSMUw3Zwe9EabLj6Vi3tf4lX68/KlCEUH0M3vfmBQLvLzwg
	3urF7733UOC5PyfcaMfiLUKk9sVOI3k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-AwgGyLEVNNyKxYPp7uJaNw-1; Tue, 28 Oct 2025 13:49:54 -0400
X-MC-Unique: AwgGyLEVNNyKxYPp7uJaNw-1
X-Mimecast-MFC-AGG-ID: AwgGyLEVNNyKxYPp7uJaNw_1761673793
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47105bfcf15so35951325e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673793; x=1762278593;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wjUs/xTYbM7Fdac3xo6xGaBum9uo0673qS9j9wmfiU=;
        b=jjPn6CVBGwPCBNc94aDYYybOsQuelnr7mje/MRDEEbAmq6smWif+iYRFXAv09rJpIi
         OKN/nyGhXyMqlLFIiQmZkqEbL2l4Gs69TILT15QVhb5CeRBa2uA71Gr6z/kOXFN7tcn8
         N5htWdHgaUryH7mkSescUPUiPp4R9KvTEsZkvr36+bFWUApLt7nV7vKN9feBYlRz8ND4
         Gfc2Dw7eOnOZ+GxzzNzfBJu6vce2Mv2rwC8zpwD8aI1T1UN78v9rE3ZHtZBPhwQoDZ87
         PWJX8HEKQir+8S9UN+eI5T2TOjDgc9iQ618KjOii1T8Vp9Xr4ShlwdI97v1yaQhfyP/Q
         eZQA==
X-Forwarded-Encrypted: i=1; AJvYcCUYRmUtD3Gp98Gf0jNzM8J+eG+dPZlWcUifvaT+Af1s2smh/aeP25dxP4qNvxUtssEGg/YPm5zR0T6pNS/1cbO2aMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPFh5QFn5hi2XRSL9kX4CNiOHoGE7hBaqLBzF2eXbHjkSljDFj
	c1lluegKVpwWkk0KOEHf4uBhRtUpwAICShAtrZmtreqoEvSvPfISY1vtZqIk3D8G1o6dXSVfKpr
	AfbOAj/1EhuEq568OzdzIKou+Ffw9dNGqLccKqxJ/k8Sp9fe+VepwP9yiqeeleo62qubSz/dc6Q
	==
X-Gm-Gg: ASbGncsYHTbbYNMuWG7277vXEhvRqHAQnsu6fsK6eNpNJ8O3ZZ8uZbIaZwIZ7bQmyd1
	j1xBYVbwAjkPMXyfO+FaGNj2n9ANpNJ2g/zi8BqdGH95L2Wj5halue4pijWKePHgl+En9RzxWjM
	QJ+xLU7nNEYlico2X/GLkSDRbnFZFStdXmVaaDMGmoagmQVuiy/vNC+2bUCSX131v9SKgmKnH9K
	2FdXvvhK5Q0NFbSyQCgq83uHUew8+cj2M+P5VHO/+4ovhkL9NU7P9xcvUGjnvVrFPh+/qdE67Gb
	x93IKpEFKMOLuNaEGutd7Elg2kJTFpCXUfpmJSWPoTtZsce3dCZKA2LM0PsaCV3LuyU1qZVT0sN
	zmBTJTbqKa+GyOCUQEdjn0ytfvR1Hodnc+q47aPw=
X-Received: by 2002:a05:600c:3f0d:b0:46e:2cfe:971c with SMTP id 5b1f17b1804b1-4771e283ed6mr2495585e9.0.1761673793417;
        Tue, 28 Oct 2025 10:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcx7klDKQsDly0rERnv58qXRJAfJupSMrXo3pXhmlMb1uRNgLUDuTQsDYYW7kLhyUZ6FSXvA==
X-Received: by 2002:a05:600c:3f0d:b0:46e:2cfe:971c with SMTP id 5b1f17b1804b1-4771e283ed6mr2494955e9.0.1761673792961;
        Tue, 28 Oct 2025 10:49:52 -0700 (PDT)
Received: from [192.168.200.155] (host-80-81-2-50.customer.m-online.net. [80.81.2.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e387baesm2888955e9.2.2025.10.28.10.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 10:49:51 -0700 (PDT)
Message-ID: <f36ba14b-f2e7-4efb-92c0-a4d4f58b1bfd@redhat.com>
Date: Tue, 28 Oct 2025 18:49:48 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 mm-new 06/15] khugepaged: introduce
 collapse_max_ptes_none helper function
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
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
 <CAA1CXcA4AcHrw18JfAoVygRgUZW3EzsN6RPZVrC=OJwSNu_9HA@mail.gmail.com>
 <2983c165-8c13-4bb9-b2f8-bfe8508cce43@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <2983c165-8c13-4bb9-b2f8-bfe8508cce43@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MTSGGCqv8G4sNALFWdukj6jaaWwUeUGTxjZO7i5BguE_1761673793
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Hey Lorenzo,
>>
>>> I mean not to beat a dead horse re: v11 commentary, but I thought we were going
>>> to implement David's idea re: the new 'eagerness' tunable, and again we're now just
>>> implementing the capping at HPAGE_PMD_NR/2 - 1 thing again?
>>
>> I spoke to David and he said to continue forward with this series; the
>> "eagerness" tunable will take some time, and may require further
>> considerations/discussion.
> 
> It would be good to communicate this in the patch, I wasn't aware he had said go
> ahead with it. Maybe I missed the mail.

Just to clarify: yes, I think we should find a way to move forward with 
this series without an eagerness toggle.

That doesn't imply that we'll be using the capping as proposed here (I 
hate it, it's just tricky to work around it for now).

And ideally, we can do that without any temporary tunables, because I'm 
sure it is a problem we can solve internally long-term.

-- 
Cheers

David / dhildenb

