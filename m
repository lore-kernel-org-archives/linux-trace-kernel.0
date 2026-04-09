Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729B3C660E
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Apr 2026 12:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736349; cv=none; b=LoSatBmbqW6Abf/V2OyFHabkFbKZhFGQw17g2hfPgj7jwp5Zm3YPeA1eBoUzoyPqauDcriqJ7bc7TaKGeZzDShl8OFGByMSA9g8tzlYhO6+QBM0L9OIYR3NAjSS1NB8Fb3s9Crrxsthumlc4Ceci8CCvOCVf9nZqouT5jF3JQ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736349; c=relaxed/simple;
	bh=Q4bpFJfQkflU5zV60Z7VmDlqQfSFg9hfoRai3sIS6R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5tx7jo9pwIuD+fD/IjHbGEUCSarFCHK6ERzh1i15IGn+ID6uIPJfsF41q4NC/Ol1SAc7agVKnAKFDHq3iLHyKkCJm6ZiT5NbhWWbvRxTftfDnjbQAwREIYbQ30jHQ+yjkc/x9V2/2wxrgPwznWBxfswnrLY4+GAhLSaFWvGWWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ecSZo3If; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ecSZo3If"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775736323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LSc3SmOYtBIOWoG9kyHi4EIc+hb4HbzyTC5iZOUi+nA=;
	b=ecSZo3IfKhaT1zAMOau+LZCp82lULh2HH4wwzB5fZM2h8IXJu4BzwSBYrrjgneo2LjIQ3h
	Er2dzbsKQE7Est3hOiUs1yA9iWqS8GUmA3hC4W4e92L4KMTsWC2I7rMGucq0+HR4SJYXrq
	1ps5+8EUcODW0eGbvDl/PH4puys9ODI=
From: Menglong Dong <menglong.dong@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 1/2] tracing/fprobe: Avoid kcalloc() in rcu_read_lock section
Date: Thu, 09 Apr 2026 20:05:13 +0800
Message-ID: <2258680.irdbgypaU6@7940hx>
In-Reply-To:
 <177573095696.3666478.4412068539797028855.stgit@mhiramat.tok.corp.google.com>
References:
 <177573094819.3666478.11900825120958856397.stgit@mhiramat.tok.corp.google.com>
 <177573095696.3666478.4412068539797028855.stgit@mhiramat.tok.corp.google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/4/9 18:35 Masami Hiramatsu (Google) <mhiramat@kernel.org> write:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> fprobe_remove_node_in_module() is called under RCU read locked, but
> this invokes kcalloc() if there are more than 8 fprobes installed
> on the module. Sashiko warns it because kcalloc() can sleep [1].
> 
>  [1] https://sashiko.dev/#/patchset/177552432201.853249.5125045538812833325.stgit%40mhiramat.tok.corp.google.com
> 
> To fix this issue, expand the batch size to 128 and do not expand
> the fprobe_addr_list, but just cancel walking on fprobe_ip_table,
> update fgraph/ftrace_ops and retry the loop again.
> 
> Fixes: 0de4c70d04a4 ("tracing: fprobe: use rhltable for fprobe_ip_table")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/fprobe.c |   53 ++++++++++++++++++-------------------------------
>  1 file changed, 19 insertions(+), 34 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 56d145017902..058cf6ef7ebb 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -536,7 +536,7 @@ static void fprobe_graph_remove_ips(unsigned long *addrs, int num)

Hi, Masami. Thanks for the fixes. Overall, the whole series
LGTM.

Some nits below.

>  
>  #ifdef CONFIG_MODULES
>  
[...]
>  				  unsigned long val, void *data)
> @@ -591,6 +567,7 @@ static int fprobe_module_callback(struct notifier_block *nb,
>  	struct fprobe_hlist_node *node;
>  	struct rhashtable_iter iter;
>  	struct module *mod = data;
> +	bool retry;
>  
>  	if (val != MODULE_STATE_GOING)
>  		return NOTIFY_DONE;
> @@ -600,13 +577,19 @@ static int fprobe_module_callback(struct notifier_block *nb,
>  	if (!alist.addrs)
>  		return NOTIFY_DONE;

The "retry" confuse me a little. How about we use "again" and "more"
here:

+again:
+	more = false;

>  
> +retry:
> +	retry = false;
> +	alist.index = 0;
>  	mutex_lock(&fprobe_mutex);
>  	rhltable_walk_enter(&fprobe_ip_table, &iter);
>  	do {
>  		rhashtable_walk_start(&iter);
>  
>  		while ((node = rhashtable_walk_next(&iter)) && !IS_ERR(node))
> -			fprobe_remove_node_in_module(mod, node, &alist);
> +			if (fprobe_remove_node_in_module(mod, node, &alist) < 0) {
> +				retry = true;
> +				break;
> +			}

Wrap the code within the "while" with {}?

Thanks!
Menglong Dong

>  
>  		rhashtable_walk_stop(&iter);
>  	} while (node == ERR_PTR(-EAGAIN));
> @@ -615,6 +598,8 @@ static int fprobe_module_callback(struct notifier_block *nb,
>  	if (alist.index > 0)
>  		fprobe_set_ips(alist.addrs, alist.index, 1, 0);
>  	mutex_unlock(&fprobe_mutex);
> +	if (retry)
> +		goto retry;
>  
>  	kfree(alist.addrs);
>  
> 
> 
> 




