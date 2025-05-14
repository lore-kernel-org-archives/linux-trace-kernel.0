Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D731DE4E3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 May 2025 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747245192; cv=none; b=dewLYSTcayuPZUPKqNVrSom0RXnP+R6C4HipzwZANPpOa+jmoo/WxO7Bx7YR0CDnFgkQQqrkVVZD7ou68HlDMMrc7J1o0tD9yhwk22jkQhqQbc6RgRmv2/sZihq6lanfqFGKnnTCCCA+6SsEzm5PThqyruD9Q6FW0KJLkA8/tyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747245192; c=relaxed/simple;
	bh=yyrmU6W8SSAQ69TGnG/eTlj7nlNV55pBc8ipgTcqAPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qGbf0HDc2b0np7QiJaBU+50w69pXgryy+hK6oJyQ3Y3amdL8BFDDeNkWs3TXBvMWAnYltS5wRttWuQZaFW4lGco6JN/5ZmgRpoMIFmhZqddoUkGe0p2F+37owC+22dCpLdPlRzMismforqea5m498Xlo5sZ+QSyMLYuV+N1SyvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gqwyMfLA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqwyMfLA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747245189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T9gEkHcNNRGwG4zKAICU/T3iGmVhFST3CjssIJGy95U=;
	b=gqwyMfLAMu/CQ5tVs5dBinLpPaHpKh/lZXq5e5Rg8eEyr8wBW4Ns9EBde1Qx5aaCBNAMfA
	0kk/uaJrw4RwiHzv4LwmxugtckmS103aoT2ftPM/9O20DQGCD096DPhjUla9g3Nb6Wm/C0
	HhmkSX3N3FgDSALojYQPKN+oq3NCHYE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-dMgCto0AOTmGs_7mQa6GbQ-1; Wed, 14 May 2025 13:53:08 -0400
X-MC-Unique: dMgCto0AOTmGs_7mQa6GbQ-1
X-Mimecast-MFC-AGG-ID: dMgCto0AOTmGs_7mQa6GbQ_1747245187
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43efa869b0aso608485e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 May 2025 10:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747245187; x=1747849987;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9gEkHcNNRGwG4zKAICU/T3iGmVhFST3CjssIJGy95U=;
        b=VvgLH9YalgtAApVc2XEueUCgPWMo24nG11AjHMJ837kH0AtIFtBPqRqHpmsTWVtVqg
         c15cWXaKvfDVOdnUOki4pGgHdsYyEjlcrC1RxZo6v3qWdTY8C8GkdnkUbbBcYYU+ekBp
         gU+h+QxlD+ADYsbzCO+ldhTPqtCtMcPUne+rS9EPUCTQ2PyRZy5K6iCNFljI4MVKykSr
         Y0wLNKi70gA5T/ETBI5SHWqYOKUe1aHZ+lVmCcw/8Nk/eczFFRSZMXuJwJOY0rXt9ftt
         kmVMfVeZtrJ1TD4L6ME/joiqOWTimyj5IfDKp48YioHZHQaOtc/AiWKAcxNEOrqZ6jpy
         Gz5w==
X-Forwarded-Encrypted: i=1; AJvYcCUrHvtEuWRoz2yMfXBlaQMORqNM0yW3ZNheRVbvHBzHDJw38JnymeeNEyhNUKEmG+0TUR/7ZnhfCkPHFj6oIxmrYDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZNjn7sI1UvIpogTxQOmpeWDmvF5xrhYX0O71kOor8LSj/lKse
	IKBELeD6ESdN4te0rcp65d6iaJhXizY8AdqsFpvMWxlSM7rv0Wbx6qHVd5sH/7iCSavucENZ2d2
	YVsFx+71s6pJIjEtIy1/4Llg+fNCMlCX800gF6uHc9V41LyEG0Oiq+PbB6QmhohrCCwG0Uw==
