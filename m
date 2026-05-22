Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC0E341065
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779467477; cv=none; b=FpoEbJgKeFXLmeD3GSC56aur0SdSy8Q57Hs8b5d4hbIXzxaBIVkut34kKKrc80ObbHNCEJFBxnaJxrMnoLjctC5qNeVDNoKNpo4kgFhfyrxhIYFvKjKxL1O6ZEgcbTNGZkVGCLLoF1VvASEPeuNJ+iTj82fKXzW0CCcxU5lZJ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779467477; c=relaxed/simple;
	bh=ZB1zN0lFhdutdAJ2gklLxjJbqSoEBLb4bQLOW2WicV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBWa5CySDrOveXJTMkcsZj1RK12au8XFjsf4H2o9Vfzye5x7Azn0L261U6lo/4NFCbIIc+mfVARsPicP3P9WC9Td/7L6VgklKs0DwE4qiEsf3As7rtZvO4y44MEhODuMwB0+yKhHA3a9EmyU2XL6E5+Ok6Aya4T6Ne51iRNWrwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4nqoacz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4nqoacz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779467475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZB1zN0lFhdutdAJ2gklLxjJbqSoEBLb4bQLOW2WicV8=;
	b=F4nqoaczi57Rr0qAFhwJkWP88Ii6WZt5phliC6RzBfo2yLF1rgkgYaDzx1b/SL1VgbQ991
	Gqh8F3NVz8/5vGGa9lkFiCsWOZTpK7t8iGofp0tscqMU/H6qgF2ik4LX4gz+l3Hdwo7cxz
	iL1MpE9+7+1B2VGI87w0iZCB4h7XLhs=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-jp4iMdG9N0iKxrPu9cMMRw-1; Fri, 22 May 2026 12:31:13 -0400
X-MC-Unique: jp4iMdG9N0iKxrPu9cMMRw-1
X-Mimecast-MFC-AGG-ID: jp4iMdG9N0iKxrPu9cMMRw_1779467473
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-65c7df54465so7143158d50.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 09:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779467473; x=1780072273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZB1zN0lFhdutdAJ2gklLxjJbqSoEBLb4bQLOW2WicV8=;
        b=coGh0P0zuJ6T/Cly4ioiIBnZPcTOnKHN4bcEzZ5I3Ajl65usmskiTzRVV9zJ+8WIiq
         8zhXXZP0DU3zz6NPOOWyY/LGUkpGe725EdGKO4cGvjoL0wuMftsS9yvkHay3lDFJE7Zl
         O1yZDy2H2POPF50BjIg7p6enLYaeBD81krkeHnz4HZJe1GZEolWOMrnfwjIdGQY1r2Ko
         Z548LD0uX1OYSJFRtn7IZ+fK7R4w9PoNbkzcbrI9+1ImUL/z5EHuYy95PsKZWazhur5H
         0tWqWfVsYyLdkY9FIR4DWpug1cNWl4sejTxDr+O2+Yu66qZ96nsotk5Xh4ApSVHxBpDs
         7BLw==
X-Forwarded-Encrypted: i=1; AFNElJ9uYqsefmyPAsFNzAk8mbCsQ3eE0F0ZIRfd1kZ3NUNHng98GMRZEPr1vO0E7HiMlHdSr6/DiyWV15AsAc/sJfCIcEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGAkWEBZz/0tBX4WSIMVGF40pq9Nq/vnloaCdEhnuVAl929SZ3
	rRgUzP/PxpMkBqshWBIRDGhRxJ67LVm/r5JsOYVA/sOkwcD4I1b7qwHzLS8+EaLauhA+lsj+9i3
	DRI0+rxMivxr62+T83eYFnjRHJsHIUfa4aEuArPqZ7qDoRQKtJaVXNQt0e1G5rlzjduklnLtz3N
	uKVUphg1OQDYVSmhi2ssroS2YRE0ewvMGLCw6vdwIlXTLzF9ug
X-Gm-Gg: Acq92OFbFOpinCAFe713IhLZaOCw03Qfxv14y9MseN4a3cUPJuZy1GV5PGMJkhuQKRu
	jYLGokXtvyoAzyUecIAQ7GB7dCTQ50CPuSkiBL0li04KuwsoRqNRe7cBOXn7fZyHeDuYugKzif3
	spK5tUStbl7NpyK0z/cjJaHkngl5Ea1L3R02DTmY0hkCV8/Bd7XcJgfEAQdbS2gPkDak6PCZUNO
	5rpNKI2GRye+8EQ
X-Received: by 2002:a53:ac9b:0:b0:65e:d9f4:115a with SMTP id 956f58d0204a3-65ed9f41984mr1675618d50.52.1779467472949;
        Fri, 22 May 2026 09:31:12 -0700 (PDT)
X-Received: by 2002:a53:ac9b:0:b0:65e:d9f4:115a with SMTP id
 956f58d0204a3-65ed9f41984mr1675510d50.52.1779467472252; Fri, 22 May 2026
 09:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522150009.121603-1-npache@redhat.com> <CAA1CXcCoDU_pnp0SmMzRi8wPGB1OBjbbokevq2X_03X1vpWtOw@mail.gmail.com>
 <ahByO_HWn6MB8z-u@lucifer> <CAA1CXcDoFdZZ4aBx0BPA7QXYKYBYDoqUiLTLYe3L5opJ0LsJGg@mail.gmail.com>
 <ahB_hae8coGvf12Z@lucifer>
