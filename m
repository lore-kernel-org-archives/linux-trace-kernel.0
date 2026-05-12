Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A1739FD9;
	Tue, 12 May 2026 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545002; cv=none; b=qa8auuR/NFpY9XJWy4oPTygWEsIAUafz+lomtiA/C/7wFiWjKYruYWydGwT2IoQAbTpTMG/Xs+owXTlFZUwUAy8l1ExJlsuhdOX86RjVjPDWKFGYGyHGGqOrsACTsLnznfYOlPv2fb/Kqr8TBezQLnXfcsbAW9PPbCvAKFeEBb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545002; c=relaxed/simple;
	bh=oOz5EXdk6rMc/V0s+CRCekTvAdYe44DJ42tAZEbuREU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JoZanueLLWPWPcinNRB25hLGpF0tyVrni4XkxqSVvqPob63UTvz4DrG3q7e9K9LrxxJVcnM6ZG3PJSOT4PGEkJkKxnPfYQlksXTe6D9zjx5gvKwfCG+/PvSRW6Y/OyROVS/V+n+xQcVW80obH8rHR2J3wO/9WjDRsgX4G5g7hvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIN9TG6/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIN9TG6/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B915EC2BCFB;
	Tue, 12 May 2026 00:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778545002;
	bh=oOz5EXdk6rMc/V0s+CRCekTvAdYe44DJ42tAZEbuREU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IIN9TG6/KAa+QS6omXwg9xQJWFIqUI6sYtPx8jOYe7YgsAEk40n8aMCpNusK8IXdc
	 R77sIGKRoQbmpyLgd2E/oYI1f2c0qLvUfw+rYBzwCuIJoshfIHlbiDZV8veyCNMY5Q
	 ZoTlXiWf2YV+U891k8WAkbhQ7Xn4wYfIbOKBT/G+RonXyHMVGEYeAKrhscNAjlYY+S
	 rp7HOaLVR8Oxv6xeJDnKP1ONeT1EBa5OZXlJj45+7+2KTgy2LMbIwzOIdp5iA3HskV
	 DyexfTpYEzHVb1YgD01/9pfofarMrO78j6NSE7EB0+QKXBpvW8Or46BlMzkOhYeZwQ
	 EyzkO7wgIB10w==
Date: Tue, 12 May 2026 09:16:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: kernel-janitors@vger.kernel.org, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kernel@vger.kernel.org, Breno
 Leitao <leitao@debian.org>
Subject: Re: [bug report] bootconfig: init: Allow admin to use bootconfig
 for kernel command line
Message-Id: <20260512091638.8b95253ab022d7dabf473465@kernel.org>
In-Reply-To: <af4YTUrDM-ciyoa-@stanley.mountain>
References: <af4YTUrDM-ciyoa-@stanley.mountain>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Dan,

Thanks for reporting. A similar problem is pointed by Sashiko [1].

[1] https://sashiko.dev/#/patchset/20260508-bootconfig_using_tools-v1-0-1132219aa773%40debian.org

On Fri, 8 May 2026 20:07:25 +0300
Dan Carpenter <error27@gmail.com> wrote:

> Hello Masami Hiramatsu,
> 
> Commit 51887d03aca1 ("bootconfig: init: Allow admin to use bootconfig
> for kernel command line") from Jan 11, 2020 (linux-next), leads to
> the following Smatch static checker warning:
> 
> 	init/main.c:368 xbc_snprint_cmdline()
> 	use scnprintf() instead of snprintf()
> 
> init/main.c
>     331 static int __init xbc_snprint_cmdline(char *buf, size_t size,
>     332                                       struct xbc_node *root)
>     333 {
>     334         struct xbc_node *knode, *vnode;
>     335         char *end = buf + size;
>     336         const char *val, *q;
>     337         int ret;
>     338 
>     339         xbc_node_for_each_key_value(root, knode, val) {
>     340                 ret = xbc_node_compose_key_after(root, knode,
>     341                                         xbc_namebuf, XBC_KEYLEN_MAX);
>     342                 if (ret < 0)
>     343                         return ret;
>     344 
>     345                 vnode = xbc_node_get_child(knode);
>     346                 if (!vnode) {
>     347                         ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
>     348                         if (ret < 0)
>     349                                 return ret;
>     350                         buf += ret;
> 
> In user space snprintf() can return negative, but in the kernel, no.
> It returns the number of bytes (not counting the NUL terminator) which
> would have been copied if there were enough space.  So maybe you want
> to do something like:
> 
> 	remain = rest(buf, end);
> 	ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
> 	if (ret >= remain)
> 		return -ENOSPC;

Actually, we need to query the length of required buffer size if buf == NULL
or the buffer size is not enough.

But as Sashiko pointed, I need to check it with UBSAN. (but I think,
even if @buf is NULL, the @buf is char *, thus it is safe to add some
value...)

> 
> Or maybe you might want to use scnprintf() which returns the number of
> bytes actually copied.  Otherwise bug ends up pointing to beyond the end
> of the buffer.

No, I need to calculate the required length of buffer.

Thank you,

> 
>     351                         continue;
>     352                 }
>     353                 xbc_array_for_each_value(vnode, val) {
>     354                         /*
>     355                          * For prettier and more readable /proc/cmdline, only
>     356                          * quote the value when necessary, i.e. when it contains
>     357                          * whitespace.
>     358                          */
>     359                         q = strpbrk(val, " \t\r\n") ? "\"" : "";
>     360                         ret = snprintf(buf, rest(buf, end), "%s=%s%s%s ",
>                                 ^^^^^^^^^^^^^^^
> Same.
> 
>     361                                        xbc_namebuf, q, val, q);
>     362                         if (ret < 0)
>     363                                 return ret;
>     364                         buf += ret;
>     365                 }
>     366         }
>     367 
> --> 368         return buf - (end - size);
>     369 }
> 
> This email is a free service from the Smatch-CI project [smatch.sf.net].
> 
> regards,
> dan carpenter


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
