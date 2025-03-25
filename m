Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C044A269B03;
	Tue, 25 Mar 2025 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742940615; cv=none; b=kR+tdqRTHX1YAGVa0I1AMbLsxs6DK5QmXSobFAw8Gs4tjgDAsFG1LaQ8CaDAv1rmmfW8uVjKvsgROkZ1MyTGczaSSZRYQXRmlWYK4o4a1xWjFaNDJd4dju41+wEhUz+8vDj5C1d/IiBQDRu3tPehpgdkFpIMxR8XOdxVUtl6lS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742940615; c=relaxed/simple;
	bh=wT4x+n5x6UsN8Uy+iI2Ioy+2sbSgRPmrV+sg1r0WxIA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GKQMxe443l8NTaeRqG4D2AY3mB9sR+gLqkZunDXByAZsKpWO6CL2NWEAZiTY7p+NJNPwKSmDMGqucuHmo96fKuObyqaM9XtXDpZSnU49KxGHAQbrngPwU1qiwTQD2AHZXLIuGGzHjr1VDf3ML1YNP0OQFwDjAN9c+wBVP6R90MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HN1xYoYU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HN1xYoYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4B5C4CEE4;
	Tue, 25 Mar 2025 22:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742940615;
	bh=wT4x+n5x6UsN8Uy+iI2Ioy+2sbSgRPmrV+sg1r0WxIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HN1xYoYUeup0jmzYo7eqpZu2tg61FK4ik0TH3XmrsCDT1sz44SVCv1oRYrrQ5/t9V
	 LpnffUxlhXqavPoWMPxMnaX8T+lh7qfQI/cD5AOhWhXo84Qh9fj6FjaLIRIJmMuyoO
	 wH7cutLCSa31E2Y2xxThqaom8EhSiGaXv4g7c05yr2Kdguynqe5oFYqz42PcN4tMBO
	 UueoLOrIbpN4/duGNsfeILl4YOrwLLoqG00HTysNCAUFX87FdJUtKCxOgPyO9mUY7L
	 GfuRPTqJxjdPE7vPoBPvpvl7148C/lWFgWJybyTQUnVSS8a0DduS8m4lxEXviMIF1e
	 tp20/eDWeW8rQ==
Date: Wed, 26 Mar 2025 07:10:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/1] tracing: Show last module text symbols in the
 stacktrace
Message-Id: <20250326071011.3c2c97ba3a441c1a5fca582f@kernel.org>
In-Reply-To: <20250325154955.5ed4fa33@gandalf.local.home>
References: <174282688292.356346.8368421078882769536.stgit@mhiramat.tok.corp.google.com>
	<174282689201.356346.17647540360450727687.stgit@mhiramat.tok.corp.google.com>
	<20250325154955.5ed4fa33@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 15:49:55 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 24 Mar 2025 23:34:52 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since the previous boot trace buffer can include module text address in
> > the stacktrace. As same as the kernel text address, convert the module
> > text address using the module address information.
> > 
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202503112205.joXgt8gR-lkp@intel.com/
> > Closes: https://lore.kernel.org/oe-kbuild-all/202503112303.D7g66VSd-lkp@intel.com/
> 
> FYI, You don't add "Reported-by" and "Closes" tags for kernel test robot
> reports for previous versions of a patch set.
> 
> It even says that in the report:
> 
>    If you fix the issue in a separate patch/commit (i.e. not just a new version of
>    the same patch/commit), kindly add following tags
>    | Reported-by: kernel test robot <lkp@intel.com>
>    | Closes: https://lore.kernel.org/oe-kbuild-all/202503112205.joXgt8gR-lkp@intel.com/
> 
> "not just a new version of the same patch/commit"

Ah, I got it. I missed that part.

Thanks!

> 
> 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v6:
> >   - Protect module_delta by RCU.
> >   - Make nop make_mod_delta() for CONFIG_MODULES=n.
> >   - Rebased on linux-trace/for-next.
> >  Changes in v4:
> >   - Move module_delta to trace_array again.
> >   - Use bsearch for lookup module_delta.
> >   - Revert the boolean logic to avoid '!',
> >   - Fix !CONFIG_MODULES compile errors.
> > ---
> >  kernel/trace/trace.c        |  133 +++++++++++++++++++++++++++++++++++++++++--
> >  kernel/trace/trace.h        |    8 +++
> >  kernel/trace/trace_output.c |    4 +
> >  3 files changed, 138 insertions(+), 7 deletions(-)
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
