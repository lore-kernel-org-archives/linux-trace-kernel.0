Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795340655;
	b=UpDGSTnMNQ7/c/FxHAPznd8eHPkLry6XspsVCMpmhnZrGX+PVk0Wl/q4oiNMOtHFFbP4
	 v1h1xm6kEcz6AKHQ/kZcSK6v70V2XDDlWxWGARHlt/IY76qm0sz6+fFQaUC9PHA5obOMR
	 4eGC3WWjDzK6ZL5B5WMiI4eVArCLK/ldNLnIHgDOgLcOLsn2MvdxeyMsuQrz4VnTKVlLA
	 V0nSY1wVfrSxp4zotuuehL2zdmJ54/IAHf5u6Oroc3zVVyAYXk2V7iLsT6MY0vRF917M6
	 8bDO7+O8j6iF3NVRkwCGp9mqssGPqLFsOxH45pN4y0+YkescbSJWA8iJukqXd75Gruw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795340655;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jG647zLaKDOa4ikcmyWqfAVgJu2lrwpR7ZtVwyZzKa4=;
	b=ZYg3awKeJVIOgyPTvEfNwVvwbHIq0oquDZ5K/tzWQZindmCMNA7aDI/tNXs++qp0Kle9
	 KFEIDToKbCQb7PZMNgdkGGTMb+fVGv2w/+yGwmz+QzN+2yngbDBbBOz13APftWyaLHse9
	 Ym/RG8YDjYx6+BXZIHzJi1lJFPfjgk1+SdO09rJDMx2bSjP3WvG4o1QyCvOn4NeVm34xl
	 WQevwYHudh3SofKtqdYYaqpvAeTpgwUDSoBOdWsTgORKR3vY/xbdYAjiF48W01f2aeCnU
	 PiHfW2z+USIoJJ5ScAck6WJfhZUSNtF/ZD5fnF7EX8wXokhOYiOnhFHvtK84dFkPJZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mL8pnkIe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0416606A320;
	Sun, 22 Nov 2026 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mL8pnkIe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B5D1F000C0;
	Sun, 22 Nov 2026 09:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795340654;
	bh=jG647zLaKDOa4ikcmyWqfAVgJu2lrwpR7ZtVwyZzKa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mL8pnkIe8Oj21MLgrwC+7bKOwfvrpfn8Qa7Wj+Xq/WsWv7iBtUecV1zPwKTEhic29
	 VD3FQzU6FSn8G7AXdMq67n5e0ZZunbsWwGwARgkIq/xDBps6xEK4DTihOELNNrOJ8N
	 WzwgfiKpr2xYfNAr2LvUIMBbLXqG+yYFxtVkzIYlEInHxYiqumSWDOIGg5+xKd8Fg4
	 cpOT+7+coAi0WZx+lekoMoR8HUR9adeBmuHUgYWBD057ar08KtbqXhYkhg5k0avDyQ
	 tKQ4Fq33FvDiYTxLr1TfMuhFB6TPrCgWsmhu4tp25jM3d0lsoG+VtNM9V2PKZKkQUC
	 QU1PvgD4E68yQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Yifan Feng <evanfengff@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/fprobe: Do not let KASAN check the $stackN read
Date: Sun, 22 Nov 2026 18:44:11 +0900
Message-ID: <undine-1795340651865886565-b6ba73d13d584735@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261118003205.59804-1-evanfengff@gmail.com>
References: <20261118003205.59804-1-evanfengff@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Tue, 17 Nov 2026 16:32:05 -0800, Yifan Feng <evanfengff@gmail.com> wrote:
> ftrace_regs_get_kernel_stack_nth() reads the Nth entry of the kernel
> stack for the $stackN argument of fprobe and tracepoint probe events.
> That entry can be in the redzone of another stack frame, so with
> CONFIG_KASAN_STACK every hit of such an event is reported:
> 
>   # echo 'f:fp_read vfs_read $stack10' >> dynamic_events
>   # echo 1 > events/fprobes/fp_read/enable
>   BUG: KASAN: stack-out-of-bounds in process_fetch_insn+0xac9/0xcb0
> 
> Use READ_ONCE_NOCHECK(), as arm64 does in regs_get_kernel_stack_nth()
> for kprobe events.
> 
> Fixes: 0566cefe73b9 ("tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS")
> Signed-off-by: Yifan Feng <evanfengff@gmail.com>

Looks good to me. Let me pick this to fixes branch.

Thanks!

> ---
> Tested on v7.4-rc3 in QEMU with KASAN: 6 reports before, 0 after.
> Found and written with the help of an AI coding assistant.
> 
>  include/linux/ftrace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 1c2056a1a68b..bdb6ee6bc3b9 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -270,7 +270,7 @@ ftrace_regs_get_kernel_stack_nth(struct ftrace_regs *fregs, unsigned int nth)
>  	stackp = (unsigned long *)ftrace_regs_get_stack_pointer(fregs);
>  	if (((unsigned long)(stackp + nth) & ~(THREAD_SIZE - 1)) ==
>  	    ((unsigned long)stackp & ~(THREAD_SIZE - 1)))
> -		return *(stackp + nth);
> +		return READ_ONCE_NOCHECK(*(stackp + nth));
>  
>  	return 0;
>  }
> 
> base-commit: 63fdb511c27afcebce797e3db580b3534ddfa639
> -- 
> 2.39.3 (Apple Git-146)
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
