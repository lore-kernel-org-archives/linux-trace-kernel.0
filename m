Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B58238C0D;
	Tue, 16 Dec 2025 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902413; cv=none; b=darGbC3NyQdnjA95qlDXg5X4ChDVSdbnyuEozL252bnpx+CNgR7cFkyBuaLVRrdXo7Sz7F7i9BikttNF4jBwmKEQ9GYQs6cC6RR1vtRLdflnr49F6LYoqva8eeJt8E4vEY5QnzL7NhJHGZQyoJQQSLlohNZ1U5kwJCD7hGIwspg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902413; c=relaxed/simple;
	bh=KhLineq9EcWA6Xu7RFnM/lDJsd1xNoYtqLmMRCzX4As=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5FyN3r0UKHDZAwI13ZFGWgC+hoRtjIh8PxYP/+FVTHXw0Hdwiw2ihbuH9zomdeASVCuVpzqaWmlxZz88FbTDkvHb1QO8WQ1bxxgintnYlplKkO6Qti9grFwqYnK0V5ubTIRQO56QgqerL+T/6k0oiwNwd8CCwCUuGEzpB4I7mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 4E17B1A06A8;
	Tue, 16 Dec 2025 16:26:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 481492002A;
	Tue, 16 Dec 2025 16:26:41 +0000 (UTC)
Date: Tue, 16 Dec 2025 11:28:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, ast@kernel.org, jiang.biao@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: fix address for jmp mode in t_show
Message-ID: <20251216112814.71588752@gandalf.local.home>
In-Reply-To: <20251216034533.111090-1-dongml2@chinatelecom.cn>
References: <20251216034533.111090-1-dongml2@chinatelecom.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 481492002A
X-Stat-Signature: abntmy6o1qrz1j75cqjj4zzu74aiejfb
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/K6hK8c5WgJ4pmEt1Vr0h06nURfBNd9LM=
X-HE-Tag: 1765902401-89161
X-HE-Meta: U2FsdGVkX1/i+82m6PYHyMNAEHIMqsp1CJIqoHMJxUKcIi7SCZ/AUNu9lJnE5p4lzVLUs2yaRnCp8kRI0Ncq7RqUsmL5m/3ntXlMbUUgafZpeILJpWqqqiHh8aDbhkQespvRNCkYHsQjqEWG0lHBjNcv12aQfayajCtvOpdQEc5uJzzxOR2t7zxLNSwtEo+xB3+XvYYOiSPqvawsVbjTgZxZUkzCyHmto8Qi3JPt18ISIUnggLUWDNIu1WZE+pGdsUCjJMYRcum7+rPHZqeiHO9mItEkaCESoNi8JjiO54rRgtTo3XSLXav45veV7H3AWFkIudKxsi61pGmJLfpign+E/s/GF5jA

On Tue, 16 Dec 2025 11:45:33 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index bbb37c0f8c6c..d4c41fb76a25 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -4492,8 +4492,12 @@ static int t_show(struct seq_file *m, void *v)
>  			unsigned long direct;
>  
>  			direct = ftrace_find_rec_direct(rec->ip);
> -			if (direct)
> -				seq_printf(m, "\n\tdirect-->%pS", (void *)direct);
> +			if (direct) {
> +				seq_printf(m, ftrace_is_jmp(direct) ?
> +					      "\n\tdirect(jmp)-->%pS" :
> +					      "\n\tdirect-->%pS",
> +					   (void *)ftrace_jmp_get(direct));

A little cleaner way to do the above:

				seq_printf(m, "\n\tdirect%s-->%pS",
					   ftrace_is_jmp(direct) ? "(jmp)" : "",
					   (void *)ftrace_jmp_get(direct));


-- Steve

> +			}
>  		}
>  	}
