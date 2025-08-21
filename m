Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7291FBEA6;
	Thu, 21 Aug 2025 03:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747718; cv=none; b=VBjOXiGc5SUjxQIeWRr2oTbe9DbzLd0y6y+dqG+/1/yTDD5ln14P6X/0w2cbrKZMMFwTEzaWK8CY70H+kVzQvmVTSimisdt/PO2TAUU7If8OFCzRHMTbUDW135lfJ5C/iy8UHPgSqJNowsjSHlhOVp5/mr+XvoMX2JZRrz/YzMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747718; c=relaxed/simple;
	bh=X+MusV7/pRuzSWK84Guko9Sj7ekebKWsuoI3ckFV02k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yv+ThHgazDQZ7/63QA2mh9seUZehGiVzUpqm0hpuFab4YfuuvepxSNwvP3vwdlWnicGQdUIrW5QY6EOqHXvlDOsCZYuFsGBFbHsNY0JVDQyEHEOVOSWu4+DL9cc9xKMLKIXNRIhCNoASLzqfekX8ov+5nX+Z0kl9WewhbS6dKiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEMdT9DK; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEMdT9DK"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb73394b4so81144966b.0;
        Wed, 20 Aug 2025 20:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755747715; x=1756352515; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ly8HhEQvY9JxMVhrYHzoh/hAff3HjFqcoEOj5b7KCq4=;
        b=ZEMdT9DKGVPUePaus5FFyXbk3eLDWC8B6ohc3qetL7MdDsWjxA3kT5ey1D9i7Nu3T+
         lTTC9S+mPBPbF1bdBcI5kLy/QHns9OFTc2p3MxwOhucGUJbWCNW8TD01uoyWZNF6UgKG
         O9PeKfqJICWpp6Cw9CeZngFxE9nA4Q0gAx2B/SoMSwrOdaJrrOI6BjZ06fkszz9mourR
         DkGMXe+YQ/KeAHu++P4yMqFBWadA9CyCjLarGklfhSQdx4GmCY/FFJcf0L+mWFGwmo8w
         AVZBHNHs9z06ewFE96wpAVNMXJu+APjVECh0E/lsPK41T2tNPeyQg8mYRYBIGqX8HuPk
         kN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755747715; x=1756352515;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ly8HhEQvY9JxMVhrYHzoh/hAff3HjFqcoEOj5b7KCq4=;
        b=cgJExGWyBzlUXk7CDAiYAGKkJl+oOF/8M0qYwaGjH2lj1EhyEQ1VZLj7cU9DqpJWmx
         G/VmKTJ5s2lkhEkfLHa8kYWu363NfpxIvK7hvugx4VPJYeIYmnvn/XTAHntX69++RMy6
         78VH+3e4juFJP+KXZHcq2doUry0XKmhlUHkMuY/3Lqb4bbGAB63RZi4bdsSErmF9q22R
         pm/GFZYO//MGt5UbL1hMxCCGusQ3Yer8mjRnvVSzBXK+E3cKPy5jjw8hvmfnZ1AvcqkI
         IclBPOBn6sf1+pvbxgbP40gNusDgy41RX6PwPz3xyKGMWkpGjHzpDqEiIIA/C2GKTPGN
         6dYA==
X-Forwarded-Encrypted: i=1; AJvYcCW78S5+yZ2JacgKY4ce0EoEqjMXnGSOCcwkFTNscxEMkFDcj5h/dHkCSuBPuYG6L6YQFoEwFynuNxwl0okQ@vger.kernel.org, AJvYcCW88HcGYAHvdY9BCLNNFquzmWKyzERn53YaHot8qIog27vTm0dRYxDgXz5j0YIv4pPifGIr4xEPPvM=@vger.kernel.org, AJvYcCX0f0T2kQ20kUvdrH9IOfrVE7wVT5vPIwx83K6mMNigOfZjJLinQuWiHPTRdl34ECBO6zh62DQCIfuVYXkBeakshhu7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy050G6Yvky7ECqvi9I5ZkMq7XFflsBiZZAM9EqZi5D855WvImZ
	N8XjUJ6wQeRblfIyOVVGuBhdoL22L4PRqxNB7nUNVSn4rzVkE2DiviF4
