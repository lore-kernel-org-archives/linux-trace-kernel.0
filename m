Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5501A9FBC;
	Tue, 24 Mar 2026 04:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774325527; cv=none; b=JOHPRpTOSvvYz1UJtVBXRWWKnCe1LeEDM7ri0wA2XJRLYk1vITbXOENlNZPG1t76iQN0JsxJ1yEJo+NnWfXtI+n3kOxmlgapZHMi08OdxnV5kW9sniCUMr5/GgrnZt9vwZ0H07G8Ms1HZBjsSqJesYA3ECZsghahNcDzbUWbNUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774325527; c=relaxed/simple;
	bh=GrpbaYNebG9Sp27pZAaVyfegWQ2nxuyNsHVi5DboqZo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Db/AZbjOnz9Zj7mIuEWu8ZZ2aYubZAke6uH2G/G9EtcuCTYkMAccg82Sgy26RrI0oVr7e7cU77Df40nOGSbqHlF4GcRPkmsMibeTp8SjnSCyjKhVlRnsa68pWpEixbumpV70YFWqp7E7gQwf1FodZbkfemBLBdQwq4V+Yd/V2nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+aR3CYf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+aR3CYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70C2C19424;
	Tue, 24 Mar 2026 04:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774325527;
	bh=GrpbaYNebG9Sp27pZAaVyfegWQ2nxuyNsHVi5DboqZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M+aR3CYfaXTQYiTT++ukVf+zs6odq1Gpx8IEQ1NJuHmzy/2dj+75yhZGgG1/fOSSK
	 fc13zmIxmeVm9tKGQaa6oxM+PXK8SlmNhuS4NaAPuQy+KSNESNahFXnB+W0Z8+RJOe
	 9tDgX3gTxhu2zN3xcf2nO+jX7nCAZNaHhTTlwWfMpm0jOzoeBo7C20YHzDYKQZ6njG
	 FxMNNOwCLPvmyRvTcrshrbiMCnX21vqeGPDZgR1VcM2BZEW9xMSDZCoRN/HsPnH0a6
	 E7wHOXgH0G9SCAr3cirxpvv9X/5ftulQcdAfTPOfQpfupdDQCmkfifqdRuyIGpiiLw
	 WTyFh0Em20buw==
Date: Tue, 24 Mar 2026 13:12:04 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Cc: rostedt@goodmis.org, corbet@lwn.net, shuah@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 4/4] selftests/ftrace: Add accept cases for fprobe
 list syntax
Message-Id: <20260324131204.735c60133288e94718f20d31@kernel.org>
In-Reply-To: <20260205135842.20517-5-seokwoo.chung130@gmail.com>
References: <20260205135842.20517-1-seokwoo.chung130@gmail.com>
	<20260205135842.20517-5-seokwoo.chung130@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Feb 2026 08:58:42 -0500
"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com> wrote:

> Add fprobe_list.tc to test the comma-separated symbol list syntax
> with :entry/:exit suffixes.  Three scenarios are covered:
> 
>   1. List with default (entry) behavior and ! exclusion
>   2. List with explicit :entry suffix
>   3. List with :exit suffix for return probes


Could you also add wildcard pattern test?

> 
> Each test verifies that the correct functions appear in
> enabled_functions and that excluded (!) symbols are absent.
> 
> Note: The existing tests add_remove_fprobe.tc, fprobe_syntax_errors.tc,
> and add_remove_fprobe_repeat.tc check their "requires" line against the
> tracefs README for the old "%return" syntax pattern.  Since the README
> now documents ":entry|:exit" instead, these tests report UNSUPPORTED.
> Their "requires" lines need updating in a follow-up patch.

This means you'll break the selftest. please fix those test first.
(This fix must be done before "tracing/fprobe: Support comma-separated 
symbols and :entry/:exit" so that we can safely bisect it.)

Thank you,


> 
> Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
> ---
>  .../ftrace/test.d/dynevent/fprobe_list.tc     | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc
> new file mode 100644
> index 000000000000..45e57c6f487d
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_list.tc
> @@ -0,0 +1,92 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Fprobe event list syntax and :entry/:exit suffixes
> +# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[:entry|:exit] [<args>]":README
> +
> +# Setup symbols to test. These are common kernel functions.
> +PLACE=vfs_read
> +PLACE2=vfs_write
> +PLACE3=vfs_open
> +
> +echo 0 > events/enable
> +echo > dynamic_events
> +
> +# Get baseline count of enabled functions (should be 0 if clean, but be safe)
> +if [ -f enabled_functions ]; then
> +	ocnt=`cat enabled_functions | wc -l`
> +else
> +	ocnt=0
> +fi
> +
> +# Test 1: List default (entry) with exclusion
> +# Target: Trace vfs_read and vfs_open, but EXCLUDE vfs_write
> +echo "f:test/list_entry $PLACE,!$PLACE2,$PLACE3" >> dynamic_events
> +grep -q "test/list_entry" dynamic_events
> +test -d events/test/list_entry
> +
> +echo 1 > events/test/list_entry/enable
> +
> +grep -q "$PLACE" enabled_functions
> +grep -q "$PLACE3" enabled_functions
> +! grep -q "$PLACE2" enabled_functions
> +
> +# Check count (Baseline + 2 new functions)
> +cnt=`cat enabled_functions | wc -l`
> +if [ $cnt -ne $((ocnt + 2)) ]; then
> +	exit_fail
> +fi
> +
> +# Cleanup Test 1
> +echo 0 > events/test/list_entry/enable
> +echo "-:test/list_entry" >> dynamic_events
> +! grep -q "test/list_entry" dynamic_events
> +
> +# Count should return to baseline
> +cnt=`cat enabled_functions | wc -l`
> +if [ $cnt -ne $ocnt ]; then
> +	exit_fail
> +fi
> +
> +# Test 2: List with explicit :entry suffix
> +# (Should behave exactly like Test 1)
> +echo "f:test/list_entry_exp $PLACE,!$PLACE2,$PLACE3:entry" >> dynamic_events
> +grep -q "test/list_entry_exp" dynamic_events
> +test -d events/test/list_entry_exp
> +
> +echo 1 > events/test/list_entry_exp/enable
> +
> +grep -q "$PLACE" enabled_functions
> +grep -q "$PLACE3" enabled_functions
> +! grep -q "$PLACE2" enabled_functions
> +
> +cnt=`cat enabled_functions | wc -l`
> +if [ $cnt -ne $((ocnt + 2)) ]; then
> +	exit_fail
> +fi
> +
> +# Cleanup Test 2
> +echo 0 > events/test/list_entry_exp/enable
> +echo "-:test/list_entry_exp" >> dynamic_events
> +
> +# Test 3: List with :exit suffix
> +echo "f:test/list_exit $PLACE,!$PLACE2,$PLACE3:exit" >> dynamic_events
> +grep -q "test/list_exit" dynamic_events
> +test -d events/test/list_exit
> +
> +echo 1 > events/test/list_exit/enable
> +
> +# Even for return probes, enabled_functions lists the attached symbols
> +grep -q "$PLACE" enabled_functions
> +grep -q "$PLACE3" enabled_functions
> +! grep -q "$PLACE2" enabled_functions
> +
> +cnt=`cat enabled_functions | wc -l`
> +if [ $cnt -ne $((ocnt + 2)) ]; then
> +	exit_fail
> +fi
> +
> +# Cleanup Test 3
> +echo 0 > events/test/list_exit/enable
> +echo "-:test/list_exit" >> dynamic_events
> +
> +clear_trace
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
