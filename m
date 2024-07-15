Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA727187868;
	Mon, 15 Jul 2024 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721044232; cv=none; b=EmQ48Gd9zqpAHUwqRROk7v8tlFAPUNHtgXnTlhtO2CEksSKf3EdAjzIedn7CdKnTaFqYEQrKUhMyaIWgaYE2817NZ1ljtsgXbYb8ZSR622W61opuAgcJzq65Heh/lL65Kvjw//YwTUxzU5uq2fVKUew1zgFjNJreNrdJdXqq578=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721044232; c=relaxed/simple;
	bh=6HktQveZYZY8xj7VM6lTXVzRe46Y/bY66m6VrxTkVvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdPstFJo+5vOj4+9Os7v2uAOCttn3XuDV6LVs7XnK49IbeYLuZZi9Gyr3Na0faQpFc/eLw96OT+VKXI9VjJrMbhRcCGqAS9r99KeXXgNIt23X6gUeABPeStuE6zg6VJ9g7EW5Pp4l110aN739/GU5cettBHaWpPhEgiVLZt0R74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jbSed8z8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jbSed8z8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IgLqbIYYbf5VaLN+RYs8iTvm9G3RYQZaYHEJtEaSwz4=; b=jbSed8z8U4eNPiMh9yUAukoX7C
	DvNVRfih/B79WBFOmvJxls1k8PXK+W8t6VZyqisRVTvici/2kL0dXupXMP/xInR8lq6zYpEJVx8jG
	YHiagrxD5YdqY6EjBJpr/qGgEdtKcPoqTmrGnif5iQqqXAVmbPXLMK0UQSyszkE3E0b/qhXYFupzs
	3ITb74NDInqIsN47QSEYGwGcmvmaXy5I1tzM7vkEI0559MGHOI/FtUEAplUJCdP+SQPwNSPcVdA+s
	zbz8yPU9LE7ZaKIw6CqtzDzzfzocLRdRsObZujhu4ilzoCUvw+xyn+13+HKisiqJfJ5b7vgf+ltDu
	67MPOu/Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTKDr-0000000FkoJ-2Fm1;
	Mon, 15 Jul 2024 11:50:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 322553003FF; Mon, 15 Jul 2024 13:50:27 +0200 (CEST)
Date: Mon, 15 Jul 2024 13:50:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, mingo@kernel.org, andrii@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add uprobes entry
Message-ID: <20240715115027.GG14400@noisy.programming.kicks-ass.net>
References: <172074397710.247544.17045299807723238107.stgit@devnote2>
 <20240715181417.6421de1e1a18a39685533115@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715181417.6421de1e1a18a39685533115@kernel.org>

On Mon, Jul 15, 2024 at 06:14:17PM +0900, Masami Hiramatsu wrote:
> Hi Peter, Oleg,
> 
> If this is OK for you, please give your Ack.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Please also collect Oleg's ack.

> 
> Thank you,
> 
> On Fri, 12 Jul 2024 09:26:17 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add uprobes entry to MAINTAINERS to clarify the maintainers.
> > 
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  MAINTAINERS |   13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index da5352dbd4f3..ae731fa2328c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -23105,6 +23105,19 @@ F:	drivers/mtd/ubi/
> >  F:	include/linux/mtd/ubi.h
> >  F:	include/uapi/mtd/ubi-user.h
> >  
> > +UPROBES
> > +M:	Masami Hiramatsu <mhiramat@kernel.org>
> > +M:	Oleg Nesterov <oleg@redhat.com>
> > +M:	Peter Zijlstra <peterz@infradead.org>
> > +L:	linux-kernel@vger.kernel.org
> > +L:	linux-trace-kernel@vger.kernel.org
> > +S:	Maintained
> > +F:	arch/*/include/asm/uprobes.h
> > +F:	arch/*/kernel/probes/uprobes.c
> > +F:	arch/*/kernel/uprobes.c
> > +F:	include/linux/uprobes.h
> > +F:	kernel/events/uprobes.c
> > +
> >  USB "USBNET" DRIVER FRAMEWORK
> >  M:	Oliver Neukum <oneukum@suse.com>
> >  L:	netdev@vger.kernel.org
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
