Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B143737AA91;
	Thu, 28 May 2026 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958783; cv=none; b=Zs8waxvve67+rxZtjgfwm6DWE4CzDh9To9+pyiCD1MYIJI/+2uL2RiC93K/3lPY+mV2CZBTmxARpdaS95jbx6XgW3NzVuHM5gsk47A3z07pjKSmARE2z2j/ZHd68hfOlN9I4RN6t+CgcVObrEX9wv/1fx8QotD7KIaO2bySRN3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958783; c=relaxed/simple;
	bh=qVvt1P77x8NsDZmDrgTvxdcgLxDFkysfyRlw2k/6f64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=htb8549P780/Vd9EalOj1mR0oGhLLbLjABQ6hqEPd5UvUYu3EefaGtPi5VaaZgzOcmS+nfzkL3z+61bZb67pBJlTdUkoZTXDdpetV3Uh7wbepYx8NsZ4AqVpa/N75VzRN4SJuepAcuSht+Fz+nuQtnxokZwk5eTIdk0DosIt9b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AQoJWAKM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rHpY4EUA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AQoJWAKM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rHpY4EUA"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779958779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qVvt1P77x8NsDZmDrgTvxdcgLxDFkysfyRlw2k/6f64=;
	b=AQoJWAKM1A5l1mXdhdXfViKSf9KviIeH9MxYOqDYHI7NTMCaa4Px6PDtYm0017OSw33VQ0
	rPDLw4te20C0kYvaK+cP4o3wEmD4yVeoAcLl7Z1wCECdVILKFIwyIpeEf7U3sXi6dJf7TP
	YKY94vJQpQjXH6fM2JKuI95skags9G8gbTgKeINXDGsbFC1Wmc+UD/BK6SGrHimfJvOAEc
	oXWIAL/Ov6xE5lVaWR8miqmeMQB5RQIAkgJFMB0oNUoqrIDCWI7X3E6V409b6LfFoJVX/2
	uytMnC5kNFu9sJ9IOrNHoflF3sUKePLssQ5iVZqzKn578IsiN4xBC22r2GxcSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779958779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qVvt1P77x8NsDZmDrgTvxdcgLxDFkysfyRlw2k/6f64=;
	b=rHpY4EUACt8dixmsYI7OzhC0o/R5Zq/Tl2ZPko9crfgZllvvHypP5kTHREFKPxCLnq1oAR
	53vvRvl1jsWAM5Dw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v2 05/12] rv: Prevent in-flight per-task handlers from
 using invalid slots
In-Reply-To: <20260527062313.39908-6-gmonaco@redhat.com>
References: <20260527062313.39908-1-gmonaco@redhat.com>
 <20260527062313.39908-6-gmonaco@redhat.com>
Date: Thu, 28 May 2026 10:59:39 +0200
Message-ID: <87cxyfoqo4.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Per-task monitors use a slot in the task_struct->rv[] array and store
> that locally (e.g. task_mon_slot), this slot is returned during the
> destruction process but currently hanlers can be running while that slot
> is returning and this race may lead to accessing an invalid slot.
>
> Synchronise with all in-flight tracepoint handlers using
> tracepoint_synchronize_unregister() before returning the slot.
>
> Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
> Fixes: a9769a5b9878 ("rv: Add support for LTL monitors")
> Suggested-by: Wen Yang <wen.yang@linux.dev>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
