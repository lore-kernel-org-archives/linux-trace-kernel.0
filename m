Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC3295516
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757720138; cv=none; b=TaHZgg8MI5TKCeDZgzw8B7LkuIPr3MJ2nbO7RjE/FB7S72gZYdl7fWpRrI0meppQoVF1OPi1pKLHHpZ1IJvDqoWLvjRXQcpC4RUMrLK71+F1ou5Wap75IxdI0YvR7AJeflvX82aa0kPyLSZeuxlbJ01eyKAxP7TaPFO7yrms8Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757720138; c=relaxed/simple;
	bh=HPCu1pwVM4Drx10GdaCY7ng58mnQe58dpSzFUAkQI+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnccKFjABE3fdizjMeovEjgd+rymz5Ccl54cDujIrSXBYiesQal/MeNkp6A7E4O3amUr0fLIluUB7kaLS+R4WIC3lB/85n/zx/Sjztn4w80ibTgTFHaG/x24mDjhJThNVnRsYgey4rVqF6npkjcCNt70mnqV5GUSmduff9j9HfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fCF7B9dK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCF7B9dK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757720135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HPCu1pwVM4Drx10GdaCY7ng58mnQe58dpSzFUAkQI+A=;
	b=fCF7B9dKtX5oGbwOI/+CpV9ZWjHRBZg9w39qyb5fMfZsPTMx49i/sDu6b2HWFK/XHwAtkh
	z2X9XhCqGFKLJBMIEHCAsUWBYyDtadvICgPaBGtD532h5zukPN5kVd4yc45eGyrBqEmpFe
	c+44W79JCJimlLDbtO/Rh7K+U9wAq6w=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-YobBDg7OPpedrGOXEFeUag-1; Fri, 12 Sep 2025 19:35:33 -0400
X-MC-Unique: YobBDg7OPpedrGOXEFeUag-1
X-Mimecast-MFC-AGG-ID: YobBDg7OPpedrGOXEFeUag_1757720132
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7216c46b069so25867797b3.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757720132; x=1758324932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPCu1pwVM4Drx10GdaCY7ng58mnQe58dpSzFUAkQI+A=;
        b=kAK+Ch/EqIiRKJaUtdQszoVEPficALL/Byig72Shpi9zIXJyvW1lIe6FmEvyoFae27
         73yfL7EpbluCgxZEevuPEie2PYMiM3akb680CRwaWbLYg6CVaDQnaFMU8p6VdTdEQl5H
         jiGHrTMpa8Y6Y8TBGfeJSnqfp4VrDbGFEy+1PeqI7SsUvPElQVdrwewhkTA1udDeGBug
         M4wwRTBSqw4TgaT1Hnyr/5ftrmrn1zcPf7Gi6jfmZyh9ZPuYn7mTiQ0EIdpnTiBS/Gf0
         WNMV4RHsFGCa5tzGZIGJyVyYHQzZjuM6MEgNC+kciZfvfU35Z1AJBETENXFjrWMI6W0Y
         7uhw==
X-Forwarded-Encrypted: i=1; AJvYcCVrzZNpCR4b/wPMqxrb2CkAewlBzsULD/W0Z0+aeyeM0r5QkkyIZygg3dJtvZr7XQp2Mf7r1xYXpW4fNayCaBS8kYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLtNd33d/gVthmoa8cY3bQ4rRPBS76JfzdpMUd+aZHFfgPN8vM
	hJa735S7OQZqk0olEFLktkXQv1mUCZ13ZD7NppvAKuWfw75TJa2CLzlsANVzknWfw1v9TIq4CxD
	dbqO9OUTr20SvQ+uo9snGoo4rlLuWwkSz2dfUnUkrnDykuG+0QuMZW1BBSK+ugYuQeb3p/OddiE
	AKv4NGwNZrX1Dvg4DxjftBsMCidlM/akA0HaBknWEaDBQn9hBbAZQ9aRgNwBgugg==
