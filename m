Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB6529C330
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763952; cv=none; b=jomnDWSrqaO/m18tznT9Y5DMZTgWlBDMqi86GlnnrGiB9eeohJltviUHxmAVMqZTG53viInCdR5HxlvvK834BwCBx34gebye6VvQc5t6Y0LdpoasJlG89GQA8jCQN7aGW+B4R2gi4bSrOuT4DgLrBAhtvCiJDW7IOv7oW7QBEFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763952; c=relaxed/simple;
	bh=KT9DlPksG9UQbZOWad5YYts7A1CKA2x522V7AUSSVLI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGhQzPUyf+hcVfVWjLu6Be4UnjY6CzsJOuecrhAhU4+PPjzewbKYE9zwyLttCXCFWfC7WPTJvE5VMPJmDSBaLjQpLIewBUkNJmuT0dpBwJRLes6UzkM0xDS2gigIUhhd4nnWA1/f4oN5vGccaxi/cwm+Wrk5W7Xrc2gkHHqpk1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 0B8731294B5;
	Thu, 17 Jul 2025 14:52:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 6920620010;
	Thu, 17 Jul 2025 14:52:27 +0000 (UTC)
Date: Thu, 17 Jul 2025 10:52:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Fusheng =?UTF-8?B?SHVhbmc=?=(=?UTF-8?B?6buE5a+M55Sf?=)"
 <Fusheng.Huang@luxshare-ict.com>
Cc: "mhiramat@kernel.org" <mhiramat@kernel.org>, "GuoJin Dai(
 =?UTF-8?B?5oi05Zu96YeR?=)" <GuoJin.Dai@luxshare-ict.com>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: =?UTF-8?B?44CQZnRyYWNlX2V2ZW50cyBsaXN044CRcmFjZQ==?= between
 trace_event_eval_update and __register_event discuss
Message-ID: <20250717105226.1ab19b95@batman.local.home>
In-Reply-To: <20250717105007.46ccd18f@batman.local.home>
References: <3c1259275c784bbd9e2f33e1b2d846c1@luxshare-ict.com>
	<20250717105007.46ccd18f@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: otybkrxzk5n4n3t5zszapqk381mobjdg
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 6920620010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18F/ul4JTsaK2KwWeqgwFHXoE2rpl09FQg=
X-HE-Tag: 1752763947-495190
X-HE-Meta: U2FsdGVkX1/9Kh+dd2HnKQZSes3+C7x4l57wNrVS2bETER04EjIP+16+O3T5AKdqMIvdEQy8Fcxzr1JFcBaIG9lnCF547XBMcIVDDo1DiTj57CwFaHFmvyDOPeG9TP11mnh6yNSndpOCXJC/IF2VIz5nPTim6v1vXoaHuUUKlsg54wE9lCaJ0bUa9o7O5EjIajGFk9WbF/KGV66rjM4OVmj13nhHMTatoNZ1zzSCCwbWD4n6XdzxSIHSdbymxvradu/rLCW65XsNSwHPOwxtEqPpSk2Kt6KQNj5rlImolhyu/zDQMQIAnqDLsw+hFsg8l7xXDsFGHZmaLwZBY4ceMDLJhVYkcy1ELNtPs72yQzjDjPilHTa05MNGehgvl7/WQy9RxtNnV1B49vLzD+P2ow==

On Thu, 17 Jul 2025 10:50:07 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 120531268abf..f00d3901cd3b 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3675,10 +3675,12 @@ static void trace_module_add_events(struct module *mod)
>  	start = mod->trace_events;
>  	end = mod->trace_events + mod->num_trace_events;
>  
> +	down_write(&trace_event_sem);
>  	for_each_event(call, start, end) {
>  		__register_event(*call, mod);
>  		__add_event_to_tracers(*call);
>  	}
> +	up_write(&trace_event_sem);

Bah, it appears that this semaphore is taken within these callers. Let
me fix this up properly.

-- Steve


>  
>  	update_cache_events(mod);
>  }
