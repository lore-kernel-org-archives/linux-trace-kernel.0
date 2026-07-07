Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F6B225791;
	Tue,  7 Jul 2026 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446864; cv=none; b=n506RC78jtxe8Zw+rpN8auUZX6thuliy0ueo7XdtkrrsbPhaWnGJGA8pOmN9+Kvf/c46EUN9/yzm8/Yq9CTogg7AlTG6hlCX6xy9Ojir9kzFHtcmvBN4iNs3j7/e1bgFl4XSSXqoa68nleuUUcvkCiF9e4kkFxRivh9R8JoG8QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446864; c=relaxed/simple;
	bh=Sd8OesTG4kgdZzsBXYAsfQO7aZdAADxr0eFKRhHxp4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDLqv1Hok/jaU9WmmPmn9TJ5Un4h0inXfv7QuNFvyxk8kd+dMI86dl64owBrV/lbM4T4jEnwKJDrU/kAG/3+bA7wgrNO8tkgE2VB1ULUrzIO1seBTfGg/e8WdMMzFT1Duh0scTn9HQ9//XlXhqxLN8/V/kaiFNHTvnBTcZ97Ow8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id ED61E1A04D7;
	Tue,  7 Jul 2026 17:54:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 3F4B920025;
	Tue,  7 Jul 2026 17:54:20 +0000 (UTC)
Date: Tue, 7 Jul 2026 13:54:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yu Peng <pengyu@kylinos.cn>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/synthetic: Free type string on error path
Message-ID: <20260707135423.0180646e@gandalf.local.home>
In-Reply-To: <20260707132417.2193412-1-pengyu@kylinos.cn>
References: <20260707132417.2193412-1-pengyu@kylinos.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3F4B920025
X-Stat-Signature: dmwkphf19bgsszabky8bdqagx3zsb4c1
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18fDgWQBvwwc+8b2ZQcwBRfUGoImCX97iQ=
X-HE-Tag: 1783446860-84711
X-HE-Meta: U2FsdGVkX19Zxp/T5AXu86pBbtpAncMskjzfXd0x9huK4D2t79bfUYsCM0HUUFfkDwMhiS/jnW1De9syGnRxYFihnvjhSwb4Cs4HRqHBcjYVYTTQi2nrZf7aD89y/WbrhVx5T3/vNzkv3cayG10mtkeVGwgV9Fp4cvMKEPtKWAP0c4ueg8OKBbCjiX2DMZnJI6hEzQ4USEGtD27Pc1WH0TndsTT55xt1iZ4WqjKKikd4wQkNF/X+SUul2r6IiHyXtUdUmq6M9bnHeO9Lq3tqI79zsE+YnyK0v7XMvHyQwS/y2bfDzkOlMiJbEzKbnSbvExI5QBJN96HAjqh9O9vdBOXh7mKLTkGrig4mLEnX98LkyUG3KGIyFpIFs/Bu/QyXYjW98uReQCuAGTWjywmzYLT/ymnTkqxHaJfHtq5OWO7h2F4xHmyuT36QAosdh8uO

On Tue,  7 Jul 2026 21:24:17 +0800
Yu Peng <pengyu@kylinos.cn> wrote:

> parse_synth_field() builds a "__data_loc ..." type string before
> assigning it to field->type. If the seq_buf check fails, the temporary
> string is not owned by field and is leaked. Free it before leaving.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Yu Peng <pengyu@kylinos.cn>
> ---
> Changes in v2:
> - Use __free(kfree) and no_free_ptr() as suggested by Steven.
> 
>  kernel/trace/trace_events_synth.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index e6871230bde96..ad2e70258291b 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -828,7 +828,7 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
>  	} else if (size == 0) {
>  		if (synth_field_is_string(field->type) ||
>  		    synth_field_is_stack(field->type)) {
> -			char *type;
> +			char *type __free(kfree) = NULL;

Ah, we can't do this here.

(Sashiko pointed this out: https://sashiko.dev/#/patchset/20260707132417.2193412-1-pengyu%40kylinos.cn )

>  
>  			len = sizeof("__data_loc ") + strlen(field->type) + 1;
>  			type = kzalloc(len, GFP_KERNEL);

Because after this code we have:

			type = kzalloc(len, GFP_KERNEL);
			if (!type)
				goto free;

Which jumps out of the if block, and that will break the cleanup.

I'll take you original version for now.

-- Steve


> @@ -844,7 +844,7 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
>  			s.buffer[s.len] = '\0';
>  
>  			kfree(field->type);
> -			field->type = type;
> +			field->type = no_free_ptr(type);
>  
>  			field->is_dynamic = true;
>  			size = sizeof(u64);

