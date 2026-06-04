Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1D18871F;
	Thu,  4 Jun 2026 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565694; cv=none; b=OuHyQgfs4iMpUDitjhyRd+PTnS4pJP7WR3YwrnJVE8LSxm4FB05RVotJ46vH3FQ43Zx+CR99oVjf3Riuxxx0bLDC8X2JNBO+DKvKl0jZhAyXimdLmn/ruFbEqN4IVS3J3wMaOOrAtyY2cVBvt3XLPhbxjto805RB/d+5VAzA0jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565694; c=relaxed/simple;
	bh=YfAeJ06oxFq13xAWPlJyuWM6cBIfokfmiJ5IxY9FIx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCXYCJoI+PY9pFX/5OdejVMd0Ido9EyNndT9PGuyB2cdnjpZQL/fXZyIxd2JGnmni1Re4CcaZa6+DJ2tnOxVuzguh9715CYeok33qb/3Kifb54fdV0mjBzRSDv0O0AgwAZRbTpQSe4RMD9vqdFPIp+lsBzAU0mAXPnBYDHBEC4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a/aWqTp1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a/aWqTp1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oAIOfYNzNKrl7NU/dsuIGGnjFpaY7UfhCHlbjkfTv2M=; b=a/aWqTp18bxGWjqPFafudwl1ud
	78GAHabhWpar2q8+xd7vNCu2jkDHdK5E+mNgBMNF6ZqANjL7oL3cRQcP3tuAENBqR6pitkWuKbFlQ
	K6RO4qi9PjDCoU/K2+/wuTCISKZ3u8grfKLlEv7Ax5gdXs2vNFvh2hW0ogOP8Wi+jGUPU/dguHjw8
	O0/xero/jcap3KfqMFa4L+CuTLCKNoi1Or7bICk1PhMcfn4eQDXvHBWY7iMLTs3CThLgCLFzT+VAR
	Jq0hqW5+cVL/ol2fvBs8bURjRrKpwV5X4WGjRvGvTeSsUuxlhzewmkaFdC66vEHGHO56sZqfnM1aF
	LShLse4g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wV4TO-0000000E8uY-1HhS;
	Thu, 04 Jun 2026 09:34:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 947733001FD; Thu, 04 Jun 2026 11:34:45 +0200 (CEST)
Date: Thu, 4 Jun 2026 11:34:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Tengda Wu <wutengda@huaweicloud.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rethook: Use tsk->on_cpu to check task execution state
Message-ID: <20260604093445.GF3126523@noisy.programming.kicks-ass.net>
References: <20260525132253.1889726-1-wutengda@huaweicloud.com>
 <20260526123719.482f07a3843e207e22d95378@kernel.org>
 <94179dab-ffb7-4fab-af45-b20bfb686ab3@huaweicloud.com>
 <20260601084001.9566b443746447ec2bb1a9fb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601084001.9566b443746447ec2bb1a9fb@kernel.org>

On Mon, Jun 01, 2026 at 08:40:01AM +0900, Masami Hiramatsu wrote:

> Peter, is it OK to drop @rq from task_on_cpu()? 

Sure.

> Then we can use it from rethook.

Well, it is in sched/sched.h, which is an internal header, and no you
cannot use that header in rethook.

But lets step back first, what is the actual problem here, why are we
looking at ->on_cpu at all?
