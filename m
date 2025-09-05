Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0887221577;
	Fri,  5 Sep 2025 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101133; cv=none; b=N4s7SOx7xUkeyUKYENNI8xIo4+TDbgqSgYRZohyxkrdAnrB4fok+bkcRvpKtdOMvdY0a41Dr4aaX1rlCfZt6dQwlpfAyeZZ3U2xiVYrLTJ2bW1SCHKlF17W5btsrYCUSUein9Dqd0lCbXQSmu/bc/v7G4ZtQyNKOWgIzqNn1XJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101133; c=relaxed/simple;
	bh=U9oSa2Dh8yshfVoh6TuWYERaJFbgi+QGHLnYK0vULIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLDDdspxgTi6xi7BE80YHcK8tjf8PEKsKq5hLlX9OKu9E56c70LOCCUjGIYY6dLd73CkyCVbBJKbv0Ya9KAOCTzfh2OoEiTI+YRkeDZe/O2/ng502shwFduE6ErMhWLKsgaY5HmA9L/qPn+5KwGXh/+uiXfHAGEH528rWxjXfwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 7BD401A0178;
	Fri,  5 Sep 2025 19:38:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 921B719;
	Fri,  5 Sep 2025 19:38:47 +0000 (UTC)
Date: Fri, 5 Sep 2025 15:39:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pu Lehui <pulehui@huawei.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>, Pu Lehui
 <pulehui@huaweicloud.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Fix missing errno when zero parser->idx in
 trace_pid_write
Message-ID: <20250905153926.68b47107@gandalf.local.home>
In-Reply-To: <e3c22d00-1a0c-45e0-bc76-955d367ab4d1@huawei.com>
References: <20250821071721.3609109-1-pulehui@huaweicloud.com>
	<e3c22d00-1a0c-45e0-bc76-955d367ab4d1@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7xfnaj9qsfuneec441b56cyuew6m7kdj
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 921B719
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19w8e+rcyq3MTvpt6bLlPxvAV8ZPrHZbL8=
X-HE-Tag: 1757101127-572679
X-HE-Meta: U2FsdGVkX1+f9wmQtYBN5OBcUTJ1cFpo3gWqS1jDTTfrvxPeJnjUsYOc1hsCVcqHEPPxZoMultw7druGuJuROpYyqO1jLpcodvnQ/W7dOdIN/DmG6zYb18RjvpXd9TwCYJexaHGq4sYlgtZikU+WwDReAfdPVlrK23vOpl6Hb0Z0CKjWNjJqz4gfO/X9Wj5shyBHPUbsUKs1Ynupukj0VaayDYsbv5HFqm9O2kF2vl1m+lC5iXqHXNC9mvwSImU0HUb+K+TC1ERpAyeme/NIhA/q+1Ams60XruQfkt5ZxTn/wNYPV4IlXURR4CHkr8OVFchdOhT9X6NASVQJLQ+NBz8BHmRt+mnc

On Wed, 3 Sep 2025 12:15:16 +0800
Pu Lehui <pulehui@huawei.com> wrote:

> As for this fault injection syzkaller issue, shall we need to silence 
> it? How about the below fix?

I usually don't care about fault injections because it causes "faults" that
would only happen if the system was about to crash. But anyway..

> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index e6b50b416e63..c17c031e7917 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -834,7 +834,11 @@ int trace_pid_write(struct trace_pid_list 
> *filtered_pids,
>                  /* copy the current bits to the new max */
>                  ret = trace_pid_list_first(filtered_pids, &pid);
>                  while (!ret) {
> -                       trace_pid_list_set(pid_list, pid);
> +                       ret = trace_pid_list_set(pid_list, pid);
> +                       if (ret) {
> +                               trace_parser_put(&parser);
> +                               return ret;
> +                       }

make it:

			if (ret < 0)
				goto out;

>                          ret = trace_pid_list_next(filtered_pids, pid + 
> 1, &pid);
>                          nr_pids++;
>                  }

And put the out label just before the trace_parser_put().

Oh, and add one space before the "out:" label. That makes diffs of patches
show the function when changes are after the label and not the label itself.

-- Steve
