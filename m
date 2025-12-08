Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB6531812C;
	Mon,  8 Dec 2025 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765178399; cv=none; b=rEjaSewWImqovGq0W8vHo0+YoXfwOUTKHCtgQf2m2jRjfZ+42Fqby+KdWn9iuFa2O4H886xa3Vjn8ctSwGK8jyfmf4jsh9l+aTu4SELxNrL3K/UiOViRwRr6WaBZygesV+nvaWus9cStHCapLfi2b4t2zxwakO97eMXTEja9cwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765178399; c=relaxed/simple;
	bh=9o3BrEm1VDHGtDidlZHe7Kv4vviEVWPLkbywRUuELO0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gv55WNIQ0RkWTaZxioIX873wWI28zHPi/v13wkbOCT5KBHQEM7VPlycH2e7BSQqb7zWlbuynH7lJq9Gc3xh+sxdWoI9xo6qHkVDlw7IZTFMDNYO/sDfMMY4ENJdO/Xg2Gs59fDZroWei4EIVBkAABAU0n+sa0y9dCF/slr/g19c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZydf0uL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZydf0uL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A7EC4CEF1;
	Mon,  8 Dec 2025 07:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765178398;
	bh=9o3BrEm1VDHGtDidlZHe7Kv4vviEVWPLkbywRUuELO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bZydf0uL5ye9BCcgPZpNQULCgDlGnb56NBnJxtCVttAGoka/21t9xOrRZ4dAW0N4K
	 PSsOUbf5spsHV3t5td6ZtHZQOFcJ+ZWfvNvtL2T4xmRBbKue5vqNI2XvI+lZ6R+MJ5
	 bJUC56v18Z2fTHQ/qn4xrFmqbiWbRTFUmMkwDVt66Mi+0BSpai1xIWZ6pG6Pm0ZMEL
	 naJojyOn7nlkXIi84xlIx5U2/0QQkiqrGbD3NudbMKAIXJYYNvHoDmg++0Vfiwpa/4
	 MiH+viiWVWFHoajtzbyw6tuPP8Gs+1A8RZAFp2il/Hy+95BmnKkxZrr/zWcZdl20D1
	 Qp/pthYqVfFHA==
Date: Mon, 8 Dec 2025 16:19:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: qingwei hu <huqingwei.kernel@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, davem@davemloft.net,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mhiramat@kernel.org, naveen@kernel.org, qingwei.hu@bytedance.com
Subject: Re: [PATCH] kprobes: Call check_ftrace_location() on
 CONFIG_KPROBES_ON_FTRACE
Message-Id: <20251208161955.54e2fef0fc793092a93ce88e@kernel.org>
In-Reply-To: <2E248E7C-773B-4998-B059-A576163B36B0@bytedance.com>
References: <20251205092933.3889547-1-qingwei.hu@bytedance.com>
	<20251205100823.28aa8ffd@gandalf.local.home>
	<2E248E7C-773B-4998-B059-A576163B36B0@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 8 Dec 2025 14:54:33 +0800
qingwei hu <huqingwei.kernel@gmail.com> wrote:

> 
> 
> > 2025年12月5日 23:08，Steven Rostedt <rostedt@goodmis.org> 写道：
> > 
> > On Fri,  5 Dec 2025 17:29:33 +0800
> > "qingwei.hu" <qingwei.hu@bytedance.com> wrote:
> > 
> >> From: Qingwei Hu <qingwei.hu@bytedance.com>
> >> 
> >> There is a possible configuration dependency:
> >> 
> >>  KPROBES_ON_FTRACE [=n]
> >>       ^----- KPROBES [=y]
> >>         |--- HAVE_KPROBES_ON_FTRACE [=n]
> >>         |--- DYNAMIC_FTRACE_WITH_REGS [=n]
> >>                ^----- FTRACE [=y]
> >>                  |--- DYNAMIC_FTRACE [=y]
> >>                  |--- HAVE_DYNAMIC_FTRACE_WITH_REGS [=n]
> >> 
> >> With DYNAMIC_FTRACE=y, ftrace_location() is meaningful and may
> >> return the same address as the probe target.
> >> 
> >> However, when KPROBES_ON_FTRACE=n, the current implementation
> >> returns -EINVAL after calling check_ftrace_location(), causing
> >> the validation to fail.
> > 
> > This is a feature not a bug.
> > 
> > The reason is if you put a kprobe on a ftrace location, it can cause ftrace
> > to trigger a bug, as kprobes will modify the location and ftrace will see
> > something it doesn't expect and think the system is corrupted. We don't want
> > that either.
> > 
> > If you say "KPROBES_ON_FTRACE=n" and place a kprobe on a location that is
> > controlled by ftrace, it had better fail!
> > 
> > NAK
> > 
> > -- Steve
> 
> Thanks for your clear explanation. I will look into other approaches
> that work with this configuration.
> 

Can you check the code under arch/<your machine>/ implements the
kprobe_ftrace_handler() correctly? if so, it should be enabled automatically.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
