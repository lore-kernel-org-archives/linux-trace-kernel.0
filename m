Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7326E36CDE1;
	Thu, 21 Aug 2025 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781181; cv=none; b=EImhD3EcX3M7xcZtOr8NAtx+FsLj4iiwxI1ynC3RLaS9WdlA4zRxwZEF3e6kzrtDUvbEPk9X1n7FzMC5sFOQ9AmRCrst1eOhcWHGSWofi8w2wZ1AdPrlt5ykqdtBRenpyj0vYvxTyUZxGSbP2lwXHoKEltfxixH0q7HzEwOhulg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781181; c=relaxed/simple;
	bh=71b6hgwbfDeSBSalaVlAEyTbwwEcR8fqw0NuU3fVyM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRmifBeYyFMaa3RFTqMB269FbjKm1M8enpbbvD3m4uIccD4vwnj250DGIgdMR8poH1h8sMfFiD76bUNV70ldP5m3NCH32nRYp2YGjfeM5nk8Pu6nHnbuU6ubt7EVTHtGX0GjajDBcQvOizQCpdxdSenjcsPoDtJRNpjZtFE9i64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grdbK7l3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grdbK7l3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE78DC4CEEB;
	Thu, 21 Aug 2025 12:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755781180;
	bh=71b6hgwbfDeSBSalaVlAEyTbwwEcR8fqw0NuU3fVyM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=grdbK7l3zLoQjKYHUjWWpt/ZJCDCwAih9CgW2vAxyCOdNpWtVBZZbQe9VrejGem93
	 pH1IaTEp9XaJslfLLQ1MLzwFcBGEBVuKmUqVx4Ort/dJAoGli5OCY3tW39bibNzDt8
	 4GhY32G0D3snqUVhT4JPTpL92jcQuUXYD4I0nzWKTescIQkcamkfA11/OppDmi5VHK
	 gFuWsUX3KlkQw8O1myLcoOVgEj2yYYD1rdwOp4aNtJHgsChR8eh5BKXclw6pejSy8U
	 /jjOFtj1M6LO461U9MkSOxZYfXqyf14deS30XPW85G59DbUsmCkgPlLn7jma7ODDGp
	 SZ2KKXLCsZ1AA==
Date: Thu, 21 Aug 2025 08:59:39 -0400
From: Sasha Levin <sashal@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] fgraph: Copy args in intermediate storage with entry
Message-ID: <aKcYO5xvRv3M0Ngf@laps>
References: <20250820195522.51d4a268@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250820195522.51d4a268@gandalf.local.home>

On Wed, Aug 20, 2025 at 07:55:22PM -0400, Steven Rostedt wrote:
>From: Steven Rostedt <rostedt@goodmis.org>
>
>The output of the function graph tracer has two ways to display its
>entries. One way for leaf functions with no events recorded within them,
>and the other is for functions with events recorded inside it. As function
>graph has an entry and exit event, to simplify the output of leaf
>functions it combines the two, where as non leaf functions are separate:
>
> 2)               |              invoke_rcu_core() {
> 2)               |                raise_softirq() {
> 2)   0.391 us    |                  __raise_softirq_irqoff();
> 2)   1.191 us    |                }
> 2)   2.086 us    |              }
>
>The __raise_softirq_irqoff() function above is really two events that were
>merged into one. Otherwise it would have looked like:
>
> 2)               |              invoke_rcu_core() {
> 2)               |                raise_softirq() {
> 2)               |                  __raise_softirq_irqoff() {
> 2)   0.391 us    |                  }
> 2)   1.191 us    |                }
> 2)   2.086 us    |              }
>
>In order to do this merge, the reading of the trace output file needs to
>look at the next event before printing. But since the pointer to the event
>is on the ring buffer, it needs to save the entry event before it looks at
>the next event as the next event goes out of focus as soon as a new event
>is read from the ring buffer. After it reads the next event, it will print
>the entry event with either the '{' (non leaf) or ';' and timestamps (leaf).
>
>The iterator used to read the trace file has storage for this event. The
>problem happens when the function graph tracer has arguments attached to
>the entry event as the entry now has a variable length "args" field. This
>field only gets set when funcargs option is used. But the args are not
>recorded in this temp data and garbage could be printed. The entry field
>is copied via:
>
>  data->ent = *curr;
>
>Where "curr" is the entry field. But this method only saves the non
>variable length fields from the structure.
>
>Add a helper structure to the iterator data that adds the max args size to
>the data storage in the iterator. Then simply copy the entire entry into
>this storage (with size protection).
>
>Reported-by: Sasha Levin <sashal@kernel.org>
>Closes: https://lore.kernel.org/all/aJaxRVKverIjF4a6@lappy/
>Fixes: ff5c9c576e75 ("ftrace: Add support for function argument to graph tracer")
>Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

	Tested-by: Sasha Levin <sashal@kernel.org>

Thanks for the fix!

-- 
Thanks,
Sasha
