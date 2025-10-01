Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA592BE02B;
	Wed,  1 Oct 2025 23:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759360986; cv=none; b=ZCw6mpguhRa3xVUIAUz0uAFpyG/8RB03HDyp0bLTOu8z/1FcLdNJiyLRbq2NECOI/SEIkc+Ugwelzgtzm91o3bEqJzxBy2EsUy6LxvXu0UnklFxWf6AwYcXwMJZreOXDGS7g8h/2ErACRpj4ZWYsjXzZqYlPaSh0Nc9XKrhR2cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759360986; c=relaxed/simple;
	bh=OaJwKx164mjwazfI+P9qEAACr+27VZ/B3fB9uZpCc4M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TjamRd/eCoqF4Xj5dutGKex4ZZa5+8eHmcWJPmbHlr/j+YsMdfuxKua/F8G42U7oF7BNM766plu/xUb8cJE2ueVDcXGRozRgpQDnq5jMLvNkr+ptgGgX3pnq6/Y1f2NIqVw1JhAitZcxvJxBhu+KNqTJhzT70ZFg/hwZMj8+2kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UA7GIn/K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UA7GIn/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4147AC4CEF1;
	Wed,  1 Oct 2025 23:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759360985;
	bh=OaJwKx164mjwazfI+P9qEAACr+27VZ/B3fB9uZpCc4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UA7GIn/KFJJN1NH1fqz1mA1eeiqFEgJFdF+6Jo/sig0lvXRw+qrJaSfaoRTaCEvtb
	 cr0p3yHAC052R12Mtr2vSt/g++NaJ7O0WC4bVHD/hoYiV6Tz4slqFia6oyQtymAGcl
	 77+9619aQSbBfq7yL/67gpv14fKSo2rLLfd+ETtaEFaVNDjrF7BbaBAWyWSgbG0Z6/
	 nMNTNltxRz0uPEn6kIA2VrKkZXl3UBPlYUBHJjkWiA5L3F6y7cj3Do4IkRJt4FJsaP
	 5klxpiUTy1hCoeqTmhwCACYxKeDYbjY9S87Ul72hFvjECs8w6FWuUpmHIvtg28abUq
	 RqyIRcDkXz7zg==
Date: Thu, 2 Oct 2025 08:23:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: chenyuan_fl@163.com, mhiramat@kernel.org, bigeasy@linutronix.de,
 chenyuan@kylinos.cn, john.ogness@linutronix.de,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, rostedt@goodmis.org
Subject: Re: [PATCH v4] tracing: Fix race condition in kprobe initialization
 causing NULL pointer dereference
Message-Id: <20251002082301.a20b2d5ea4379c33cd9c5953@kernel.org>
In-Reply-To: <20251001123200.GN4067720@noisy.programming.kicks-ass.net>
References: <20251001003707.3eaf9ad062d5cad96f49b9ba@kernel.org>
	<20251001022025.44626-1-chenyuan_fl@163.com>
	<20251001123200.GN4067720@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Oct 2025 14:32:00 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Oct 01, 2025 at 03:20:25AM +0100, chenyuan_fl@163.com wrote:
> 
> > 
> > v1->v2: Fix race analysis (per Masami) - kprobe arms in class->reg().
> > v2->v3: Adopt RELEASE/ACQUIRE semantics per Peter/John's suggestions,
> >         aligning with Steven's clarification on barrier purposes.
> > v3->v4: Introduce load_flag() (Masami) and optimize barrier usage in
> >         checks/clear (Peter).
> 
> Stuff like this ought to go below the --- such that git-am and similar
> tools throw it out.

Yeah, let me remove it manually this time.

Yuan, please put changelogs like below next time:

---
  v1->v2: Fix race analysis (per Masami) - kprobe arms in class->reg().
  ...



Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
