Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4691509AB;
	Mon, 20 Apr 2026 01:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776649344; cv=none; b=CBMMCLYKWylCgUj4rJwH9AI+QkE53e94nvbmFUlHYQrJ496eKWbkY/qdd3G+odDjFRcsmJVNwdaR/OoHaWnj8citb/Zp6JTLAiOuipY83oba9WfaDo8gntSB35t8uvIpaMIzoCrbE+0EqNRFVomhXMbB3+M7SZvVKsBvYOe6rd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776649344; c=relaxed/simple;
	bh=2fTaUVDOEn7ljswtnXmtAe8f02ApAbuE93fVLmMvkNA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qs/3AdfQsVYmxUAIhNvMkMzQnsPgNpBT8yY0LggT5L1sHZb0f/H2T6Xz3CP0MjBJbwZ/IgCuONnIcVhNFkNAYqMNAiwTDg/WOyS3HwJI7mrx5h1L04T4gPZrqgqFzgbzSnt4sD8SaoynOA0NuqSq2nPcTYGRLCMMHJwYH5pzBW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4kXFLye; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4kXFLye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CE8C2BCAF;
	Mon, 20 Apr 2026 01:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776649344;
	bh=2fTaUVDOEn7ljswtnXmtAe8f02ApAbuE93fVLmMvkNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z4kXFLyeamtt9lx8dz+wNsmTKJPo7kRmCv3X4Ms+FdgdkAE6fkLos7qp/iQCPRh8I
	 wyez7QiVoA0oRP2d9EDYuCo3HIwWdjoP0texdOIGj6RSsffw7LkXRlBtSrgmxA6l5z
	 BLgG4IAl68r0FSoN/Ca1otXGWcmPwsPieONjSR1wGE1mdEVolu8sVcU1dREmXTUIbz
	 xUvjDkZdqAr7ZfgFI3C5m48NdCiQLGyRVJs+jzEyOJnzGCtbELo+qudWYBXmxfmoJq
	 Efn8smbMzgm7elrfJiNP6cxiM6X+Ikdh3L3BIkmfmyf8UZwixVSL+A88OyENfJ1X08
	 ms6r5hp/A1xMA==
Date: Mon, 20 Apr 2026 10:42:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Menglong Dong
 <menglong8.dong@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v9 7/8] selftests/ftrace: Add a testcase for fprobe
 events on module
Message-Id: <20260420104220.625bb541f7e8127513f91a2a@kernel.org>
In-Reply-To: <177644271967.584467.9751522686479464647.stgit@mhiramat.tok.corp.google.com>
References: <177644266147.584467.8179035927318998910.stgit@mhiramat.tok.corp.google.com>
	<177644271967.584467.9751522686479464647.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Apr 2026 01:18:39 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add a testcase for fprobe events on module, which unloads a kernel
> module on which fprobe events are probing and ensure the ftrace
> hash map is cleared correctly.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v9:
>  - Use "trace-events-sample" instead of "trace_events_sample"
>  - Add checking unload module and remove core-kernel event case.
>  - Check test module exists when unloading it in EXIT.
>  Changes in v8:
>  - Newly added.
> ---
>  .../test.d/dynevent/add_remove_fprobe_module.tc    |   87 ++++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc
> new file mode 100644
> index 000000000000..c358c5071f15
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_module.tc
> @@ -0,0 +1,87 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Generic dynamic event - add/remove fprobe events on module
> +# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README enabled_functions
> +
> +rmmod trace-events-sample ||:
> +if ! modprobe trace-events-sample ; then
> +  echo "No trace-events sample module - please make CONFIG_SAMPLE_TRACE_EVENTS=m"
> +  exit_unresolved;
> +fi
> +trap "lsmod | grep -q trace-event-sample && rmmod trace-events-sample" EXIT

Oops, we need to check "trace_events_sample".

Thanks,

> +
> +echo 0 > events/enable
> +echo > dynamic_events
> +
> +FUNC1='foo_bar*'
> +FUNC2='vfs_read'
> +
> +:;: "Add an event on the test module" ;:
> +echo "f:test1 $FUNC1" >> dynamic_events
> +echo 1 > events/fprobes/test1/enable
> +
> +:;: "Ensure it is enabled" ;:
> +funcs=`cat enabled_functions | wc -l`
> +test $funcs -ne 0
> +
> +:;: "Check the enabled_functions is cleared on unloading" ;:
> +rmmod trace-events-sample
> +funcs=`cat enabled_functions | wc -l`
> +test $funcs -eq 0
> +
> +:;: "Check it is kept clean" ;:
> +modprobe trace-events-sample
> +echo 1 > events/fprobes/test1/enable || echo "OK"
> +funcs=`cat enabled_functions | wc -l`
> +test $funcs -eq 0
> +
> +:;: "Add another event not on the test module" ;:
> +echo "f:test2 $FUNC2" >> dynamic_events
> +echo 1 > events/fprobes/test2/enable
> +
> +:;: "Ensure it is enabled" ;:
> +ofuncs=`cat enabled_functions | wc -l`
> +test $ofuncs -ne 0
> +
> +:;: "Disable and remove the first event"
> +echo 0 > events/fprobes/test1/enable
> +echo "-:fprobes/test1" >> dynamic_events
> +funcs=`cat enabled_functions | wc -l`
> +test $ofuncs -eq $funcs
> +
> +:;: "Disable and remove other events" ;:
> +echo 0 > events/fprobes/enable
> +echo > dynamic_events
> +funcs=`cat enabled_functions | wc -l`
> +test $funcs -eq 0
> +
> +rmmod trace-events-sample
> +
> +:;: "Add events on kernel and test module" ;:
> +modprobe trace-events-sample
> +echo "f:test1 $FUNC1" >> dynamic_events
> +echo 1 > events/fprobes/test1/enable
> +echo "f:test2 $FUNC2" >> dynamic_events
> +echo 1 > events/fprobes/test2/enable
> +ofuncs=`cat enabled_functions | wc -l`
> +test $ofuncs -ne 0
> +
> +:;: "Unload module (ftrace entry should be removed)" ;:
> +rmmod trace-events-sample
> +funcs=`cat enabled_functions | wc -l`
> +test $funcs -ne 0
> +test $ofuncs -ne $funcs
> +
> +:;: "Disable and remove core-kernel fprobe event" ;:
> +echo 0 > events/fprobes/test2/enable
> +echo "-:fprobes/test2" >> dynamic_events
> +
> +:;: "Ensure ftrace is disabled." ;:
> +funcs=`cat enabled_functions | wc -l`
> +test $funcs -eq 0
> +
> +echo 0 > events/fprobes/enable
> +echo > dynamic_events
> +
> +trap "" EXIT
> +clear_trace
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
