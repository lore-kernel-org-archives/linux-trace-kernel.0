Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974BB4A205D;
	Thu, 15 Oct 2026 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053863; cv=none; b=b1cAJNdabzbit+BhXkzIdSBICo1Yd3Dy3DOZg22XiRWDjDj7zlGRfQLz6Y79ShaG8uX3yqGP055UI9cOMXM/7zqLDhAOfP2FzL4v5O0mxWXZBIqYyknxU3Y1tCDVwSX6hxxGVktHFWvB/tevbBNOTiKInqKTA8UrVtgQo2ko8Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053863; c=relaxed/simple;
	bh=2prWKZldvCX2n0mxqHkwqsegVwBYc4lTQjmzG6E2h2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKNlhbueUclxSLcwVsNSMZtSxmo9hFbm2hiimclikDRp/Uand5dm1WQGpyxEtcV61VCXRXppVomAC5lIm5WqS0Q6iQ/snsy4n6PxaY7UsSZHbgeWA6s3vBrYXo3Nvs2Pr8Hj5+VWq4C+7KUwBAnXve3G7yNBXEQU3s1YwlzF2ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sc/veeA7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sc/veeA7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D8F1F000C4;
	Thu, 15 Oct 2026 08:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792053862;
	bh=cEX2ZWAeYBdoqlVT1gjPGchlDWE0HZwfagWF9vIwj18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=sc/veeA774ZDxO59Bzz4Obxxf5hzNa3lpmx2kWb7ZhJTZAYOxvUrYlHbgIxYpwWK8
	 8ImScpq65vwXsfUIXljQzUpMSA3VNaZT8tuXFqq7MsWW9676+61j8QCKByRutgT6Kb
	 NCD25k/rYfSDylUkNqNQRag7y9Nf0mmoZyboRB9U=
Date: Thu, 15 Oct 2026 10:44:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Haoran Wang <haoranwangsec@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	security@kernel.org
Subject: Re: [BUG] tracing: __copy_from_user without access_ok leaks kernel
 memory in syscall fault tracing
Message-ID: <2026101539-rinse-refocus-8203@gregkh>
References: <6ad07a3c.6e2bf4e6.f29cc.dd67@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ad07a3c.6e2bf4e6.f29cc.dd67@mx.google.com>

On Thu, Oct 15, 2026 at 03:01:08PM +0800, Haoran Wang wrote:
> I'd like to report an issue in kernel/trace/trace_syscalls.c:686 (function
> syscall_copy_user_array), found via static analysis of Linux 7.0.11 and
> verified against the 7.2.10 source tree. I have reproduced the leak on an
> 7.2.10 kernel.

Cool, but you forgot to also provide a working patch for this?

> 1. Summary
> The "syscall fault tracing" feature (added in 7.0, CONFIG_FTRACE_SYSCALLS)
> treats the raw syscall argument args[1] (the buffer pointer) of faultable
> syscalls (write/pwrite64/ mq_timedsend) as a user address and copies it
> with __copy_from_user(buf, args[1], size) without an access_ok() check.
> When a traced process calls write(fd, <kernel address>, count), the
> sys_enter tracepoint fires before vfs_write's access_ok and
> __copy_from_user copies up to 165 bytes from that kernel address into the
> per-CPU trace buffer, which is appended to the sys_enter_write event and
> readable from /sys/kernel/tracing/trace. The write() itself then returns
> EFAULT, but the leak is already complete. copy_from_user() would have
> rejected a kernel address via access_ok(); __copy_from_user() does not.

This is root-only, so there's no security issue really, right?  Or am I
mistaken?

thanks,

greg k-h
