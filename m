Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B563033DF;
	Wed, 27 May 2026 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896258; cv=none; b=YgDOczumMAC63S7tuP0Y0edAmmw49zoD76aX6ZICfqM7clQdVIG3TbR2yimbv1naxDEuyySW2wS2vXs5WxX/OQE9eCiz3PHxBEjs+/ciQibA7NHl1k6VfYUn22/1YfMiLnavGYMTiO0iZZBYDZpnunPti6Hq5C2XZfOHt5paxSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896258; c=relaxed/simple;
	bh=CKnoBuLNzkLlnL+dEXS6wGXpa7gCnNKq6Qyzz321pD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVTxangq9EyQuNHokotEMRchJVXtxiSd8WCRINDa4ayas/cgz+s1SrcILDDV2RrtKfP6TRFxBmhJGsWoXfJxcsCmBuOlFUXF/TceugNNe7K3v2CCb2SD/nxbsCXEUXXiQY2LqXeQI+bz57br0ehEsjSswYe3g2nN4H1ncKdT+Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 8BD85120602;
	Wed, 27 May 2026 15:37:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id A9C2031;
	Wed, 27 May 2026 15:37:33 +0000 (UTC)
Date: Wed, 27 May 2026 11:37:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Rik van Riel <riel@surriel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf/ftrace: Fix WARNING in
 __unregister_ftrace_function
Message-ID: <20260527113732.664d26db@fedora>
In-Reply-To: <20260527111301.2d0d8256@fangorn>
References: <20260527111301.2d0d8256@fangorn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A9C2031
X-Rspamd-Server: rspamout06
X-Stat-Signature: 8zpi8s5iy8hmmm9gghmh4ajrr9wxfhgg
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18sN3Z+qiHjOGzOwHSQZg5mZgdVyH6kwsg=
X-HE-Tag: 1779896253-145336
X-HE-Meta: U2FsdGVkX1+6HoMNP5Sj11GbkSOgK5jinNdtyvBit0fq1SDhWqIG8A2yUF1TyfxryKIctWpvC4xTV7YmVoPf/qd4jSHMk206KeKPJim5liVtND/l230w1mKQwQ91HHqCR6P+zkS4d2nagQdDPJpccYYUAKyK9oaLMKEP/xrjAMQSksgosftCO5Qj9utaBBYuuAYmQI8Dce1Z2SjyjRo4gXGgWPAAgNL1FJ8s0Dt7W9ldGtVppuCYi1ObtdVJJSgWJGLRQYIXWVoLm4qtSfXCipfQDNQKdX7izLhNrGySX/+J+YdUACIF5Y69vkFtukuHahK7crQ/g0cT4me6EVJrleF3c49Me6EncNJ5H9xhxpxQSUU5QTOEuVjPXs67YpN5UHsB2gkAOn7a/exQPwuB4A==

On Wed, 27 May 2026 11:13:01 -0400
Rik van Riel <riel@surriel.com> wrote:

> perf_ftrace_function_unregister() unconditionally calls
> unregister_ftrace_function() without checking whether the ftrace_ops
> was ever successfully registered. This triggers a WARN_ON in
> __unregister_ftrace_function() when the ops doesn't have
> FTRACE_OPS_FL_ENABLED set.
> 
> This can happen during perf_event_alloc() error cleanup when
> perf_trace_destroy() is called via __free_event() on an event whose
> ftrace_ops registration failed or was already torn down by
> perf_try_init_event()'s err_destroy path.
> 
> The call path is:
>   perf_event_alloc() error cleanup
>     -> __free_event()
>       -> event->destroy() [tp_perf_event_destroy]
>         -> perf_trace_destroy()
>           -> perf_trace_event_close()
>             -> TRACE_REG_PERF_CLOSE
>               -> perf_ftrace_function_unregister()
>                 -> unregister_ftrace_function()
>                   -> __unregister_ftrace_function()
>                     -> WARN_ON(!(ops->flags & FTRACE_OPS_FL_ENABLED))  
> 
> Fix this by checking FTRACE_OPS_FL_ENABLED before attempting to
> unregister. If the ops is not enabled, just free the filter and
> return success.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>

Thanks Rik. Is this urgent where it should have a Fixes tag and Cc
stable as well as be sent to Linus during the -rc release, or can it
wait for the next merge window?

-- Steve
