Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A43DA7E2
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Apr 2026 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751467; cv=none; b=H3xZbYbRGYQG/hSMRcsQ7+UbHp0RnTeWPz0Pe+RWDl34NlFM/llisYFrY59s3YQ8aRP8B5+X6e6o2oVRmiO9FMX2yAWm7Vkqg8K0YFuWXQO1dmE49N6nnpvaqXCi5xuF2s2xYCMBoDW5ns3eVNGo//TKt/hvQJn5n8DEM55gQZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751467; c=relaxed/simple;
	bh=u5xb2RET3ZHjMSQSsb7HWH90tD/uXVXf03fHQr8W4g0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkskrZCSe/2fsfCt5pt9nPMa5d6smdXKvetG2jWaoM7qRIwB2lQPr/mDiB6Cce9N6JBzvbIltaXcdpPyzDjrPLgDEL4I0QtcLpKACtsi0RCxKc1GGBIrIpXtNdJU4SsF03gMjY/ThrVd0k4MqajzSqGD0YCjkwQtkey+qbWewRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/MTE/gZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/MTE/gZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775751464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5xb2RET3ZHjMSQSsb7HWH90tD/uXVXf03fHQr8W4g0=;
	b=i/MTE/gZih4AGTVPnp9IBdgI4RCmeayfBwZg/jufhJl2gxz3E5LPKrncSNzkE/XosfDlWI
	WCqjYTgiLIbwcDKjTIcy7vszKUyOrkoeSvKOMKX6YMKYUH8MF3MgAYIfD3SEUvk/a5KwuS
	6JDV3OBfvK3NnLb0C04dM3cBAHPtmIg=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-sMuNIwbyNiCx-lfO0syI_w-1; Thu, 09 Apr 2026 12:17:43 -0400
X-MC-Unique: sMuNIwbyNiCx-lfO0syI_w-1
X-Mimecast-MFC-AGG-ID: sMuNIwbyNiCx-lfO0syI_w_1775751463
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-65088fb3f10so1998890d50.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Apr 2026 09:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775751463; x=1776356263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u5xb2RET3ZHjMSQSsb7HWH90tD/uXVXf03fHQr8W4g0=;
        b=SBq7rOpt/fOLc+JJUdkdeBEYENTfNOdA5q42XtH2jwZPxaJiONLJsQT5UoZPKppuqM
         5wK6yeXf3lL/1zfDBA6JLmDciklLt7cmq713zGtxNfrc6tdK1Z0NLGbsDcbnl8zujNcq
         PMRpjw3r3Jtkf88alNBabQLkd31/z6SsyOew+1nb2H37hKpyJDy3MftOffA4NLtA3qGj
         xG+XJIzZ7T6q0v0PCR8UJb7wd3t5uWUWX9GCZC09SKVdU0cAOgH/pApA+OZPZtdUbeGu
         7ApO+9PhP6yUQYU7jWGjtBGvU2piCPL68GEiSIconjy6NPc/6pTUe8H4kXbJp2nLTDZ6
         kgtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOQYM0h7hhWoP4jO0t6cLxzFOdwF3OYHRQ7hO3i6hgVK43sthTXk6SI88xTwDwiqKXEnp/5z6S0pQf0JEn5/LoCFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwppopbPtXwE/aXPRRaWg9WSJknO0uepWkX9yOomPqd59ZxRaqF
	OL2ckKadXmUr0Ne+QovLww79sjb8veVxE/fh9QKlxZfea6CXwZ8LJZinwXOB3dMZ3HiWcwqM7fh
	2jJgiNSn/B3H2eKAEBy3idjGM44XR0Eb1f5bG6q6ERKc+j4Gj5AOKSQpCLLK6q7gNnz8aQgZkdy
	8If8O1OlGtb7rEQ+a0YFBESOqsVIEEo5KVqn4q9vB7fUWRVOVq
X-Gm-Gg: AeBDiesKv/a4CdokMRkXf0xt4XtbfEw/29es5tAvjg6z/PItC3m+Mj53LzE4ttbKwPk
	iJ+t98xlTIF1FP6wVUJDKa+bDodzz6OUD+jALM/I5I9kOul/DGeyKeu576wyHsTCqwZVrpOMzAB
	i8VcCmCM16UBlcA1Uiwc+8SM0j5fcLrLlfHnf1Gu9Ovu5IXKCkBzf/9lp7yEJJwG37+CwwLSBZu
	J/V1iQP
X-Received: by 2002:a05:690e:11cd:b0:64e:e0fc:a311 with SMTP id 956f58d0204a3-650488b2a89mr24106313d50.66.1775751462419;
        Thu, 09 Apr 2026 09:17:42 -0700 (PDT)
X-Received: by 2002:a05:690e:11cd:b0:64e:e0fc:a311 with SMTP id
 956f58d0204a3-650488b2a89mr24106105d50.66.1775751459745; Thu, 09 Apr 2026
 09:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226031741.230674-1-npache@redhat.com> <20260226032347.232939-1-npache@redhat.com>
 <8a4568de-e0f9-471b-bc94-1062d4af3938@kernel.org> <ee39e605-0d9f-433b-9dfa-f70fd92edfac@kernel.org>
 <c4e80668-9018-48fc-883c-5d52a5950065@kernel.org> <CAA1CXcA8nE2PZrB4J1gV5v16PeQ7X2AiwjJ3gO1Q8hW7tyTtPQ@mail.gmail.com>
 <2e3f7c8c-c443-4e71-ad60-36c5203de09b@kernel.org>
In-Reply-To: <2e3f7c8c-c443-4e71-ad60-36c5203de09b@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Thu, 9 Apr 2026 10:17:27 -0600
X-Gm-Features: AQROBzDa3ZlDSyBeTiJ6U3kFPCzeIQ0iT24eqWDzIWH0VQcWacDEzklP5yv7TuM
Message-ID: <CAA1CXcCNLkdjMt=WXgJ1QYSn9WTgN8FVZDQk8E9P=S54sFDSDA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v15 03/13] mm/khugepaged: generalize
 __collapse_huge_page_* for mTHP support
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com, 
	jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, 
	lance.yang@linux.dev, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
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
X-Mimecast-MFC-PROC-ID: p27kZo5N4MYCaouVEgsRXpk4NZthsljsX7mrAfS2WfU_1775751463
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 2:14=E2=80=AFAM David Hildenbrand (Arm) <david@kerne=
l.org> wrote:
>
> On 4/8/26 21:48, Nico Pache wrote:
> > On Thu, Mar 12, 2026 at 2:56=E2=80=AFPM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >>
> >> On 3/12/26 21:36, David Hildenbrand (Arm) wrote:
> >>>
> >>> Okay, now I am confused. Why are you not taking care of
> >>> collapse_scan_pmd() in the same context?
> >>>
> >>> Because if you make sure that we properly check against a max_ptes_sw=
ap
> >>> similar as in the style above, we'd rule out swapin right from the st=
art?
> >>>
> >>> Also, I would expect that all other parameters in there are similarly
> >>> handled?
> >>>
> >>
> >> Okay, I think you should add the following:
> >
> > Hey! Thanks for all your reviews here.
> >
> > For multiple reasons, here is the solution I developed:
> >
> > Add a patch before the generalize __collapse.. patch that reworks the
> > max_ptes* handling and introduces the helpers (no functional changes).
>
> I assume that's roughly the patch I shared below? If so, sounds good to m=
e.

Ok cool! Yeah very similar. I was just making sure you weren't dead
set on it being squashed into the other patch.

>
> --
> Cheers,
>
> David
>

