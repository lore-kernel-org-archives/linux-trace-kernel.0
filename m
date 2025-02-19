Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6D719DF6A;
	Wed, 19 Feb 2025 01:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739926876; cv=none; b=i5HywoRQQSYqwdZc+S0Fzelo0q+qNjuHEAsYONTWijAU5suT0XyztvYlbMZsA10Iax8OaISySILW6/Frvp45xhsWfLrpVcc+/gXyncClTFWp/fvuxYMgQhpzuPvMc6PMrwp/FC7LTNMqN2LYZhSM79YEegsmyK+NdPF7i2fgBjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739926876; c=relaxed/simple;
	bh=K27M5LdL2W/vFFCCuRxbGFedU1ZjRtE2yaMRw2l/oCg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tUlGzNpC5qhrfukWlp0egjmXVaG6FrmQp3xQ3eAuuR39hai+G9y39W/zKoPO8On8qcPdqucpLgJrhkNOXd1NcJwGqQnndpP1kF0iQS7TPfTkeQCBoSNYZ4vs0pH+HDtmkBz2kUjkwSzrIa8mYMyqzpAdSSyMispCeYlV8pAqyPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5cOSEhZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5cOSEhZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC61C4CEE2;
	Wed, 19 Feb 2025 01:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739926875;
	bh=K27M5LdL2W/vFFCCuRxbGFedU1ZjRtE2yaMRw2l/oCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L5cOSEhZ8vPUegAMpU7zp7peFtj48ey9OcxCeUVCT16T8MI6Y1U9C1OYIbwQp27tl
	 XD4KsvsqshxLDeFkJ8rymxUBl9dDtEO19+LwcVa5YeJWiM1OZg2mifRBGVdge7c9N+
	 wLEYV8moRPaq33RZ5ddB+BKkpU8CdmtLMC5He7o5pevINW8FzR0LljCCN/qk5RdWxa
	 O+S0gI59tiu93Zf717qCWOcTYGp74nPuYdclnpWhIkPTzi+hyvUYubj08+mALyZlFs
	 wNSs9kxyzOCAxhUPyHdTPewncfPOA25OL7HSyqm6IEkEATS3lfYITAjIiA7ugPYvcW
	 XyG5GUodgJtWg==
Date: Wed, 19 Feb 2025 10:01:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, Sven
 Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 5/5] selftests/ftrace: Update fprobe test to check
 enabled_functions file
Message-Id: <20250219100111.6e2c749e17b0f5e451cd6be0@kernel.org>
In-Reply-To: <20250218193126.956559192@goodmis.org>
References: <20250218193033.338823920@goodmis.org>
	<20250218193126.956559192@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 14:30:38 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> A few bugs were found in the fprobe accounting logic along with it using
> the function graph infrastructure. Update the fprobe selftest to catch
> those bugs in case they or something similar shows up in the future.
> 
> The test now checks the enabled_functions file which shows all the
> functions attached to ftrace or fgraph. When enabling a fprobe, make sure
> that its corresponding function is also added to that file. Also add two
> more fprobes to enable to make sure that the fprobe logic works properly
> with multiple probes.

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

BTW, would I pick the last 3 patches via probes/fixes branch?

Thanks,

> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  .../test.d/dynevent/add_remove_fprobe.tc      | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
> index dc25bcf4f9e2..449f9d8be746 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
> @@ -7,12 +7,38 @@ echo 0 > events/enable
>  echo > dynamic_events
>  
>  PLACE=$FUNCTION_FORK
> +PLACE2="kmem_cache_free"
> +PLACE3="schedule_timeout"
>  
>  echo "f:myevent1 $PLACE" >> dynamic_events
> +
> +# Make sure the event is attached and is the only one
> +grep -q $PLACE enabled_functions
> +cnt=`cat enabled_functions | wc -l`
> +if [ $cnt -ne 1 ]; then
> +	exit_fail
> +fi
> +
>  echo "f:myevent2 $PLACE%return" >> dynamic_events
>  
> +# It should till be the only attached function
> +cnt=`cat enabled_functions | wc -l`
> +if [ $cnt -ne 1 ]; then
> +	exit_fail
> +fi
> +
> +# add another event
> +echo "f:myevent3 $PLACE2" >> dynamic_events
> +
> +grep -q $PLACE2 enabled_functions
> +cnt=`cat enabled_functions | wc -l`
> +if [ $cnt -ne 2 ]; then
> +	exit_fail
> +fi
> +
>  grep -q myevent1 dynamic_events
>  grep -q myevent2 dynamic_events
> +grep -q myevent3 dynamic_events
>  test -d events/fprobes/myevent1
>  test -d events/fprobes/myevent2
>  
> @@ -21,6 +47,34 @@ echo "-:myevent2" >> dynamic_events
>  grep -q myevent1 dynamic_events
>  ! grep -q myevent2 dynamic_events
>  
> +# should still have 2 left
> +cnt=`cat enabled_functions | wc -l`
> +if [ $cnt -ne 2 ]; then
> +	exit_fail
> +fi
> +
>  echo > dynamic_events
>  
> +# Should have none left
> +cnt=`cat enabled_functions | wc -l`
> +if [ $cnt -ne 0 ]; then
> +	exit_fail
> +fi
> +
> +echo "f:myevent4 $PLACE" >> dynamic_events
> +
> +# Should only have one enabled
> +cnt=`cat enabled_functions | wc -l`
> +if [ $cnt -ne 1 ]; then
> +	exit_fail
> +fi
> +
> +echo > dynamic_events
> +
> +# Should have none left
> +cnt=`cat enabled_functions | wc -l`
> +if [ $cnt -ne 0 ]; then
> +	exit_fail
> +fi
> +
>  clear_trace
> -- 
> 2.47.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
