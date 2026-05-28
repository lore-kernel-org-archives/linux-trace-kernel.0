Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6063812C4;
	Thu, 28 May 2026 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957785; cv=none; b=VIBZaHl5duvjE1sHlCfM/U0c+UhLW9VlYDKR46QzOEFtbuHm2+gCP9BvuoL/eIEud28mIfX0zxy2o2HO4NE7rZb8BDKUMai+K6uB83xAv69twEOq1Ex2rUPSxwmWlZ2EpD9qPVizpGJy28Sv2Go8vkiWU5EI3aXhL3R7VvJ+Fio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957785; c=relaxed/simple;
	bh=j5RKj15Knv7gB+tmSJNEVDkK7qZWfNTPe0prChR28Rk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X+32dXLapHiPoEwfDUDqXKbE7nA+FimtPCsqUk6V3QYH1Hy1DBV7t6q0tUWh91e5eJSD2AiWmuTNsHo8u735N/A0M9KNUFyNYcrFGVUhaxje6qTwjZ/x1N1W8Ocd6NF0VGsVpyYLe9yTTHdfxsranMYNnJ4WWA0/JN+EF6pRuwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m1z0QbAx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/eR0JxP6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m1z0QbAx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/eR0JxP6"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779957782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j5RKj15Knv7gB+tmSJNEVDkK7qZWfNTPe0prChR28Rk=;
	b=m1z0QbAxr+O3F7dxcNDkA33Hjz+prEOY3/Bd5/TS11clmfagE0DHDA0495Q/u61fwxnLCK
	aVJRCP/3K87yK850G98u86f46AsBgYuun8ldhtYHZ50FEUXedzGJYINt623dwN3a3jSrwz
	lwqab33D454INqln0L9c+Jd4vjBfHdss3RIbBG0KZESTzVp5xuMu4k6k4j8i964oHRhwRx
	ldOYU9WyaI07f1A+DmFjp+dOV5zEcePwNa/QICGBQJxMVLjL+vtlpuIIVnKg+wi/tUmWzF
	4NJYwxnJboQ5XZdoTZK5ekQr95+6sZmrSwIGR6dS5xsHf9olIBE6jzJz7meJ6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779957782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j5RKj15Knv7gB+tmSJNEVDkK7qZWfNTPe0prChR28Rk=;
	b=/eR0JxP6cAjcVNHrUqoXfe+YyTleFBVgJnjYakQNQCgaKwmDvC0VLtY9u+9iuaEk/Aopp7
	xvd/DFS8hcYY6lCg==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v2 02/12] rv: Fix read_lock scope in per-task DA cleanup
In-Reply-To: <20260527062313.39908-3-gmonaco@redhat.com>
References: <20260527062313.39908-1-gmonaco@redhat.com>
 <20260527062313.39908-3-gmonaco@redhat.com>
Date: Thu, 28 May 2026 10:43:02 +0200
Message-ID: <87ldd3orft.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> The da_monitor_reset_all() function for per-task monitors takes
> tasklist_lock while iterating over tasks, then keeps it also while
> iterating over idle tasks (one per CPU). The latter is not necessary
> since the lock needs to guard only for_each_process_thread().
>
> Use a scoped_guard for more compact syntax and adjust the scope only
> where the lock is necessary.
>
> Fixes: 30984ccf31b7f ("rv: Refactor da_monitor to minimise macros")
> Fixes: 8259cb14a7068 ("rv: Reset per-task monitors also for idle tasks")

Fixes: tag "indicates that the patch fixes a bug in a previous
commit". There is no bug here, so I don't think Fixes tags are
applicable.

> Reviewed-by: Wen Yang <wen.yang@linux.dev>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
