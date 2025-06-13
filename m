Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7403B23C51A;
	Fri, 13 Jun 2025 02:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749782732; cv=none; b=UfWAt0yb55E9B+k6ghWGZdf+iWi11yqxmKr5mChCDBshBw6L+M9vMaLoXq+/OUaFgXHCkq/Ch8Eg9mqL6qtdQWYF5g0GHbOfGPKXPxHUxL8qLzUR1rzCONu/bzOT8dxHYxfxWndKEKwvFBn4BAKTz/t000uz/TO3GqpQx82y6EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749782732; c=relaxed/simple;
	bh=3/GEX8v0y2wHN1aX/L2mKFs1OFPJY5H90o4kJS9wwpM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Y3Sub0lbd6nVmE6XEn4305FbpOpB+stmXQpzfDAf/dOrOiY//2X+yoOakQjuf6Xy9FZyAaWSGeN5+ij6D7lDn1p6+0OE7Lcax/TqUpgwUOVkJGMXd+YJUkylXoIuc/cAE+byCmuJLHvf4iF6BzU8xeXAhZTd4xysh7PcLyOS3dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuNHrr8L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuNHrr8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05643C4CEEA;
	Fri, 13 Jun 2025 02:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749782732;
	bh=3/GEX8v0y2wHN1aX/L2mKFs1OFPJY5H90o4kJS9wwpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZuNHrr8LNMudj5VjitbPf8sj267s1AVw4sJ3tx3f2xyysCzJgjUcKEpfJS+2+SHBC
	 2vZw3CqSkknFLYIEYI+wvsMN1Q2YaDv0Twsni0z9M38p+F4vzH4bOjlQ0Wmkh9E6ic
	 nPyJI7xc4mB71myghFYs6C0Nts84PHUuJz4Zlc+oMWJc227vMoT4w4KxQ328zTE0pA
	 I2IRTj67MttXw0BB+bCTZOtXDeegB78y5mK9BBIL9W0TmjZ/fIxdFyzutiCdrEKMI6
	 eVNtnkj5E+gSp1nOkQbuTgfkUSLsBj5tPP8zaM8AaJQMp6JMaFZHUbaoQo9BNdYHYw
	 JwRtQGgb/TdAg==
Date: Fri, 13 Jun 2025 11:45:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 acarmina@redhat.com, chuck.wolber@boeing.com
Subject: Re: [RFC PATCH 1/2] tracing: fixes of ftrace_enable_fops
Message-Id: <20250613114527.7e27a9a0ecc2b59d98677b0c@kernel.org>
In-Reply-To: <20250612104349.5047-2-gpaoloni@redhat.com>
References: <20250612104349.5047-1-gpaoloni@redhat.com>
	<20250612104349.5047-2-gpaoloni@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 12:43:48 +0200
Gabriele Paoloni <gpaoloni@redhat.com> wrote:

> Currently there are different issues associated with ftrace_enable_fops
> - event_enable_write: *ppos is increased while not used at all in the
>   write operation itself (following a write, this could lead a read to
>   fail or report a corrupted event status);

Here, we expected the "enable" file is a pseudo text file. So if
there is a write, the ppos should be incremented.

> - event_enable_read: cnt < strlen(buf) is allowed and this can lead to
>   reading an incomplete event status (i.e. not all status characters
>   are retrieved) and/or reading the status in a non-atomic way (i.e.
>   the status could change between two consecutive reads);

As I said, the "enable" file is a kind of text file. So reader must read
it until EOF. If you need to get the consistent result, user should
use the enough size of buffer.

> - .llseek is set to default_llseek: this is wrong since for this
>   type of files it does not make sense to reposition the ppos offset.
>   Hence this should be set instead to noop_llseek.

As I said, it is a kind of text file, default_llseek is better.

But, if we change (re-design) what is this "enable" file is,
we can accept these changes. So this is not a "Fix" but re-design
of the "enable" file as an interface (as a char device), not a text
file (or a block device).

I want to keep this as is, same as other tracefs files.

Thank you,

> 
> This patch fixes all the issues listed above.
> 
> Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
> Tested-by: Alessandro Carminati <acarmina@redhat.com>
> ---
>  kernel/trace/trace_events.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 120531268abf..5e84ef01d0c8 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1798,6 +1798,13 @@ event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
>  
>  	strcat(buf, "\n");
>  
> +	/*
> +	 * A requested cnt less than strlen(buf) could lead to a wrong
> +	 * event status being reported.
> +	 */
> +	if (cnt < strlen(buf))
> +		return -EINVAL;
> +
>  	return simple_read_from_buffer(ubuf, cnt, ppos, buf, strlen(buf));
>  }
>  
> @@ -1833,8 +1840,6 @@ event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
>  		return -EINVAL;
>  	}
>  
> -	*ppos += cnt;
> -
>  	return cnt;
>  }
>  
> @@ -2557,7 +2562,7 @@ static const struct file_operations ftrace_enable_fops = {
>  	.read = event_enable_read,
>  	.write = event_enable_write,
>  	.release = tracing_release_file_tr,
> -	.llseek = default_llseek,
> +	.llseek = noop_llseek,
>  };
>  
>  static const struct file_operations ftrace_event_format_fops = {
> -- 
> 2.48.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
