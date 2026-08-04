Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC7032E6BD;
	Tue,  4 Aug 2026 23:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785885292; cv=none; b=McDqYfgLtX++vrTL7FL8MgQfdjeREV6prVHrFEUR3aCOD6LTfrEoC2xrUgmYbwj7EK31BB+p8d1/nBOJdumq+yOAf7LO9Xk61RRM3jA3/RR5aq5uPfC4nQk0Q5MQQjyM5ABwKMVD9pua590fkW8tE2GOrqXSnLlxNdlGgU0S6+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785885292; c=relaxed/simple;
	bh=z9Vr4Kg4aCHB7cu9ouMnGwHLIN3IxGjt34nEzA5uro0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=m66KtRgpLxbHR02H1z0TvvOFW+mEboL9N4yaARjUWQsR2wG/FwyDuxz7NAv4/TPUqCvPBSaQdeWC5H0MjZvG9WWkHASZoKaDYyzB28hBAxKjH2QgQKiMYIfaSQNP+MUhadfb2URAq8SpceVryVODhLfp+bFgudFps/H1hQDsOwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnpFcQaa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnpFcQaa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0CA1F000E9;
	Tue,  4 Aug 2026 23:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785885291;
	bh=MBUcJ70lDBR/ONvs7oswiz6e67cFR4LzMlZK65HjRxs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QnpFcQaa/7wZPNaZF+xiLZPPitk8z/guGa/4HvNjGCLU8MqkJk+uwU5/9TCYIzvbZ
	 Y5U7SkUFWlIpIoEF4DzdqiG1Z0AYxelGylWZXMkqVu8snfXex6krnKI3LUEOHWg8wK
	 2PeauoFQu+s2/CsAfeg8W4xJo4mqNcrQP9Hu2dg+BE+rRPvGGTMfmFBe4p0ExnBMNP
	 iyKdS5AafTeX/dpyms2BMBoFpCM3mvmrJZWEy+CHemHUBUlszNQ13l0HMrviH79uLY
	 E6YNqlPORKPzcKvyz7GIYhk/Qjp/9XOJp3WQS5r9DtMCMO22HBusjuAM91ALZd3EzR
	 fdgxaKdtOJgfw==
Date: Wed, 5 Aug 2026 08:14:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, kernel
 test robot <oliver.sang@intel.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: refactor eprobes test to fix argument
 checks
Message-Id: <20260805081447.128b24864b77af9683e801de@kernel.org>
In-Reply-To: <20260804194705.760893-1-martin@kaiser.cx>
References: <20260804194705.760893-1-martin@kaiser.cx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Aug 2026 21:46:35 +0200
Martin Kaiser <martin@kaiser.cx> wrote:

> The add/remove eprobe test installs an eprobe for the openat syscall and
> runs ls. It checks the filenames that were opened by ls against a
> whitelist and a blacklist.
> 
> Commit 206b25c09080 ("tracing: eprobe: read the complete FILTER_PTR_STRING
> pointer") fixed access to some string fields in eprobes. This triggers
> test failures as the blacklist does not allow relative paths for the
> openat parameters.
> 
> What makes this test unstable is the fact that the openat calls vary a
> lot between different systems.
> 
> Refactor the test to make it more robust. "cd <directory>" will issue a
> chdir syscall with the target directory as parameter. Set an eprobe on
> the sys_enter_chdir event and filter for the exact directory name. Allow
> (fault) as fallback.
> 
Looks good to me.

Fixes: 206b25c09080 ("tracing: eprobe: read the complete FILTER_PTR_STRING pointer")

Since it is already merged to linus tree.
Let me pick it.

> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202607151010.b68428e1-lkp@intel.com
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Thanks!

> ---
>  .../ftrace/test.d/dynevent/add_remove_eprobe.tc  | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
> index c300eb020262..e2322693d0c3 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
> @@ -1,16 +1,16 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: Generic dynamic event - add/remove eprobe events
> -# requires: dynamic_events events/syscalls/sys_enter_openat "<attached-group>.<attached-event> [<args>]":README
> +# requires: dynamic_events events/syscalls/sys_enter_chdir "<attached-group>.<attached-event> [<args>]":README
>  
>  echo 0 > events/enable
>  
>  clear_dynamic_events
>  
>  SYSTEM="syscalls"
> -EVENT="sys_enter_openat"
> +EVENT="sys_enter_chdir"
>  FIELD="filename"
> -EPROBE="eprobe_open"
> +EPROBE="eprobe_chdir"
>  OPTIONS="file=+0(\$filename):ustring"
>  echo "e:$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
>  
> @@ -18,20 +18,14 @@ grep -q "$EPROBE" dynamic_events
>  test -d events/eprobes/$EPROBE
>  
>  echo 1 > events/eprobes/$EPROBE/enable
> -ls
> +cd /sys/kernel/tracing
>  echo 0 > events/eprobes/$EPROBE/enable
>  
> -content=`grep '^ *ls-' trace | grep 'file='`
> -nocontent=`grep '^ *ls-' trace | grep 'file=' | grep -v -e '"/' -e '"."' -e '(fault)' ` || true
> -
> +content=`grep -e 'file="/sys/kernel/tracing"\|(fault)' trace`
>  if [ -z "$content" ]; then
>  	exit_fail
>  fi
>  
> -if [ ! -z "$nocontent" ]; then
> -	exit_fail
> -fi
> -
>  echo "-:$EPROBE" >> dynamic_events
>  
>  ! grep -q "$EPROBE" dynamic_events
> -- 
> 2.43.7
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
