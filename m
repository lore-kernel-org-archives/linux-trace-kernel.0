Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C9E18FDDA
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709687; cv=none; b=A2N9k55GZFAXCWFyolEg1FQD4Ef/wpYdXsOFZ2SMJGBL6v9kPeqjTKZWBJAcxtepVKC6IqEBDzrBLtmGYGuAjzoKU8ZmNkagae3wIsx9aV9mJ0Kzm0ZFPNymjLQxstM0fT/XPNm7BgkXNS8Hs8JNyiVZYDhlXUnA4HdPuVZV2wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709687; c=relaxed/simple;
	bh=Uir1zyQpp8pFgPeuDOaJoz5kXprveWc5MyXzA+WiQW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYzk/68QkwHwx2ct8Mcg0HbHb1gzQKwoEyiR+6EJsTGj2seHc1c5g26CKRx9uwG4L1beCZgqKWcmAl1YpxQrT10WAw5Efwtu7bO4vjj+Db0n83qQnVyC3f+h86kL3ev91qupQzj5oC9v/d4u/jIE8FJcjFyYJj+cAYVbt8xSypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CF6C4CEC7;
	Mon, 30 Sep 2024 15:21:26 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:22:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Maverickk 78 <maverickk1778@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: ftrace not tracing pciehp probe
Message-ID: <20240930112213.4dc0916e@gandalf.local.home>
In-Reply-To: <CALfBBTtqho0iEV5rpG=2uead0MPZQoRiins8yeXwY-WfZnR08Q@mail.gmail.com>
References: <CALfBBTtqho0iEV5rpG=2uead0MPZQoRiins8yeXwY-WfZnR08Q@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 18:16:01 +0530
Maverickk 78 <maverickk1778@gmail.com> wrote:

> Hello,
> 
> I enabled ftrace and set a filter on the command line as *pcie*, I
> dont see some of the pciehp(eg: pciehp_probe from pciehp_core.c)
> module function calls in ftrace, It does trace pciehp_isr but nothing
> else.
> 
> My command line is "ftrace=function_graph ftrace_graph_filter=*pcie*
> ", is there any restriction on tracing static function calls?

Only if the compiler inlines them.

Ftrace only traces true function calls. That is, locations that something
performs a jump to via the call instruction for x86, or a branch-and-link
for several other architectures. The function has a prologue where gcc or
clang will insert code that will allow ftrace to attach to it.

If the compiler decides to inline the function, it will no longer be
visible to ftrace as the compiler will not add the necessary logic to allow
ftrace to hook to it. In the binary, the function simply "disappears" and
the content of that function is injected directly into the calling function.

If you do not see the function you want listed in:

  /sys/kernel/tracing/available_filter_functions 

Then it likely was inlined by the compiler. If you don't want the compiler
to inline your function, simply add "noinline" to that function:

static noinline int foo(void)
{
}

And that should tell gcc not to inline it.

-- Steve

> 
> # cat /proc/cmdline
> BOOT_IMAGE=/boot/vmlinuz-6.11.0+
> root=UUID=f563804b-1b93-4921-90e1-4114c8111e8f ro
> ftrace=function_graph ftrace_graph_filter=*pcie* pciehp.pciehp_force=1
> pciehp.pciehp_debug=1 pcie_ports=native quite splash
> crashkernel=512M-:192M vt.handoff=7
> 
> 
> Raghu

