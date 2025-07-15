Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C277F22DFB5
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593954; cv=none; b=q2jCNdXovFy4YIFLDFtRLWGucBtWyxvg4pUsa27c/BfdYyM4apELgm/gdOEN6G2MxxwW0TRETlUlcdyLXOL0qU3wk6RwGqrV6hCljQfnR10FwFt83z/o1Hj8+N+78PsVJyIcVcdUQJbwC/WIfFJGffQAgXZRLkk/hddG+cF/exY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593954; c=relaxed/simple;
	bh=dTz/J9wlC+nywxQTpGo4UF/Z0sNT7Lcm+tM61+gHrNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzCGanDMZvD/kHWsX9M6G4im7RslJ0Y5efSDh5p5XZq7F2bk9eBQic0trtN654pVUC6Ae9XEAJ7Am2SJkCQaGThBILBNZXTfurvG0vSzWrwgl8u+yJHB1CDRUt0eQa0IAY233b2fGTh2JpTSz4zrwhA1Do6UXSar+UvYBjhth5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mf+4EU1y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mf+4EU1y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752593951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHM4gZNCeGPf0Dq25GgumpITXaeUKp0zRvBNhoIXd98=;
	b=Mf+4EU1ylWMaOu2sjZpP9WBuDOXofTRBvj0nfBSZt0d0nwO6D7MpbKc2eG9h9BEaN9TUe7
	KRGn7yKOnghnJZ9WElG0ebqE3x0NJJmCkQn0pv8dym5vfYRapfx2Y52uItF9gOt+ALVUlx
	nRCDeNEWKvDcZswUzhrn0h6BIBALHDw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-GqN6ik_-OW-K6UHeMRK-IA-1; Tue, 15 Jul 2025 11:39:10 -0400
X-MC-Unique: GqN6ik_-OW-K6UHeMRK-IA-1
X-Mimecast-MFC-AGG-ID: GqN6ik_-OW-K6UHeMRK-IA_1752593949
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f85f31d9so2221497f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752593949; x=1753198749;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHM4gZNCeGPf0Dq25GgumpITXaeUKp0zRvBNhoIXd98=;
        b=Pn1AaBz+u7mwiccPffb1o5M+wCf5uRE1OUpz1TJl99UmJSr65YQE0WFx6oMKMLyyvp
         jYUlRwwMzE01lk8iwAm2ER4Q37t5fluuu4f6Zv21/eqigWjO87JZLyyWnU+lmXNs0ad1
         t6Rcy3XlV+FmicgaPd0nma+fbs3kW7l/UYXBuDWqWD6nBeOXG7IxtIRHxENQMW/W4A/p
         O3jnBmxnrXAJRs4jpTp6LTq16XXZpWeMAKE6oJAf/q+uiFh/XEFVdbjaXoS+d5CaJkoY
         Hvfq+qw1HUY7fsAcUOB3aFtbwb3PwZz4RNrlFooIp2PqD3enxO9rPlgR/a3It20hfE09
         2tHA==
X-Forwarded-Encrypted: i=1; AJvYcCX1AdQRjF8bI67qZm7h0p19FStfTFd0uv8UebshYH26WNNOQt3kPubwFHt6N3gNMhIeLTZoUxzFvF3pZnmB4UBPnbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWaKfkspO5hLxXdwXr8gz08oEo4ZqVBBD7OF8L5VPZcAlvg8Xf
	VGfKAmjjl/HwFLRDqYon4gbwUqOsZtZx4DOkYs6Bhgz3yxVW+t/p6QIqLonMi6+Lmjnmui2jbaV
	8a6emNfnRWbaAbU78jNzhBOTS5f1kH0HdUh5BFCxNKDeA0+t25wBrVQQJiXZGkVIp+ZhpOwRMjg
	==
X-Gm-Gg: ASbGnct9sbqp1nkfRm+qIgQcXPTCjO76yJSqDcV8pw5O1GuumDsaqZ8J5oOpaFx/KIc
	6SlpQsOspezoWwRJHeTFVIvXk+iQxnPh9nE0wTRbPpG3zgWbM7KVTMajtnYUv4mx4qsxgrqMXPl
	IgE3tVnX+vVVK0OlWHbgtqc2ZyoNMADl9pP8UM6Iao/gM6Id6mZ1ndI8cWWMvtadecfZ/k1P1ND
	xAdXCXOhGaEMqP/Xut0UxA+8naL/kXaTwfXQH9OwmC9DVF7i50l6WZqGdO/2ZymFFTQ0tZLBd2+
	98zC+r/G+e1YsX8+RTE0zKLlLXENl9ohxGovRlGjVXdhT7B5pcRZF3akPWQLvucVFCy5bfukp8C
	sa/3+/AL1SuVSU9W8l3W4jvr3vqfcqtS2c0G0g7k6QAA+JIIBXC9EOtlS9fMxP5/72ys=
X-Received: by 2002:a5d:54c1:0:b0:3b5:def6:4e4 with SMTP id ffacd0b85a97d-3b5f18dc957mr12722515f8f.46.1752593949283;
        Tue, 15 Jul 2025 08:39:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtrPZ5XjleiUjEdSdNotNWI9zAnnUxsYftwPbMASEv5sC7k861KNZN1awNoAXfH+5ERC81DA==
X-Received: by 2002:a5d:54c1:0:b0:3b5:def6:4e4 with SMTP id ffacd0b85a97d-3b5f18dc957mr12722472f8f.46.1752593948800;
        Tue, 15 Jul 2025 08:39:08 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1792sm15715844f8f.13.2025.07.15.08.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 08:39:08 -0700 (PDT)
Message-ID: <f51d923e-da89-46d7-8e3c-702f055b78ca@redhat.com>
Date: Tue, 15 Jul 2025 17:39:05 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/14] khugepaged: rename hpage_collapse_* to
 collapse_*
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
References: <20250714003207.113275-1-npache@redhat.com>
 <20250714003207.113275-2-npache@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20250714003207.113275-2-npache@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OlPk1rklwlquU4U9o1XpIsoC6tibHIU9NxI8KEhj6u0_1752593949
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 02:31, Nico Pache wrote:
> The hpage_collapse functions describe functions used by madvise_collapse
> and khugepaged. remove the unnecessary hpage prefix to shorten the
> function name.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

