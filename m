Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13A2AD03;
	Thu,  9 Jul 2026 00:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555454; cv=none; b=D8nCurtgwQA8JXszD+7j7x/Vu1re9XEc7IoQF8yGMAWtmaYKQAZoac8tMvpC7SGTI4uJeZGecSDkq9vxAXuL7N7c4Vje5RBZPz7ZUDVtCxcUqLOz/0kjJvX+XEUFc+MbfyyDrVp2BmWdXsDMjd9szj210hzdzKCRvjSaLvoym6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555454; c=relaxed/simple;
	bh=W1yVeRZyQJfIQeiPN9ZmVYS74ML7qlXmDZy0Fwlo5u0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CxrIkFVFLLG7KneN88BIASS3Klic3bR1r0kKNTyZ/3Y5bUqjsXANozvFslTCU91wytZhapDDcS6cBk5CXd5LZoTfR6OwztoUiPBPoLvF7p8mKX49Lc8cfi0YuheFe9PPED7ETFdOndY4422U0mITfVnS9GbcRV0MI84PoufIiF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rm2srGD5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rm2srGD5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435A91F00A3A;
	Thu,  9 Jul 2026 00:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783555453;
	bh=uQB2z1NEc9GdNL2cFTj5gTdBz8ARYyB4t/eYr4yJOxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rm2srGD5W91C0RFOKB4Ddof6om3oLdaSlhwO4lHVMbP77tb59zrkiOzQFgIVChuX9
	 kcaI5xQCJOKpmHGYW1qUtLpK/PKv/NuW0W42g59UEyt6gz9/Q5OgK8bvhJlfyFvCpP
	 MlyHAmFnUtBUDod1vNXvdrte/4X5uR2R1n8hNHBur2w8uG4KrYc1ECFr7S62Mc15wo
	 WEEyP/fS7MA8llFSjyRK5nEWKzM+onYEsVo+0jvgS3eVHdF/ynYKe1sta6IxMT8E+k
	 pQ8hHsxplVF3LVT5f2IK4QKlJ0GxRX/sweOHfhUF9yK89CHr1yzeKpa5u6gNB8E70l
	 3MjNb/2DIOCKw==
Date: Thu, 9 Jul 2026 09:04:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jeongho Choi <jh1012.choi@samsung.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mhiramat@kernel.org, ji2yoon.jo@samsung.com, minki.jang@samsung.com,
 hajun.sung@samsung.com
Subject: Re: [BUG] tracing: Too many tries to read user space
Message-Id: <20260709090408.b7a5de9ec8dc92141550636e@kernel.org>
In-Reply-To: <20260708091804.584975f9@gandalf.local.home>
References: <CGME20260708123754epcas2p1f15cc305ddb09f97164491d750769ef7@epcas2p1.samsung.com>
	<20260708123753.GB1386@KORCO121415.samsungds.net>
	<20260708091804.584975f9@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jul 2026 09:18:04 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 8 Jul 2026 21:37:53 +0900
> Jeongho Choi <jh1012.choi@samsung.com> wrote:
> 
> > The code at the WARN location mentioned in the log above is as follows.
> > 
> > 7374                 if (WARN_ONCE(trys++ > 100, "Error: Too many
> >   tries to read user space"))
> > 7375                         return NULL;
> > 
> 
> This happens when something forces a schedule.
> 
> > 
> > Our current analysis is as follows:
> > 
> > In the Gmail process, during a low memory situation, LMKD writes strings
> > to /sys/kernel/tracing/trace_marker for systrace recording. At the same
> > time, it broadcasts a sigkill due to low memory, which is causing the
> > LMKD trace marker operation to stall.
> > 
> 
> Can you see what is being scheduled in? Perhaps use the persistent ring
> buffer (if you can) and enable sched_switch tracepoint in it.

Nit: If the device just caused oom and not crash/reboot the kernel, you can
just use normal ring buffer (or perfetto).

Thanks, 

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
