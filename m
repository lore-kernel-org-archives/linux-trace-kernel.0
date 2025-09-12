Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D312AE66;
	Fri, 12 Sep 2025 01:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757639249; cv=none; b=h+2h9ytysy3Gs7fDDs34IJx7e1pLmMAjNwGYby4IKAEOE3zxlsZVods5/dPreSFeMh71c46SwMuk7eT05eabb7Q8hkRszmHZYQDvRBN0kBB+yUWsHW8ofIswMPvheaMttc664C+P0shynl+/HLnKldOLQQ/DiYubVHrQ7/alh6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757639249; c=relaxed/simple;
	bh=PXuMJATVT4V0Y16Ka+lqtvBlfX81tB2vy3KhW0U7yNw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rFy91xpFZ7NefJiOToOQq3B0STEChovQll3jGUJiaEVf0/qeaR+O2Wv4RPry0giKnDkp3JhiptzVg2AKF3E4uIZgYvhGI621e6+/ZGR+oZ4keX6AD/M728si8DtDJadhJ2nC5OtC0rYfD3KewOAR8rJcJSBssCaJMfHgGhuBhD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLrXaBU9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLrXaBU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA00C4CEF0;
	Fri, 12 Sep 2025 01:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757639247;
	bh=PXuMJATVT4V0Y16Ka+lqtvBlfX81tB2vy3KhW0U7yNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dLrXaBU9sm6JjTx7yMnrAWHzGggmPl9ChW3HUUfCJfPQ1RupdUGBZupZevzvrNAnj
	 qqWKh9IbNcZOots0tCo95xxx38IqCC5RLsHH+wgRArii+KRrvzl9hivVoGr0Qp7Mdj
	 e6JIb3kknNcn8VC1kJf3GL6WzF9Zu/3FatptpsAQjwFcfw6BasZKVrhcMcCRTXgsKs
	 bj0uLjCJNYkas6NBhgR6Sup+5dN6l79ufOCpZ+TcaeYVhLsRtLmLFz4uAF6rYYP3VB
	 mBwt859ZmB4c1FCaydz731HnFwNvP3RJpzinCL6N042yJBgpiazhbYOpwywUejcy5V
	 f6EcX6h9WVWdQ==
Date: Fri, 12 Sep 2025 10:07:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-mm@kvack.org, Kees Cook
 <keescook@chromium.org>, Aleksa Sarai <cyphar@cyphar.com>, Al Viro
 <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] uaccess: Comment that copy to/from inatomic requires
 page fault disabled
Message-Id: <20250912100723.4fce2b29c4d77f3a89c0b636@kernel.org>
In-Reply-To: <20250910161820.247f526a@gandalf.local.home>
References: <20250910161820.247f526a@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 16:18:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The functions __copy_from_user_inatomic() and __copy_to_user_inatomic()
> both require that either the user space memory is pinned, or that page
> faults are disabled when they are called. If page faults are not disabled,
> and the memory is not present, the fault handling of reading or writing to
> that memory may cause the kernel to schedule. That would be bad in an
> atomic context.
> 
> Link: https://lore.kernel.org/all/20250819105152.2766363-1-luogengkun@huaweicloud.com/
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,


> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/linux/uaccess.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 1beb5b395d81..add99fa9b656 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -86,6 +86,12 @@
>   * as usual) and both source and destination can trigger faults.
>   */
>  
> +/*
> + * __copy_from_user_inatomic() is safe to use in an atomic context but
> + * the user space memory must either be pinned in memory, or page faults
> + * must be disabled, otherwise the page fault handling may cause the function
> + * to schedule.
> + */
>  static __always_inline __must_check unsigned long
>  __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
>  {
> @@ -124,7 +130,8 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
>   * Copy data from kernel space to user space.  Caller must check
>   * the specified block with access_ok() before calling this function.
>   * The caller should also make sure he pins the user space address
> - * so that we don't result in page fault and sleep.
> + * or call page_fault_disable() so that we don't result in a page fault
> + * and sleep.
>   */
>  static __always_inline __must_check unsigned long
>  __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
> -- 
> 2.50.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
