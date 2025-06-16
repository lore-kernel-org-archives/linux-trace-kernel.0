Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D01E219E93
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Jun 2025 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750089141; cv=none; b=an2bs3ulSlA0ynoBrAxit1i4IgHDlFRvCb0+Qr4H6GUAtHWC1uTcgTRIqRmMxDlETYCViSD5w020Ibnr2CXIjCIwds0gXM/7jMVXvEsdPDjF3mdEzeZlouNneixBgtnj64kYUcfC1NIZINfgenyo50NEE8oicgoUpu23LEirZwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750089141; c=relaxed/simple;
	bh=cgvgta8aciMoxErXIYuF2aSDop9idzFQFduLa/KczfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edzhVZC+2MbLCia66co+h4U9DZjP0eyi87smiJkyoYwJwcKFuYC2iAAX1QWcoScBzUIgWtfTchaG3izzM445AcJms5j/28kOHl9EwZfBOHpF3xC3DSty8o0djhhVokQNai9o1d6PUg+kP84au1wwZMzEWF+w3/smnrs3lqJ4yQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NRIufuTs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRIufuTs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750089139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cgvgta8aciMoxErXIYuF2aSDop9idzFQFduLa/KczfY=;
	b=NRIufuTsHbEDoKCYRp3Ad1bRPaXOtNhIMsAgjZLq9URhStt6gZiMU9eE2vg7rVT5dZiMjD
	ALycUeISdIe9AEwOgteCVygUZeLj7jrxo4cRV3bcbGec3fYGkoVLBsiP8Y8tFGqxfgwtcz
	CTBLPDYyZIPsb5ZFs/ZhY/R6dUKulfg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-27TBJ0aYPuq2PnUDTGXS7A-1; Mon, 16 Jun 2025 11:52:16 -0400
X-MC-Unique: 27TBJ0aYPuq2PnUDTGXS7A-1
X-Mimecast-MFC-AGG-ID: 27TBJ0aYPuq2PnUDTGXS7A_1750089135
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-70e4269de4fso61846867b3.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Jun 2025 08:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750089135; x=1750693935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgvgta8aciMoxErXIYuF2aSDop9idzFQFduLa/KczfY=;
        b=VxdP7Hnj4Y/dE2epr1QfDD+HGXxbYYAI4hZKmkNOVqAMNeqiAYMx/ku5GAwKBy+X9t
         5wetiReFmzlgyZCqJYoOLxYGkMYOKdnl3oEtmSmZNWv27ayA2C9IJOpNTHJLKkHVi4mp
         9BigRG4FlsHr6l04ruNotuSUTXu/9MWpunEaWOXHu27P8KPXGNHs2DM3HKN1DD5zZxMY
         AGMYE6qyn8FZrzoAXSq6X/eA4sMjzmiHZ9rg2sEIx8YTfXsUtowwDih8NiEcd5Hfa6N9
         yF/NmDDxlvydFoLkk5ozjEfeL21UtrJMLPFgZ0EnaIoh6ihJDog2dXe2MgIILIHdEGXR
         lQYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxVukGTDe0ZqW4GhjbKzxhlqY9mKViQdW5Nj4ze2stzz5aCU6Bsl9Gt8KY9VoPERK1tfR6Rce0GcIPIx0S9gIWo/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMlNvO4CoR3wVLVVMJA7wzbGsV7k/y7PGmcNxHlTbMa42BX0GO
	L3cCSjkpgtYs7XQr4hnNzmpZ0mJt/tzmXrfwaemHx3qgvZVWR8nkareA+1Y9lm8CQvjD7cwuVhq
	nIV3QXPyvM69Kssx55/lSFzk/wgsTXFvz15Rtmtp3XPWlMkIm1OJC91mKEkUooHcDeqD4A9Ev+7
	/EeOhNQJNcqoLuTmMvI3hLpfgxhRI2feKWPe7rZXDl7IsCyHtw
X-Gm-Gg: ASbGncsZ/thYjebGnOwB4ilXD0JbBij/WFRXeHGyOGB4ygRlNXDWcdjDZRMVlRgVfCb
	6tI2JMaVj1Erxf+eXcoyWVzy76LUd0YxPmZmcMgglMqYVsf6ZNdw84sMXmzfAYLH8CqfX6vcamZ
	3QimmUig==
X-Received: by 2002:a05:690c:385:b0:70d:f237:6a60 with SMTP id 00721157ae682-7117543cf7cmr125891007b3.7.1750089135481;
        Mon, 16 Jun 2025 08:52:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZXG6wclfxD90BTesxhzMtrDTqbltqXOg871c5dsmQbh0pbJek5ygMMH70krpIlhvDmoHznJlg+ptMx6vksPc=
X-Received: by 2002:a05:690c:385:b0:70d:f237:6a60 with SMTP id
 00721157ae682-7117543cf7cmr125890177b3.7.1750089134944; Mon, 16 Jun 2025
 08:52:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515032226.128900-1-npache@redhat.com> <8621cd4f-a206-4440-9b02-52e9277ce212@arm.com>
In-Reply-To: <8621cd4f-a206-4440-9b02-52e9277ce212@arm.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 16 Jun 2025 09:51:48 -0600
X-Gm-Features: AX0GCFv_bntaKb1uWoTVlmOvBCUrEspFcRe-M6VQE_1ShbpjFnXLzcNhSs4x95w
Message-ID: <CAA1CXcD=MOEfa6XBp3+e3dSMCmgfx0NgB0DgnxRWTAS-KKZx-g@mail.gmail.com>
Subject: Re: [PATCH v7 00/12] khugepaged: mTHP support
To: Dev Jain <dev.jain@arm.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ONuGExD4r9KlHPdVkHzMYdtfmMe3Pa3Tc3QPA2QCbpE_1750089135
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 9:52=E2=80=AFPM Dev Jain <dev.jain@arm.com> wrote:
>
>
> On 15/05/25 8:52 am, Nico Pache wrote:
> > The following series provides khugepaged and madvise collapse with the
> > capability to collapse anonymous memory regions to mTHPs.
>
> Hi Nico,
Hey Dev!

>
> Can you tell the expected date of posting v8 of this patchset?
Hopefully by next week, although it may be longer (as a try to catch
up on everything after PTO). We were originally targeting 6.16, but we
missed that window-- so I need to repost for 6.17, which we have
plenty of time for. Ive also been releasing them slower as previously
I was not giving reviewers enough time to actually review between my
different versions (and this creates a lot of noise in people's
inboxes).

I'm also going through some of the testing again, this time with
redis-memtier (as David suggested).

Cheers,
-- Nico
>
> >
>