X-Gm-Gg: ASbGncv7WyuS9Prxf0OsIuqe/qfwCeMbhNbmpvLcaXpr7X9nXFCyo5Q7FyiQP5cg7A0
	i8/RPYV1395JrCPLyVAGjzFVDDbn4NnHgBob+k2L/gz9tH2Ze2oAH3EFpHGto8s9qiaMcnyfIcR
	hJ+aDYpUFFBuG3XNY+v1bJ/A725OvCpqlVVaNUrTZJSoYqXaQzKkETa/PmtkaxmrdOgtP52Pt9f
	8W31MklQhFIfgHhb2d1PRt95lKbRTj6ls2/pf3C3P72QHXfn/TwHTCJxrVmUK1w9s+cuRDEdSjs
	v2DtF/POZHo/DQTSLJT+7KJhmIyfJ6Sh6MgnCPSz532cBAgQdAMFAKscHO5CMRXZeB/oLnpMJWR
	jwn9p38wnce1Pyd7L4zs1rQ==
X-Google-Smtp-Source: AGHT+IGaJqB8Du4nZbwZH6+ZZ1UR1jsjKqH51Z9VenWWYM+Y2riY0qwNibopPt1+EA0CWK1IUnGClQ==
X-Received: by 2002:a17:907:3e8d:b0:af2:5a26:b32a with SMTP id a640c23a62f3a-afe07c154d7mr97515766b.30.1755747714772;
        Wed, 20 Aug 2025 20:41:54 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded2ba31dsm299249166b.12.2025.08.20.20.41.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Aug 2025 20:41:54 -0700 (PDT)
Date: Thu, 21 Aug 2025 03:41:53 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Nico Pache <npache@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, david@redhat.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
	sunnanyong@huawei.com, vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
	kirill.shutemov@linux.intel.com, aarcange@redhat.com,
	raquini@redhat.com, anshuman.khandual@arm.com,
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
	jglisse@google.com, surenb@google.com, zokeefe@google.com,
	hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
	rdunlap@infradead.org, hughd@google.com
Subject: Re: [PATCH v10 03/13] khugepaged: generalize hugepage_vma_revalidate
 for mTHP support
Message-ID: <20250821034153.uyxjy5yvxx5no5sf@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250819134205.622806-1-npache@redhat.com>
 <20250819134205.622806-4-npache@redhat.com>
 <cd4dd743-679f-4c55-9635-6d32e6fa5ff7@lucifer.local>
 <CAA1CXcDORXqm4JoHn4ZSEhT3ajsuY2MAPwefMXk3+YMXcpvqkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA1CXcDORXqm4JoHn4ZSEhT3ajsuY2MAPwefMXk3+YMXcpvqkw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Aug 20, 2025 at 09:40:40AM -0600, Nico Pache wrote:
[...]
>>
>> >       if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
>> >               return SCAN_ADDRESS_RANGE;
>> > -     if (!thp_vma_allowable_order(vma, vma->vm_flags, type, PMD_ORDER))
>> > +     if (!thp_vma_allowable_orders(vma, vma->vm_flags, type, orders))
>> >               return SCAN_VMA_CHECK;
>> >       /*
>> >        * Anon VMA expected, the address may be unmapped then
>> > @@ -1134,7 +1135,8 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>> >               goto out_nolock;
>> >
>> >       mmap_read_lock(mm);
>> > -     result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
>> > +     result = hugepage_vma_revalidate(mm, address, true, &vma, cc,
>> > +                                      BIT(HPAGE_PMD_ORDER));
>>
>> Shouldn't this be PMD order? Seems equivalent.
>Yeah i'm actually not sure why we have both... they seem to be the
>same thing, but perhaps there is some reason for having two...

I am confused with these two, PMD_ORDER above and HPAGE_PMD_ORDER from here.

Do we have a guide on when to use which?

>>
>> >       if (result != SCAN_SUCCEED) {
>> >               mmap_read_unlock(mm);
>> >               goto out_nolock;
>> > @@ -1168,7 +1170,8 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>> >        * mmap_lock.
>> >        */
>> >       mmap_write_lock(mm);
>> > -     result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
>> > +     result = hugepage_vma_revalidate(mm, address, true, &vma, cc,
>> > +                                      BIT(HPAGE_PMD_ORDER));
>> >       if (result != SCAN_SUCCEED)
>> >               goto out_up_write;
>> >       /* check if the pmd is still valid */
>> > @@ -2807,7 +2810,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>> >                       mmap_read_lock(mm);
>> >                       mmap_locked = true;
>> >                       result = hugepage_vma_revalidate(mm, addr, false, &vma,
>> > -                                                      cc);
>> > +                                                      cc, BIT(HPAGE_PMD_ORDER));
>> >                       if (result  != SCAN_SUCCEED) {
>> >                               last_fail = result;
>> >                               goto out_nolock;
>> > --
>> > 2.50.1
>> >
>>
>

-- 
Wei Yang
Help you, Help me
