Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035384;
	b=GN522hLl9P3fodBPAj7ug4YBbKc09Z1q4vtohvM602xi12ocV8EuyQSGMyoTC2nozqad
	 FBsJYbjroUkw+dswuwforZCNeAs23NC6hHbRL6Qk1pD8eQ2SqVdobCl3SHfsr8WAm0Lny
	 O41WpO3thov//BbQ+n0B5RFoAGxPd1gQDW1Uaoy/Htcqa/NrqILkdTRVwDU6WaHA//HTv
	 FTqLng03A7FC4CzNAGHxmbeeP+TybN+mv+MLrUi9LsALkJ0MxRIf2kEi1sTIeXx3WNmJy
	 ydzLrwX8GQ77jd6yUMvZBXaokynwmAGWPPORnGYvbB35Ff0D+ZqAmtb9qjLXgybZXrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035384;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Spam-Status:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=/w5gM9JlgSieIjqZ52kZRMIYLrdxxdSRHqJypDDCvPg=;
	b=SHqhX97Wajtti3znm5Etqlcd1MIFmUkI15YpePTKTCh214LLhc75OB3+kyCtPP8dAo7h
	 BENsX5/HDXQJAk/TOc9l5CisYv/kfdK8esIZPUwcByLhJIVVhEyLHkHWDuAtTrHxGsrR3
	 YnGyj4hZtPfmPGdyj6BYWRSkOXuPxW0u7gNWl4jfMjHqOGeaX3anmbwyiUM8ol+qJHZY7
	 kuXjn1XF3tHmQkygdp4ejn93XMcO6wANyLFJO246+3VD6kO6Ye3rTgW4BbbSv0fhZq4+E
	 pQ9s9wxwLCG5lqllUDLnQ3ElEB6qsMTqG04iTQ0+uAJbgC8hWio7EIp1yPjTMHJ5s0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=xzENGHEz;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526F4606A31C;
	Wed, 18 Nov 2026 20:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 526F4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=xzENGHEz
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 06179A08C3;
	Wed, 18 Nov 2026 20:56:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 4157E2002C;
	Wed, 18 Nov 2026 20:56:20 +0000 (UTC)
Date: Wed, 18 Nov 2026 15:56:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yifan Feng <evanfengff@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Do not WARN on a function probe glob that
 starts with '!'
Message-ID: <20261118155619.4d465f3c@gandalf.local.home>
In-Reply-To: <20261118032637.80038-1-evanfengff@gmail.com>
References: <20261118032637.80038-1-evanfengff@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: t3obshratx3dt7edp8q6odctuzomtmtp
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 4157E2002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/G/b9WkT65oSjyk5g56uOSRgjldkM2Ep4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=/w5gM9JlgSieIjqZ52kZRMIYLrdxxdSRHqJypDDCvPg=; b=xzENGHEzcRBTCyQMM3bxo+nGZ64M/ojZMxJOJVetXmdQkChnfgt7s/b44RrcSM+aDYWhGZkDPAkwHKRGC3hBId6vShCT1Ugxzp8ejWQqzEuQmSJZtZLvinY3TO09Amb2Z55HV0UCiD4gXPjMGpowYOurPbS4dLCU+S8rS42zNGk=
X-HE-Tag: 1795035380-573014
X-HE-Meta: U2FsdGVkX1/uFm17/g4Vz3c9gTo7yILL6XbPYwQocIHyEz1XnGo47Ch3gpWXN9VvIBMN6I6E8RdSUC3j02nDEMtC6P6iINw3BpuCH+v0TYsJXGMLwVz1jUp5Bo7WJeZ6musfi5jBP3Eyt0HecO3RQ1aNY9yH0qPX2qsLCRv/rKMDxX+mJ6JPa4gAzCdLjQt99s2VRFeLLOFqcD6teTRUIlhwaBSZSNpzqs+d2KNVVBLykRqg3F+xyVa3Bm3YZX/kfdW4RkfB3QoaOPvn+o4ooE2Q6wF9gKfQye8c7SaRW+xnB5pXcYjj9AyWwbHN07XG9kiW9JOv8vQ544aRQGJnxzaWu8kYF2QXbMobfsSVV07rLb+AnjpNPw==

On Tue, 17 Nov 2026 19:26:37 -0800
Yifan Feng <evanfengff@gmail.com> wrote:

> Removing a function probe with a second '!' in front of the glob
> triggers a WARN_ON() in unregister_ftrace_function_probe_func():
> 
>   # echo '!!vfs_read:traceoff' >> set_ftrace_filter
>   WARNING: kernel/trace/ftrace.c:5675 at unregister_ftrace_function_probe_func+0x662/0x870
> 
> The callback strips the first '!' and filter_parse_regex() then reports
> the second one as a negated glob. This is plain bad input from user
> space, so return -EINVAL without the warning.

I still want the warning because that should never happen.

The real fix is to make "!!" return -EINVAL immediately.

-- Steve


> 
> Fixes: 23b4ff3aa479 ("ftrace: add traceon traceoff commands to enable/disable the buffers")
> Signed-off-by: Yifan Feng <evanfengff@gmail.com>
> ---
> Tested on v7.4-rc3 in QEMU: WARNING and taint before, -EINVAL only after.
> Found and written with the help of an AI coding assistant.
> 
>  kernel/trace/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index c7d74b33d36d..04ea82a18601 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5672,7 +5672,7 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
>  		func_g.len = strlen(func_g.search);
>  
>  		/* we do not support '!' for function probes */
> -		if (WARN_ON(not))
> +		if (not)
>  			return -EINVAL;
>  	}
>  
> 
> base-commit: 7ccb044c27720d48175577080b851f047ddcfd1c

