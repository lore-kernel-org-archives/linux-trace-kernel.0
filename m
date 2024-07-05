Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FC6146A8A;
	Fri,  5 Jul 2024 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189858; cv=none; b=LlwK3dcjIODJxN2wQtRJqUeqtQKw4t0/UeZLBaHFmV9+06rNfWUAZ//wt6X1OKAI1hyoBzYklqa7/4xZS9wRIBSbF2fvA6S0A/RtZyrLfMmckB2KmzYEF1U7mnM2RR5rlkPaUUSJ/SCvoEXlf3Y3k32hwIz3R4F7A1RrCN3+8gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189858; c=relaxed/simple;
	bh=QNhUc31+DOIBjWg8E9pWy7RWFL1/sbz1daYZaABHAPw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=smogRXECejlzipHjMtbSYG6REiL9HtpPmM+QdnFK/ElqecgsD9RHce1dKdgp3GSKVppyeKcIUeVV9lzwLQGHUCucvayQ5bP0d7uMucy2ulb2O320jsJwH4jF7NOEHh+a4VU8LBFy2giynhguvCSI9XsTiEa9uxFZWnoprH7cif0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2307C116B1;
	Fri,  5 Jul 2024 14:30:56 +0000 (UTC)
Date: Fri, 5 Jul 2024 10:30:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Francis Laniel <flaniel@linux.microsoft.com>, Nikolay Kuratov
 <kniv@yandex-team.ru>
Subject: Re: [PATCH for-next v3] tracing/kprobes: Add symbol counting check
 when module loads
Message-ID: <20240705103054.379b0cba@rorschach.local.home>
In-Reply-To: <172016348553.99543.2834679315611882137.stgit@devnote2>
References: <172016348553.99543.2834679315611882137.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jul 2024 16:11:25 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Currently, kprobe event checks whether the target symbol name is unique
> or not, so that it does not put a probe on an unexpected place. But this
> skips the check if the target is on a module because the module may not
> be loaded.
> 
> To fix this issue, this patch checks the number of probe target symbols
> in a target module when the module is loaded. If the probe is not on the
> unique name symbols in the module, it will be rejected at that point.
> 
> Note that the symbol which has a unique name in the target module,
> it will be accepted even if there are same-name symbols in the
> kernel or other modules,
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
