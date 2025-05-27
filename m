Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260A8274FE9;
	Tue, 27 May 2025 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353236; cv=none; b=d41fq9xz4WF97CJRKL79OSyMKe7U5sbmdoLf2K0LzeEuKdCWryEnOn4/GRLNlypI33kob3D8QgGbKjD7oYEE0GF1DX6z4mkNt6pzutIrojPJN5Kyu7FI4NyqsS4f5Ev76+WeGf1mQ1fWAeSWLZTaOdMT9yt7I1TzNMHJBtAkKyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353236; c=relaxed/simple;
	bh=jwje34nB6gKyQoKpfDGgc2ECy7vWfnVq2EpNyYhTPuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDnhHKMAvlWhMPBevZgu1kmYNnQ4Vo0j7MxoNmwcjytm1DbQsqLa6DApKMhUOlk2FouhBsXTTy46IhEKMIqjtgWa00aMaw8XHVqzrXbEL9SfC2IWK+Me09897B9a6oPWFPX11t7L5LVrpu7ALwhbIhk4H/FbFfigk+8CVqm63TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF84DC4CEE9;
	Tue, 27 May 2025 13:40:33 +0000 (UTC)
Date: Tue, 27 May 2025 09:41:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: yebin <yebin@huaweicloud.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 mark.rutland@arm.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yebin10@huawei.com
Subject: Re: [PATCH 1/2] ftrace: fix UAF when lookup kallsym after ftrace
 disabled
Message-ID: <20250527094131.1f4a92ab@gandalf.local.home>
In-Reply-To: <6833C4F1.3030300@huaweicloud.com>
References: <20250523083945.3390587-1-yebin@huaweicloud.com>
	<20250523083945.3390587-2-yebin@huaweicloud.com>
	<20250523135452.626d8dcd@gandalf.local.home>
	<6833C4F1.3030300@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 May 2025 09:33:37 +0800
yebin <yebin@huaweicloud.com> wrote:

> On 2025/5/24 1:54, Steven Rostedt wrote:
> > On Fri, 23 May 2025 16:39:44 +0800
> > Ye Bin <yebin@huaweicloud.com> wrote:
> >  
> >> Above issue may happens as follow:
> >> (1) Add kprobe trace point;
> >> (2) insmod test.ko;
> >> (3) Trigger ftrace disabled;  
> >
> > This is the bug. How was ftrace_disabled triggered? That should never
> > happen. Was test.ko buggy?
> >  
> Yes. The following warning is reported during concurrent registration 
> between register_kprobe() and live patch, causing ftrace_disabled.
> 
> WARNING: CPU: 56 PID: 2769 at kernel/trace/ftrace.c:2612 
> ftrace_modify_all_code+0x116/0x140

OK, so it is a buggy module.

> >> (4) rmmod test.ko;
> >> (5) cat /proc/kallsyms; --> Will trigger UAF as test.ko already removed;
> >> ftrace_mod_get_kallsym()
> >> ...
> >> strscpy(module_name, mod_map->mod->name, MODULE_NAME_LEN);
> >> ...
> >>
> >> As ftrace_release_mod() judge 'ftrace_disabled' is true will return, and
> >> 'mod_map' will remaining in ftrace_mod_maps. 'mod_map' has no chance to
> >> release. Therefore, this also causes residual resources to accumulate.
> >> To solve above issue, unconditionally clean up'mod_map'.
> >>
> >> Fixes: aba4b5c22cba ("ftrace: Save module init functions kallsyms symbols for tracing")  
> >
> > This is *not* a fix. ftrace_disabled gets set when a bug is triggered. If
> > this prevents ftrace_disabled from getting set, then it would be a fix. But
> > if something else happens when ftrace_disabled is set, it just fixes a
> > symptom and not the bug itself.
> >  
> There are multiple causes for triggering ftrace_disabled. I agree that 

Yes, just like there's multiple causes for BUG_ON() ;-)

The ftrace_disable is used to help keep the system from being totally
corrupted. When it triggers, the best thing to do is a reboot.

> aba4b5c22cba is not faulty. However, the incorporation of this patch 
> will cause problems due to triggering ftrace_disabled. The generation of 
> ftrace_disabled is beyond our control. This is related to the user. What 
> we can do is even if there are no additional derivative problems.

Well, when a user inserts a module, then they become a kernel developer too ;-)

> >  
> >> Signed-off-by: Ye Bin <yebin10@huawei.com>
> >> ---
> >>   kernel/trace/ftrace.c | 3 ---
> >>   1 file changed, 3 deletions(-)
> >>
> >> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> >> index a3d4dfad0cbc..ff5d9d73a4a7 100644
> >> --- a/kernel/trace/ftrace.c
> >> +++ b/kernel/trace/ftrace.c
> >> @@ -7438,9 +7438,6 @@ void ftrace_release_mod(struct module *mod)
> >>
> >>   	mutex_lock(&ftrace_lock);
> >>
> >> -	if (ftrace_disabled)
> >> -		goto out_unlock;
> >> -  
> >
> > Here you delete the check, and the next patch you have:
> >
> > +	if (ftrace_disabled || (mod && !mod->num_ftrace_callsites)) {
> > +		mutex_unlock(&ftrace_lock);
> > +		return;
> > +	}
> > +
> >  
> The second patch I added judgment when initializing 'mod_map' in 
> ftrace_free_mem(). The first patch removes the judgment when 
> ftrace_release_mod() releases'mod_map'. The logic modified by the two 
> patches is isolated.

Actually I think both patches are buggy.

When ftrace_disabled is set, we don't know the state of the code and we do
not want to do *any* more text modification. That's what ftrace_disable
means. Something went wrong with text modification and any more changes can
cause a bigger problem.

We don't add "exceptions".

If you are worried about unloading modules when ftrace_disable is set, what
is a much safer solution is to up the module count of all modules that have
any ftrace callsites active, and prevent those modules from being removed.

Again, the only solution to a ftrace_disable being set is a full reboot.

-- Steve
