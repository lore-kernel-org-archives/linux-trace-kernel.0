Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465CF23BD0B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594942; cv=none; b=TsTBzY1uZ4Vq36Tjb02eP6YTqI/8m1QDH7oXJuUKhGfzqjhtr2lvGBhcDcVq62IJcks5rAs794jhvvr/PyqS3u8EywmJlMJK5icSXo72igAyf7nmxFSb3PfB072vj37jrhQqPfo80nX2NKt4hSab9KYs1999LfJWE4FuU3xnGIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594942; c=relaxed/simple;
	bh=cfxm7upyQPAVQ+Uo2q1SRfof7gmygRtzj5suTyQ+ELE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hdoAPNXJ0HiYkQfYMS0+CkfFbKX/wpUK4t0hMYQitm7xfr+QdieY6piY2FnpcG4uvvV0B89M7fvrRPJ0+dGOZeauBjH8BDNOSaUsLm8zSdMq39iH7XA+wHifg3A8OIkFAC+FV4Nna+Ryt69YKvpBYhdVpuW4bnprNcZVCmG+PLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGhDjYoJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGhDjYoJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752594940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vw5r3Akmq7xXxayfvhNmSDNFarBdqUJD1u86wPfqyi0=;
	b=gGhDjYoJ+FftzxxEHxEt65sdxxkjYaWCN+Y8XrynmkFkm3O3LoSi1QB5/eGJAGEFOXovoc
	7u3Khya7ImR4uh3wBEN9cqPR43pwgypywJTCX5IlRl3EUiLxJbV4n09OgmLKv6d1cDWgYI
	YPhwoMVwgiNKiS+89hwaftD6K9U3FHw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-NU35L6sDPx20L2Q9zUE8GQ-1; Tue, 15 Jul 2025 11:55:39 -0400
X-MC-Unique: NU35L6sDPx20L2Q9zUE8GQ-1
X-Mimecast-MFC-AGG-ID: NU35L6sDPx20L2Q9zUE8GQ_1752594938
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so31562305e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752594938; x=1753199738;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vw5r3Akmq7xXxayfvhNmSDNFarBdqUJD1u86wPfqyi0=;
        b=h6IvN6FZymmXxy1+uXIUNQzAT3Y3HKydcS2cWa6dlmFFxG3peHJ5JgKhBxsmSPq7ax
         sNhdrXkJilIGht0rBuGOxsGIHt6Cgxu5Mn0MPs/86P/8BZh3FkLTrwzy9ro42jM/DAFz
         gWLskxioTtv8NMUUMDVCI4n23GNoPPZlA4z2eD6nCRWip97efngzDf7N8AtnAujk7owq
         cBIEGc8un5VZTv+4BsHnNoWmqGGqzi8c3JNmGzU6An0wCK3ZLqTh2v5VAFEvXmB9IX5I
         IZe6LMX+fIQdIDbiCJhw/620eiaWKOjy2Qzw5Gfj6upYEfZZDvAkq7yu3cJ8ceTsNDzF
         Lc2w==
X-Forwarded-Encrypted: i=1; AJvYcCWZlUBBDtPFdDp11BoZpQzPVAax9VwRRIPuzi6/aSu5wjS8QzO4FEzBpLwgXVRW8STrUQEHvlWeU8nuO/aPDcGghIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuzzVq1uAU5XbcxqH6GBancTdlrAM7cm+I+ynRwL0W8DRJ/ROR
	+ie3BoKRFITKMZiW9uCGE7Jz4Kq+n13jONciyt0w0usbBTPYJk5UDDNQVTJgBlKv6oZG+tmHuTK
	bgjY79QOP4yd21wb7pyMxXIlYsd3wC52Eb8aY53T3ivDNqHEQAUJl0ngteosRUygMVE2Sak+2Je
	05bzWdQ5fm
X-Gm-Gg: ASbGncv76xJFfELzvTWu7ZAXbQHL23c3+5o0hhbkHmroIBO1pPH7wHmfe/SRrhgq8En
	RbOLVlABHzD8Nam2LnBspxbwFnDWMA21gkQPzZvwxsPGhh6qW1VcfjpUSAepjcr0t7jNBDb1+Kt
	C08movpzXhL+sBnr1TzcAVexAoEuZHeXyLXPD2/hNKKw+RhxvwbLAVyMZiqmhYbayA/lvEZ2ray
	QpNf0qut89eRinjn6nWxgU6nVrRe0VzF+yowra+ZRf2zUvjZ5ifeJEwC5HayHzDA2rkcObs082U
	Yu+ZHXwIIzYYaOwbRnfLMfmCbmWE0UyqJXpsK6ihCW2VHnV4z8gOZz+MeThhk03W8jOQh348zbp
	gqp9puaT9VyE7Vm34R2rZSeoAUeRX4HD4ufkdfw3Uzh+LDKbJzQ8wts2cjkBdPRk21yk=
X-Received: by 2002:a05:600c:6304:b0:43d:46de:b0eb with SMTP id 5b1f17b1804b1-454ec16cb2emr185559445e9.12.1752594937720;
        Tue, 15 Jul 2025 08:55:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGLH6MyR+39m02QpxgDnQgYYuOtc5KV6pEpu//wpsb2B99jrq4K5jhW1A3aeu/+1h6XLLeFA==
X-Received: by 2002:a05:600c:6304:b0:43d:46de:b0eb with SMTP id 5b1f17b1804b1-454ec16cb2emr185559125e9.12.1752594937251;
        Tue, 15 Jul 2025 08:55:37 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45611651008sm87611505e9.9.2025.07.15.08.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 08:55:36 -0700 (PDT)
Message-ID: <e70399bd-6aa0-4e65-8695-f45ae70dabbc@redhat.com>
Date: Tue, 15 Jul 2025 17:55:34 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/14] khugepaged: generalize hugepage_vma_revalidate
 for mTHP support
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
 <20250714003207.113275-4-npache@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20250714003207.113275-4-npache@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o432Eq-7G66Q_L6R8EAqNyThjvH-rqN7jECCAnaQYdo_1752594938
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 02:31, Nico Pache wrote:
> For khugepaged to support different mTHP orders, we must generalize this
> to check if the PMD is not shared by another VMA and the order is enabled.
> 
> To ensure madvise_collapse can support working on mTHP orders without the
> PMD order enabled, we need to convert hugepage_vma_revalidate to take a
> bitmap of orders.
> 
> No functional change in this patch.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Co-developed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

