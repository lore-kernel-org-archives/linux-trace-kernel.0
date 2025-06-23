Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1BD824A3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Jun 2025 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688229; cv=none; b=Sbzttaaky1awgXSGSqfOrUbdy4r0ny+weNBo/BfgXETlJNM+0o1cDErV5R3MLvTIRR/nAA55p8AxPskodgSkLi5tWOLvbqYpWE7mFM4iCFkLG0AbA//kGbf7vMWJaNNVEFA4K7DQ8qWLY1p+vhMm+9hZ2qqnwqJA7Xs/L2nW4zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688229; c=relaxed/simple;
	bh=cFKZeL+hYNuWQhIXij5F912cJ1wz6SXdUpucQjuTNnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3KCmAbPS6Rzl1OPcCpcSUMwzZnr2P6FF02zlHSAZxgM5kUfL7PRlvwEc/8uzLyaFDUyz5zH7Ujomv386qDM5NGzkpJ0pXuILG39TqJeY4x1tKHwFKheiLfuOrZg1gCB2OL/YYVqgV0aQ6XC4NA8Ycjw5rOD+aqrxC0gFtwWXFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RJ5ZAsLW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJ5ZAsLW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750688226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h8Olqgg5wM7szEFmj8uTM5sjPX8xuFrJrmZyG5BlKBM=;
	b=RJ5ZAsLWXhNWYoYQ+/i7onP+LL/Mtu/tMsBye+9z/bk1ny7kum4ou6CnPj/oijHOGogdlL
	CyTi7kEmIEvBEJzUzvAD97WImCaLNJSspcNOePkxD9eab2RW7X3lJZYamrvJmJK5PoPrXc
	dkMt4Z+1aPrir3WJJRskQ0pYxSXVw2I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-Pjo9r1IvPXeMlF7DMmvAFQ-1; Mon, 23 Jun 2025 10:17:03 -0400
X-MC-Unique: Pjo9r1IvPXeMlF7DMmvAFQ-1
X-Mimecast-MFC-AGG-ID: Pjo9r1IvPXeMlF7DMmvAFQ_1750688222
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4eee2398bso1633372f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Jun 2025 07:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750688222; x=1751293022;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h8Olqgg5wM7szEFmj8uTM5sjPX8xuFrJrmZyG5BlKBM=;
        b=dWh03/LnJrP0QjOepZwZms8cWR4/QJ3PjkMT/T2QzAzz1jYUe5noHyGsWI+48I4eM0
         lpFsv3m9TgpD4uMCQ1kKTuuMSkgTJAqwuDGCGAEbkinxyCRMom+ad8akNyL51Pb9mYUt
         rDutyyKJY04SX8vE5+EFe/nFy/wJD9W5CFHi4WNRGZ6emzRv8sZphKNuWdoMo0wRXJFu
         FtGY5hgpd+kHJ7Go0qcbVNRrvrZTo1yADBDk/ajEMVwm008eRSM/yXGD4eiw9+QuBd0O
         51Mc/SESI6LAQl+C7X5uwBFu6EL1CHULILA0Jvtd9+PoJG93ZV8Nno9LosTZx+DF9Zvv
         D3Lg==
X-Forwarded-Encrypted: i=1; AJvYcCW5JgDLJXtEJU8JicboKyZeEYTrVSkb7aRmnL7wMUHrzWlnETVuAR+5lVbXYJpV6JvtcB5H5gGCitv/5wvYa6sMkws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBTAnDB3H2Lv9gb5nAsO4i4MKJaENerKrYfRAaMNaSZxsFIy9W
	2hUjoLdCHjTjxNBZyqin0Fcr5ySfwWAMyQvHHcHB59dzuYmK+6y1mF0MpGoIndzAY5+4B0QSEbA
	Pcq8TWBh9ol2UkppfXJv2/VRc8T53Oq2rdx82GOVqLIfAwQy+SHszrRkityQe3nvsFzBAEC4fRg
	==
X-Gm-Gg: ASbGncvL3WNJ4MaN9XYqgu+Nr0jqqEopenTbwm0oFQWTB5lgNbH3UpIi99v89vNpZ7p
	z0UYlBnnSQbiBDHyBX1E6AewBzuGTII/yVrX08TM7APNJGQueMf2c7UvyMTaFilbiOTJ6Jpb6FD
	lxkw1t7b3m1SFNNCx1zRD+nkWsXhjQ8XZHa9ZmPIGoxJMD9jxT0rzsVeoPo/PHhTqp23K+fJMJE
	R9Q7KavlaUwz10CfXabX8MprO9XzOW4WvIMJbJUl0Mll1GQPtM+Ywrli+sYJUK//GjXim+guayw
	KClUdvcrGTTROBRojOidOWZVlY54rlNApCqh/LdUadjxHgI41Ln/kmlShvwGnudQ/EPsphlCtQt
	HSgT8kt1GAxA6ln6tDOXUTmUYr3JwwUhfgpaogtUpcmNd4J9mOw==
X-Received: by 2002:a5d:5f87:0:b0:3a3:67bb:8f3f with SMTP id ffacd0b85a97d-3a6d12eb182mr10399963f8f.53.1750688221764;
        Mon, 23 Jun 2025 07:17:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8dR6X7fHQaI9fQSh9DO1Tx6U+p+mGsBYH7hTQ0+BF5CKnFOIsqhzs0NiVKWgUUywR+JX//A==
X-Received: by 2002:a5d:5f87:0:b0:3a3:67bb:8f3f with SMTP id ffacd0b85a97d-3a6d12eb182mr10399861f8f.53.1750688221154;
        Mon, 23 Jun 2025 07:17:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e97a908sm145737335e9.4.2025.06.23.07.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 07:17:00 -0700 (PDT)
Message-ID: <702c58b1-7b07-4cc9-a5b3-8d3f33aba02b@redhat.com>
Date: Mon, 23 Jun 2025 16:16:56 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm: change vm_get_page_prot() to accept vm_flags_t
 argument
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Peter Xu <peterx@redhat.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nvdimm@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <a12769720a2743f235643b158c4f4f0a9911daf0.1750274467.git.lorenzo.stoakes@oracle.com>
 <552f88e1-2df8-4e95-92b8-812f7c8db829@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <552f88e1-2df8-4e95-92b8-812f7c8db829@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m7uhsMsvAV_76U12ax9zKXffec3Fic59LkNIcMFhafY_1750688222
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.06.25 14:25, Lorenzo Stoakes wrote:
> Hi Andrew,
> 
> I enclose a quick fix-patch to address a case I missed and to avoid any risk of
> circular dependency in a header include.
> 
> Thanks to Vlastimil and Oscar for spotting this! :)
> 
> Cheers, Lorenzo
> 
> ----8<----
>  From d66fe0b934098ccc2ba45f739277fffe86c91442 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Thu, 19 Jun 2025 13:21:15 +0100
> Subject: [PATCH] mm: add missing vm_get_page_prot() instance, remove include
> 
> I missed a case for powerpc, also remove #include (that is not in practice
> necessary) to avoid any risk of circular dependency.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

