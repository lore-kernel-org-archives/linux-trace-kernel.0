Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD0A2EC553;
	Mon,  9 Mar 2026 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086581; cv=none; b=V4Yq8zpOcu1TS8cff9lpQipZ9KmZa8dfHnNz1vGHQiwJZaSZHf0LJxgbWxRrSJrsRKZWamIxSXoKM2gRgv92fxgIsSP1oMC1UCVbuT1SdJTZ2AcX8m9ZOXVET9vNnnK7EPKq6pqEI33Db0yhiNmdxYHzf4yaFdHNGkLNcXwCmMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086581; c=relaxed/simple;
	bh=4QRGyVduG/Qaz1BCew/1ZmaegZ9qxUUkfCV8AiwOovM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pgdas72iDTdhFdGbqPfahyA766LuYQXo1xWBe/u5woEKZMFZh/8eyh12CTk4PEx0auaMLyGep1VUaztoDNS3PaSwTpqcF+hrklFkg7H2xFHoTxheNotT2X26JBjUybrUCCd+k4754P7CF1Nt14LKbJB1+aUMEHwhua+4csrmOKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 1DED41B73DB;
	Mon,  9 Mar 2026 20:02:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 3F85732;
	Mon,  9 Mar 2026 20:02:51 +0000 (UTC)
Date: Mon, 9 Mar 2026 16:02:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wesley Atwell <atwellwea@gmail.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing: drain deferred trigger frees if kthread
 startup fails
Message-ID: <20260309160259.0c94958f@gandalf.local.home>
In-Reply-To: <20260309195220.2726094-2-atwellwea@gmail.com>
References: <20260309195220.2726094-1-atwellwea@gmail.com>
	<20260309195220.2726094-2-atwellwea@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: h4atcd7r5un6eu8imnkcypk9zif9nkky
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 3F85732
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+rLF9KddfVKdVBrlutGLRigU5G6F1DZ6A=
X-HE-Tag: 1773086571-473091
X-HE-Meta: U2FsdGVkX19RfQ+rFssaj0yqED4Bn6OGGqEZUxUvGSgZjcKt5lwxr+Iblrh8SV97gBUYDmtS7UkVcBBSxWwg0D8CqoT8488G7bnKgWmsXOkHsdAcpFHzDTc/wjEmnStf61TfjVVrZJ0Ks+t4Scbt+mviCy7/fSeqh50mJIsJXFXPjVoqA8+AJN2zVMW2o9dajwZnwCKil34QEisQIjex+y7qtGuqCybIvXuOp0kVxn/L4BKRJzx4k6pmhE5IVFmppyMsv32tgQzi1L1yySL4Fczk0CSOY6jQGYr+SdiJkShO/AjoQWdrmz2Ff9agQ6Iq28r4oN42+FQ7ybUsKnDkIkYEV7K68o+R

On Mon,  9 Mar 2026 13:52:20 -0600
Wesley Atwell <atwellwea@gmail.com> wrote:

> @@ -56,30 +89,48 @@ void trigger_data_free(struct event_trigger_data *data)
>  	if (data->cmd_ops->set_filter)
>  		data->cmd_ops->set_filter(NULL, data, NULL);
>  
> +	/*
> +	 * Boot-time trigger registration can fail before kthread creation
> +	 * works. Keep the deferred-free semantics during boot and let late
> +	 * init start the kthread to drain the list.
> +	 */
> +	if (system_state == SYSTEM_BOOTING && !trigger_kthread) {
> +		llist_add(&data->llist, &trigger_data_free_list);
> +		return;
> +	}
> +
>  	if (unlikely(!trigger_kthread)) {
>  		guard(mutex)(&trigger_data_kthread_mutex);
> -		/* Check again after taking mutex */
> -		if (!trigger_kthread) {
> -			struct task_struct *kthread;
>  
> -			kthread = kthread_create(trigger_kthread_fn, NULL,
> -						 "trigger_data_free");
> -			if (!IS_ERR(kthread))
> -				WRITE_ONCE(trigger_kthread, kthread);
> +		trigger_start_kthread_locked();
> +		if (!trigger_kthread) {
> +			llist_add(&data->llist, &trigger_data_free_list);
> +			trigger_data_free_queued_locked();
> +			return;
>  		}
>  	}
>  
> -	if (!trigger_kthread) {
> -		/* Do it the slow way */

You removed the above comment. It's still relevant in the above if
statement.

-- Steve

> -		tracepoint_synchronize_unregister();
> -		kfree(data);
> -		return;
> -	}
> -
>  	llist_add(&data->llis
