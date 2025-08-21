Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3850A258EFF
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789973; cv=none; b=sUe/RoWblCxexZHCcIg2o8s9UD7HLpgYJ5xTDt8edONnNS3B8cMLVFzx092OjV9qIQAuTuA7kjypQottQoA33nOQupjWUn4UEptLs47mQ+1wswFjNKmP1mPDvKOYVEZAVH3oTR0yrastcpTQVnMX4HqpS0y2XNxGEcH+LCaO/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789973; c=relaxed/simple;
	bh=8moJCROeW1MwwauO6xq63NCG7+noaOTOnQ79nf4Lx80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+dxRO888j7PUxYqjb4kSAViptbX59OXe1iEAhzyrvXZ3jOu27i35fJEuAsOOlhdBc1FindLHtMj+jou0WeO0tw5Y8Ix4+oaOSORHz5OzkcUq3cisJNaNC4h0eS8scYzgQj4/wkhDL/d6foo6WuEliic+3MsBk7lKo6QEhJFHO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YvvpiNFM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvvpiNFM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755789971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEKkDobB8vwmnFpvY8PoyUMJCycz91A8IkaT8DFK9XU=;
	b=YvvpiNFMPeyo+Diq7WO+z/dX4WVekcOuPLOTQC1obdairmSUKDZ66ChNMvCg2YXasSTP/X
	v3VSHPrep6oXp2brhGD+Aq1mDN6TNUw1Oor1h5bNbvppkA9XPsgUUeIW/H7UQF8Nh+ahPW
	hJbT+jh9vqXXVJKIzcITuhg/FS/jIWg=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-E3lfWS5HPtKeYPqtL-5cyA-1; Thu, 21 Aug 2025 11:26:10 -0400
X-MC-Unique: E3lfWS5HPtKeYPqtL-5cyA-1
X-Mimecast-MFC-AGG-ID: E3lfWS5HPtKeYPqtL-5cyA_1755789969
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-71f9ee9670eso17381907b3.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755789969; x=1756394769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEKkDobB8vwmnFpvY8PoyUMJCycz91A8IkaT8DFK9XU=;
        b=fJ0XZhey7ei2v8VUYPBzGa+Zh03n/srDvqi9a05vh8F+me5PqUT+O9XAsVFZpf+RWG
         1jbfMpo0Q5V1Xbby4A6mJH+nYhEZXsNnV5lArGOkwX04vWVw2uKj/WmQoVOYQABEwA9j
         7MBdpBsyq1sZkZG0Xt3Y5hPBet4S1jHrexQOF2EbJDRNkMiwin/bqFQR4awsSqypIaAx
         S4PHIalCw3Wo4GxfvvrgUce8BYM5Vt6l3/m0BsP+Dnz8s6T0kSZLeYkpp702ziQTbLoh
         rXkg5KIz/csmnRjRNmIktl7O5dT2hMu4erxGK7T6ZWoUZmFSQkoDx6uXe/22MbBOT0i6
         Wa+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0v0aNNVOrF5Jw2yhMfBnPcJro/v5SBaTu9wROgS5ZpklEGfYxvmvHdXtWq33F1tLAMsJfFoFSPWpcQeJnunG5e08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU/DZKevSmSabqiHi9C6mnqroZiB6YgL77Go3zcwG+yIzjwjki
	8T3O2rmSsGh+ZLWIbZImIVHEaitI1Uajk1BSsH3D3Pdn7FD1h7KNMZgUkG08U618V8WgEABP8wn
	WZxleQy06Ui7tA1RZ2svt/zSMXY78BqCC6JitV9svwsgIPGjmVtV9JkqtJ4uFdFUWjrkIYu4sEm
	n4awddR68F7hhUNnkbMjbFY+5GUvztDzB8kGKvjZRDdrr82G4X
X-Gm-Gg: ASbGncsxl5Sn5xXpE1K7DL+FdhH99OoJa54Mr50qrO8GHP4T5Kwng73ZTbnjBcTHPaR
	cF9x5LbsunSKDNuI672a4cXBKl9XQsIh/TmPV8xnpBt5h6VekkTFT47Zd1iMZqtJwDydCTHxc+m
	a2TUgc21rYAOseL++cLpLogcU=
X-Received: by 2002:a05:6902:100b:b0:e93:b92c:ee20 with SMTP id 3f1490d57ef6-e95088e66fdmr2698991276.6.1755789969220;
        Thu, 21 Aug 2025 08:26:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA0f6PQCn0aQQ73DO5x40Ev9z93mEJijQRhHTNYum23X09DqH0vh6LBZKUrLyYzx7jARY0Uu5ScQ6B+4yOKuI=
