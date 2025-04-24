Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0362701C1;
	Thu, 24 Apr 2025 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745507037; cv=none; b=kNAx9pZzTMCFvPwZymW2BEGs/E9MXEVkJbqJCOv1lmtLi18AxeWWMtJ5gpc9HP0QCtc4GjFPb+JZBI+3jAZLvK3MM84osj3JkcoMYhpzwLbgJf0BVJtfiQg8kLYl0myOPe79gZNUXF7Dw2d2Z5+PLVuuGEjzcn9wcV/9BSj2K0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745507037; c=relaxed/simple;
	bh=kvI7kjUwXN7aMCUd/KqC+XSsxo1YD9LUHguUFe5g3nU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/P6o0ltqUrJNjKio02JdUG4NmE1TzrzJPSxZcp/dkWnGI7b5pcOEZjMbl5E8IENQzwacFiZ1UTVjgQiKVEIj0ga3qshrnOTIcUjzd9C5cPDVZHnRB4F8FKvxKVWpGbIPY2hKV4BRH9PXZbY9jQjG/bFGtsboldLBP4UHPr2gXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tn64V9hA; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn64V9hA"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac34257295dso195140266b.2;
        Thu, 24 Apr 2025 08:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745507034; x=1746111834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5chFS9OMORzLKORouVhOFOBJ5V69Jo/Whb7Bt9/v68A=;
        b=Tn64V9hAt7oZpveFNmO1YXDvDMGpv722v4TZiu4f6iX8vKdJT0ARoWpTWxMSyZ+s3p
         /qSv3RlYQedlTQXTawyD+1/gQQ8ICXnrE79W3P42Yeb+QRtLsvt+GVPhrkgrzGZOnxsD
         6Dvu+TYmOBbV0888JEdwaWWUCLpgyk0Bmd3H8m+nOATl79FFqoqqYHuVwUuoTmMThGHS
         K2XxXqDWCIj0xc4HYeYLWUTebv8rHWcy2+xnyfG9Zexva/NPCxw/NVGlgfiOCSAp3bMO
         PPOS107sQ7iV2zAMYWSAuVAT7eUZY5eibZj9Oio4ddiI5NalxHFS4obHrY5cPhB00pC+
         bOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745507034; x=1746111834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5chFS9OMORzLKORouVhOFOBJ5V69Jo/Whb7Bt9/v68A=;
        b=TGVWLUbtq58AixEo/onDSF8qVrxBXipI19r90osXyei9ldPhKfRLo0JkeYr4UMxtfm
         EAVdQvsM34L6l1Rp6zEkxi6ZPgui5uJgloGMERnjbUcU5M+Tvun4vjppT3rXwi3+3qPH
         X7tLbUYBCF8A5YvX2ymtEuANum5r5GulB1Tymyxpp/tlkBX923WLbOavU4gR3XQT3oez
         AyiLg0HuhZpvJDAZeQRiyQwwRyTktIp7tJEv12OkMSlcO2ufr8mNNXFQgh6FAlpP4mcF
         loeog7DIZQmyzH18wmBkoSAk6JC0ZyG9hiqkzi8Ma9N65zeDiJvqH0R89+LDhl/ydol7
         yPxA==
X-Forwarded-Encrypted: i=1; AJvYcCUa6e13co8nxuk8FFHqrXORdd+uwfkqwoub/5J2z3b78qTzIAr4TLwiPgP56sJznPTdbxDztCZtb5Rw0Q+B@vger.kernel.org, AJvYcCV86v7X1z6vr3QWTVoJ9OMIFtYKV7T2N+s+rGHQJM5dZVcvEMdvsx1goOhPvGAeqdKvCcGxCWHL3b0nuY/Pkmm9PM+N@vger.kernel.org, AJvYcCXchajTP83ra7eeXxy33oBQ3Fg1tFoJxv2BrlaZPk5M90mLvyWsM/cJiDx0gSEoAKqT/hpLj9UYuxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrCx97ZxEhO1yUS1c6EIK5K2KwhWHdP/iC8XNhlQU7d8mBHMIx
	n5MYbJvolwcmKFQxwvo1l3N7xBg55+SaMUjckHGS2dEkyHldlafr
