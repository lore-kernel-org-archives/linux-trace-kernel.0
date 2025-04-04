Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54322D27E;
	Fri,  4 Apr 2025 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743775374; cv=none; b=LLArTVq7O2FfChiAKBl9MJs5sTtSojZ/LjEPoaTGIJvgqkrad921rZbXkerXfWolHHEXxH5KWCbBPB/N7R0BegdsYJ2GHc7jcm/IGHzmCCVjuVQLnr6auJDkQy1HhDnP0WXvCK0R7gp+D/QMX472W50BUerIheq5710ENVJsAVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743775374; c=relaxed/simple;
	bh=1X8+Xr8hv8b+T4iI5Uc77T5lmSNbzFrp1Cixnj48R0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhRVYtG6PW9c2QxWb8TP7zAdhtCdu5NlQFFZ9nhppTIo9P5VC4akgeFmCMtTDj9Aq0nVeuGKyWaqHVewQHadeNCxMdh7cjYnIYdIi3uQ3t5OcHVuXXiKuICH4Iv0xlA4cO4yDGz24lRyKQvKvt7HAHKMiSW43dQ5n1q7iFFwgbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222AFC4CEDD;
	Fri,  4 Apr 2025 14:02:53 +0000 (UTC)
Date: Fri, 4 Apr 2025 10:04:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Move histogram trigger variables from stack to
 per CPU structure
Message-ID: <20250404100400.22195057@gandalf.local.home>
In-Reply-To: <20250404095841.2cac7a47@gandalf.local.home>
References: <20250403204251.0164a4cf@gandalf.local.home>
	<20250404095841.2cac7a47@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Apr 2025 09:58:41 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Hmm, this is incorrect. hist_pads can be NULL or allocated, so the check
> should be:
> 
> 	if (!hist_pads)
> 		goto fail;
> 	hist_pad = per_cpu_ptr(hist_pads, smp_processor_id());
> 
> Will send v2.

In fact, if hist_pads fails to allocate, the triggers should not be enabled
(it would fail to enable). So I'll just add to the start of the function:

	if (WARN_ON_ONCE(!hist_pads))
		return NULL;

-- Steve
