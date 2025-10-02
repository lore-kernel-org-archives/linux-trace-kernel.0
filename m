Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FEE30CDA4;
	Thu,  2 Oct 2025 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759413940; cv=none; b=QubY4HuaKsVLc4mFUDGC+6lmvTg1PCkiGXUfVzoTvLkx9pwE9dstIR7jxpe2blgoUKA68mKp39p3kUR1EegVkkMMzA8asSTXJ+FM7W3WWSlMkSOb4lwG0Fcq2ox7UxKLT9QRUTLe20ieIfkIbbt28i7wxdmvSGi48M18jimi8PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759413940; c=relaxed/simple;
	bh=w/6ukFnSIf3xFHi/LDem9ERkn1jLezN2X7IbgT7Mg98=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DkdIT9Ttx08kp2difXOkrjhOmBPo0KJrAl3mkQvSoAJ/ZtOkeXlb0KqjdF0TCGhgoyUJ5uL1KFAZSEM3/9oOOFCXc2YcMxtDlQ/AQzVduiFkhYW0IKB7CDd7TN+2LE7LilpFG0AHtiSuhYXnmhiJ+kjE3jZ8aGUZl9hq3FyYVQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1R9as0r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1R9as0r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA8FC4CEF4;
	Thu,  2 Oct 2025 14:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759413939;
	bh=w/6ukFnSIf3xFHi/LDem9ERkn1jLezN2X7IbgT7Mg98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s1R9as0rPJejr5crZ8buPFO9viDB/UW1/TKbHoovyjtGQ7Ta++SyOtnDBFBF4MM1D
	 D+GlwXKbpv39wKWkARYvagfHTxRbOW667IxWKTvR6hNn9VT4CBG9RfBpplSE2Q2n2K
	 6b9Lbxsfys+BjTmMHa3SwlHE+PhEgPigzk4vorX+2B9zcO8z2tSg9gFun+61YRXZMa
	 9QMkLyKSGxEVhsXrl0sprHNumxP6h+PvkRXdMkdYozhP+b+5J5c2LE23d2weh1XHcG
	 4aUN29vf3toEiaBpazhd01Gs91IYhgpquBX/kBVSLe0whmK/iQQXH4Pz07v+Z5tA1h
	 uod0rE7UnH0cw==
Date: Thu, 2 Oct 2025 23:05:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH] tracing: fprobe: Fix to init fprobe_ip_table earlier
Message-Id: <20251002230536.a0e15f3b016782c3bb9e5e9d@kernel.org>
In-Reply-To: <CADxym3Yvxs_Z6a1-EPziz79SBRsYHcaOH-CtvUhngYy3bJ71iA@mail.gmail.com>
References: <175939434403.3665022.13030530757238556332.stgit@mhiramat.tok.corp.google.com>
	<CADxym3Yvxs_Z6a1-EPziz79SBRsYHcaOH-CtvUhngYy3bJ71iA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 2 Oct 2025 18:00:24 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> On Thu, Oct 2, 2025 at 4:39 PM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Since the fprobe_ip_table is used from module unloading in
> > the failure path of load_module(), it must be initialized in
> > the earlier timing than late_initcall(). Unless that, the
> > fprobe_module_callback() will use an uninitialized spinlock of
> > fprobe_ip_table.
> >
> > Initialize fprobe_ip_table in core_initcall which is the same
> > timing as ftrace.
> >
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202509301440.be4b3631-lkp@intel.com
> 
> Don't we need a Fixes tag here?

OK, I'll add it too.

> 
> The other part of this patch is LGTM.
> 
> Reviewed-by: Menglong Dong <menglong8.dong@gmail.com>

Thank you!


> 
> Thanks!
> Menglong Dong
> 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/fprobe.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index 95e43814b85b..99d83c08b9e2 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -847,4 +847,4 @@ static int __init fprobe_initcall(void)
> >         rhltable_init(&fprobe_ip_table, &fprobe_rht_params);
> >         return 0;
> >  }
> > -late_initcall(fprobe_initcall);
> > +core_initcall(fprobe_initcall);
> >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
