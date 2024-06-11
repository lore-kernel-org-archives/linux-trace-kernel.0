Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0021C17C7DA;
	Tue, 11 Jun 2024 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718115840; cv=none; b=EJBh0gT65Td58urjlmATXJflOvqrthii5SPRnKo2ISVNS4pJFqMid5s1Qchhp6KbLtcoEtqmxIPudXq12gBbXNlu2W+tB7S+cQ7nwyomH7ScA0JzdTN/oeh++bJavRkfBt87WBL7NCXL82rEUwtPwpWKsISt2draD1B0+cKjrhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718115840; c=relaxed/simple;
	bh=zQSUZDf9BA6axvEmuxkge4ZvqblG70QClCm0SBwZzhc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGbG0sz6246ye1zQS+Zdcy3xzphLaI163tPhkE1NxHD7F0jxBDJk44/X2Rfa77rJ+g+3Ww93mPzUHZMVlEGTYzeEHqHU6ImRzryaoS4Fs+SVS14LBoA3DNONlZXTu77twd5yy00J8i/d2HaTBYgDCUEVgHHxRrrM0D41itaD3MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3763C2BD10;
	Tue, 11 Jun 2024 14:23:58 +0000 (UTC)
Date: Tue, 11 Jun 2024 10:24:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v3 2/3] tracing/kprobe: Integrate test warnings into
 WARN_ONCE
Message-ID: <20240611102414.203b95bd@gandalf.local.home>
In-Reply-To: <171811264685.85078.8068819097047430463.stgit@devnote2>
References: <171811262833.85078.12421348187962271050.stgit@devnote2>
	<171811264685.85078.8068819097047430463.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 22:30:46 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Cleanup the redundant WARN_ON_ONCE(cond) + pr_warn(msg) into
> WARN_ONCE(cond, msg). Also add some WARN_ONCE() for hitcount check.
> These WARN_ONCE() errors makes it easy to handle errors from ktest.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v3:
>   - integrate WARN_ON_ONCE() and pr_warn() instead of remove
>     WARN_ONCE().

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
