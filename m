Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A113224679C;
	Fri, 17 Apr 2026 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776435509; cv=none; b=AWyumeNXLS6SWkdkIBkJ5CpvQITtezwwfojNrRxgJgfV8J98htWSNorMtS5x8Uh4X/nZ5rnUJF5EfEMMdFS7BDgbAYtH9giXoPb/3GAFwvTW4zc6NAVa3PzE8FPWsz5jdG5OSO+Zi61SN9xwl0VREPJoBKTjkM0miGaFjuI12ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776435509; c=relaxed/simple;
	bh=gHVrVANEVRPGF2u/nWKl1Ar0wHhvfIux7UuyA5DPf6A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0zFJLw3H6C0QCcJHiFs54XvWuPDgYE72xX9/mjsRrlPW3yaI1jsjZtDCkkbVyAXTeJENwmk4tmK3ZLfhAU0KsOj+uVdx4RoCb9NxMN+HGw3P+8iJN6vqj2wgyyWmaJD5FbLH+MBy3wx9d5hFQHgbWoN/7pUTNQjA+/G/9f84s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id C6B241401E5;
	Fri, 17 Apr 2026 14:18:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 60D3620025;
	Fri, 17 Apr 2026 14:18:17 +0000 (UTC)
Date: Fri, 17 Apr 2026 10:18:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Xiang Gao <gxxa03070307@gmail.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Xiang Gao <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH] ftrace: fix use-after-free of mod->name in
 function_stat_show()
Message-ID: <20260417101814.22d5c21b@fedora>
In-Reply-To: <20260416083335.920555-1-gxxa03070307@gmail.com>
References: <20260416083335.920555-1-gxxa03070307@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zamambch6m5puwrpk13pts4ik9f7h7wp
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 60D3620025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18SLyK75PmSHl7DVyw/yTbWwK9ZCs00PW8=
X-HE-Tag: 1776435497-768123
X-HE-Meta: U2FsdGVkX1+ZME+5eMltPv0Ya7gi5TnlrNgiW3So55WYUfnRhU5/x6GJ0s7HxTzFeIJ9FuoZHN8ptLEdrLub37Vpj2feHHHRRHN8qBwCzMqTGyElt3L3LVIaucu4+4IpnWtIbNz9hFFoyeNJRsrIr0Y32qoURLTULkrBX09HOT2F13asXRH07bWdy1jy4pqpd3NDD1cfvQFww27gMBkwnpU5P4/7EdAYKmtyEmQ5w6lkik3B78ggID3RMIrmc0IMEuMK0M/RB/9PIXrqgRleM3L3Pbv/rlVCMBM1ZPxOBMCQ3GFyeisyrQfsvqipY8NHAxwDQnthJsxwabqSrI+P9t9xlohGWSWHqWINoLVXTv+jhY/k+QCs/Q==


The tracing subsystem expects subjects to start with a capital letter:

  ftrace: Fix use-after-free of mod-name in function_stat_show()


On Thu, 16 Apr 2026 16:33:35 +0800
Xiang Gao <gxxa03070307@gmail.com> wrote:

> From: Xiang Gao <gaoxiang17@xiaomi.com>
> 
> function_stat_show() uses guard(rcu)() inside the else block to hold
> the RCU read lock while calling __module_text_address() and accessing
> mod->name. However, guard(rcu)() ties the RCU read lock lifetime to
> the scope of the else block. The original code stores mod->name into
> refsymbol and uses it in snprintf() after the else block exits,
> at which point the RCU read lock has already been released. If the
> module is concurrently unloaded, mod->name is freed, causing a
> use-after-free.
> 
> Fix by moving the snprintf() call into each branch of the if/else,
> so that mod->name is only accessed while the RCU read lock is held.
> refsymbol now points to the local str buffer (which already contains
> the formatted string) rather than to mod->name, and is only used
> afterwards as a non-NULL indicator to skip the kallsyms_lookup()
> fallback.

Was AI used for any part of this patch? Including finding the bug? If
so, it must be disclosed.

> 
> Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
> ---
>  kernel/trace/ftrace.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 413310912609..6217b363203c 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -559,21 +559,23 @@ static int function_stat_show(struct seq_file *m, void *v)
>  		unsigned long offset;
>  
>  		if (core_kernel_text(rec->ip)) {
> -			refsymbol = "_text";
>  			offset = rec->ip - (unsigned long)_text;
> +			snprintf(str, sizeof(str), "  %s+%#lx",
> +				 "_text", offset);
> +			refsymbol = str;
>  		} else {
>  			struct module *mod;
>  
>  			guard(rcu)();

Just move guard(rcu) out of this if statement to include the below
reference. No need to make the code worse. This really looks like AI
slop :-(

-- Steve


>  			mod = __module_text_address(rec->ip);
>  			if (mod) {
> -				refsymbol = mod->name;
>  				/* Calculate offset from module's text entry address. */
>  				offset = rec->ip - (unsigned long)mod->mem[MOD_TEXT].base;
> +				snprintf(str, sizeof(str), "  %s+%#lx",
> +					 mod->name, offset);
> +				refsymbol = str;
>  			}
>  		}
> -		if (refsymbol)
> -			snprintf(str, sizeof(str), "  %s+%#lx", refsymbol, offset);
>  	}
>  	if (!refsymbol)
>  		kallsyms_lookup(rec->ip, NULL, NULL, NULL, str);

