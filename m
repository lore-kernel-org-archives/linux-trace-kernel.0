Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509603C457D
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Jun 2026 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488977; cv=none; b=mVowLz0WkRIRhK8cZp1kPDIfqqjMrsz9lZdQlsxo9FpUdhxR02Tx3qL6y/drXmfaZqaCaEKedV73/8VA2XByj8SObMeK354eZttCfZYw7HhAdx5m2pByCYy0uit+42UzjAMcAJXSe9dwryMSyDIxjKEmzL60INtS3OnwUiIe9Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488977; c=relaxed/simple;
	bh=rr4Wx+WQ9kTyjJZ4jV8jG377uxMzetXCa4qJ2aoZkEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Whbm97xpJma9wyPs+2MpO0syk2eXulBAxkT0EPNZyhTG+9HepW5cWTT9CXZKeW3R9Py4XKXYKt/KRLz5kHOnwbjzunzKINLDWwbYZai7MK4gt03ZfrDBux4pp4Ms7UJ3nil1nvV29ywINVOMoGOvykZUl0DHiYafxggdk09GAUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhPLtiqa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhPLtiqa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780488973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNEtlb9dNSrrLzMMlCD/oxjjgcgHEDwsYx0ryDudzQI=;
	b=KhPLtiqaaf42r74tNqWy+6vL3uqUREgPnv7o4mNYccL04f43U7Az99Wy2elHa7w9Uz0I9P
	+qNhNTJCHV7G0W+xScw5mLHPf78V53ZADRyova4YdmgpOjgrKZ/hbHnPY6l5vAHYv/r+Wd
	CN689KO6xrQ613C60gKxNpGGL/aR7m0=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-3cPI7TLkMDqLMrjnXtBYZA-1; Wed, 03 Jun 2026 08:16:12 -0400
X-MC-Unique: 3cPI7TLkMDqLMrjnXtBYZA-1
X-Mimecast-MFC-AGG-ID: 3cPI7TLkMDqLMrjnXtBYZA_1780488971
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-660d7828a5bso1213296d50.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jun 2026 05:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780488971; x=1781093771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wNEtlb9dNSrrLzMMlCD/oxjjgcgHEDwsYx0ryDudzQI=;
        b=oquUb7qonCkJg/2dhknJanDXCltdgnaDEbP9cqhH+rCxSlCf2lxBhl+SRN4FLgr0Nu
         33K2J67U/IfflH6fV3vPB5wZ9sSq9GASt3s/ATLL2ubYLHARdWj2LxkbRQ1DC4O8TD/0
         4xSX8KySPaOLXw8tporOMD0nj7fEx12q50T8LavKOevB4wUk6F4poKq3q0K9koYj0WHW
         A3FQDr+lE+OJra5pOadYXpeUrq7Pqnffhb90Qb7UR4gVEcDl9lsz3C08pqnT2GzV1UNr
         wNIfXNErquw4AViKW5olL2dtVmA9OPCqnGkIm/fzBOVrOmj+3Aw0Fjw18BFs6Rm8XowU
         JWxg==
X-Forwarded-Encrypted: i=1; AFNElJ9M6MH0h8KDIULAgq96HyDEP8EwznsBGYGfiXC+fqAg8WRgQNclmCJ1Fe7m5But3qMKB9mObN4PQ2PfcEjbz1HyFQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjoLL8oBq/QyJ/cFVsWEaKbLByBW8ITYrYbwW0ivCJRQsI3fTq
	Kaevhqum9E37Qy34HUeEr6fqrZL0iZMUMgPVP6LxOl+bQTjb4QZO9VoTuJQ3X63o5iAUza3aQJ5
	/f0AbASpHb6d61e8OXdEVaQQ/Jcm6VbweRAAzbTY7iGzPM/ruNL5QFZYbEq2LxnlCLf73QRmXBH
	sJRzdwR2/OQ1G99Gd1HioYfB1rDiBYWTGBwHUnPXUDzH2YxHzr
