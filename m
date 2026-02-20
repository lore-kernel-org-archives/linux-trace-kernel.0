Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C8672622;
	Fri, 20 Feb 2026 02:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771555544; cv=none; b=KPSIhI2HQI2NLudRnNxcJE/lmPqYLh0JplQ4t2rigPAR6ZWh9r6BDXFeSqlQBP5H3Hx312tqhLp27FempVCgP/vJ2ku6/7tikkfyMSXv439ngZWnFU51OsOSQ2eGupFbpb4k7SHJiEWq+n0vgG2q9ZviPnv2mGBHKSg5DrcBXxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771555544; c=relaxed/simple;
	bh=Y/OqXw+e1jp9DoEohwtomED6cl2v82Ml2XtU3ljvNRo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OvPsXxcTCc5TY/pD7rUMEOaQPsl3IFIgFA05vrBvRZGpNDkrlxLLcVC2xJbb3EpozM4Tk7mgweIC9rTolkw1c2wV7cBY9kHr5+q7Z4K0z1+ZHaBY9JwNQ2LvTUJXkPTwV9GZl5/zFU0wbeiEJCW033N6FLmZcDLvOBV5f4vPiMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWhv+XfU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWhv+XfU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01956C4CEF7;
	Fri, 20 Feb 2026 02:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771555544;
	bh=Y/OqXw+e1jp9DoEohwtomED6cl2v82Ml2XtU3ljvNRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qWhv+XfUUYc93EGrnVk8EIMS6PWGjs1hJtjeKGefhMLbNyb30BXWdxkSNZ/vFdVVI
	 jV8QylyUsKxKryC9fmh1BjqfmV6KCtz+wUbQUfkXOMBQqcP0Okf6EDasmUnCyWz7GY
	 1/r7v5kapty2YM88rX9dAVb5qaT8uiLXis4w869frcm6I/Xabuiuv9VNzr65es88Vk
	 B+2KHAVZtIKnjHkBBkCtCFIphyvVinu84vUbErRvOxLnFgCJNMpSeqwofDZuW2ro3Q
	 FZMt2hVv1Ct0FIRt6zP54B9A4eXIFyGCZbnAk6+mJbBvCPFma5KbzFbKos1s3XOBth
	 mOgfSBRld6SrQ==
Date: Fri, 20 Feb 2026 11:45:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Dave Hansen
 <dave.hansen@intel.com>, "Elly I. Esparza" <ellyesparza8@gmail.com>,
 linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, Naveen N Rao <naveen@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86: Prevent syscall hooking
Message-Id: <20260220114540.fbee78a9a8b8097ec729451c@kernel.org>
In-Reply-To: <202602191041.4CB9C4AAFD@keescook>
References: <20260218144735.24307-1-ellyesparza8@gmail.com>
	<0c5396b5-f084-4ade-adc9-029037031eea@intel.com>
	<20260218105204.3af7251e@gandalf.local.home>
	<202602191041.4CB9C4AAFD@keescook>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Feb 2026 10:45:02 -0800
Kees Cook <kees@kernel.org> wrote:

> On Wed, Feb 18, 2026 at 10:52:04AM -0500, Steven Rostedt wrote:
> > Honesty, if you are worried about this, just run LOCKDOWN on tracing, and
> > prevent *ALL* kprobes. Because yes, there's a 1000 ways to get this
> > information once you have kprobes enabled and have root access. This patch
> > is hurting legitimate debugging of running systems more than it is limiting
> > rootkits from hacking the kernel.
> 
> Yeah, I agree. If kprobes is available, there is a lot of harm an
> attacker can already do. If a bright line between root/ring-0 is
> desired, a system needs to be configured to be using lockdown or similar
> things to turn off the interfaces that let root write to kernel state.

Agreed. The blacklist (or blocklist) of kprobes is designed for preventing
nesting software breakpoint handling, not for security.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
