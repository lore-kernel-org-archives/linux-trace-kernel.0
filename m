Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C6522171E;
	Wed, 26 Feb 2025 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581691; cv=none; b=R+j2c9lC0gM4T23Ke96t2npoT1z8O3dGm+EmSEYz66V1Nf6SKTlILfiH+hW0/rJtgrnbThG3n1T+/aVWY//VHGoJ3nRJ26j4tWKk2zT7kFoIVRxxSUplbjP9H41K2AxTvhIUBgFehebRFYLVyssW9e9Bikj4AUsjxIk8Bdi89rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581691; c=relaxed/simple;
	bh=N5pfdNLe+7DSuFxXMeqe3V85svqYKJ23Y9wxDbruU6I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VRsn5/TWroT5fipp0RxX16WIPl6s5SOEL5MaqF5EYMuZsALsGg0UzFIeIMDTLWzPv++3kR3d9RP2uv+MwBoUTB9yz6z3Tef8zdVbV13FCXAnnTd4EyqkpXydGvgUviU1c872OeP6u5fHPCre5SJhwmZv6OLL/BlUYhMGOjM/O58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PukYN0zX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PukYN0zX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D6BC4CEE4;
	Wed, 26 Feb 2025 14:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740581690;
	bh=N5pfdNLe+7DSuFxXMeqe3V85svqYKJ23Y9wxDbruU6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PukYN0zXjnAWKdcvGpAeXpJqOOEjbYMMAU++3I2Xbg3JD8MT/tFbWUqZuLr+JlFgo
	 ndfkdrD2jkTCNOEGJyMkvtQy3bV63AxMAeVFTT1BSRNe+B2xcIS7ZQzU3Gd0QuvuV4
	 C1mqwYoxuih6faDiufJD0j1/2WFyOjeXh07TmNLXU4HMorq3GLuB+cmifEDfdBbdre
	 mFzm+d7LyljvGG9pcuFd7c1GvXjH7JxLDZ3eDnpszJ9iceystmeXrlGQOn+7KvaAwz
	 Lziee9uh+nHU29WiuIlnC4vNiZK1H2uqo0o8xJVhEgi4x+KNmCQ0ajbM5F+FmlyLnH
	 RGix7N+82K9lw==
Date: Wed, 26 Feb 2025 23:54:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Sven Schnelle
 <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Let fprobe test consider already
 enabled functions
Message-Id: <20250226235447.7fab8051b2968277ce6920db@kernel.org>
In-Reply-To: <20250226142703.910860-1-hca@linux.ibm.com>
References: <20250226142703.910860-1-hca@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 15:27:03 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> The fprobe test fails on Fedora 41 since the fprobe test assumption that
> the number of enabled_functions is zero before the test starts is not
> necessarily true. Some user space tools, like systemd, add BPF programs
> that attach to functions. Those will show up in the enabled_functions table
> and must be taken into account by the fprobe test.

Hmm, this ftrace selftests has been expected to be run without 
any BPF programs... Is there any other issue on other test cases?

Anyway, this looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!


> 
> Therefore count the number of lines of enabled_functions before tests
> start, and use that as base when comparing expected results.
> 
> Fixes: e85c5e9792b9 ("selftests/ftrace: Update fprobe test to check enabled_functions file")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  .../test.d/dynevent/add_remove_fprobe.tc       | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
> index 449f9d8be746..73f6c6fcecab 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
> @@ -10,12 +10,16 @@ PLACE=$FUNCTION_FORK
>  PLACE2="kmem_cache_free"
>  PLACE3="schedule_timeout"
>  
> +# Some functions may have BPF programs attached, therefore
> +# count already enabled_functions before tests start
> +ocnt=`cat enabled_functions | wc -l`
> +
>  echo "f:myevent1 $PLACE" >> dynamic_events
>  
>  # Make sure the event is attached and is the only one
>  grep -q $PLACE enabled_functions
>  cnt=`cat enabled_functions | wc -l`
> -if [ $cnt -ne 1 ]; then
> +if [ $cnt -ne $((ocnt + 1)) ]; then
>  	exit_fail
>  fi
>  
> @@ -23,7 +27,7 @@ echo "f:myevent2 $PLACE%return" >> dynamic_events
>  
>  # It should till be the only attached function
>  cnt=`cat enabled_functions | wc -l`
> -if [ $cnt -ne 1 ]; then
> +if [ $cnt -ne $((ocnt + 1)) ]; then
>  	exit_fail
>  fi
>  
> @@ -32,7 +36,7 @@ echo "f:myevent3 $PLACE2" >> dynamic_events
>  
>  grep -q $PLACE2 enabled_functions
>  cnt=`cat enabled_functions | wc -l`
> -if [ $cnt -ne 2 ]; then
> +if [ $cnt -ne $((ocnt + 2)) ]; then
>  	exit_fail
>  fi
>  
> @@ -49,7 +53,7 @@ grep -q myevent1 dynamic_events
>  
>  # should still have 2 left
>  cnt=`cat enabled_functions | wc -l`
> -if [ $cnt -ne 2 ]; then
> +if [ $cnt -ne $((ocnt + 2)) ]; then
>  	exit_fail
>  fi
>  
> @@ -57,7 +61,7 @@ echo > dynamic_events
>  
>  # Should have none left
>  cnt=`cat enabled_functions | wc -l`
> -if [ $cnt -ne 0 ]; then
> +if [ $cnt -ne $ocnt ]; then
>  	exit_fail
>  fi
>  
> @@ -65,7 +69,7 @@ echo "f:myevent4 $PLACE" >> dynamic_events
>  
>  # Should only have one enabled
>  cnt=`cat enabled_functions | wc -l`
> -if [ $cnt -ne 1 ]; then
> +if [ $cnt -ne $((ocnt + 1)) ]; then
>  	exit_fail
>  fi
>  
> @@ -73,7 +77,7 @@ echo > dynamic_events
>  
>  # Should have none left
>  cnt=`cat enabled_functions | wc -l`
> -if [ $cnt -ne 0 ]; then
> +if [ $cnt -ne $ocnt ]; then
>  	exit_fail
>  fi
>  
> -- 
> 2.45.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
