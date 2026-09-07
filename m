Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A0E51FCDB;
	Mon,  7 Sep 2026 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799508; cv=none; b=FDsgAWvNLvDYteRwL/zijWJL0+ljxjBAIptIYATKLhtfQ2wAYYIyBOCDFltYBFmOxgk6KIm++8BNpRKK2dgzTMVeIe0v9ObAAb0hJ6e03wadrQZHZPyBCSXRUsukQ4KPXYVNQ+HgjBQ7xCrNQoXeZmbSMdUdI28Q9UJ/2qU5TuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799508; c=relaxed/simple;
	bh=JNNcGPg6GIL/WEakvJ694PuUxBRXX0IGTFIMXIj6GJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NowlyiITkqu/8mAZmIQsM5OV3+4PPEZbmiDrwAF/g6vGhriz/ubEhDfsI621QaptaCB7ON+hftoirPDnyECPCE3J6kn85uwHEXpKXAypzRGD4US6VhGErX046tmE1aIsUuOaZ4zipDv5rvzfvpdCPQ7f6Q4xpM/tkLigTN0iFaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OmTGGLEr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OmTGGLEr"
Received: from CPC-beaub-VBQ1L.localdomain (unknown [70.37.26.58])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5124620B710C;
	Mon,  7 Sep 2026 09:44:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5124620B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788799467;
	bh=IJMNT8Zybj9jSX6rKt61DM5iZuECFfZ5JYyExgt+5sQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OmTGGLEruBeMFCJ+JVv75nsr4RHFhRxwKi+Yuaati/bTNxce62jY8pJnxod+rdegs
	 cKO3qmyt+tJDmB7mAnP0RFaWa7dSyuhp8/CWGxO6XbLDrT1JocIze3abyUj+iLaIqS
	 OabSBYZZWUtPS65gTgzUdKPCbNpvasIRR9DA+2zI=
Date: Mon, 7 Sep 2026 16:45:02 +0000
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/user_events: Don't destroy fields when event
 removal fails
Message-ID: <20260907164502.GA65-beaub@linux.microsoft.com>
References: <20260903182903.GA62-beaub@linux.microsoft.com>
 <20260904115223.2976446-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904115223.2976446-1-bsdhenrymartin@gmail.com>

On Fri, Sep 04, 2026 at 07:52:23PM +0800, Henry Martin wrote:
> destroy_user_event() destroys the event's fields before attempting to
> remove the trace event call. If user_event_set_call_visible() fails,
> e.g. because the event is still enabled and trace_remove_event_call()
> returns -EBUSY, the event is left registered with an irreversibly
> destroyed field list. Any subsequent interaction with the event then
> operates on an empty field list while it is still fully visible in
> tracefs.
> 
> Move the field destruction after the call removal, and splice the
> field list back onto the event when the removal fails so the event
> remains in a consistent state.
> 
> Fixes: 7f5a08c79df35 ("user_events: Add minimal support for trace_event into ftrace")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
> v2:
>  - Restore the comment on detaching the fields before removal: removing
>    the event frees the field list memory, which is allocated and owned
>    by user_events (Beau).
>  - Comment why the fields are spliced back onto the event when removal
>    fails: the event stays registered and the fields must be recovered
>    (Beau).
> 

This looks good to me.

Reviewed-by: Beau Belgrave <beaub@linux.microsoft.com>

Thanks,
-Beau

>  kernel/trace/trace_events_user.c | 26 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 93cda2f6f2692..f658c3a77aa7a 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1122,10 +1122,9 @@ static void user_event_destroy_validators(struct user_event *user)
>  	}
>  }
>  
> -static void user_event_destroy_fields(struct user_event *user)
> +static void user_event_destroy_fields(struct list_head *head)
>  {
>  	struct ftrace_event_field *field, *next;
> -	struct list_head *head = &user->fields;
>  
>  	list_for_each_entry_safe(field, next, head, link) {
>  		list_del(&field->link);
> @@ -1502,17 +1501,32 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
>  
>  static int destroy_user_event(struct user_event *user)
>  {
> +	LIST_HEAD(fields);
>  	int ret = 0;
>  
>  	lockdep_assert_held(&event_mutex);
>  
> -	/* Must destroy fields before call removal */
> -	user_event_destroy_fields(user);
> +	/*
> +	 * Detach the fields before removing the call. Removing the event
> +	 * frees the field list memory (trace_destroy_fields() is run on
> +	 * successful removal and kmem_cache_free()s the fields), but the
> +	 * fields here are allocated and owned by user_events. Destroy
> +	 * them separately once removal has succeeded.
> +	 */
> +	list_splice_init(&user->fields, &fields);
>  
>  	ret = user_event_set_call_visible(user, false);
>  
> -	if (ret)
> +	if (ret) {
> +		/*
> +		 * Removal failed and the event stays registered, recover
> +		 * the fields so it is left in a consistent state.
> +		 */
> +		list_splice(&fields, &user->fields);
>  		return ret;
> +	}
> +
> +	user_event_destroy_fields(&fields);
>  
>  	dyn_event_remove(&user->devent);
>  	hash_del(&user->node);
> @@ -2212,7 +2226,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
>  put_user_lock:
>  	mutex_unlock(&event_mutex);
>  put_user:
> -	user_event_destroy_fields(user);
> +	user_event_destroy_fields(&user->fields);
>  	user_event_destroy_validators(user);
>  	kfree(user->call.print_fmt);
>  
> -- 
> 2.43.0
