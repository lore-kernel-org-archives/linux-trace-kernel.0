Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC7C2BD5BB;
	Mon, 12 Jan 2026 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232594; cv=none; b=RWnfNXMEU2hx5zBdFUyEoJk0uT76U1SXW9yNyIyVXz415pZwrVt3MnGFEWqYYFESOij70jHj3ti4+4X/EuWFnu0Q07aShcKdrDTXtJP1ce6O86Bog9F8mNAj9fll8iD1AcMDzLm5HmzOdDFO0r9v6s+CIm/srnOc2/+uHyrd3Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232594; c=relaxed/simple;
	bh=zc0Wt28XmAyG258QU5LNywvxiHWlyYYomnAQewieYWg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dz0P/4IGP4yCB7AT5ALg2IDdFIOa9inguhwjow14ZxQwU2oewgydwXzvoByMUGXsmNi1evVNnfcYsIwjQL4zajQ6egIYzHF1UVyxVet0HiS/IH5qZ3AAePF0Vyvxu2PkLnbsH8rX8Vxg3AAsDEoefvTy+WBP451XnbCHG29Nz3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 63973140518;
	Mon, 12 Jan 2026 15:43:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 18A5630;
	Mon, 12 Jan 2026 15:43:00 +0000 (UTC)
Date: Mon, 12 Jan 2026 10:43:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: tglx@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, aliceryhl@google.com, yury.norov@gmail.com,
 vmalik@redhat.com, kees@kernel.org, dave.hansen@linux.intel.com,
 luto@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 mhiramat@kernel.org, brauner@kernel.org, jack@suse.cz, cyphar@cyphar.com,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-trace-kernel@vger.kernel.org, wangfushuai@baidu.com
Subject: Re: [PATCH v2 3/6] tracing: Use copy_from_user_nul() instead of
 copy_from_user()
Message-ID: <20260112104302.76462c73@gandalf.local.home>
In-Reply-To: <20260112073039.1185-4-fushuai.wang@linux.dev>
References: <20260112073039.1185-1-fushuai.wang@linux.dev>
	<20260112073039.1185-4-fushuai.wang@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 18A5630
X-Stat-Signature: znkn9ceiqct94ajt4g5nhoqp7bufefdh
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+PbTRD0q5RQVfExPtU7QrgGg+/6cgjoMw=
X-HE-Tag: 1768232580-582637
X-HE-Meta: U2FsdGVkX1/qCfodGH5OJif+Ga2mSvax0+7rfi50kfGk0/9WyQ1u6/UrH6IizIOZwEFbEGTeooKwwpw2X7uhO9W54/mw/jxsKSbY7o+rmhwoRJswTjE9Sz9DI2qiLbqMpovXhlVYJ3yGfbMDPb4dsXIXcsv0Wom1q53A4AdtUbnwErib+R8pT/stNLx5O+l1HaOMJ1Sux0NvDpXvWsen0gfixst5+CDoOc8VcKel0vw5LsMpB+sFDO0ieitEot9T2C3N5mHq9JqlOwZ8hohiISV07lI5H1VtSl0+1yVmqJCfceLsEJ3I+T9KsZ4sr4nfS74xZB9IWlFbU89VQn9r7m9d79rvl/3jDH4QlAsPVFVsfZ/6qOkb9Egz+JLO4I+ia+xdJ9RpTuJbzgZFrQA13g==

On Mon, 12 Jan 2026 15:30:36 +0800
Fushuai Wang <fushuai.wang@linux.dev> wrote:

> From: Fushuai Wang <wangfushuai@baidu.com>
> 
> Use copy_from_user_nul() instead of copy_from_user() to simplify
> the code.
> 
> No functional change.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  kernel/trace/trace.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index baec63134ab6..b6ffd006fcf9 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -11266,10 +11266,9 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
>  		if (size >= WRITE_BUFSIZE)
>  			size = WRITE_BUFSIZE - 1;
>  
> -		if (copy_from_user(kbuf, buffer + done, size))
> +		if (copy_from_user_nul(kbuf, buffer + done, size))
>  			return -EFAULT;
>  
> -		kbuf[size] = '\0';
>  		buf = kbuf;
>  		do {
>  			tmp = strchr(buf, '\n');

