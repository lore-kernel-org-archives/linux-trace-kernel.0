Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1BD3126AC;
	Wed,  1 Oct 2025 22:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759359570; cv=none; b=TONBf+qPgLpgWnFacfX9MftQA2PsZVWWqxfqJMeMU7dULz5QsQ4v3n1XGpgF/6SVOHeW4bJ3d8Jzz/KHXucauirK28FDBu9tKJbDGqXwimUYAnEn5QzLBLnmuS4kxBSPoV8gMuorr5Y/HEHIJMvVftmBELdr4Njo8meiJ1k2hNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759359570; c=relaxed/simple;
	bh=agXdkieca8BfRHPymdWSNZNOugOyRGYDoDDEgRKk/aI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Q327ODCAKKP5+64UyM9JM+kBMl+MZPDSn8eUH0HEPbnH6lqb3Ify3L44e46SMhXgU713xVd0Gng5JsHKShdtrGNywlOUAL4ke/rLFfQ8BbqG8Slde1xUf1Von9eEPGXwy1NNtM3436+Erx4FzJYdtptsJwsy8Iu1bVMVGXdNtUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M33aXQwK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M33aXQwK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B729C4CEF7;
	Wed,  1 Oct 2025 22:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759359569;
	bh=agXdkieca8BfRHPymdWSNZNOugOyRGYDoDDEgRKk/aI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M33aXQwKXfTEz0llfjPPitVi2XS5FxLNHzjdZAxPp9ykwGkFDNRzxU5rPIRUD42WX
	 /EDhYv3gQ1A120DlWimp4SyHIsZh9nKsoe1TiXGS3ef+8xjb8j0ZlLS0bt4SdaqPGU
	 esZ5AGwR+Q+atE/DA2cF9XGvHVpKHl8iDAkBlqKXDj6CrBXmHbszN9y4afus3lCZf2
	 AGwmGHStyYcUIVWNj6lIDF0gt3HYSRoFnKO+VBkC5TjbuF3t5KTzNEp3DGqHY5Yi1I
	 dEP6v1lNHz1aMpUL1Q/a9/Dy5XVhW6KtlxnjqlrjXwDyN2IfghS4Rk76nF5CJwpno6
	 D7rAm1n5ldUZw==
Date: Thu, 2 Oct 2025 07:59:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, chenyuan_fl@163.com,
 mhiramat@kernel.org, bigeasy@linutronix.de, chenyuan@kylinos.cn,
 john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4] tracing: Fix race condition in kprobe initialization
 causing NULL pointer dereference
Message-Id: <20251002075924.6c97aaf0ecb9500418c87680@kernel.org>
In-Reply-To: <20251001103149.2d52d03f@gandalf.local.home>
References: <20251001003707.3eaf9ad062d5cad96f49b9ba@kernel.org>
	<20251001022025.44626-1-chenyuan_fl@163.com>
	<20251001123200.GN4067720@noisy.programming.kicks-ass.net>
	<20251001103149.2d52d03f@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Oct 2025 10:31:49 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 1 Oct 2025 14:32:00 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Anyway, patch looks reasonable now. Rest is up to Steve, this is his
> > code.
> 
> Actually, it's Masami's ;-)  And it's up to him.

Yeah, looks good to me. Let me pick it as a fix.

Thank you!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
