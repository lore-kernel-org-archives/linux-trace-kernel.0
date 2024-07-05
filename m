Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B91143C41;
	Fri,  5 Jul 2024 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720163435; cv=none; b=C4XCKgs3i1YSTWAVIo3LsGyFr0VUr2yc8z64pAqnmfVSLhE/BkYAjJvh+ITbybv9NmQ0ix0TzwvW4zAUTzfBOgVUlwy5uUFbL4fy7PmOlnLok1LnnPwMNr41p2Q6iqG81pFhmsbnYRQkO/LF6nvU3gsr1v2f2ddO37pQhIMdRac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720163435; c=relaxed/simple;
	bh=FXypFo382SIXThuXCUwX7hvFYjAAaZul3NTblqc7hn8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nHKd2nP4fxAMhNfiUD1q+Ybt7qZFAL8YJBNsaX0AIBiqHTt8gBoSmoQPuJWWsoXVIaiCiy0FMwErAVfrvJ+/z+rvGau+CjQ+3oFMspTbzCmlb8CDv1GltelC35f72UoJtFfYZL6eR4eULlzyi8e9mifPQaPQ5SZ7i1t8N80mp18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBNPC1wx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBNPC1wx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7FFC32786;
	Fri,  5 Jul 2024 07:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720163434;
	bh=FXypFo382SIXThuXCUwX7hvFYjAAaZul3NTblqc7hn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jBNPC1wxwVjFy+4oHxB3t0qmoHVmERtBps8NjFYfeBto6wvCAKNkH/0sDp/iX7+MD
	 QZgxvH+j/zgTmQjW6bqLTcwzGarRfQ3I5URK516qArFsKhX8ipLeYU+IABcqa8sU+w
	 l9Az9iG38HF/xnv/VLoDy/geWfGP5RUjdq6RrtpH6Vh4WYMqn4WYBb2UEdzwYQNnQs
	 RPZepyEn5Ya6vKdbx4za8MP4haMFmiEH9p4ldDG16lna4xssH/4ksfLWIQdYOisZRe
	 hAWtiIYpxBhldedl4ynisCH9tzBt35hRN1rQNkx/CtUh8IunW6G4DrQ2ynYp/A8ZdL
	 Y0/6LPXij2VPA==
Date: Fri, 5 Jul 2024 16:10:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Francis Laniel
 <flaniel@linux.microsoft.com>
Subject: Re: [PATCH] tracing/kprobes: Add missing check for skipping symbol
 counting logic
Message-Id: <20240705161030.b3ddb33a8167013b9b1da202@kernel.org>
In-Reply-To: <20240704164336.1176281-1-kniv@yandex-team.ru>
References: <20240704164336.1176281-1-kniv@yandex-team.ru>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Nikolay,

Thanks for the patch! But this remind me that I forgot to send a patch
which can solve this issue more generically.

https://lore.kernel.org/all/171338679446.616570.14456856697191949345.stgit@devnote2/

Why I did not send it...? Anyway let me send the update.

Thank you,


On Thu,  4 Jul 2024 19:43:36 +0300
Nikolay Kuratov <kniv@yandex-team.ru> wrote:

> In commit b022f0c7e404
> ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
> it was already done for symbol in __trace_kprobe_create(), but func in
> create_local_trace_kprobe() is also valid usage.
> Not doing so leads to ENOENT for module_name:symbol_name
> constructions passed over perf_event_open().
> 
> Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
> ---
>  kernel/trace/trace_kprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 16383247bdbf..3f4c9195dc0d 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1834,7 +1834,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
>  	int ret;
>  	char *event;
>  
> -	if (func) {
> +	if (func && !strchr(func, ':')) {
>  		unsigned int count;
>  
>  		count = number_of_same_symbols(func);
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
