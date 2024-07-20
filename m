Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E1F946C
	for <linux-trace-kernel@vger.kernel.org>; Sat, 20 Jul 2024 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721490776; cv=none; b=KXQ6vbZj+X4A9nGJmIKqdnAePSTsNAlt3IO7aF+DExQF/q51NhtTHhLIa96FEtIbslgFgmNVrZTRs8SZDj03IIDhKn0Woex9iRGZI7AAXKYEC585oqhi83gdCZHbOZzxAhcGBQ4tV1U9o04dF7OOH56zDoFK7wJhsyyrRjt1qjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721490776; c=relaxed/simple;
	bh=srZx9P49tkcXXP6EyGkWVlnmXXFOW2xRRQGVvtpPnxA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kVA6B+SRSziAQoInC3EKCOKO76NABx5igpot0lOSv6/r17QtVioHqKX8FFwdZcG0xxZUava4PrZhKp8AHl0wDzy8ByFn5WIfEF/j33Hf1jGODP9/FMmnTy6EmK+gKaNMjEZp9R5kKcmYZnQkIJ3Y2YxQy+SS5EQDIooGOd1yG/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld+TArm9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld+TArm9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A134C2BD10;
	Sat, 20 Jul 2024 15:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721490775;
	bh=srZx9P49tkcXXP6EyGkWVlnmXXFOW2xRRQGVvtpPnxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ld+TArm9ku21GBxx6Mr/DPgk/z0yMRfYE+q4qulYHUQE9FOswjmaMzC2m0mw3/vto
	 XiVLTDbUahmys0bO8L3YCJeKPyfeqk5wePEGEG7BaeTr44qPrfmU/RHG6L7+JP2005
	 MuX+z8TVadCAmanyzV4OKNq3b3ElEOCt1C44qcGE7CHXaYnN2c2GWwls6uAW+ybtOY
	 G9Im6ol8ur2gwCOCLdwC0tVKqPmjBFIkdGYAeDjvC90eA7dJbZvGrzB4l3DLzZ6uHf
	 6mdBpxRuRDVZknzdkGYMgMKihmk4+qOrYDDepQ/2dXY4dTsi8GrqGma+HmsOSZfo4+
	 CRQuE42xGUcjA==
Date: Sun, 21 Jul 2024 00:52:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [bug report] tracing/kprobes: Add symbol counting check when
 module loads
Message-Id: <20240721005252.3a5face397b8c4f8096d363b@kernel.org>
In-Reply-To: <1c775c89-42fe-4c86-ac6d-d97170885ae8@stanley.mountain>
References: <1c775c89-42fe-4c86-ac6d-d97170885ae8@stanley.mountain>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 13:30:57 -0500
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Hello Masami Hiramatsu (Google),
> 
> Commit 9d8616034f16 ("tracing/kprobes: Add symbol counting check when
> module loads") from Jul 5, 2024 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	kernel/trace/trace_kprobe.c:828 validate_probe_symbol()
> 	warn: missing error code here? 'try_module_get_by_name()' failed. 'ret' = '0'
> 
> kernel/trace/trace_kprobe.c
>     815 static int validate_probe_symbol(char *symbol)
>     816 {
>     817         struct module *mod = NULL;
>     818         char *modname = NULL, *p;
>     819         int ret = 0;
>     820 
>     821         p = strchr(symbol, ':');
>     822         if (p) {
>     823                 modname = symbol;
>     824                 symbol = p + 1;
>     825                 *p = '\0';
>     826                 mod = try_module_get_by_name(modname);
>     827                 if (!mod)
> --> 828                         goto out;
> 
> Is it intentional that "ret = 0;" here?

Yes, hm, I dropped an important message here. If you see the commit
9d8616034f16, you can see there was;

/* Return 0 (defer) if the module does not exist yet. */

So it is intentional.

But thanks for reporting. It should be cleaned up.

Thank you,

> 
>     829         }
>     830 
>     831         ret = validate_module_probe_symbol(modname, symbol);
>     832 out:
>     833         if (p)
>     834                 *p = ':';
>     835         if (mod)
>     836                 module_put(mod);
>     837         return ret;
>     838 }
> 
> regards,
> dan carpenter


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
