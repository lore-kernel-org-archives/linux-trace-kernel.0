Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CD32FE571;
	Thu,  8 Jan 2026 02:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839715; cv=none; b=p0cxuNmbpDzHadX5LQ+4sA6KDAN5Ypxv0ryDeg9xJhApZ/Z7xUMhjUBL4yZDgbpJa160yCXLAy/Jl2F3a2UPFYTenKBz/fGDfFsIqi19ZVvjOUUQp/zu1Of/JE3k1+kQGLeUZE+yAPfeZywSMYfV8nftdPeKAHESCDwJS7EJ0LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839715; c=relaxed/simple;
	bh=mwO0h8pxODHcoTt8zbXiEQOPVm+2tOSGeyNuIN4895E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CFxCSS13HR5btuoV0cUoJXEnhrHMIP2/UjX6NfV6Bom87pJNxQrenhjcPPjHaKkcxgVwDw8Q4MzTa5/N7FsX3VfZ/ATyKlJ3ki1dyukURi2frmtZmEWftj75M3gXNcHPUYKC+d4jJbxNLNR9hepoGEuOnytIbC75N3zqRY/bgkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJ8sf8Wp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJ8sf8Wp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BE9C4CEF1;
	Thu,  8 Jan 2026 02:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767839713;
	bh=mwO0h8pxODHcoTt8zbXiEQOPVm+2tOSGeyNuIN4895E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RJ8sf8Wp0rux6r70tlzGDqyyhXtmcBsDiHnDz4jroLF+C0FLPK+kB0Jhd5DNbXhuw
	 FSBt6lG3uvBrRstujmtSAvOvW7IKtci2XXpFIMTR2W4eZfzBgXrbMhMELvkH78SqI8
	 pkCBEK7tBUWL79E3wNKZ72fNkcJR52NgkMtoOuRSOwec04K4UUXAF+M1PHaNXkcg1p
	 4l2hE0eLb9I4nt+0oqn5JaxM6tr5TMRsFjfr8mbu/xPXFQrKG2rA1Mu6WWooIVtzZF
	 qL4domMDl+PVRO/Z3FOoWcDTeM46svN8Tlmo1Im8ish7yh+02l5cHpr7ZB4iNJ9e+s
	 oxrERWNWFK3bg==
Date: Thu, 8 Jan 2026 11:35:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Avoid possible signed 64-bit truncation
Message-Id: <20260108113510.5f0716c539f2ab416fd39ec9@kernel.org>
In-Reply-To: <20260108002625.333331-1-irogers@google.com>
References: <20260108002625.333331-1-irogers@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Jan 2026 16:26:25 -0800
Ian Rogers <irogers@google.com> wrote:

> 64-bit truncation to 32-bit can result in the sign of the truncated
> value changing. The cmp_mod_entry is used in bsearch and so the
> truncation could result in an invalid search order. This would only
> happen were the addresses more than 2GB apart and so unlikely, but
> let's fix the potentially broken compare anyway.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> Reduce the number of checks as suggested-by Steven Rostedt
> <rostedt@goodmis.org>.
> v1: https://lore.kernel.org/lkml/20251209224024.2322124-1-irogers@google.com/

Look good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> ---
>  kernel/trace/trace.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 6f2148df14d9..5e2d597b4377 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6109,10 +6109,10 @@ static int cmp_mod_entry(const void *key, const void *pivot)
>  	unsigned long addr = (unsigned long)key;
>  	const struct trace_mod_entry *ent = pivot;
>  
> -	if (addr >= ent[0].mod_addr && addr < ent[1].mod_addr)
> -		return 0;
> -	else
> -		return addr - ent->mod_addr;
> +	if (addr < ent[0].mod_addr)
> +		return -1;
> +
> +	return addr >= ent[1].mod_addr;
>  }
>  
>  /**
> -- 
> 2.52.0.351.gbe84eed79e-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
