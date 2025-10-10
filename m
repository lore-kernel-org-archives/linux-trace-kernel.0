Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DB71F63FF;
	Fri, 10 Oct 2025 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760098337; cv=none; b=kEdqEwNo/w5La6dmblPwn4+dzFLs+F7n9v57/XpKOExNnVKdppHk865lHl//H3Zb2cMyInSorWqFl8vyFJIeBASN8IzXZOXkw2fyRWn912lNH4ThcD4csEaR2tLBh5GNkaIWm/QLvY1IRSylD8hPmiDktxaBZvyHHGdW2IqAShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760098337; c=relaxed/simple;
	bh=dbCHzhJqjQbavP7vJkxUzAhA45knn1zjhLs+4m4r/q0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fIYS6lWcnzj/+yoPTOThuCdk6uaQoRvR60bNTE/+Pic/cBJdADYfXorTaTCwR//Grvv1Dmr5aSeW8jnD2bFY0oWmbV11ntW32dyVmwuHBaDFfkD2baovjK1JooldHOCgTi4fjDlQAfUXOkCc+WOTB6oJHlLTPczKU3Vovns5m20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uBqKlxqz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+bWx8mme; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uBqKlxqz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+bWx8mme"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760098333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbCHzhJqjQbavP7vJkxUzAhA45knn1zjhLs+4m4r/q0=;
	b=uBqKlxqzZthHxmGyenIQ4h6B8n34iQWNzYNd2mPHPldfA8CUotTspNUiUBJVxyyfLcG6IX
	cJGk1pZQnS8zNiVYvT3Wzjuswtdue1BTj+f4c7lPlIA2kayGVfqQPBBi8R8PkwSZwhNlJZ
	hVRvxada7EeSxtHywP8NyQEjSHTYZxMvV4Qb39QcJ4mIZ+PmVls7cFYu3ikh6V9J89dc0p
	bJGMd/qb7Li1OFgHxDieUDjMyg5j2rAGPa+9ubSWDT7/xa/99qVHJv9mshm60THlhNT2fG
	mhimf86hM4iQ9IuEvyCdTwnQGUWo9erwPSUidKQPGdiyxNbkot0yE9Q+Tx7zDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760098333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbCHzhJqjQbavP7vJkxUzAhA45knn1zjhLs+4m4r/q0=;
	b=+bWx8mme/IJR9plmjdj/rjGCP2E7uuvOm1ey62WgwleG+5D4cLyMtHPk9lcC/1YKsLoPjw
	K35HZqqB97fZ4XAQ==
To: Gabriele Monaco <gmonaco@redhat.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] rv: Add signal reactor
In-Reply-To: <2536a7777eb54ede40a335fa4204e87301b13040.camel@redhat.com>
References: <20250919-rv-reactor-signal-v1-1-fb0012034158@linutronix.de>
 <d0aaaf1f47f0d948b60b0575e179564e3c024188.camel@redhat.com>
 <20250922162900.eNwI7CS0@linutronix.de>
 <ced1cdde298d105ba2d789e4e4704caac8dec518.camel@redhat.com>
 <6a5fde33-b3e3-44e2-8ea5-5f4cf350cf35@linutronix.de>
 <87ikgxqrna.fsf@yellow.woof>
 <3c55441187b869b5bb07b74ef88c10bfd51f9fb1.camel@redhat.com>
 <20251006115555-9822f5f1-fc9d-4d6a-9735-274b242e0eba@linutronix.de>
 <2536a7777eb54ede40a335fa4204e87301b13040.camel@redhat.com>
Date: Fri, 10 Oct 2025 14:12:12 +0200
Message-ID: <87o6qfx8f7.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> So if I get it correctly, you are both "voting" for removing reactors in favour
> of tracepoint-only error reporting.
> Am I getting this right?

No, I just do not use the reactors much myself and wouldn't care if they
get removed. But if they are useful for you, let's keep it.

But I do like Thomas's proposal to build the reactors on top of the
tracepoints, so that they are decoupled from the monitors.

Nam
