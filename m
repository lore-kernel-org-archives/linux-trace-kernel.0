Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEBC38E8BA;
	Mon,  8 Jun 2026 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907367; cv=none; b=PuamAJlCM4PD0EGS/8zHrs3dbVw9h9u1VH1kFVDuqLZDUHmv+pKzKMUDAFp/LRm3VwZ8p4+Oq+3tdHAoKCoAYuWb1fgFyg6QZmgjzl3o+4W/nB/HGVt38yxePDM3d44nk2QwUSWNZA1A090BPk2UaILeiSo6q8p/7QPCfobl2zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907367; c=relaxed/simple;
	bh=fHrNpyKCgEItOWGb0RKjqg1aScuY/LR0yF3f77Fldoc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ufCcPvOhdRO3yjRvA1Uj5ghR2b/e1OSJHZWZ3EBAmmaycHqMB9D93Cg3kbEsDMhPLnukOSsvqBPlWbizIIOPHJ4E6yp/n1+xkAqEdKec1HnVPYrxNsNYH4Y7X6ucmRpGlCpOC7KvWIpmFuaM/hBfQcqDCczGityb03EtHkzMQxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ADQpidBf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bhrAz34H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ADQpidBf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bhrAz34H"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780907364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHrNpyKCgEItOWGb0RKjqg1aScuY/LR0yF3f77Fldoc=;
	b=ADQpidBfvvwZygKFGbzON0Hoi/66gDoa5Nq5VPMdViGOj1oRbi7OHmPbT1iLk6CGc3i9lH
	m1KKxGZXkOQ1DSdLaCglPtYOHX6XXdXry26KTHVlyjveMXsRMLpEqymua6JKcTy+5i7lLm
	bFBxShvg+e3AzmKtPS8aFj4HKD09VdThslH/7/fHmxHTtVN/zc7B+BxF1FSY8rmMaxCgxi
	8bHR499ssxc/h82whfA/eBg1eW7vPjDGDU39D5NFmyrD+p/dbenCiaz6lK4zGELPy5cJED
	HZ1wdKxCp2Botu1sj9BUEK3mHQffGU5dnwmf74q04k6Nwmszl3yryGpvGgY96w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780907364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHrNpyKCgEItOWGb0RKjqg1aScuY/LR0yF3f77Fldoc=;
	b=bhrAz34H6mgm5KS5Xf2qe1jXB4GJWtvAC4GLiOWBMHZqXB1SeaFl5HZT62jO2kHIIfRwIg
	2m2BxIROtv4HEjAQ==
To: Gabriele Monaco <gmonaco@redhat.com>, Wander Lairson Costa
 <wander@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/13] verification/rvgen: Remove dead code
In-Reply-To: <310e485ce394c7d258e142e14d5e51c5e15e1d30.camel@redhat.com>
References: <cover.1779956342.git.namcao@linutronix.de>
 <9120d2a5987b79b646dde4001381581b703c0dd7.1779956342.git.namcao@linutronix.de>
 <310e485ce394c7d258e142e14d5e51c5e15e1d30.camel@redhat.com>
Date: Mon, 08 Jun 2026 10:29:24 +0200
Message-ID: <87bjdle8pn.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> You might want to remove unused imports (linters should help you with
> that too):
> * re, typing.Iterator, and itertools.islice from automata.py
> * deque and ConstraintRule from dot2k

Thanks, I overlooked those warnings due to the noises from the existing
warnings :(

Let me clean up the existing pylint issues, so that new warnings are
easily noticed.

Nam
