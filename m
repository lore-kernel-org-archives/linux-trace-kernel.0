Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309811B5AA;
	Wed, 31 Jul 2024 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445322; cv=none; b=R5OTFlIM8zctAxPSieSIo7ZjqFc3wSKWHiNhs9Vaa+I6A9rnAkzH/mjCkcOw9lUAxlB5GjvF9x3QS82NK5L6JEXAD191JKC1Tn1f6nzYl6x/Qa6hEcosOzl49RhRrIJctEj44hc+dUCv90SHaDQSC+lvqyVl1pz4itnGMYV59q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445322; c=relaxed/simple;
	bh=M7XfYP4jB9PHxC7I1Mbcu8PF16k1/ZNXZFQOSFqw/jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfXKIGk6BRcM908J+a3uYIdphxtoWhsV71PFpwCQajSeU9NqhHUtNANYaAghduiwm3fwrPVJ9SS5fJnaF9l0Ekb1kUun6GFKw2ybGtX0ClR6ycKTxW6+syurHbpVTI5+bqk5tjdzO/3ITZNSe6sjqa0zcOcI7p7Ls04qCpoFAek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5hxNc+S; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5hxNc+S"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cfcbdfa572so1555724a91.3;
        Wed, 31 Jul 2024 10:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722445319; x=1723050119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8+1Ga1arjNxx7kizUnJk9pLWONwqIibdpZUKJOK6ZU=;
        b=g5hxNc+Sx96ZD21qD/9FXES3f6GW5nCQWxKNcrYLmLGEra3lmAzZqZQjFFOYiWFlJZ
         bm1M/BmcRQTzxIx8UcXzVtjRN4rKYLI2qM0vprfifXUZz0a430Yrh6TYD6j5hQsTEfPT
         DEqipo1OiDmklsy1Wydv8zg7VEj6PUI2fPsfJEhaRoRQN1IFE5e12vXnP+GlFPzWbWGl
         ExDsr5rBmAPGJhsVCu917lMU8PEs+rs3RcQnamwJ70+AEdqGEm+nkDYIaZcTvwHSDTwy
         b4yEIQoSIn7bIptLgZBOj0kj2On41EtaPaKP+jbbSfskO4rAwY1oh+m8uTx833eHWr84
         hUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722445319; x=1723050119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8+1Ga1arjNxx7kizUnJk9pLWONwqIibdpZUKJOK6ZU=;
        b=E3RSjUSP+Oc6B8kRm80RhW/IdCPpcflFXoc2flPeuBd0tNG6KKq1EpRynhuVL/pRID
         tvZxhlc6bsODJeEGYVwhgQI1NpjH2IcYPT+F9+UrwrD38vQ0drEpGS4omlp09jjazFqq
         HHaMBJEv0s/ilLRgzwHYnfl18IHvPIKnT5boZ06RmdnwgjEKZYvBDvleVyszQNjfVn46
         L0HrfL8ZDggIg3xireRtqcLf3u+qVL2/MomnPJkKcKzbMSQ4AOA0EBQIYWtz/Rspf36q
         s+duoUzRhsx0PfZ6E3BOX3zwdiD3Py1caDKaq0aUWk3mpHTvSXMpK3mGbAmLjCCVAAFh
         tQtg==
X-Forwarded-Encrypted: i=1; AJvYcCUK1pT8pC3xn/28LYscPv6mJsEwzTNrxGLm4HntiJ8arCjhWwP/OAQjADUrrMYo+D7l61gVZ1qPyTzxyFnt+xX/WeoiYHZUOUA6MpI8AYOmNZi7IYSSnvpBRZg5XcLgCnsjWaysD5vQhgLF78FtAVgh
X-Gm-Message-State: AOJu0YxMqqZiL4ChQycYjQGsI3Kj48/DMC8pgSPv3wBtZGT7/QaADG5p
	3bHVlM46Nlh+qco76oM/SvJg4cj6yzLnYpQsPEzJTovBwhz9z+1YEM41r0/Hz/cVra5+JgNQEja
	SrkXfKkTYXwT0usYa0R4dWv+ug/A=
