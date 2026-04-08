Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07DDCA45;
	Wed,  8 Apr 2026 01:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610233; cv=none; b=aodO7s3QNfZFPOeM/2NuO/iXbQJFR/fsKqbvw52QhReXI2hkTmLX5kuluxyONQPbWzKzmIIqwjr3jBdKkNwwBj2Nr9J6uFRRzAK2w1Kjzs6qTNK8rtTHc7mJx/jdXZ8+QbXcRxLYNyghqq8f0/op85nUxnKMW0qQv6f0NQ195yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610233; c=relaxed/simple;
	bh=a3xhaVGY/SxMDfx3Hn2Tszl14EUFFGLwxQ7gDxOgNDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXeCmxBKzkKVAM8nsOMhHhGiu33kCm0Vz2vsJsJuw0qqUjSSPtTi/bPmdF8l23nsc4MHqwoigAqRkhqXsTcK8b/orM5xEbuylEoKMG9Khqit5cgxGgF6sI/IoJqKPbRDr37keNnKkRCri2VNG4aaxXTLdJ2Ua0R++gtcawJCesQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 3E57913BEA8;
	Wed,  8 Apr 2026 01:03:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 562F22001E;
	Wed,  8 Apr 2026 01:03:48 +0000 (UTC)
Date: Tue, 7 Apr 2026 21:05:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Tom
 Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v2 1/2] tracing/hist: rebuild full_name on each
 hist_field_name() call
Message-ID: <20260407210502.102e5d37@gandalf.local.home>
In-Reply-To: <20260401112224.85582-1-pengpeng@iscas.ac.cn>
References: <20260401112224.85582-1-pengpeng@iscas.ac.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: bgmgdzr4zkpry4x1a65ara8776udhkkt
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 562F22001E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18aTlfnHz/MOk/n+YQ2rFjoF75g/Q30ieU=
X-HE-Tag: 1775610228-994174
X-HE-Meta: U2FsdGVkX1+mOEx/h7s19oHvkIq6Ruu2DOZsa3N9Z8f3671wiNoOL3r39MPjycAYxngh3lKTQXabaaDWLwRJ3mEy4IBX8hMN+5SCO3KlO31845Qyl6Jr0j0Y1zwmLW6mbbllijNSLNG+1+ToIkS/DWAcvs+w0Wf74R1MX9ajrrjI/LERKGtUCGH8PmeDhDwYPArEk9eveFWM5VCTnG7Li7DmLb56n9p2XijPngv3GqorMLGFmlww7L2mH71lJmz/MMH8gr3VXFpeHrriM6IJnQL3Zu/y7pqzytUCz7MzZaqaeX6TpJeJinKgXTegQEPGDAxSrrsq+lNBLGd+VlHIm4Bv5jO8bsFq


Tom,

On Wed,  1 Apr 2026 19:22:23 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> hist_field_name() uses a static MAX_FILTER_STR_VAL buffer for fully
> qualified variable-reference names, but it currently appends into that
> buffer with strcat() without rebuilding it first. As a result, repeated
> calls append a new "system.event.field" name onto the previous one,
> which can eventually run past the end of full_name.
> 
> Build the name with snprintf() on each call and return NULL if the fully
> qualified name does not fit in MAX_FILTER_STR_VAL.
> 
> Fixes: 067fe038e70f ("tracing: Add variable reference handling to hist triggers")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> Changes since v1: https://lore.kernel.org/all/20260329030950.32503-1-pengpeng@iscas.ac.cn/
> 
> - rebuild full_name on each call instead of falling back to field->name
> - return NULL on overflow as suggested
> - split out the snprintf() length check instead of using an inline if
> 
>  kernel/trace/trace_events_hist.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 73ea180cad55..f9c8a4f078ea 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1361,12 +1361,14 @@ static const char *hist_field_name(struct hist_field *field,
>  		 field->flags & HIST_FIELD_FL_VAR_REF) {
>  		if (field->system) {
>  			static char full_name[MAX_FILTER_STR_VAL];
> +			int len;
> +
> +			len = snprintf(full_name, sizeof(full_name), "%s.%s.%s",
> +				       field->system, field->event_name,
> +				       field->name);
> +			if (len >= sizeof(full_name))
> +				return NULL;
>  
> -			strcat(full_name, field->system);
> -			strcat(full_name, ".");
> -			strcat(full_name, field->event_name);
> -			strcat(full_name, ".");
> -			strcat(full_name, field->name);
>  			field_name = full_name;

I wanted to test this but I can't find anything that triggers this path.
How does a field here get its ->system set?

If there's no way to hit this path, I much rather remove it than "fix" it.

-- Steve


>  		} else
>  			field_name = field->name;

