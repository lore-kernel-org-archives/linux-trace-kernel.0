Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFCC25F967;
	Wed, 11 Jun 2025 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637575; cv=none; b=l5ExVKQ4ZDoHrmCL3jwig8zCxuWhwMk6QAs/DDEeR4F5cLOl6U8F2jsbOkmheb/3nkjJvbdxGoIG2J3PdfiPa3usLzhUtSExeGrw3vkRsEo7PyoiqYQDd1RX3i+ZOeqgv0RtYhoosTp7dOErDnnrzdV6PhM2ZX2ub3M/ap0MHZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637575; c=relaxed/simple;
	bh=+y7RDxNBQgieh91E0p6llbHjFkjykarWWIot+/gLf8Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fAM0+Ciz9K1rySJHqd9KKpz6BkHbzyrOAPCe1VkpisvEvJLPMcttThX5AiMRy5K8AVcZUUD5GXWoNPwzfCVUtWKFMmo96Ssv7VuRiSSsNyO7E2+oppKQa8b8XWxAWJ2Q6JEkU+9Zo6OhE10mv/Q3il61g5YHUInM4Xv7a2EJ1RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cp1DWkYp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp1DWkYp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92101C4CEF1;
	Wed, 11 Jun 2025 10:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749637574;
	bh=+y7RDxNBQgieh91E0p6llbHjFkjykarWWIot+/gLf8Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cp1DWkYptsuaZC/DfhiVQ1C6yfDl/DwyMIWoOpO8laP6dp910MGNxCcVUoxZkM6Dk
	 aYho9MXPnRHZyJjZ5PzDx9shPkWL8r6DOqTizXQN/OAfCYF6EBv1TMKPEJ6w46s/Ql
	 1vaZRULMhEHEVSmmHHMd6kB6COVWpW9yapj93z/eXy0Fws8kP9vuaGlceMKI328Hj4
	 e/9dld5D63aZimksx/4JHw08InBEu1p2OcgVmo+eax/29o/qd9c0GLI8DVXCQz5jBv
	 pAt3Y/nuOrF7f9kOYcreIrEPW7BTrm9roGjALwaNzEBsbTKiCk5q//MJgO56NBijYZ
	 XiGrbtNdzk8iA==
Date: Wed, 11 Jun 2025 19:26:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Naresh Kamboju
 <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd
 Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, Anders
 Roxell <anders.roxell@linaro.org>
Subject: Re: [RFC PATCH 2/2] x86: alternative: Invalidate the cache for
 updated instructions
Message-Id: <20250611192610.6edf9713f6ee84c26f653ea5@kernel.org>
In-Reply-To: <20250610115030.0d60da65@gandalf.local.home>
References: <20250610234307.c675969e83ce53bb856e94d7@kernel.org>
	<174956686826.1494782.11512582667456262594.stgit@mhiramat.tok.corp.google.com>
	<20250610115030.0d60da65@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 11:50:30 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 10 Jun 2025 23:47:48 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > Maybe one possible scenario is to hit the int3 after the third step
> > somehow (on I-cache).
> > 
> > ------
> > <CPU0>					<CPU1>
> > 					Start smp_text_poke_batch_finish().
> > 					Start the third step. (remove INT3)
> > 					on_each_cpu(do_sync_core)
> > do_sync_core(do SERIALIZE)
> > 					Finish the third step.
> > Hit INT3 (from I-cache)
> > 					Clear text_poke_array_refs[cpu0]
> > Start smp_text_poke_int3_handler()
> 
> I believe your analysis is the issue here. The commit that changed the ref
> counter from a global to per cpu didn't cause the issue, it just made the
> race window bigger.
> 

Ah, OK. It seems more easier to explain. Since we use the
trap gate for #BP, it does not clear the IF automatically.
Thus there is a time window between executing INT3 on icache
(or already in the pipeline) and its handler disables
interrupts. If the IPI is received in the time window,
this bug happens.

<CPU0>					<CPU1>
					Start smp_text_poke_batch_finish().
					Start the third step. (remove INT3)
Hit INT3 (from icache/pipeline)
					on_each_cpu(do_sync_core)
----
do_sync_core(do SERIALIZE)
----
					Finish the third step.
Handle #BP including CLI
					Clear text_poke_array_refs[cpu0]
preparing stack
Start smp_text_poke_int3_handler()
Failed to get text_poke_array_refs[cpu0]

In this case, per-cpu text_poke_array_refs will make a time
window bigger because clearing text_poke_array_refs is faster.

If this is correct, flushing cache does not matter (it
can make the window smaller.)

One possible solution is to send IPI again which ensures the
current #BP handler exits. It can make the window small enough.

Another solution is removing WARN_ONCE() from [1/2], which
means we accept this scenario, but avoid catastrophic result.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
