Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845ED2475CB;
	Wed, 15 Oct 2025 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563224; cv=none; b=WiLayn16M6kCZX2bqYq9Ms+fWhv2HStqDS/gRHOgqTMnLVifqHqps6c/Vk43JegdEAlKHbDvbmBA+P4kQhzB2NspytotndRFHEvgcgEgHPLppMEkoyXQ8OK9JJserMItKPMz9/i6N3NpDS2qcBceWg2WzrUP4mL1sVJcU5/sp4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563224; c=relaxed/simple;
	bh=EOxifxp6BWGJCSPE+t53wdqzeFijrm/u/4LqfvO1BIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qqz3AE8HQIYUkff+pvYi8RO6cQ03Ny/w7VZfRHyJbKUT481cPnfNyP6bQseZiED7cLgcmhAHKu0g6Ld9LBpEBA4zapkgkolhdyNWEkvIhVa7xdhw2F5Qi2UoiVD0CVn/Qh1l5/kuy7gl/Fc3PxTExgoNo3x4CESj6F3qz548XBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id C6D7CB953A;
	Wed, 15 Oct 2025 21:20:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id F34E02000E;
	Wed, 15 Oct 2025 21:20:11 +0000 (UTC)
Date: Wed, 15 Oct 2025 17:20:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tracing: Allow tracer to add more than 32
 options
Message-ID: <20251015172020.5966beaf@gandalf.local.home>
In-Reply-To: <175918529300.65920.15856373929947126262.stgit@devnote2>
References: <175918528341.65920.10238038992631012350.stgit@devnote2>
	<175918529300.65920.15856373929947126262.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: oj795q6u9q9iu85od7rb7oc8eszdpre1
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: F34E02000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19FhodM+VZGak7x5DFU+TTZTy9PHWLL5AE=
X-HE-Tag: 1760563211-601402
X-HE-Meta: U2FsdGVkX19lh7rtuHgALC7BeoYzF4V+Nz1FFo8Nz7c9cuEnyAwiTw9GA4JBwe/+LLvNKlzehfDn/q9I8Ads+fgCFw2qXJWOkRX0qLwyPPOJnYq6INo6ENYYm/idTe9xnBOc4+bxlKZua3OgdpWa+h7KZ/v5ZjjY6nQU8rPUxUfq6lb2XOu3KgT/+LzNg+oKJr+gsWj+wiYm9S8+7JJAsauPjub/p/BsnmVSqH3crR6Dewl7bWqrKz2Z9i/Q7IOXeOPvwVujbkFQ/ixXLMx7irbtbWvcFJwLgO3m+nuTPqbSZiAaDqpnrHa//w06vRToHu7BvS0Lbq/BaXI/rpWJB9d51XT6tH3W

On Tue, 30 Sep 2025 07:34:53 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -86,6 +86,11 @@ void __init disable_tracing_selftest(const char *reason)
>  #define tracing_selftest_disabled	0
>  #endif
>  
> +/* Define TRACE_ITER_* flags. */
> +#undef C
> +#define C(a, b) const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
> +TRACE_FLAGS
> +



>  #undef C
> -#define C(a, b) TRACE_ITER_##a = (1 << TRACE_ITER_##a##_BIT)
> +#define C(a, b) extern const u64 TRACE_ITER_##a;
>  
> -enum trace_iterator_flags { TRACE_FLAGS };
> +TRACE_FLAGS
> +#undef C

Why all this work when this could have been simply fixed with a:

-enum trace_iterator_flags { TRACE_FLAGS };
+enum64 trace_iterator_flags { TRACE_FLAGS };

  ?

Not to mention, using const u64 requires saving these numbers in an address
and referencing them, instead of doing it inlined in text. That is, using
u64 instead of enum64 is both slower and wastes more memory.

-- Steve

