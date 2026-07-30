Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3678543935B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433248; cv=pass; b=DfrZB2US3jeT0cddtSDGMFLtLDZbUY9hRlLNnzCX/vBX2vtrxuTY0VNmTkHe+9JujsZQulEooR9DfgYhsGdA6qeDoaW4Qow2LgeE5+6QCVVmaaecPI2nxA37k/dTRC09OvEyNCPmpMhQHT5JDmiBmo0UkE8VFEsuYyPtbSpYb8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433248; c=relaxed/simple;
	bh=SaO2GwcUuVir5GmS15OHZBlOQWPsR84MdCDSNA5BGRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eROO6vskgknMB3oTv4c00Brqz8aCcGD3K8Rr7Z0WwAnI/lPqgfkDZeZxjVW1qf+/aZV6dXpjDTAR+KWDwnFqimE/LyX+oDGm7k3S1FWM237Fbxh6sOnZIP1XyP+2hL2IKAb5QgSVqiYTf92sS+sY7j2+QvSMffXib9MD41bUQho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tMIMANqU; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tMIMANqU"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-498012a61f6so5885e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 10:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785433244; cv=none;
        d=google.com; s=arc-20260327;
        b=VeXwBOOgQCdq3qakj7WRmTIMDpg4eh5+QZhG2jjqmPYec4EKnw7i3/LJdFOi7EBfs/
         UqznmYNdBlHH9zAjTu7JclrPWJj/TX5fjkimfcPnGfj5+u2XZzETB9TtBk67rw3Bj3f+
         28XDwolg5N73u7a2NL3tY20IHX5/Jotwih8yY0hns7UFFcKzoRcTpEDNzDjIT5+UoYlW
         Oi6HNPPQWXyr+h2SPFEpiZdbhIPNlQko80D+xozdFT5K+w7m8zUqJbYqLzSDJWWKEr/a
         VFFCl9h8Sr6y4nXexDto1cNUKLf193L1c7BmWdxyH2qh0+K20ZeUY8GsHZBD8i2SqkmF
         4dWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XLMCRr3YVakAFIrgmUPrhARsAro1zufop+cwIiHnKcQ=;
        fh=Y96lUQfqA5jdp1io1B/GwnNsx6C177OvXnZTqSgvPdE=;
        b=BKb8xUVh+NXfYwsJPvD/F/ksWnBoUfIBjRYHkGDVSD8ArwzrOT7H+XnyO+y1ArGjjS
         0vG2+YE8HZtzBexKaRxvLoRcaCeAJ4yptHjvNYzyciphNy3d6Liq5JY5WzAT5WyyZ09X
         ZTZOwZ/wdYsGSbv6FGveYnqN6yKKGCuycwSoxL3zIDYMAzt5nscx5j+rLoRasPzZ8mjE
         SkweSWTZ5tB9YgDdoTVfZ5fHKu3cWWETTfxgiF/gqCTkSaKOaNKbgejHyB2gUmTr9Ooo
         i3qc3AWQdU7ONScrkRPEqWxS2CbfnEev62Rfhmfny7DT11PR9OC93KnGwuYQLkSzkEOp
         ysnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785433244; x=1786038044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XLMCRr3YVakAFIrgmUPrhARsAro1zufop+cwIiHnKcQ=;
        b=tMIMANqUPrzbweELQxKavrKIDKF8wJDFV7pHGR72UWBRXJvF3CLrK7rAluBBTOtZwp
         P0ckv+HRUkSk++aETKZRNsNxD1a1MftdwqcS3wvJ4uVdKmq11DhGN5NRroSSGewtrIQ+
         Rzk/GAIMKwLhB4RgUT4csDvtkgialuntscfblf2RGL593RgsprZFVaNpKDI3lg+aJ+l6
         V1z/o5mywGY3z3+ayEgSFjjHH0K6LGRBV5yTwORVXmL5meXfp460oCXKg3tAFAjWr41L
         NKkq+zBWrAWsfCKUvo8VkEv0g46DI7ffc4sJ/ekvIgpV8XhCtJSI/pKpVpHm3RD++tc/
         DfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433244; x=1786038044;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XLMCRr3YVakAFIrgmUPrhARsAro1zufop+cwIiHnKcQ=;
        b=owRGxnXkBCPuYUnP4WwX90qCO0lRACr0rjGbEjm6wGBq8OVAiC7eqSnaWJmbjuH4Kk
         8c4EVp3VIht49iKYd/1JtUaQxVjFXBN3FIQJ/9dM7qO3HSpqPd3Ywg1nRpoyLyOKAnlX
         iPRXQ0FZy8tG3Xsdb/rftfmNhOgrxtpOIIeDz8M92w6QwIFwyLXZnGFxpebTNOj27v8t
         yTZ2yziHWUy9Ew7a7w8iJLGm5iwXeHKjSnBJDeANXUkZwh5/FzQ6o5RPQLbIz7z+ydE3
         DfntBqAOQC/beRalAchZ+Ug+Q0HkMkk88/xJvLFPfN4CxRVhaYaDZnEK1LVe6kIPrNYp
         iniA==
