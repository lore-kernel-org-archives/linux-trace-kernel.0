Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FDC3446B0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242320; cv=none; b=r6gw25VTQY0+0aeGmbAwzJ7xvCwk+lwgmbpLICMzZy6+qRrjJvLoDSadUloEzmmD4sderm2eVPUJXxDISCXDAsRUlCmcZoD5ZmZ8SBGWFn/KZ0JHwjQ1OWBwa3XQxg9RFuJ1Ko3yq+YrcGUbAeD5m5FLyIFn0W+LmTg3n9nFdZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242320; c=relaxed/simple;
	bh=nzvl7mqCF4ztoD1AQhrEHtx+ggc5PpKtO7mNFBUOwCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQw6hKCfOp3hZ1PaN5Y0x2vCJYzJ2jvBDjiljhB0jXUFsq8pN7JGUXB2zk7PRhsXubCiwBk2Y7puz5DnU/7Rv0Wn8h3addN0U91bYdhvReHyHfJb6wRU0FEvKLyZy9/qAGrR9b1df+suwJZiLYDljAaMBPzEj60ukwD3wVfdeiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f47e3Cim; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f47e3Cim"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f705536so341135366b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 02:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790242317; x=1790847117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IVufKMPB9vejpNzxTLukLIifCoBhEi//kGkahD5KaUo=;
        b=f47e3Cimiq/4GG/lBAVvrd1xly4gsc9O4dK5YuRxulEjBDmz6olRWnVL0TveIpkiFi
         uvz9xeCMA/3K7vbu4v8AkF2hbW22qq03Z1KfDkRBCz3oirpIYrLJ5Eq9hlHH0/Xdd6Am
         3ZqWTqIJGfI8CznfuuD4iMZhodEHg1gqpWSdKBKURrElNF3CArEFI51tvz+2ULuz4R/L
         /Wl20E2CvTIOGWZZUEEJAjFbrW6q8rKCxTw2goPBhAEWE6qHH3oCYtOE+r4UGkxwHeDa
         yEx5wECT6uohnRGbonOnbM2ctn+iJeYV3ur8BsFYaYNDdchZfsDgLtqYGiXc/Wpw7ga0
         +NbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790242317; x=1790847117;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IVufKMPB9vejpNzxTLukLIifCoBhEi//kGkahD5KaUo=;
        b=J75DD509G/kQeARhOOfvMJ797ZAbS+iVlbaVOZgb8my4PlPDkoUXgfJqTD2JqthONy
         xqj7RfmGDFDjrUqZG57fB/RiqpjVqovxPVOJ5f3z3pfnpnHFsSNZHTFCBLG/znaN9yt7
         GbNbpgJFdiO6EHJG8AvYpeSYc6ASGBsvqeMhMXisp9BYTXWybqKZkK+yGWRXfMmQV8PS
         rj5QWn8NzAccH0JqjHJ9m5yDoGdc3cFKXN2fS3VOtn9LiSsV+o0NEpGHP9z3fvAbDX3p
         3qdjjyS/VhKjCh0vrv+KdDZwDjZ/qm7otly3DKVOca94oGIkF5iyvf1p50lwX71zAO5g
         cAxg==
X-Forwarded-Encrypted: i=1; AKwUvBxOa/VI4a60wYU7VZYxc00YYuA5IOV97fw1ZLfJ6LaI+y9IRXHqtKCEPp7sp9xDVFspDBQHNfYLYdSI8uTx+entMz8=@vger.kernel.org
X-Gm-Message-State: AFuF++nBUJvUIltoU+xSYBHadJnMw3l08H1LS1AqC2yHzs1jWDRIhEjm
	o08r0EWqOFOktxb0sKpplNd2luUGHPiBB48UUQq8S1PEdZ9t8nDcdKWp
