Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFED3221297
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753213819; cv=none; b=jHGWB6lOP8J3gtCSZz1EcGWRx6Cr1PreLPePhdE7Szf40cm4gHjNKnOtwm5hpXLye0XcmhZC1R6jIPGZ+r5/DHEa3+krkWeauilT3XnedYzqzMUfbto9T0MWZMIv4pM4vCBbtW30L8kp17KYZ474K/3zR+gS+4GPIeeXQOz5mn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753213819; c=relaxed/simple;
	bh=ggYoDR0Wh4GP+RhrdjZXU/EJDUaACooyhlPvVhUWQcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLvU+LN+TeImjUbFMyL7Gq8fN2Kxp8nrMi3abg1AuSnr9bz5mDMsldXsGvq5/TsxMGNam/ELFFwu1Soy3/dMxZ7J6/nLtbyiSCzIXmeSjzhBJZvItE55pHg86r0lwu4E9YWGeBzfUI/A0KqhZBXem+d9x6BzH+3oFL/vdWcqk3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9lGnh70; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9lGnh70"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753213816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4CYJo6AX22LVhclJsQOSW3EWxZhNyBIePuLSfFpCwQI=;
	b=H9lGnh70lxMQxYKRcoVl/isVZWK26kZih/Vli7rygfK2dS8Cwt6EFb0ihGp8qK4ak5jGG9
	yZkSy7ubFyNp+UNuoW7R9k9o5I72B7GaEmTEL7njbGjKQn8MDc7sgwLAolphN5favLWYQc
	ZvJXUAExO0+7DJFjGOfleWOp0hmjuyc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-yy_y1trgPGa4TxS_kGJ_8Q-1; Tue, 22 Jul 2025 15:50:15 -0400
X-MC-Unique: yy_y1trgPGa4TxS_kGJ_8Q-1
X-Mimecast-MFC-AGG-ID: yy_y1trgPGa4TxS_kGJ_8Q_1753213814
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a50816ccc6so3791495f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753213814; x=1753818614;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4CYJo6AX22LVhclJsQOSW3EWxZhNyBIePuLSfFpCwQI=;
        b=KXXhG9+tezOhJ8SBkWeoKpo7oPJXRlqvd6rbE64LCU1XBXSl30Dx0ps0rzUmU8x7gO
         MAUAi5NMFPjcVh+7KnoCTNPttHQyZlFPhfpPIFCaAFzuUz0e9pdBvsOKuqx0E/zvf/mD
         oNnIybzehgxh7ZRW/GXVhmJRiu1/Kvm5yHIypX5vnf8TRR7/qUDNayfvx3H00QwW6g0i
         CUbY9ko3dyTk9O0U8eIOavOHIQdD9u2vmhmp97cJ+XZNv7Lysfb8odD4JZV/PckKMgUN
         h9nbtfyBeT7yTSkUnEh7j2kywh22IOjjzjDKFuQtz73c8ev7shPkd/sD/TkbhhdAiTMO
         dyHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgJNprAwYg/SYsIwxS2RN/EOHR31pt2ZgheMzTposV7dvkCluakMgSqPcMghFQl9utcTRGw5S+ffnQQlRiZ+ePvU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVgW80ecG+MsXzcEwu674n6Ko9d25mmdMmOBC3qHC7ELKRyH2G
	r9/IWltc6c87NOuKPdKkSQdH/jAy57uvDr5e0JJAInIKJI+N7+c+34T5hZVk/+2vF0lKOVmpAsU
	BwV0j60GiUIVeig6FXNj+8uTbEukfdwI7c+7ODy2MSMUc8WixGsuA0rSpOuqiuVieoLpFxQ8ybg
	==
X-Gm-Gg: ASbGncsZ25SZf34yimv712RxrDwlbsi0RxpmiVSBkmybWpDJcCBXgi1rWI7nq2zhQFT
	IHUYGrDimWCXTjX3uyNHH8Ah0cxxY2l3LjHZDGz0iQ7WXOtH8Xezxg4a1Nh+MNvmxwADXYMLVj3
	Jr5Ax9Ane0c9wjgaWqpQulZCowPWPSTlasAop1HUGpHl3hTXp7tSpLkQ3kw0oQguxPQ6CqBwQfi
	tBkTpU3iSHxYoiomG2IL9+l4X+lxO5Up+5JPtSXFZNeJEpuf7M8+cJsMgROqwAvsebw1YOBtjcu
	l7dCVpnUoTBz68puM1Y63GWqr3/vGxgJiFZVDrfxfy0fq+4gBPwI8Tj8ICFnPGnhURVcCwJ035J
	dYL9MGu/sBJr1+o+lwxQHnRUUoejo96LTUrRapZxvQ7cSq88tVTew5xxW62xpYpXzFA4=
X-Received: by 2002:a05:6000:2881:b0:3a4:d64a:3df6 with SMTP id ffacd0b85a97d-3b768ee04a6mr365286f8f.3.1753213813981;
        Tue, 22 Jul 2025 12:50:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTGClSNX9mUSWtmXovYaFOq4uYjzpLv10wKGZfAItrjjD7uCRR5y1Y77Cn/0hc29Z3GFAHmA==
X-Received: by 2002:a05:6000:2881:b0:3a4:d64a:3df6 with SMTP id ffacd0b85a97d-3b768ee04a6mr365259f8f.3.1753213813446;
        Tue, 22 Jul 2025 12:50:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:de00:1efe:3ea4:63ba:1713? (p200300d82f28de001efe3ea463ba1713.dip0.t-ipconnect.de. [2003:d8:2f28:de00:1efe:3ea4:63ba:1713])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d7efsm14361183f8f.67.2025.07.22.12.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 12:50:13 -0700 (PDT)
Message-ID: <38daa60c-927f-4076-b1b7-bf81c49deacd@redhat.com>
Date: Tue, 22 Jul 2025 21:50:11 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: remove
 trace_mm_alloc_contig_migrate_range_info()
To: Zi Yan <ziy@nvidia.com>, Richard Chang <richardycc@google.com>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, David Rientjes <rientjes@google.com>,
 Martin Liu <liumartin@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20250722194649.4135191-1-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250722194649.4135191-1-ziy@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0dvwildx3kpE99D7ijGm86lI_p8jTYAz5Cm7PNS2eX0_1753213814
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.07.25 21:46, Zi Yan wrote:
> The trace event has not recorded the right data since it was introduced
> at commit c8b360031218 ("mm: add alloc_contig_migrate_range allocation
> statistics"). Remove it.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507220742.P3SaKlI6-lkp@intel.com/
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Yeah, right call IMHO

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

