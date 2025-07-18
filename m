Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2175D293C77
	for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828035; cv=none; b=plHRPGB4gSViOQRkMQLUN+vJch2X1y0fkmor0gvm0IbJ523JXqnxkUyKhF398qCjpM8dLLXEWNqPCWOeYivoWQoFtVsDxPp9+gLk/G4C7Cfnx9FpSO68KGsDvw6meLrl0hUxwXlqxq6fDWOoIDPJPdys4aUuWPL8w3/C93+th6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828035; c=relaxed/simple;
	bh=NXIn0oOiAY5DyTFM5n21UQrMt/j12camTlktMJL+mRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcbM0dv0Pj9TKelXiZw9ism4LcS8KLjqEnpgcnSnQ3Y3dHxSgZwd2smLCn9eqAo0NhxBoQCxV0PJxUnFWK7shDjrMuCyj4X52+26qVl13OBnfmZ5MDIRrSf3Tva0UMdO/MzpLIZ4RoIKynQiuUcq5VcxHr+oUMxAPd9T9T5w3XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKVL2NEK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKVL2NEK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752828033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WPYZFlhAUKb/G740pk9MgxcQsgVOZ7ap5V10cruPzTI=;
	b=aKVL2NEK5nVj3QhfSgklM0jibKXwcqKgvanAFfBq5MsgB4Zn8MWpG7TgVLgDYW4DDjhPg1
	LQQiGDCfrJHP/Y4HS7uycG4lQlTgn5E92gXoJZTxK+h1Edz7NzVi2n/0c4/yfRT4eGpHVD
	ioRnU0RdPJjc2RTz2NMcukRT4j87TMQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-h5-GRpf1NpKS4KOqvdMyhg-1; Fri, 18 Jul 2025 04:40:31 -0400
X-MC-Unique: h5-GRpf1NpKS4KOqvdMyhg-1
X-Mimecast-MFC-AGG-ID: h5-GRpf1NpKS4KOqvdMyhg_1752828030
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f85f31d9so923552f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Jul 2025 01:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752828030; x=1753432830;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WPYZFlhAUKb/G740pk9MgxcQsgVOZ7ap5V10cruPzTI=;
        b=fd9IS3YUrD1aKmFBg63JHD9ThVJ+lAZhrg9TTOlGgqa2r7hZWTtcQJprjP8EJN+eEr
         oRCRBA+YuRclsd/xKPUdJ7lxhoRyxxKfv7AN44VMySajdj7ZJjyStmNLt0jQsFkeUoK8
         hJLx3JxvjQ+s+OIAvQujLZMVtAe50B/8o6QDhCw/IxY0sNise1yVxE8RCvdOVJGnOIQR
         p9iE2Qp/BESTPCp5EXoxSqRC3HFnaqQq9exP7S0A1Vsz1gDm5kL8ChKKjqA+Sk8BsBH8
         HlOyjNe85xoTuNcWg7S33iIZLa8bro2fqXHIaKwSdemZ0rIfq4dKkdbGYXP82cy9doEv
         g5qg==
X-Forwarded-Encrypted: i=1; AJvYcCXZQRkCUmT6VfY3WHDUx9JRpndzp2f4MkTw3R4DvcJ93E+YgVplp7Wn9wHIj5CauWg8CzPKRmUkhClzixpA43VUwe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YytBShfYH32nzBOdJx8Xm4SpeZ8IskVpCcOkHK/vdDauLDJEdP5
	ieSe4qvCmXZrJpC0PrlJqQOiJNiZc1d8WnDHL6TpEZE1zOJiNuw6/k++KG00jjjT03iRD+QRKPD
	E25B2m2D4kUOqL+638fjMY/ZFLKH3ZAYoOBvGE7Q4aRUVWYV8itqihgVLkEn15VPMdvrIzxComw
	==
X-Gm-Gg: ASbGncuQvfJHFldF0lvFkmcxLzJruR13loNnwypR9UrGwK0utbsTlXYgmzBFfxRg33L
	QgXPbReFJh7Ct555N0b/y+mkWr2ptDzz6iYoO7LHK6pgdHaCbuAVLEH3LL77jISOrHs6MfeZcDf
	ywQ5hIV3MfJtKV7G0xn96hUswX98+Y7zyiRCFmDccVj+fsPrwDUVDIeaiAHBXnypp+4+mnnNZw0
	Q7Dz87gHgvUvtgi93qblUzGbx0Hg4nGj9c2z5Btf39LYJ9IV/H1txcK3vLkbelCXxtL7LqO2Ypt
	/Jt0/0D5UCTv5OlX/ylafXVJZOl0Vc5JYIie7L7o7bCszoWgd51R2UuzNCO9aswowXjvQkvm/RO
	ud0SL/MpSGSbEj1LsB86MjPMBssl0WCjyodw8W1GMQVjVY0KHvhAr/aXQt8b7ImpY3PE=
X-Received: by 2002:a05:6000:2f81:b0:3a4:f90c:31e3 with SMTP id ffacd0b85a97d-3b61b217fe2mr1583079f8f.31.1752828029679;
        Fri, 18 Jul 2025 01:40:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGw3GhDEO5aWcDmxGxplFA0hEIFhsrWZD2yMQYdssxAcVngYd7MFaN9vkiBTT7Ef4dOlRckA==
X-Received: by 2002:a05:6000:2f81:b0:3a4:f90c:31e3 with SMTP id ffacd0b85a97d-3b61b217fe2mr1582998f8f.31.1752828029080;
        Fri, 18 Jul 2025 01:40:29 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f43:8900:f364:1333:2a67:d49e? (p200300d82f438900f36413332a67d49e.dip0.t-ipconnect.de. [2003:d8:2f43:8900:f364:1333:2a67:d49e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bb48sm1197825f8f.24.2025.07.18.01.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 01:40:28 -0700 (PDT)
Message-ID: <ab968af5-2034-446c-9844-533ec62ae14e@redhat.com>
Date: Fri, 18 Jul 2025 10:40:26 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/14] khugepaged: allow khugepaged to check all
 anonymous mTHP orders
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
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
 <20250714003207.113275-11-npache@redhat.com>
 <3b8d32dd-9d40-44b1-a0ab-8185073b9072@redhat.com>
 <CAA1CXcD2KphY8PEHyjQuYhZJf_oiNz-8UN1m9AtPF7j9O7U2sw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <CAA1CXcD2KphY8PEHyjQuYhZJf_oiNz-8UN1m9AtPF7j9O7U2sw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5ZTAChDxkbbUT_u9-rfVJjBGqrpdx9GKS3xoHmOlVrE_1752828030
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.07.25 09:25, Nico Pache wrote:
> On Wed, Jul 16, 2025 at 9:28 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 14.07.25 02:32, Nico Pache wrote:
>>> From: Baolin Wang <baolin.wang@linux.alibaba.com>
>>
>> Should the subject better be
>>
>> "mm/khugepaged: enable collapsing mTHPs even when PMD THPs are disabled"
> Thank does read better.
>>
>> (in general, I assume all subjects should be prefixed by "mm/khugepaged:")
> ehhh, seems like there's a mix of "mm/khugepaged", "khugepaged", and
> "mm: khugepaged:" being used in other commits. I prefer using
> khugepaged as it leaves me more space for the commit title

It's inconsistent, but we generally try to indicate the relevant 
subsystem (mm).  For khugepaged it's probably the case that it's not 
easy to confuse with another subsystem.

-- 
Cheers,

David / dhildenb

