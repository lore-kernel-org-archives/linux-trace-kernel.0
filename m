Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EF624FC18;
	Wed,  5 Mar 2025 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188006; cv=none; b=PHZjG12k0Noj0VMmeD9ztDkK7KPpI6OE6nR8HquNYRoG/YBetqUlydRvmuYGfVrS+8U0itv+moSP1fKLCnsBt2PQ4VNvJIsag2Qb7ScCDpW1nyEdic1FuHYPQhLlyMckGQd0mUsX0r2jpHI+mUmoxz5+YFd868DF5Xgx09Tm63I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188006; c=relaxed/simple;
	bh=sNP+NNEDqcfz55fVq14lJl9O8BqjCihgzDa7tqzQcgw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUbyaYTaVmpJUPVyhIuPp0iqIti3Y/nt5x0J0WKwJJL7lLGj7rNeajB8Mn7gmOCFV1T/s/ncXJQZSpDEU2dA/amX8VcGluy+wbBS4nsXnFmkcT14gYGMNt3FpgWEodiEUaTdv8rrJ+A/OzRSuqIBki21ukYah5wHDyHdCy7nMBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F748C4CED1;
	Wed,  5 Mar 2025 15:20:04 +0000 (UTC)
Date: Wed, 5 Mar 2025 10:21:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org
Subject: Re: [PATCH v3 5/8] module: Add module_for_each_mod() function
Message-ID: <20250305102101.2178feab@gandalf.local.home>
In-Reply-To: <17c0cce7-03c7-488a-b61a-6c41d5bacfa1@suse.com>
References: <20250304012516.282694507@goodmis.org>
	<20250304012548.433669427@goodmis.org>
	<20250304095714.47a171fa@gandalf.local.home>
	<17c0cce7-03c7-488a-b61a-6c41d5bacfa1@suse.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 09:47:49 +0100
Petr Pavlu <petr.pavlu@suse.com> wrote:

> On 3/4/25 15:57, Steven Rostedt wrote:
> > 
> > Luis,
> > 
> > Can I get an Acked-by from you?
> > 
> > This follows the changes you have in linux-next.  
> 
> Hi Steven,
> 
> I'm not Luis, but we started rotating the modules maintenance every six
> months and I'm currently looking after the modules tree. I see Luis
> seemed ok with the change in the previous discussion and the patch looks
> reasonable to me.

Ah, you may want to update the MAINTAINERS file. Right now it has:

M:      Luis Chamberlain <mcgrof@kernel.org>
R:      Petr Pavlu <petr.pavlu@suse.com>
R:      Sami Tolvanen <samitolvanen@google.com>
R:      Daniel Gomez <da.gomez@samsung.com>

Which puts Luis as maintainer and you as a reviewer. If you rotate
maintainerships, you should update that to have an M: next to all that are
in that rotation.

> 
> Acked-by: Petr Pavlu <petr.pavlu@suse.com>
> 

Appreciate it.

-- Steve

