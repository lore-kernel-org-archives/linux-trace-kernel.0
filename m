Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A3B3EC2C7;
	Tue, 31 Mar 2026 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949054; cv=none; b=YGa/X34gWk4UebCAbpi7Lp2YFodzbSsQ8RrJGCOZKcDTrawiSX51TJaCalhwXqaEWRUmcWVfyZk2sKp1RRsXDjl4rDaxXDIwUH1UwxW35/1DecXWU9vcWEjQXHxPEZRqGuoU5iT8VbOmMWH0e84/UTfpi615AjnIyytktiDP0Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949054; c=relaxed/simple;
	bh=aQ1rinq+2CJOz/dRHBf7uxjWsiZK7071iwnGHfcl5gM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mLYagHY6zVAXGFNFi7RgGlg/x/IgTuleU+9wGrM/rcRmFkM4vaUc63ClfpNan+CO+M9ZZ4f0mbw1GeSW+cTlJxFwAfJyBksbal+bXwKT8mWuucU+Cz5lwGR5AOOt+g+u6QnH6mQ9Xq8smlTxZdJtnV2G8eMXe+KHu0RMbIi2JmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlGIwlzQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlGIwlzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB44FC19423;
	Tue, 31 Mar 2026 09:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774949054;
	bh=aQ1rinq+2CJOz/dRHBf7uxjWsiZK7071iwnGHfcl5gM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RlGIwlzQREm9CuwtYQSAy9Q7KriSrd9ruX4mhahzHul3hI2cwDc8DZXyID7T//R4l
	 l8TRhaIIBxHbBI+u6FHldan1rhDXPoMaGjfQguiNwASFIEEZ1ZdatBQC83/StmYchS
	 npWjmWg6IWWbDQxk29cfBCYorFmzHtlbEZg41/CMmBGGB7TySfYYrvra7VS2nBGguo
	 qy/FpB6EqjseSRUuVs4Hy+WcoW7J2+g5vzn+GZCOuufERiAfd0ZLViRteaO2NcKlTO
	 f61w3GTykw/Gp8+tLBjh3/XqhqIOyva3BM40RkP4NCRy3YdXOT/mWwpgZD0K7Kci2+
	 TbSCyiP5EeSyg==
Date: Tue, 31 Mar 2026 18:24:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] tracefs: Check file permission even if user has
 CAP_DAC_OVERRIDE
Message-Id: <20260331182412.5898957ab996dc36d57842e4@kernel.org>
In-Reply-To: <20260305123314.41ab284d@gandalf.local.home>
References: <177071300558.2293046.12057922262682243630.stgit@mhiramat.tok.corp.google.com>
	<177071303130.2293046.2400906233143699263.stgit@mhiramat.tok.corp.google.com>
	<20260211104623.73fd4fc3@fedora>
	<20260212151515.b384ac24de9b736d10387d21@kernel.org>
	<20260305123314.41ab284d@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Mar 2026 12:33:14 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 12 Feb 2026 15:15:15 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > With this still not working this late in the game, it will need to wait
> > > until the next merge window. I'll take the first two patches of this
> > > series now though.  
> > 
> > OK. I will send the next version without the first 2 patches.
> 
> Hi Masami,
> 
> Did you send a new version of this yet?

Oops, I missed this reply. Let me update it.

Thanks,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
