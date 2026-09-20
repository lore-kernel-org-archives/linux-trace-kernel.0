Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901DC3F4DC7;
	Sun, 20 Sep 2026 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789903783; cv=none; b=MAgd3RRdcJUxc8bzIS5wGzJ1JUIykd4yAxUk8ZRe9q1jywyozpn1T1HdkQ3kFnBlXy80Wc5Ag0ktNsQi4e0k6MQRe92RSK7DiIksHkP5nTC+bLchbKCDRUyFSVZJUamrAw5dAhclSh5ki51Y0307yX6BIAjLn1jCe7p8wBl2BDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789903783; c=relaxed/simple;
	bh=2gjJudq4izhq9IkfVOID0c4xvDN+P7P8O8ylW+AveUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6aXi4Fw3FYaHPXR6Puuta0y014yBRS/Z/X38qP8jkTyKpd3Z8XbBFWa5M2EI5z+uBD1HpSPOtZD5htU6ivEjXN4cY17CAe8bOeH3WIR3JbBUIlm5b7msNds/vzw26+0pqQ7vPnIW0ZA8lhptS3nmXNYO+8QxofJoeV7jn/rRd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=v/epQyRj; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="v/epQyRj"
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 49A141403EA;
	Sun, 20 Sep 2026 11:22:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 5F80320026;
	Sun, 20 Sep 2026 11:22:35 +0000 (UTC)
Date: Sun, 20 Sep 2026 07:21:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, Peng Fan
 <peng.fan@nxp.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: use assign_bit() where applicable
Message-ID: <20260920072151.40637efd@fedora>
In-Reply-To: <20260920022810.3145921-1-peng.fan@oss.nxp.com>
References: <20260920022810.3145921-1-peng.fan@oss.nxp.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: g196ure1i8i8sf9jfgon3xcsie8w81r3
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5F80320026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Ql80igF4NtJw0bd/efvVbzTp3DyX0Ris=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=JzLWghkgJwXUDT/eJcnpKGJ9j5om+rM0RNHOLD6uo0Q=; b=v/epQyRj8Hs9jOMCrwTAB9TlRqRuYaKonMqgoCigDkGndvKE774xpv8UOYLSVmAZyCjJwJyF6B9VOcQ7v/2E3NPyc1CDbgE1393Lufg2HS8oFC+dhSCVysNb+vNMNjwI2JeZBcqXLGes8Mz+xCbftYeOTOHkmMeszXPrbvMu66A=
X-HE-Tag: 1789903355-503385
X-HE-Meta: U2FsdGVkX18v2tQzrM9VkrDA1quBgUiLCF3bUSfJ6L6ENbBPzSaGs1hJOUtNfN583oaWg5cGBjsfXOfQ0swIzMSMZG8ou7RImSICFprA1Nl3p327IZtw7IaYH+i4ZDWy1b8hm0h9Og1XfJ89ula12MZnhVWN1l0EgbjglINYToHjMFlSw9ap9kMUl7qs8h+4veXamVW9Gfj1rljLDU6JCdH74MEKPx2waqi9qCdT4yzak/xQQ/yJF13F+bM0ebQsRx4GyIU1Ghe/79dXM/qhf7xESRgun8LgVn/0GWrejxgj60lAdgPO5RUj4RCvPKTHpb5zkt0h2LUrzkLHBewQAdeWffbacwuPT6rGIrdj4NJRc4iYoAFkm0MmpOK6KCAeNXsDOz4r3kI26RFzPSfy/et2VEGqV2BR

On Sun, 20 Sep 2026 10:28:10 +0800
"Peng Fan (OSS)" <peng.fan@oss.nxp.com> wrote:

> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert open-coded if/else with set_bit/clear_bit the assign_bit API.
> 
> Done with Coccinelle semantic patch:
>     // set_bit -> clear_bit => assign_bit
> 
>     @@
>     expression cond, bit, addr;
>     @@
> 
>     -if (cond)
>     -        set_bit(bit, addr);
>     -else
>     -        clear_bit(bit, addr);
>     +assign_bit(bit, addr, cond);
> 
>     // clear_bit -> set_bit => assign_bit
> 
>     @@
>     expression cond, bit, addr;
>     @@
> 
>     -if (cond)
>     -        clear_bit(bit, addr);
>     -else
>     -        set_bit(bit, addr);
>     +assign_bit(bit, addr, !cond);
> 
>     // __set_bit -> __clear_bit => __assign_bit
> 
>     @@
>     expression cond, bit, addr;
>     @@
> 
>     -if (cond)
>     -        __set_bit(bit, addr);
>     -else
>     -        __clear_bit(bit, addr);
>     +__assign_bit(bit, addr, cond);
> 
>     // __clear_bit -> __set_bit => __assign_bit
> 
>     @@
>     expression cond, bit, addr;
>     @@
> 
>     -if (cond)
>     -        __clear_bit(bit, addr);
>     -else
>     -        __set_bit(bit, addr);
>     +__assign_bit(bit, addr, !cond);
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  kernel/trace/trace_events.c         | 12 ++++--------
>  kernel/trace/trace_events_trigger.c | 11 +++--------
>  kernel/trace/trace_events_user.c    |  5 +----
>  3 files changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 30c0ddf90887..72a210da67d6 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -859,10 +859,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
>  			WARN_ON_ONCE(ret);
>  		}
>  		/* If in soft mode, just set the SOFT_DISABLE_BIT, else clear it */
> -		if (soft_mode)
> -			set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
> -		else
> -			clear_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
> +		assign_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags,
> +			   soft_mode);

Please make it a single line. tracing is not strict about the 80 line
limit if it makes it look worse.

>  		break;
>  	case 1:
>  		/*
> @@ -4273,10 +4271,8 @@ struct event_probe_data {
>  
>  static void update_event_probe(struct event_probe_data *data)
>  {
> -	if (data->enable)
> -		clear_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &data->file->flags);
> -	else
> -		set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &data->file->flags);
> +	assign_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &data->file->flags,
> +		   !data->enable);

Ditto.

>  }
>  
>  static void
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index 4d2fde996c0f..3b5e14fd0dd9 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -674,10 +674,7 @@ void update_cond_flag(struct trace_event_file *file)
>  		}
>  	}
>  
> -	if (set_cond)
> -		set_bit(EVENT_FILE_FL_TRIGGER_COND_BIT, &file->flags);
> -	else
> -		clear_bit(EVENT_FILE_FL_TRIGGER_COND_BIT, &file->flags);
> +	assign_bit(EVENT_FILE_FL_TRIGGER_COND_BIT, &file->flags, set_cond);
>  }
>  
>  /**
> @@ -1673,10 +1670,8 @@ event_enable_trigger(struct event_trigger_data *data,
>  {
>  	struct enable_trigger_data *enable_data = data->private_data;
>  
> -	if (enable_data->enable)
> -		clear_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &enable_data->file->flags);
> -	else
> -		set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &enable_data->file->flags);
> +	assign_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &enable_data->file->flags,
> +		   !enable_data->enable);

Ditto.

Thanks,

-- Steve
 
>  }
>  
>  static bool
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index f658c3a77aa7..055894cb999c 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -590,10 +590,7 @@ static int user_event_enabler_write(struct user_event_mm *mm,
>  	ptr = kaddr + (uaddr & ~PAGE_MASK);
>  
>  	/* Update bit atomically, user tracers must be atomic as well */
> -	if (enabler->event && enabler->event->status)
> -		set_bit(bit, ptr);
> -	else
> -		clear_bit(bit, ptr);
> +	assign_bit(bit, ptr, enabler->event && enabler->event->status);
>  
>  	kunmap_local(kaddr);
>  	unpin_user_pages_dirty_lock(&page, 1, true);

