Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FF04A1D;
	Wed, 21 Aug 2024 00:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724199308; cv=none; b=LzmVnPzzfHfHjafvL2/nfzn/aaigeKE0UHzmt4UMdQFQhVOUn3Dg02aEZpdJJTU0/LNAXmfbddbHik+biHuQaGf3/1DXoS49pR93OFtGrKOK7TG32JIJ8Z37c03/9ao14cyMepCMglA0FdJb371JZJBVDjLKBXWWD4UtnDp5Nb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724199308; c=relaxed/simple;
	bh=b7WM2dNKgQVg9iGjT3xGNxwb+Ar/RpDBdfMEFg1mGc4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KV30oPfnou2aCGXpCdxqc5EyOzOhf3ktJU1y8NEiXaeKf9hRI+tdoKNmEA+Doq1xYf/I542ZHYawWKLsB/tlG7sOs78BwMidVvtSM8QtWbXnACs+ugnZsySdincJKn+NKNbOPNpZXpeTirw+Lt+Yzdmsc2B727soKH8sdhySCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouwIClGo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouwIClGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B32C4AF09;
	Wed, 21 Aug 2024 00:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724199308;
	bh=b7WM2dNKgQVg9iGjT3xGNxwb+Ar/RpDBdfMEFg1mGc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ouwIClGoJbgqkLnhVYVU7ymNkHLz1qIS4w8C+nXoWGtVz2ReYHsK5nyafgDSVN8mV
	 KyUpgvoqtfXZyB2k7s1kw5NNctFVvxOdPDSGj5+OlYGnTPi6ESMZ1Fv2N7MNNWme9e
	 OW2RAZY9CIKdXTY5cjND31CtGgrgjTOdJrhbGySwfUX6lPA3vBqFERNzbhxiSJn4q6
	 JUBp4lazOcdV759bk15UrS56qJ80aNueRwI3iF0O50AwWOFhqZvmvHNqgASQq/8s+s
	 iQnFM8mEU6BJIotV7PYiqpisBD/E8Hg2+DrkBT7QB4P1lDe89OYpXpGS/piMu5Izg+
	 LBbuy0sNdSP3g==
Date: Wed, 21 Aug 2024 09:15:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Mark Rutland
 <mark.rutland@arm.com>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kernel@vger.kernel.org,
 clang-built-linux <llvm@lists.linux.dev>, Nathan Chancellor
 <nathan@kernel.org>
Subject: Re: [BUG] tracing: dynamic ftrace selftest detected failures
Message-Id: <20240821091503.097e729cecb8560f8f51a646@kernel.org>
In-Reply-To: <20240820194914.2352a914@gandalf.local.home>
References: <20240819171152.12f05e0ae5c9472004d1b00a@kernel.org>
	<20240819112902.11451fe8@gandalf.local.home>
	<20240820005649.dd019cfa70a8955d91cf85a0@kernel.org>
	<20240819120244.5657eb2f@gandalf.local.home>
	<20240820100330.9ee6f3d51f22bb9bab7c4b83@kernel.org>
	<ZsR0Z6DxSHOI-wNj@J2N7QTR9R3>
	<CABCJKueKhDVarco4mgNeR0hkAhxDtxBjdpu=QaYVi+TGoiqd2g@mail.gmail.com>
	<20240821070539.981b42e5f3b939c5ce5e3a71@kernel.org>
	<20240820181109.4203158d@gandalf.local.home>
	<20240821084351.4b1c9d4d52b5aa7e07681d69@kernel.org>
	<20240820194914.2352a914@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 19:49:14 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 21 Aug 2024 08:43:51 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > Can you add the __used and see if it fixes it?  
> > 
> > Adding __used to DYN_FTRACE_TEST_NAME() and DYN_FTRACE_TEST_NAME2() does
> > not change, the test still fails.
> 
> OK, now that sounds like a bug in LTO itself.

Hmm, I think __used just preserve the function exists as a function. But the
callsite can be optimized. This mean the __used function code is duplicated,
and embedded one copy in the callsite, but keep another copy as a function
which can be used from outside. But "noinline" attribute seems to be expected
not embedded in the callsite (because that is what "inlined" mean), so it
looks like a bug.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
