Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A251ADFED;
	Mon, 18 Nov 2024 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949573; cv=none; b=eI4clUU/5qIQZtRx0XSXYdguX85q0tQimTMuD8XrcRyCcSHvW2vwpQEawSUeYehS6Tbx74B12D1ILoSgBXHqv7jziaULO00hV8y4rWjgYgfq9q7xzxsRZ6u0svEAmfM3C1zabKuC2uavW8sBcRQIiFG9EObVZgvocnm2nerG6e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949573; c=relaxed/simple;
	bh=YdB9bqEFMkrLTE3NaILf0rD6dAw1Yx1a7PE8Zen1qB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZn8wwX1ZeLHh1qeJNoaD11wWDAjfyNkiURaESiQ1k1Wyyqk1wDIu7nANdMb6nG9P0NGs73Qa/9cNmfmHaVh6elBqOe4+Z5bTl4hEjeeO9bzfQcgHso6NOgaDbWM12bOHcB/3Y7pNDDuadV83p97BJjn7hXckmzqzTa0kjMy5Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9BDC4CECC;
	Mon, 18 Nov 2024 17:06:11 +0000 (UTC)
Date: Mon, 18 Nov 2024 12:06:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: jeff.xie@linux.dev
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiehuan09@gmail.com, dolinux.peng@gmail.com, chensong_2000@189.cn
Subject: Re: [PATCH v5] ftrace: Get the true parent ip for function tracer
Message-ID: <20241118120642.211fb11f@gandalf.local.home>
In-Reply-To: <20241118114320.3ce1b022@gandalf.local.home>
References: <20241008033159.22459-1-jeff.xie@linux.dev>
	<991260353fbe141ffef8db7a08ed8fb2473e4ca0@linux.dev>
	<20241118114320.3ce1b022@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2024 11:43:20 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 18 Nov 2024 16:15:02 +0000
> jeff.xie@linux.dev wrote:
> 
> > October 8, 2024 at 11:31 AM, "Jeff Xie" <jeff.xie@linux.dev> wrote:
> > 
> > I'd like to know if this patch can be merged into 6.13?  
> 
> Bah' I missed seeing this update and it was buried in patchwork on the 3rd page :-p
> 
> I wish you pinged me last week.
> 
> I just sent my pull request for the ftrace topic branch, but since the
> merge window just opened, I can start testing this now and then push it to
> next. Wait a few days and then send another pull request to Linus by the
> end of the week, if nothing breaks.
> 

This patch conflicts with a clean up patch I incorrectly put in my trace
topic branch (where it should have gone in the ftrace topic branch). I
haven't sent a pull request for the trace topic branch, so I'll just apply
this patch on top of that (fix the conflict), test it, push it to
linux-next, and then send it later this week.

-- Steve

