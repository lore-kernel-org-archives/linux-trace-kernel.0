Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADAB6F305
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758676982; cv=none; b=fzYlrXLl3XDw825Las6pLkch6VDSTgPNTACEpdyWzKTkXGaiRQ2aq+1S0Q2HgKYfo4uAAMzzoF8RIF5ZXpTZ6Tl3GaLJI/LkzP0VptSipbgs7vUaWIVYvQOM4mXUfBdY9h3EcKhz6yU9nLZNxhX0H3s7sjez/iO0iXv+oPkGnmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758676982; c=relaxed/simple;
	bh=TgwuxGsn8VB4YZPmw2l+tOHTsIx/q0QGWyZEgrYeFH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+QG6LYkTTdSaB2Fg2oqZWN4h66oVWKhhX+5PyENLu8sMJPM/ozCD3/1xFiWm/1YFMuCH0QIStFEp3qZe+lyAgdPZsr+pD6Y7O7DkqCPQOtxTGa8lWNmeu8e4Ku/Xxrp9GyRVkvZVNLdZHnple254YWzRfaxQNDcbjZltjH/iWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vE8BijtI; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vE8BijtI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758676977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lau8/UwGF11EKFVgHgGuhNYWYNkTOFSSckmL4qmixzM=;
	b=vE8BijtIke7QuJ6DsZzARjSLXpvnPuprDCEN/BCHmZAqPmsAuhOb5W405Sxd1nwGwnCj+Q
	04O3AJXRZWXWuzPma6yUp4uHqJ6JAqFW9yWNea9i9DBcflQj+x6g0N2SMCagvAZ6HGIydg
	gzWNsZX7VtJ2DZ8Unm0WzRo6yodK9l4=
From: menglong.dong@linux.dev
To: Steven Rostedt <rostedt@goodmis.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: fprobe: Remove unused local variable
Date: Wed, 24 Sep 2025 09:22:47 +0800
Message-ID: <12748427.O9o76ZdvQC@7940hx>
In-Reply-To: <175867358989.600222.6175459620045800878.stgit@devnote2>
References: <175867358989.600222.6175459620045800878.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/9/24 08:26 Masami Hiramatsu (Google) <mhiramat@kernel.org> write:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> The 'ret' local variable in fprobe_remove_node_in_module() was used
> for checking the error state in the loop, but commit dfe0d675df82
> ("tracing: fprobe: use rhltable for fprobe_ip_table") removed the loop.
> So we don't need it anymore.
> 
> Fixes: dfe0d675df82 ("tracing: fprobe: use rhltable for fprobe_ip_table")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/fprobe.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 6a205903b1ed..12ec194fdfed 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -457,8 +457,6 @@ static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long ad
>  static void fprobe_remove_node_in_module(struct module *mod, struct fprobe_hlist_node *node,
>  					 struct fprobe_addr_list *alist)
>  {
> -	int ret = 0;

Acked-by: Menglong Dong <menglong8.dong@gmail.com>

Thanks~

> -
>  	if (!within_module(node->addr, mod))
>  		return;
>  	if (delete_fprobe_node(node))
> @@ -467,8 +465,7 @@ static void fprobe_remove_node_in_module(struct module *mod, struct fprobe_hlist
>  	 * If failed to update alist, just continue to update hlist.
>  	 * Therefore, at list user handler will not hit anymore.
>  	 */
> -	if (!ret)
> -		ret = fprobe_addr_list_add(alist, node->addr);
> +	fprobe_addr_list_add(alist, node->addr);
>  }
>  
>  /* Handle module unloading to manage fprobe_ip_table. */
> 
> 
> 




