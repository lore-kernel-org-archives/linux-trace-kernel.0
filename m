Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029EC3164AA;
	Mon, 12 Oct 2026 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819365; cv=none; b=TC0mz47Hs8vyP50h9v2ekdxCNZQZZ1QYpEykOAZJkUCieW3Bx99ThSsAFQx5HwPHA9Ja0q85YWGo6f8v61fXTIKiKJeeYx83GvQTivNw5rX/bt7lq1nqQyBbXPqmIm76hATF7xNSINxME9SZ1mU9jDYxHkY93XhNFN/xHgeoTrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819365; c=relaxed/simple;
	bh=2vSF2gqBNcVkxH/IauI+5VVX0DbFCNuesHR91OHkwHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=TENWKGhu0uug/zxM1Aum2xxZjycWrqx/QWRn+Hg4euWhTarT+SWomMulnQGkgV3W4FZNVHSSbq0iqPZ9ghhzNi4FWSAohZxGtBv5xQ17LOoOK4PAZ5HQZwXGv1udpAZXYrH3NW/R3hUVsYOZ97e4jcfrbp5rPn4rGMH0SoPWoxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZV5/284; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZV5/284"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDF11F0089B;
	Mon, 12 Oct 2026 15:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819363;
	bh=AR8pnH24hBv5dJi1wECaTrxQRJQHXyrZ70Ek9hqLs9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UZV5/284QGe9fx1r2F2/VikE7yDbAOSgT57q7tbY/A4s5WnYxFkow5genW5H3XIWK
	 9/X1cXWsDsB869kwM+RrZWSQk9VPYgGnodeISdTT1zWNmRhQ8zgMO2m27Ogcj0IZgs
	 qc19KFY83VJ7+kNluavnnpZMkZ7xUsx16aa3jjfBNOFwHg7jJtkhv+55RWbQmbMcd8
	 5RLLw0qBXrAyFb3jjMI9jxteoSKkRSZcEc/GJ72/gBdn1Epw8nDNXvSF/14Dfu5/bN
	 +zEKvptSbkPcq3BlXVtfu9fTDbALdbUblaWmw/xifc0quubNEm+mbu+Gzc732/DCzE
	 ROQmHRAxLkZRA==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: woradorn.laon@gmail.com
Cc: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, inux-trace-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, shuah@kernel.org,
 skhan@linuxfoundation.org, me@brighamcampbell.com, jkoolstra@xs4all.nl,
 woradorn.laon@gmail.com
Subject: Re: [PATCH] tracing/selftests: Fix incorrect invocation of exit_fail
Date: Tue, 13 Oct 2026 00:35:58 +0900
X-Mailer: UndineD 0.1
In-Reply-To: <20260918061913.28069-1-woradorn.laon@gmail.com>
References: <20260918061913.28069-1-woradorn.laon@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261012153601.6DDF11F0089B@smtp.kernel.org>

On Fri, 18 Sep 2026 13:19:13 +0700, Woradorn Laodhanadhaworn <woradorn.laon@gmail.com> wrote:
> Replace all `exit fail` and `exit_fail;` with exit_fail to keep the
> usage of exit_fail consistent across the ftrace selftests. This also
> reduces warning messsege such as 'exit: Illegal number: fail'
> in test logs.
>
> Signed-off-by: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>

Looks good to me.

Fixes: 2f84b39f4847 ("tracing: Update subbuffer with kilobytes not page order")
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Shuah, can you pick this fix via your branch?

Thank you,

> ---
>  .../ftrace/test.d/00basic/ringbuffer_subbuf_size.tc         | 6 +++---
>  .../testing/selftests/ftrace/test.d/00basic/trace_marker.tc | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_subbuf_size.tc b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_subbuf_size.tc
> index d44d09a33a74..8cfe59d32b1f 100644
> --- a/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_subbuf_size.tc
> +++ b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_subbuf_size.tc
> @@ -60,7 +60,7 @@ test_buffer() {
>  	# the size must be greater than or equal to page_size - data_offset
>  	page_size=$((page_size-data_offset))
>  	if [ $size -lt $page_size ]; then
> -		exit fail
> +		exit_fail
>  	fi
>  
>  	# Now add a little more the meta data overhead will overflow
> @@ -71,14 +71,14 @@ test_buffer() {
>  	new_str=`awk ' /tracing_mark_write:/ { sub(/^.*tracing_mark_write: /,"");printf "%s", $0; exit}' trace`
>  
>  	if [ "$new_str" = "$str" ]; then
> -		exit fail;
> +		exit_fail
>  	fi
>  
>  	# Make sure the entire line can be found
>  	new_str=`awk ' /tracing_mark_write:/ { sub(/^.*tracing_mark_write: /,"");printf "%s", $0; }' trace`
>  
>  	if [ "$new_str" != "$str" ]; then
> -		exit fail;
> +		exit_fail
>  	fi
>  }
>  
> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc
> index 9aa0db2b84fc..1986c1bf1606 100644
> --- a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc
> +++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc
> @@ -68,14 +68,14 @@ test_buffer() {
>  	new_str=`awk ' /tracing_mark_write:/ { sub(/^.*tracing_mark_write: /,"");printf "%s", $0; exit}' trace`
>  
>  	if [ "$new_str" = "$str" ]; then
> -		exit fail;
> +		exit_fail
>  	fi
>  
>  	# Make sure the entire line can be found
>  	new_str=`awk ' /tracing_mark_write:/ { sub(/^.*tracing_mark_write: /,"");printf "%s", $0; }' trace`
>  
>  	if [ "$new_str" != "$str" ]; then
> -		exit fail;
> +		exit_fail
>  	fi
>  }
>  

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
