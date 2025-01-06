Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31EB8C1E;
	Mon,  6 Jan 2025 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736194876; cv=none; b=sTKOz1WHzjdEIn6oRf20FfEaW9NHHOanraQceYk9VcmAWeBS29ffVi3yow23nTilEa8DCgRZNNZNACHVByKgoGJObqvC3izE/9DcuyE4shSefSieN+neFoncJ43LTq/0rjJfZXQeQOWPrdChaS5LikN7BL+KvBc2Dl9nhm8gIr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736194876; c=relaxed/simple;
	bh=KNwZcmcQBZFXTDqYI8YaUMrN9FmZ/5D73q+fkRZ78Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBEJgQki0+8MG+c/XqRPi2zVYGIeXyPpQRpepGBCWdfBcfSI0U1pkPGqbrnffEffyLFWThrQwct88rrbH6QIj2lqK10EV23RgXejt7lUh5hjvOMbYoV0Swi7C4FuCU5nNoTYmsAr3Irf9AJ6kMhbNWC4B+SqhRHI+M3y3vvXt2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD7DC4CED6;
	Mon,  6 Jan 2025 20:21:14 +0000 (UTC)
Date: Mon, 6 Jan 2025 15:22:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: WangYuli <wangyuli@uniontech.com>, mark.rutland@arm.com,
 tsbogend@alpha.franken.de, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 xzhong86@163.com, wuzhangjin@gmail.com, srostedt@redhat.com,
 linux-mips@linux-mips.org, ralf@duck.linux-mips.net, jeffbai@aosc.io,
 zhanjun@uniontech.com, guanwentao@uniontech.com, jiaxun.yang@flygoat.com,
 gregory.clement@bootlin.com, philmd@linaro.org, tglx@linutronix.de,
 rppt@kernel.org
Subject: Re: [RESEND PATCH] MIPS: ftrace: Declare
 ftrace_get_parent_ra_addr() as static
Message-ID: <20250106152240.7e2220bc@gandalf.local.home>
In-Reply-To: <20250105173747.3859102eeabed7ffba8cbc07@kernel.org>
References: <527F9AFF0430AB45+20250104144708.18438-1-wangyuli@uniontech.com>
	<20250105173747.3859102eeabed7ffba8cbc07@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 5 Jan 2025 17:37:47 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Sat,  4 Jan 2025 22:47:08 +0800
> WangYuli <wangyuli@uniontech.com> wrote:
> 
> > Declare ftrace_get_parent_ra_addr() as static to suppress clang
> > compiler warning that 'no previous prototype'. This function is
> > not intended to be called from other parts.
> > 
> > Fix follow error with clang-19:
> > 
> > arch/mips/kernel/ftrace.c:251:15: error: no previous prototype for function 'ftrace_get_parent_ra_addr' [-Werror,-Wmissing-prototypes]
> >   251 | unsigned long ftrace_get_parent_ra_addr(unsigned long self_ra, unsigned long
> >       |               ^
> > arch/mips/kernel/ftrace.c:251:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> >   251 | unsigned long ftrace_get_parent_ra_addr(unsigned long self_ra, unsigned long
> >       | ^
> >       | static
> > 1 error generated.  
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

Note, this should go through the MIPS tree.

-- Steve