X-Forwarded-Encrypted: i=1; AHgh+RorvpHT10M26+V9UL/JZdE5sGMs1wNrw7qjow2yPy/idQTlqusHK47QQ7oGOZp+yPXpZbR+4b148L5w33+05puyL7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YynUr687mNX4HwxcLRotofQjIi/mBxPbAk+ne6Ekdb6SBuciXHB
	5lzYnccIwHuL0vYZRboEHr2KM6zreKF17KbH4RYZVz1dsKVr1UqSdrzrdJOlS9KyhfjqcMrdkWA
	imaNIOfJwlp3CHu8+fCL+kr2DxFIX99pS9NfKIZQt
X-Gm-Gg: AR+sD10eJWZhxHKy+Ff7/bfIpgoOESv8onX52evCt/aD5kszQf6WOMySpsuSRJ1mA/q
	l7KHjfWtIhakHSsIROU/eKIkHHq5eM04TTaRwv+CwppJV60ohZi7L6mIfbLMh18k9L353KnZFos
	MH/5AzvJXkJYLkX9CL25H/gqBddS6Ne70g96mRSKFxvg43FeqjbvcC36U2AwjK9lWfuSYC28/Ln
	yRFCtMFbz+xl2UC3Fdkj+bbBILQGZDElF3H92tdLw9phW1PRbp8jqfQ+voX43r1asd5jmA+AHw1
	qhoxw/Maus9xzMJcPE5RAtIV2ZgQ9WB5fMk2Xnlu88DU
X-Received: by 2002:a05:600d:848c:20b0:490:ab15:b9e8 with SMTP id
 5b1f17b1804b1-4980587baa9mr47795e9.2.1785433244036; Thu, 30 Jul 2026 10:40:44
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-rfc-nt-demote-v2-0-452dbe3b5073@zptcorp.com> <amuJbBrTW9W6_sx8@gourry-fedora-PF4VCD3F>
In-Reply-To: <amuJbBrTW9W6_sx8@gourry-fedora-PF4VCD3F>
From: Frank van der Linden <fvdl@google.com>
Date: Thu, 30 Jul 2026 10:40:32 -0700
X-Gm-Features: AUfX_mzF-rbdWdA029msHQErAvjm1m5KqVtwi7O3MQR1mBpjRQR1Wfxbg8w05fM
Message-ID: <CAPTztWatWbsF4KQwD-_nib-vrZ6uvrhMYcOc1mkWu-7DzN95AQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/3] Demote to lower tier using non-temporal stores
To: Gregory Price <gourry@gourry.net>
Cc: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Rientjes <rientjes@google.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <nifan.cxl@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Raghavendra K T <rkodsara@amd.com>, 
	"Rao, Bharata Bhasker" <bharata@amd.com>, SeongJae Park <sj@kernel.org>, Wei Xu <weixugc@google.com>, 
	Xuezheng Chu <xuezhengchu@huawei.com>, Yiannis Nikolakopoulos <yiannis@zptcorp.com>, dimitrios@palyvos.net, 
	Ryan Roberts <ryan.roberts@arm.com>, Huan Nguyen <nhuhuan@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Alirad Malek <alirad.malek@zptcorp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 10:30=E2=80=AFAM Gregory Price <gourry@gourry.net> =
