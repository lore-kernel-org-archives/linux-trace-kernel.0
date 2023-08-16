Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3056C25B4F
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 16 Aug 2023 19:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbjHPTEU (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 16 Aug 2023 15:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345720AbjHPTEK (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:04:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D282270A;
        Wed, 16 Aug 2023 12:04:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A269E6246F;
        Wed, 16 Aug 2023 19:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F9BC433C7;
        Wed, 16 Aug 2023 19:04:03 +0000 (UTC)
Date:   Wed, 16 Aug 2023 15:04:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH] [v3] kallsyms: rework symbol lookup return codes
Message-ID: <20230816150407.3d5dbc40@gandalf.local.home>
In-Reply-To: <20230726141333.3992790-1-arnd@kernel.org>
References: <20230726141333.3992790-1-arnd@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, 26 Jul 2023 16:12:23 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 05c0024815bf9..a949f903c9e66 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6965,7 +6965,7 @@ allocate_ftrace_mod_map(struct module *mod,
>  	return mod_map;
>  }
>  
> -static const char *
> +static int
>  ftrace_func_address_lookup(struct ftrace_mod_map *mod_map,
>  			   unsigned long addr, unsigned long *size,
>  			   unsigned long *off, char *sym)
> @@ -6986,21 +6986,18 @@ ftrace_func_address_lookup(struct ftrace_mod_map *mod_map,
>  			*size = found_func->size;
>  		if (off)
>  			*off = addr - found_func->ip;
> -		if (sym)
> -			strscpy(sym, found_func->name, KSYM_NAME_LEN);
> -
> -		return found_func->name;
> +		return strscpy(sym, found_func->name, KSYM_NAME_LEN);
>  	}
>  
> -	return NULL;
> +	return 0;
>  }
>  
> -const char *
> +int
>  ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
>  		   unsigned long *off, char **modname, char *sym)
>  {
>  	struct ftrace_mod_map *mod_map;
> -	const char *ret = NULL;
> +	int ret;
>  
>  	/* mod_map is freed via call_rcu() */
>  	preempt_disable();


Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
