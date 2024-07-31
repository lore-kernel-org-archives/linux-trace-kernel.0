Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45F516C873;
	Wed, 31 Jul 2024 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445558; cv=none; b=F7a4n/fQVtXOIP5Ydo/0boMnkJTxYHkh443AzD7gbK9h6HDu9APpaRmiuNwdAfy4+8T+AhfQt8GcQL1RupXIQ7mR5GQXSJg8b+G1eukh1qoSR5dV53+tAqqlo6KYqcblkO1PZajp44j3AL//UeEg7ob+l5OX6DHzT9GD924lsJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445558; c=relaxed/simple;
	bh=subyk3gFtQxzv0FW/N62EaQXV2sMa+xeKNeBxUKqjxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l11SnOzNoatzu50c0vg7k4QcxVLZNiHsNN8CkVU1wnR7nkhqZUKD/rM/uEsaLDaV+J4DultMwatJ0gXlPR9jaDat6M2w6C/WJCMm4VcjQkWEDyVe4vpvRvLJ7asPbedhv/+DmsNeRajnM/mAK2ld6frkibWWwI6bevg83dLK0ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PoEF5B9P; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PoEF5B9P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ESWaf8RGHnPUm7yIk+SlXm2PJi3OCKeLS1PiF/gE5Rw=; b=PoEF5B9P+RHzcKgkAyzK5NNrs1
	sV9u5BcTbFPn+WwXbpZLAlzLkkvQvsUWshMKZuhHRRqfc5MgoBIU8pqKFjNfwufqojFSey0Yl1BSN
	R4zgcchgzjjMpBWwDJ9zEp4nND7z0TnErH8EHY7554xKW4iTBmXgordhwW2+PuUdk/11MljZl3RCD
	wHggMRzcOOYfh6re5pbAFSgESHwpy9+Cz3a3mB+4QOH9RwtcCeQSHdzZqKYP9p18UI2XYw7bzVbyc
	J7tTzdvMt1zNv/teb46T0B3RtGmv9IQnmNJENi/egl4fNxQJg/5ZC6XJw2pQGBrqKB0xSao4kn/0N
	v27Zuo4g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZCls-00000005Gdg-0Fp5;
	Wed, 31 Jul 2024 17:05:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AFF54300820; Wed, 31 Jul 2024 19:05:51 +0200 (CEST)
Date: Wed, 31 Jul 2024 19:05:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, andrii@kernel.org, mhiramat@kernel.org,
	jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] uprobes: make uprobe_register() return struct
 uprobe *
Message-ID: <20240731170551.GK33588@noisy.programming.kicks-ass.net>
References: <20240729134444.GA12293@redhat.com>
 <20240729134535.GA12332@redhat.com>
 <CAEf4Bza1_njsVUad8so9EFxy8VmJsTfzaaAahBYFtOqdF1HAjA@mail.gmail.com>
 <20240731165614.GI33588@noisy.programming.kicks-ass.net>
 <CAEf4BzZXze8wRQwEJSy5nFzH=uk4wZPHY-gWw6j7iZfeBEiO0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZXze8wRQwEJSy5nFzH=uk4wZPHY-gWw6j7iZfeBEiO0g@mail.gmail.com>

On Wed, Jul 31, 2024 at 10:01:47AM -0700, Andrii Nakryiko wrote:
> On Wed, Jul 31, 2024 at 9:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Jul 31, 2024 at 09:18:00AM -0700, Andrii Nakryiko wrote:
> > > On Mon, Jul 29, 2024 at 6:45 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > > >
> > > > This way uprobe_unregister() and uprobe_apply() can use "struct uprobe *"
> > > > rather than inode + offset. This simplifies the code and allows to avoid
> > > > the unnecessary find_uprobe() + put_uprobe() in these functions.
> > > >
> > > > TODO: uprobe_unregister() still needs get_uprobe/put_uprobe to ensure that
> > > > this uprobe can't be freed before up_write(&uprobe->register_rwsem).
> > > >
> > > > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  include/linux/uprobes.h     | 15 +++++-----
> > > >  kernel/events/uprobes.c     | 56 +++++++++++++++----------------------
> > > >  kernel/trace/bpf_trace.c    | 25 ++++++++---------
> > > >  kernel/trace/trace_uprobe.c | 26 ++++++++---------
> > > >  4 files changed, 55 insertions(+), 67 deletions(-)
> > > >
> > >
> > > You'll need something like below to not break our bpf_testmod. And
> > > please send pull patch sets, not individually updated patches, it's a
> > > PITA to deal with. Thanks!
> >
> > Do I stuff this on top of Oleg's patch or do you want me to fold it in
> > one of them?
> 
> Please fold so we have better (potential) bisectability of BPF
> selftests, thanks!

Fold where, patch 5?
