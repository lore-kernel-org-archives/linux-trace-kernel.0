Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F30A315D3D;
	Sat,  6 Sep 2025 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757125796; cv=none; b=Qfz1Jq9kPdE92TmXDbesn9Mb/heEA3QT9FW5uCCE0eNfB6FrqqjMAKWSGHTZ5EjcBDxlKFbwU/YmSKdb796HmGaYV8jxZliduLrFpLk47QUXPVLgU/AgQuBZEUgwzazWO54czmwUaijxCuoubhBhcMjkEUmct+qiLwboxLQ8x6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757125796; c=relaxed/simple;
	bh=jYkwUCzSvRhyaQCuijQtXNsDWPerXcNfYRGwM+bAOz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uRwPaJCcAx+baEztjo01BMwsrJXYYtcWQrxUA1GTCEbGebJTOzBGrytZsvT8567FNtHEM+m8Qkuh/1LnD/lTGwvtvg4tpGToWkE3NfEsEpEvD1dOGNfQHiJmfNu9fNxeagVLSLrAUmUMNbbKPPB8KSB4k5G+kKSvVI46VnXkiA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id EACCB1603D8;
	Sat,  6 Sep 2025 02:29:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 0B5CB20029;
	Sat,  6 Sep 2025 02:29:49 +0000 (UTC)
Date: Fri, 5 Sep 2025 22:30:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ye Weihua <yeweihua4@huawei.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] trace/fgraph: Fix the warning caused by missing
 unregister notifier
Message-ID: <20250905223029.4fee615b@gandalf.local.home>
In-Reply-To: <9d6ee97b-5b0a-48a7-850d-de18d3107bce@roeck-us.net>
References: <20250818073332.3890629-1-yeweihua4@huawei.com>
	<9d6ee97b-5b0a-48a7-850d-de18d3107bce@roeck-us.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: cmd8qqo46ez37zaq5pkwx9g4jejw567p
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 0B5CB20029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18WGejc4BSZISLCwjdV/lV+WIcA8UNYhMw=
X-HE-Tag: 1757125789-94756
X-HE-Meta: U2FsdGVkX1/KnVXTIKhxRwY8pYrrcD5VqtTQizjjzv7FrfEABC73iKILJ0jDPaPxtx99s8C7MQEaEzBkiwp5KkZRiR9dV8+6xbHHAcyH1wIpWBUSm5bNvGbxpbZYFBthWIL8zKCGxRc9UQrfqnr7GqTAejOEi0UuuTF/zPfTJyZVYrd1k0Hsy2NfuQG9XWsj33LGbOj0h0gWcPEFY+38TYpCtg1KZOtpwFcs7B/7rzOzpZUlmhMHC2zezBq4OOvGJ+2vzGIjjfm8eO0YHzOtw99cdBBS2danR5F6qp43qQSbvaqiESdMUbm/aGEJr7bIilguZOqnP6bXkqInDThwaCLViCtWV5kd61cB0kqB/b8P+YaINbT/YSDlws4ZYMBA

On Fri, 5 Sep 2025 16:19:02 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> > +++ b/kernel/trace/fgraph.c
> > @@ -1391,10 +1391,11 @@ int register_ftrace_graph(struct fgraph_ops *gops)
> >  error:
> >  	if (ret) {
> >  		ftrace_graph_active--;
> >  		gops->saved_func = NULL;
> >  		fgraph_lru_release_index(i);
> > +		unregister_pm_notifier(&ftrace_suspend_notifier);  
> 
> Is this really correct ? The pm notifier is only registered if
> ftrace_graph_active==1, but not if it is larger than that.
> The above code unregisters it unconditionally, even if
> ftrace_graph_active > 1. I can see that the resulting double
> unregistration in unregister_ftrace_graph() doesn't really
> matter since the error return will be ignored, but is it really
> irrelevant for the successful registered graphs no longer get the
> benefit of the pm notifier callback ?

Ah right, it should be:

error:
	if (ret) {
		ftrace_graph_active--;
		gops->saved_func = NULL;
		fgraph_lru_release_index(i);
		if (!ftrace_graph_active)
			unregister_pm_notifier(&ftrace_suspend_notifier);
	}
	return ret;

I missed that there's a:

	ret = ftrace_startup_subops(&graph_ops, &gops->ops, command);
	if (!ret)
		fgraph_array[i] = gops;

Just before the error label, so the goto error isn't the only path there
that can affect the ret variable.

I could add a patch or you could send one.

-- Steve
