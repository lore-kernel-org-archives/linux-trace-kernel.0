Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5156E81749;
	Fri, 23 May 2025 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748022845; cv=none; b=ETE50DYYfaiMKyDTTgoiatlDagoqHRQQSGs8zQ4rm9bGt5+0iIA3Q2sYEbc0sBHFySJ+hbrd7VsRHSmmPYV23UiPX0NYEqrsoDA3ZmAn4k9aTldj1I0s/4LDy3Fk6JY2BBnYC5+Ssa6qGNCGfVKJA3QMecbGkWS518J5lJAQ4n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748022845; c=relaxed/simple;
	bh=db42/PxwgTCfK0dtD0B0pORObzB+Jtsp7PplyAvnh44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGyQ0DuvKfLUb4ccYloS4yLjj+5j5QMT0kax+rYeEuF9uvh0NEacLux5P9QS45kdu9CONgsr7Y+es9i3qxF/8osaO//jHi3/zyuDIk92cgH8X5itYrY3rXW6z/A5KArNcr6ewwSQtsVyJsD9SoJVrYdvtzw3AuT/yqdeGnBLDv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFCEC4CEE9;
	Fri, 23 May 2025 17:54:03 +0000 (UTC)
Date: Fri, 23 May 2025 13:54:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ye Bin <yebin@huaweicloud.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 mark.rutland@arm.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yebin10@huawei.com
Subject: Re: [PATCH 1/2] ftrace: fix UAF when lookup kallsym after ftrace
 disabled
Message-ID: <20250523135452.626d8dcd@gandalf.local.home>
In-Reply-To: <20250523083945.3390587-2-yebin@huaweicloud.com>
References: <20250523083945.3390587-1-yebin@huaweicloud.com>
	<20250523083945.3390587-2-yebin@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 16:39:44 +0800
Ye Bin <yebin@huaweicloud.com> wrote:

> Above issue may happens as follow:
> (1) Add kprobe trace point;
> (2) insmod test.ko;
> (3) Trigger ftrace disabled;

This is the bug. How was ftrace_disabled triggered? That should never
happen. Was test.ko buggy?

> (4) rmmod test.ko;
> (5) cat /proc/kallsyms; --> Will trigger UAF as test.ko already removed;
> ftrace_mod_get_kallsym()
> ...
> strscpy(module_name, mod_map->mod->name, MODULE_NAME_LEN);
> ...
> 
> As ftrace_release_mod() judge 'ftrace_disabled' is true will return, and
> 'mod_map' will remaining in ftrace_mod_maps. 'mod_map' has no chance to
> release. Therefore, this also causes residual resources to accumulate.
> To solve above issue, unconditionally clean up'mod_map'.
> 
> Fixes: aba4b5c22cba ("ftrace: Save module init functions kallsyms symbols for tracing")

This is *not* a fix. ftrace_disabled gets set when a bug is triggered. If
this prevents ftrace_disabled from getting set, then it would be a fix. But
if something else happens when ftrace_disabled is set, it just fixes a
symptom and not the bug itself.


> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  kernel/trace/ftrace.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index a3d4dfad0cbc..ff5d9d73a4a7 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -7438,9 +7438,6 @@ void ftrace_release_mod(struct module *mod)
>  
>  	mutex_lock(&ftrace_lock);
>  
> -	if (ftrace_disabled)
> -		goto out_unlock;
> -

Here you delete the check, and the next patch you have:

+	if (ftrace_disabled || (mod && !mod->num_ftrace_callsites)) {
+		mutex_unlock(&ftrace_lock);
+		return;
+	}
+

Why the two patches where the second patch just adds back the check and
then adds some more stuff around it. This should be a single patch.

Also, why not just keep the goto unlock, that has:

 out_unlock:
	mutex_unlock(&ftrace_lock);

	/* Need to synchronize with ftrace_location_range() */
	if (tmp_page)
		synchronize_rcu();
	for (pg = tmp_page; pg; pg = tmp_page) {

		/* Needs to be called outside of ftrace_lock */
		clear_mod_from_hashes(pg);

		if (pg->records) {
			free_pages((unsigned long)pg->records, pg->order);
			ftrace_number_of_pages -= 1 << pg->order;
		}
		tmp_page = pg->next;
		kfree(pg);
		ftrace_number_of_groups--;
	}
}

And tmp_page is set to NULL before that jump, so the if and for loop will
both be nops.

Why all this extra churn?

-- Steve


>  	list_for_each_entry_safe(mod_map, n, &ftrace_mod_maps, list) {
>  		if (mod_map->mod == mod) {
>  			list_del_rcu(&mod_map->list);

