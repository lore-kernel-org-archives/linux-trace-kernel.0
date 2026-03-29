Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2195E37D12A;
	Sun, 29 Mar 2026 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774809547; cv=none; b=c3Dg/znWd/sxTKAlJ4YcYUPzDrRsOsS39FBCJFZx5Uylpr0x9vQAAcpIBcY6a7wvledqoavVjrpqIv1eWnOLsxoQ09kdVBsvOWTAv4+7wgTieH6CsJhrGf1LBGJ2FHi+eV9D/y5tmwEp0w5LhCkj8/Io63j/1F57x27IDQxnVJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774809547; c=relaxed/simple;
	bh=kxUOsvPOR/Kq/RPcD57qK4ySszU2EecAu+y8lwisSdg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QmJRrDj9KslTUkQzN2S6KmNqp1hAGZAQWr9nE/rYJ2q1uwNW0kKXCwtZMTrgyNI5sYn1oBMl3w5Vl0iI7YmUV+UYh9JeCX8Lkr2vVLOZYpjxCKg9bJbeEwlruVXr0tPaPWGUoNCaxCpmDFjMEMMpV/VcXIPYhoY6Uqd1RccQvOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id D31531404F4;
	Sun, 29 Mar 2026 18:38:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 03D2520029;
	Sun, 29 Mar 2026 18:38:55 +0000 (UTC)
Date: Sun, 29 Mar 2026 14:39:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 tom.zanussi@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing/hist: bound full field-name construction
Message-ID: <20260329143949.35659b68@gandalf.local.home>
In-Reply-To: <20260329030950.32503-1-pengpeng@iscas.ac.cn>
References: <20260329030950.32503-1-pengpeng@iscas.ac.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 03D2520029
X-Stat-Signature: cgwtu6j7yfgcb7jpwahzde7udspx4wq1
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+IZOtreKI8fx1Km0abmjs/QaWg8Ff440Q=
X-HE-Tag: 1774809535-216554
X-HE-Meta: U2FsdGVkX1/oqtA3OhOEuzPFYul/79FHNyrVJmG9hrXK2IMAEB4E7RwyanSKMiG/OSGSxOU4cpdwk92vYQcCEegZcHWLurnIBerd1XGnayUIk1/QJH/tqlLwyY5v+rhVePpT4/XU/gFyy4rj/Jo0WdMPUr01Da4VXsDIyOWPF9AZbB+79X9UmgTsGI3rrqhFnnmD6BuvEgH83tQeO2Z5welhuO+K4jHmurfWiFdeRoY4oKNbDQGuIEYpfjiGG/82WbulNzT6v0xnBRN9C28T4iLEgflDrPmH+LoLCj4XVg4PVTGD8DlgSy1iol5hdEn6

On Sun, 29 Mar 2026 11:09:49 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> hist_field_name() builds a fully qualified synthetic field name in a
> fixed MAX_FILTER_STR_VAL buffer using repeated strcat() calls. Long
> system, event, and field names can therefore overflow the static staging
> buffer.
> 
> Build the qualified name with snprintf() and fall back to the plain
> field name if it does not fit.

The fallback breaks 
> 
> Fixes: 067fe038e70f ("tracing: Add variable reference handling to hist triggers")

Do you have any examples where it actually does overflow or is this just theoretical?

If it's just theoretical, it does not get a "Fixes" tag.

Hmm, but actually I don't see it resetting full_name to a '\0' so I can see
this concatenating on top of a previous value. THAT would need fixing and
require a fixes tag. An example of triggering the overflow would also be
required.

> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  kernel/trace/trace_events_hist.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 73ea180cad55..4a27da628a71 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1362,12 +1362,12 @@ static const char *hist_field_name(struct hist_field *field,
>  		if (field->system) {
>  			static char full_name[MAX_FILTER_STR_VAL];
>  
> -			strcat(full_name, field->system);
> -			strcat(full_name, ".");
> -			strcat(full_name, field->event_name);
> -			strcat(full_name, ".");
> -			strcat(full_name, field->name);
> -			field_name = full_name;
> +			if (snprintf(full_name, sizeof(full_name), "%s.%s.%s",
> +				     field->system, field->event_name,
> +				     field->name) < sizeof(full_name))

Ug, please do not use a horribly looking if conditional. And it should most
definitely error on overflow: Break it up:

		if (field->system) {
  			static char full_name[MAX_FILTER_STR_VAL];
			int len;

			len = snprintf(full_name, sizeof(full_name), "%s.%s.%s",
				       field->system, field->event_name,
				       field->name);

			if (len >= size(full_name))
				return NULL;

			field_name = full_name;

> +				field_name = full_name;
> +			else
> +				field_name = field->name;
>  		} else
>  			field_name = field->name;
>  	} else if (field->flags & HIST_FIELD_FL_TIMESTAMP)

-- Steve
