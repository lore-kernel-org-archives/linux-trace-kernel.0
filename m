Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E680B1D27B4;
	Tue, 19 Nov 2024 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039803; cv=none; b=b6IfSLyNrxIldvbb9TrwsX4pbfNRNzzvrUZmCPz54diSqCgJ+g5kwJL7HHvCHEP0/FUL4AHSBx+2n257wEDp5Rk/8KBQpjdOIRHddC/72seL2B8pd/CCwDgqqoiZ143E0hkReAI9DHCOa8s4W9SrZFTyuLqGuS6m5R6Key0vkxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039803; c=relaxed/simple;
	bh=cLTJ+4S41DbHMXwLJNlzcTSQqcxHabmps6W8J8gSRSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YfEf9X7NSlJRqbIF5et88Gu1P4gRzB4fpEdW6V1XF3twa9KEXXahWE8owsPmAGtI+VZK8GiA3VEeJlR/+d9Zfnn6R+LPSBv0W6Bl0azgz/PyT4BcvEP7v3IBNCsALumDdeE0kCn19axEaGgM0QwaDyxTWI+2qhxdQspvJc6VRUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923DDC4CECF;
	Tue, 19 Nov 2024 18:10:01 +0000 (UTC)
Date: Tue, 19 Nov 2024 13:10:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Geert Uytterhoeven
 <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>, Tomas Glozar
 <tglozar@redhat.com>
Subject: Re: [PATCH RFC 0/2] Add basic tracing support for m68k
Message-ID: <20241119131035.3c42a533@gandalf.local.home>
In-Reply-To: <e4456cb1-b1bc-453b-b3b5-3ee4f03995be@yoseli.org>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
	<3a8f6faa-62c6-4d32-b544-3fb7c00730d7@yoseli.org>
	<20241115102554.29232d34@gandalf.local.home>
	<cbb67ee2-8b37-4a4d-b542-f89ddae90e94@yoseli.org>
	<20241115145502.631c9a2c@gandalf.local.home>
	<2c43288a-517d-4220-ad31-f84dda8c1805@yoseli.org>
	<20241118152057.13042840@gandalf.local.home>
	<22856ed6-b9d0-4206-b88d-4226534c8675@yoseli.org>
	<20241119102631.76363f2a@gandalf.local.home>
	<20241119112850.219834f5@gandalf.local.home>
	<e4456cb1-b1bc-453b-b3b5-3ee4f03995be@yoseli.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Nov 2024 19:06:45 +0100
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:
> > 
> > It shouldn't crash, but it also found a bug in your code ;-)  
> 
> In my code is a really big assumption :-).

Well, not your personally, but I meant "your" as in m68k code.

> 
> > You reference two variables that are not part of the event:
> > 
> >   "mem_map" and "m68k_memory[0].addr"
> > 
> > Do these variables ever change? Because the TP_printk() part of the
> > TRACE_EVENT() macro is called a long time after the event is recorded. It
> > could be seconds, minutes, days or even months (and unlikely possibly
> > years) later.  
> 
> I am really not the best placed to answer.
> AFAIK, it sounds like those are never changing.

That would mean they are OK and will not corrupt the trace, but it will be
meaningless for tools like perf and trace-cmd.

> 
> > 
> > The event takes place and runs the TP_fast_assign() to record the event in
> > the ring buffer. Then some time later, when you read the "trace" file, the
> > TP_printk() portion gets run. If you wait months before reading that, it is
> > executed months later.
> > 
> > Now you have "mem_map" and "m68k_memory[0].addr" in that output that gets
> > run months after the fact. Are they constant throughout the boot?  
> 
> I don't know.
> 
> > Now another issue is that user space has no idea what those values are. Now
> > user space can not print the values. Currently the code crashes because you
> > are the first one to reference a global value from a trace event print fmt.
> > That should probably be fixed to simply fail to parse the event and ignore
> > the print format logic (which defaults to just printing the raw fields).  
> 
> The patch you sent works...
> But, it fails a bit later:
> Dispatching timerlat u procs
> starting loop
> User-space timerlat pid 230 on cpu 0
> Segmentation fault
> 

More printk? ;-)

-- Steve
