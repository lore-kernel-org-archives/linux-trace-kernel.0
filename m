Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C1237CD32;
	Thu, 23 Jul 2026 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828260; cv=none; b=U7RSZOXxCTUDgU2MzkBmIUb4vetM91wCNxoo3uhM5QQBaKTF8+3ERVyI9KmQ6sKWHbXSetrBPHI8nXKXq/6PuhEsLETM9EQDrqo54zgbU4meLqOh/BWRyKEBC8reyY15/6SjiE5/n3SnVamJq0p0YVGijpyRsfZoQjji/j3FR5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828260; c=relaxed/simple;
	bh=UL+Ay/seoUORWXpwCrqzq9E29lYZh9pZ/K/qBmJAMzI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVReIm9aOZo2ov8HpU0qA2lM+Pci8OX09ihfkp4wGogeBMSJ2DFtEKMGzlxlvO/k/REaOClijgQZ/bvqISGDLVBhwatHUJOXJtPiX0uISN45RSQTlT8PNA1+dbLEJwtrXSu9b8EpsmHbeOKfP3QQDe0IicYEtIUKBmEKaqCGL9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id A1999A0036;
	Thu, 23 Jul 2026 17:37:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id E7BA720025;
	Thu, 23 Jul 2026 17:37:29 +0000 (UTC)
Date: Thu, 23 Jul 2026 13:37:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Carlier <devnexen@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Restore synchronize_rcu() before freeing
 trigger private data
Message-ID: <20260723133752.7d384996@gandalf.local.home>
In-Reply-To: <20260723170212.55325-1-devnexen@gmail.com>
References: <20260723170212.55325-1-devnexen@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 3b977byuzbdex11mbyxkfw1pjdfma8tz
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: E7BA720025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+LiWOkogkUIiemfi+XgvAMR6pnYQ1yNqU=
X-HE-Tag: 1784828249-523947
X-HE-Meta: U2FsdGVkX18Ewjbaf29kjoHUzZqA4e0W/cV1HhrEmpRvTVejBg+ARpaXqJw2o/TVRgcWtrAK2fxmK6gA1uQn/As1oQeXbtRBTXs0l4ZvfTE4plxWJQvDfU2Typ/GKKpKdXSZ8aSChhcsaDNHaWx4iKIo9SzhjCdY9kdHzDzEXyKrS8r09aAVZ28JX8rptR5BcAcnHg24eX/VR+hssZZ7gYLGVt9gtf16VSU/6ssedt0z0Z43b4YxGZVwId5HmbTYDf0hgV/5l6oUbDfX0v4j5kN0n/uBm8CA6g96igR/QAEqkdJ2cRJJQ+qr0VpM8srOrZml7LwmVd2bPeJYpivA8lQKJsqJfkNh2KrwfHZxvpm/X5RUCW5pRUnOiHK6tZBUvrsu7xqetcgruvt8BOKZLQ==

On Thu, 23 Jul 2026 18:02:12 +0100
David Carlier <devnexen@gmail.com> wrote:

> ---
>  kernel/trace/trace_events_hist.c    | 3 +++
>  kernel/trace/trace_events_trigger.c | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 82ce492ab268..ddd2f70dac4f 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -6349,6 +6349,8 @@ static void event_hist_trigger_free(struct event_trigger_data *data)
>  
>  		trigger_data_free(data);
>  
> +		synchronize_rcu();

According to Sashiko[1], it appears we actually need tracepoint_synchronize_unregister().
And I believe Sashiko is actually correct.

> +
>  		remove_hist_vars(hist_data);
>  
>  		unregister_field_var_hists(hist_data);
> @@ -6388,6 +6390,7 @@ static void event_hist_trigger_named_free(struct
> event_trigger_data *data) 
>  		del_named_trigger(data);
>  		trigger_data_free(data);
> +		synchronize_rcu();

This needs to be changed too.

>  		kfree(cmd_ops);
>  	}
>  }
> diff --git a/kernel/trace/trace_events_trigger.c
> b/kernel/trace/trace_events_trigger.c index 655db2e82513..c3f54f2540b6
> 100644 --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -1730,6 +1730,7 @@ void event_enable_trigger_free(struct
> event_trigger_data *data) trace_event_enable_disable(enable_data->file,
> 0, 1); trace_event_put_ref(enable_data->file->event_call);
>  		trigger_data_free(data);
> +		synchronize_rcu();

According to Sashiko, this one basically causes a revert of the original
delay. 

OK, let's bring back a partial part of your original patch. Have the
"free_private()" again, but only apply it to this trigger, and switch the
above other to synchronize_rcu() into the tracepoint_synchronize_unregister().

Thanks,

-- Steve

>  		kfree(enable_data);
>  	}

[1] https://sashiko.dev/#/patchset/20260723170212.55325-1-devnexen%40gmail.com
