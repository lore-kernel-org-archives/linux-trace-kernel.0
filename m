Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A921176FB1
	for <linux-trace-kernel@vger.kernel.org>; Sun,  3 May 2026 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777811013; cv=none; b=toznRUdhbHyto8BBHLYBanxzoZVZ7KRCsAbSGNIv5oN0oOJhEAsxEjpkFgSdGY9lkPUVuVl2tJisrqyZ3HtlcpPCHIhvH3QzDIaVfNvxsd+iDrVqaZPi0Op0zqMx45ice/2wK1lpE9pwXxFno5x1xem6Ib4pbkkzeEqYf1y3IlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777811013; c=relaxed/simple;
	bh=JNyT4oyq9E6Y8A2QB1qYoRnA7vKpjkquviD/jEdVtHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/2i5qCFys0eTmm1/4s82023oAc2DxiQvIIYRqr4SggrmhJuQOmgt2h/wbcXCZaqfQ6e9cxw+HmCCjkICY59vCZNQRPdcqGJz62GzPrIvHkEND3Ut5fNSuAwlZg91dQwvFDLIq2lloFjMfe12IUoWTY/7PYYGydVOSVgEsmDRb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YpPpnnm6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpPpnnm6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777811004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/dXnEXBOslXDQfMUjznIyWpVKfBg+VR46+JkfIfv78=;
	b=YpPpnnm62glkZRKQE4sNQFUJsRDszqStBvfMWF5UJRB0oRo8J18h3pYWlAiJmBe1j8g00j
	brdDKKA7c8J4wYYZgoZYXIIu7+s9fqd5B6gyVz8pQFI2PtEOAsBR0J+bqllQCmFOqgfmZb
	i5T0vVUtwphzWDc8gjqRB8z9xJWNMgc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-L_LNP3A-OsWtqt---BLBRQ-1; Sun, 03 May 2026 08:23:23 -0400
X-MC-Unique: L_LNP3A-OsWtqt---BLBRQ-1
X-Mimecast-MFC-AGG-ID: L_LNP3A-OsWtqt---BLBRQ_1777811002
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7bd5c421975so45321927b3.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 03 May 2026 05:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777811002; x=1778415802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/dXnEXBOslXDQfMUjznIyWpVKfBg+VR46+JkfIfv78=;
        b=os0siOh3furbEfn4YhmNK54+Acp83bjDldzO+oJGz9DKsh2Av6BYFh0L1zJyWNl7fT
         3FZ8p8N4ciz18481UgWlcReNYfk2hoQpVzSM/yhI22z+Pr+Q1Fy0/hjKi9Q3cB60MK2J
         bKumA+S2LXHXy592hn64DfT0wD2H1h6PdKtXL/bP3O8bp2kEGRIjw/Wu/eeY3mwQ1vI+
         g8unjLsdt5sYV5NrRx+j8XOjH0Pik44z0+jXTB8jsuwgJucpf1vf2/zEuoZM9+rI1lFX
         1Au6VLZy1iGbbL9Cm31xZqxXi7JZtYU39vISR+gVxlMd4fO7a0c548P9u74VJO4lSoc4
         j7yg==
X-Forwarded-Encrypted: i=1; AFNElJ+dEY95ypSSvLaGGM4qg4aKBd6/PweJqSGj+uUSC7XLhsSv1t3g916aEONMIK8SBmo1/lEy27k6mT+jD7Z9WXOh45Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyirvVR/OCTDsY0FmrGPJf4l8Z3vWt1mswqg8ew5aQ/9V7YUvhz
	iIw7lF1MQlNCQoOfuVdOhQJUSxc2YeJOXmHQQlcjAUQrOQr19O+OFZZOYDV+frJvgTMiWmsj/ZN
	h+/i51iGMHCHrEck1Rqbhv3bOFnrNxB3zI0cyGzrw3zNMkJ/oW77zHq5un7om+c/i+6Li0NdIeX
	+ioawKl8M3gg4TFUmERWcJZIpdXaVVdyPQmkS1CXVqFHBvtsdb
X-Gm-Gg: AeBDietRVluZpdG0x7mvTlvCFaggrb/9bjEcTpGxn0GT8UbY9opEZKf1y3puT3ysc0Z
	hvRAu7hYDxROEqZVavi+I+vM7IMNnUfTHTsYRM5sCfds1bJnQz6XtR5aXqE+bh6x5VJ9f+0ZDOv
	EQbLc1cwt9mQXhwHCsHNlojNxyh/e3Cq6uDrk+WOkVCyP6epaMCb9F+g1SI6w/Rvk5bm+EE6cV3
	YDo8UVmCbwP2QQ=
