Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47FE168BD;
	Fri, 12 Sep 2025 01:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757639024; cv=none; b=kYJxhvFM6DawQqlrkCxnpBMB5yebhM3gcMZXMzrQyy4cEHYDc5Z6KnjExdOql6d5/K3Bb8+Zm5iCFqUk9yYj5okVsgrpbd5Lgv4MSd13xcvIkjJ0zklBIs+u0S+EcqzWReRNUHt2MFD4x0QE4G8IIcAGMUc09yj4fwxt3UoxvpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757639024; c=relaxed/simple;
	bh=UupyoFE7SnAlsffL4fmvxHr7u5yI/7mpAQ9gZ/SiWEo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KL1GXl0fqakfE7f0WyysG/iXTiFlie7eqRJrEOwZqkmBjYSjxgaSFRAjQaSPDaDraZMgvx0LOXtXKxjdJBSl69QyaUVAnOdxq6CIGJn7pBiaAt1NWO2QJFelautj0H1dYDceEQ6rvvjpeapCMRt4X7zrRHJiD0IaLS7duU+8VCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htZH4rWZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htZH4rWZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB87C4CEF0;
	Fri, 12 Sep 2025 01:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757639024;
	bh=UupyoFE7SnAlsffL4fmvxHr7u5yI/7mpAQ9gZ/SiWEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=htZH4rWZF0hXTnA2KtZ0qwz8xfhw/zUMoL7xbSJLovLmAZm+ScgSRZUNXi/AbEbOW
	 0nA6QmCTuc4q+lPuxrzV25Ym1FlBnc5Wt0ikuidiLSu7mPC4J9JgLzgD8eBU2JG6u/
	 e46CjUiQZBl0EdlWn4HphIDg5t1vRWoyFqON9ZYhnzBfxURT/wRv3DkUjHOR9+FwED
	 yiHSKAhI4xOcbDSOYANFAoGRhmUdjudoBpeRICFg0AtB1q+TFZF3QmIsFjNTdNN8vI
	 mw7SewA037OQHw5BhEASdJraBdgnKjgoTFEWu91dtSW8PXeNXsY3G6vJ6btV9jqB9W
	 nlu4ydPbGmLtQ==
Date: Fri, 12 Sep 2025 10:03:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Documentation <linux-doc@vger.kernel.org>, Linux Kernel Tracing
 <linux-trace-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, Tom
 Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 4/5] Documentation: trace: histogram-design: Wrap
 introductory note in note:: directive
Message-Id: <20250912100339.d9456de2783cdc67b01cfec7@kernel.org>
In-Reply-To: <20250911042527.22573-5-bagasdotme@gmail.com>
References: <20250911042527.22573-1-bagasdotme@gmail.com>
	<20250911042527.22573-5-bagasdotme@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 11:25:26 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> Use Sphinx note:: directive for the introductory note at the beginning
> of docs, instead of aligned-text paragraph that renders as definition
> list.
> 

Looks good change ;)

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/trace/histogram-design.rst | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
> index 4faff1669b77bd..ae71b5bf97c6c7 100644
> --- a/Documentation/trace/histogram-design.rst
> +++ b/Documentation/trace/histogram-design.rst
> @@ -11,13 +11,14 @@ histograms work and how the individual pieces map to the data
>  structures used to implement them in trace_events_hist.c and
>  tracing_map.c.
>  
> -Note: All the ftrace histogram command examples assume the working
> -      directory is the ftrace /tracing directory. For example::
> +.. note::
> +   All the ftrace histogram command examples assume the working
> +   directory is the ftrace /tracing directory. For example::
>  
>  	# cd /sys/kernel/tracing
>  
> -Also, the histogram output displayed for those commands will be
> -generally be truncated - only enough to make the point is displayed.
> +   Also, the histogram output displayed for those commands will be
> +   generally be truncated - only enough to make the point is displayed.
>  
>  'hist_debug' trace event files
>  ==============================
> -- 
> An old man doll... just what I always wanted! - Clara
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
