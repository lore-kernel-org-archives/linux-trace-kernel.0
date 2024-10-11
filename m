Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D851EEE6;
	Fri, 11 Oct 2024 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728654845; cv=none; b=O4nZlsipWwilkSne32cG1tlDb6eBI3EWimp59HGvCzPeq1sdwmYA9IDTUy3QxZa5SU3Jy2mq8SeQX6o+cAclteztqTIH0mhXpt+dA5a1xjTjGI0znur7EzODRfDonNJy4Xkog8rEEspyFeqWebMIRGm9MjRP9glBtU4xNhD7/AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728654845; c=relaxed/simple;
	bh=Sv5FjeJB6rOyTDr/gWMgV6rvQD5TpxE2okDuINMJE1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcIYC65AuJxu01WvQ0Wm8E1B9KEwQC5yLqa8gOPw7u+OvfinGHvxegPsjDdeTReIRxGf3s+FtvOXO2uE4ZA6iD3XzJhyAgzwaSB1uBcmJj5gtoj5KGtamqUbJ0dy9XPH7izRC3mwAnklV/VoxLIO6FhDtQLyD3XzzjUo1Xt7aXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5007FC4CEC3;
	Fri, 11 Oct 2024 13:54:04 +0000 (UTC)
Date: Fri, 11 Oct 2024 09:54:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Suraj Sonawane <surajsonawane0215@gmail.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: fix WARNING document not included in any toctree
Message-ID: <20241011095413.0e57758f@gandalf.local.home>
In-Reply-To: <87h69izs3b.fsf@trenco.lwn.net>
References: <20241002195817.22972-1-surajsonawane0215@gmail.com>
	<20241010154708.0bf658a3@gandalf.local.home>
	<87y12vzqg0.fsf@trenco.lwn.net>
	<e7851def-91ce-43e7-880a-22dc5752c4ad@gmail.com>
	<87h69izs3b.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 07:28:40 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> Suraj Sonawane <surajsonawane0215@gmail.com> writes:
> 
> > Can I send an updated patch with this change (moving debugging section 
> > to the top)?  
> 
> The patch is already applied, so no.  You can send a new patch against
> docs-next if that sort of movement is warranted.
> 
> Honestly, though, just shuffling one file around only seems so useful.
> What would be nice would be to turn index.rst into a good starting point
> for people wanting to learn about tracing, rather than just a jumble of
> files.  It needs organization into sections and some connecting text; as
> an example, see the (minimal) organizational work that I did for
> Documentation/process/index.rst. 
> 
> It's more work, but would certainly pay off.

I'm still new to how the Documentation directory is set up. But I agree
with Jon. It's been on my todo list to make the tracing directory more of a
tutorial. I just need to find the time to do so.

-- Steve

