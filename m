Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B910713B7AE;
	Mon,  1 Sep 2025 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756742482; cv=none; b=TPlHMaSnNUe6BIkQAlgQEOnbH4spAA6PHCkdpwz8MPH77QEkjmQIJzHWuL4MsHPDQd+e1Vzchok8JFQ49TomcUlJ5b3Ene0fRX+cIDn2+IdOTNS+Lpr8hQW/vep9uGoATwHr9fG0MO3b6yY0oAS5dxs7rzk2g70CDcLsf52kez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756742482; c=relaxed/simple;
	bh=fQrRra8bEfuqcrTWzDBgXbZl6usAWaGI/BYxHkcaEX4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iqITHSmdOiIxSqHWFLgLJdBTpJN1okj/i50sqqaHsTg1vXv98zZnNKr7QE/CThpTvf5YWXsvJQ9d+L4JlkKy0bPJcn6cNvBPl8jYE5Guw2rdcGzOh8cT5R80Ikj48k8nl3nqd1lvJZdQ8/WbYpGJmXCD1R39+M5AseDapCyUUAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RN8JwpVp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RN8JwpVp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8BEC4CEF0;
	Mon,  1 Sep 2025 16:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756742480;
	bh=fQrRra8bEfuqcrTWzDBgXbZl6usAWaGI/BYxHkcaEX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RN8JwpVpmStxLHZa6f+4Buk+WRFPunyEzr4bt7PRE+cOGMbx8hwdtvpjTIko9mhqJ
	 xHnYCYG0ohHVf5B7VyWz5VXZ2jVZp+80P7CYhkqRuQxCMRe3XM2/s5mRyiAFu01SUZ
	 qpZpJq2gCcVQu20f35por/+EgC7JqmDUlu0x6dQG9CVJUpRr7tDU1uF7nOD9sAAVft
	 hMr3C2FxyG1TWOjTIVDZorlWLe6VOCdyCQHzF7WMBDisPFA03g4I+Y2ncCD3Tq0pf6
	 yHouBlFpSCnm6auYHEnX+JSMl675akoy+8QvXWzDQf5rj+U3R2ZfFS58/24HFZvg5J
	 yVxG5WdbOR0rQ==
Date: Tue, 2 Sep 2025 01:01:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Luo Gengkun
 <luogengkun@huaweicloud.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
 Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] tracing: Fix tracing_marker may trigger page fault
 during preempt_disable
Message-Id: <20250902010115.e20bb3beb9341aa5cb651009@kernel.org>
In-Reply-To: <20250829181311.079f33bf@gandalf.local.home>
References: <20250819105152.2766363-1-luogengkun@huaweicloud.com>
	<20250819135008.5f1ba00e@gandalf.local.home>
	<436e4fa7-f8c7-4c23-a28a-4e5eebe2f854@huaweicloud.com>
	<20250829082604.1e3fd06e@gandalf.local.home>
	<20250829083655.3d38d02b@gandalf.local.home>
	<aLIFRHcsEo2e2GE7@arm.com>
	<20250829181311.079f33bf@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 18:13:11 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 29 Aug 2025 20:53:40 +0100
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> valid user address.
> > 
> > BTW, arm64 also bails out early in do_page_fault() if in_atomic() but I
> > suspect that's not the case here.
> > 
> > Adding Al Viro since since he wrote a large part of uaccess.h.
> > 
> 
> So, __copy_from_user_inatomic() is supposed to be called if
> pagefault_disable() has already been called? If this is the case, can we
> add more comments to this code? I've been using the inatomic() version this
> way in preempt disabled locations since 2016.

Ah, OK. it is internal version... plz ignore my previous mail.

Thanks,

> 
> Looks like it needs to be converted to copy_from_user_nofault().
> 
> Luo, this version of the patch looks legit, no need for a v2.
> 
> I just wanted to figure out why __copy_from_user_inatomic() wasn't atomic.
> If anything, it needs to be better documented.
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
