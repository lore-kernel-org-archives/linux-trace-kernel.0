Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2707618FC80;
	Thu,  2 Oct 2025 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396472; cv=none; b=vEdfTE2qfhigKFKQ3LNayBJh4QTT81O+YxvmAPMOJBeynq64sMomBsfTLICvnUQ2urwsjja6qh9ISd7KaAMVr2W6WA7NcPpymXqWf+PbfNcQBDTnIUeRjRzgkBrC5A4rBnuTIHqn8p7wc6vtLL/Zk3wlOFJEOVHDRFK1uD7GIMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396472; c=relaxed/simple;
	bh=A/j+Q0C8jyIwG3fetIVlHcpz++qZg6W/5wjEK0+ooqw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UvIJC2gz/9z1Nd0wOw5SsqDAqKSH0mfiIKj68rRoQckewO1/7aOljvv8zCkVZPD7ZivFkGUFioxzrZ5tx/DcAjhQ/vW3Q9HjLmTVnkpvhzwrw4ikFoUp56+fFei4ayTviAehVCMFwbQ2YoP1qGA7cwQl5iiCv1VF/+lkiudbRf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eM3HMv83; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xnZkskNY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eM3HMv83";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xnZkskNY"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759396469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tXOQOs4fnTj/6b+1rByBsXsxY8Mz9qwSY8WKi5NqMHY=;
	b=eM3HMv83keSwreLtGKEf0/puMuzbFzUEVHwpErC3AC40tiwHxPHuHaLg+hbqnnqfG2/e9u
	lm75jaBrJa/ZV23abyDl4Y1e2PQK67azMPKk8TOC9R0jsXUAGDsYFBVFqeurF8FrYPMJy3
	r1kA5CSAA41TxNRfyG8YWkgOOOvCQQ1c13npVsZD15xqhleVe0DXd1lUjdpQPH9c7c4bfe
	O0k9PzPlxLLzaOqIIA7HAve8OEkpXAeODpm0VZMpSdQ9co8IIoor8Fd9PXLvQCezwWnLMM
	nYq9iedGswL7dBAJPn08SdTjFKGYrgSOYA3GcFnSREby4vzfbNIMjEJyiZtH6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759396469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tXOQOs4fnTj/6b+1rByBsXsxY8Mz9qwSY8WKi5NqMHY=;
	b=xnZkskNYvCro5XY7IecONgOVGQ5BkMVoqtZpct6JKATBa7/YMU17SqkRJVB0OQ0pLiyHwS
	XYhxdljVlKxsFDCA==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Juri Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 03/20] rv: Unify DA event handling functions across
 monitor types
In-Reply-To: <20250919140954.104920-4-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
 <20250919140954.104920-4-gmonaco@redhat.com>
Date: Thu, 02 Oct 2025 11:14:28 +0200
Message-ID: <87a5297jij.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> +/*
> + * da_get_task - return the task associated to the monitor
> + */
> +static inline struct task_struct *da_get_task(struct da_monitor *da_mon)
> +{
> +	return container_of(da_mon, struct task_struct, rv[task_mon_slot].da_mon);
> +}

This function is not used? Maybe later in the series, let me keep looking..

>  static inline bool da_handle_start_event(enum events event)
>  {
> -	struct da_monitor *da_mon;
> -
>  	if (!da_monitor_enabled())
>  		return 0;

Can't this part be shared between different monitor types?

Same for the other handle functions.

Nam
