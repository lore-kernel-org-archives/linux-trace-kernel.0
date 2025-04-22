Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F04D1F03C5
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Apr 2025 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311810; cv=none; b=ghWau+JulH+HbLBiTaoFf/Xw1O11V1w+uBlMUEYvh0jkyEHlWEfboCPF0C/z0EMGFSki3j/SfN8Nn4vSLwKsq1BtbAHJVzaE39SM1dIEzEJ3H/Jg4UkhXSeAlDg7upC1iO80y4t0cBw/dPxoM5984fIRVsyGT2HioJUk9yoLH4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311810; c=relaxed/simple;
	bh=mQMv0280S9fiv6yWeg6+QdliY/NMtzBceavxZCtVgPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbcFo2q/+l1IVcL0r5nVe8z1zPF5z+wEn6aoK8wz58iDqWfvpNSUkZ+kMVDdQP5/PFQ+QlVBME+owEUiqA3VlMjQIxkV6SrOAYcXFQwiyUgoYu0xb7v60kQUgEXIOQWTXqqGgPCpJHv42JkyKUH3pp9JXh/YKFKNAIeouSXZ34I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QF2Tjqoo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QF2Tjqoo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745311808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z0fcTSDbZFobMICkC0Dhe3mC0DwS7Ydit7B1nvC9kvY=;
	b=QF2TjqooDPYmYVVSymjAu8TSMlOgmcnl7WOwTfKJZxw1QoyWTtHf8nIhwHfVe8GZdURizC
	vz8H7YfcuOsUGrFwXW/IOppWiR3HGbQJz1kmySMalMH2LcNdsWQmyswEpArbu4kz7VaZo/
	zID3kFLfyXlndL24G/1Vv9+U70fX2Jk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-3lorpJwfMGaxuE5BaULDkQ-1; Tue, 22 Apr 2025 04:50:06 -0400
X-MC-Unique: 3lorpJwfMGaxuE5BaULDkQ-1
X-Mimecast-MFC-AGG-ID: 3lorpJwfMGaxuE5BaULDkQ_1745311805
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43f251dc364so31368675e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Apr 2025 01:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745311805; x=1745916605;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z0fcTSDbZFobMICkC0Dhe3mC0DwS7Ydit7B1nvC9kvY=;
        b=S10s8XAxJWSFiI1ZDuUt+Ivy5qLXIYgm9hQ+ThQXWBcnWsA92cF1Io2j0UjdDSX1qi
         AhuEgGGugU3VdLIWQD+MYqkNH+wz3Q8Wj2dZnvy5rz20BZiWViV4Qh2QJUObtJw0qGSF
         BvYmVHM+b9LRVGvXSjpQK8Ukx776g4zFZuyqkulwCKsrv8zyUWLl/ciN8SKu+T6WbCBn
         8njugx6VG9CXJNDTWd9xF7za42+Rwp6Hl84vYTtPg3IiDiz2e7RC6UyVgbMPwLbJwWTm
         DjPCfOyYEy5+rZU6ZhnkYLuspnvVykxzBX5J9P8s/xxb8JYb3/R/P/J7vi/zlYWoeljw
         1ZoA==
X-Forwarded-Encrypted: i=1; AJvYcCXLdgMsGsRSqiXovZ7/n/a5CQ+UbgQCD3woaC1rqcVV1dmkIUTbDU7A6Ldx2ERo8Y0gTMx5fy0YHRLsTZLkaEYe/l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW65tB30avgdoRPKdW6a4PBZMPmCOQSsMw8Qw+XJFA2e1Qp3n7
	57UH+WdFUFu+gy+NPEUVc4KnGlM8AT/rfy0K8Hl+JXnGEMpmeVFTCrBdz782FzR6K8+MWuFXQk2
	Ixw98PAqQt0n6EEDuEjL6lt2JO5VMlU+npVKSouh9cNprwokJv8J0Pa/MIx4Yi/rgd7FVNw==
X-Gm-Gg: ASbGncsoyfv5lbbu7gV879QORTDmBEfv8Wj4/ylbPRBVd6cx3b9epRAvOxgcTMZgPrG
	eSd2+MT3+rZ3aodIXs9hbywd9l9rJjZcjr3VxQOw6YIfLnDfaD7RAao8cheaTuc3+ahWcmEM3lH
	d9D7avRnb7og+/N0aevM/K9BPzxnsyDKsVJQRNZuVobul01k2tOvSW40vH35gfDl6Ia7wy00fOY
	Q4pvGxTcCdCBn5s/ifE9Eqfpj/Ub1mvsCXTZATLpbssLB8XizqV3fiHSlQ3X/Per2aZMnFAz7J1
	eF3lV5DNv9PzXEnFC/H95MlFD0PPnZ9/VjTozPX6QX7mdmg98LV1PdXIXYoo/8tX9ui4tVE9sdF
	onC9Yu3DyGWAfUjTBUhD7Gg5pC3y8OPDVPmBk
X-Received: by 2002:a05:600c:1e0a:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-4406abfba46mr120321175e9.20.1745311805240;
        Tue, 22 Apr 2025 01:50:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECr66G2BVj6iMCdSW6EqVysasyZkIUlqhuAbaMtOvHNydc9OHzsoJRl5icUzYIKQjhjTTlZg==
X-Received: by 2002:a05:600c:1e0a:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-4406abfba46mr120320865e9.20.1745311804859;
        Tue, 22 Apr 2025 01:50:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c731:8700:3969:7786:322:9641? (p200300cbc73187003969778603229641.dip0.t-ipconnect.de. [2003:cb:c731:8700:3969:7786:322:9641])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5bbc07sm167240545e9.17.2025.04.22.01.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 01:50:04 -0700 (PDT)
Message-ID: <31ed0cc4-89a3-4f92-a611-06322c5d248b@redhat.com>
Date: Tue, 22 Apr 2025 10:50:03 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] khugepaged: Refactor
 trace_mm_khugepaged_scan_pmd() to take folio instead of page
To: Yang Shi <yang@os.amperecomputing.com>, nifan.cxl@gmail.com,
 rostedt@goodmis.org, mhiramat@kernel.org, willy@infradead.org
Cc: akpm@linux-foundation.org, fan.ni@samsung.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, npache@redhat.com, mcgrof@kernel.org,
 a.manzanares@samsung.com, dave@stgolabs.net
References: <20250418183920.273154-1-nifan.cxl@gmail.com>
 <20250418183920.273154-2-nifan.cxl@gmail.com>
 <d987a374-c83b-4067-9d47-62f3b758c8d3@os.amperecomputing.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d987a374-c83b-4067-9d47-62f3b758c8d3@os.amperecomputing.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: peJL5xFd7XB8qkwFo7axjBdSKe-AobAHqxDUX_kTvq4_1745311805
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.04.25 00:40, Yang Shi wrote:
> 
> 
> On 4/18/25 11:34 AM, nifan.cxl@gmail.com wrote:
>> From: Fan Ni <fan.ni@samsung.com>
>>
>> trace_mm_khugepaged_scan_pmd() is only called in
>> hpage_collapse_scan_pmd(), where the head page of a folio is passed in,
>> so refactor it to take folio directly.
>>
>> Signed-off-by: Fan Ni <fan.ni@samsung.com>
>> ---
>> This is a new patch added to the series.
> 
> The change looks good to me. Reviewed-by: Yang Shi
> <yang@os.amperecomputing.com>
> 
> But I think the two patches can be squashed into one patch.

Agreed, something like

"khugepaged: pass folio instead of head page to trace events"

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

