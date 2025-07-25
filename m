Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A1F1AC43A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Jul 2025 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753483070; cv=none; b=Poj212WDH5KGXfpj3l6SHFvo/afeXBCMbQz7HvtRO3t8WoPAEYm7juaywpzKsFuTkPfGq0x97utcHGwUdYs0jWqYU4ZvPukkyzM/HGoy8Xul0tO80fsz+jDj4wkdDwxOqmp7EvqNBgLeaNktS0Wol3ycpBIKCwbwbKNBYoaDlSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753483070; c=relaxed/simple;
	bh=PxMQJ32P9TM5LgrkFm1FLN9ED8pQui3GJRtf4HfC5h4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QaHB3TJwhcbj8HT3xC3CePffOuQKvQOHPkD8d7VxsFE6B/LT1Zxs07cOxFS2Vv7OA380b5rdOZO/mik5aNEUc9LhxIa0hNWfWLScUd/SCLeYHEBkG8Z4v8+12vkxA3ACz5sOOqRPjHmyJD/pIGkm+cRRw7WqB3bVC6J7tsuwiHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HLrWBITs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLrWBITs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753483068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PxMQJ32P9TM5LgrkFm1FLN9ED8pQui3GJRtf4HfC5h4=;
	b=HLrWBITsS8zgU/vH4iAPhs4UCRrHuraaL9dC619wNHtl3I5VJ+3xCqVdoggmjWEQm5ZKjA
	lrvNkjGr2eESy6/hfbeqjExx4vrPUdWgCvVHAVsN9p+Fc88fbXL4ypdq+/yFbLQp53O6lN
	/GeIUDt6Dhd1fznXArGUxYHZDpi35cA=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-nJwy3C0bM8eLpK94AsOFvw-1; Fri, 25 Jul 2025 18:37:47 -0400
X-MC-Unique: nJwy3C0bM8eLpK94AsOFvw-1
X-Mimecast-MFC-AGG-ID: nJwy3C0bM8eLpK94AsOFvw_1753483067
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-707cf1b0ecbso42044857b3.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753483067; x=1754087867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxMQJ32P9TM5LgrkFm1FLN9ED8pQui3GJRtf4HfC5h4=;
        b=VITb3Ntb4ch/rj2oQAM6DhWPtzeNRoCctCsPyscjBPV7tjbiLz96o4UOp1pQg0AT6u
         JFZ1dC8lI852j/rVenkZ6a5MgU07RY++zSmPAFI0Wss/UTeqSG8DklWdoZJBtISDj+s8
         BubK/+TC9sfREysR8QFXoBKSJB78nhKNz/MBkb0133xnYS6gLBQrViZH4CyppWrCt5Al
         mnGQl/s3FEFYfjr1o8inyrryvZ9gqJ6Yi9pRwcWxgRz6ZJhvxYc8EnkuOd7dl4ySrI9b
         SKVhNEWHkzdfxTlxBMEFfQ06lA+0M0sDpExJhptNPOwiZVFI+6BE5/8NVkL0FgrSJ/Wa
         TTZw==
X-Forwarded-Encrypted: i=1; AJvYcCWbrrjwmSbKlooT9s0lZiaZxvFg+fwRSLdQZhpUcJRRG2GHvpnkp2KbkhbQp/B9K8ij6j/DuPn+9UnxPNy+/iorXms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCp61bAewo8bD9rFO92dwdgVQE11bPEDKnyPfXfSyticq5HkNp
	PGfqbwqGMhNOJNKoktQR//O4HhGGxaU6LJF711k+1CDa3mN20OhHLhHbTPnNS06ggqC4SywAML/
	ef4Hk10q8yLhaNfKDR/HH5fkeNwMO/u0fCmq5b/sqTqPPeFC7OTYf1vbzElZb2rX0xEps7P/FSn
	NuJaugqBrByhkQo4SmY4Wx7/raCEpGM0mTqpeu+OJT1jQPc4M5
X-Gm-Gg: ASbGncsfCh3GATuQQ2ebqvlyojSKdc/9SclIpFrzPPFO3pkDAPcTwNd9btu41lOXnac
	T2vjhhAmNlflU/WICHOvrJP57CFW231iFa5xzJhZv38GDVCumljYlfdMLEEXQpr0DRJp2wjxiBA
	0+2suGVsm6MKPnL8JOKqsUceQ=
X-Received: by 2002:a05:690c:4513:b0:714:3e:f424 with SMTP id 00721157ae682-719e3461242mr52042867b3.35.1753483066645;
        Fri, 25 Jul 2025 15:37:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfOqA9QhdPY+M0vEESx6VKf5ml2IvqKk9pj3fqjSjpp95LtZTi4ZjJtdc1Jt2Guhr63gv18jpOEl7GBVnJQNw=
X-Received: by 2002:a05:690c:4513:b0:714:3e:f424 with SMTP id
 00721157ae682-719e3461242mr52042437b3.35.1753483066311; Fri, 25 Jul 2025
 15:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714003207.113275-1-npache@redhat.com> <20250714003207.113275-6-npache@redhat.com>
 <f87dd075-59e1-463f-bc36-0f6582abf31c@lucifer.local>
In-Reply-To: <f87dd075-59e1-463f-bc36-0f6582abf31c@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Fri, 25 Jul 2025 16:37:20 -0600
X-Gm-Features: Ac12FXy2-qDATzXIVs0g2RONSMMgciAzDMU4oBvRHpQajDJJel4xlOl2pw4wSCs
Message-ID: <CAA1CXcD0qKMqR4KSD-uqVORk=_gB=JwfkQ5owYV792B5Ng788A@mail.gmail.com>
Subject: Re: [PATCH v9 05/14] khugepaged: generalize __collapse_huge_page_*
 for mTHP support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6TN1GF6mM2JbQdpTxPlGXg8dm098NPmbHeL2RktHrDE_1753483067
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 10:15=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> FYI this seems to conflict on mm-new with Dev's "khugepaged: optimize
> __collapse_huge_page_copy_succeeded() by PTE batching" patch.
Yes, I did notice this last time I pulled. I haven't taken the time to
resolve it, but will shortly. I want to make sure I do it correctly
and that these two dont conflict in any undesirable way !

Cheers,
-- Nico
>

