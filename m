Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3312E24503E;
	Wed,  5 Mar 2025 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189673; cv=none; b=bLzJP/2DStn8i4c4ycuW0C3ycOdK7x8H0PEJC78YQibKDDzI2W2Aluvlh9sNJfcD3kOzu7/BXGuXzYhIFJ2ODa4uo0zbyeSgQyP8PibzsFB0DdRVKGFTho+ScXswz0vXI1Q5+CUbQmzyI0sMwDgPRum7opDWRvLjdC7Yz5xj/5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189673; c=relaxed/simple;
	bh=f5OV5c6HM0JnrDQ9qS5sHeItWaSeUzifZtx8IrBFMDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDEQDYuW/lBOcg1la1Q++DFfNrAexr/1n8qwy7mq2lmJIoDQa8XhU5q8RXqyDpP58Kayj40qBXkdAAZOziTw/moPfnvSAon6id00U2REZvRV3WTqmNhR+AvBX+rsbnazY9earPcgYJLHNKXYJuEBx6AqZqnnqST8FeCsgzJwm1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BD5C4CED1;
	Wed,  5 Mar 2025 15:47:51 +0000 (UTC)
Date: Wed, 5 Mar 2025 10:47:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Huang Shijie <shijie@os.amperecomputing.com>,
 patches@amperecomputing.com, cl@linux.com, yang@os.amperecomputing.com,
 peterz@infradead.org, jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH resend ] tracepoint: Print the function symbol when
 tracepoint_debug is set
Message-ID: <20250305104749.15e57b19@gandalf.local.home>
In-Reply-To: <f600edd0-8855-46af-98ec-1181db1f5dd4@efficios.com>
References: <20250305015505.14493-1-shijie@os.amperecomputing.com>
	<f600edd0-8855-46af-98ec-1181db1f5dd4@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 08:53:43 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2025-03-04 20:55, Huang Shijie wrote:
> > When tracepoint_debug is set, we may get the output in kernel log:
> >       [  380.013843] Probe 0 : 00000000f0d68cda
> > 
> > It is not readable, so change to print the function symbol.
> > After this patch, the output may becomes:
> >       [   54.930567] Probe 0 : perf_trace_sched_wakeup_template  
> 
> What would it print if the address is corrupted ?
> 
> Perhaps we could do like the backtrace code and print e.g.
> 
> [<00000000f0d68cda>] perf_trace_sched_wakeup_template+0xNN/0xMM
> 
> ?
> 
> I don't care about the actual layout, but removing the address
> from the formatted output appears to be removing useful data
> in debug situations.
> 

Perhaps this can use "%pS" which shows both the function entry and the
offset. If no function is found, it ends up being the same as "%p".
Also, it's likely that the "%p" is hashed here and one couldn't use it to
debug either.

-- Steve
