Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FA84779F;
	Mon, 19 Aug 2024 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083013; cv=none; b=ICAuIvXahRwwbayulH1KzqfOhh/LxnlFwHbRTWgD4owVOgvkPOhXcj3cAWnww44Vh4P7M9B/bYGVaJmywR/i3jOfBmg1F1sYSAfY4rBaCT3g6zros5Td13p70cjrSdqVDIH+GPL/DGF/K4/ChiqLalmDSJ/P9RJmptmb4XsDX2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083013; c=relaxed/simple;
	bh=BS6XawxXgYg+cRvcYiNoodcCmziXBlmGLjtuiRHyHB4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fHyVfvV6GIwVmgdqyMzhAx58mb0GKc8aH0PjqLXk1WCrlb9Xhm1jDCyePo17dUU5jqx2kVWt5tzk+FFNKdstTmeeE0EKm6NB/E66ryHNQesFM6fMvK9GfGActuosME0xIiPsnaREMZojkMzSK6JhKyl/+3ajP8qGStKRp6T8fps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oozbnefi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oozbnefi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DC3C32782;
	Mon, 19 Aug 2024 15:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724083013;
	bh=BS6XawxXgYg+cRvcYiNoodcCmziXBlmGLjtuiRHyHB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oozbnefixlKxGyn1RN5XcpyDjXcVYNPjYcChr0ypBJmhICdXtrvDA6Wr+IaRQ/Wmt
	 7inZ7G18mc5ar2PGFKRO5FZktRToRFmJ9X3RDMzE1Cf0c0BlxpISQufNtRdWfepVIC
	 cINJMwvBrqPNjPWWZkamJukZmQ1ghNKAWXQ2y4LnkThAQyjdoS5hMKHTLfO2/q1WL2
	 TARrC1wriZEuMvpG4fW9qAWROMnb3XPnstBYX5cG5WXO8/W1oAY0/bRBz7/m/uWN6y
	 5LQrrbIjYL/OIDlht35cwBX6zPxKyRPcUxxUNTMjG4Y0lujb0oSYmpA6R4hFYMz/YO
	 udNyjqna77sHg==
Date: Tue, 20 Aug 2024 00:56:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [BUG] tracing: dynamic ftrace selftest detected failures
Message-Id: <20240820005649.dd019cfa70a8955d91cf85a0@kernel.org>
In-Reply-To: <20240819112902.11451fe8@gandalf.local.home>
References: <20240819171152.12f05e0ae5c9472004d1b00a@kernel.org>
	<20240819112902.11451fe8@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 11:29:02 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 19 Aug 2024 17:11:52 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > CONFIG_LTO=y
> > CONFIG_LTO_CLANG=y
> 
> Hi Masami,
> 
> Does it still fail if you disable the above?

No, I found that caused these failure.

> I wonder if that causes functions to not be part of the available filter
> functions that the ftrace filter test is using :-/

Ah, LTO optimized the target function call... (same as ftrace-direct example)

> 
> We may need to add "noinline" or something to make sure those functions
> don't get inlined for LTO.

Yeah, we need such option at least for function call test.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
