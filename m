Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EB9389DFF;
	Thu, 28 May 2026 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958876; cv=none; b=GUj6/VrE9ROUydM2qrLyRG8E7FUc0N4u53Y7F3RZhM2acHIqgWtQOlxV8w2bBGrnpoyMQfnm+fjVHEh5nEttGu9YC1xi99z6J7QsAhOGSJX5Ke7Cnj1tTPppLCh9RqeZDLq4r3oCQhmebb7LO+m58NddQ+Z+dGEB3Kr7L0g4FdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958876; c=relaxed/simple;
	bh=/Wq7RzObojSVm4aq32LMpZqfHUFtBaNTPWUxHaD2mac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Egugf8zoOua9yc1Wax8fIP8gF7GuDBMCMOz02NVehH1vtQAkIVy+vMHb5lIA/pUY6iO9NcB/2hYNu9ufG17tsAyxyGYmoNZIpNwyU4/4Hmu09O+kFodA2H9imHoHr6qJ6ebq7d1YbXQcxubLH1tipvkcidW21eKL21tO5l5zdZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D+wVTYDa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O3LE4yog; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D+wVTYDa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O3LE4yog"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779958871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Wq7RzObojSVm4aq32LMpZqfHUFtBaNTPWUxHaD2mac=;
	b=D+wVTYDaPO+r/jyvaHDbYCZAbx3DLABIqftKDIBb53DDV723h92gj3efY+yJh5M2zUQc4Q
	SLCM+FvEeJsY10SfOkRwVN8+cukth0H+4TGtW/mw2C3YFT1whD6uu/ZYNr1vm9BbzL3DW8
	211mPTqfTwJmVNN4iw/3EqUXrvYJEOUdubfcHjbQJmqd8+wa7OvUpZV+G1/sw93vbWs0go
	gUPD3iMURKG8kMSnzDf/+BAZOHBOsUZfH0/s243l7wkIGUCCmO1q346Lltx9W0h1S2FZwy
	YIPmAhEzxDsGva8QQhC9UeOm09f1ICY2gZiV6EnIIcbj0xBWeJpUbzEVZ5emMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779958871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Wq7RzObojSVm4aq32LMpZqfHUFtBaNTPWUxHaD2mac=;
	b=O3LE4yogiQwe/KlLIPy2PUZ413gLH6BxVAhLqxhv2fzVbX1WEUQLFb7cYQZc+boFK+VzI8
	sxioRZ/2491kMhDw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v2 06/12] rv: Ensure all pending probes terminate on
 per-obj monitor destroy
In-Reply-To: <20260527062313.39908-7-gmonaco@redhat.com>
References: <20260527062313.39908-1-gmonaco@redhat.com>
 <20260527062313.39908-7-gmonaco@redhat.com>
Date: Thu, 28 May 2026 11:01:11 +0200
Message-ID: <87a4tjoqlk.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> The monitor disable/destroy sequence detaches all probes and resets the
> monitor's data, however it doesn't wait for pending probes. This is an
> issue with per-object monitors, which free the monitor storage.
>
> Call tracepoint_synchronize_unregister() to make sure to wait for all
> pending probes before destroying the monitor storage.
>
> Fixes: 4a24127bd6cb ("rv: Add support for per-object monitors in DA/HA")
> Reviewed-by: Wen Yang <wen.yang@linux.dev>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