X-Gm-Gg: ASbGnctiAGxOn3i5K3o/DpUrwCuPK+SKaFJUNVpvErGaQX1lr/lSjzeB9ErYl5CAlbE
	Sz8IXzCVmxe7P+irse0wjT3wmsNzg/fZ2S6n8udrK3NlFN8VE94Izxc1VS5jAuW4ijaXE2rQ+MZ
	GGwMf3BRhKjCBPgPbyAGTeIW406N/+d5tS0wbn2Ifc1WJ6ItruYHEHKCsLRix3Fw0pgvLIj9ath
	1u926+yz3VhTvYFovwKNa7rUhIoUqWslGqjWthce4YG1VGKjrzcSx3YYDwk7v7l6tfYM0UhUTn0
	aXDGIrggmCE/v860dgHlldYYkRjfjEdKjO9rMRLFn8UTDyWumkifINGbVAarvwWO4aRIIlPwMlc
	2vu3N15/UiOfu
X-Google-Smtp-Source: AGHT+IEco8mssxoawhcAhtRNlPLqlID5zUq0vN72hKI33kZSrx4fa3BkNkpoQ0Lld1zoeiMfeTtTrw==
X-Received: by 2002:a17:907:3c93:b0:ac2:9093:6856 with SMTP id a640c23a62f3a-ace573a6e8cmr320455066b.54.1745507033210;
        Thu, 24 Apr 2025 08:03:53 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1cca:202:d408:3819? ([2620:10d:c092:500::5:5042])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace59c260d2sm120633666b.145.2025.04.24.08.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 08:03:51 -0700 (PDT)
Message-ID: <b22e222f-1d6a-4685-871c-1aaee319b744@gmail.com>
Date: Thu, 24 Apr 2025 16:03:49 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/12] Documentation: mm: update the admin guide for
 mTHP collapse
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, ryan.roberts@arm.com,
 willy@infradead.org, peterx@redhat.com, ziy@nvidia.com,
 wangkefeng.wang@huawei.com, sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 dev.jain@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org
References: <20250417000238.74567-1-npache@redhat.com>
 <20250417000238.74567-13-npache@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250417000238.74567-13-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17/04/2025 01:02, Nico Pache wrote:
> Now that we can collapse to mTHPs lets update the admin guide to
> reflect these changes and provide proper guidence on how to utilize it.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index dff8d5985f0f..06814e05e1d5 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -63,7 +63,7 @@ often.
>  THP can be enabled system wide or restricted to certain tasks or even
>  memory ranges inside task's address space. Unless THP is completely
>  disabled, there is ``khugepaged`` daemon that scans memory and
> -collapses sequences of basic pages into PMD-sized huge pages.
> +collapses sequences of basic pages into huge pages.
>  
>  The THP behaviour is controlled via :ref:`sysfs <thp_sysfs>`
>  interface and using madvise(2) and prctl(2) system calls.
> @@ -144,6 +144,14 @@ hugepage sizes have enabled="never". If enabling multiple hugepage
>  sizes, the kernel will select the most appropriate enabled size for a
>  given allocation.
>  
> +khugepaged uses max_ptes_none scaled to the order of the enabled mTHP size to
> +determine collapses. When using mTHPs it's recommended to set max_ptes_none
> +low-- ideally less than HPAGE_PMD_NR / 2 (255 on 4k page size). This will
> +prevent undesired "creep" behavior that leads to continuously collapsing to a
> +larger mTHP size. max_ptes_shared and max_ptes_swap have no effect when
> +collapsing to a mTHP, and mTHP collapse will fail on shared or swapped out
> +pages.
> +

Hi Nico,

Could you add a bit more explanation of the creep behaviour here in documentation.
I remember you explained in one of the earlier versions that if more than half of the
collapsed mTHP is zero-filled, it for some reason becomes eligible for collapsing to
larger order, but if less than half is zero-filled its not eligible? I cant exactly
remember what the reason was :) Would be good to have it documented more if possible.

Thanks

>  It's also possible to limit defrag efforts in the VM to generate
>  anonymous hugepages in case they're not immediately free to madvise
>  regions or to never try to defrag memory and simply fallback to regular