wrote:
>
> On Thu, Jul 30, 2026 at 05:02:56PM +0200, Yiannis Nikolakopoulos wrote:
> > In most memory tiering scenarios, the memory to be demoted is expected
> > to be cold and most likely out of the node's last-level cache (as well
> > as target pages in the target node). Using non-temporal stores instead
> > of a standard memcpy path can reduce the cache pollution in the local
> > node and the bandwidth overhead to the target node. Furthermore, for
> > certain types of CXL devices that support in-line memory compression,
> > the last-level cache eviction patterns can negatively affect the
> > bandwidth of the device. Non-temporal stores can mitigate this.
> >
> > This patch-set introduces a new migrate_mode flag for using non-tempora=
l
> > stores that is used only in the demotion path. Patch 1 adds some helper=
s in
> > x86 and mm to bring non-temporal stores support to a respective folio_c=
opy
> > function. Patch 2 adds the new flag and necessary changes for compatibi=
lity
> > with the existing behavior. Patch 3 uses the new flag for demotions.
> >
> > Experimental data: in a CXL system with 1 memory expander, a microbench=
mark
> > that allocates N=3D64 GB memory in the local node and then triggers dem=
otion
> > using memory.reclaim, shows a practically complete elimination of read
> > traffic on the device, i.e. write traffic is N GB with and without the
> > patch, while read traffic drops from N to almost 0 with the patch.
> >
> > Opens:
> > 1. There is some "duplication" in the x86 tree and a bit in mm. Can we =
do
> >    something better there? As it is now in copy_mc_to_kernel_nt we
> > duplicate the machine check functionality, which if available will over=
ride
> > the non-temporal. We were not sure how to prioritize these two and what=
's
> > the best approach here. Can we completely skip the machine checked for =
this
> > path? Huan Nguyen has some ideas here that we will align for the next
> > version.
> > 2. I am not sure how this should be structured so that it is easily
> > adopted in other architecture trees (e.g. aarch64). We rely on
> > memcpy_flushcache for x86_64 but this does not use non temporal stores
> > in ARM. ARM support is currently out of our scope but any input is
> > appreciated.
> >
>
> I'm still a bit confused why using NT Stores needs to be an explicit
> option - rather than the default behavior if NT Store is available.
>
> Lets assume we did this for all ASYNC requests, is there a negative
> effect? A positive effect? Why the new ASYNC type? Is there a
> correctness issue?
>
> ~Gregory

Yes, this is a good discussion to have. I believe that the initial
reason for using a separate mode here was to be non-invasive, e.g.
"don't break anything else".

But why not use non-temporal stores for everything? I don't know. I
suppose one argument might be that if you know that the destination
will be used immediately, NT stores might be a slight performance hit.

arm64 already seems to use stores with NT hints by default.

In general, though, I agree that for ASYNC requests, just always using
NT seems fine.

Maybe the mode and reason should be folded in to one variable, so
that, further down the stack, a decision can be made as to what type
of copy to use? E.g. if the mode is !MIGRATE_ASYNC and the reason is
MR_DEMOTION, then non-temporal is still a good choice. If the mode is
MIGRATE_ASYNC, NT is still a good idea. If you wanted to get fancy,
any mode with folio_test_waiters(folio) =3D=3D true should not use NT,
since a task is waiting to use the data, so caching it is better.
Maybe that's overthinking it.

- Frank
