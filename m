Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C225D1FC;
	Fri,  9 May 2025 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746827732; cv=none; b=m1zk3ROn6a/xVKA1YsQ0FSe84/ka9MqQtEvxB1C/ptdbxbt1a6vQjAJ5ezk0XKE/9R0aQ+BUHjjlmpvK/9M+9ffROMuqRuwLYESdSw6hnaWLJYuMrfD+FVQRPCRioPkmOXMJIx2RHEH1tFpvwRmVBWStCqRif69h1cBKLdCitNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746827732; c=relaxed/simple;
	bh=6bUOYnfeM9YGBmORFUWmmhMKscODaW6xHbQzUzzRfsA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=j/Ze95DP/XAvfPW9yUnnBIldyjV+kHRbputps4g+TqxGX/JiMlqJ3/fQq5UqrpUNM4qcp4vuDY7St1gnrPydN29PR7uhDSJ7YEq0bo4MY6q9fH92u3vuXqRsoUiTRNj+g1bZJ5VqpjwjqetrFuV8e88+06bZia8aKsR3264812A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0caTzXf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0caTzXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E439AC4CEE4;
	Fri,  9 May 2025 21:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746827732;
	bh=6bUOYnfeM9YGBmORFUWmmhMKscODaW6xHbQzUzzRfsA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L0caTzXfaYVDYsmlDbAMInMQJd0DrUBqCxzWuz7ARC5KzVumm7tQHq2yERiR6wJNx
	 bD5RepcINa/ChKivgDP5ZH+r2dveevcpXiXTjEoKLzOGycI0YIElrzd1WwmC+8Hw40
	 UiFCJblbBpPxoqTU4VihLGJYm3dXnP97RoTgYPMnrh2GPExFyMTD1ii4uJ8psSKWTB
	 pBHx4HEhTlVn2YeX9iHewZmDXoH0ormRn/u8/7nWTkYjXMplQq6qlAnD2SN+J2Cu7B
	 2A4JBRUsOKZ6Nm1c1LW1vJaaOfmjqOmVwBnzgnfnrSwQMZLLA8NclhYFOJ9uNnPX9M
	 GpMSXxjVXn6Yg==
Date: Sat, 10 May 2025 06:55:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH] tracing: fprobe: Fix RCU warning message in list
 traversal
Message-Id: <20250510065528.d726869719f27145cc69f179@kernel.org>
In-Reply-To: <bdc3a680-d915-4b84-9d87-bfbe68372243@kernel.org>
References: <20250410-fprobe-v1-1-068ef5f41436@debian.org>
	<bdc3a680-d915-4b84-9d87-bfbe68372243@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 May 2025 16:30:08 +0200
Matthieu Baerts <matttbe@kernel.org> wrote:

> Hi Breno,
> 
> On 10/04/2025 14:22, Breno Leitao wrote:
> > When CONFIG_PROVE_RCU_LIST is enabled, fprobe triggers the following
> > warning:
> > 
> >     WARNING: suspicious RCU usage
> >     kernel/trace/fprobe.c:457 RCU-list traversed in non-reader section!!
> > 
> >     other info that might help us debug this:
> > 	#1: ffffffff863c4e08 (fprobe_mutex){+.+.}-{4:4}, at: fprobe_module_callback+0x7b/0x8c0
> > 
> >     Call Trace:
> > 	fprobe_module_callback
> > 	notifier_call_chain
> > 	blocking_notifier_call_chain
> > 
> > This warning occurs because fprobe_remove_node_in_module() traverses an
> > RCU list using RCU primitives without holding an RCU read lock. However,
> > the function is only called from fprobe_module_callback(), which holds
> > the fprobe_mutex lock that provides sufficient protection for safely
> > traversing the list.
> > 
> > Fix the warning by specifying the locking design to the
> > CONFIG_PROVE_RCU_LIST mechanism. Add the lockdep_is_held() argument to
> > hlist_for_each_entry_rcu() to inform the RCU checker that fprobe_mutex
> > provides the required protection.
> 
> @Breno: thank you for the patch, I have it applied for a while on a
> branch dedicated to our CI to avoid false positive reports.
> 
> Tested-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Oops, I missed this patch.

Let me pick it up and send it urgently.

Thank you,

> 
> 
> Hopefully this fix can be sent to Linus before the v6.15 release :)
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
