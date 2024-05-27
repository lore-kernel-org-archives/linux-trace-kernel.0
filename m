Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD21733C8;
	Mon, 27 May 2024 23:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716852550; cv=none; b=WmyJSHCUkm6KdAiXn3w0mRg+z6TnrTFKq0pK8BhfMYMGhHd/a+R7R5NX32xQLz6fGRIQTOfTA9ir1Gh+J3xhHHI2SXyyXbmBbv8KXa1o15RUiWPkSFBHMiHIwVuqeXbYIMB+r0/ue6FeWM5fEQnfBv5jqnThtD6WD2mpn2Bl4SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716852550; c=relaxed/simple;
	bh=rjLg2LgiEkRoeNsn3CNZc8/LZBGXGzj+L03bkFhBtbI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uNIb5yA3GyT3bM87Kc01GX32TKNyMZDxYlcnZPf6w0Pdye6HMlmVwsEZEIk9+gxdmGW0X9EeBnpcFAlGkoTxvlk9x7PVoV9uCCy6OgnpZtZBeiTymQyoyD0on9DVpLEJKPNNhej0AVLkcwPDL3DmNF0vzOeVNt0CBN8khURPQZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE13C2BBFC;
	Mon, 27 May 2024 23:29:09 +0000 (UTC)
Date: Mon, 27 May 2024 19:29:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 0/3] tracing: Fix some selftest issues
Message-ID: <20240527192907.49c9220f@rorschach.local.home>
In-Reply-To: <171671825710.39694.6859036369216249956.stgit@devnote2>
References: <171671825710.39694.6859036369216249956.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 May 2024 19:10:57 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is a series of some fixes/improvements for the test modules and boot
> time selftest of kprobe events. I found a WARNING message with some boot 
> time selftest configuration, which came from the combination of embedded
> kprobe generate API tests module and ftrace boot-time selftest. So the main
> problem is that the test module should not be built-in. But I also think
> this WARNING message is useless (because there are warning messages already)
> and the cleanup code is redundant. This series fixes those issues.

Note, when I enable trace tests as builtin instead of modules, I just
disable the bootup self tests when it detects this. This helps with
doing tests via config options than having to add user space code that
loads modules.

Could you do something similar?

-- Steve


> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (Google) (3):
>       tracing: Build event generation tests only as modules
>       tracing/kprobe: Remove unneeded WARN_ON_ONCE() in selftests
>       tracing/kprobe: Remove cleanup code unrelated to selftest
> 
