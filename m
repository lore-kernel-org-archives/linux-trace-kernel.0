Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385DD19067C;
	Tue, 20 Aug 2024 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162176; cv=none; b=e/xPHT+CTEnAAhHHG61dxRwxZc1z8w6eVVsfPEqYWXpk59eKaPhFDsyCwDXyd8bkmQu2xhCT5iO5oq5ta/xbEFC6ymPRq89Rbo5nUYjYuGpMDpCzaUP8vWfe1eb/SIHnavsCiSvodzaUr2YxqKFzGMUYNwWlKC864sQjsx5Wt2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162176; c=relaxed/simple;
	bh=RofX8uJMXAhMRx/mQGA5JX2iXZa55j9cSx1hV2QqdnU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Abwhc0N14Q6+fZ/tQ64t4AaVy4vui96wrSAv/Ti0CqWlAhpsj0IYqf3zjukwry8RJrnIt/8HSssBTS1dcqGgCXBgAVzXp4vyJa5FyEE7+XIpSbn6zQgco7Wj/x1R1k2n95tnh1UuuEZLHS5jaS0bf/1ki+P5nMRHjvhvL0KsuHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288D2C4AF0F;
	Tue, 20 Aug 2024 13:56:15 +0000 (UTC)
Date: Tue, 20 Aug 2024 09:56:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] tracing: dynamic ftrace selftest detected failures
Message-ID: <20240820095641.1c74302f@gandalf.local.home>
In-Reply-To: <ZsR0Z6DxSHOI-wNj@J2N7QTR9R3>
References: <20240819171152.12f05e0ae5c9472004d1b00a@kernel.org>
	<20240819112902.11451fe8@gandalf.local.home>
	<20240820005649.dd019cfa70a8955d91cf85a0@kernel.org>
	<20240819120244.5657eb2f@gandalf.local.home>
	<20240820100330.9ee6f3d51f22bb9bab7c4b83@kernel.org>
	<ZsR0Z6DxSHOI-wNj@J2N7QTR9R3>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 11:48:07 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> > I found the target function already has "noinline". I tried to add noinline
> > to the testing function (callsite), but it also did not work.
> > I think "noinline" is for the compiler, but LTO is done by the linker.  
> 
> If LTO is breaking noinline, then that has much larger implications for
> noinstr code and similar, and means that LTO is unsound...

Hmm, doesn't noinstr place the code in a separate section?

I wonder if we create a separate section for the test function that LTO is
inlining, if it will prevent it from being inlined. That is, noinline tells
the compiler not to inline, but LTO happens after the compiler is done and
may inline functions in the same section. But the linker does see separate
sections and I don't think it will try to inline that code into another
section. But I could be wrong. ;-)

-- Steve
