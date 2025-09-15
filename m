Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2DE319872
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943848; cv=none; b=JJeWT2q3Gvv8d8DvuNd/TMoBAIzh4vfhX8OjcoFJ3IE68dtAC1h3zeqoMhyfdmPrLhlEJtrhrYh20tZiMl/XuvdgXqcIEIa8bniKwLqLFsP5BTDflebNMe6sYjtiZKIMMePg7yBIyuB+7PRnKsjWrWCnkHyLgd1ojOi1OcEKUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943848; c=relaxed/simple;
	bh=eWsE6lXzcWArDuZ2O6Ifm6kkXdfeCZmZ5u1H0M37k40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkXYmEUFJfCR8wVb4fvO3ag1LVFRC2Z8oDVJH4Z99bBLDOct+qQH0upknqBq9Ug3++IT3rix1a8OVKfQHnCVNd0vOfl9q7dEIvsROd1ox7Udi3iUH6jgU9bXXJuMr0qXmbbTodqJ05eCyYGcVWpWUclE1wjLkSVeG+VZVsnwgv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=hImU0ZhL; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="hImU0ZhL"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8287fa098e8so150198385a.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1757943845; x=1758548645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q6oMWOUjEhTHaIkKCNJfxWZcVknSr0QJ4euJbdXpCDU=;
        b=hImU0ZhLMM4O1/+INHZf+yWIT5wCoYldrmt04hNyQcsIMvvgy6ffpXM5uAJFP6xmmV
         rX+wUhUq9rLgbb749tAs3fk1lbcIBd3d26HWWsAvwWE603wjqKrN7SuSbSTAANYqagjo
         ZF1kYZN0T/LxRFV8o/8gYTtOIa6z1TLdUbvFvqUGtHYfaoHy7rEst8yqT4Gu6uoD6XJG
         kx+H9T9OI4Teuhap3QTMZldKpbjE3L8V/DZpFvxK76U/aqwBJ9DOVbl9/gZWhjMluvFy
         D+Qau1gwCGvVyECD8g6hxXBq0PA2QLCNxUgiVuk11UUF012hfC6i6LyisOevWllmprej
         M27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757943845; x=1758548645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6oMWOUjEhTHaIkKCNJfxWZcVknSr0QJ4euJbdXpCDU=;
        b=UYHd8YNlJvu32T2y44gNYLkxzvnhtlNwNvd44LvDlCGQ3ZI/ipPGP+wASiULBXkMvb
         xCVPJ38+AqDd6k/Eq4RpC6ZTrAo1OvxJgkOpXlGM3vCNZVLLO50z6Tk4FoGuYZ+mfbxf
         TrFL+2aDn4XOsbnT3ED/OMHUUaVY3mR9zn/chfyCLC9l1zk2iD/LVixAchDxY2NSyFUT
         uM7+1tUghMrXKeWaqxRFST+VJLr21jCEa4VEjegfeYFrWpX2mepgkdQ2iVsu/80JRvQx
         yNM42xbLY75F69/Qmd/PCGLi3BHuIKntgAu9q6ZgJtIT58x7PBgakD+k0B7fKjBoQOQT
         F9+A==
X-Forwarded-Encrypted: i=1; AJvYcCUnpbaNFxuwBWmCXyhVOFMlEsKR7HasotG4/UgT9/suOX+iOqGnuN15btWAz/k5MMcCBKRVDe3ov8f95RTjIScdkmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzE7j4rEmVVyYLMjDyIzc6ed4ufbNfM64suQM3e10HUhjSXcx0
	vTGJ5Dkf2xwKmcy85R0qDpJZMMEO85gNaWrqNn/IIjzxYOxpvnU0vg8cUTo6X7+b0Cw=
X-Gm-Gg: ASbGnct5ag4+/JVbWe7eAj10PZ+/o0KEqtiY3w3wmuTAXLA6YgkdHsreHiKO9fgsNdD
	+WAgM8daEUQEyWgUzEs69IQrHHGXyH02V9FK6DOuAzzm1jRGekgRhgl5S+gzWUTkUXFkr00o06F
	zhs/6soMSKG0PV2IGNtLzY1MQreuQoSQ0uobk4NLqBvaVvKJ0Ew3pDU4MpU+e9kuZfARpME3KYy
	upRHE5VcTf2j9jF8YL3C5r20YhHeu4X6xk28F0QYLORAut0HNAGGwb9bXlqQFkEdNSs2VyjUYZw
	U8udrSMuS5KZIW/ZCMkHecQSf4S0y+Vn1v+SSpNjbWYY3RrIZaUiXqQ/KiqGy0BS1Uj8ncmbahS
	9unRA9Svh/WyVRETPkGTTCW0N4p9mKzO+YNvCoak99GY=
X-Google-Smtp-Source: AGHT+IEpx1kLk3BJgZa+W6SfvekSSLAHkh6bU7VHRFGYegEO0mCkS/PzSHlaHZMWsZNyeolqd/d0Qw==
X-Received: by 2002:a05:620a:394f:b0:827:d7c3:cde8 with SMTP id af79cd13be357-827d7c3cf5cmr771847485a.57.1757943844439;
        Mon, 15 Sep 2025 06:44:04 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-77f44157463sm25210606d6.2.2025.09.15.06.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 06:44:03 -0700 (PDT)
