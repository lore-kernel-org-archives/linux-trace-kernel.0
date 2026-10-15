Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6444A3C7691;
	Thu, 15 Oct 2026 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792076160; cv=none; b=uA84sqIYn8ukZY4fb/DL8t6iRmsRTh6R5d8osXQfU/0wIMDdVXSjOMv+ilxaVk1lru3SW+NoN3lYsx3lZ6XRfwXZhf0I+7AL5PmjJjsYhHnHnRBE0wPi5ubtFy2xu91VnOSwntS4rXsqrmtjWsB5UDI9tsH0Y1aXpGrwGW9eJ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792076160; c=relaxed/simple;
	bh=JX4Rp0WX+9j2MktP4vpVcNRoanH80FVuYttHP/oNa9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=YPr90OlhuiH69V6hbHOL8Qoqv+9fffe6pzfS39ud8BcuSBbh1V7Uzte/9SgWm43TGjtKd78CHG0Dbd12dGm572yQOcAoFVUSP1HzDWB2dliFoIJXduOdnMrUod+7C+oDgZiuFTGnUPyiZ1hT40DyduJwQKeHD2oGE2vavu3hxxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbDs+gmv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbDs+gmv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFB41F000C4;
	Thu, 15 Oct 2026 14:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792076158;
	bh=sfNpcWGpTvdQK6lnbDP9vsTbCPKVjF4UGRe5DroLj8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YbDs+gmveHle48VccyQw6d0vtr4s8TpmDXuzzOXuwJUJYqWLzx98hLwhOoOq8DTie
	 LG+OY2UwsXLjBSFTisTQ40VI2CuyeWKj2t1P8lfVejc43dSOUBgZ1a1w12J1FxdKzV
	 afCEb+GR+XkZ8LV0JFOEXaIxQd/nHE6OTtK+KxOtENQnhyFSZsVdFLlI+8zHl3owgY
	 YIhlZjFsCwH1K3M2gNr3hL9TdUuFIehXCi/B/8KW+8y+m1k1Rwgrc8M7rSxUTydDLj
	 8FnzLaQycLWrp+vij6ViFO40bEOpMCEbgqc4QfPW8ppacdERLGTWKbnQNL0llBV8MS
	 0odb+l8YaNolw==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jaewon Jung <jaewon8868@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Add nice dependency
Date: Thu, 15 Oct 2026 23:55:55 +0900
X-Mailer: UndineD 0.1
In-Reply-To: <20261015022416.43534-1-jaewon8868@gmail.com>
References: <20261015022416.43534-1-jaewon8868@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261015145557.7AFB41F000C4@smtp.kernel.org>

On Thu, 15 Oct 2026 11:23:39 +0900, Jaewon Jung <jaewon8868@gmail.com> wrote:
> The tests use nice but do not list it as a requirement.
> Add nice to the requirements so the tests are unresolved, not failed,
> when it is not available.
>
> Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Shuah, will you pick this via your selftest branch?

Thank you,

> ---
>  .../test.d/trigger/inter-event/trigger-onchange-action-hist.tc  | 2 +-
>  .../test.d/trigger/inter-event/trigger-snapshot-action-hist.tc  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
> index 55ab0270e5f7..04e6db2a734d 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: event trigger - test inter-event histogram trigger onchange action
> -# requires: set_event "onchange(var)":README ping:program
> +# requires: set_event "onchange(var)":README ping:program nice:program
>  # flags: instance
>  
>  fail() { #msg
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
> index 9eb37c2fa417..64bb0dca7e3b 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: event trigger - test inter-event histogram trigger snapshot action
> -# requires: set_event snapshot events/sched/sched_process_fork/hist "onchange(var)":README "snapshot()":README ping:program
> +# requires: set_event snapshot events/sched/sched_process_fork/hist "onchange(var)":README "snapshot()":README ping:program nice:program
>  # flags: instance
>  
>  fail() { #msg
> -- 
> 2.43.0
>
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