X-Gm-Gg: AYBFou1oPXY2AtJegcoMHsyiXEREREvK9/wzRBKZ3wlCoLQYMAB6lQ8u8v89M6eQyA7
	WOFkC1v5sJdN45MiPoPek3Wyhl1JN3c/AcZ//xEV4wmK/IfOwp6US6uFrV53ie/sgvmaIfCo8cV
	HoGywh28SjL8EUCqG5Wy3HN7NcZ6nazPDqOKh71jLxI7UBMkGP/tiNmr0mvGCDlllOPhxtaEHYl
	cXxi8FuPnPTym9s+yRVmlWc6bIIsVlPOkkx59FGmHfFHhWsj1bSWpZlKitxaP9ikURrMz10cjtA
	Og7zx5qhmH0mnzqzX3vV9vBdijEAbg0XZ+OoppCUiltLxL03Cz1yPuxJqNTHyNkJoI2S6YEVV+V
	28SOvAssnYasUP0ULd4whTt99OCSY+P/VMCcFNjMsVznIb5/VBeKc91rR/H+bEjWFaYZ+Nw4fzB
	wpRjZ5Cz+///gU+zRFZXqRn4lKzZMCyIA25O1ZkEOSnyUnbgvV7VzqvsiWzYVOq5fCoL/gn85Dj
	dCnAr3iCEHEySe0vyn/h++WKWVVnPkeShB1E8QkBOECTakjLLq4/24qa+iOExTt6Hav1kuoi8Rd
	Zu4f
X-Received: by 2002:a17:907:9812:b0:c26:1648:a06e with SMTP id a640c23a62f3a-c2ac253f94cmr137512666b.41.1790242317135;
        Thu, 24 Sep 2026 02:31:57 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae675d59sm270080366b.42.2026.09.24.02.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:31:55 -0700 (PDT)
Date: Thu, 24 Sep 2026 11:31:50 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Boqun Feng <boqun@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Make optprobe optimizer multi-generational and
 asynchronous
Message-ID: <arTuBodyGqQ0mErI@andreayoga.localdomain>
References: <20260923164510.f3bbddefea4423f8f1bfecb8@kernel.org>
 <179017148080.466588.9116221556625712980.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179017148080.466588.9116221556625712980.stgit@devnote2>

Hi Masami,

> -	/* Step 5: Kick optimizer again if needed. But if there is a flush requested, */
> -	if (completion_done(&optimizer_completion))
> -		complete(&optimizer_completion);
> +	/* Step 2: Dispatch waiting room generation if allowed */
> +	optprobe_dispatch_generation();
>  
> -	if (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list))
> -		kick_kprobe_optimizer();	/*normal kick*/
> +	/* Step 3: Check completion if flush was requested */
> +	if (!optprobe_optimizer_busy()) {
> +		if (optprobe_flush_requested) {
> +			optprobe_flush_requested = false;
> +			complete_all(&optimizer_completion);
> +		}

Removing the completion_done() check also fixes a hang in the current
code: completion_done() is only true once the completion has been
completed, so complete() is never called while a flusher waits.  For
example, "echo 0 > /proc/sys/debug/kprobes-optimization" with an
optimized kprobe never returns.  I posted a fix for that separately [1].

[...]


> -	while (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list)) {
> +	while (optprobe_optimizer_busy()) {
>  		init_completion(&optimizer_completion);

This part is still racy, though.  The flusher drops kprobe_mutex while
it sleeps, and the sysctl handler and the debugfs "enabled" file do not
otherwise serialize against each other.  A second flusher can then run
init_completion() on the wait queue the first one is sleeping on: the
first waiter is dropped from the queue, and complete_all() wakes only
the second one.

With this patch the window is wider, since kprobe_mutex is released
while the Tasks RCU grace period runs and optprobe_optimizer_busy()
stays true until the generation is finalized.

The fix in [1] replaces the completion with a counter of optimizer
passes, bumped at the end of each pass and signalled with
wake_up_var_locked(), both under kprobe_mutex; the flusher samples the
count and waits with wait_var_event_mutex() until it changes.
Something similar should fit here, with the counter bumped at the end
of each kprobe_optimizer() call and the flusher re-checking
optprobe_optimizer_busy() under kprobe_mutex as it does now.

[1] https://lore.kernel.org/all/20260924092142.199198-1-parri.andrea@gmail.com/

Thanks,
  Andrea
