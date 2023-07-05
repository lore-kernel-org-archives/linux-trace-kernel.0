Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFB9C001B1
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  5 Jul 2023 08:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjGEI0Q (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 5 Jul 2023 04:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjGEI0O (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:26:14 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F13ACA;
        Wed,  5 Jul 2023 01:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=lyqqJEhmF7h4jrFhQaGrt/1HLlCXldqjdpfuMALqFj4=; b=hGMjuGeyCmZ2/8EONhcVtWZIjb
        I+C14465VimKCFw2KgfH4hzQZOORHZNxhvd0I3vbbx/zCesajDRVxL2RQ4jkz+bS0cCMWob/6Rjaw
        KJI9s/qLH6X+2J21E9x1wH0e2VmXKfk5Taiaaz1DPsYjs2Yia2XTOgTV9+KeorWCUb//TIPiVRA2o
        DCz08TztMEifxP+d3sJ330BPy5PsVUU90Gh5MOn574got87Ev0IVt5ztvJycBWdatdOOQExESK3yG
        NLFoFf5rALvpm2Wee5dIbYcfGAa/61DfGAHYBrlHByEzk+f4hCPhMyzlOf5qmaaGr9JmBou8/i3Zu
        ohNugPzg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qGxpt-000CY7-QK; Wed, 05 Jul 2023 10:26:05 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qGxps-000Wgb-KQ; Wed, 05 Jul 2023 10:26:04 +0200
Subject: Re: [PATCH v6 bpf-next 06/11] bpf: Expose symbol's respective address
To:     Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
        rostedt@goodmis.org, mhiramat@kernel.org
Cc:     bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230628115329.248450-1-laoar.shao@gmail.com>
 <20230628115329.248450-7-laoar.shao@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a9170c05-4d32-beda-95a6-b8c4c39438ae@iogearbox.net>
Date:   Wed, 5 Jul 2023 10:26:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230628115329.248450-7-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26959/Tue Jul  4 09:29:23 2023)
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 6/28/23 1:53 PM, Yafang Shao wrote:
> Since different symbols can share the same name, it is insufficient to only
> expose the symbol name. It is essential to also expose the symbol address
> so that users can accurately identify which one is being probed.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>   kernel/trace/trace_kprobe.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index e4554dbfd113..17e17298e894 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1547,15 +1547,15 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
>   	if (tk->symbol) {
>   		*symbol = tk->symbol;
>   		*probe_offset = tk->rp.kp.offset;
> -		*probe_addr = 0;
>   	} else {
>   		*symbol = NULL;
>   		*probe_offset = 0;
> -		if (kallsyms_show_value(current_cred()))
> -			*probe_addr = (unsigned long)tk->rp.kp.addr;
> -		else
> -			*probe_addr = 0;
>   	}
> +
> +	if (kallsyms_show_value(current_cred()))
> +		*probe_addr = (unsigned long)tk->rp.kp.addr;
> +	else
> +		*probe_addr = 0;
>   	return 0;

Can't this be simplified further? If tk->symbol is NULL we assign NULL anyway:

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 1b3fa7b854aa..bf2872ca5aaf 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1544,15 +1544,10 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,

         *fd_type = trace_kprobe_is_return(tk) ? BPF_FD_TYPE_KRETPROBE
                                               : BPF_FD_TYPE_KPROBE;
-       if (tk->symbol) {
-               *symbol = tk->symbol;
-               *probe_offset = tk->rp.kp.offset;
-               *probe_addr = 0;
-       } else {
-               *symbol = NULL;
-               *probe_offset = 0;
-               *probe_addr = (unsigned long)tk->rp.kp.addr;
-       }
+       *probe_offset = tk->rp.kp.offset;
+       *probe_addr = kallsyms_show_value(current_cred()) ?
+                     (unsigned long)tk->rp.kp.addr : 0;
+       *symbol = tk->symbol;
         return 0;
  }
  #endif /* CONFIG_PERF_EVENTS */

