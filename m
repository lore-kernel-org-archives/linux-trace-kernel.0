Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33A41798F;
	Wed, 15 Jan 2025 02:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736908142; cv=none; b=R6zbah40p6rvkf2xofGekm9XXPD3HJN9ocSUMxHwt5suFcgfkw1MzwZQsU/SreDOx2XVlCES37us7JXP+mQIumZDlRqo51iREg8fTC91ZXgFZinkyVlQR9kCivZP7i9Q2Zw+UdOdYYXvyrn0NaxR9O6xON5t4h293XFfDjO3Ci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736908142; c=relaxed/simple;
	bh=yFBzBINzJ0gWZwOodEJITf+EipeBLhft8x13zrSXOBo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NO6x1IPWtbOO8oZuK5U5eQ7y6DkF1pO+vLVdnqPFLMnZfPCNcYyWEtBwH/ZO9JcBwHThgl0DDEpE6OZ5qTUm/gvs6e8aJ5AMBexaQ8nd2DcnHZ1Auw5fkmKUsehqYlzOui/xDT3x9sM1Gwk8w4CBTdGoVB5vMeup/7jOmfiyW4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C223C4CEE3;
	Wed, 15 Jan 2025 02:29:01 +0000 (UTC)
Date: Tue, 14 Jan 2025 21:29:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/5] tracing: Adopt __free() and guard() for
 trace_fprobe.c
Message-ID: <20250114212902.2bb6381e@gandalf.local.home>
In-Reply-To: <173643302228.1514810.2053430844068447947.stgit@devnote2>
References: <173643296599.1514810.1580554610685712071.stgit@devnote2>
	<173643302228.1514810.2053430844068447947.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Jan 2025 23:30:22 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Adopt __free() and guard() for trace_fprobe.c to remove gotos.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v6:
>   - Rename trace_fprobe_create* functions.
>   - Rename __free label for trace_fprobe.
>   - Simplify the last part of trace_fprobe_create_internal().
> ---

This conflicts with the changes in my tree. The ones that I pulled in from
you that makes fprobes use function graph.

Care to rebase this patch on top of my ftrace/for-next branch?

Then we don't need to worry about the conflicts.

-- Steve