X-Received: by 2002:a05:6902:100b:b0:e93:b92c:ee20 with SMTP id
 3f1490d57ef6-e95088e66fdmr2698871276.6.1755789968301; Thu, 21 Aug 2025
 08:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819134205.622806-1-npache@redhat.com> <e971c7e0-70f0-4ce0-b288-4b581e8c15d3@lucifer.local>
 <38b37195-28c8-4471-bd06-951083118efd@arm.com> <0d9c6088-536b-4d7a-8f75-9be5f0faa86f@lucifer.local>
In-Reply-To: <0d9c6088-536b-4d7a-8f75-9be5f0faa86f@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Thu, 21 Aug 2025 09:25:42 -0600
X-Gm-Features: Ac12FXxfRB0-YWz05cxs6Jud7daM5CQrb2gQwUVzVsT0dS5nUzi2PQuSgYs9--g
Message-ID: <CAA1CXcCqhFoGBvFK-ox2sJw7QHaFt+-Lw09BDYsAGKg4qc8nSw@mail.gmail.com>
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, corbet@lwn.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org, 
	peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com, 
	sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oCgfV_UUrGDxUHJynk5Q52kxZeoPo7qMnRbo3VhytWU_1755789969
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 9:20=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Aug 21, 2025 at 08:43:18PM +0530, Dev Jain wrote:
> >
> > On 21/08/25 8:31 pm, Lorenzo Stoakes wrote:
> > > OK so I noticed in patch 13/13 (!) where you change the documentation=
 that you
> > > essentially state that the whole method used to determine the ratio o=
f PTEs to
> > > collapse to mTHP is broken:
> > >
> > >     khugepaged uses max_ptes_none scaled to the order of the enabled
> > >     mTHP size to determine collapses. When using mTHPs it's recommend=
ed
> > >     to set max_ptes_none low-- ideally less than HPAGE_PMD_NR / 2 (25=
5
> > >     on 4k page size). This will prevent undesired "creep" behavior th=
at
> > >     leads to continuously collapsing to the largest mTHP size; when w=
e
> > >     collapse, we are bringing in new non-zero pages that will, on a
> > >     subsequent scan, cause the max_ptes_none check of the +1 order to
> > >     always be satisfied. By limiting this to less than half the curre=
nt
> > >     order, we make sure we don't cause this feedback
> > >     loop. max_ptes_shared and max_ptes_swap have no effect when
> > >     collapsing to a mTHP, and mTHP collapse will fail on shared or
> > >     swapped out pages.
> > >
> > > This seems to me to suggest that using
> > > /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none as some =
means
> > > of establishing a 'ratio' to do this calculation is fundamentally fla=
wed.
> > >
> > > So surely we ought to introduce a new sysfs tunable for this? Perhaps
> > >
> > > /sys/kernel/mm/transparent_hugepage/khugepaged/mthp_max_ptes_none_rat=
io
> > >
> > > Or something like this?
> > >
> > > It's already questionable that we are taking a value that is expresse=
d
> > > essentially in terms of PTE entries per PMD and then use it implicitl=
y to
> > > determine the ratio for mTHP, but to then say 'oh but the default val=
ue is
> > > known-broken' is just a blocker for the series in my opinion.
> > >
> > > This really has to be done a different way I think.
> > >
> > > Cheers, Lorenzo
> >
> > FWIW this was my version of the documentation patch:
> > https://lore.kernel.org/all/20250211111326.14295-18-dev.jain@arm.com/
> >
> > The discussion about the creep problem started here:
> > https://lore.kernel.org/all/7098654a-776d-413b-8aca-28f811620df7@arm.co=
m/
> >
> > and the discussion continuing here:
> > https://lore.kernel.org/all/37375ace-5601-4d6c-9dac-d1c8268698e9@redhat=
.com/
> >
> > ending with a summary I gave here:
> > https://lore.kernel.org/all/8114d47b-b383-4d6e-ab65-a0e88b99c873@arm.co=
m/
> >
> > This should help you with the context.
> >
> >
>
> Thanks and I"ll have a look, but this series is unmergeable with a broken
> default in
> /sys/kernel/mm/transparent_hugepage/khugepaged/mthp_max_ptes_none_ratio
> sorry.
>
> We need to have a new tunable as far as I can tell. I also find the use o=
f
> this PMD-specific value as an arbitrary way of expressing a ratio pretty
> gross.
The first thing that comes to mind is that we can pin max_ptes_none to
255 if it exceeds 255. It's worth noting that the issue occurs only
for adjacently enabled mTHP sizes.

ie)
if order!=3DHPAGE_PMD_ORDER && khugepaged_max_ptes_none > 255
      temp_max_ptes_none =3D 255;
>
> Thanks, Lorenzo
>

