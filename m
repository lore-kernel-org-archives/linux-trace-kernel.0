Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF322874F6;
	Mon, 19 May 2025 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670920; cv=none; b=Y1Kz9PCQAOxAaV+aOe96xqp4s25leCfXODRtWI1zrHt5x1V6oeZW9H74Nvfm6KZAxII9NyerGeCjTP82RqBhF8eaHaJvzKl1sxxRaP7czzWdklLaM554mj11d5ly+Zpky+2NZJM7VZBuEE6oHLKLVviqStn2BhEqqr36Bk2zoD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670920; c=relaxed/simple;
	bh=RCO44d6yYh5Qwm3z6f4RJ3bS45d/xt9R+k+HBPiCdJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RcjPLT6SzNbUm4Rxz8B5Vww3HlCqLQ7V3K1PSzIU+jOtV7uy7nd3Mj6VJIQYF19Uh+IW0L9IjikNDhj+3k10Xpxp1tdfoLTepGg0OmqEzFshoJ7ndc615zikDsWJ8z5rgv1P4UU+wsGizsZjQvMPFvEP0fOs0zkbdYwFsZh/I4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93023C4CEE9;
	Mon, 19 May 2025 16:08:38 +0000 (UTC)
Date: Mon, 19 May 2025 12:08:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Will Deacon <will@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>, Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 17/22] arm64: mm: Add page fault trace points
Message-ID: <20250519120837.794f6738@batman.local.home>
In-Reply-To: <20250519151238.GB17177@willie-the-truck>
References: <cover.1745999587.git.namcao@linutronix.de>
	<554038c996662282df8a9d0482ef06f8d44fccc5.1745999587.git.namcao@linutronix.de>
	<20250516140449.GB13612@willie-the-truck>
	<3E29A42D-8A6A-4342-8C60-2BEF1EDCD640@goodmis.org>
	<20250519151238.GB17177@willie-the-truck>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 16:12:39 +0100
Will Deacon <will@kernel.org> wrote:

> > Perf events work for perf only. My question is why isn't this a tracepoint
> > that perf could hook into?  
> 
> Well, the perf event came first in this case, so we're stuck with it :/

I wonder what effort it will take to convert perf events to tracepoints ;-)

Note, I'm talking about tracepoints and not trace events, where the
latter is exposed to tracefs and the former is not.

> 
> I was hoping we could settle for a generic helper that could emit both
> the trace event and the perf event (so that the ordering of the two is
> portable across architectures) but, judging by Nam's reply, the trace
> event is needed before kprobes gets a look in.

Perhaps we could add a helper function that does both (perf and
tracepoint) and hide the implementation from the code that calls it?

But I'm currently still on PTO so I haven't looked at the details yet.

-- Steve
