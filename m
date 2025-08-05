Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFCF13E02D;
	Tue,  5 Aug 2025 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754396541; cv=none; b=JvRcCTw8CH9TnNk0pwTXJePIaODwjBNaEAhSOGBgtCeObhqzpbwL4k0qlLbwggGCrmaF+pyooPy9eKhVG8CzYMGpcl3cj173A6waRnwbl1Yzw7HLA/zva0uwOs6jgw7jiQMjTs6rNh/zNzuCiqp32ZGWhpfXtBSNUuKtxGIlM3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754396541; c=relaxed/simple;
	bh=t5LIvOPKCCMLE6CEQIjDBeOUoU9iW3UC8AEn+hRpZA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpEr9rr8W65R0NPV1LkwYj+0M6lOwVNy/HKDvl8kRLInrs91TUuuGiOQBmYTwVK3vOVWZ/7o7l/8MvjzDfQvDcCbkJ4dGy9hJzhhoLYaE5jtx66fi6sxE9gUVxHmOETai6F4DH4+Q9WTfVkmwfspLwhjCo6sCad9xvisd7y7Cas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xqig9eRc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OiFmtDvJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xqig9eRc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OiFmtDvJ"
Date: Tue, 5 Aug 2025 14:22:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754396537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NgSlPXIrxym8VP0mqPSMog5kqh+7STBDgOIav6T6SdY=;
	b=Xqig9eRcWj4/7CpnX2a/Sh0oUDiHxTyKbCq12dVU6bl6R2J+HhaRVxLUcURUA4nJxLczVX
	G1QmWgNAN15w80xxbAvccAGcEYok611Ji7jNJ1CgQifgRo+vL5fHYCF7xas0aZQopLvHfZ
	UcLpkSPjMrUvspj1KVmaio969mGFJtw0Y636GVGlTqTngNHaEgbuvcPsB6aerMmgxrHiYb
	RucHROvJme00sLPsFSk4kF8jyTpiHDZZ53ueoPhXJQxy9FgmLRppsADebxUXY/Tl/CG31F
	T1B9b7WjHbo5ALSz+MYfbXX5aU7YgnP25Nmbyo21DPZ8TGtHyjm4exq0rgYSVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754396537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NgSlPXIrxym8VP0mqPSMog5kqh+7STBDgOIav6T6SdY=;
	b=OiFmtDvJJYNlDS3or/1DTgUWnX94UxnZweSREMzpBRZe2DqV+bqUzP5V4wKUmjMsbgzkhe
	hiVSc/mNLH7bh/CQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] rv: Add rts monitor
Message-ID: <20250805122215.hXbwUchz@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
 <20834b8fcd4dfe75642cec2097e29f4c636a33fb.1753879295.git.namcao@linutronix.de>
 <b3499e8d79c2215b4fb765c0ceb5294f322efa3a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3499e8d79c2215b4fb765c0ceb5294f322efa3a.camel@redhat.com>

On Tue, Aug 05, 2025 at 10:40:30AM +0200, Gabriele Monaco wrote:
> Hello Nam,
> 
> I just built and booted up the monitor in a VM (virtme-ng), the
> configuration has preemptirq tracepoints and all monitors so far (as we
> have seen earlier, it doesn't build if rtapp monitors are not there
> because of the circular dependency in the tracepoints).
> 
> All I did was to enable the monitor and printk reactor, but I get a
> whole lot of errors (as in, I need to quit the VM for it to stop):
> 
> [ 1537.699834] rv: rts: 7: violation detected
> [ 1537.699930] rv: rts: 3: violation detected
> [ 1537.701827] rv: rts: 6: violation detected
> [ 1537.704894] rv: rts: 0: violation detected
> [ 1537.704925] rv: rts: 0: violation detected
> [ 1537.704988] rv: rts: 3: violation detected
> [ 1537.705019] rv: rts: 3: violation detected
> [ 1537.705998] rv: rts: 0: violation detected
> [ 1537.706024] rv: rts: 0: violation detected
> [ 1537.709875] rv: rts: 6: violation detected
> [ 1537.709921] rv: rts: 6: violation detected
> [ 1537.711241] rv: rts: 6: violation detected
> 
> Curiously enough, I only see those CPUs (0, 3, 6 and 7).
> Other runs have different CPUs but always a small subset (e.g. 10-15,
> 6-7 only 2).
> It doesn't always occur but enabling/disabling the monitor might help
> triggering it.
> 
> Any idea what is happening?

Thanks for the report. I can reproduce the issue.

Looking at the tracepoints, it makes sense why the monitor complains, some
RT tasks are enqueued but are not dequeued. Then a sched_switch happens
which switches to a non-RT task.

Most likely the dequeue tracepoint misses some cases, let me investigate..

Nam
