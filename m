Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C6634CDE;
	Wed, 31 Jul 2024 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722444981; cv=none; b=FQxd4umSaqYJebSutF7r286rMswyVb3QRuOZGVJZVp22fKNrwMpS6KR70bAusHnuwa7lcHFFfhmJg4jS11uwyb5tViSLPUGXwVTaR9FKActoMPUaU953B5+f2EYnfkb+ceQW7dx4TxL/lldLLHOSh+R7y1tONE12icaUGHDwU1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722444981; c=relaxed/simple;
	bh=Z1l84i7WFLY3J70ZGQGL5lORuV+MntauxP/4ole/9iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uS3PB/nOV7xS+49bHYTfiM3ByvwnlgbLTqGRyHNUujwwDm4+b1vFM3VW4tpO24a1qSSG0Zey/fFMGao/lTM88P+AJnyzmYMVyulNNiQyAPdAOkOxPc6DlVmoW7vAbRybtkw942bB4gCt0SZ+ix5NGyQyl4P4O5rmwaSPAL9ZFbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=efz3Csix; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="efz3Csix"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=+Y3CbVRYq6I9qI+FCwLhJRP1pML6FNbZG9fc1WfeQgs=; b=efz3Csixxs9JsqLUSMNMRJqMpA
	JG6+T46amFlrIk8zCukmNh5GWHhUYKeE3RGjnynOb3CJ+nzMHjGXQ8yW9GBE+D7eUjRKv/QYcxlwK
	DKJEHEXkxjj4SxysjiNhmudWlmTeJB98BRGSYkkA+33wsfd/RsEMSQv7eN+XnYICPqQNFdvz715BQ
	JD1R/8pE0dXDZQLW8r3XtVK3bfSZJ5JTEnmUj0u9RDY1lQg4E/RGSL0e1AudtQXxwO5+HtmRkzrqm
	eMRi2apUXu0CruNI68G2dMJ2LwIQiw2hVH3eKfp0nqyJCKAv7I3eRlzblmuslx047IkXbALv1vWZN
	fLtIczjw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZCcZ-0000000GMD8-1NIH;
	Wed, 31 Jul 2024 16:56:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D6D0E300820; Wed, 31 Jul 2024 18:56:14 +0200 (CEST)
Date: Wed, 31 Jul 2024 18:56:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, andrii@kernel.org, mhiramat@kernel.org,
	jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] uprobes: make uprobe_register() return struct
 uprobe *
Message-ID: <20240731165614.GI33588@noisy.programming.kicks-ass.net>
References: <20240729134444.GA12293@redhat.com>
 <20240729134535.GA12332@redhat.com>
 <CAEf4Bza1_njsVUad8so9EFxy8VmJsTfzaaAahBYFtOqdF1HAjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza1_njsVUad8so9EFxy8VmJsTfzaaAahBYFtOqdF1HAjA@mail.gmail.com>

On Wed, Jul 31, 2024 at 09:18:00AM -0700, Andrii Nakryiko wrote:
> On Mon, Jul 29, 2024 at 6:45 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > This way uprobe_unregister() and uprobe_apply() can use "struct uprobe *"
> > rather than inode + offset. This simplifies the code and allows to avoid
> > the unnecessary find_uprobe() + put_uprobe() in these functions.
> >
> > TODO: uprobe_unregister() still needs get_uprobe/put_uprobe to ensure that
> > this uprobe can't be freed before up_write(&uprobe->register_rwsem).
> >
> > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/uprobes.h     | 15 +++++-----
> >  kernel/events/uprobes.c     | 56 +++++++++++++++----------------------
> >  kernel/trace/bpf_trace.c    | 25 ++++++++---------
> >  kernel/trace/trace_uprobe.c | 26 ++++++++---------
> >  4 files changed, 55 insertions(+), 67 deletions(-)
> >
> 
> You'll need something like below to not break our bpf_testmod. And
> please send pull patch sets, not individually updated patches, it's a
> PITA to deal with. Thanks!

Do I stuff this on top of Oleg's patch or do you want me to fold it in
one of them?

> commit 9f739a9997ab833394196459fa7e6dd4d13dd48b (HEAD -> uprobes-oleg-cleanups)
> Author: Andrii Nakryiko <andrii@kernel.org>
> Date:   Wed Jul 31 09:15:46 2024 -0700
> 
>     uprobes: fix bpf_testmod after uprobe_register/uprobe_unregister API change
> 
>     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 5f152afdec2f..73a6b041bcce 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -431,6 +431,7 @@ uprobe_ret_handler(struct uprobe_consumer *self,
> unsigned long func,
>  }
> 
>  struct testmod_uprobe {
> +       struct uprobe *uprobe;
>         struct path path;
>         loff_t offset;
>         struct uprobe_consumer consumer;
> @@ -458,12 +459,14 @@ static int testmod_register_uprobe(loff_t offset)
>         if (err)
>                 goto out;
> 
> -       err = uprobe_register(d_real_inode(uprobe.path.dentry),
> -                             offset, 0, &uprobe.consumer);
> -       if (err)
> +       uprobe.uprobe = uprobe_register(d_real_inode(uprobe.path.dentry),
> +                                       offset, 0, &uprobe.consumer);
> +       if (IS_ERR(uprobe.uprobe)) {
>                 path_put(&uprobe.path);
> -       else
> +               uprobe.uprobe = NULL;
> +       } else {
>                 uprobe.offset = offset;
> +       }
> 
>  out:
>         mutex_unlock(&testmod_uprobe_mutex);
> @@ -474,10 +477,10 @@ static void testmod_unregister_uprobe(void)
>  {
>         mutex_lock(&testmod_uprobe_mutex);
> 
> -       if (uprobe.offset) {
> -               uprobe_unregister(d_real_inode(uprobe.path.dentry),
> -                                 uprobe.offset, &uprobe.consumer);
> +       if (uprobe.uprobe) {
> +               uprobe_unregister(uprobe.uprobe, &uprobe.consumer);
>                 uprobe.offset = 0;
> +               uprobe.uprobe = NULL;
>         }
> 
>         mutex_unlock(&testmod_uprobe_mutex);
> 
> 
> [...]
