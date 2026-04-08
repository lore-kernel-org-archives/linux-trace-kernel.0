Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B7725B2FA;
	Wed,  8 Apr 2026 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775683040; cv=none; b=I208U8sHm/M0eo3oxxNRCQ7zDb4EHdZtOdg9n+d+6duy/W7bxsuZoavbgxpkZOYb48aSs4Cmv9oaKxXwugvjXu+VC/PDtSJBZEBFrlblJYMKwI9RAzCKftPGDq082M8h9Deaqx8ogJBoPISUChZJXiTxdTccxmuVy1/YvekMuic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775683040; c=relaxed/simple;
	bh=kL4JIANbRkLCjsk/v05rCxdjsPuz7hyQ3m06eD+7240=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWVNQw2sxlF5hlJ4PJVqPdaEiJDi0aIkNlxT22pXpXmQ06+nqaSvDzAZBwug8EirDOK48IPayYMrjZ+6o+4OKXJshj6rxeQ1QYDT5FNVk/DzN3trfJAPkz5W/wMaJxm60OIqkctroSRJehEzFPgW1IGDLsKt8kA5h4VSTKksJNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 7E7C4C1473;
	Wed,  8 Apr 2026 21:17:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 7B27820010;
	Wed,  8 Apr 2026 21:17:14 +0000 (UTC)
Date: Wed, 8 Apr 2026 17:18:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Cao Ruichuang <create0818@163.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/ftrace: Quote check_requires comparisons
Message-ID: <20260408171831.69520c50@gandalf.local.home>
In-Reply-To: <20260408043212.8063-1-create0818@163.com>
References: <20260408043212.8063-1-create0818@163.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qggikak9uuwqsaubqgdnoumrbc8tkozr
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 7B27820010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/GA0BHY3Qdn+SBbEeagXI+9QeaobFAzLs=
X-HE-Tag: 1775683034-244701
X-HE-Meta: U2FsdGVkX182U5ZUSLlNzQU9MUzBlRa9DQUhfZ0PvfdWkpyNZxJ5/9wZNno4//2tqUIaUyuZukqoJXHgANNou6Se1we0VyH4iFbjAj+ZuDhddyzRmKLIRRaXUEpMPQxUwvl3fsc7jrVDfZM22he5vBfY+RavZS8Lmp+XHMmaAW73Bl2tRw2XrE0bMpOrTMAaHYjf87s9+SPYgUFiszp9ycaYUrG+d5U/2g+GSmZrm3dbwW0imfINYPjC53U1t2Fv0U/ofTflL4KHjge5WM2rJJ/qtyzRtVCWunWFDbg71zKhPOtVhDZbAsq6GWE6ZHUE0kcQcgubbhr+38f0A3z0z2Q8GYI/rFZQTwidb5jbul2zSAxU4PsQ6o8ROabSQGa8seiIDa/hCJOGLjnIHmBhbA==

On Wed,  8 Apr 2026 12:32:12 +0800
Cao Ruichuang <create0818@163.com> wrote:

> check_requires() compares requirement strings that can contain shell
> pattern characters such as '[' and ']'. Under /bin/sh, the unquoted
> test expressions can emit 'unexpected operator' warnings while parsing
> README-backed requirements.
> 
> Quote the relevant comparisons and path checks so the helper handles
> those patterns without spurious shell warnings.
> 
> Validated by rerunning fprobe_syntax_errors.tc and confirming the
> previous '/bin/sh: unexpected operator' lines disappear from the
> detailed ftracetest log.
> 
> Signed-off-by: Cao Ruichuang <create0818@163.com>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Shuah,

Care to take this through your tree?

-- Steve

> ---
>  tools/testing/selftests/ftrace/test.d/functions | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> index e8e718139..442aa28ff 100644
> --- a/tools/testing/selftests/ftrace/test.d/functions
> +++ b/tools/testing/selftests/ftrace/test.d/functions
> @@ -145,13 +145,13 @@ check_requires() { # Check required files and tracers
>  	p=${i%:program}
>          r=${i%:README}
>          t=${i%:tracer}
> -	if [ $p != $i ]; then
> -	    if ! which $p ; then
> +	if [ "$p" != "$i" ]; then
> +	    if ! which "$p" ; then
>                  echo "Required program $p is not found."
>                  exit_unresolved
>  	    fi
> -        elif [ $t != $i ]; then
> -            if ! grep -wq $t available_tracers ; then
> +        elif [ "$t" != "$i" ]; then
> +            if ! grep -wq "$t" available_tracers ; then
>                  echo "Required tracer $t is not configured."
>                  exit_unsupported
>              fi
> @@ -162,11 +162,11 @@ check_requires() { # Check required files and tracers
>  	    else
>  		test=$TRACING_DIR
>  	    fi
> -            if ! grep -Fq "$r" $test/README ; then
> +            if ! grep -Fq "$r" "$test"/README ; then
>                  echo "Required feature pattern \"$r\" is not in README."
>                  exit_unsupported
>              fi
> -        elif [ ! -e $i ]; then
> +        elif [ ! -e "$i" ]; then
>              echo "Required feature interface $i doesn't exist."
>              exit_unsupported
>          fi
> @@ -223,4 +223,4 @@ get_mnt_options() {
>  	local opts=$(mount | grep -m1 "$mnt_point" | sed -e 's/.*(\(.*\)).*/\1/')
>  
>  	echo "$opts"
> -}
> \ No newline at end of file
> +}

