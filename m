Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D655A265CA9;
	Fri, 14 Feb 2025 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739545172; cv=none; b=OT8scwV0SL0RQ0bpWZXkPVKUki+Q0FxPnBfz4GSwDSrXCmUbf7WJjBjX8PBUayFXh4vBxrTPZQ7PjaRBAKMQK0PGxN5R2EHGrQ1OEXXp+I1SDpGtjbpxCg95QjfkdWTFu4hNLMTwNZcO7lMsRjs6nD3qti942ntZiR6TIbO1278=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739545172; c=relaxed/simple;
	bh=Io4JQ0oyH1SJGJSnUwmUO6pwCZ69NxFTTQDXWqQj8HM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+MtyX5NKugpP3P4685SQMOJdq8shlti+r+HEcjkU0ZoXld8OB38dKax+KC3YIM6Yh39SlBGKekwHnpYIhRm/9LacZ4ALXTyRnOdWlNeHiS+dnevlSWwRNeEAQc6Zj7wXZEEtpUTXDfZpLv1jRCDoQiNXd9jWKIfULUD10nnEWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A95FC4CED1;
	Fri, 14 Feb 2025 14:59:31 +0000 (UTC)
Date: Fri, 14 Feb 2025 09:59:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH] tracing: Do not allow mmap() of persistent ring buffer
Message-ID: <20250214095943.178501fa@gandalf.local.home>
In-Reply-To: <20250214233613.bde0638f393186f56f0b30eb@kernel.org>
References: <20250213180737.061871ae@gandalf.local.home>
	<20250214110722.7eaf35b42c4858e6b74500f7@kernel.org>
	<20250213212147.6511b235@gandalf.local.home>
	<20250214161332.8797b20f09e068c33f872698@kernel.org>
	<20250214070712.01997ea1@gandalf.local.home>
	<20250214233613.bde0638f393186f56f0b30eb@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 23:36:13 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> > It's not supported. If you try it, it will crash. This prevents reading via
> > mmap() on a boot buffer. I don't know what you are asking. Once this patch
> > is applied, mmap() will always fail on the boot buffer before or after you
> > start it.  
> 
> Hmm, I meant it is supported for other non-persisten ring buffer, isn't it?

Correct. It is supported in other buffers, but it just isn't supported in
the persistent one.

This patch only disables mmap if it's trying to mmap a persistent one.

I guess I don't understand your concern.

-- Steve
