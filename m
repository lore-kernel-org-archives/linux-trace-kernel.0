Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5173E1CF0;
	Mon, 18 May 2026 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092032; cv=none; b=kxbdRu1TJyAh3lzyGyK9FPx5GGPsb9XtzG0L2JyhSeXJQvHuDMe6Zqjg0piSw0cFWepScPgen9iuxH1goznk7Qu2jrOydCZkcoGRi1NXS9IiMtwVpKIRnqb+MZI5neFQTOKuYMWZGIlqW4yqRgjUXSTWmBUN/KglCDPX4Scp5ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092032; c=relaxed/simple;
	bh=4I0h26XM8l2HhrxzK2T+/khxRbiXFvoZ71tgbbI1Zak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NVzUikBk0oWrM6hyYF2JpmKh8H5NgVdQ3fkTDahAHkdAZl+jQbw2FnN3rTZpAbB0qth2PrREy7qwmMyh2sRSMPNIGWpkhpmkDFfK1W2YwEWuQo3UNPSObjzbxVcQv7/sqChhgI/Bk7Xdk87IuKp9hgB//XqsxWqh9jHaQJuqGNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LXYVNxLT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IhtCDH/K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LXYVNxLT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IhtCDH/K"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779092029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+y2ndcnQ4Q+0Mv5t/X6KdWgH/GdsD2MPwRaNQcJHSdQ=;
	b=LXYVNxLTn126Ad7ym7mebxbFlc6kYE9vLiXSP0ANTfG8nLwqeMTGa4TCbJEK21UwXliIF/
	Ug8Il+IVAoE9oP8Up/t1iTgEAM/US8SL/uufL6mYJZdt1sNKsRHaE6jzfkjz2sceMoI6rJ
	iAhSv328TZ9qLM0GcjjLguu0UvI3w2X5afkmDGHlvXsRlj+3QUh2uYRhAMlVM5kCWPe4pE
	BDCqf/TK4hURDims2ZUk33MHtRkvugdD+YqOmZuYF4w9iO8IavphXniAr2yXKrupL9F4K3
	6UbpsZMgTi8lSH7ynIjJyyZc+2qZwSqIh27LZA/KlU2Qh/qh7zaaQEWUuNUkJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779092029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+y2ndcnQ4Q+0Mv5t/X6KdWgH/GdsD2MPwRaNQcJHSdQ=;
	b=IhtCDH/KjI/MUE5CFx4TcPFD9dBNVclXiAYTYNd3BxlhcgTBndcmsJRTBrFenft1+VyXfk
	D2pyzFBBkD//VBCg==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v2 01/14] tools/rv: Fix substring match bug in monitor
 name search
In-Reply-To: <20260514152055.229162-2-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
 <20260514152055.229162-2-gmonaco@redhat.com>
Date: Mon, 18 May 2026 10:13:48 +0200
Message-ID: <87ecj9879f.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
>  static int __ikm_find_monitor_name(char *monitor_name, char *out_name)
>  {
> -	char *available_monitors, container[MAX_DA_NAME_LEN+1], *cursor, *end;
> -	int retval = 1;
> +	char *available_monitors, *cursor, *line;
> +	int len = strlen(monitor_name);
> +	int found = 0;
>  
>  	available_monitors = tracefs_instance_file_read(NULL, "rv/available_monitors", NULL);
>  	if (!available_monitors)
>  		return -1;
>  
> -	cursor = strstr(available_monitors, monitor_name);
> -	if (!cursor) {
> -		retval = 0;
> -		goto out_free;
> -	}
> +	config_is_container = 0;

Isn't config_is_container unused?

Perhaps it is used in a follow-up patch? Let me keep reading..

Nam
