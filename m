Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFD13BCD36
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 20:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785444569; cv=none; b=bSbuPB0Uf7jvJf641kIBNt9tYe82wTNrwE3CE0m+uok8NpYHVt05oEPnkiZJBvqX5kiA61VLoc4Y/uiqIyTO2RjFgkQW0+svazL1qDVLBFpCIp2MhZ9rABTBA4Get/HY2jp/rPC6QHbtk5PMjkA0sTKS0thSUdoOv08MKNVBQfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785444569; c=relaxed/simple;
	bh=AHj5iKPxjLBOIXTL2+StTfzdgS6fKwysuaXV1Ino2qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRhsiQMVPUplmH00runkWM1U1xHcMrVgU/e8f/n0RNl/yFlGVUWoj6uCkPO6guRi/5A610lAwxyDndvDrtdfoDCTOXCFSGjb/ypUloma/kR/VbFgkXf5XeeqW69ZRG8knDVP1NtN38OikdmquO4gyoXERv46Ilz3O/iff6ipzSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HRGK3Dhp; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HRGK3Dhp"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-934944f2d22so86485a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 13:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785444567; x=1786049367; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=azR+hkvo8cQmu5EseR5wH9M0hM5NW4S4o7e4N9bgAu0=;
        b=HRGK3Dhpp9s7eljVPHut9/mFKj4q3/pakwVOHfvmS+dLydi7z2SjGBBHZ3bZkoWlxf
         3nD4kyYDUfQq4DKExbVG4jOd8WLyIR2gV2KRx+wnRoxk/r0fUURyBTUDgcGMxrs4Whqu
         TiogT5YPHsRSlkBVc9Wo3+7UNSSdXE3C8Mzyy90uzUFlDD1H3/GdlXejcnXh4FNRXmSa
         mwd4k30/HVj2ogScZkT2MFjomWyYe7FruVCbPB4n2M70AvgkZZ9x4m39FZr3drdMedPm
         +OqFvnwN7xHkTDLV8lPnb/pHGpZ6W6AyBnXJ5z51FeWKQLcdhtzeod0UB1QbW0Tx9JBv
         wfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785444567; x=1786049367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=azR+hkvo8cQmu5EseR5wH9M0hM5NW4S4o7e4N9bgAu0=;
        b=i3akkFUBNbEnpggCsEy2X4ci5T/8/320SzO7871XIVRvkhxcectdBhfncahM3hvmOj
         uZIrtigkZcsPrqZp9GZyhTNa1Z5FZmkA4zjRNFz48iZ/f4oEDYYs53fMDm7mq2rh5cm+
         +vwR7uEoz1WTzrLfmgcQIrleAUuafKuS8lC7Y0t34e4HuAgDbaHwfuqt3kKyVCol/K0U
         VWVMmANhCe7sRviQt5/fM25jWdSzfztb/AW30ydS7VlWHtyBrOdYWcDabHwf+nBUJcB6
         W0ZE8e5L5poJtWd5O8fgid6amyz5CqPA3R+9ahd2vl06V+jvhYja/tndQ5xl/Njx4lUT
         WIxg==
X-Forwarded-Encrypted: i=1; AHgh+RoF0HlNNAAoAaimQlLg2+3xWPXdkCJwLEtuABsXQhMMdNVdB+uvkiCNLtevfLwOE5Mmu6k7z+ccokFlWpcO7Wusrh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY0gi8olfUHPC/frdcG+tqxGKaW2yHUJCMRGF7RWket2ZsYCCK
	8kOXXEcmMQgNVqckR+QnKc4sG7YYVAhROKgNHEKvodqzgHppRRoL/zl+t7L9JqzyZw4=
