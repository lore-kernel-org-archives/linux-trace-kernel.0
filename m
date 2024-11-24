Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD39F2500B5
	for <linux-trace-kernel@vger.kernel.org>; Sun, 24 Nov 2024 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732478230; cv=none; b=EbHICK/OqlTMZ9fo9KWxosTFm2WjNdWifq3eQ5iI4eEWwtmnOrKIMa0glcKl88p6NCuqkdl+v1BSJvvHlDAI5DOjwyiioj05xn/mxp4whtaa03jDlOKgt+8AtUS+hGW1QdMqqZIOGrCc7FiYA7wbpTFVyl1t9eWffQ8eL6gPdQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732478230; c=relaxed/simple;
	bh=OcNnfOETQ9CK3MaYLJJ9ZxKWUCVW7lfZvl2yfrAIWII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtjU0VHieES+CyrHnxC8xFk4qGbesHozN8mBNAhdxm9QJDYaYxXMT6zyJn0wWDlU7IfIl3sIr56MdgB5Xy/Ah+Opr8PdFKBY8rBXcP+WfWUp4uVvWpDy4krg3OIJ4CzkyfjPOBJVNdska7Wa6bCTkjGxWGOKxGJsEvxFV2pnDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bigX6Htv; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bigX6Htv"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4668194603cso148151cf.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 24 Nov 2024 11:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732478228; x=1733083028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydgtc14DZFpEcBW19X27uxPsYRsPBfImUkfn8msMgnw=;
        b=bigX6HtvT9fuCWuWZ83Jx0Fg+7XOhz6PShXKo3XZNKAfm/JDYKy/mPjTBdpJMw2Glo
         XZFSph4FUfuVs/Rz+xwpd1QjNhG/7LHYFhGoC/qT0DeEzIHwefhOS5hw5R/1SzZVwcdK
         JOSRpyogg9ilDV6P4U03r6pXq9f6z3Ps45X0cH02jnjCZwQQMCZ3Oiu9nrHCBixQGjob
         kDRgfkwkUkJ7UhtNSg9T3xjkyWzOIdKbZr/4fODJD0Uz0Yzv2DIZcQJFKBpoiAYObFqq
         66qVIpAV9PH1h0MjGyEJEcYDY1euSb7sjZXfxMVcD6nRF/Sk4UlWJmqHfR0UOavOQNsK
         mQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732478228; x=1733083028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydgtc14DZFpEcBW19X27uxPsYRsPBfImUkfn8msMgnw=;
        b=Z2U/vCkGivTT4ooj1RbVkoiffXlZXGbOMrk+xg72+Dy5M30W6LtJjOH+rWrQ6R1aY5
         /DySpBwpt8JwgAjETl+iZQzS/K0BVAWoJSC6p1Zd31CEnb1zMfwwy7yQi8uCn3aMa1Of
         T3m7VzU7SpCHdd1r45GQfZa1irbrLEI+ns4GmsEIRiZrdVCBqkccURcf63ljYhFIX/je
         lLzPWlyWbiuhHdiqE9Jr5XwvwO53FYmbwGdzl7mXxERlgXa3MQ1EceVT8cWSDHo0H5s/
         GMVgIDdSNZtweTKird1RlyjZeD43JhYxOj9+BcWhruy1JNNZMfMtW44sxlx/cSVFmjJn
         IA2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUI4o/KL82/8FCEGSK9EuUPflW33GJm/vzbP2nZ3nnWElPq82Ly1RvLcsAYNDq9PonLyqm8WdNBvHyylFJCtX99hcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/GScYrSq+3rf2DLEDrn3oFIPOaQeIKZY27OzgSW+5pt0Afd5x
	cUYo4u+3Jf3kxRs3Q4QcIUGSt0pkKCdLIYYuDyvZicKPuTF/VsrHIqD5i9fwTFArLGx3YvbVF9g
	0EDCUoPabbRM2/TUYP3c5mCLU5xNtydV0FPAA
