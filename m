Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F4E1BC46
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 21:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770240938; cv=none; b=FAyJ5982cdNFbWFYLy/4VC4W2UaP8gLA3qIZrGKh6dqNtN/L3cSxmW5Ndseu9zo5V44gx+c9biY5geVYqjbSp+M1o9N4ehlR7M4fyihGo7u6kmmAVbBfjFAirEsw4wYXtbjQF1t5e7Nnsy7m9yvURiN6ufgA5SaAPEMyYKEzKaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770240938; c=relaxed/simple;
	bh=yOuGpU8BQBEI3wUqRQh0+3eeVXQ5NT8/K0Y+M0gFwEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8s3ArhQYp1lzfvrXLFYznRfv6WWHkSIH6lPEG0Ywg2lZ4MHpBFJCs2BVCx4r4A7dZzrZlEr5Z53u0+SzdkvwNcDyHC6Ukex45mKAdVGZAwotspduz5+j7Bb/qhNB4M1hKDLTX6dCCQCjMJXZicP63gMyEGiz2yzyklKHjU4mi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RxXT9OnS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxXT9OnS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770240937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlyrMaKGGiD8GgpuGPaSWwtm7U6K5QJqsNa9rsAtym0=;
	b=RxXT9OnS5YLoXS77I4eu7SJYzEVsuQbOXSQ3OCjbgbIQNjBtCbodT0D+7aU8l564Pamc51
	b4ZnkQhj/xPmHWYNWfESpj9ptlFDwuXMrIJIpMwPfNV8J1MLdHXFmG0ipagEDWAIllf1aZ
	RMY9eCk/LRdyEQNcw5Mxce1yhLg/aGw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-BCI6N1tzM02P8uUtnuRKNg-1; Wed, 04 Feb 2026 16:35:36 -0500
X-MC-Unique: BCI6N1tzM02P8uUtnuRKNg-1
X-Mimecast-MFC-AGG-ID: BCI6N1tzM02P8uUtnuRKNg_1770240935
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-79064868702so3329477b3.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Feb 2026 13:35:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770240935; x=1770845735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nlyrMaKGGiD8GgpuGPaSWwtm7U6K5QJqsNa9rsAtym0=;
        b=mc646flQctvwKAnW0ibQmACVE2dbbFuebvbrlXzw6RQ82ja4J9qV0bw3BIq/1o/q6g
         WPM7pRjJKDo7eUd51bkLQHa42TKPp8fzLDFEhM6TlvFT/u0Z1IhqMoC+Zg418crccqwD
         2MBvQyrKrJtQMJeUiJM+0yG8rQuqsEzXJHExpKUchCUonvSz3opT3ZWiYhZDH5WxLFUk
         SpjcAlSKzb6SrHjG8d7Nx6q+AgH4/bxWebS2TfUOrZgsoUq8Vz69psVcTdr1kYqqv30g
         Z5oqu8rWCjaRftu++SY/Zu5jqK69DJBO0HZdDhN6+dcFMg26SD/HvdO1nLwhPtBpwjNZ
         hI2g==
X-Forwarded-Encrypted: i=1; AJvYcCU6tKSLbJr41O5dfpjGbEcaAJhN/lJ/XZIrEN8/UVcsxUAmT2BPOMKJtQ3aaUOHMI6oyH68u63FWG7GumeFRM4UWZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLbGG3NVF4A7G98KPZe7GwtOuQTiLtJgIHCteOm84Er2hh0BhG
	+EoS2EvoM7/Nho76xQaLETKbJG+7nFiocDYF9IERLqel8UNBMke1huv9XNrNT5ta2USqt5kZvi+
	p+/Nzfrs/Ym9V7RZT/pMlDlBq/mGd8XiBbPCpbsKDWE3oAKjR1PBek+MtT6ykRxbgOwr7Aprhzv
	rc9Et9SB+DSaUd4TeSa7KhEWyenyF/f4ARuBGtZ4RpKPQJioUb
X-Gm-Gg: AZuq6aKL12UHYJvuxGzKspSO+5uLIwU2A53QE2KhaEn+1WgbkvFMTv64aKCpPdhIeVK
	8BsIty30YD0sQQL9iL0vrUMgbRQewrM3Zv0/14Gic0R35KmyAM0y0PlyvaO1Bwyo5A32yE9N1ty
	R6jlg0E+mQx6HSKE0/DCv1L7hSKqx2EDXFQQWdQkdQ8sbmN+9BH2Gm8RrCCo6kE5TV
X-Received: by 2002:a05:690c:c50d:b0:794:752d:cc73 with SMTP id 00721157ae682-794fe823278mr37751967b3.61.1770240935396;
        Wed, 04 Feb 2026 13:35:35 -0800 (PST)
X-Received: by 2002:a05:690c:c50d:b0:794:752d:cc73 with SMTP id
 00721157ae682-794fe823278mr37751487b3.61.1770240934851; Wed, 04 Feb 2026
 13:35:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122192841.128719-1-npache@redhat.com> <8067c5c9-491e-453a-be1b-33603744758e@lucifer.local>
In-Reply-To: <8067c5c9-491e-453a-be1b-33603744758e@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Wed, 4 Feb 2026 14:35:08 -0700
X-Gm-Features: AZwV_Qhj9f0Nsb6Ktl9VTFxoa5W8_cz6au4xpYaFZG8J9_wccM3oiCb7CJWR8Xc
Message-ID: <CAA1CXcA8digLf78mc2UFCGnGMu=xRBGGXsY6Xb4uwwkfr2kB3Q@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v14 00/16] khugepaged: mTHP support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, corbet@lwn.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, jannh@google.com, pfalcato@suse.de, jackmanb@google.com, 
	hannes@cmpxchg.org, willy@infradead.org, peterx@redhat.com, 
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com, 
	vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com, 
	yang@os.amperecomputing.com, kas@kernel.org, aarcange@redhat.com, 
	raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com, 
	tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, 
	cl@gentwo.org, jglisse@google.com, zokeefe@google.com, rientjes@google.com, 
	rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ajnj9xj1_x0CX4b3Vm8mmCI4RuHxjPk8nSe1Nc4Dp3s_1770240935
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 4:34=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Jan 22, 2026 at 12:28:25PM -0700, Nico Pache wrote:
> > V14 Changes:
> > - Added review tags
> > - refactored is_mthp_order() to is_pmd_order(), utilized it in more pla=
ces, and
> >   moved it to the first commit of the series
> > - squashed fixup sent with v13
> > - rebased and handled conflicts with new madvise_collapse writeback ret=
ry logic [3]
> > - handled conflict with khugepaged cleanup series [4]
>
> Hmm no mention of change to 3/16, unless it's folded into one of the abov=
e?

It's the line with [3], but yeah my bad, i'll try to be more detailed
with these change logs in the future. Was particularly lazy on this
one.

Thanks for the reviews :)

-- Nico

>
> Very important to make reviewers aware of this stuff.
>
> It's also worth separating out things at a fine-grained level, really
> everything. More detail is good. See [0] for example - I practice what I =
preach
> :)
>
> Thanks, Lorenzo
>
> [0]:https://lore.kernel.org/linux-mm/cover.1769198904.git.lorenzo.stoakes=
@oracle.com/
>

