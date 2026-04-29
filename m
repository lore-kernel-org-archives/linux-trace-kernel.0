Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C5935E94F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473811; cv=none; b=m12SKHyftgoZxN1F1du8G/79gHYSlcnFYULFyBqc5dpaD5e04JgfmW8ZbE3XrOkqTzDXAZCIhPuq9sJtKC8m8lE89/iBQPlTU0Fyix6Ovz2PG1MPcKiVMV9JcVVjarNCueIrtffhQnMsP3jfOBrt4a0bx/0oKlR7MCse8mcaar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473811; c=relaxed/simple;
	bh=jIWEmT2kn3M94mxS9fkvjuBivVcWDJW0vt5Ut0aO5NM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAHEUaatdOoThhthnzC67mZN7Ott3tPjMRhRslIhq6rGYY/BjWWQBcjW+NAiXZzdGNj33XWTRIjbnYqqyv8aaxGkoigGs3Vs4RwbHSyDg2nUADRrPtGNujE4mCWSwTXFq/y6kkh6J/wskbGA+TT/lq2+xrUyBtQVxcIKgo67WbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DZA64DGd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZA64DGd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777473809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OMHYvLIEZUKpZgFTXwdf+A1Vhw+Yb9KxrwCYQMievwc=;
	b=DZA64DGdgWXti8xJLNZC2ggguxBYSBGuLQvNVgk+rCvKGCFIgFuxUhmDmsKK8H2UaNw3AH
	uJgTOMD2InzPz3v5XkelRMtKexuPV8xEMmvVTw2a9EAM/XXp0/pb76u968ytQ3nSjmrZQS
	DbRf1LhJWfC2pYxvymwp9rQ6ed7b4/4=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-B3F_5qabNzaRJpaQdZs8vQ-1; Wed, 29 Apr 2026 10:43:28 -0400
X-MC-Unique: B3F_5qabNzaRJpaQdZs8vQ-1
X-Mimecast-MFC-AGG-ID: B3F_5qabNzaRJpaQdZs8vQ_1777473807
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7b3e41a97f0so176058357b3.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 07:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777473807; x=1778078607;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMHYvLIEZUKpZgFTXwdf+A1Vhw+Yb9KxrwCYQMievwc=;
        b=H8aPVnhKJ6mBM7piqy8YsdfWUXiqn5MBUy9kmR24r6+qGgc76OeeLmjzW8v66XpU6R
         GeVN/nxhwbZaoO0DUuXiqZU9rxbdOzR4OjUucy32uruzK0XbEEqREkGSrk6Ib4lv3yN7
         eOi87zo3gcEGPQJgjVl7+072t8Te1QGVfDCOykhRQC1ybNLgT5NsrmCIh06DNMeuRSiw
         BUqOWibZQZcSzmChAKZpm9e2YPwggCJr6+1+8Z3ulxbQ+Jvvj8H/KLh+mQYhHwNrR5Zt
         f2ffc9NHE1wwM3phPB2R+FhSL5YwToOQg0jaAyZ2EOTn8F2w5hqOs0nnHG4/2wMJ+SkT
         4A0w==
X-Forwarded-Encrypted: i=1; AFNElJ9zgPCe3m3eYx4DtSEtakXWBeE1q9N5wKbsURhXDKpLi5D65oohyj2tsCuhoDnkeFLBYPdkwtzzEF8tIZPm8uoo3Ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUeuHJiYvpw8bTn2qKoqPcadBDAiDseejNtgSbiDLY1mKKN/w7
	0YH7xcyFO3Z33jWZUjK5lKk8BXExpTlUcdfde8FCEO/gDmN0QZK//rXT/b1KvipWYTF/I9LO7OV
	kvhXZynTv1JlvPCTYcE3Wvg7Tf3NGsuVW4wQ4r8UV2W5eHHuSw7Vx40EvAGvCYHgHmea6oXjzo/
	7yPYAUNfqf+5hNDrpaScgR6EqV/Zwo8JP3uXoHC06lTzFwWhLd
X-Gm-Gg: AeBDietr9ta3sEqHl1D7wqrpe6OdBj0NOXoQL2MBwmqg7mBx2+RPma15hmvnYPnyhKc
	g4UfnYw1gQ5qNRBBWMmZ0oQcgXeyzSOXMskCzNf5sALAnOSSRMz1mjc/cJcJl3KCSDZGLWLcrUO
	uE1HVuGNdcYHFsrhiZLWDxMT0I4GCE9gJzZ1hjCzUxJL9E6VBP+sAWkONoiBGMfkVICDDyAIOmv
	REQP72JohiYRqhHiSSAt5dmS9WX+IgN96Asch9YskLSq+jSz4s=
X-Received: by 2002:a05:690e:d58:b0:658:1e1d:b8c6 with SMTP id 956f58d0204a3-65bfb71083dmr3655702d50.44.1777473807361;
        Wed, 29 Apr 2026 07:43:27 -0700 (PDT)
X-Received: by 2002:a05:690e:d58:b0:658:1e1d:b8c6 with SMTP id
 956f58d0204a3-65bfb71083dmr3655616d50.44.1777473806821; Wed, 29 Apr 2026
 07:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419185750.260784-4-npache@redhat.com> <20260420131549.3673619-1-usama.arif@linux.dev>
In-Reply-To: <20260420131549.3673619-1-usama.arif@linux.dev>
From: Nico Pache <npache@redhat.com>
Date: Wed, 29 Apr 2026 08:43:32 -0600
X-Gm-Features: AVHnY4I1QOeoIsPtdFMRgostIrIoED-4ANNwkr8mXezmIk-ShLJX3AJsP5h7kD8
Message-ID: <CAA1CXcBSic27LKezu05-MNZ__KgKiOu2o=ftWhfCks33ts6pcQ@mail.gmail.com>
Subject: Re: [PATCH 7.2 v16 03/13] mm/khugepaged: rework max_ptes_* handling
 with helper functions
To: Usama Arif <usama.arif@linux.dev>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, 
	joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, 
	Liam.Howlett@oracle.com, ljs@kernel.org, mathieu.desnoyers@efficios.com, 
	matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, 
	peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com, 
	rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com, 
	rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: huheQbXavyIQEltEq2l2hT7Q2mYO43ZQqhwVl2K13Dw_1777473807
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On 4/20/26 7:15 AM, Usama Arif wrote:
> On Sun, 19 Apr 2026 12:57:40 -0600 Nico Pache <npache@redhat.com> wrote:
>
>> The following cleanup reworks all the max_ptes_* handling into helper
>> functions. This increases the code readability and will later be used to
>> implement the mTHP handling of these variables.
>>
>> With these changes we abstract all the madvise_collapse() special casing
>> (dont respect the sysctls) away from the functions that utilize them. And
>> will later in this series to cleanly restrict mTHP collapses behaviors.
>>
>> Suggested-by: David Hildenbrand <david@kernel.org>
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> ---
>>   mm/khugepaged.c | 114 +++++++++++++++++++++++++++++++++---------------
>>   1 file changed, 78 insertions(+), 36 deletions(-)
>>
>
> The old code re-read khugepaged_max_ptes_* on every loop iteration; the new
> code snapshots them once per scan call. If userspace writes the sysctl
> mid-scan, old behavior reacted within the scan, new behavior uses the value
> sampled at entry. This is completely ok IMO, but might be good to call out.
>
> Also might be good to write no functional change intended apart from
> above in the commit message?

Ah good point! Ill clear that up

>
> Acked-by: Usama Arif <usama.arif@linux.dev>

Thank you :)


>

