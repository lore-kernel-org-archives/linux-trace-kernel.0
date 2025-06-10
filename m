Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3EC21B8FE
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Jun 2025 07:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749539134; cv=none; b=ZJWSUwX7Y1nLtVcbIwcfwGtadu2BcYvgYZGnJtVBckxSr3e0c6vz7iAqGc90OxcvMTWDL297EB1c+85a8jVkM333LpiYBI52PvwFClqrdbUod+xpfa5ZoDLkyGH26hIxTIfU/kW87e5WwfFq7K5PqODC7fGUUiVnRCrxlL6itjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749539134; c=relaxed/simple;
	bh=+BVmPMYo6tXe5jLgYA9bBLt98rJDRk/RsCsffrkmwtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxK/KcyPvnZ32I2EuJJ1LGvhhkfBN+m9JkT1xWdgjWQg2ALryLUN+EVnq6ZW4Q75L9VgBPTXeV+z+C9xDcTmYGOoJNy+XmagaUHd5DJMX6Tib9dTlNQZKpC/xeLA39CkvYEm4xp19Mj5PHT7Q9lNk/iRGzEbxXsvVAxB/ZFzw/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FV74yq95; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FV74yq95"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749539132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4uGayi3wE9vU8k3pYd0gZMMeUhuTj20TdyE6+hjuf10=;
	b=FV74yq952logpFARiEVVI3Zs1FHVVNA4irEJOiTICSKYG+iEaH14gUXpmIHBU7eyV3AjCT
	5IMcCBSAZN0ctCstoP81DVEXm49pyZCVn56S3NsPsVx2DEG5QXl3JHuX2bNPh9Y1uvyVBe
	tHp62ljPtkWBTgCoqTKc+/x5kyL3p64=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-J4_bjmQNPLW2gIOBZtmfdQ-1; Tue, 10 Jun 2025 03:05:29 -0400
X-MC-Unique: J4_bjmQNPLW2gIOBZtmfdQ-1
X-Mimecast-MFC-AGG-ID: J4_bjmQNPLW2gIOBZtmfdQ_1749539128
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so1962093f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Jun 2025 00:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749539128; x=1750143928;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4uGayi3wE9vU8k3pYd0gZMMeUhuTj20TdyE6+hjuf10=;
        b=Sxcq5SPzFq99bSSZjo6/jT8LPbXCcRbk+FhxCAT1njmNgQ40n5iSa9Vn+2Ngg2q3yR
         Owq9RdRfZfBa6RhVteFvv0H8Ow9FCSbOt38R7KNiLO8xX+McGHYEzURGfa/PBTpSaJsu
         q6wEMa0qLHzyd7YfoKJFR4UaIWRcpKOhxsVPohGbDqbbjXTEz+WDBiEIM0ySqIJgZZdp
         +JYMPRpBgEnHi0eQB2o9LK1Hw1mqiFqkSgy2KxUrUBTe8KVdFwDpVYhcIT2h19SdbJ2J
         3Vma0E2ZGv4tCBtMFcEXAitYovbg6FreSESv4qjPz/N9lXGjXxRtmwp3d8vKWkf3drv4
         dATg==
X-Forwarded-Encrypted: i=1; AJvYcCW3R8JR2XWThxdbz6cg5Ek5VCLX5Hl1FTspwUkXpfeTRK3U/akhliiF0WrQBDnwdbDXK+toL3OQEMfqsymxfzLAJlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE+s/Z/0u8LR1ccKmuzefX76THiuEBHTNwsF7tmXYf/ZQIo5BV
	Ku+Ze9NXAxkFxq5R9fl8jeG45XhL2P/bC5n55uPowf415hOyy7ApP6EQRCLDaRe6jI9khKCTZHO
	Jg4TZQ946xweCfxH21bISpg+2FD+pBewD9k+Iy3Hr5pxZCQ1eKzG0AMFuuWFRZqBXCGZDYo6vug
	==
X-Gm-Gg: ASbGncus4NnVYEgpHNQWrvCDqhUtQa32qzlzbCZsy0IttzXNai3nEf8gtzDZZBsHt9K
	tgXh35QqrBIU70PxhOK3xppz0rRWLWeVxbVKvTX0tSHKrMBXxXJUysxE5herzOpEzPRuFX9+Cfl
	habCXRRPN2RpQqPwjOr5i+gTOEEKdp+o31YiQSmbSOzrPoYwwoVl+IAhZVyOi9+8EUONScjI9gl
	J/7R7BgDmfeAOnGg2iV7n7l06AYcGhT+Cp50HzEjQrN0MVobuzogBnsLoJ0dVentmexCASkTIiO
	vOBm+BEul+9R4PFP63sdy7f+4vYh4Q0d1Qw3YIadotXb9DA29Ge0pLM=
X-Received: by 2002:a05:6000:1447:b0:3a4:e002:5f97 with SMTP id ffacd0b85a97d-3a5522674d1mr997603f8f.1.1749539128054;
        Tue, 10 Jun 2025 00:05:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHChnADTfaieweRBHvUp3WTN9uAJLomdiqgSBhu5JtbJEpBVcl3obpq3MkMSLVwf70BjgKN+w==
X-Received: by 2002:a05:6000:1447:b0:3a4:e002:5f97 with SMTP id ffacd0b85a97d-3a5522674d1mr997569f8f.1.1749539127681;
        Tue, 10 Jun 2025 00:05:27 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4526e1595d4sm127883385e9.16.2025.06.10.00.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 00:05:26 -0700 (PDT)
Message-ID: <c2f52065-9758-4ce0-9c15-ef040bebd37e@redhat.com>
Date: Tue, 10 Jun 2025 09:05:25 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] mm: use folio_expected_ref_count() helper for reference
 counting
To: Matthew Wilcox <willy@infradead.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Shivank Garg <shivankg@amd.com>, mhiramat@kernel.org, oleg@redhat.com,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-mm@kvack.org
References: <20250609170806.447302-2-shivankg@amd.com>
 <aEc0MNj9JNXbLHmw@casper.infradead.org>
 <E40B36E2-1D0E-4769-B155-0175A06DE3AB@goodmis.org>
 <aEc7JG-OL2fp075j@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aEc7JG-OL2fp075j@casper.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fDnAoFCvB2Kc7ASHxZ6-pkVaMyQOak4y5Q_b54wI_zs_1749539128
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.06.25 21:51, Matthew Wilcox wrote:
> On Mon, Jun 09, 2025 at 03:31:40PM -0400, Steven Rostedt wrote:
>>
>>
>> On June 9, 2025 3:21:20 PM EDT, Matthew Wilcox <willy@infradead.org> wrote:
>>> On Mon, Jun 09, 2025 at 05:08:07PM +0000, Shivank Garg wrote:
>>>> Replace open-coded folio reference count calculations with the
>>>> folio_expected_ref_count() helper to improve code maintainability
>>>> and reduce duplication.
>>>
>>> If it needs this much additional commentary, perhaps it's not actually
>>> clearer?
>>
>> I don't know. I tend to over explain as I rather make it totally obvious what is happening. I wouldn't say excessive commentary is necessarily a sign that it's not clearer.
> 
> That was a Socratic question, not for you to answer.
> 
> My opinion is that the extra commentary is obfuscatory and should be
> removed.

+1

-- 
Cheers,

David / dhildenb