X-Gm-Gg: ASbGncvltPQijZkpYFhbhqz0df+XJantIyfz7I7Adqrakj03C2HYQKekYRZIp35IWdR
	8x7IFi+tYYWOuGN+dQtUZ30EgSdFbZvD3cHiD/w8FgnU+edFUXf5QnORbpdFBaIVqxor9eb89w0
	tZK6ReV6r91ra6jovoSFWems0hHL/sEWOYgG0Q717HkVo/jcOVp6ycYUYzKzBUZwQ/F+8btZ6GV
	XB3mVjaWIdKnWmjtcz6e9/tzC2bTVrPe0aKoO/7Ue2XUvBnW+bv3GsY9WMCIbSUeJOxFLf+sqlp
	oNvD7c+SagBBubgxHEEpg1rVoWkBkoIBDcOG3oFaHpVQftu1Y9fry2OeQhTu71HZJlsijMC5flZ
	QtPCWQgwBD/eARXjx6anI3eI5jdX+AUKI18maXjI=
X-Received: by 2002:adf:f7cc:0:b0:3a2:2d6:4205 with SMTP id ffacd0b85a97d-3a349921da8mr3561091f8f.47.1747245187412;
        Wed, 14 May 2025 10:53:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI/rQoUNdarqySB6UGfLmR7K5cvW1c5VoY82rTRIWoLyPgqKa4z52Sz2Zo6d+MLUSeBgWoLg==
X-Received: by 2002:adf:f7cc:0:b0:3a2:2d6:4205 with SMTP id ffacd0b85a97d-3a349921da8mr3561064f8f.47.1747245187062;
        Wed, 14 May 2025 10:53:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f15:6200:d485:1bcd:d708:f5df? (p200300d82f156200d4851bcdd708f5df.dip0.t-ipconnect.de. [2003:d8:2f15:6200:d485:1bcd:d708:f5df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecccbsm20532621f8f.32.2025.05.14.10.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 10:53:06 -0700 (PDT)
Message-ID: <18d502c8-7bbe-470e-863c-7c2f42ea2487@redhat.com>
Date: Wed, 14 May 2025 19:53:04 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] x86/mm/pat: remove MEMTYPE_*_MATCH
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
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
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>,
 Ingo Molnar <mingo@kernel.org>
References: <20250512123424.637989-1-david@redhat.com>
 <20250512123424.637989-9-david@redhat.com>
 <f2bxgy5tmb3cpk457lay3hl4wejj5dvttswnvzi2uudxtkkbsm@ktcytlgv64nn>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f2bxgy5tmb3cpk457lay3hl4wejj5dvttswnvzi2uudxtkkbsm@ktcytlgv64nn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0s5P8fGzuUuJsDER2_Jbs0r9jtw7S5lmqfu5YWtGNFY_1747245187
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.05.25 19:48, Liam R. Howlett wrote:
> * David Hildenbrand <david@redhat.com> [250512 08:34]:
>> The "memramp() shrinking" scenario no longer applies, so let's remove
>> that now-unnecessary handling.
>>
>> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Acked-by: Ingo Molnar <mingo@kernel.org> # x86 bits
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> small comment, but this looks good.
> 
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Thanks!

> 
>> ---
>>   arch/x86/mm/pat/memtype_interval.c | 44 ++++--------------------------
>>   1 file changed, 6 insertions(+), 38 deletions(-)
>>
>> diff --git a/arch/x86/mm/pat/memtype_interval.c b/arch/x86/mm/pat/memtype_interval.c
>> index 645613d59942a..9d03f0dbc4715 100644
>> --- a/arch/x86/mm/pat/memtype_interval.c
>> +++ b/arch/x86/mm/pat/memtype_interval.c
>> @@ -49,26 +49,15 @@ INTERVAL_TREE_DEFINE(struct memtype, rb, u64, subtree_max_end,
>>   
>>   static struct rb_root_cached memtype_rbroot = RB_ROOT_CACHED;
>>   
>> -enum {
>> -	MEMTYPE_EXACT_MATCH	= 0,
>> -	MEMTYPE_END_MATCH	= 1
>> -};
>> -
>> -static struct memtype *memtype_match(u64 start, u64 end, int match_type)
>> +static struct memtype *memtype_match(u64 start, u64 end)
>>   {
>>   	struct memtype *entry_match;
>>   
>>   	entry_match = interval_iter_first(&memtype_rbroot, start, end-1);
>>   
>>   	while (entry_match != NULL && entry_match->start < end) {
> 
> I think this could use interval_tree_for_each_span() instead.

Fancy, let me look at this. Probably I'll send another patch on top of 
this series to do that conversion. (as you found, patch #9 moves that code)

-- 
Cheers,

David / dhildenb

