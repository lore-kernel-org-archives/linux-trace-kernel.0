Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5341E32939D;
	Wed, 21 Jan 2026 02:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768962177; cv=none; b=nipOEAP9pv2dlvk4erViPQHSw6RRNVhzaSFprMtCM5cqprUoMBy4jrwPaPUtTHQyjqXW4i/hTNsMcf54Fu8aQBS/IZOx9q+YbS3X4ArbKCOqiCDcCITOXSxrifb3nMNaEnbJejR7lJ7ZnT+BJMU0MVz4Ua8V8g3A5oiSfNE6Z5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768962177; c=relaxed/simple;
	bh=xkrOc08meP/tP4NaFjOnC04eXwfWmJ9Lz3MfAVyVEp4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=g3p0erXxvbuOc7Pyvk+uJnCZlruCwHUQ3cjxqK+WS3Jq752jbZiFeWTg1QslOcnQpTj97AgGn2kRAlo50G1+XQfRDg3xRlvFxJBZo8HnLM+DZMIXHzdiqDwhxXvnAmzULHVH/rtTFjYHx8mN7cx0bu7L4bTSiOPRahk5I8tSQ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQWPdm4s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQWPdm4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E071EC16AAE;
	Wed, 21 Jan 2026 02:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768962177;
	bh=xkrOc08meP/tP4NaFjOnC04eXwfWmJ9Lz3MfAVyVEp4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BQWPdm4s9X+isTaQQZbP6/ApmC2lTgDrYKcrV7dqIwK2Ru2XUBGkFD3i3UtfB5Dos
	 FLqIN5GeSAuMuvA9wB+L1XUtm3QtIxSzCeussrMxftGNiA5HddByvhuw+2obClmAFI
	 eJCBykJMnCfV33LI22sjTGZocDbJPycxBLbHI15EzZ7884TWcwA8fuPpKhWdjlns6o
	 m2cAw0/vS1Mick3XebmSTkSKD7zk2qkEUx5FhnrLWLH7WQlWpgOMavtE4ztB5/h35c
	 /OE+KDeXuCpHfSITvIQX3ahUPLbpbus7zdOLWA3ClBl1hocZHOhAsAd9W5B85mYJfD
	 RFodXp+GRBK5w==
Date: Wed, 21 Jan 2026 11:22:53 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Weigang He <geoffreyhe2@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scripts/tracepoint-update: fix memory leak in
 add_string() on failure
Message-Id: <20260121112253.3e02bd1ebb50ad6d1651bb1f@kernel.org>
In-Reply-To: <20260119114542.1714405-1-geoffreyhe2@gmail.com>
References: <20260119114542.1714405-1-geoffreyhe2@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 11:45:42 +0000
Weigang He <geoffreyhe2@gmail.com> wrote:

> When realloc() fails in add_string(), the function returns -1 but leaves
> *vals pointing to the previously allocated memory. This can cause memory
> leaks in callers like make_trace_array() that return on error without
> freeing the partially built array.
> 
> Fix this by freeing *vals and setting it to NULL when realloc() fails.
> This makes the error handling self-contained in add_string() so callers
> don't need to handle cleanup on failure.

This looks not enough. If the memory allocation is failed, it should NOT
continue anything.

I think we need to make the command itself failure when it fails to
allocate memory, as below:

diff --git a/scripts/tracepoint-update.c b/scripts/tracepoint-update.c
index 90046aedc97b..1b4129a21942 100644
--- a/scripts/tracepoint-update.c
+++ b/scripts/tracepoint-update.c
@@ -94,7 +94,7 @@ static void make_trace_array(struct elf_tracepoint *etrace)
 		if (!len)
 			continue;
 		if (add_string(str, &vals, &count) < 0)
-			return;
+			exit(EXIT_FAILURE);
 	}
 
 	/* If CONFIG_TRACEPOINT_VERIFY_USED is not set, there's nothing to do */


Thank you,

> 
> This bug is found by my static analysis tool and my code review.
> 
> Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
> ---
>  scripts/tracepoint-update.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/tracepoint-update.c b/scripts/tracepoint-update.c
> index 90046aedc97b9..5cf43c0aac891 100644
> --- a/scripts/tracepoint-update.c
> +++ b/scripts/tracepoint-update.c
> @@ -49,6 +49,8 @@ static int add_string(const char *str, const char ***vals, int *count)
>  		array = realloc(array, sizeof(char *) * size);
>  		if (!array) {
>  			fprintf(stderr, "Failed memory allocation\n");
> +			free(*vals);
> +			*vals = NULL;
>  			return -1;
>  		}
>  		*vals = array;
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
