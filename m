Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A553815F0;
	Fri, 10 Jul 2026 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710851; cv=none; b=kIQ3oGwGFduEv1eldF5/a++xqJxi5ePOeIfFNR/z1hfAmMc0dsD9SU6vUdDnof+rIRdBDPY2xg/hLiJbqLNGxllaIZfSc2nmL89hj/2QyhkRNeYoTtQ54r65UwxrsRHHMWbw0BsHjL2V3X+gHX37PMz5WMEvTudVZ0xoonCD5DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710851; c=relaxed/simple;
	bh=100S/dvlLVz4p4G++LneVn45QELJa3UerG7xWrUk7mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PmVlcbak5VgcWnuBQE/eUbOczQV6SsL8NCrq+1lDxWpLQw0NO3LizQce7O69ESx6xyjmI5e6TkPPZ7oC3B6j9twqqsrKQypvNnI81NZY1gDnd2jjOFB5rkltsaVJT4S7q67tqAt9vG5w3KMJjATcCjRdxyQVnBIEI9C4kgfKyd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id E29631C8C88;
	Fri, 10 Jul 2026 19:14:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id C7B986000A;
	Fri, 10 Jul 2026 19:14:05 +0000 (UTC)
Date: Fri, 10 Jul 2026 15:14:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Li Pengfei <ljdlns1987@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 mark.rutland@arm.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhangbo56@xiaomi.com, lipengfei28@xiaomi.com
Subject: Re: [RFC PATCH v4 0/3] trace: stack trace deduplication for ftrace
 ring buffer
Message-ID: <20260710151415.726a8c82@gandalf.local.home>
In-Reply-To: <20260706063154.1947674-1-lipengfei28@xiaomi.com>
References: <20260616064119.438063-1-lipengfei28@xiaomi.com>
	<20260706063154.1947674-1-lipengfei28@xiaomi.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: C7B986000A
X-Stat-Signature: 77d75e1qt5h5n87q6mxxu6ssyurcx4hg
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19g3eCGWomfAmc0thjoqp/ZFmQvBCDmU7I=
X-HE-Tag: 1783710845-904239
X-HE-Meta: U2FsdGVkX1+fAfT6kjfwIrmi59odxYDgkBCCIl5h3kiKYSMT8DU3maQCuq+SF4LSh2OrWSggL+vi0fEjQmeaC3BCju5DuHPcWLGQE+i2ne2PNUS3V2vzlHMKS1t1wmyou89seSrQ2SKDDyGfbBFEu9IfFtqJU2CqyzL5tdCE6fR2Rp/lx/MzEtxB86Z3MYRKZfjHr8MGCr0pabolWVikNnqMSPdukYYr3aRek9MyaJGOMYiQnuiZfpKbvF7lJxG89gqVDW+tzaRyAPEohbpoNQFjcqQJfNZ5fUr4021pviUOx/yCNVwtxR+Qz3vry/nxoFZoi1zZZzSZjSgzXW9ocKJmWdzyruMHdc8458JYFa5IhfRfH59nOs2JhcYJc8Hsd5lFbGwtUMI=

On Mon,  6 Jul 2026 14:31:54 +0800
Li Pengfei <ljdlns1987@gmail.com> wrote:

> From: Pengfei Li <lipengfei28@xiaomi.com>
> 
> Hi Steven, Masami,
> 
> Gentle ping on this v4 series now that the 7.2 merge window has settled.
> 
> I'd especially value a quick steer on the two design questions from the
> cover letter, since they shape how I respin:
> 
>   1. Eager vs lazy allocation of the element pool (~8 MB at the default
>      bits=14 when CONFIG_FTRACE_STACKMAP=y, whether or not userspace ever
>      enables the option). Is eager allocation acceptable, or should v5
>      switch to lazy allocation on the first 'echo 1 > options/stackmap'?
> 
>   2. Whether to introduce the stack_map_bin binary interface now, or ship
>      the text stack_map interface first and add the binary export once
>      trace-cmd / libtraceevent integration is designed.
> 
> Happy to respin in either direction. Full series for reference:
> 
>   https://lore.kernel.org/all/20260616064119.438063-1-lipengfei28@xiaomi.com/

Sorry for the late reply. I just started a new job (on 6/15) and spent the
first two weeks focused on that. I'm just catching up now.

Note, I tried out this patch set with function tracing on lock functions:

  trace-cmd start -p function -O stackmap --func-stack -l '*lock*'

And wow! it grows pretty quickly

  # cat /sys/kernel/tracing/stack_map | wc
 326593  708742 10979376

Anyway, I do like the idea and I may even use this to help do user space
stack traces. But I will have to take a deeper dive into it, which I will
hopefully have some time next week to do so. But if not next week, perhaps
within the next month.

I just letting you know that I'm not ignoring you. I'm just a bit behind.

Thanks,

-- Steve
