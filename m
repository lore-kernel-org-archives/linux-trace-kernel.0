Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61E7314D35;
	Tue,  2 Jun 2026 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390325; cv=none; b=aPxlhlQyp+kVmUlJ78Yx84xJaESsBxxc6SVvbpgswt+KmMPIFD9+PsKhRhYwOMvzqBgEDYdUWmyXNIhd0w81uPZiui0V4BZhbp8AAT9mhUJq1oard/q3LukES76jpK9V52EajiPIJcoGN+roNWXVLg26PI2wXOcFvKJ8RfCck5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390325; c=relaxed/simple;
	bh=4vG0wb7DAmioJW+3P4s3kX5fqij+PBk7BlftL09F7Hg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d0UdSDOjXHj5jEnVZX9vGoaWYsw1GU+Np/iQBj2n4NMcWJBhxC6bU0abSecztj5BWII3q+/RFs8cjregeXigCV0wRVAWyBlYHQJ8BsOO1jIkMKDURptGP3+ywuYTXg3dXtz6PXquUl1/HRbzr0ructsul4pjRkPvQsRThyzb77E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qEjk/LKv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hs/crJl/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qEjk/LKv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hs/crJl/"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780390322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4vG0wb7DAmioJW+3P4s3kX5fqij+PBk7BlftL09F7Hg=;
	b=qEjk/LKvQ9c3IzEVCbmYqOclT2OeA7jlZaireHHpVp7pijMu38ItqLyQHw5H8ymX/huiaD
	1cweh5oatCTP+VOA/t5BvDyWae0ivltrhqy1rqiWppcp8x7WgC8LZeyVeXHUASVXpN0N+2
	e3nlNZUNJFuUQlhBEWM63xBH0usvr23kCKUH0c+TDbEKKB0z8GFPMfLr7zbLdc4j6Tq34S
	jk7JGDNkY4hSxPG4SNpvRsDYsEUYTGm/4cnCaOzc5P+U+DO5fMig/pu7v/cxUn0hCZ3D1C
	xFb+FaUwSJfHxNPPZMgdn3cBCKpqVM3sDwS5ODVNmEjDgmhY43Ja54N5jI+Beg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780390322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4vG0wb7DAmioJW+3P4s3kX5fqij+PBk7BlftL09F7Hg=;
	b=Hs/crJl/Uku0CpKhgPnSn6aplNc1EEJJJkg6+eKCJRoXpBPDW3NESaSu291LanTMET6hnP
	QgMNAh53b3TspoDQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v4 06/13] rv: Do not rely on clean monitor when
 initialising HA
In-Reply-To: <20260601153840.124372-7-gmonaco@redhat.com>
References: <20260601153840.124372-1-gmonaco@redhat.com>
 <20260601153840.124372-7-gmonaco@redhat.com>
Date: Tue, 02 Jun 2026 10:52:01 +0200
Message-ID: <875x41z5n2.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Hybrid Automata monitors hook into the DA implementation when doing
> da_monitor_reset(). This function is called both on initialisation and
> teardown, HA monitors try to cancel a timer only when it's initialised
> relying on the da_mon->monitoring flag. This flag could however be
> corrupted during initialisation. This happens for instance on per-task
> monitors that share the same storage with different type of monitors
> like LTL or in case of races during a previous teardown.
>
> Stop relying on the monitoring flag during initialisation, assume that
> can have any value, so use a separate da_reset_state() skiping timer
> cancellation.
> New monitors (e.g. new tasks) are always zero-initialised so it is safe
> to rely on the monitoring flag for those.
>
> Reported-by: Wen Yang <wen.yang@linux.dev>
> Closes: https://lore.kernel.org/lkml/d02c656aada7d071f083460a5c9a454363669b61.1778522945.git.wen.yang@linux.dev
> Suggested-by: Nam Cao <namcao@linutronix.de>
> Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
> Reviewed-by: Wen Yang <wen.yang@linux.dev>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
