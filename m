Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CA532B10A;
	Mon,  1 Jun 2026 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298987; cv=none; b=CMG/v7oAdhRBWwrfTMg47h4ripbs6Af1azOq2sz8TZNYciJaw56cMZGvssjizylFg1jq9P8uQjoqi74bPpWcv6WBfHsLkStirhFprCPmx7heYVZ6t6ith22TpuFt/+/oZkpRoQ+MjBCrKdgLkIUPicvZsjBi/VXF2QmXyPXq3Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298987; c=relaxed/simple;
	bh=jL5VwbA3a5kyi5DoHFzlhrW9I5j8FU6NOOW51wx6Zoo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aj8OuDuMEyXAjKprZYjsffVxWZ/wQnfGQRHRfhbom4GmhscG4ZvLbxsXaQqWwqH3ASJGq7ER+LxaKpv50H2kdegPJaPXwYMGIpzGgjR8k+BjgCXhb+PIIqwtc1QckcRPbcE4NHKj4Fym6LLNQlNL0DFHv15NfJ+atRoV7RgbVRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=avGf6QnN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5+ttcjhd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="avGf6QnN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5+ttcjhd"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780298984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jL5VwbA3a5kyi5DoHFzlhrW9I5j8FU6NOOW51wx6Zoo=;
	b=avGf6QnNZSOPanNgwcvIduVar+dFdmTHW/gOgZVR/FwpLACwDaffYWSHLf2EcA3HR9IyU7
	PgEyKhaH+cLC+X2Y4QKIJ5OHjUC/BfZEs3un0atRDy59UEOpvQ0qc0nTfDJj8DK29pMjB9
	m4dHBZb7yVWBcvGA1N5py1Uyl3exV+nhza0JXdR3CKVLkDjsh+oJPjecD7IHd+JcrxdZHC
	jTjBBEmss3gXC3ji3CB2Lps7KAnAn7Uub2BNqRqYqGBNWlSUQl9p2PoJGzxDHgrEkzj6X3
	Jp9NWfc3NxbonnxwedUMROTc5eSuuPRqjMXpSHLirNzsVDaDjDIJoBAZUZcULQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780298984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jL5VwbA3a5kyi5DoHFzlhrW9I5j8FU6NOOW51wx6Zoo=;
	b=5+ttcjhdG14MdoFJVF7YLS3SIlrj9HhrSHgoOgLcJRTXxgo5MgTUnDi7lw92YHFbQbmQQY
	95dTj0UZoiBx3aDA==
To: Gabriele Monaco <gmonaco@redhat.com>, Wen Yang <wen.yang@linux.dev>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/13] rv: Fix monitor start ordering and memory
 ordering for monitoring flag
In-Reply-To: <76628c68336037b0d652456cf2033d3b51399a09.camel@redhat.com>
References: <20260530141652.58084-1-gmonaco@redhat.com>
 <20260530141652.58084-6-gmonaco@redhat.com> <87ik82ycl3.fsf@yellow.woof>
 <76628c68336037b0d652456cf2033d3b51399a09.camel@redhat.com>
Date: Mon, 01 Jun 2026 09:29:44 +0200
Message-ID: <87cxyayazb.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> This order won't work.
> Monitor reset relies on monitoring to be true to stop the timer. The
> same function is called also on monitor start and there the timer may
> not have been initialised yet, we use monitoring to discriminate the
> two.

Right.

> Am I missing something here?

No, just me being confused.

Nam
