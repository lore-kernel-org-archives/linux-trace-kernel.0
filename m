Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194138;
	b=40ec0jH5PlfIoOH72+nzB1/YueuwDQiTIeR3vL6hF3ayVejYf4JwoaXWgilCt19ncfK+
	 8mZV1cqysT9RnnDWjMU2cWbqF+TKDQFHMDforsCryiSu53PZFYAQrLodlzdZMOLcvO5TB
	 miMtk7b0u1y33PHjCPbQCV5ilosLEdGNFaUxJSsc8Xxm9pXSWmfUNnZgrKgd/EmxuqTb6
	 RlOD3oOMc08WkC4RT3LjC2H5twGfMiTdV73DFV6X3pQj0aO5zswcXPhyrz5vdPojm/Pmz
	 53aGDZl2quAJFcKc0288vgNULR6fTUqEdBAbkZ6WmgvgTQCojZHrbYjbMxsIvTBSSDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194138;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=FLKnlRbJD1/tet/3IiAp1mZT2KpI2WVfTfQBZi4MnUQ=;
	b=l3mfQo/eqfmheQvuC+L73NuSxSHRZAypcozYbMfFR3FxOsxLN2OVY2i5dPOT70erS+PO
	 kQDBqidfgt3Dqw31g7v5wUA1XpfwpDuGi0GazUQhzBcPPzUx/DzhfFGkBqw/eoISVM1Xv
	 nbSmLkj5ZVPuhyiNZjqxgaMVEinpv6z2UQyX+zDDPE9OhJa/z1TozDV2ahzdauFMbJmbo
	 XtbG4aO3MXtYwR3v/+U60MgiW05bGGx+353yu9UGzLVPKjgiHl2bz555uvXiiPTe51KM0
	 Uw5fEWlfAbfeec3kE+Pq/xNeuyrakM3RhmFJFwdL1DuBEIbI+T5W9JggpDqE6OHUSwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=qQvuRZzS;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D67606A31A;
	Wed, 28 Oct 2026 13:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24D67606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=qQvuRZzS
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 881D080C8B;
	Wed, 28 Oct 2026 13:28:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id B33A320028;
	Wed, 28 Oct 2026 13:28:47 +0000 (UTC)
Date: Wed, 28 Oct 2026 09:28:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 03/16] tracing/filters: Fix false success return in
 process_system_preds()
Message-ID: <20261028092846.3782e698@gandalf.local.home>
In-Reply-To: <179314823296.684037.17602272705996028005.stgit@devnote2>
References: <179314820431.684037.4147763044424284198.stgit@devnote2>
	<179314823296.684037.17602272705996028005.stgit@devnote2>
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
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: B33A320028
X-Stat-Signature: fjmr4z6yb7u84x13waruh7dcciwpi13n
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/7VmVCgvu1oMBM+JBddpevWT5GzRegh8Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=FLKnlRbJD1/tet/3IiAp1mZT2KpI2WVfTfQBZi4MnUQ=; b=qQvuRZzS4Mv8IDFULHOF5ttRvBP7irHxHzjl2PfEcCYIG6wUHoKDCLrffdcAchMqblXv0y0tULtIGJr/1mfV7gCtpfx4shnKaMIPH+Dc+qDmS1JDQqo8RJitrGHuwYBzzvbrUQAcFpBXukN87jC9FtfiXkv5lhRrpSrTer6/07c=
X-HE-Tag: 1793194127-434769
X-HE-Meta: U2FsdGVkX18QH3hilVK39IPdqSs9Dt6zlZZxHRTm6dS9YMboGgj2f4JbgPnciIgJ+YjTq+rXwomyQl2XifRRpIlon6hlqmkoAyAEXoUS/dDHeM2CKviEyCS9XDDlSiKHYxGLUGUAIXLnSCwwDPjbfPwH8tontCIlC9uAfsxguvi1It3n/BdNvYRcoKgtl+1P/FydI3DHekFyWF2EmSmwbwV76UFzTza/wdReWAP3FHecZgSRWK/SBKiNrY6fY+hJ30cH+FKXzuGS6kR8DXupx3rWnAOVmUGIdLb+2VLVYBsuzkPk3pGebyDDOcEfH6SDbCcYDvXhPC/Mz8YeVb882fjb34M8fKcU

On Wed, 28 Oct 2026 09:43:53 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> In process_system_preds(), "fail" is initialized to true to indicate
> whether any event in the subsystem successfully applied the filter.
> However, "fail = false;" was placed at the end of the event loop outside
> the error check, unconditionally clearing "fail" on every iteration even
> when process_preds() returned an error.
> 
> As a result, if every event in the subsystem fails to match the filter
> (e.g., an invalid field), process_system_preds() returns 0 (success)
> instead of -EINVAL. Consequently, create_system_filter() considers the
> operation successful and silently resets the subsystem filter display to
> the default global filter message instead of reporting the parse error.
> 
> Move "fail = false;" into the else branch of the error check so that
> "fail" is only cleared when at least one event filter succeeds. Because
> file->filter is still replaced even when process_preds() fails, check
> !list_empty(&filter_list->list) on the fail and fail_mem paths so any
> replaced old filters are freed after an RCU grace period via
> delay_free_filter().
> 
> Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_events_filter.c |   15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index f7c067a58ba4..617bc3c0bb0c 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -2354,8 +2354,10 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
>  			filter_disable(file);
>  			parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
>  			append_filter_err(tr, pe, filter);
> -		} else
> +		} else {
>  			event_set_filtered_flag(file);
> +			fail = false;
> +		}
>  
>  
>  		filter_item = kzalloc_obj(*filter_item);
> @@ -2370,8 +2372,6 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
>  		filter_item->filter = event_filter(file);
>  		event_set_filter(file, filter);
>  		filter = NULL;
> -
> -		fail = false;
>  	}
>  
>  	if (fail)
> @@ -2386,14 +2386,17 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
>  	return 0;
>   fail:
>  	/* No call succeeded */
> -	free_filter_list(filter_list);
> +	if (!list_empty(&filter_list->list))
> +		delay_free_filter(filter_list);
> +	else
> +		free_filter_list(filter_list);
>  	parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
>  	return -EINVAL;
>   fail_mem:
>  	__free_filter(filter);
>  
> -	/* If any call succeeded, we still need to sync */
> -	if (!fail)
> +	/* If any filter was replaced, we still need to sync */
> +	if (!list_empty(&filter_list->list))
>  		delay_free_filter(filter_list);
>  	else
>  		free_filter_list(filter_list);

I still prefer my suggestion which cleans up the code and gets rid of the
duplicate if statement for freeing.

  https://lore.kernel.org/all/20261026153258.5259323d@gandalf.local.home/

-- Steve
