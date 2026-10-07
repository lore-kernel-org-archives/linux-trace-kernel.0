Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9953B27F4;
	Wed,  7 Oct 2026 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791367862; cv=none; b=MH2ncgJBO1WWdQIP+fiT+FffDYZ9nl4BpRMcoGNtwJ2680LIbV2/Rxcr3fNS917rxxl7M4HcjTKjeHatuH10np8OTRMvG81BMCVjikrSufSVhIhTXxdd2HWh8wX24MPmyV0H4b4y8v5xXKO2sb/sqPffnR/8WlxAOipG+Rz3x88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791367862; c=relaxed/simple;
	bh=H6VlnTbZoLL0Obq0sGmwrhxmClOhWmlxdkyvCn6fuNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=uHmhvtpg9YrMEpHJd3LYlTTFcmNGEduDkq8sQ+AjFeg9mcSoddjr8JfhW/c9i5CeTr5TPbAywR6oK0Jh/3GGW3mIfwwhxQ53a/g/Uw90kRwRWMORtjVxpRsUoubHmYlIFiNxEMD4P3L2teR0iyKUS+etWpbD2dhCQIFpnXPxsaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCXa1iDf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCXa1iDf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9881F0089C;
	Wed,  7 Oct 2026 10:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791367852;
	bh=vOH7ltGy6XiraLDUQDCsPzWkSHpFX75ZD94gqqUETbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jCXa1iDfV8UMCscd2lbZpzbIFmsTnq7vZ68C73AZQ33jMXrhhlW8ekI66jHC7R4GF
	 MlMzDwECzX68tSy1uw+amWMFeqYddn4T3wJiFhjmJvwpWzT81Vn9UFHvRKnkGiqZRX
	 GDe05ifiChkDEpkQc3QmqtA2CWVPTrKvL2JJslo/SkB4b4CtIlTMgyToQEQNwpu+ih
	 B36Sucq3OIfS/WhgxWBMwKQ+fL5ysA2v6Bl6sp8r6JRfwYPxA7+fzQD0R58eELZSGA
	 rRLmTxw7sVTGrol3jXwItnC3sizRJRPSLPlXKGViXOCLlF4oevlwQOX9kpI+KQQINy
	 nl7rHQeGGaevw==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: kylebot@openai.com
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, outbounddisclosures@openai.com,
 Kyle Zeng <kylebot@openai.com>
Subject: Re: [PATCH] tracing: Restrict perf filters that read kernel strings
Date: Wed, 07 Oct 2026 10:10:48 +0000
In-Reply-To: <20261006224005.49636-1-kylebot@openai.com>
References: <20261006224005.49636-1-kylebot@openai.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261007101050.ED9881F0089C@smtp.kernel.org>

On Tue, 06 Oct 2026 15:40:05 -0700, Kyle Zeng <kylebot@openai.com> wrote:
> A task-bound, counting-only syscall tracepoint can be opened without
> permission to read raw kernel tracepoint data. Setting exclude_kernel
> does not prevent its filter from running: perf_syscall_enter() submits
> the saved user-mode registers.
>
> Pointer-string filters use FILTER_PRED_FN_PCHAR by default, which reads
> through strncpy_from_kernel_nofault(). For sys_enter_openat, for example,
> the filename field comes directly from a syscall argument. An
> unprivileged caller can pass a kernel address, install a filter such as
> 'filename ~ "Linux version*"', and use the event count to test the
> contents of kernel memory, even with perf_event_paranoid=2.
>
> Check the compiled filter before installing it and require the same
> kernel and raw-tracepoint permissions as access to raw kernel tracepoint
> data for FILTER_PRED_FN_PCHAR. Inspect every predicate so that other
> events, operators, and boolean expressions cannot bypass the check.
> Return the permission error through the existing cleanup path before
> publishing the filter.
>
> Keep user-pointer (.ustring) and record-local predicates available under
> the existing policy. This leaves tracefs filtering and authorized kernel
> string filtering unchanged.
>
> Fixes: 5967bd5c4239 ("tracing: Let filter_assign_type() detect FILTER_PTR_STRING")
> Assisted-by: Codex:gpt-6-astra
> Signed-off-by: Kyle Zeng <kylebot@openai.com>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