X-Received: by 2002:a53:d789:0:b0:652:ddea:1679 with SMTP id 956f58d0204a3-65c3da48ba9mr4711771d50.16.1777811002216;
        Sun, 03 May 2026 05:23:22 -0700 (PDT)
X-Received: by 2002:a53:d789:0:b0:652:ddea:1679 with SMTP id
 956f58d0204a3-65c3da48ba9mr4711719d50.16.1777811001752; Sun, 03 May 2026
 05:23:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419185750.260784-1-npache@redhat.com> <20260424065828.031775921990de37f83a2468@linux-foundation.org>
In-Reply-To: <20260424065828.031775921990de37f83a2468@linux-foundation.org>
From: Nico Pache <npache@redhat.com>
Date: Sun, 3 May 2026 06:23:31 -0600
X-Gm-Features: AVHnY4JOUrqYQ7pe89RlEK7DBNztOKRfp0pqQ2vs73ofctGb0t3K8NYvkU4AuHg
Message-ID: <CAA1CXcBJFoqDrkQbRE6JnpV-gjfNXe2sUxaCyXPC82h3qk9Jig@mail.gmail.com>
Subject: Re: [PATCH 7.2 v16 00/13] khugepaged: mTHP support
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com, 
	cl@gentwo.org, corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jack@suse.cz, jackmanb@google.com, jannh@google.com, jglisse@google.com, 
	joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, 
	Liam.Howlett@oracle.com, ljs@kernel.org, mathieu.desnoyers@efficios.com, 
	matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, 
	peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com, 
	rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com, 
	rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _gUkhYI72fCE3skDO54k7PSYZeWbUhPGYf4L-28v-58_1777811002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On 4/24/26 7:58 AM, Andrew Morton wrote:
> On Sun, 19 Apr 2026 12:57:37 -0600 Nico Pache <npache@redhat.com> wrote:
>
>> The following series provides khugepaged with the capability to collapse
>> anonymous memory regions to mTHPs.
>
> Lots of stuff here:
>       https://sashiko.dev/#/patchset/20260419185750.260784-1-npache@redhat.com
>
> It's going to take some time.  Hopefully worthwhile.
>
> As always, it's useful to hear about the usefulness of the AI review.

Ok I went through those! Can you please pull the changes from the
staging branch so I can resend it soon (probably after LSFMM, so no
rush)?

Heres my report:

patch 2 - rather useless as memcg does not have per order/mthp stats

patch 4 - good point, although kinda minor, same as what Usama brought up

patch 5 - either the concern is nonsense or im too dumb to understand
it. Maybe someone else can confirm

Patch 5.2 - Not a real concern (I don't think), given we've already
fully locked down the PTE table, nothing should be able to reach it.
It notes a specific config might be an issue, I will test with that
on.

Patch 9 - was a real concern, and my fault for semi-lazily stripping
out a variable without fully considering the effects. David noted this
too. Good news is that it got the reasoning for why it is bad correct.
Oddly, I did not see a bug during testing which I would expected to
show up in the madvise tests. I just reverted my changes, I will try
to clean this up in a future cleanup series... Although there may be
no good way around this madvise behavior.

Patch 10.1 - Good point, I had considered this during my design, but
then convinced myself I was incorrect. This actually saves us a lot of
heap space :) Gotta retest a lot though. First few tests show no issue

Patch 10.2 - Not a concern and if we made it here, it's already been
checked. Furthermore, the result would be the same. Although not a bad
question from the AI

Patch 10.3 - I dont think this is a valid concern at all

Patch 10.4 - I don't think this is a valid concern at all

Patch 10.5 - The first half is valid (although it's what the next
patch does), so it's not really that valid, it's just missing the
series context. second half hmm

Patch 10.6 - Not a real concern

Patch 11 - Not a bad consideration

Patch 12 - real bug from my last refactor

Patch 12.2 - Decent consideration, but not a real concern, just a design choice.

So yes overall very smart to check sashiko :) But as someone currently
actively working on sashiko I was already a fan.

Cheers,
-- Nico



>

