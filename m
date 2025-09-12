Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7783D168BD;
	Fri, 12 Sep 2025 01:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757638989; cv=none; b=Oqut2t7Gib3+K8KMruo1a1kiQIlDXHhY0HdZJ1Dw9cv+3j4DdqFZT6KbSxgZAhkcFkhoXSjkr5PF+K556DEwNZQs+ZCtPnhUOc1cs6dtbXeew5e5qplTQOun9dPJijmNv1G9HUUBlT3K2JffjkZ4547fpu2yKXahlB55uH2eb6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757638989; c=relaxed/simple;
	bh=+lPOJeKM6MhjUIBHcpWIAx0Maec10BV4sZliTOp87ss=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=psvaG8haM999fByQ/5N6fzwuoMSQvMVOsLF5Vqjt0jcGb88dciUQ4ndDosEmcm6fdvbAM8Z4qj8l7RtN2QK/O6j8SyOYTiLuJh7UEyCx9cGnBtpAhRCaElpcowwpuzxKRvNiNOjoEK/htVQ7H9ftn+E6i/ooUuY/vdGB9bRUxQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQ3AmHgr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQ3AmHgr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B80C4CEF0;
	Fri, 12 Sep 2025 01:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757638989;
	bh=+lPOJeKM6MhjUIBHcpWIAx0Maec10BV4sZliTOp87ss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AQ3AmHgr3bvw1Pv5R4gae0S4x7mCuiG77XhIi+sp8Z5zRcns7wuU+JrKs1tlX1Z5W
	 XqqQ9+/1YOWt3VNeKXJaluEZ+WPgc5GwCjEqLJgYHaBhLjhhAFBrcFvSmubBelqRIm
	 S776ZLhzgtkbF9Os4VWmZ8CIZ8o7zvrzV9rSZ8YjZWMOWRkEb1aexVkEuOpSpobO6+
	 hIiQmfILqVubnqO9zKec1kjEnZru+OWok9AtfNSf5nG6HXxhzNiZQx1XeJCMHB1ExN
	 lGdSTtLIPf4B9Vt2XoQu1iIbH6KfcmbS/LNSRJ/B3Bnx5+ZRMwc8IvMw58JryCfBBU
	 4wSGarFH8MnCg==
Date: Fri, 12 Sep 2025 10:03:04 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Documentation <linux-doc@vger.kernel.org>, Linux Kernel Tracing
 <linux-trace-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, Tom
 Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 3/5] Documentation: trace: historgram-design: Separate
 sched_waking histogram section heading and the following diagram
Message-Id: <20250912100304.c02dbe51e7cfd690ac537d83@kernel.org>
In-Reply-To: <20250911042527.22573-4-bagasdotme@gmail.com>
References: <20250911042527.22573-1-bagasdotme@gmail.com>
	<20250911042527.22573-4-bagasdotme@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 11:25:25 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> Section heading for sched_waking histogram is shown as normal paragraph
> instead due to codeblock marker for the following diagram being in the
> same line as the section underline. Separate them.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Fixes: daceabf1b494 ("tracing/doc: Fix ascii-art in histogram-design.rst")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/trace/histogram-design.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
> index 231a12bd7d461c..4faff1669b77bd 100644
> --- a/Documentation/trace/histogram-design.rst
> +++ b/Documentation/trace/histogram-design.rst
> @@ -380,7 +380,9 @@ entry, ts0, corresponding to the ts0 variable in the sched_waking
>  trigger above.
>  
>  sched_waking histogram
> -----------------------::
> +----------------------
> +
> +.. code-block::
>  
>    +------------------+
>    | hist_data        |<-------------------------------------------------------+
> -- 
> An old man doll... just what I always wanted! - Clara
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
