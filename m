Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528092EB84A;
	Thu,  2 Oct 2025 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759413871; cv=none; b=eyxJ/e1iK8OQ0e5Bc9Y2l/i5pTxa8SHHjHxZ72iKHOW7Q8Owx0ZavUMR7vmHA9RGkOrpJl8V/cSAAOxlay8wfliQS0drZNoXRS6xH0J2McpSaNjd8sAfEARIg53EncpzEEqmzzI/+eDyg9yq0YyyNhLaxXYdTlCC6PJ7l6McJ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759413871; c=relaxed/simple;
	bh=yQmoDtmZMHdho2muG3b/6Dm/dtwSTenriZTMG/NkHD0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SZtIW9tuOomY/dq4ZstxG9AVxoM0HtReDKCuzql949lO6Xoz8sOqzFX1+2NMyXWE1H4MWBJ7VqWMNNGDSm23DWakccs3npYr/EqJlY3cGsp7Qw783w5Fzv4MgAtNnjaKzGwiPJkYMIeMi3bs7vjh+SRPPCipMD7eZqxsEddAW8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnTV+gFt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnTV+gFt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF05C4CEF4;
	Thu,  2 Oct 2025 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759413870;
	bh=yQmoDtmZMHdho2muG3b/6Dm/dtwSTenriZTMG/NkHD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XnTV+gFtFYDfl9Juc3g+VGxPGe9Mmue+h8MfSlRRvyYl3cSxXBOibY4zaeRUmzry/
	 MueM0IIHV4z3c6Smy/s7AgcJt9PArUUBX1US+0oMG7Od6zBMMTDFfiMebqKYoay9QE
	 gSXS49tqAxr0VsqexVFZxR6GIs2TxLNfeDsgSpnGIhlIdFIT8LYE1QD1l6ajA+2LD2
	 kwE0f9aoiEJ6AcPqDa2BetrXqwR8/jARo8nJEijY4GPUw4rCg40PqJ+/XlWsszvZEH
	 Xop7CSW8RZkxfi+yaBwOT/VXCAk0WVR1BCIQJSpCZ3HwRzJ+oBO+iJhp86DHhR/wSj
	 DVG2RFNqFy9SQ==
Date: Thu, 2 Oct 2025 23:04:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, chenyuan_fl@163.com, bigeasy@linutronix.de,
 chenyuan@kylinos.cn, john.ogness@linutronix.de,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4] tracing: Fix race condition in kprobe initialization
 causing NULL pointer dereference
Message-Id: <20251002230426.708abb71918760263d499ec8@kernel.org>
In-Reply-To: <20251002075924.6c97aaf0ecb9500418c87680@kernel.org>
References: <20251001003707.3eaf9ad062d5cad96f49b9ba@kernel.org>
	<20251001022025.44626-1-chenyuan_fl@163.com>
	<20251001123200.GN4067720@noisy.programming.kicks-ass.net>
	<20251001103149.2d52d03f@gandalf.local.home>
	<20251002075924.6c97aaf0ecb9500418c87680@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Oct 2025 07:59:24 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Wed, 1 Oct 2025 10:31:49 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 1 Oct 2025 14:32:00 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > Anyway, patch looks reasonable now. Rest is up to Steve, this is his
> > > code.
> > 
> > Actually, it's Masami's ;-)  And it's up to him.
> 
> Yeah, looks good to me. Let me pick it as a fix.

BTW, I will add below, the commit introduced the flags.

    Fixes: 50d780560785 ("tracing/kprobes: Add probe handler dispatcher to support perf and ftrace concurrent use")
    Cc: stable@vger.kernel.org

Thanks,

> 
> Thank you!
> 
> > 
> > -- Steve
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