X-Google-Smtp-Source: AGHT+IEENT0NDPRwWvh2L1GmLJe+Zqny1LoZGQAplTQI4qrsuk/ksFj5pyZ9O2O+MbNDnCl89V6Qc256Fm7F7jQVmxw=
X-Received: by 2002:a17:90b:3003:b0:2cd:3331:ebc7 with SMTP id
 98e67ed59e1d1-2cf7e0959a8mr12990006a91.2.1722445319422; Wed, 31 Jul 2024
 10:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729134444.GA12293@redhat.com> <20240729134535.GA12332@redhat.com>
 <CAEf4Bza1_njsVUad8so9EFxy8VmJsTfzaaAahBYFtOqdF1HAjA@mail.gmail.com> <20240731165614.GI33588@noisy.programming.kicks-ass.net>
In-Reply-To: <20240731165614.GI33588@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 31 Jul 2024 10:01:47 -0700
Message-ID: <CAEf4BzZXze8wRQwEJSy5nFzH=uk4wZPHY-gWw6j7iZfeBEiO0g@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] uprobes: make uprobe_register() return struct
 uprobe *
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, andrii@kernel.org, mhiramat@kernel.org, 
	jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 9:56=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Jul 31, 2024 at 09:18:00AM -0700, Andrii Nakryiko wrote:
> > On Mon, Jul 29, 2024 at 6:45=E2=80=AFAM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > This way uprobe_unregister() and uprobe_apply() can use "struct uprob=
e *"
> > > rather than inode + offset. This simplifies the code and allows to av=
oid
> > > the unnecessary find_uprobe() + put_uprobe() in these functions.
> > >
> > > TODO: uprobe_unregister() still needs get_uprobe/put_uprobe to ensure=
 that
> > > this uprobe can't be freed before up_write(&uprobe->register_rwsem).
> > >
> > > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  include/linux/uprobes.h     | 15 +++++-----
> > >  kernel/events/uprobes.c     | 56 +++++++++++++++--------------------=
--
> > >  kernel/trace/bpf_trace.c    | 25 ++++++++---------
> > >  kernel/trace/trace_uprobe.c | 26 ++++++++---------
> > >  4 files changed, 55 insertions(+), 67 deletions(-)
> > >
> >
> > You'll need something like below to not break our bpf_testmod. And
> > please send pull patch sets, not individually updated patches, it's a
> > PITA to deal with. Thanks!
>
> Do I stuff this on top of Oleg's patch or do you want me to fold it in
> one of them?

Please fold so we have better (potential) bisectability of BPF
selftests, thanks!

>
> > commit 9f739a9997ab833394196459fa7e6dd4d13dd48b (HEAD -> uprobes-oleg-c=
leanups)
> > Author: Andrii Nakryiko <andrii@kernel.org>
> > Date:   Wed Jul 31 09:15:46 2024 -0700
> >
> >     uprobes: fix bpf_testmod after uprobe_register/uprobe_unregister AP=
I change
> >
> >     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > index 5f152afdec2f..73a6b041bcce 100644
> > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > @@ -431,6 +431,7 @@ uprobe_ret_handler(struct uprobe_consumer *self,
> > unsigned long func,
> >  }
> >
> >  struct testmod_uprobe {
> > +       struct uprobe *uprobe;
> >         struct path path;
> >         loff_t offset;
> >         struct uprobe_consumer consumer;
> > @@ -458,12 +459,14 @@ static int testmod_register_uprobe(loff_t offset)
> >         if (err)
> >                 goto out;
> >
> > -       err =3D uprobe_register(d_real_inode(uprobe.path.dentry),
> > -                             offset, 0, &uprobe.consumer);
> > -       if (err)
> > +       uprobe.uprobe =3D uprobe_register(d_real_inode(uprobe.path.dent=
ry),
> > +                                       offset, 0, &uprobe.consumer);
> > +       if (IS_ERR(uprobe.uprobe)) {
> >                 path_put(&uprobe.path);
> > -       else
> > +               uprobe.uprobe =3D NULL;
> > +       } else {
> >                 uprobe.offset =3D offset;
> > +       }
> >
> >  out:
> >         mutex_unlock(&testmod_uprobe_mutex);
> > @@ -474,10 +477,10 @@ static void testmod_unregister_uprobe(void)
> >  {
> >         mutex_lock(&testmod_uprobe_mutex);
> >
> > -       if (uprobe.offset) {
> > -               uprobe_unregister(d_real_inode(uprobe.path.dentry),
> > -                                 uprobe.offset, &uprobe.consumer);
> > +       if (uprobe.uprobe) {
> > +               uprobe_unregister(uprobe.uprobe, &uprobe.consumer);
> >                 uprobe.offset =3D 0;
> > +               uprobe.uprobe =3D NULL;
> >         }
> >
> >         mutex_unlock(&testmod_uprobe_mutex);
> >
> >
> > [...]