X-Gm-Gg: ASbGncul0cEhWPKgnmj45QTVebGt9YlGN+0jmSKiuzcORBgyWtPVnca6Q+BZgAOKnJl
	fdl51PY4jdlvlqnzHfh/bp7u5zfTLnWtRo54wxYC9WRhCibb2xJNo7mhM2AaAjCduZIzg4s0Wxq
	p+/RJ+GDKC9xFMCSvhKkA9E8GuVoBqEFnAQoc=
X-Received: by 2002:a05:690c:6ac2:b0:729:677e:b7b with SMTP id 00721157ae682-73065fa0c40mr46615437b3.47.1757720132265;
        Fri, 12 Sep 2025 16:35:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf6FRXt0puU/GkbiNMmkdOBMh3PmcUJa8ItdRIcV21DzC27xRjlQRyXSqK3+grheHlKb8t0P44+F+NVaC7sWY=
X-Received: by 2002:a05:690c:6ac2:b0:729:677e:b7b with SMTP id
 00721157ae682-73065fa0c40mr46614957b3.47.1757720131865; Fri, 12 Sep 2025
 16:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912032810.197475-1-npache@redhat.com> <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <43f42d9d-f814-4b54-91a6-3073f7c7cedf@redhat.com>
In-Reply-To: <43f42d9d-f814-4b54-91a6-3073f7c7cedf@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Fri, 12 Sep 2025 17:35:05 -0600
X-Gm-Features: Ac12FXwW-JyuDr21ldb1iQAOW2JaSV_ia9I1rYO-9C_34jUWMMoQfpgn4vajl84
Message-ID: <CAA1CXcAenBm4=V1=-bXmruL85MfyqTXu5_-BmzGfOEaQ4z-Tdg@mail.gmail.com>
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
To: David Hildenbrand <david@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, jglisse@google.com, 
	surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com, 
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz, 
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SZWuBf7CeqHaH_K5gEaoIleHOrbLjr0Mvi__xeSEq_o_1757720132
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 7:48=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 12.09.25 14:19, Kiryl Shutsemau wrote:
> > On Thu, Sep 11, 2025 at 09:27:55PM -0600, Nico Pache wrote:
> >> The following series provides khugepaged with the capability to collap=
se
> >> anonymous memory regions to mTHPs.
> >>
> >> To achieve this we generalize the khugepaged functions to no longer de=
pend
> >> on PMD_ORDER. Then during the PMD scan, we use a bitmap to track indiv=
idual
> >> pages that are occupied (!none/zero). After the PMD scan is done, we d=
o
> >> binary recursion on the bitmap to find the optimal mTHP sizes for the =
PMD
> >> range. The restriction on max_ptes_none is removed during the scan, to=
 make
> >> sure we account for the whole PMD range. When no mTHP size is enabled,=
 the
> >> legacy behavior of khugepaged is maintained. max_ptes_none will be sca=
led
> >> by the attempted collapse order to determine how full a mTHP must be t=
o be
> >> eligible for the collapse to occur. If a mTHP collapse is attempted, b=
ut
> >> contains swapped out, or shared pages, we don't perform the collapse. =
It is
> >> now also possible to collapse to mTHPs without requiring the PMD THP s=
ize
> >> to be enabled.
> >>
> >> When enabling (m)THP sizes, if max_ptes_none >=3D HPAGE_PMD_NR/2 (255 =
on
> >> 4K page size), it will be automatically capped to HPAGE_PMD_NR/2 - 1 f=
or
> >> mTHP collapses to prevent collapse "creep" behavior. This prevents
> >> constantly promoting mTHPs to the next available size, which would occ=
ur
> >> because a collapse introduces more non-zero pages that would satisfy t=
he
> >> promotion condition on subsequent scans.
> >
> > Hm. Maybe instead of capping at HPAGE_PMD_NR/2 - 1 we can count
> > all-zeros 4k as none_or_zero? It mirrors the logic of shrinker.
>
> BTW, I thought further about this and I agree: if we count zero-filled
> pages towards none_or_zero one we can avoid the "creep" problem.
>
> The scanning-for-zero part is rather nasty, though.
IIRC me and David have discussed this in the past and decided to avoid
this approach at the moment because it would be complicated and
"nasty".
>
> --
> Cheers
>
> David / dhildenb
>

