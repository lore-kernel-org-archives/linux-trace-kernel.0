Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFA917557E;
	Mon, 19 Aug 2024 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083340; cv=none; b=HRWhtv/iBBKcq6sNn54QnY0u4FmssoVZphOeaZVZcMY3ZU/EcXT7GXbBWF5zwlDl5Hl1H1WYWfZ/nQJ634JUVw1KwWxAVKES23cs1fWYKC1K0pk5y2nB3A6oyUI98wQYtKMEFOX4LkpG9P0+Nm9U8fJ2zt67nh9ukC1xckQbN+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083340; c=relaxed/simple;
	bh=3R1EprVZAZi+ilfqaR9P5vzc2DX83xvyT0LOUkr+4qI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANXaskz8f8SJGgbI86xKabtw58GP5AbEIUFtQH4v5grfZsXcC4GzPuFG4VbeEGuYbqz3Yjn2QHGykvXKM7xqSfkHoGIZvKgGkX3nYaUrFNbuEBBspHt98OlAy00i3pdcsaBtpIHm2QifjrOKYJlwDvHTTwGhOoEf/TyL7tBrBiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DE3C4AF12;
	Mon, 19 Aug 2024 16:02:19 +0000 (UTC)
Date: Mon, 19 Aug 2024 12:02:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [BUG] tracing: dynamic ftrace selftest detected failures
Message-ID: <20240819120244.5657eb2f@gandalf.local.home>
In-Reply-To: <20240820005649.dd019cfa70a8955d91cf85a0@kernel.org>
References: <20240819171152.12f05e0ae5c9472004d1b00a@kernel.org>
	<20240819112902.11451fe8@gandalf.local.home>
	<20240820005649.dd019cfa70a8955d91cf85a0@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 00:56:49 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > 
> > We may need to add "noinline" or something to make sure those functions
> > don't get inlined for LTO.  
> 
> Yeah, we need such option at least for function call test.

Could you add the noinline, and if it fixes the issue send a patch?

Thanks,

-- Steve

