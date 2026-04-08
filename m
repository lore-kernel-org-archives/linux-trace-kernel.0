Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE56410F1;
	Wed,  8 Apr 2026 00:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775609364; cv=none; b=I8mX8zSVrz54zNyqDRiK/l3QJ2ZZmIVLOTQHuI5dgtj1OvznIkVJ8D803M6HXUf5i8GYjcN2CZ5IQ5WDyK8w5ipBW9se8psPVOe1AWsNjd+Gn42ZIWyMGV8jQmnRIxwpHSjhDiawlzlgv1b7hWKHSK9yEVJEKyqV+Flpvl8+wuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775609364; c=relaxed/simple;
	bh=hE5EVp/Myefxt22uRsXlRHaLo5BcP7S2IdMqn/YcaOo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VJ+puGeEKCthhA9PO2yHdlVBx0EAVU+ft8NYhW96EVdhNBkaH4zIcuNwktincj2a9DzZgJoWltLXtLHzyGkyyKWRG8DG9+7uBDH17NNqZFexOJETweSAdDKQLTP0PVQL87tHKwk3UH/yd8ZC7kfNbvx1uDz26wrwtcc+Nz2pxeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcyfEUkr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcyfEUkr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAC9C116C6;
	Wed,  8 Apr 2026 00:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775609363;
	bh=hE5EVp/Myefxt22uRsXlRHaLo5BcP7S2IdMqn/YcaOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CcyfEUkrMfLu/jc7JRJLW/HFihnQK+3W2km8X/jlhL3INP7kCoyT5bKhN4VTFkqEw
	 z5Iiik0T2OyXccDQbvSq/TWHQSXMoctiTxEpXT/Bb1PkulDSRnOMlw75BUlqyMcIfj
	 BwxGcqJRPUUC5yRC9dUwE5iD2PMQAAtWt2FHzJlJQzX4cvjPTBs04WJDSS2JUhnhEp
	 O7l67H5kKp8eCiEVbTuwdHosqL5pWEDt/zrCJWy32eSyfOktIG9c6KrRhq74Uz2w8n
	 l/vqJBv+2QPL90n8VJL++zMWSNpalz3pi4RksMgOBrMiZ361BjXxYfoFuxR9A3BSI/
	 Zcj9w3ji1NMiA==
Date: Wed, 8 Apr 2026 09:49:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Cao Ruichuang <create0818@163.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Account for fprobe attachment at
 creation
Message-Id: <20260408094920.417cbb5e64220afc2bf1b2aa@kernel.org>
In-Reply-To: <20260407115751.96184-1-create0818@163.com>
References: <20260407115751.96184-1-create0818@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Apr 2026 19:57:51 +0800
Cao Ruichuang <create0818@163.com> wrote:

> add_remove_fprobe.tc assumes that enabling an fprobe event is what adds
> its target function to enabled_functions.
> 
> On the current kernel, the fprobe target already appears in
> enabled_functions as soon as the event is created, and enabling the
> event does not change that count again. That makes the test fail even
> though the event lifecycle itself works.
> 
> Record the attachment baseline after creating the probe events and only
> check that enabling them keeps the expected functions attached. The
> cleanup checks still verify that removing the events returns
> enabled_functions to its original state.
> 

Hmm, did you run this test with not clean environment?
It is not designed to do so.
(I think we should not check ocnt, or if there are any entries,
 we should stop this test as unresolved.)

Thank you,

> Signed-off-by: Cao Ruichuang <create0818@163.com>
> ---
>  .../test.d/dynevent/add_remove_fprobe.tc      | 28 +++++++++++++------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
> index 47067a5e3..ff08bd1ac 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
> @@ -26,23 +26,29 @@ grep -q myevent2 dynamic_events
>  grep -q myevent3 dynamic_events
>  test -d events/fprobes/myevent1
>  test -d events/fprobes/myevent2
> -
> -echo 1 > events/fprobes/myevent1/enable
> -# Make sure the event is attached.
>  grep -q $PLACE enabled_functions
> +grep -q $PLACE2 enabled_functions
>  cnt=`cat enabled_functions | wc -l`
> -if [ $cnt -eq $ocnt ]; then
> +if [ $cnt -le $ocnt ]; then
> +	exit_fail
> +fi
> +
> +echo 1 > events/fprobes/myevent1/enable
> +cnt1=`cat enabled_functions | wc -l`
> +if [ $cnt1 -ne $cnt ]; then
>  	exit_fail
>  fi
>  
>  echo 1 > events/fprobes/myevent2/enable
>  cnt2=`cat enabled_functions | wc -l`
> +if [ $cnt2 -ne $cnt1 ]; then
> +	exit_fail
> +fi
>  
>  echo 1 > events/fprobes/myevent3/enable
> -# If the function is different, the attached function should be increased
>  grep -q $PLACE2 enabled_functions
>  cnt=`cat enabled_functions | wc -l`
> -if [ $cnt -eq $cnt2 ]; then
> +if [ $cnt -ne $cnt2 ]; then
>  	exit_fail
>  fi
>  
> @@ -62,11 +68,15 @@ if [ $cnt -ne $ocnt ]; then
>  fi
>  
>  echo "f:myevent4 $PLACE" >> dynamic_events
> +grep -q $PLACE enabled_functions
> +cnt=`cat enabled_functions | wc -l`
> +if [ $cnt -le $ocnt ]; then
> +	exit_fail
> +fi
>  
>  echo 1 > events/fprobes/myevent4/enable
> -# Should only have one enabled
> -cnt=`cat enabled_functions | wc -l`
> -if [ $cnt -ne $((ocnt + 1)) ]; then
> +cnt2=`cat enabled_functions | wc -l`
> +if [ $cnt2 -ne $cnt ]; then
>  	exit_fail
>  fi
>  
> -- 
> 2.39.5 (Apple Git-154)
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
