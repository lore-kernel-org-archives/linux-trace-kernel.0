Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8898345CBC;
	Wed, 27 May 2026 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846647; cv=none; b=KJruwmS6at3YS8b5WMtp+qgnBTQYV43GuYx//0Slm33V+832KA37brvmaV5N1RNWSsMlAKewSM9axhpw85sfOdBO/hZJCK710MMkj2V2j3Se3vuCTKHqIo7+LNtWxHPcdF+gEaHUzBD7uKoRmSx6JC9W6eA84tjXgM9w26eF9IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846647; c=relaxed/simple;
	bh=Y6aS9RTkQI+QCcePtlxWmiNrBckcQXB6kXvST0eCVaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dv0nbTEi4g2ZfF+JulEsCb6O00mEPMeScXF5hbWJKvof5cuoeBIQf7X9sTVlweyvtuyojwDu+xQxz7sWKvEbA1+kk9UButzo85eHgD5dFYJK89kPS926/NsorgObtktEXj63nGC+O4R/Yg6PaqPeKpXSqpsLs6ZIJmnLpgpePYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 06FA5161344;
	Wed, 27 May 2026 01:50:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id EF99A17;
	Wed, 27 May 2026 01:50:35 +0000 (UTC)
Date: Tue, 26 May 2026 21:50:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Yu Peng <pengyu@kylinos.cn>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Use kstrdup_const() for constant hist field
 type
Message-ID: <20260526215033.78fdac7f@fedora>
In-Reply-To: <20260527101015.74fc2d54860f16e4aba83cd7@kernel.org>
References: <20260526095105.1330810-1-pengyu@kylinos.cn>
	<20260527101015.74fc2d54860f16e4aba83cd7@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ngyidhohkjnyuck9r9xctu9acj9rhxra
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: EF99A17
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19ZTUcdJChkGal5VG+Fom6tsS69BO2+Wbw=
X-HE-Tag: 1779846635-984830
X-HE-Meta: U2FsdGVkX1/PGXWdqVPOXjjoF/j6LY5omiIVftUuHbNN9DNy7OmThwj5r5GXLQzwiMPkb4/D0VE/Y/g88iplT5owaoYtcVIHbEQsSYNh2vgPLM+Y5Mypd5I8z8p9Biyx94aXNC4AOJ6975/rzm1Dbq96sPJoKVG9ATZfw7zXcrIuqprLgPTmCK6xmHid4ZaVVx/MyJvO1pLugN3UMap/Cwbqp9QtenQDNIwx3PqGGWrf2gKJfzHsThBJFOt04q9a960geKfyxSXyAn0VSBZWZIR/mNMiNlXXlPHKXR3j7Pu/YuFb9c+zIL/7ymriQ9A0CA7f+iB/XFjRhzYDHcLik5hssQM1lgOX

On Wed, 27 May 2026 10:10:15 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 26 May 2026 17:51:05 +0800
> Yu Peng <pengyu@kylinos.cn> wrote:
> 
> > The HIST_FIELD_FL_CONST path duplicates the literal "u64" type with
> > kstrdup(), then releases it through kfree_const().
> > 
> > Use kstrdup_const() instead, avoiding the allocation for a .rodata string
> > while keeping the matching free helper.
> >   
> 
> Since we are using kfree_const() to free hist_field->type,
> we can just point it as same as HIST_FIELD_FL_HITCOUNT case.
> 

Agreed.

> Thanks,
> 
> > Signed-off-by: Yu Peng <pengyu@kylinos.cn>
> > ---
> >  kernel/trace/trace_events_hist.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > index eb2c2bc8bc3d..6ffe9f4720a0 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -1992,7 +1992,7 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
> >  	if (flags & HIST_FIELD_FL_CONST) {
> >  		hist_field->fn_num = HIST_FIELD_FN_CONST;
> >  		hist_field->size = sizeof(u64);
> > -		hist_field->type = kstrdup("u64", GFP_KERNEL);
> > +		hist_field->type = kstrdup_const("u64", GFP_KERNEL);

This can simply be made to point to "u64".

Thanks,

-- Steve

> >  		if (!hist_field->type)
> >  			goto free;
> >  		goto out;
> > -- 
> > 2.43.0  
> 
> 