X-Gm-Gg: ASbGncvP0U8WsIuMXwwIoh7dgmkX0rtGGNg9pPoKbVFxW7x5BOL33RmrTNEFTeul3jv
	EdIfPR4MvbA6ub6O/eDtFQJOo1tGlY0DmvVWxYRK5bVs/k84Wl/2ByCuwInRyPw==
X-Google-Smtp-Source: AGHT+IEA0e8lCBFPAtVyOffPIrAlSanvsYtSOuzXTjPA1NcAopy48+uF2AbLjCTIrBPX0rYRUwiU7jwTUnp1FXB3rug=
X-Received: by 2002:ac8:660f:0:b0:466:861a:f633 with SMTP id
 d75a77b69052e-466861af6a1mr1683291cf.5.1732478227528; Sun, 24 Nov 2024
 11:57:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122035922.3321100-1-andrii@kernel.org> <20241122110737.GP24774@noisy.programming.kicks-ass.net>
 <CAJuCfpFvHwjMDdFGjCfg+fta2=Ccif7XReTH6TpC+V+PZ1JmAQ@mail.gmail.com>
 <CAJuCfpFy27B3B=4QvATTzaM44Ferf1scbt0JCdrCdj2gzo52+A@mail.gmail.com> <20241123203543.GC20633@noisy.programming.kicks-ass.net>
In-Reply-To: <20241123203543.GC20633@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 24 Nov 2024 11:56:56 -0800
Message-ID: <CAJuCfpGM7rX6EBLSpjY-go1N-mbc_ObgjeggTLgE4rOR4mXDDA@mail.gmail.com>
Subject: Re: [PATCH v5 tip/perf/core 0/2] uprobes: speculative lockless
 VMA-to-uprobe lookup
To: akpm@linux-foundation.org, Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mingo@kernel.org, torvalds@linux-foundation.org, 
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, willy@infradead.org, mjguzik@gmail.com, 
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org, vbabka@suse.cz, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, david@redhat.com, arnd@arndb.de, 
	viro@zeniv.linux.org.uk, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 12:35=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Fri, Nov 22, 2024 at 09:48:11AM -0800, Suren Baghdasaryan wrote:
> > On Fri, Nov 22, 2024 at 7:04=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Fri, Nov 22, 2024 at 3:07=E2=80=AFAM Peter Zijlstra <peterz@infrad=
ead.org> wrote:
> > > >
> > > > On Thu, Nov 21, 2024 at 07:59:20PM -0800, Andrii Nakryiko wrote:
> > > >
> > > > > Andrii Nakryiko (2):
> > > > >   uprobes: simplify find_active_uprobe_rcu() VMA checks
> > > > >   uprobes: add speculative lockless VMA-to-inode-to-uprobe resolu=
tion
> > > >
> > > > Thanks, assuming Suren is okay with me carrying his patches through=
 tip,
> > > > I'll make this land in tip/perf/core after -rc1.
> > >
> > > No objections from me. Thanks!
> >
> > I just fixed a build issue in one of my patches for an odd config, so
> > please use the latest version of the patchset from here:
> > https://lore.kernel.org/all/20241122174416.1367052-1-surenb@google.com/
>
> updated, thanks!

Hi Andrew,
I just noticed that patches from an old version of my patchset are
present in mm-unstable, more specifically these two:

fb23aacd2a14 "mm: convert mm_lock_seq to a proper seqcount"
549aeb99ccf1 "mm: introduce mmap_lock_speculation_{begin|end}"

Peter will be merging the latest version into tip/perf/core, so this
will cause a conflict at some point.
It should be easy to update them in mm-unstable to the latest version
[1]. I was able to revert the old ones and apply the new ones without
any merge conflict. If possible, please update them instead of
dropping them from mm-unstable. Some patches I'm preparing to post
have dependencies on this patchset.
Thanks,
Suren.

[1] https://lore.kernel.org/all/20241122174416.1367052-1-surenb@google.com/
