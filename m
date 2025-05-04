Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3441684A4;
	Sun,  4 May 2025 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746351721; cv=none; b=oz5F+MMw2MpqhjL5wIsK+6LJH+mvGHM3B0X9Uf2DGy+ecChzus3c0NWuS3D0VcGBzP/mwVLGS6RJH+z8yReL9p+ygTmpcncklafRAuvfejwaWmszGKw1UYiUnlgKkGzMy66xxSOMCvpJewQa6Gq56pmR1KCBu1dGp+lucBW4Qk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746351721; c=relaxed/simple;
	bh=dSzA91nB8CHSr5Hse/nAOssPhfcOywqtv0vsP7ZdSZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNy7LKpygDDovSSdTIFTKSLVj39oUPxuoouGGQjC6dEHzS2wykBtlSfooLnWGVHu4gJnGV2buYJH44lHGgnHZ4U9a4NoB57y8ICSYlkIMI4MRK2M/gHr0bnV5bWGZEq6RGmJ/RZNe/IrAdI3JLYFZLJFC8rgIcVDhNtAWRPTcCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6kiUgse; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6kiUgse"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0802C4CEE7;
	Sun,  4 May 2025 09:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746351720;
	bh=dSzA91nB8CHSr5Hse/nAOssPhfcOywqtv0vsP7ZdSZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6kiUgseaMvEWkO9T1um+E/WfyFjnTdfWEdsxtmEjGz8YsP7CQ0P51slYCCfcVyl5
	 IBijlAyqvCQpp4R7rxgUEJ+dr4v+z1BcFj5viKEJxR+hbb1+CgXYn7gCk2m75htSli
	 h77ZFZbbcig0MHHYaYDXHp8mgbkvLA5AcQmZz02Pk195YhSd+GuE2w5l5BtiD4PMUN
	 W9NzADD5zwAUR7kehlMiO2dtQd9dcvu3qgfVs+sfUj9byKVj4wfx1qY2NAdXe2RT+O
	 6nuNmVFzej5oUiMi1/2fFRxOKNHLn6tBO/v1MHckk8Rx+nod88q66SJ+OT0pM1/87G
	 qqwDN6NUUd+nQ==
Date: Sun, 4 May 2025 11:41:56 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v7 00/17] unwind_user: perf: x86: Deferred unwinding
 infrastructure
Message-ID: <aBc2ZBlQTpybK3Z-@gmail.com>
References: <20250502164746.178864972@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502164746.178864972@goodmis.org>


* Steven Rostedt <rostedt@goodmis.org> wrote:

>       unwind_user: Add user space unwinding API
>       unwind_user: Add frame pointer support
>       unwind_user/x86: Enable frame pointer unwinding on x86
>       perf/x86: Rename and move get_segment_base() and make it global
>       unwind_user: Add compat mode frame pointer support
>       unwind_user/x86: Enable compat mode frame pointer unwinding on x86
>       unwind_user/deferred: Add unwind cache

What is the cost of 'caching' here? Will we double-buffer the tracing 
data before it reaches its single primary tooling user, with no use of 
any actual 'caching', which will be scenario in like 99.9% of the 
everyday usecases when this facility is used?

>       unwind_user/deferred: Add deferred unwinding interface
>       unwind_user/deferred: Make unwind deferral requests NMI-safe
>       perf: Remove get_perf_callchain() init_nr argument
>       perf: Have get_perf_callchain() return NULL if crosstask and user are set
>       perf: Simplify get_perf_callchain() user logic
>       perf: Skip user unwind if the task is a kernel thread.

Please don't leave periods in titles.

Thanks,

	Ingo
