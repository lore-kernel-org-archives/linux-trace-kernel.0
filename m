Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DE71A29A;
	Fri, 11 Jul 2025 01:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752198282; cv=none; b=bhMdMFysXQAYPvnrw3nrdKF6KTTJk6hSbXs7sH4rz/y8eRr4H2gxmDIRfazFdPeMViaAmP6RhIOPgOXNXb0vqrEsSF3BwwEfpWTlMEiIinwCsOsLFw/OP18lNtMLM+qS4WoVFCyyAXJKsUeyGEQyt7ZCgZ6AmqQma57p1QRAdQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752198282; c=relaxed/simple;
	bh=rpYWhR2CcuKDyjqvIZQHIeXBHouYEsSg8k1FGs3gZPE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XxIGBw4RlITLacol6ghnU9YJ/ZTsJKVLiqUelV6+8MntghrUvLsB2vLTCeZ9HarDIxOxwcpbj73+WNo4gmdcQRv0loJm06hDodb0sIplpzsrUHsVMatrmOY/I4n3EIwQxyXDB2EP7uzufHDpHpUahFHDu3Ns3tXBTo0zohfdv3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfVsw37Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfVsw37Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9894BC4CEE3;
	Fri, 11 Jul 2025 01:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752198281;
	bh=rpYWhR2CcuKDyjqvIZQHIeXBHouYEsSg8k1FGs3gZPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BfVsw37YLgWl4j1bj9gqriTIcCDVmezpAmkqb9vMwLmhMDHJp7jtGV2hjbK64BMAG
	 4V1a+LSBIEUXaE5RZ15G8xx8Rloc6o6gDZj9/JMbOneUaOspgfpxzYVWh2ETw0dYjA
	 L114WwUsSZ4jhxJj+fvFCIs9YN9oaY9oyBsoBmtS/MgWHU9mOY92SOfs+asnt8msV0
	 y4uGVCo0EhTvvFyXl1Y6qcap5axNn4pDeGkNWoyZ8bSplV+Kz/VS2cwtDGRzKQaZGj
	 cAN+dakCkKTsWbINIJcjTzU9U9+W2Trv3+i8SHeqiBBFmTT+uY25zgWqIUleZOuLGg
	 G+U3cP+Rg+J2w==
Date: Fri, 11 Jul 2025 10:44:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Remove "__attribute__()" from the type
 field of event format
Message-Id: <20250711104436.df72f612ad78f06ec96e63f7@kernel.org>
In-Reply-To: <20250710095327.69144489@batman.local.home>
References: <175197567999.977073.8989204607899013923.stgit@mhiramat.tok.corp.google.com>
	<175197568917.977073.2201559708302320631.stgit@mhiramat.tok.corp.google.com>
	<20250709131107.397a3278@batman.local.home>
	<20250710224520.4eaf514db761ecaaee9bc1e1@kernel.org>
	<20250710095327.69144489@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 09:53:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 10 Jul 2025 22:45:20 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > And it doesn't free after allocation because it only does the
> > > allocation for events that will never be freed. For modules, it
> > > registers the allocated string so it will be freed on unload.  
> > 
> > What happen if the tracepoint in module has the __attribute__?
> > (or enum etc?)
> 
> It adds the string to a linked list via add_str_to_module(). When the
> module is unloaded, it searches the link list "module_strings" for all
> the strings registered under that module and frees it.

OK, thanks for the clarification!

> 
> See trace_module_remove_events().

Let me check it.

Thanks!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
