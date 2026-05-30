Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9441799F;
	Sat, 30 May 2026 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780148805; cv=none; b=A89KM//F2j377EDB851oiSzIvT+EJEnXu/xUbotfyLaAuOv8ZgXDofqUZt+YGhaHMcyoT9iCqBrSGkliNHm2TuZYMsbm/v5YLCQ1jvm9x25Y4Q0x83D71M07yC+ZDJBCvxK0ydruVyzqnIDWE46jfkvdN8sdNp5XFPk3sSY+3dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780148805; c=relaxed/simple;
	bh=7vy97Nw1auW3TRwhcZ5UGejrsgzN/Enn1bD2SOPa/SM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BIauGpzSujaAmTqfOEswPHsm3gXVQoBXLQUZTAdIOPCJnGehtPrtfwxKx/IB97ePlPnN0Fw06hqBXOKPQ7plW5bjqb/kvt++aS9BYTzPdPbu4coBvufWXQDj2zmLTSVj/nHG/1xfdcUl99z/ARrbxZp3pln1na7C/kDKvSx7d08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoL5DWjv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoL5DWjv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C41F1F00893;
	Sat, 30 May 2026 13:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780148804;
	bh=vImyCeKfsgeILX1MZc0y5+Hf1HuWGrdd4W6QYHLEb38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WoL5DWjvKIB24dRtHVT2+HpCQ+2txM8ucJAmeXJlGPTcvFg/l6IHmr4Di0dB16f5T
	 c5D9M/NZRJDjH1wISAg6nhrMXrprMkAJvF+j1hiYqs1mn7hhA9iEDIChTqOHmukVGA
	 aQcIwvP1AeYKtcSgep9xkudl5AmM8B1CHBMtLgtFrpG7bnadZFoqLG6X6xNA+4r1OB
	 odOcAizIojX17sybRny+1v2E7IhfqjnR9turIkv3fTTmSm/7aWA2K5qs1K90yxGPeU
	 0YI/zbdMu5YfxLd1XkNdlIeyJ2gs9HxZ0Xgi1FBaYKnatDXuPFCcd5RltmmC3CJex9
	 h3WHXmg0FbuRw==
Date: Sat, 30 May 2026 22:46:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tracing/probes: Point the error offset correctly for
 eprobe argument error
Message-Id: <20260530224639.49fada6cd098985a799d21e5@kernel.org>
In-Reply-To: <20260528222934.7d0b1881@fedora>
References: <177967567399.209006.1451571244515632097.stgit@devnote2>
	<20260528222934.7d0b1881@fedora>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 22:29:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 25 May 2026 11:21:14 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Fix to point the error offset correctly for eprobe argument error.
> > In the cleanup commit 1b8b0cd754cd ("tracing/probes: Move event parameter
> > fetching code to common parser"), due to incorrect backward compatibility
> > aimed at conforming to the test specifications, the error location was set
> > to 0 when a non-existent formal parameter was specified for Eprobe.
> > However, this should be corrected in both the test and the implementation
> > to point correct error position.
> > 
> > Fixes: 1b8b0cd754cd ("tracing/probes: Move event parameter fetching code to common parser")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
> 

Thanks! Let me pick this to probes/fixes branch.


> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
