Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FBC3859DA;
	Mon, 23 Mar 2026 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774256768; cv=none; b=hZTtGuuyk7oLETlhntal5XVu00JzRNJk4eOS6nek1eTRBVb780eNYRTIAj8Gcb7dGK1n5wGBhsvH9UAt2vkFcZzqGtZFnozSioLEW1jci2+2I86W0gzClsrqa5w7B8GatxZPNxhyN90woHmx+0mCoUoS0ZVXe6jlv0ZHaVni16c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774256768; c=relaxed/simple;
	bh=L+ScKwnZH+fuxaso/Ph5wgI39yuzO8z2JlBFqqQe2OI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=juA+KYMsI52Y1zJT8Gqdo4WaSMhhgvufxLVYuwFLOhW9ZAIz+F1jD0F302ZLVCRkPU6bOkuRndULyFvRmBM3GUIZMwfTLXO9GKgMyfDB8erhDiSmIj2sHZK0e8oJytT0IIKcwX49iP3Uu7h0m7sKXn0EZWemBIVQ+pTiNtmMDRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ekE/Px0Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZfD6QqHF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ekE/Px0Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZfD6QqHF"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774256765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+ScKwnZH+fuxaso/Ph5wgI39yuzO8z2JlBFqqQe2OI=;
	b=ekE/Px0QGHPKONcm9mda/BH78Yi7PRPMhI9xI/8qa15QkRQu3hMUo9/rJk06JUAuCKmhaU
	Y6EEW4b/EOVhbqpNajpqygwXEfJWjeHdfO1Caw1NwI2ytiMPpQ6gPfatd49S5rZlTMorAs
	QhPdK4UvS4r0s3W0QNjsl2mC2XSs/6lPr3r7XzhdfjJL4VJBLhCxPPI6srHK6/v0M1yBZD
	T8wv3wh9iDWa8wOFgYiA2yNEQIrB3lk9i1RKLG3xAFpt9Gcn4FSHglNiPJ28VvdMZOUqkA
	ZwAdS2QABYOG/Cn9Hg/jd1CM2u1DwXXLb6EHRmfVTA7WV65XaoxpNLV4BZufXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774256765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+ScKwnZH+fuxaso/Ph5wgI39yuzO8z2JlBFqqQe2OI=;
	b=ZfD6QqHFuJ69lDp5zcRN9ZRoa2poebXropMIE6Gw2Xn6wONkPuMZLcQhh4h5SZ7fCSUhee
	SCCACK6KaCNS73CQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Juri Lelli <jlelli@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Clark Williams <williams@redhat.com>,
 John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v7 09/15] rv: Add enqueue/dequeue to snroc monitor
In-Reply-To: <20260310105627.332044-10-gmonaco@redhat.com>
References: <20260310105627.332044-1-gmonaco@redhat.com>
 <20260310105627.332044-10-gmonaco@redhat.com>
Date: Mon, 23 Mar 2026 10:06:05 +0100
Message-ID: <877br2hq4i.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> The snroc monitor is a simple monitor that validates set_state occurs
> only when a task is running. This implicitly validates switch in and out
> follow one another.
>
> Add enqueue/dequeue to validate they also follow one another without
> duplicated events. Although they are not necessary to define the
> task context, adding the check here saves from adding another simple
> per-task monitor, which would require another slot in the task struct.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
