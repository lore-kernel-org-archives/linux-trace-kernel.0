Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF33D47A5;
	Thu, 15 Oct 2026 22:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792103934; cv=none; b=AbKlZt/6ZCgx5SMrYDTba9SeecezqOLicgVFAr47lc0wcLQaoihSyNKAzFeap7l7yz9JrBeFxgsMpWoVPuJrogLaDXSyYu+zOvbp1bw+OX8Dgc5rp0NYhwxdfDUBnQRKNj1yglKboMrCEQezxkFCECTh8GzaTHQpkr8w0jTXh4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792103934; c=relaxed/simple;
	bh=oUiamnPVBgTpH4+GroToOl4VifqgWz5swMC8+NgF8kc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTxjfHKiVNRxtcUes1cBQOvGf0LZ0qwBhqgNO1YYOnxwPi6SLWGTm+sheUbMEdY4x2x7GFW5B4OplT04dRLiv9GQHjQw/FlyNvB+nz8rhziWYO3U8GGqlAHS3oCMLpuYEppJsBf0IiqTgeLCSOaDLrq6ysW6IbsphEPmPMEllWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=BxcemC9v; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="BxcemC9v"
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 2140AC01F9;
	Thu, 15 Oct 2026 22:38:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 13F261A;
	Thu, 15 Oct 2026 22:38:43 +0000 (UTC)
Date: Thu, 15 Oct 2026 18:38:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Don't log an error for the speculative field
 variable lookup
Message-ID: <20261015183841.4cbc5af2@gandalf.local.home>
In-Reply-To: <20260913203156.941433-1-donggeunyoo.kernel@gmail.com>
References: <20260913203156.941433-1-donggeunyoo.kernel@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Stat-Signature: ndxx4g5jy79m4indhjp5amai6z97z9te
X-Rspamd-Queue-Id: 13F261A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18kZPowU5+iMalZAk31pbTiqi/5ImtZYu0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=XyKzzc14QmZPtfKeM1dz5ieN4n4yq+aaG1CgOHIsZ/A=; b=BxcemC9vLfDix0ZZ5GhTiHn5l8iyX0DpacJcuPj/BfviTa4/CriA13o9UA6XVvO6TJvqEmBAQX3Z08gwKkRrAhF3zt25BUfjt16G5LywapJ+Dionm+V5mNQi2HQ9JRCQKWXH68ssrbAioSLB/Ut/rm46W8mATO1Qq3fw7dzYJUY=
X-HE-Tag: 1792103923-529475
X-HE-Meta: U2FsdGVkX1//o9HgiTvFd2XPd/1Dh0iBkGpTa9ZCib5NfWgd6G5ykkZsvPiGSXMtPZVe3xjqvXkM5G8OgZpf/40HlKge88f3YvJMp30RR40I7ZAxwUvIx/mm2EcCA+5864uJvIcZrzIg0w+WBsQSj+xRbMUF0gAB/pwihSFe3U7ag/5Aeucejg14hJypz1bycbKaCn2H03rlRyBAB49fWAjh1d/RyMF+nIvFrnJ9upis08wBey5uXgp1zN/mHnxieOk9i10jsdTxA8XQQdUaaTO+RaR4qxZkQKAs/tqQjJbS3z5/os8XV5wQW+OjkxJkLspdZclhExrFEmva169bm4GxKCtsbhwq

On Mon, 14 Sep 2026 05:31:56 +0900
Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 963e0d6b61fd..4676dc6d9146 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -806,9 +806,12 @@ static void last_cmd_set(struct trace_event_file *file, char *str)
>  		snprintf(last_cmd_loc, MAX_FILTER_STR_VAL, HIST_PREFIX "%s:%s", system, name);
>  }
>  
> +/* Set while a field lookup may fail silently; the parse path is serialized. */
> +static bool hist_err_silent;
> +
>  static void hist_err(struct trace_array *tr, u8 err_type, u16 err_pos)
>  {
> -	if (!last_cmd)
> +	if (!last_cmd || hist_err_silent)
>  		return;
>  
>  	tracing_log_err(tr, last_cmd_loc, last_cmd, err_text,
> @@ -4003,7 +4006,9 @@ trace_action_create_field_var(struct hist_trigger_data *hist_data,
>  	 * unqualified fields on the target event, or if qualified,
>  	 * target fields that have qualified names matching the target.
>  	 */
> +	hist_err_silent = true;
>  	field_var = create_target_field_var(hist_data, system, event, var);
> +	hist_err_silent = false;
>  
>  	if (field_var && !IS_ERR(field_var)) {
>  		save_field_var(hist_data, field_var);

I applied this patch then I unapplied it after looking at it.

This looks racy as hist_err_silent is global. The parse path is serialized
but we should add a lockdep assert in hist_err() to make sure the event
mutex is held, as well as by the setting of the hist_err_silent to prove
that the code is serialized.

-- Steve
