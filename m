Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A92A451062;
	Wed, 13 May 2026 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684397; cv=none; b=CDSuJzglmay+HPpxHvN015WRy8NZD1j40X+S+wkg41eYzzDxbMMwcSNVNvLbvjk3hiGW0zGEmjRXojFcQMq+kwn2bqFcBeYKrTVNgs++gy4DPUcIM2WmwKJF7yQV8j6YmafAF2BPJt44MyFizhuQApn1KlEx/Ox7sHbBJvBRfz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684397; c=relaxed/simple;
	bh=GMDlgJH93DvxWckoM67X7tcpwo+mnwJkIInKhw+ZGSc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xl/cJam4/xsQk7P7MlRVKrOUQcjQadxZShWOnHT6v7UWTCAS6x57wuhBKuiZk4UdtAI0KIZriM3cod8jkgB/m7EjZDiSxzDCOHsuId6mkDip7fg6Q57gdQ5FfIrIXVS8GCqlwuQ/5nBz1s45PZzJ2jJmYJB0G8WF3SuHwk0iIY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 0D8994016D;
	Wed, 13 May 2026 14:59:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id E01A120015;
	Wed, 13 May 2026 14:59:36 +0000 (UTC)
Date: Wed, 13 May 2026 10:59:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Marc Zyngier <maz@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: samples: avoid warning about
 __aeabi_unwind_cpp_pr1
Message-ID: <20260513105939.3bbdc174@gandalf.local.home>
In-Reply-To: <20260323105646.590718-1-arnd@kernel.org>
References: <20260323105646.590718-1-arnd@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E01A120015
X-Stat-Signature: xr9333hza3uzmm4871w7qej56tz7y3cq
X-Rspamd-Server: rspamout01
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX197IoFTOok/1yyP+GJkcRZZLi7eGY9KJds=
X-HE-Tag: 1778684376-103969
X-HE-Meta: U2FsdGVkX18x5dUHK+zjobqA7Ypu8qBrjnmWIaKF00iWCbJJE5w3pDSmHlY5w7Dj9ypzU7UvnBfWn+wtT9f8SHK3SUXFz/ayLmsb4Mmc0E7NtfP5WBjKF3I3LzHmcmfVbH5Qi/Ag9EtUwwQrMSJ8PZvGeKFf4O0ZtDrMYdli4Or2jNUhJtSbXsmtia3Ukugk5rzqyCYdecLsPeCaYNw7/cmm1XxgqZOvJGHjUGmuNJoGS4uOJFluu/WxN1TxT2+p2YogtctEhmkocIzhXXvksnerSImGhmd4OEtRcPPnHzh4AwNGCrGKuuLyPurkTanne0GxF61ZHkRcZkWkrAA1R24Yobll5We3


Vincent,

Is this patch needed? That is, did it fall through the cracks?

-- Steve

On Mon, 23 Mar 2026 11:56:41 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The now more verbose check found another symbol missing from the whitelist:
> 
> Unexpected symbols in kernel/trace/simple_ring_buffer.o:
>          U __aeabi_unwind_cpp_pr1
> 
> Add this to the Makefile.
> 
> Fixes: 1211907ac0b5 ("tracing: Generate undef symbols allowlist for simple_ring_buffer")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/trace/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index d662c1a64cd5..aba6a25db17b 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -169,8 +169,8 @@ targets += undefsyms_base.o
>  # because it is not linked into vmlinux.
>  KASAN_SANITIZE_undefsyms_base.o := y
>  
> -UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sancov __sanitizer __tsan __ubsan __x86_indirect_thunk \
> -		      __msan simple_ring_buffer \
> +UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sancov __sanitizer __tsan __ubsan __msan \
> +		      __x86_indirect_thunk __aeabi_unwind_cpp simple_ring_buffer \
>  		      $(shell $(NM) -u $(obj)/undefsyms_base.o 2>/dev/null | awk '{print $$2}')
>  
>  quiet_cmd_check_undefined = NM      $<

