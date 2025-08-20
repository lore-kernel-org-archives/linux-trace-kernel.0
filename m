Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEBE322764
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705389; cv=none; b=OIrZuIjR6UEEse19nNB8l72vHVmQeAwEj3gqCKm6L38H6dQhn6jRzp8CvRhrAerj//Ufw3RcURThAdMKBqw6T61hdTQgNHqI9QkK9ii89YppClR1SAC1YJWCv5ZV7bMCOXa9q48i/TBR6QoqFPMWFr4KLB29Vt9sO0GbENsMwVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705389; c=relaxed/simple;
	bh=R+Ptmzm6SrCTWJS8/j0R6UkbUGMTtTE9b9TRKD7b9iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ViSZOgXI013mIxxJI01zFjymHvCZym/EHJD5C+Q219mF2fA5+UqxEgNg8xNfP7CanR+KgwvPyoTczxugGdm0vWfEyIWOpI+0zHLdJl+gbyRCpt3u14yUKdNPC4rcR/3C5RBrshTB4BfAoVThPyDGuIAPETeJ/ut+UnGizSdCH8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hlkejOyD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlkejOyD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755705386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Er23qODQtG4idaztLuSjwC5wmfZWAF3dygpF7gAo74Q=;
	b=hlkejOyDGlilp3X7Xi4KhtK/wmTOAegOxNdGk8wHmhw9WSEkhs5IPnEEbSVa0kVVA7wsTx
	olcZCcdNVxBQPN9Bs4zb3bmMLo3iuGR5eeRbnVltNGTGRx+CYOy7kItTJMPNkouk3dDSyk
	VjJhVsx6qhM29AgOBvu+/oXweNXD6+E=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-kJlvCoJGNoaVQeFyzbxGMw-1; Wed, 20 Aug 2025 11:56:24 -0400
X-MC-Unique: kJlvCoJGNoaVQeFyzbxGMw-1
X-Mimecast-MFC-AGG-ID: kJlvCoJGNoaVQeFyzbxGMw_1755705383
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-71d4cc7fa4fso18542207b3.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755705383; x=1756310183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Er23qODQtG4idaztLuSjwC5wmfZWAF3dygpF7gAo74Q=;
        b=F7fO+enp1Wi9/Vz1eAObxGE5Sl85XV5jkYcbSKxs3dx18MAxd4lLN7dMh6Hcbfc5+V
         H9mkO2JPopUT5FsOJ9VkeeIX1cLbvk5ai5bfil2SNB+kABFeqqlb45GpbwfSp/4/YfCX
         VdyfLLAm6/Y+/paUUEBj1fX1zO5AMv3zLeq7/wEhP2IgZZvlpP5w7lMV6NPOC85PL0cs
         BpL/SPg3vBNBibpYVBMxZ9Wfvk4q/9QCmD8Wq5nXfOaAFjhN5zdN0tbMIGXDOO2DiKR8
         XLqF3DM2BDjlIlw57E1mAEdsTMcYEK8JNblnE5ShPmtLjsApmE4qLXh4TwFXortUnj0n
         ZAsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGc2wqkdqJ7zzlB57cydopXHx84x9hOxz2mNc6xs8a3V03hy+ZeEIltkdsGT+mqfsF3+g3fx6BHZRLa79Kh+Fq3p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUUkjSDDsp/yB1s9nUn0krgjEjEtx/H1ey26ZXi3lecIeYQ+K6
	ieTCSIxzIuV1qHVZtyeSWRVpAOsqUM7+Bc7EaKPO/VXrskZn9ntafqFh2/0oaAbu8mzrgIRilaE
	GGeOBR1mgUBwcIFjsJseL9bWJybz674qfR+C+tFtD5xHLDkYfkdhJ/uv8bC6+AtRnQnznKVo6TY
	knQ3zBEz9AdcxxdTvMFulyL+MdJpVLYhL+axu06GLLb/fcspga
X-Gm-Gg: ASbGncvSQEsBcOqpBNQDEsLvvdkJmwh32ohA/BzXmW/NfQAViO9C6Iw1MgbLyc3RoZQ
	lavotAD12tYbCI3d4TlRSLvnDzhSzu39N0OCqCpY+pYDX2I3z9SMZwk3AgYe1RUN2rBH/WBxxAT
	U6DnxuuH9uib5EpmC066bx0Sw=
X-Received: by 2002:a05:6902:2b85:b0:e94:fc8c:e1f6 with SMTP id 3f1490d57ef6-e950485820fmr102026276.5.1755705382731;
        Wed, 20 Aug 2025 08:56:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS+QnZtdkkS1vjc4OhO99gWxx/B53oOwhGsZXtA1ANwD9WwiLwFVxw4OYIIrLt4QKiuxs/inUSPFs93SI8/Kk=
X-Received: by 2002:a05:6902:2b85:b0:e94:fc8c:e1f6 with SMTP id
 3f1490d57ef6-e950485820fmr101964276.5.1755705382248; Wed, 20 Aug 2025
 08:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819134205.622806-1-npache@redhat.com> <20250819145530.243e02184b743eb9ec506856@linux-foundation.org>
In-Reply-To: <20250819145530.243e02184b743eb9ec506856@linux-foundation.org>
From: Nico Pache <npache@redhat.com>
Date: Wed, 20 Aug 2025 09:55:56 -0600
X-Gm-Features: Ac12FXzgXuKDwPVbATQMmVh6NLWeMMDQC0r_rrDLYa5BGBJGyBVrKKAptFCfllU
Message-ID: <CAA1CXcDpRywoWKXyoJPBgs0TCbENooQsj+hDzYVhP4eYsiiFJw@mail.gmail.com>
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, baohua@kernel.org, willy@infradead.org, 
	peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com, 
	sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _VdEoeAJrEUmoa4C6ZmRzovvneEH2DSjmpJae26HwNQ_1755705383
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 3:55=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 19 Aug 2025 07:41:52 -0600 Nico Pache <npache@redhat.com> wrote:
>
> > The following series provides khugepaged with the capability to collaps=
e
> > anonymous memory regions to mTHPs.
> >
> > ...
> >
> > - I created a test script that I used to push khugepaged to its limits
> >    while monitoring a number of stats and tracepoints. The code is
> >    available here[1] (Run in legacy mode for these changes and set mthp
> >    sizes to inherit)
>
> Could this be turned into something in tools/testing/selftests/mm/?
Yep! I was actually working on some selftests for this before I hit a
weird bug during some of my testing, which took precedence over that.

I was planning on sending a separate series for the testing. One of
the pain points was that selftests helpers were set up for PMDs, but I
think Baolin just cleaned that up in his khugepaged mTHP shmem series
(still need to review). So it should be a lot easier to implement now.
>
> > V10 Changes:
>
> I'll add this to mm-new, thanks.  I'll suppress the usual emails.
Thank you :)
-- Nico
>

