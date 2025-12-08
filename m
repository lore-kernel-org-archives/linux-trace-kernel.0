Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9522E9EAD;
	Mon,  8 Dec 2025 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765222583; cv=none; b=W4BJ7AweN4vzkLtK4tDmYVcIeUfeylBc2fyC1vYoFVrbwA3FyuhGPWkCCaBdaq5f38QYzCzYoUX1ppHOBEiRfbCEsn0S2W/CSSvox83FfE3MzdmImmtQZ6lv2K24sG+mccaZscNxypzvC0euzlcp+feUV7keRTfgvmHRntJZwIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765222583; c=relaxed/simple;
	bh=4mgcZSG+fTWENNiQ+FgCPTtYAfg/59Iuq9795OGWGbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZdHxa86Cxf/g5DxqKXVex0T7ORvjP2/9xlr0O7ve6HcPuXSGhuIhQD1YjzDSpDeQ6UklP3Xs+fB6UpYY8TFhKNnNjbQYmDYCBh9kX2oh5wT7JCxdaig1QXwebiZBA1iPtLSSYKQq7cQsHI3be3BgAIlR0o8VgzjPtPWIGFyo6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oxbllLc/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oxbllLc/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YaXx4ZqIO5Fq9QOT2VoH9tUUXqDWc6URCT+EeEyJ+bM=; b=oxbllLc/620LwOkqrRp788ugrN
	BJoURwbzQongXo4N8WpNmO3GAKgupzd2eAYGbUhF5El5IWg4+Asax/jidQtJ9zlHIC6XjnQ8ZI2u/
	wiZ0sz6RV556znLkm0Ykx8/CZWWaV1tM7jDiZyw6dwmFJ/fBUzsYyUT3lOSeO8QCa3HBUmv+fTYA3
	S2wQ7/H/Pu3vKHwtmUT3ZZqM1ByCmUkYg8yaw2rohyhQKm3SMHUOpNg86WTpBVtAMgkHAK5PvadgN
	pEsL+xFALO7zTLs+IkJ74kVDQu7CFKKjzbJjySBX5HctQYCTkH7uaDnoyMuwKDzIs/DYxZ7cSgcE7
	oQLnTRWg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSh1j-0000000AAqZ-037W;
	Mon, 08 Dec 2025 19:36:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F243330306F; Mon, 08 Dec 2025 20:36:05 +0100 (CET)
Date: Mon, 8 Dec 2025 20:36:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Steven Rostedt <rostedt@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 0/4] unwind_user: Cleanups
Message-ID: <20251208193605.GG3707891@noisy.programming.kicks-ass.net>
References: <20251208160352.1363040-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208160352.1363040-1-jremus@linux.ibm.com>

On Mon, Dec 08, 2025 at 05:03:48PM +0100, Jens Remus wrote:
> This patch series applies on top of Peter Zijlstras' latest unwind user
> enhancements (and perf deferred callchain support) on his tip perf/core
> branch:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
> 
> Which has already been merged to tip/master and linux-next/master.

Right, that should be empty now :-)


> Jens Remus (4):
>   unwind_user: Enhance comments on get CFA, FP, and RA
>   unwind_user/fp: Use dummies instead of ifdef
>   x86/unwind_user: Guard unwind_user_word_size() by UNWIND_USER
>   x86/unwind_user: Simplify unwind_user_word_size()
> 
>  arch/x86/include/asm/unwind_user.h | 27 ++++++++++++++-------------
>  include/linux/unwind_user.h        | 18 ++++++++++++++++--
>  kernel/unwind/user.c               | 12 ++++--------
>  3 files changed, 34 insertions(+), 23 deletions(-)

I'll go stick these patches in tip/perf/core after rc1 or so, no real
hurry with these, right?
