Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793043199;
	b=SzsisnHp16SWu3iLEr0jYqHaboqh8p841QzDASWf5Api/JhpRheqd+Cg8f4Hb1PkY9fn
	 Vu3EXyJzcIHe7+HfmQ+bGwMNFj7vhnnlztK8EPIv8PfDXqFjTw98S2chOAtg5pPP0KvxI
	 1lb0ZeCgPG0m7sx10uLQg++kLgGEdA8N7a2WoFl6/oGaycbWZbNuZU8O+Cy/N/aXGT0GU
	 ZrGxYt30xwZCyV8pjZaTkM8ji7BYNXCyo7tfD154HotbelsSaATgI4oKC36EGPuFM0K9S
	 rUjiHGO+5hsVfk0mumdV/JGk9yea9LpX2IQ1G/2YlSMyRNULv0oUvg35eY1sX3CEiFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793043199;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=7FroyQfmGccRo/6Ojp1n1yG7KvHfRDE9iUS1JPBi4tA=;
	b=LmWySa6llty0NeHGDhUkZq5E1yupmA15MBIYh2sukPCBAY5jOB/RhEtPwNjJTGkBEBGo
	 ByaYYUxtUWs1VCRo4UxeLdMfkR+jQQjKYiZtc/BCNDMX83UHgBcVxG0BUizGNqA4yX+K0
	 Mmg9yNiBUqQVWrd1jvV5NoSPDEKT8nxV1JgBhpojyIbK2hlUSV9XfoSJ0LwD06O4/9XMi
	 49mnSbcJXgVrDOAJnmgYomxPj669Jwmm2/SZeFHX9jjmHzD6QTpH/dI3EJT1XOGLwSUKW
	 f1gR6yorS1e10ZUFz7zhQyjaETYd7HqPEuFaNMsHJ5epU6rl3s54HTUevr54gha+T9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=o3qhcDEp;
	arc=none smtp.remote-ip=216.40.44.16
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9099606A31A;
	Mon, 26 Oct 2026 19:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9099606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=o3qhcDEp
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 67014C082C;
	Mon, 26 Oct 2026 19:33:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 7DFC72002D;
	Mon, 26 Oct 2026 19:33:08 +0000 (UTC)
Date: Mon, 26 Oct 2026 15:33:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 02/10] tracing/filters: Fix false success return in
 process_system_preds()
Message-ID: <20261026153258.5259323d@gandalf.local.home>
In-Reply-To: <179285914279.466249.18363232291728825688.stgit@devnote2>
References: <179285912318.466249.7425922682086130057.stgit@devnote2>
	<179285914279.466249.18363232291728825688.stgit@devnote2>
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
X-Stat-Signature: thwpb7popeprf8q1p8e567zoydgbqdnt
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 7DFC72002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19n6zJjGGG/dMguuPm3g8hioVpXwuAfxOs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=7FroyQfmGccRo/6Ojp1n1yG7KvHfRDE9iUS1JPBi4tA=; b=o3qhcDEp6ZUw/1N6aAxNUGtgb0fM+WpVyS99Cgl/CBI2IbqYO4OZ48KFBlPVpPEp6i1sqzPEYLoqX55s2NLvwEdiQv5TNTyB762AAQCg5i+RlQBt0OG9KNeRmW2RSBTLIBIiy3DDGuxvMJPwlD+FTqiBkd4zOoQU2Y44TDIrMEM=
X-HE-Tag: 1793043188-40761
X-HE-Meta: U2FsdGVkX1+p/N4uQdBG2PVX04ya0aV9sLJPfjmDhd/YgbvjOHbNuT11ylfKbF2M6+0ioHko+Mls50AYzyt8Ttm038TUHDa6DARfBPFpUv6tex9dNkD2o1zJFl4jV/zQHJdeeal5qpDbStpupDp+UDtBK59hZ+n4ijjoA6upTzpfbygXOy8l2Qe4I1qcM9fCyewrsaQ3L/845Mbh9LLqdiKvgM2V5yC95F1X/ErlBBm8UATiOL6wSf4hbofCxfjJa9MUD3e6Im4MarEQcLd2609ZAklmQvtrtZa1jE1E1WTWYhzbCm4IFN08clsECE/cw5jFCc9UAKwBPD1bxrKd1VPynDbcCj5g

On Sun, 25 Oct 2026 01:25:42 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_events_filter.c |   15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 18ce3ec00d34..c2c35b4de85e 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -2332,8 +2332,10 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
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
> @@ -2348,8 +2350,6 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
>  		filter_item->filter = event_filter(file);
>  		event_set_filter(file, filter);
>  		filter = NULL;
> -
> -		fail = false;
>  	}
>  
>  	if (fail)
> @@ -2364,14 +2364,17 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
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

Hmm, I think this can be cleaned up a bit better.

 1) remove the fail boolean
 2) consolidate the if (!list_empty()) logic.

Like this:

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 5e74d2dae40a..4d763c55bb7b 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2305,7 +2305,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	struct filter_list *filter_item;
 	struct event_filter *filter = NULL;
 	struct filter_head *filter_list;
-	bool fail = true;
+	int ret = -ENOMEM;
 	int err;
 
 	filter_list = kmalloc_obj(*filter_list);
@@ -2332,8 +2332,10 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 			filter_disable(file);
 			parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
 			append_filter_err(tr, pe, filter);
-		} else
+		} else {
 			event_set_filtered_flag(file);
+			ret = 0;
+		}
 
 
 		filter_item = kzalloc_obj(*filter_item);
@@ -2348,11 +2350,9 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 		filter_item->filter = event_filter(file);
 		event_set_filter(file, filter);
 		filter = NULL;
-
-		fail = false;
 	}
 
-	if (fail)
+	if (ret)
 		goto fail;
 
 	/*
@@ -2364,19 +2364,18 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	return 0;
  fail:
 	/* No call succeeded */
-	free_filter_list(filter_list);
 	parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
-	return -EINVAL;
+	ret = -EINVAL;
  fail_mem:
 	__free_filter(filter);
 
-	/* If any call succeeded, we still need to sync */
-	if (!fail)
+	/* If any filter was replaced, we still need to sync */
+	if (!list_empty(&filter_list->list))
 		delay_free_filter(filter_list);
 	else
 		free_filter_list(filter_list);
 
-	return -ENOMEM;
+	return ret;
 }
 
 static int create_filter_start(char *filter_string, bool set_str,


-- Steve
