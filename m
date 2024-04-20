Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E59439B
	for <linux-trace-kernel@vger.kernel.org>; Sat, 20 Apr 2024 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713577260; cv=none; b=ByhJvbeevLoMGOkJW67nMEgKca+0vvgOKr2bkOZSRI+AglKZp1MURL0mHt456vLicyWwCkYEoT5Woh57HMY+iDIUrr/YwihevBH8O8+PryJYCH2upO6PnigGSxzsvYF2TXc2jKjOltY23oaNWqj3OJWosfYZR4sE2pYMhq3mJP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713577260; c=relaxed/simple;
	bh=DsGeZs4RjAQkK+rxQXK9DtMDsEc3sAc28gxsRD41EuE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/xReI6blANniqvcWF9NUHCoAGLbaEe6mQ8rTzoAS60W+BkjzqZ0VsdLPcsD4VmyZ8Gg5hmj/GojqBHZSpui5ZrQifq4zOVNb1RKW+7RueDh38WV7n3fh66a4/r/TBmg07lMp0wIEZm5scelpJDrUDFweZ4u61y1r0i0pu6RNdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05D4C072AA;
	Sat, 20 Apr 2024 01:40:58 +0000 (UTC)
Date: Fri, 19 Apr 2024 21:40:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Bang Li" <libang.li@antgroup.com>
Cc: mhiramat@kernel.org, <mark.rutland@arm.com>,
 <mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>,
 <libang.linux@gmail.com>
Subject: Re: [PATCH] ftrace: Replace ftrace_disabled variable with
 ftrace_is_dead function
Message-ID: <20240419214054.688d624e@rorschach.local.home>
In-Reply-To: <20240419143844.97847-1-libang.li@antgroup.com>
References: <20240419143844.97847-1-libang.li@antgroup.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 22:38:44 +0800
"Bang Li" <libang.li@antgroup.com> wrote:

> Use the existing function ftrace_is_dead to replace the variable to make
> the code clearer.
> 
> Signed-off-by: Bang Li <libang.li@antgroup.com>
> ---
>  kernel/trace/ftrace.c | 46 +++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 50ca4d4f8840..4a08c79db677 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2693,7 +2693,7 @@ void __weak ftrace_replace_code(int mod_flags)
>  	int schedulable = mod_flags & FTRACE_MODIFY_MAY_SLEEP_FL;
>  	int failed;
>  
> -	if (unlikely(ftrace_disabled))
> +	if (unlikely(ftrace_is_dead()))
>  		return;
>  

NACK!

ftrace_is_dead() is only there to make the static variable
"ftrace_disabled" available for code outside of ftrace.c. In ftrace.c,
it is perfectly fine to use ftrace_disabled.

-- Steve
