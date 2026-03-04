Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAF3225A38;
	Wed,  4 Mar 2026 02:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772589868; cv=none; b=SjgpWHOmMS2Db1Ay3AJyc7ooj2u2Ts4XBx5q0BAqhc92pfRXS57jins3urHfVcK5cIH4YNaTNov5vLvS2GDrRsuOiIkzZyZkx00bC7n+fbPz6sPbXYkaFZGgtJlNF+kP22eZbeNQgY8Dh6Kkkac/6QQeNPSTFO/B9DfJCqHwhlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772589868; c=relaxed/simple;
	bh=bu2JEb+Rf17VZQLWMg1vd3R4bY9db98CagjP+MKyUkU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Sv3RsNB1k9htpWpMrjyx4jf5LVA64MYH/AucAXCqd8bM7vTql4phW8GjAjmBRb4xcxYPsuhNiMKleg9ntnm/q4SnA0IiMEIVZoWlLc6UhKmw7JSM+V1rK22ayzCzLvjZdXEIz1hTXpeYfiNsi9A5lQjGnx7mK4Y0pVWIvSUYnqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qb634Cs5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qb634Cs5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60D7C116C6;
	Wed,  4 Mar 2026 02:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772589868;
	bh=bu2JEb+Rf17VZQLWMg1vd3R4bY9db98CagjP+MKyUkU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qb634Cs5jR/nwxMeNQPRySkN/aTYdTGhlE2xVrYaGkGus0CzscSrAgW8Rp8E2R3QW
	 qBZKIOsEipVorMesgLqrUPlq4ScBa3Zphd8VcxjVtAizwwBPOtaaqLbPmVRHe1Bfim
	 uBQsjcWSq0sOunAUBmR9xu2DX/krMMYuv4dozlTGj5IF+TNczAZBr+qaILiDZcEPcr
	 9BCORRCbzAAr9XRyCdJJd3BjbdRzFVHeQEWTaIGrybM+jOak/yljDpcqnkd0/7sGqD
	 XEnhDiJQpQ/VwypOEl4Iz39tT1nluDd8KQj8gjnkYV962iAzh2F/1fbkWs/fa+eJhL
	 Q6ktR/0i84hiQ==
Date: Wed, 4 Mar 2026 11:04:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/tracing: Fix to make --logdir option work
 again
Message-Id: <20260304110425.3858532b6ba092d84a31595a@kernel.org>
In-Reply-To: <177071725191.2369897.14781037901532893911.stgit@mhiramat.tok.corp.google.com>
References: <177071725191.2369897.14781037901532893911.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Shuah,

Could you pick these 2 patches to the selftests tree or should I pick it?

Thanks,

On Tue, 10 Feb 2026 18:54:12 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since commit a0aa283c53a7 ("selftest/ftrace: Generalise ftracetest to
> use with RV") moved the default LOG_DIR setting after --logdir option
> parser, it overwrites the user given LOG_DIR.
> This fixes it to check the --logdir option parameter when setting new
> default LOG_DIR with a new TOP_DIR.
> 
> Fixes: a0aa283c53a7 ("selftest/ftrace: Generalise ftracetest to use with RV")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  tools/testing/selftests/ftrace/ftracetest |   18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index 3230bd54dba8..0a56bf209f6c 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -130,8 +130,7 @@ parse_opts() { # opts
>        shift 1
>      ;;
>      --logdir|-l)
> -      LOG_DIR=$2
> -      LINK_PTR=
> +      USER_LOG_DIR=$2
>        shift 2
>      ;;
>      --rv)
> @@ -199,6 +198,7 @@ fi
>  TOP_DIR=`absdir $0`
>  TEST_DIR=$TOP_DIR/test.d
>  TEST_CASES=`find_testcases $TEST_DIR`
> +USER_LOG_DIR=
>  KEEP_LOG=0
>  KTAP=0
>  DEBUG=0
> @@ -210,12 +210,18 @@ RV_TEST=0
>  # Parse command-line options
>  parse_opts $*
>  
> +[ $DEBUG -ne 0 ] && set -x
> +
> +# TOP_DIR can be changed for rv. Setting log directory.
>  LOG_TOP_DIR=$TOP_DIR/logs
>  LOG_DATE=`date +%Y%m%d-%H%M%S`
> -LOG_DIR=$LOG_TOP_DIR/$LOG_DATE/
> -LINK_PTR=$LOG_TOP_DIR/latest
> -
> -[ $DEBUG -ne 0 ] && set -x
> +if [ -n "$USER_LOG_DIR" ]; then
> +  LOG_DIR=$USER_LOG_DIR
> +  LINK_PTR=
> +else
> +  LOG_DIR=$LOG_TOP_DIR/$LOG_DATE/
> +  LINK_PTR=$LOG_TOP_DIR/latest
> +fi
>  
>  if [ $RV_TEST -ne 0 ]; then
>  	TRACING_DIR=$TRACING_DIR/rv
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
