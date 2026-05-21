Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E99572617;
	Thu, 21 May 2026 22:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779401745; cv=none; b=e9A18sNjixwtgGtrnCBBqI2qyksBHY0AcplU99nA1HX8vnzhaH1KK3Ovi3K84jktjI5W3QnnRg/cYf13G34mLnmrLgfK33r0DFHtK6jwxIdQPG6OGWgKTvBI84i8kshXmTfU7pavUgeSm+uVhHHpWuV5ocZ0akp/TTpcLCrff9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779401745; c=relaxed/simple;
	bh=r+JM2JK0FTeKC4aPFkIY1mrn8iGIos5ZGDOx4RKhtMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSeOB/UIboe8bHh9BoG1vnEn3VC/CWL9sCbjy5lU6rr7CCU5kpBZSO6b55RlCwgudQN15+tSUMx6ndCe5dClxEGBzV4gI8aWJ8l3sOPnfAHuu6PnBAu1RFEyo64+7YyOBsv1kjOo+TgCmSZUAHgb8AYRqw+qQKIetX4yTEoppTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id EFB65A079D;
	Thu, 21 May 2026 22:15:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id EFF3017;
	Thu, 21 May 2026 22:15:39 +0000 (UTC)
Date: Thu, 21 May 2026 18:16:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 skhan@linuxfoundation.org
Subject: Re: [PATCH] tracing: Replace BUG_ON with lockdep_assert_held in
 uprobe_buffer functions
Message-ID: <20260521181601.77ce38e6@gandalf.local.home>
In-Reply-To: <20260521192846.8306-1-yashsuthar983@gmail.com>
References: <20260521192846.8306-1-yashsuthar983@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: incue951kjf67kgeaehrbeeyoze94b5k
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: EFF3017
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19QDmoh69w+l97Kn5RB4iPvatNEVscSp28=
X-HE-Tag: 1779401739-910093
X-HE-Meta: U2FsdGVkX1/RWz8UuETVDZ4mEba3czftjYMZ3lzrD9n0ZvQa2mPFwZcCIMY1upaCzwJ8eKF6gXOy2VsK8Y4gsN6mXhGk+8jEe4HLSVJ0bLf2sQFgO+6iXXPKUvLhnXfxuhbTQVL4VSng/TZtZseH7dULpvuTODnKrN3Gn3LbagxmwM+gC78LMAyhmyImOVmwUtmRgP6qVNuZwzLJwSaZiARH2a9WR/eMS73puf7sl10bIBu2rpQUa1AEicXtGoWOLXjC44Bj6ZBwl7mCoJEmHZi310BK7ZJavXVANFoAfCgjek7BXEg/FINFbQap0FLTsqXNB4An3TrrJ7khLqBRyiGHwcPUCgpjnszbqO1nkHM1FgTGbJQhPznZ1HtIzZzgzn15Xvc4jUb+ylKAGcLVIQ==

On Fri, 22 May 2026 00:58:46 +0530
Yash Suthar <yashsuthar983@gmail.com> wrote:

> Replace BUG_ON(!mutex_is_locked(&event_mutex)) with
> lockdep_assert_held(&event_mutex) in uprobe_buffer_enable() and
> uprobe_buffer_disable().
> 
> BUG_ON() will crash the kernel. mutex_is_locked() only checks
> if any task holds lock,but not the caller task. lockdep_assert_held()
> also check current task for lock and no crash on true condition.
> 
> Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>

This looks good to me.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

Masami, do you want to take this?

-- Steve

> ---
>  kernel/trace/trace_uprobe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 2cabf8a23ec5..aee0960d0cf7 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -912,7 +912,7 @@ static int uprobe_buffer_enable(void)
>  {
>  	int ret = 0;
>  
> -	BUG_ON(!mutex_is_locked(&event_mutex));
> +	lockdep_assert_held(&event_mutex);
>  
>  	if (uprobe_buffer_refcnt++ == 0) {
>  		ret = uprobe_buffer_init();
> @@ -927,7 +927,7 @@ static void uprobe_buffer_disable(void)
>  {
>  	int cpu;
>  
> -	BUG_ON(!mutex_is_locked(&event_mutex));
> +	lockdep_assert_held(&event_mutex);
>  
>  	if (--uprobe_buffer_refcnt == 0) {
>  		for_each_possible_cpu(cpu)