X-Gm-Gg: AR+sD10/t8XkwR+YD0gJQ0kYZDzEyGWaCO6f//nyue1x4llTlSoQGq4K/DacotKdzNU
	SRMgsnTbgw+b1C3EslITmj8+nI6LQrzYTANsZqp2X/m75vwG5u6pNUMdKULdBby9Dko8Ep9Nx5M
	lLUPDKZmMg9XhF9tJDjubEZWpUMdY7zAvrn4+JBIYqtvFKOJkCN2vPRXHcEvKnt11vPNzTP247N
	JcsvxRuL/qg9osNU+5lWDt5DpJUne0A0f/oY/7TcerUox1kEDf+HvzncSO80xJpDfshoEXoPr5o
	IsQZInPE6NW1WFm9fcjhP/9MGinWdHhtnj9PmJXJIOXozzA1uv/gBV2zqbWMXVNps8XRbvYqVfI
	+Suzg7P2a5XjM3V5caE4ihFRDP6tG0jh6yk+ZvZ0d5ou2byLk07RNC1OyKDtOGQQEloNa+Kz+fQ
	dDcsdmKkqCfYGFRBTDDAj2aXysncAe9NaBapnduRhslmJfh2XLBsB+IiH4B27nZBVf6/eBQb1/f
	H28JWDCajm/iJGGtIs60NqfdG5T4zJf9xcmj+AiPMTW
X-Received: by 2002:a05:620a:6088:b0:92e:c118:18e2 with SMTP id af79cd13be357-9348dc4ea66mr225698085a.89.1785444567383;
        Thu, 30 Jul 2026 13:49:27 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d325ade8sm489716185a.12.2026.07.30.13.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 13:49:26 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:49:24 -0400
From: Gregory Price <gourry@gourry.net>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Frank van der Linden <fvdl@google.com>, 
	Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Brendan Jackman <jackmanb@google.com>, 
	David Rientjes <rientjes@google.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Fan Ni <nifan.cxl@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	Raghavendra K T <rkodsara@amd.com>, "Rao, Bharata Bhasker" <bharata@amd.com>, 
	SeongJae Park <sj@kernel.org>, Wei Xu <weixugc@google.com>, 
	Xuezheng Chu <xuezhengchu@huawei.com>, Yiannis Nikolakopoulos <yiannis@zptcorp.com>, 
	dimitrios@palyvos.net, Ryan Roberts <ryan.roberts@arm.com>, 
	Huan Nguyen <nhuhuan@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Alirad Malek <alirad.malek@zptcorp.com>
Subject: Re: [PATCH RFC v2 0/3] Demote to lower tier using non-temporal stores
Message-ID: <amu4cfko8YY9awfF@gourry-fedora-PF4VCD3F>
References: <20260730-rfc-nt-demote-v2-0-452dbe3b5073@zptcorp.com>
 <amuJbBrTW9W6_sx8@gourry-fedora-PF4VCD3F>
 <CAPTztWatWbsF4KQwD-_nib-vrZ6uvrhMYcOc1mkWu-7DzN95AQ@mail.gmail.com>
 <amuTOC7qxWHVyZcO@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amuTOC7qxWHVyZcO@cmpxchg.org>

On Thu, Jul 30, 2026 at 02:08:56PM -0400, Johannes Weiner wrote:
> On Thu, Jul 30, 2026 at 10:40:32AM -0700, Frank van der Linden wrote:
> > On Thu, Jul 30, 2026 at 10:30 AM Gregory Price <gourry@gourry.net> wrote:
> 
> > arm64 already seems to use stores with NT hints by default.
> > 
> > In general, though, I agree that for ASYNC requests, just always using
> > NT seems fine.
> > 
> > Maybe the mode and reason should be folded in to one variable, so
> > that, further down the stack, a decision can be made as to what type
> > of copy to use? E.g. if the mode is !MIGRATE_ASYNC and the reason is
> > MR_DEMOTION, then non-temporal is still a good choice. If the mode is
> > MIGRATE_ASYNC, NT is still a good idea. If you wanted to get fancy,
> > any mode with folio_test_waiters(folio) == true should not use NT,
> > since a task is waiting to use the data, so caching it is better.
> > Maybe that's overthinking it.
> 
> Agree. `reason' seems like a much stronger signal.

I think this ends up cleaner as well, it would be a nice improvement.

~Gregory
