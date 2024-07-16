Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9C819E7F7;
	Tue, 16 Jul 2024 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158475; cv=none; b=j97ALm3MgbzfybQnyKJiRv5R60CXdROnY0chMQMExDPt108xkMKt3u5msIWRf+TCjcFWwiRWZy5s+2f2wAfUAWzFthjuOD3l5dUnQEaaQpNMETOX0JchQqNF9TQ+9eZa86iIscRtDodIuM0znMQ66+h4lOjo82prRqx17Msba8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158475; c=relaxed/simple;
	bh=UP2B229J7ZxIe0tzEcSruqguvLjt6N+LMMfX0Qc+HN4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YxKO9WGIBmEJF7M26aeYwikoVRVHEz+AMLP1yX8NKUmZF8E+BaADXaw8HCSzNZ9izhYH5/gk4Mktk0KvVheZ3KkLVtrqSb4Z8wQOlw+T3+gi2KB2ySGQconFOIWusi+3b76NHqHsUcsSawEC0Zg7r5X0bgGZxR7GDkX8RFnn83A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631BAC116B1;
	Tue, 16 Jul 2024 19:34:34 +0000 (UTC)
Date: Tue, 16 Jul 2024 15:34:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
 lvc-project@linuxtesting.org, linux-trace-kernel@vger.kernel.org, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [lvc-project] [PATCH] tracing: remove unreachable
 trace_array_put
Message-ID: <20240716153432.4024a180@rorschach.local.home>
In-Reply-To: <38513f97-d99a-4758-b84e-278e30f5565c@ancud.ru>
References: <20240712201258.99070-1-kiryushin@ancud.ru>
	<20240712193306.3174c85e@gandalf.local.home>
	<98c01cc6-dcee-46d0-bdc8-0e35165ec68b@ancud.ru>
	<5ec2d185-0359-b0df-664a-d20722fe3666@ispras.ru>
	<38513f97-d99a-4758-b84e-278e30f5565c@ancud.ru>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jul 2024 22:19:05 +0300
Nikita Kiryushin <kiryushin@ancud.ru> wrote:

> On 7/16/24 12:45, Alexey Khoroshilov wrote:
> > Yes, but there is another possible modification: replacement of call to
> > nonseekable_open() by a call to some other function that returns error.
> > Current code is already ready for such modification.  
> 
> The change of which function is called would change the behavior indeed, but,
> TBH, I do not see it as a valid point: If we assume that nonseekable_open() changes to something else in the future, we may assume as well that some other call will be
> added later with a risk of resource leaking. This is a thing, that whoever would do
> such changes should be careful about.
> 
> For me, the code as it is now, is not uniform with the other places that use
> nonseekable_open().

The point is moot. If something returns a value, even if it says it
will never return failure, there's no harm in checking it. If we ignore
the return value, that is a unneeded coupling of design between the
function and its users.

It does no harm in checking the value, so I rather just keep doing so.

-- Steve
