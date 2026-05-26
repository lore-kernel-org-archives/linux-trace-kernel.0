Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD583E0C40
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796818; cv=none; b=D4DmCEG7qx22Hrka3A1SUC5gwucfcsFaICcy2LWa6OWKKEAhRQOQU3MwakLTn5qV5QJkm0Q4uMAM6SqjjTsYwtUZxvOJt75V8CwR5OnIn4c347IC9ucJOgSCnpyRc+XDJacu2su4ttuXiZSD0FDGj1hpF8/sRxieeijftSfHjJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796818; c=relaxed/simple;
	bh=++rX8GA/6dLiVp5wot1X1q4t4NIATV95cr8PVbXQrxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKnfVLyNNtpN3UM9TlCjO+tcxpGyB+Imwp6uS0SjrGqofSH1HQAIkzRjtEt4lnknvPD9bpWH6uwfhJgbwXG1TIIYFTw+Fds+dC/j12QdQ/YN6srts0IBt7bTQ2S4qJxR4KdTXWGzHWXI1aHeAsrttPH/sv5ngyN32BmhjMt6THo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8Nwl6fq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8Nwl6fq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779796811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPVI6FG+9wTp5VL8rvlsGJ2RfHITdLh7b6n9qoUv9X8=;
	b=E8Nwl6fq7TnqAiKFZAL5OONJdleqRjUsURVcDVdHfm+eCsSCZBHakYXVImiGp3rd8VM2xW
	4qyqQcMo2FNHewSvLnU8w6Oi7Eo6hmA4D3CRxmao5lgE9KdcWVFtftqUQ9TWD/qEb8YgtV
	OIon1qQDSDY2P/mDttnvc/y/ew5m9s0=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-RdSxYRDuNOmsjL5o72IeqA-1; Tue, 26 May 2026 08:00:08 -0400
X-MC-Unique: RdSxYRDuNOmsjL5o72IeqA-1
X-Mimecast-MFC-AGG-ID: RdSxYRDuNOmsjL5o72IeqA_1779796808
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-65db7715a7fso16698703d50.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 05:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779796808; x=1780401608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dPVI6FG+9wTp5VL8rvlsGJ2RfHITdLh7b6n9qoUv9X8=;
        b=om99Av/YYvlJrHBtOTi/tjNNBSOKyhSAWOIwlS+uVZE2K4C/M5O33haHHMl872ppEe
         c7B4CEYhFK03D59dTrYBfdJldQlfoVsCQNl2fsvkNxQy9kque1TY1elgON9rs+2GKZDN
         l3RAZyC+onLt5ytWlfag5YeIHuNcEYZoiUDsew8inIbkOSZH25jYWxMRInS2zG4x0/Gl
         rlgwHX9ZXXdWvNPuaB1EmRbU87K3AZ1Vyqhx/IGeF35mAjZ04rW3xhwQaj6YpJntJmab
         zD0gLWm147/mL2to3j+XwRz2ATeuBx8ekqzM37X3T3d6MVIINLJ9FWxkbUco8sB/YZ3r
         ITOA==
X-Forwarded-Encrypted: i=1; AFNElJ/gyP7uY5Y+KbMn4ZAuyVubr78k0PUGVnShOZmGhDc3SJ0qsZnNfGoKhxkGkfWrxv58rW9e0VTZjBVbJHDaql8VdI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO2vCDBXKH1zp0qAeFgZjUYmG4wJ2OmEcUXrrnJafC0/8Qi3Kx
	AZqqwGvaVnRBmClwx/4I2KBshySGiAEjYyFMVBOSqAN7cfWLPP/cU6COX+cTiVOi9WgFoC6F/rr
	VB13BQ9amDITXK7cz/0Do95/PIfEfgSkYiyNE1VYkwAs9xEUIFoJCmaikFWYXMnRnYKPhMoJgwn
	Ek6ZD/uaRjxn/o/Of+i8A+7WI4W+pZ5uhjaBl7lc6dZpiZXOai0dsFacxnUTw=
X-Gm-Gg: Acq92OF6R2ed3e6QnVINFLaW4l6H+wxeA1ucG2IZjX/YqPnlHSyJs2XqQ64/6q3k9bR
	V35BmsDlY6IHzhydZC9idzR5RYSUSGfubhrfrce9CvDpEP90M7B158EkUHcZp/O8/NRkGPdVjHH
	9octG+tPrsnlF2nuDjWUAFpAnh5gkNr9WjL1d1vGqrtlLaVWqpD8vt5w5/0o7j3z8MNwimx/pSC
	zfrsw==
X-Received: by 2002:a05:690e:4186:b0:65c:febd:c0b7 with SMTP id 956f58d0204a3-65ec9772e80mr14934518d50.20.1779796807857;
        Tue, 26 May 2026 05:00:07 -0700 (PDT)
X-Received: by 2002:a05:690e:4186:b0:65c:febd:c0b7 with SMTP id
 956f58d0204a3-65ec9772e80mr14934471d50.20.1779796807277; Tue, 26 May 2026
 05:00:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522150009.121603-1-npache@redhat.com> <20260522150009.121603-15-npache@redhat.com>
 <94f759f8-e2ed-4f22-b9e7-4693ad005509@kernel.org>
In-Reply-To: <94f759f8-e2ed-4f22-b9e7-4693ad005509@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Tue, 26 May 2026 06:00:39 -0600
X-Gm-Features: AVHnY4I2kJlfEdj79rgn-OjWXsjv0gbtFCil3AHTWp4P9-K4HDgNbrjoGJeC5zg
Message-ID: <CAA1CXcD0w3CJKzwTvv6gaA80XBYwTTbZGnNGJjbirYMZnBmyHg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v18 14/14] Documentation: mm: update the admin
 guide for mTHP collapse
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
	usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com, Bagas Sanjaya <bagasdotme@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LsdbZ-chHMGHhAHuEh2IDFMszM-R1JQlbNpt8vGzWRg_1779796808
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 3:59=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
>
> >
> >  process THP controls
> > @@ -264,11 +265,6 @@ support the following arguments::
> >  Khugepaged controls
> >  -------------------
> >
> > -.. note::
> > -   khugepaged currently only searches for opportunities to collapse to
> > -   PMD-sized THP and no attempt is made to collapse to other THP
> > -   sizes.
>
> Should we maybe leave this here and clarify that for file/shmem, it will =
still
> only collapse to PMD-sized THPs?

Ah yes that would be a good idea. Ill send a fixup!

Thank you :)

>
> --
> Cheers,
>
> David
>

