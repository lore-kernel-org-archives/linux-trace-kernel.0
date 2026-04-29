Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A770B3783A2
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473368; cv=none; b=rUhwyr+nGyV+e6YzMBieqFAK01WqWsMiATeC01VugM8iok7S3zkyLMB4fKFSqs7NdoS72272bXgaA217MTrI3p/Q5VFiP7v6Cf+LtYtf2xDVLnGMwJPRlYYYykz5jE8hTUPcPKbsjg3qNMFK9MKsuDShHfW1Yt5COdG5Brks8B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473368; c=relaxed/simple;
	bh=iQE2N9uDqo+wCoggLYHS+nb5L2Ud6xbnNHLN8AB2tr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIHtE6JKC/KHmbE/vMW+2oZFEL1aBtA1/7fFjV5mogBAteJ6Zc0q1wdc9EvPf67+qt5BIVKT2r9YheRmgGOgNiaRML9wZMTqosXyPM+GCUHt6dg5IiSDO7Fosjt8yfix0cL45PZoL0TEDDQZYoaKc/598JhJP+oG6/tqJ4QKuFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vsi/Jt3D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vsi/Jt3D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777473365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQE2N9uDqo+wCoggLYHS+nb5L2Ud6xbnNHLN8AB2tr4=;
	b=Vsi/Jt3DF9kOwjg9GLMNx+uORcddHrQrGYHfQ3pYgq58HjLe4G58J2pJjx0+x/tyj4+Wqs
	F8Zwh0Ve9F2Y8BN4vgeX+IpI+a3h/SCcZxYpxeL7qSHzWZ9DnFZqInKmokYtEqwNX2Yagt
	dQ4RmTypt8kSTPVa5QKm4zUMpuidC6U=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-OVD2akZ8Ocq1bYSAImSWbw-1; Wed, 29 Apr 2026 10:36:04 -0400
X-MC-Unique: OVD2akZ8Ocq1bYSAImSWbw-1
X-Mimecast-MFC-AGG-ID: OVD2akZ8Ocq1bYSAImSWbw_1777473364
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-6546ccc8989so1304152d50.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 07:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777473364; x=1778078164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQE2N9uDqo+wCoggLYHS+nb5L2Ud6xbnNHLN8AB2tr4=;
        b=OGG1KaalDdTvA4qDfdxUwzIFbabVo1Rx7VQZnqfxk9rH4XnBjcyeO37r8JTSM5YNfh
         4MJzIBJApRHzssBR4mAtJDTf29Q3/25ev5O0Oz7rfUvw+QsnU7NPoCo+aK3cV+3L5KMn
         yvNFsURXW+pfNIknpLM4FWnprMsj1BWs14PVh2QMjsAeC5E3qIRCDEUJ0vqWVulUux4u
         RZXvk4HIZcgxhN2bw1sy/LEHpzeFGBguqdnXGEJtSyJF2w2Fj+6fgUdjEotodB79pbWL
         9mgkF5Hgt0PqYw6TzxzUQV0QZ8YSytJraPr7yEfmmJFfEd1YG9Pml96OiRfShXBVNIvE
         0dwA==
X-Forwarded-Encrypted: i=1; AFNElJ81v5z4NOGvWiddcwlg1C7M87TK9pKr4JEiFjI0pcTwXNALqO40srC9N3HFututREUGKzq/7/81++tfHrAWHOwE9Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvWv922Kujqw4MBDiTQf7h9Zt6SX1liKML4qZPFpPGDVIRq8ln
	YpFs47zxmS815zn3GXoSFUtoUlEqtD22zMwW/O3ppml82PHztyu96nj/+9ojFJ0RQ5yuePd6E5t
	QrltIsW4E+ZpOKCM/GWHMm71HUnW9qnT/rGJQgEb3kA3Z9cdjP1x/o+HSjHWDGx/TOJH2Pgikwz
	thnF6/Sj78MwlmKzXIM1FEebB1TP+gILbTIm0Lu/7KmC1lg9hS
X-Gm-Gg: AeBDieuLWpEdcUp/c7h5J1Oe4bc+bJphCdQSLY85dGFWoSkgCL1LRAExzxB/htWSWTs
	pHxHMyiQ4gEtWIhi0eVJIFWJcfNsCc1FQZ4ZuBhtQlnZ8p0aCn/mM3wWhSpnI8ZsqCD0ZUUPCu+
	PFTO5TQxHT94nMhjNPyfuX7Zzo2Au68PLhYMtW9aYm4YaVmjlF/g9KPJt5zWQiUC8Em6uq5QcjY
	BQtXdWfSMjxjGeAD2+eKFw48/DxyiKOgfx+FY+EzRH1WzBRg/E=
X-Received: by 2002:a05:690e:12c3:b0:64a:d479:bfbe with SMTP id 956f58d0204a3-65beed4aa28mr7450099d50.11.1777473363663;
        Wed, 29 Apr 2026 07:36:03 -0700 (PDT)
X-Received: by 2002:a05:690e:12c3:b0:64a:d479:bfbe with SMTP id
 956f58d0204a3-65beed4aa28mr7450052d50.11.1777473363147; Wed, 29 Apr 2026
 07:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419185750.260784-1-npache@redhat.com> <20260419185750.260784-3-npache@redhat.com>
 <06c7e6a7-60af-480e-afd9-700e985ca2ba@kernel.org>
In-Reply-To: <06c7e6a7-60af-480e-afd9-700e985ca2ba@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Wed, 29 Apr 2026 08:36:09 -0600
X-Gm-Features: AVHnY4LbQydeCo7Rl7wn3Z-HpTNHjOIv16EQn1nxmeiXqcsqhcLw56FreBf18Fc
Message-ID: <CAA1CXcA9GzJbfBhJo6yEahnTvUz=xzfzMkhi+KmpuzfNEb7Qbw@mail.gmail.com>
Subject: Re: [PATCH 7.2 v16 02/13] mm/khugepaged: generalize alloc_charge_folio()
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Cc: aarcange@redhat.com, akpm@linux-foundation.org, anshuman.khandual@arm.com, 
	apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com, 
	jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, 
	lance.yang@linux.dev, Liam.Howlett@oracle.com, ljs@kernel.org, 
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com, mhiramat@kernel.org, 
	mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, 
	raquini@redhat.com, rdunlap@infradead.org, richard.weiyang@gmail.com, 
	rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, 
	surenb@google.com, thomas.hellstrom@linux.intel.com, tiwai@suse.de, 
	usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1jKOp0u0a39jjahIK13PPSr4CBZlwoz9Bc2VkEpJ6Uk_1777473364
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On 4/27/26 1:41 PM, David Hildenbrand (Arm) wrote:
> On 4/19/26 20:57, Nico Pache wrote:
>> From: Dev Jain <dev.jain@arm.com>
>>
>> Pass order to alloc_charge_folio() and update mTHP statistics.
>>
>> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
>> Reviewed-by: Lance Yang <lance.yang@linux.dev>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>> Co-developed-by: Nico Pache <npache@redhat.com>
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>
> Your SOB should come last, the order represents the history of this patch

Ah ok thank you, sorry about that.


>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Co-developed-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
>

