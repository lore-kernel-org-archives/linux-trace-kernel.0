Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF017D07C;
	Mon,  4 Mar 2024 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709596393; cv=none; b=HvnvZ+WYBP9LVBQv5u+71T4nLiEVhuowMSZi1MS097TDLWoqxAUR/Eo7n4GWDQFdyZ7rG4XsM+1CLxbg8gC27Hc2bbk8Gs5OqCrbOVNAV37STaRJe8YcZ9zkl8+kko+E1Jqq+GjsiXzCKx06UuF3rKHq280xQTuwwv7ahGyKFn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709596393; c=relaxed/simple;
	bh=oY2h2Y7/iDgNJjVVKrac1NOVyR5B4mT2/9/yP4Cs/mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfNm43NNwMN+CEiH97IFNyXfWi9SssC1kmS2h1fMsQascR7rshNeDIn/s3E1Np1CVntZEc9LKis0DYpVoL4Gs8wwId8FKI7QnZjqmvmjHLmcjYhB79ZDjIu68Ohu7EkMIJK8EaV1bWF7j+D57dDnfHs7Y4iL/FLUmb/AdgBHQWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0070AC433C7;
	Mon,  4 Mar 2024 23:53:11 +0000 (UTC)
Date: Mon, 4 Mar 2024 18:55:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [PATCH] tracing: Remove precision vsnprintf() check from print
 event
Message-ID: <20240304185500.3160ec20@gandalf.local.home>
In-Reply-To: <b3803989-8465-4656-8ca3-678a92f9a140@efficios.com>
References: <20240304174341.2a561d9f@gandalf.local.home>
	<b3803989-8465-4656-8ca3-678a92f9a140@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 18:23:41 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> It appears to currently be limited by
> 
> #define TRACE_SEQ_BUFFER_SIZE   (PAGE_SIZE * 2 - \
>          (sizeof(struct seq_buf) + sizeof(size_t) + sizeof(int)))
> 
> checked within tracing_mark_write().

Yeah, I can hard code this to 8K as it handles output of complete events,
that can dump a lot of data, and then limit the trace_marker writes to be 4K.

-- Steve
