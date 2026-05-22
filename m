Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D529437A485
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466273; cv=none; b=GDAYLqKES+NuEL46vOT1zSARd99fBYtBhNMzAFt7Eh8JAFhT1J5jKu40lrMY+ksWbnLVDEihoSevDFbtajCc6nu5Msxc1e91EVNWCwPZCX3a4YZX+z3lt3FGvidkBhO9gaCJyqVxVcGu0fot3q6n+m7X2+nUV8oznSu9FN5ZmGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466273; c=relaxed/simple;
	bh=La2W+yN0vzwPkY2oECj6NHOhikNkncK+jT4y0b881Cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmNkyKj86hElSZqOpG6FVJ/eabqqrLdjuxJQTSw8DnqV2kCD8l9WnI5Hrp+JqYGDHg0zPcN9cMSDT3XiS/C4OG4Y7ft3pNJpAW5ztR84QJrHVcADZ9dGuoMGOVRcfQ7v4Wg9qivZ6JjU0AMNQg4asAWPMDx9gCRiIese6+UcrcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JlT3hKo5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JlT3hKo5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779466271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IzxgIsKBLy9Uo/RJ5aMTM+y5Ci98qZZTufyvn4tb+6I=;
	b=JlT3hKo51763Chr+28crtcDS7xH9BtWFNUwqozOalRZHjhMcrvF2ShARYATaI5XOzzMIzR
	WadL15AHn+PgaGL47D6tbsqVx0BcCXsalMymWVt1oYZ2bU5yVrqkmuvAKOfyAZERFS548a
	C2It6a+VYr0yPdEqWvQUFaoG5C9g8f4=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-24KP1jz3P1yUdeviCuJx1w-1; Fri, 22 May 2026 12:11:09 -0400
X-MC-Unique: 24KP1jz3P1yUdeviCuJx1w-1
X-Mimecast-MFC-AGG-ID: 24KP1jz3P1yUdeviCuJx1w_1779466269
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-651bd2131f0so1412449d50.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 09:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779466269; x=1780071069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IzxgIsKBLy9Uo/RJ5aMTM+y5Ci98qZZTufyvn4tb+6I=;
        b=ja2jYhDlN22zVJhuOKAL4LFijUsA01QfNJacIi1E6INX3OgmngT89Z+iS4ksy66F0/
         oIxAhizcU7dJKwe66VxGS01+eQ2W61amFOlly8EclYyZwiGZDq+p0wkpPVZ5REtWSo5Q
         TXPDuannH3n0bGKDxXe6gvPYSitA3t8uPK93TxcM2XSUKx9bh5xT4jfRpZDFx7Q3kfsV
         5a+m9XzVJrJywGL/dRrfbwe7IAI8y6CM22LeGBSy396NeeNaRznk6D7aXhK7JflvymYB
         GXPH7Fr9s79rzyqEwpbfjhcjrDobEo80LKFnvH5kfxPerW7ZIlmJXcXKw81e9hXthSH+
         S+DQ==
X-Forwarded-Encrypted: i=1; AFNElJ9j+y8KOMytxoqDWQ0/Vgy8KqlNEvQOLxC/6GSFwxJbaM23s+/ZAbLWfEdSJxwicykVuMsNIRNFHeGcpOlHSu0mwMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqkw0WWBn/l+S9f1r8JrsO1XhFBveb67+ogMO+rElS3o4c/0fX
	ueL3HnJuLYKqKQXy48W8z1PuZFs2vvY430wtiLpQCljgR3KEvJOlFs0q/uNRo8feiiwriC/scki
	W7ahMuOdJHqSJiz+gXE5qg0fPXQaFVcu71bPRJYFFpSbk14aduV+QtItao76UbXL6N95V1hNnvV
	mjOpV+fJYhYtOugrzdw5FcBYpiUTqBCjktnTiIE+tNGzKz1Cmk
X-Gm-Gg: Acq92OE1uVb2E1MNyBLHXpCxv4GzytPS4SoQYHmsbrF0PqrUCpKxFDuc2l2b3qBy14M
	vck63uPREg7kOrPHVQFmAfLZzpF1n9kL0WRBbxtpKG/yMLpqE26sTkIY22dSdFoJsTrq7odMS64
	kMvkmTiJCMNAd7bYIR9GLz2/v8Ih9f8zmIjy+WPSEhufhHombDlx1tCEmdyERPIiG4S07KvrKF3
	cu/qQ==
X-Received: by 2002:a53:c049:0:20b0:65e:b05:7679 with SMTP id 956f58d0204a3-65ec9631f73mr3544878d50.3.1779466268951;
        Fri, 22 May 2026 09:11:08 -0700 (PDT)
X-Received: by 2002:a53:c049:0:20b0:65e:b05:7679 with SMTP id
 956f58d0204a3-65ec9631f73mr3544806d50.3.1779466268532; Fri, 22 May 2026
 09:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522150009.121603-1-npache@redhat.com> <CAA1CXcCoDU_pnp0SmMzRi8wPGB1OBjbbokevq2X_03X1vpWtOw@mail.gmail.com>
 <bd622950-62cf-4b57-b3ac-89635f28fa4f@kernel.org>
In-Reply-To: <bd622950-62cf-4b57-b3ac-89635f28fa4f@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Fri, 22 May 2026 10:11:38 -0600
X-Gm-Features: AVHnY4Kw4pwY2uJsQhaEmVi-b5AxtiG-JxHuFGdnogUOlR8F2xU-TlkRWivxYiQ
Message-ID: <CAA1CXcD373fFfo9YPWRj8mJ_rsnzyCrpn1uk3=k7kU=QuaLOgg@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixes-unstable v18 00/14] khugepaged: add mTHP
 collapse support
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: linux-doc@vger.kernel.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com, 
	cl@gentwo.org, corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jack@suse.cz, jackmanb@google.com, jannh@google.com, jglisse@google.com, 
	joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, 
	liam@infradead.org, ljs@kernel.org, mathieu.desnoyers@efficios.com, 
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
X-Mimecast-MFC-PROC-ID: 04WqaQOKo6BggQ2mTZHWo75gXvnCICi51-6Ol2DkpUg_1779466269
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 9:13=E2=80=AFAM Vlastimil Babka (SUSE)
<vbabka@kernel.org> wrote:
>
> On 5/22/26 17:07, Nico Pache wrote:
> > On Fri, May 22, 2026 at 8:59=E2=80=AFAM Nico Pache <npache@redhat.com> =
wrote:
> >>  include/trace/events/huge_memory.h         |  34 +-
> >>  mm/huge_memory.c                           |  11 +
> >>  mm/khugepaged.c                            | 634 ++++++++++++++++----=
-
> >>  5 files changed, 584 insertions(+), 172 deletions(-)
> >>
> >>
> >> base-commit: 6c8cb505a5634594b3ea159fd1c71bce2acf3346
> >
> > Whoops I manually changed the coverletter subject to reflect that this
> > in on mm-hotfixes-unstable but never updated the others...
>
> But why? That branch is for hotfixes that would go to the current 7.1-rcX
> series. mm-unstable would be the correct one for this, AFAICT.

Sorry this was a misunderstanding. The goal here was to base this off
the closest base commit behind where my v17 already lies in the tree.

That just happened to be the hotfixes tree (previously it was
mm-unstable, but that seems the have moved).

Sorry...
-- Nico

>
> > Hopefully that is ok. Just a small mistake. Base commit is referenced h=
ere.
> >
> > -- Nico
> >
> >
> >> --
> >> 2.54.0
> >>
> >
>

