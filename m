Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6341C17578;
	Wed,  9 Jul 2025 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752086962; cv=none; b=dE6uee883jtuUxssO4/BlaWKFguku30psCmNKg78PVRbUXPVCpL+KVsixAAbdcOriYPGoj62DS7TZ3w6THVByYOoK046HskCdmoKTw1vxspLZXmYWRFpRJUMLCeT8yzHAEKeAwgUNUx5INUNzN0oPrO3gPPICCwJQJeCjopI9B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752086962; c=relaxed/simple;
	bh=HLO9FBtVgrevooKX5m9nciAoCieYVG6E4u1Q/V5l5Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nzlfhtq0PQhsXHexGcDqz/fIiMVx1+M28B+E4OSlmact5As7LfiYyX/qMQsOJ18s55W+0BGUxwvcUQhTrunm0am69ZqwWyVttoQ7yx81GxSaCt1UQjIpXYD1sNwOhvAewLsF25Qjulih/KMvz39k7z3WY7lnNao8MWsKqFPzExA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 5F58480267;
	Wed,  9 Jul 2025 18:49:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 3B57D20013;
	Wed,  9 Jul 2025 18:49:15 +0000 (UTC)
Date: Wed, 9 Jul 2025 14:49:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v12 02/12] printk: Make vprintk_deferred() public
Message-ID: <20250709144914.6ee7199b@batman.local.home>
In-Reply-To: <25d52fcad6d1ce8f8ac262199d3e8474e029961f.1752082806.git.namcao@linutronix.de>
References: <cover.1752082806.git.namcao@linutronix.de>
	<25d52fcad6d1ce8f8ac262199d3e8474e029961f.1752082806.git.namcao@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 3sz8gx53oyzk7g6kim5n5tncrnx4mzsp
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 3B57D20013
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+zjB7gWNTPtJYxaDPygEOT9DN6uC49kS8=
X-HE-Tag: 1752086955-650145
X-HE-Meta: U2FsdGVkX1/5LlIyxZKYAcyoFuGAGb2MQtLNuxOyPviG9ckTMZovizhdrn283zotxcgcCm/pJFoz22f6vY5hV2Mb2EzUiY/u2Sg10q+X9nRNv3dbSmjqatzvWTAZ4vnWnmLUzO/d8hEtAlZQiZlV6+/rg6WIdvIhi34asik03VhJA3dmTGCcqU6QKtVDyKh7eu3OtOm3yqJ0mqFDBJdxQcScyzsLtEOsYyw6ZLs6mYpcw3+uwwmzt/z3nQr0JXB0K0QqFe6XQV+O3rI/lBiXyY5CnpRxn9tmoiyqesOS7zPvP88fV2MIS6DU5cUnBRtv

On Wed,  9 Jul 2025 19:56:19 +0200
Nam Cao <namcao@linutronix.de> wrote:

> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 5b462029d03c..d886ec98fbbd 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -154,6 +154,7 @@ int vprintk_emit(int facility, int level,
>  
>  asmlinkage __printf(1, 0)
>  int vprintk(const char *fmt, va_list args);
> +__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
>  
>  asmlinkage __printf(1, 2) __cold
>  int _printk(const char *fmt, ...);
> @@ -214,6 +215,10 @@ int vprintk(const char *s, va_list args)
>  {
>  	return 0;
>  }
> +static inline __printf(1, 0) int vprintk_deferred(const char *fmt, va_list args)
> +{
> +	return 0;
> +}
>  static inline __printf(1, 2) __cold
>  int _printk(const char *s, ...)
>  {

All use cases I've seen throughout the kernel has the __printf() macro
on the line before the function. You're introducing a new formatting.
I'm thinking we should stay consistent:

__printf(1, 0)
int vprintk_deferred(const char *fmt, va_list args);

static inline __printf(1, 0)
int vprintk_deferred(const char *fmt, va_list args)
{
	return 0;
}


-- Steve
