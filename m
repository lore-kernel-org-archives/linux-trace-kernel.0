Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB2219923C;
	Thu, 28 Nov 2024 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732812749; cv=none; b=U4TUgDFcHkItZpY8ADcAC4BY2Whh4TtwrGSOg6oX0mfzUfFxYBnm9dXBkECiJK6vYZPCAVxUFlSeSJH8Y22JsZWeFQY7PqLIrfOVauaXV1pvhv/kjvWL382mg5PG6OIRTVjGiKCTYhgQj9N6dX7FgEPd0W7aEcAQfPPbG5aE7vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732812749; c=relaxed/simple;
	bh=0A6BERd5DzHd7gVbQWNnQ5BgLD5rAxu2Y/abYO2wfcc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kx3Oy5M5+GPGTfFkQJqdIMRCAftFr01KpaMRoUEkkbtRF+7gBZvp9GxQKg26nCnU5B/SliA/A4crUK+fm0xFDl9oryaqQI/8YYFmdSWuVfooykC9wgyGz+Fvs984f/uAFD+2T7Q7QzdNGZKYCG6CdMhyun8EtA0BjNWSvTxUbxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21ECC4CECE;
	Thu, 28 Nov 2024 16:52:27 +0000 (UTC)
Date: Thu, 28 Nov 2024 11:52:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tao Chen <chen.dylane@gmail.com>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Add WARN_ON_ONCE for syscall_nr check
Message-ID: <20241128115226.504e7563@rorschach.local.home>
In-Reply-To: <67b5a0d7-95a2-46d2-bb4a-69a4368abe3d@efficios.com>
References: <20241128115319.305523-1-chen.dylane@gmail.com>
	<20241128074623.063bf253@rorschach.local.home>
	<8d4796dc-ef5b-43d8-8ec0-3891b7994428@gmail.com>
	<20241128100324.05bc4c32@gandalf.local.home>
	<67b5a0d7-95a2-46d2-bb4a-69a4368abe3d@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Nov 2024 11:02:31 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > A better solution is for there to be a return code or something where the
> > tracers (perf or ftrace) can record in the trace that the system call is
> > not supported.  
> 
> Just be careful not to spam the traces uselessly. E.g. if only the
> openat syscall is enabled, you'd only want to be made aware of the
> ia32 openat, not all ia32 syscalls.

Why not? If you ask to trace something that isn't able to be traced,
add something in the buffer. It's not totally useless information. If
anything, you know that a task is making ia32 system calls, and how
many and when they are doing so.

Why make it more complex than it has to be. To do it only once, you
need to add the accounting logic to make sure each trace gets notified
about it. Not to mention if the event gets dropped.

If the user doesn't want this in their buffer, then they should filter
it out.

-- Steve
