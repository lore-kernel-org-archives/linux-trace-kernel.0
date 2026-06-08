Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8623AB48C;
	Mon,  8 Jun 2026 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907271; cv=none; b=cp73khbmtZ8FmI2G/ZQcJo/ID0k/GhPGg5YrJr5qwMK5NvHxVthByztSwDxk048fAZcuhAvi1V65hSRGWHcRVFITFZLb6akL5mBH6k9ypKbNutvpdKCwP64kCp2untePQ4nNbfq7/0gGaoGdoE1dQ0ST0cwlTJHLugCQHsbsLLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907271; c=relaxed/simple;
	bh=/t/xJdtAWTaDPwRNaWt2epAUcxPd+NEbf93BRmgUAsk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=u9wXufUlwt3Qlb1WIrPMqRbSS1bxQc8B9Bw4WQtMONbU5JiTc2495RVS4Yg+4o3TPxHrP5klMdc/nf/sNXBOhu0+Pknuv0q0nZulp7tDTDkQD2Ykbsj62ysfugvtBE9IhtEkHmgioxNJUe/JqhnUVQU7F5ViwciImmeyrxC9TXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQw/QYqq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQw/QYqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349151F00893;
	Mon,  8 Jun 2026 08:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780907268;
	bh=be3USqyEAEBwthW31cloS67ZoJ2ILFEHZHHBneQyJJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IQw/QYqqb/z40OYsibg8ngFRPnjugvWez4kryKBdvrxVrnIcqbwfy23mfcqqEQ7m3
	 jxZZkAyiMnvyVT3+y+6aa6hilVh5bD9KeZN8ix+f6rb3ZngZax1N7by5ZUUK93WFsX
	 L0TCCe7A5ysn9Q7GvZGGv08SJO+K+6fyc3iv+Q9EfY1PZbEToUwakuPZu79o0wApeA
	 1Wl5EQ9HkxHepqbgYSJagVL4Wau8ngz5o8heWO3PKE5UUEPA4n857y+K16UI/rPj3v
	 86SHEbSYH5fbpxd7UGRL06lGk0G5gtE9i6GuxQJCwc4RbrdUlJ4R2/IkA+EWSIYgSu
	 2HWLcbEtk50uA==
Date: Mon, 8 Jun 2026 17:27:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH next] kernel/trace/trace_printk: Use kstrdup() instead
 of kmalloc() and strcpy()
Message-Id: <20260608172743.d77d5115b9f7370d6e1c424d@kernel.org>
In-Reply-To: <20260606202633.5018-34-david.laight.linux@gmail.com>
References: <20260606202633.5018-34-david.laight.linux@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  6 Jun 2026 21:26:28 +0100
david.laight.linux@gmail.com wrote:

> From: David Laight <david.laight.linux@gmail.com>
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
> 
> They are mostly replaced by strscpy() or, when strlen() has just been
> called, with memcpy() (usually including the '\0').
> 
> Calls with copy string literals into arrays are left unchanged.
> They are safe and easily detected as such.
> 
> The changes were made by getting the compiler to detect the calls and
> then fixing the code by hand.
> 
> Note that all the changes are only compile tested.
> 
> Some Makefiles were changed to allow files to contain strcpy().
> As well as 'difficult to fix' files, this included 'show' functions
> as they really need to use sysfs_emit() or seq_printf().
> 
> All the patches are being sent individually to avoid very long cc lists.
> Apologies for the terse commit messages and likely unexpected tags.
> (There are about 100 patches in total.)
> 

This looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

>  kernel/trace/trace_printk.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
> index 3ea17af60169..98171a2398e4 100644
> --- a/kernel/trace/trace_printk.c
> +++ b/kernel/trace/trace_printk.c
> @@ -71,10 +71,9 @@ void hold_module_trace_bprintk_format(const char **start, const char **end)
>  		fmt = NULL;
>  		tb_fmt = kmalloc_obj(*tb_fmt);
>  		if (tb_fmt) {
> -			fmt = kmalloc(strlen(*iter) + 1, GFP_KERNEL);
> +			fmt = kstrdup(*iter, GFP_KERNEL);
>  			if (fmt) {
>  				list_add_tail(&tb_fmt->list, &trace_bprintk_fmt_list);
> -				strcpy(fmt, *iter);
>  				tb_fmt->fmt = fmt;
>  			} else
>  				kfree(tb_fmt);
> -- 
> 2.39.5
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
