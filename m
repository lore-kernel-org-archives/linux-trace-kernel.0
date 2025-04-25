Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49811A5B92
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745611001; cv=none; b=p5r02SjCEH5E2LOFKC+xkW4PngrmzKj6yazYgloXhzbUeXrXB0NHi1pGOpsoxhJoB09ksx69w9RvhSR1gcfqHxG++IzMg3F2JAuVU46cI5lE80f21lkwBZEiAxyqTFIFD4PGHcQs21XMKX/o1YuZDo5c33xhq2gPKG5CRFr4OJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745611001; c=relaxed/simple;
	bh=jqhNbWJZJQKm3jDFrgR1Oy94a2yWCHf95UZOSaEQwxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/Xl9Lh/dsEMe8Hw2j5Tl9Y7dgSzDGmD27DiI27IU43YHWKISlgmf3r2MHcN8LtymXefQaJt+TAFIwvFFDXcXbFNJmDgkMtcquCLxsDS8V0J3waWUZY8P+UMSEFLT5969AYU91O0U17TVy97evV0YVQXLqDB2naz8Z/u/EDFED0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAULLfte; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAULLfte"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745610998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bE2Dp5Yo0pObZA0Gc62tH8dA81bjnFJ9ScY4Xen6Glg=;
	b=UAULLfteh0HWaVIQ9RhjgnIveRioHIiJVDk5zWR80Wr72A4b1nnJFLG9y9npYNJM4QYFiO
	dAbdwUrVmhAoGlxIYau1sLTWQe0i/8evUuGiEZ+mznmEWD3fiMWZxSuyOodo4nPcKlt3wO
	wBpmHD/WTvMLp0E0jfMCOnzVS9bSXUc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-GUt9rrI6P_SLIJhPT0wpYg-1; Fri, 25 Apr 2025 15:56:37 -0400
X-MC-Unique: GUt9rrI6P_SLIJhPT0wpYg-1
X-Mimecast-MFC-AGG-ID: GUt9rrI6P_SLIJhPT0wpYg_1745610996
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so12880965e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 12:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745610996; x=1746215796;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bE2Dp5Yo0pObZA0Gc62tH8dA81bjnFJ9ScY4Xen6Glg=;
        b=GLyTPq0SkAbUf2KOiGYkAstecyqHw4kvtFGHkoZu5TDmJwxDWDqBL9/cP/LYefxxOW
         VeCSjj9/XnMvtM/IIt8gQtKNjmowYmvcHnd79wouPUzMjC+bb+O3zKJdyIz30CiitifQ
         2Vp4Lo85EB0Rn/9tycil2k7KdEMAe7PmFUw32LqLAAymlKxhLHpozF/0Un9/VhDD4hp0
         ECFHjHqZatEnmTokvtLEh0+L4vTXM9KSx0HixleDupL4j2fc3TYdO7+An8kETtsHcHBs
         6nOtZyAjS++dFthW53WDRiSZ14nrqiUrP2T5Jw/cEhXXU3xgtt27fgJt2qutupLbckcR
         HfEA==
X-Forwarded-Encrypted: i=1; AJvYcCULju2bCCbhtzi8L2fUUfFESF0g3A1KW78HDi9vosEA8QpZK/tZWQdWu3ouontH2EvjdeU+sEmMpXyYUNslEoIq/ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFov/8SljJkZ2Ht5Ju2zehM57weu7KTSrTfN5a8KSDTGqpFm7h
	ZKNV1oCdgOiTj7VDVQGEEziZB5L5kxklb7sV8xoMWdbfAnBXwmrU2q6imORwL6w2Y8ZfmE5JQgt
	S56cUY4BcsirS8bg44H17TJTwTELTBpG4B8ZAHr3DjMSEW/pn3a8DUjTMnUC0q/O2IuzrGQ==
X-Gm-Gg: ASbGncvDosNIgp0IWJJ8raOaksF+rR2fp1eHOAzn8fEGVXhbE2wOfs5KkXYL8gd6qNz
	SzvPUFT7n+q9eGrA/65pfqGNAa3px0H7vB6UbnuxD2UsfjtvFUaJ5ZVaoBqhRH/0Q0/zi4FMmNP
	yA+Rs6xpNeM+bqm6ID2xhCzJGARVN6JWi7vRwP40nyrBweg2UO+awpkkeXr6DarHqlIKuQoFTE3
	vRNTt5yHxwS9Hq0U5iElhjeC016Csa0kVI0qMAl3PMhdfPNotu/yyoonsMTpuGEHjKY8O/4lQWk
	6tQhb7chrM6nxlxtrkZ77rq19EJQnoctivDdE20iPSCgoNZidI6eXBr6mmLgKVNX5xLh2NvlQH9
	0du0AMuSMHlnVzDF625RiTmMaJB5yBP3vq3Jm
X-Received: by 2002:a05:600c:a4d:b0:440:68db:9fef with SMTP id 5b1f17b1804b1-440a669b52cmr29619575e9.20.1745610996268;
        Fri, 25 Apr 2025 12:56:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDTvNhYItxE+4Y0RI+qao1NGVdbXY23J5yiDp5FychjNVZxG0vly/CBGVBOu3qdA9XOIO6hw==
X-Received: by 2002:a05:600c:a4d:b0:440:68db:9fef with SMTP id 5b1f17b1804b1-440a669b52cmr29619355e9.20.1745610995912;
        Fri, 25 Apr 2025 12:56:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70f:6900:6c56:80f8:c14:6d2a? (p200300cbc70f69006c5680f80c146d2a.dip0.t-ipconnect.de. [2003:cb:c70f:6900:6c56:80f8:c14:6d2a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2d86f7sm66114125e9.32.2025.04.25.12.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 12:56:34 -0700 (PDT)
Message-ID: <519e3bbf-b198-4e55-81e8-0a77d8ab03d3@redhat.com>
Date: Fri, 25 Apr 2025 21:56:33 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/11] mm: convert track_pfn_insert() to
 pfnmap_sanitize_pgprot()
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
 <20250425081715.1341199-3-david@redhat.com> <aAvjJOmvm5GsZ-JN@x1.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aAvjJOmvm5GsZ-JN@x1.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g2EOFzXLy5jiR-ohWGpNu2XS2UXqpWzK3dEVLvwaN0Q_1745610996
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>   
>> -	track_pfn_insert(vma, &pgprot, pfn);
>> +	if (pfnmap_sanitize_pgprot(pfn_t_to_pfn(pfn), PAGE_SIZE, &pgprot))
>> +		return VM_FAULT_FALLBACK;
> 
> Would "pgtable" leak if it fails?  If it's PAGE_SIZE, IIUC it won't ever
> trigger, though.

Missed that comment. I can document that pgprot will only be touched if 
the function succeeds.

-- 
Cheers,

David / dhildenb