In-Reply-To: <ahB_hae8coGvf12Z@lucifer>
From: Nico Pache <npache@redhat.com>
Date: Fri, 22 May 2026 10:31:41 -0600
X-Gm-Features: AVHnY4JwqTM4KQ585Lna0BN9qklHfMsqSL-jihLqRIt4jnbKPb5w4AMPLogCSss
Message-ID: <CAA1CXcCoyGzEyeFPW+zKiA2AOj=0Lm7R=odLtVru+dQa0P_2cQ@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixes-unstable v18 00/14] khugepaged: add mTHP
 collapse support
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: linux-doc@vger.kernel.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com, 
	cl@gentwo.org, corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jack@suse.cz, jackmanb@google.com, jannh@google.com, jglisse@google.com, 
	joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, 
	liam@infradead.org, mathieu.desnoyers@efficios.com, matthew.brost@intel.com, 
	mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, 
	rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org, 
	richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org, 
	rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h42F9WUdtWTtscPpBkb6ugd9EYns7VoJDQqBi_KEmho_1779467473
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 10:20=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org> w=
rote:
>
> On Fri, May 22, 2026 at 10:08:19AM -0600, Nico Pache wrote:
> > On Fri, May 22, 2026 at 9:17=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org=
> wrote:
> > >
> > > On Fri, May 22, 2026 at 09:07:29AM -0600, Nico Pache wrote:
> > > > Whoops I manually changed the coverletter subject to reflect that t=
his
> > > > in on mm-hotfixes-unstable but never updated the others...
> > > >
> > > > Hopefully that is ok. Just a small mistake. Base commit is referenc=
ed here.
> > >
> > > It's not ok, this isn't suitable for a hotfix in any way shape or for=
m?
> > >
> > > As you know, because we told you :) May has been difficult because of
> > > conferences, holidays (and in my case burnout recovery).
> > >
> > > And unfortunately the series seems to have needed quite a bit of revi=
ew again
> > > (my suggestion to you would be to ensure you don't make major changes=
, only
> > > small incremental ones on the basis of review feedback).
> > >
> > > So this isn't viable for 7.2, and we'll have to target 7.3. Therefore=
 there
> > > was no rush.
> > >
> > > Also please don't spring a respin on this series on us without discus=
sion
> > > first, with people away and (frankly) the amount of work involved her=
e,
> > > you're going to have to accept the pace that workload/availability pe=
rmits.
> > >
> > > Adding spurious hotfixes tags doesn't help anything :) please don't d=
o that
> > > again.
> >
> > Hi,
> >
> > Sorry for the confusion but Andrew and I spoke about this before I
> > sent it, and he confirmed that I should send it against this tree to
> > prevent merge conflicts.
> >
> > Because Zi's series depends on this, and this is already in the mm
> > tree, choosing a candidate before my commits was best to prevent merge
> > conflicts.
>
> There's some kind of confusion here.
>
> This series isn't suited for 7.2.
>
> Sorry but Zi's series, unless it depends on functionality here, will have
> to be rebased.
>
> People have been at conferences, people have been on leave, I've had to
> pace myself for health reasons and it seems there's been more than simply
> review comment-based changes happening here.
>
> (Again I strongly encourage, at this stage, to ONLY be making changes bas=
ed
> on review, not adding ANYTHING else or changing ANYTHING else to avoid
> delays :)

All the changes are based on review points. Very small changes in this
version; the largest being the one that you specifically argeed too.

>
> Also - shouldn't mm-unstable already have mm-hotfixes-unstable in it?
>
> I think in mm-next we will have an stable branch, that everything is
> based on, where things go once review is complete and things are mergeabl=
e.
>
> And a separate hotfixes branch based on Linus's tree.
>
> That would avoid issues like this :)

Im sorry im new to this, but I really dont think this tiny error, and
something that I'd confirmed with Andrew beforehand deserves NAKing
and defering it. Ive worked through my PTO to clean up some of these
review nits just to get it in 7.2. I even through this through my
rounds of testing today before resending.

>
> >
> > The intent wasn't that this is a hotfix, just that this was the
> > closest base before the v17 that is already in the tree.
>
> The convention is that [PATCH ... <branch>] indicates the target of the
> changes. Putting the hotfixes branch there implies it's a hotfix.

Sorry I thought the <branch> was what base you used.

>
> So please be careful with that in future :)

Yes will do for sure.

>
> >
> > Sorry for the confusion, hopefully Andrew can still apply it to the
> > correct tree.
>
> I'm not even sure what's best for that at this stage given we have
> conflicts and this has to be delayed until 7.3.
>
> I wonder if given that we should not have this in mm-unstable at all and
> just wait it out until the next cycle begins? Review can happen
> concurrently.

I still dont see why this has to be deferred, I was working with
Andrew to prevent merge headaches.

-- Nico

>
> >
> > -- Nico
> >
> > >
> > > Thanks, Lorenzo
> > >
> >
>
> Thanks, Lorenzo
>

