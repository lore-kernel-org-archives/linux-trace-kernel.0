Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9AE12FF6F;
	Mon, 19 May 2025 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747641784; cv=none; b=jZZBhfCECi52ORljbQmJAVKd1mJG/GvSwvs6sD9iH0hxgz7l1/DX3lfajkxvf9RLs/95lPFXL0U+Di/+SIfFUfPmcd/cX0Vtj3uRf7Q3siHXMxnlaR89ZdEYJx3O/ZHuh8HzHrVrmQE9ey+HBcyatd1zzLjJXme6xOPEI5cVwUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747641784; c=relaxed/simple;
	bh=lBa5YTZkMvuUtwce6u4tOUSxz48BGhJyHh7YNCMEW50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V93eBxLxLXStIMpR4A1bLMR/B92Yz8uYg54eNLoIS9zKlbjHU0GkSxJXj+e5XtsDoOvKy5Ha9MiLgseehsZNsjXVgnn1S4+I8pbG6wQuEz4YUo5ozBbt450ikUVDqZmGI8nDclE+jlTz8F6Z3Hh/JjJzi4gMiC1RukiPCuPwHq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ju94p8AQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n5vrctMm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ju94p8AQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n5vrctMm"
Date: Mon, 19 May 2025 10:02:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747641780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qn7UKdQC4LHOSIht84R3Mn36AaWF5sKTsoRKuOqQ9j8=;
	b=Ju94p8AQLFfRldxTcs8MVikKtJGtA0cY8PODOeRyRox7osIL8xockLa5SmaVYp5UgVWQpW
	u6zryGvSkzuLh+gEP3rjmrV2B49sN2YSkv6GEP/aC9mWHIckuW1oZQipTpXNkJaf65iX6q
	R7WH1qAgTViXvHC7CBFRc5izFJlifiRTkF3xlip0AnmQIP+AWD9zjhDWvqzQdzVrT2BfKU
	nolDJwFgOsH2mUa/2K0fAtqfT/9g6p4mdp4qfjMcR7nfByvGX0FsyBhw4ArXS+2y5aqFOj
	1nk6RLjJhwOkNxfQ8YUcRuSQvJQZ6Pe02sLPmOMm9rdwKemWomdOGMkwr0KyCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747641780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qn7UKdQC4LHOSIht84R3Mn36AaWF5sKTsoRKuOqQ9j8=;
	b=n5vrctMmY1SzpNnbdlZ4I/P1d/Y+oDijqmTduoFyDj42WLTb4cD1osSx3GjlLE1DKLPYMB
	SDp1hb0tBwU/9HBg==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>
Subject: Re: [RFC PATCH v2 03/12] rv: Add da_handle_start_run_event_ to
 per-task monitors
Message-ID: <20250519080256.kLt-OF34@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
 <20250514084314.57976-4-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514084314.57976-4-gmonaco@redhat.com>

On Wed, May 14, 2025 at 10:43:05AM +0200, Gabriele Monaco wrote:
> The RV da_monitor API allows to start monitors in two ways:
> da_handle_start_event_NAME and da_handle_start_run_event_NAME.
> The former is used when the event is followed by the initial state of
> the module, so we ignore the event but we know the monitor is in the
> initial state and can start monitoring, the latter can be used if the
> event can only occur in the initial state, so we do handle the event as
> if the monitor was in the initial state.
> This latter API is defined for implicit monitors but not per-task ones.
> 
> Define da_handle_start_run_event_NAME macro also for per-task monitors.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
