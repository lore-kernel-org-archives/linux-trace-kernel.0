Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BABA35CBC1;
	Thu, 13 Nov 2025 00:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762993279; cv=none; b=UgwrftAu2udYnORPL9LMYfowT6s0b7/KqJCCx2A1Va30CVUf4FSoYLdcO2R6MYfbKAxEDUMWvUrRjtCRPGMv3GGU7VA5Wu2llQEZW2Oiure6MeN7sk/qUg7GNpyeAa+IOU5UzeCvG8/qRs+whKMwXJJTzJKWg5LPClF0mrWvky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762993279; c=relaxed/simple;
	bh=fkDHdmg66zLpi1lUzDoV5cjB3E6G1XTaNeaYG1tT+w0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m4MD+Fu59oM+i8Kzv7zF1VO4M6KspzCwMXDglG/RdYtXxM/zVXdGLfeyGguORCNvMJRl9Xq6iYjaj4gP6IL2NVzSuYjlBtR52c7JA+B6zcKkSvPh4ambrX+vqOKLyy4X0AsADk6s3ap2sfWPlTnu7EXE1MbnYh6e5mC4p5yvsn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id E71F512DFB5;
	Thu, 13 Nov 2025 00:21:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id B962B2F;
	Thu, 13 Nov 2025 00:21:12 +0000 (UTC)
Date: Wed, 12 Nov 2025 19:21:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yongliang Gao <leonylgao@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, frankjpliu@tencent.com, Yongliang Gao
 <leonylgao@tencent.com>, Huang Cun <cunhuang@tencent.com>
Subject: Re: [PATCH v3] trace/pid_list: optimize pid_list->lock contention
Message-ID: <20251112192126.76a4cb9a@gandalf.local.home>
In-Reply-To: <20251113000252.1058144-1-leonylgao@gmail.com>
References: <20251113000252.1058144-1-leonylgao@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B962B2F
X-Stat-Signature: m5xcrckzciz7gkbpzfyop7ajh4hamkkz
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18POhQmfnD+3W8de2YF63ONw4wAc56uZCs=
X-HE-Tag: 1762993272-567681
X-HE-Meta: U2FsdGVkX19fbCLrnKnN0mshvPLcDz3kk68l3rlbxz7TYv2JK7ktf9+CKo76PBybXPrkCAFCrwW4o7+KHD7m9bHRU73JHrMYF4p4lsXSKBx5xIcH2d2il6BiXhtAmu30sx4IptKPhsOYOAjROWlXUdEiHsaAXyln9q9PqanWdZHbobqS162wcFQFILba6kRqIePxfy3nCvndnKEiQ+UM/K2ZN+r7bqCCzomfE2cyHEF3eIuc0Sh/mmKBKcUwJRq7I6tMpr3rKFR+2QkocOGktvHbiWBnfBlnk9og3+ZRxEPBJv8eNfHxMgxKtM3nO3iVlWA7sc2gtzW4iRyQXM4r86xdErhuGkx50IX9Dhorgblb1sRPMXvrsQdWhf/f02CS/lwk4eIuNnY=

On Thu, 13 Nov 2025 08:02:52 +0800
Yongliang Gao <leonylgao@gmail.com> wrote:

> From: Yongliang Gao <leonylgao@tencent.com>
> 
> When the system has many cores and task switching is frequent,
> setting set_ftrace_pid can cause frequent pid_list->lock contention
> and high system sys usage.
> 
> For example, in a 288-core VM environment, we observed 267 CPUs
> experiencing contention on pid_list->lock, with stack traces showing:
> 
>  #4 [ffffa6226fb4bc70] native_queued_spin_lock_slowpath at ffffffff99cd4b7e
>  #5 [ffffa6226fb4bc90] _raw_spin_lock_irqsave at ffffffff99cd3e36
>  #6 [ffffa6226fb4bca0] trace_pid_list_is_set at ffffffff99267554
>  #7 [ffffa6226fb4bcc0] trace_ignore_this_task at ffffffff9925c288
>  #8 [ffffa6226fb4bcd8] ftrace_filter_pid_sched_switch_probe at ffffffff99246efe
>  #9 [ffffa6226fb4bcf0] __schedule at ffffffff99ccd161
> 
> Replaces the existing spinlock with a seqlock to allow concurrent readers,
> while maintaining write exclusivity.
> 
> ---
> Changes from v2:
> - Keep trace_pid_list_next() using raw_spin_lock for simplicity. [Steven Rostedt]
> - Link to v2: https://lore.kernel.org/all/20251112181456.473864-1-leonylgao@gmail.com
> Changes from v1:
> - Fixed sleep-in-atomic issues under PREEMPT_RT. [Steven Rostedt]
> - Link to v1: https://lore.kernel.org/all/20251015114952.4014352-1-leonylgao@gmail.com
> ---

You don't need to resend, but the "Changes from" needs to go below the
'---' after the tags. Otherwise, git am removes everything from the above
'---', including your tags below.

-- Steve


> 
> Signed-off-by: Yongliang Gao <leonylgao@tencent.com>
> Reviewed-by: Huang Cun <cunhuang@tencent.com>
> ---
>  kernel/trace/pid_list.c | 30 +++++++++++++++++++++---------
>  kernel/trace/pid_list.h |  1 +
>  2 files changed, 22 insertions(+), 9 deletions(-)
> 
