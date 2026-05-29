Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ED3370D4D;
	Fri, 29 May 2026 04:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780028716; cv=none; b=tROzdw/QraL3pJbo6wEyRBEKYpIEnMGUcGNpL89tF3TeumotOebpocORbnzc3vEX3tatoX8PhOAg/CYUO7MRl7Y1RV+mPFOFxvn6j4+sJ50Tz9/gV8IHMgXG9i/tYtO1aA238caSnIdY3k06twltD2991s2n0+iKC36GTLwdK+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780028716; c=relaxed/simple;
	bh=EteIklfoTXV0abyQwmeC1LwHuY+X5nQ2hepI42C9HHg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CKFq2duSPjL19T6/F5V8y3kGnx8dPAQL0h2JvviMRyXonCaMHYUBX8y2c4WW9CqXJDQwv7fSiyCOn8ohKiTgdZ7le3yRa6bFTxua14iKVzT4LhoR78cYRJmqv6J7wkpalvNixloMtI2zpH3CmAHqfDSBl63AZ6zFSXmLAwtPu3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7sQYCkv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7sQYCkv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841F71F00893;
	Fri, 29 May 2026 04:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780028715;
	bh=pezRyzBy6IkRIr0Rj0AWeB8WTJPU+hi3U7V2gbjQmZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I7sQYCkvt8H7Rse3D3IXKg3rESpJmh64wB3Fm8gzyTxNoB7ncmp8YDQpTklujfY9Z
	 Q9o0GptIohz7lwJouKDOjBmdO9Ikb8KaM+vkH02tuZK9in1LegOdlsrDl5UXUXjNWU
	 9VFdWD1d3XgGimffT/9oI/LSOKdtrcyUuSJxb3L0mgbWfwNlCp+AFSxV0X5AVoG9nj
	 4jO/acaBgNJF9LJEJGZvgekrOofbtGf9pj5w3gMMExrJkwsHu+ejDsN5swlier0Eur
	 fifuU45xGDDmr5aGGoW2t+Xk7uukP1O+uE2Mi2lntPh/rSNX/ICaUvV76aiNTPY6Qo
	 hC/MhkoMuFgTA==
Date: Fri, 29 May 2026 13:25:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, Takaya Saeki <takayas@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>, Tom Zanussi
 <zanussi@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>, Jiri Olsa
 <olsajiri@gmail.com>
Subject: Re: [PATCH v6] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-Id: <20260529132508.2e98cab925fdb1fa7be21a9b@kernel.org>
In-Reply-To: <20260521225033.56458336@fedora>
References: <20260521225033.56458336@fedora>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 22:50:33 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> +	if (ctx->flags & TPARG_FL_TEVENT) {
> +		int ret;
> +
> +		ret = parse_trace_event(varname, code, ctx);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (ctx->flags & TPARG_FL_TYPECAST) {
> +			type = ctx->last_struct;
> +			goto found_type;
> +		}
> +		return 0;

Here is a bit complicated but a buggy case.

parse_btf_arg() is not used for eprobe arguments because those
requires '$' prefix. However, only if it has a typecast, this
parse_btf_arg() is called for eprobes.

Thus, we should report a kernel bug if !ctx->flags & TPARG_FL_TYPECAST
here. Something like this:

		if (WARN_ONCE(!(ctx->flags & TPARG_FL_TYPECAST)))
			return -EINVAL;
		type = ctx->last_struct;
		goto found_type;

Thanks,
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
