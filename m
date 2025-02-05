Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA30D1FDE11;
	Wed,  5 Feb 2025 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766983; cv=none; b=LSOuSfAJfOuFt+PSlXvMgmE9HEN9KdU1905nEZNjI3+3I8XO6j1LFXYO2xhDJBrDg1wGQCYILMJLXH8/Dj3jbETmEPDcE8lJXzncyOdLOIKRrXIlcVd8NtshBt4/FTlo75iTzvawSjG6qTiTtxdbWkc3q7FGqjAUW0LoHOtrp5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766983; c=relaxed/simple;
	bh=XrTK5X4YBIbNsDXLUzqScEYu1ZaiWuhAnfHdvEAFJOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=enlsKOB2Xx12bBPaoLPbWXFYmk1dS07Q6cnySt/cnFt7G3o3H1cpFiO9bJPUwGqE5lkobbYk9PQoCr8RRTLN6sfHJxEe1XzMrT8mLrJnrf4lllyDPA4GbVnGOzt0zOTKD5JR8qBV9FGBaQyKXINoM78Sqw80tTlj3t/pJlkcz8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF600C4CED1;
	Wed,  5 Feb 2025 14:49:42 +0000 (UTC)
Date: Wed, 5 Feb 2025 09:50:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Wen
 Yang <wenyang@linux.alibaba.com>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ftrace: Avoid potential division by zero in
 function_stat_show()
Message-ID: <20250205095021.15771b88@gandalf.local.home>
In-Reply-To: <20250205112154.1541872-1-kniv@yandex-team.ru>
References: <20250205103929.1538065-1-kniv@yandex-team.ru>
	<20250205112154.1541872-1-kniv@yandex-team.ru>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Feb 2025 14:21:54 +0300
Nikolay Kuratov <kniv@yandex-team.ru> wrote:

> Oops, this still does not fix an overflow because of
> 
> > rec->time_square_sum += calltime * calltime;  
> 
> We can't eliminate overflows easily without both using u64 and converting
> ns to us prior to any squaring. I will send an appropriate patch later
> if needed. Maybe we're a way too paranoid about overflows and really want
> only not to divide by zero?

Well, the divide by zero will cause a kernel crash (very bad!) whereas the
overflow just causes corrupted data (sorta bad).

But yeah, I've noticed a lot of bogus data in the stddev and pretty much
ignore it. Perhaps it would have been better not to add it to begin with :-p

The divide by zero scenario definitely needs to be fixed, and I may take my
last patch to fix it as it also stops some of the overflows.

But we can add another patch to stop the other overflows with some runtime
checks too.

-- Steve