Date: Mon, 15 Sep 2025 09:43:59 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: David Hildenbrand <david@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Nico Pache <npache@redhat.com>,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
	sunnanyong@huawei.com, vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
	jglisse@google.com, surenb@google.com, zokeefe@google.com,
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org,
	hughd@google.com, richard.weiyang@gmail.com, lance.yang@linux.dev,
	vbabka@suse.cz, rppt@kernel.org, jannh@google.com, pfalcato@suse.de
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
Message-ID: <20250915134359.GA827803@cmpxchg.org>
References: <20250912032810.197475-1-npache@redhat.com>
 <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
 <20250912133701.GA802874@cmpxchg.org>
 <da251159-b39f-467b-a4e3-676aa761c0e8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da251159-b39f-467b-a4e3-676aa761c0e8@redhat.com>

On Fri, Sep 12, 2025 at 03:46:36PM +0200, David Hildenbrand wrote:
> On 12.09.25 15:37, Johannes Weiner wrote:
> > On Fri, Sep 12, 2025 at 02:25:31PM +0200, David Hildenbrand wrote:
> >> On 12.09.25 14:19, Kiryl Shutsemau wrote:
> >>> On Thu, Sep 11, 2025 at 09:27:55PM -0600, Nico Pache wrote:
> >>>> The following series provides khugepaged with the capability to collapse
> >>>> anonymous memory regions to mTHPs.
> >>>>
> >>>> To achieve this we generalize the khugepaged functions to no longer depend
> >>>> on PMD_ORDER. Then during the PMD scan, we use a bitmap to track individual
> >>>> pages that are occupied (!none/zero). After the PMD scan is done, we do
> >>>> binary recursion on the bitmap to find the optimal mTHP sizes for the PMD
> >>>> range. The restriction on max_ptes_none is removed during the scan, to make
> >>>> sure we account for the whole PMD range. When no mTHP size is enabled, the
> >>>> legacy behavior of khugepaged is maintained. max_ptes_none will be scaled
> >>>> by the attempted collapse order to determine how full a mTHP must be to be
> >>>> eligible for the collapse to occur. If a mTHP collapse is attempted, but
> >>>> contains swapped out, or shared pages, we don't perform the collapse. It is
> >>>> now also possible to collapse to mTHPs without requiring the PMD THP size
> >>>> to be enabled.
> >>>>
> >>>> When enabling (m)THP sizes, if max_ptes_none >= HPAGE_PMD_NR/2 (255 on
> >>>> 4K page size), it will be automatically capped to HPAGE_PMD_NR/2 - 1 for
> >>>> mTHP collapses to prevent collapse "creep" behavior. This prevents
> >>>> constantly promoting mTHPs to the next available size, which would occur
> >>>> because a collapse introduces more non-zero pages that would satisfy the
> >>>> promotion condition on subsequent scans.
> >>>
> >>> Hm. Maybe instead of capping at HPAGE_PMD_NR/2 - 1 we can count
> >>> all-zeros 4k as none_or_zero? It mirrors the logic of shrinker.
> >>>
> >>
> >> I am all for not adding any more ugliness on top of all the ugliness we
> >> added in the past.
> >>
> >> I will soon propose deprecating that parameter in favor of something
> >> that makes a bit more sense.
> >>
> >> In essence, we'll likely have an "eagerness" parameter that ranges from
> >> 0 to 10. 10 is essentially "always collapse" and 0 "never collapse if
> >> not all is populated".
> >>
> >> In between we will have more flexibility on how to set these values.
> >>
> >> Likely 9 will be around 50% to not even motivate the user to set
> >> something that does not make sense (creep).
> > 
> > One observation we've had from production experiments is that the
> > optimal number here isn't static. If you have plenty of memory, then
> > even very sparse THPs are beneficial.
> 
> Exactly.
> 
> And willy suggested something like "eagerness" similar to "swapinness" 
> that gives us more flexibility when implementing it, including 
> dynamically adjusting the values in the future.

I think we talked past each other a bit here. The point I was trying
to make is that the optimal behavior depends on the pressure situation
inside the kernel; it's fundamentally not something userspace can make
informed choices about.

So for max_ptes_none, the approach is basically: try a few settings
and see which one performs best. Okay, not great. But wouldn't that be
the same for an eagerness setting? What would be the mental model for
the user when configuring this? If it's the same empirical approach,
then the new knob would seem like a lateral move.

It would also be difficult to change the implementation without
risking regressions once production systems are tuned to the old
behavior.

> > An extreme example: if all your THPs have 2/512 pages populated,
> > that's still cutting TLB pressure in half!
> 
> IIRC, you create more pressure on the huge entries, where you might have 
> less TLB entries :) But yes, there can be cases where it is beneficial, 
> if there is absolutely no memory pressure.

Ha, the TLB topology is a whole other can of worms.

We've tried deploying THP on older systems with separate TLB entries
for different page sizes and gave up. It's a nightmare to configure
and very easy to do worse than base pages.

The kernel itself is using a mix of page sizes for the identity
mapping. You basically have to complement the userspace page size
distribution in such a way that you don't compete over the wrong
entries at runtime. It's just stupid. I'm honestly not sure this is
realistically solvable.

So we're deploying THP only on newer AMD machines where TLB entries
are shared.

For split TLBs, we're sticking with hugetlb and trial-and-error.

Please don't build CPUs this way.