X-Gm-Gg: Acq92OGXrlmCWOR+3k9c5FZfCcwgp+/rj4rEhXbmfKjk1HGFViWuo0MH8E0sE5SiUJc
	VvC9SwfGDjCLW1IQb05sB7DnIqv5VizDYepQRiD8rrHG45KPGLisaAKp8nCwxd7G4l8VXa28Gml
	pAFJib0m4U90B9Gdx5stDCOUE/zEacuXYrq03uX+GMqnyp9EZbDo2E8F2/Syr0HorWaXyHM8ReN
	WgbgsoHfnXhR3ZD8A==
X-Received: by 2002:a05:690e:440c:b0:65c:58d2:18a5 with SMTP id 956f58d0204a3-660dcbf56cfmr1408292d50.41.1780488971415;
        Wed, 03 Jun 2026 05:16:11 -0700 (PDT)
X-Received: by 2002:a05:690e:440c:b0:65c:58d2:18a5 with SMTP id
 956f58d0204a3-660dcbf56cfmr1408255d50.41.1780488970976; Wed, 03 Jun 2026
 05:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522150009.121603-1-npache@redhat.com> <20260522150009.121603-12-npache@redhat.com>
 <b8380eb3-096a-49f1-9ace-99c1e75888b4@kernel.org> <CAA1CXcBg1su-bk3i_H+TW4-nTgvGSGqRNeC9MpQo7sGeH8ejnA@mail.gmail.com>
 <d3c2b00c-6810-434a-b837-0707b0a11611@kernel.org> <19639b08-5bf1-4974-9635-c458d512fa38@redhat.com>
 <ef5c470f-3c32-418d-9566-17ec01b691bb@kernel.org>
In-Reply-To: <ef5c470f-3c32-418d-9566-17ec01b691bb@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Wed, 3 Jun 2026 06:16:52 -0600
X-Gm-Features: AVHnY4LAQaiaHNznOXVI6g4R-yc6NKejy8321oN1JhGLTXQQA6dG-VWPanP8lA0
Message-ID: <CAA1CXcD_Bz=Si+vP0Sg_FhAHVjbeAJ4VdvtWGM-jVYiRXFHAnw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v18 11/14] mm/khugepaged: Introduce mTHP
 collapse support
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com, 
	jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, 
	lance.yang@linux.dev, liam@infradead.org, ljs@kernel.org, 
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com, mhiramat@kernel.org, 
	mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, 
	raquini@redhat.com, rdunlap@infradead.org, richard.weiyang@gmail.com, 
	rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, 
	surenb@google.com, thomas.hellstrom@linux.intel.com, tiwai@suse.de, 
	vbabka@suse.cz, vishal.moola@gmail.com, wangkefeng.wang@huawei.com, 
	will@kernel.org, willy@infradead.org, yang@os.amperecomputing.com, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com, 
	Usama Arif <usama.arif@linux.dev>, usamaarif642@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GK9Q17Yudc-lCgdfU9jhVFZluKZypkCg4Y5hujNKZ4Y_1780488971
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 4:01=E2=80=AFAM David Hildenbrand (Arm) <david@kerne=
l.org> wrote:
>
>
> >  next_order:
> > -             if ((BIT(order) - 1) & enabled_orders) {
> > -                     const u8 next_order =3D order - 1;
> > -                     const u16 mid_offset =3D offset + (nr_ptes / 2);
> > -
> > -                     collapse_mthp_stack_push(cc, &stack_size, mid_off=
set,
> > -                                              next_order);
> > -                     collapse_mthp_stack_push(cc, &stack_size, offset,
> > -                                              next_order);
> > +             if (order > KHUGEPAGED_MIN_MTHP_ORDER &&
> > +                     (BIT(order) - 1) & enabled_orders) {
>
> Why not a test_bit() ?

The test bit is at the top of the loop. This adds a exit if the lower
orders are all disabled or we hit the last order.

>
>
> But, wouldn't you want to skip orders that are not enabled and try with t=
he next
> smaller one in any case before you advance the offset?

We are currently iterating through each order (not skipping them).
There may be optimizations to avoid iterating through every order
(like your changes suggest), but currently, every collapse, whether it
succeeds or fails at the bottom order, must also iterate the offset.

lmk if that makes sense!
-- Nico

>
> --
> Cheers,
>
> David
>

