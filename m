Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3B17485;
	Fri, 20 Jun 2025 00:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750380079; cv=none; b=GHW6B68fH6K6EJsLxsetBP/8NaBiY4affiXUJeNVWeujPxbcSo2OF771lrlB8lcLx6X59KRXvYcoNkeb8i/wyLGd58yQ6D8RZqgd4thB1xOb5VPcXZ/NRw7LcT5Wertr6mLNXMN6EfJJ4LN6O2T8qTYYp3HzLSdsdaJyj5BERIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750380079; c=relaxed/simple;
	bh=+3CHGjIM+Mr+pVGKhzmNeZi41Rr2EggZ3gp53Y6Wi1g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FvRdTeexeTTQ4/i65scJIav6HQKRJsG0gQ9q00D5tviJBcQPD7i8721lX6dVnp120f5YSUEQvo6ZzwuKIVHvbUd2pVDeHsxzF4uARBjC95o2iha6o9Fn3VbM4bDP8d6cAnNPmPVDxG0y+y8+oA9F99ANXDyOkb+KV0ffBw1pqxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/WMn6SV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/WMn6SV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FDFC4CEEA;
	Fri, 20 Jun 2025 00:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750380079;
	bh=+3CHGjIM+Mr+pVGKhzmNeZi41Rr2EggZ3gp53Y6Wi1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M/WMn6SVuP+u5/SFJBpyzTJFMcNyPoxrKhOIQtECO3z4mpG3ocURkDWFKGo9DppC2
	 0WKDK1XDKV9drzyHE5TabrD5I/nBz1uZBOadgqY8MULiwcbYfiSOco8BPLP+KhUi+T
	 rb9F4tw6F97kpk7NIjNf9pa4LuKbaZU8pCErk2+dd2MnXBIx1x8Vqj+dG+vpOmymDm
	 hzR5GPMNdbFK+MMt4qWaKzgkvRiW7Sle+nw3Bat2t3vIZc1JUH08UDATQafIzYzVdl
	 ihubzytYA7iWfT4os6R9Ytl3S/QEVJ0ZW1jjqgiB1F56KlsWN47d0sfxwN2Y1JCw1C
	 E/Eq5ElaQJCbQ==
Date: Fri, 20 Jun 2025 09:41:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tools:bootconfig:scripts: Put back the comments where
 they should be
Message-Id: <20250620094116.366eff08bc65f682cc1da74b@kernel.org>
In-Reply-To: <20250521115018.32392-1-unixbhaskar@gmail.com>
References: <20250521115018.32392-1-unixbhaskar@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 May 2025 17:16:51 +0530
Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

> Mundane adjustment to the comments, where they should belong.
> 
> Does it change the functionality? NO
> 
> Does it improve the readability? Probably and that is why.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  tools/bootconfig/scripts/ftrace.sh | 35 ++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/bootconfig/scripts/ftrace.sh b/tools/bootconfig/scripts/ftrace.sh
> index 186eed923041..e2a075879db4 100644
> --- a/tools/bootconfig/scripts/ftrace.sh
> +++ b/tools/bootconfig/scripts/ftrace.sh
> @@ -1,23 +1,28 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> 
> -clear_trace() { # reset trace output
> -    echo > trace
> + # reset trace output
> +clear_trace() {
> +
> +	 echo > trace
>  }
> 
> -disable_tracing() { # stop trace recording
> +# stop trace recording
> +disable_tracing() {
>      echo 0 > tracing_on
>  }
> 
> -enable_tracing() { # start trace recording
> +# start trace recording
> +enable_tracing() {
>      echo 1 > tracing_on
>  }
> 
> -reset_tracer() { # reset the current tracer
> +# reset the current tracer
> +reset_tracer() {
>      echo nop > current_tracer
>  }
> 
> +# remove action triggers first
>  reset_trigger_file() {
> -    # remove action triggers first
>      grep -H ':on[^:]*(' $@ |
>      while read line; do
>          cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
> @@ -32,21 +37,25 @@ reset_trigger_file() {
>      done
>  }
> 
> -reset_trigger() { # reset all current setting triggers
> +# reset all current setting triggers
> +reset_trigger() {
>      if [ -d events/synthetic ]; then
>          reset_trigger_file events/synthetic/*/trigger
>      fi
>      reset_trigger_file events/*/*/trigger
>  }
> 
> -reset_events_filter() { # reset all current setting filters
> +# reset all current setting filters
> +reset_events_filter() {
>      grep -v ^none events/*/*/filter |
>      while read line; do
>  	echo 0 > `echo $line | cut -f1 -d:`
>      done
>  }
> 
> -reset_ftrace_filter() { # reset all triggers in set_ftrace_filter
> +# reset all triggers in set_ftrace_filter
> +

Why this has an empty line after comment?

> +reset_ftrace_filter() {
>      if [ ! -f set_ftrace_filter ]; then
>        return 0
>      fi
> @@ -78,17 +87,21 @@ disable_events() {
>      echo 0 > events/enable
>  }
> 
> -clear_synthetic_events() { # reset all current synthetic events
> +# reset all current synthetic events
> +

Ditto.

> + clear_synthetic_events() {
>      grep -v ^# synthetic_events |
>      while read line; do
>          echo "!$line" >> synthetic_events
>      done
>  }
> 
> -initialize_ftrace() { # Reset ftrace to initial-state
> +# Reset ftrace to initial-state
>  # As the initial state, ftrace will be set to nop tracer,
>  # no events, no triggers, no filters, no function filters,
>  # no probes, and tracing on.
> +

Here too.

> +initialize_ftrace() {
>      disable_tracing
>      reset_tracer
>      reset_trigger
> --
> 2.49.0
> 

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
