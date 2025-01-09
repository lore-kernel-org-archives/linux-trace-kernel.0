Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BBA2063E3;
	Thu,  9 Jan 2025 23:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736467078; cv=none; b=GqMH7djADL+Zwr6BXJMeR9YJVTxfNS0lKlffzoOllrTYwhyiu+rpvm43/CfbQ7qE2BgUh2r8z5YwT5+sYVUyds+GwkkszE4Eb65nNIOgjZ4vA2wQDu39dmxwPS3JDU1VVvFCarUHGFWp5Y70Ag2/nPlmAthiBoUKzi9blH8zYUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736467078; c=relaxed/simple;
	bh=0UYRA8SwSuwb3i2fwNPJN5XjuriDDMjD+Oh4921PTWw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qKFu7mxptPARLRCDpihIrAXJvOyAa5z3Um7vZ5t8i00cO0Bf10Fqkvv4q44i68EYf1P3GIY5x8ZiwlfejYaoNZRWyAQs7LAqB+W25ZwY3Y+OBZd+Y5FFf2BHoevGRqwy/6FBkzuLse7WfaUkHaZ1bS2KiOyScnfup23b4XQcTuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjVjAL1Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjVjAL1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D67C4CED2;
	Thu,  9 Jan 2025 23:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736467077;
	bh=0UYRA8SwSuwb3i2fwNPJN5XjuriDDMjD+Oh4921PTWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IjVjAL1QDRemMxZwFUJFFBgiEAewxmbhIFFYLDPGSDJE3s+LvT9Kmw+dOIPcs6rnC
	 heLZA+ydDbGhlk/kQaiJ9vMq+lsc/k71ZWVYEp9AGSAWB7tERMwaTug1Z+iheqegDe
	 wBQ/+4r1psSXojvDV0ID0wDwHNuSB5xoDNjubGEMvBWkiSC2kpp8lLQvkqiO37rY4k
	 E0RDn7WadHmbZoJLStWFPzRZ6iHsv4bQU7wkNy+cRoZcIwwHYt5tTM77igLqdEslQV
	 m7zo6Xk/VXeCn99EbdpknKf2K+zJFePToqJo78D+tYcRD5sTEF6xI3uiJP51zPDYz9
	 yriwwSFTAMqiQ==
Date: Fri, 10 Jan 2025 08:57:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/5] tracing: Adopt __free() and guard() for
 trace_fprobe.c
Message-Id: <20250110085752.7a9df6da26c6e63eeb890faf@kernel.org>
In-Reply-To: <20250109095607.15bfb6aa@gandalf.local.home>
References: <173643296599.1514810.1580554610685712071.stgit@devnote2>
	<173643302228.1514810.2053430844068447947.stgit@devnote2>
	<20250109095607.15bfb6aa@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jan 2025 09:56:07 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu,  9 Jan 2025 23:30:22 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Adopt __free() and guard() for trace_fprobe.c to remove gotos.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v6:
> >   - Rename trace_fprobe_create* functions.
> >   - Rename __free label for trace_fprobe.
> >   - Simplify the last part of trace_fprobe_create_internal().
> > ---
> >  kernel/trace/trace_fprobe.c |  130 ++++++++++++++++++++-----------------------
> >  1 file changed, 61 insertions(+), 69 deletions(-)
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks for review (and commented!)

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
