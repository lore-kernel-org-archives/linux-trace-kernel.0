Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31472B644;
	Wed,  8 Jan 2025 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348983; cv=none; b=AezMeOSOEuALflenbxZ8Z8JBI9epHIrLvAhadnA6vdCQgq8GEGfhaQZLb89LaKQZoAbEeuT3F69YCWeQMFqabEQ8CFRvd2fi4zGxTwYg4T15MI6Zldsid3oKew5X4kQ8P5CAcGyW9VO/EcIjIgKaRVT7zuHLf7cnL/kWc9bccac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348983; c=relaxed/simple;
	bh=JF9aBYWtgNuf75U7Sms3WeXUkbwwyY+q+ykgzxQ6VcM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+GUSnb1iKYDOmhjyV2w64Kh1gO1FmZs6sMt4E/zkgbDeGOkRPHXZULe5ZhoWm49/EGcuzld80FFUvAYsQ0qvt/hlZgCsHpicTVtBH77jAJNvgnzoFn6MIk4lyMnxH1Qn7JfdOj4IQ4Vw+m7kAQzKs+jwqhAGoqEr4jJaP/1H0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04E1C4CEDD;
	Wed,  8 Jan 2025 15:09:40 +0000 (UTC)
Date: Wed, 8 Jan 2025 10:11:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] tracing/kprobes: Simplify
 __trace_kprobe_create() by removing gotos
Message-ID: <20250108101111.11dd98d8@gandalf.local.home>
In-Reply-To: <173630227845.1453474.6513848165385480817.stgit@devnote2>
References: <173630223453.1453474.6442447279377996686.stgit@devnote2>
	<173630227845.1453474.6513848165385480817.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Jan 2025 11:11:18 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> -static int __trace_kprobe_create(int argc, const char *argv[])
> +static int ___trace_kprobe_create(int argc, const char *argv[],
> +				  struct traceprobe_parse_context *ctx)
>  {

I'm not sure I care about all the underscores. It just adds to confusion.

Maybe just:

static int __create_trace_kprobe(..)

?

-- Steve
