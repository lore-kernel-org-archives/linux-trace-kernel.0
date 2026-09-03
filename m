Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B4C1E8332;
	Thu,  3 Sep 2026 01:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788397418; cv=none; b=EEE/I0hvlkIJw80/XAvi77282dXclguBzu720p0D8zcyUIQgdJuiJ75uSxg3r2kPtZhsGdVl91wL/R5/yZoYanvepLjpEYdZDnlne6k4i3t29UVU6IIA510o2sfXQkEm71Bj/qagqqvLIv1kRxTb1ea0FdiSULdsmiCQ+eSL9/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788397418; c=relaxed/simple;
	bh=Yjs22QPyEZz39ou9ZXRrAMkokUlDqqdJ6uQDHy8S/jY=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=XSpshDzOPxJGMF5yBJbyzof9ANqE9itNUZN7E/uyBBBLDs8lhyaZO3NH8wTmXjvhYjhRo/Sx0OyW3N3lKE3F9WizSQAbdZwNtUIZsPFxFVwPS0F5V67iV7TCYWPYgO48W369oy34fJsW0pzbblR1//l83/XxerQOl8BX8fJKFeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hb1Yp4gvtz8Xrr9;
	Thu, 03 Sep 2026 09:03:26 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 68313LfN052625;
	Thu, 3 Sep 2026 09:03:21 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 3 Sep 2026 09:03:22 +0800 (CST)
X-Zmail-TransId: 2af96a98c75a204-859ef
X-Mailer: Zmail v1.0
Message-ID: <20260903090322460l3RLOYBqnQOT1Wf1Qb2E9@zte.com.cn>
In-Reply-To: <20260831094914.50eb26b7@gandalf.local.home>
References: 20260830190743637MhXoixrAPc1rfm-G8eIcg@zte.com.cn,20260831094914.50eb26b7@gandalf.local.home
Date: Thu, 3 Sep 2026 09:03:22 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <rostedt@goodmis.org>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
        <mark.rutland@arm.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
        <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <ran.xiaokai@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <zhang.run@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtSRkMgUEFUQ0ggMC80XSBmdHJhY2U6IEFkZCB0YXNrIGNvbW0gZmlsdGVyaW5nIGZvciBmdW5jdGlvbiB0cmFjaW5n?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 68313LfN052625
X-TLS: YES
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 03 Sep 2026 09:03:26 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A98C75E.001/4hb1Yp4gvtz8Xrr9

Steven wrote:

> On Sun, 30 Aug 2026 19:07:43 +0800 (CST)
> <hu.shengming@zte.com.cn> wrote:
> 
> > Hi Steven and Masami,
> > 
> > This series adds two comm-based task filters for the function and
> > function_graph tracers:
> > 
> >   set_ftrace_comm
> >   set_ftrace_notrace_comm
> 
> I'd like to avoid adding more files like this. If anything, I would love to
> add triggers to the function tracers.

Agreed. Adding two more tracefs files may not be the best interface. Together
with the points raised in the earlier discussion with Masami, I also think a
trigger-based interface would be a cleaner direction.

> > 
> > Function tracing currently supports selecting tasks by PID. This makes
> > it difficult to configure tracing before a service starts, because it
> > does not have a PID yet. It is also inconvenient to keep tracing the
> > same service across restarts, as its PID may change. This use case was
> > suggested by Xuxin, a KSM reviewer.
> 
> I've always recommended a simple wrapper script for applications:
> 
> echo '#! /bin/bash
>   echo $$ > /sys/kernel/tracing/set_ftrace_pid
>   echo $$ > /sys/kernel/tracing/set_event_pid
>   exec "$@"' > trace-me.sh
> 
> chmod +x trace-me.sh
> 
>   ./trace-me.sh command to be traced
> 
> The above will do what you want.
> 

Yes, this works well when we have control over how the application is
launched. Thanks for the example!

> But if we really do want to add more filters to function tracing, then
> adding triggers to it would be the way to go.

Understood. To make sure I understand the proposed direction, here is a
conceptual example of what the interface might look like:

echo 'ftrace_pid_add if newcomm == "foo"' > \
 events/task/task_rename/trigger

When a task changes its comm to foo, the trigger would add the PID from
the task_rename event to the function tracer's PID filter. The function
and function_graph tracers would then trace that task using the existing
PID-filtering mechanism.

We may also need a corresponding ftrace_pid_remove trigger command to
remove the PID associated with the triggering event from the function
tracer's PID list.

The command names above are only illustrative. Is this roughly the kind of
trigger interface you had in mind?

If so, we will investigate extending the trigger infrastructure in this
direction instead of adding the comm-filter files.

--
With Best Regards,
Shengming
