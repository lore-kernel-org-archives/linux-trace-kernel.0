Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E12A2AE77;
	Thu, 25 Dec 2025 01:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766627921; cv=none; b=SdhgUxAynrdpVr0wyCeHyZMC4ct+ldUGeczyx3x/iJiNnJ3r5DlGwrpFNrdLC/MzPMUW0VQwnHzaWaOdQOXebsIB79grlJE1fZHth0nEVYLBsEgXvalAkmw3Lg8BHYtiF88rA1XdL7/xGZm7nY9Rqce0iEsvcCNGuNFLVYORxBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766627921; c=relaxed/simple;
	bh=cSgpRn58DIq4fKSFYEMM5/3lQQzQWwBboEkLcUWGLcw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BmIsfcrwvEqCeYK8n2vxEI9Rq3eodlrJS0p8yc+xd8IPQ+SLh54SIDCUMhUyvCNDPrqMpZJx8fDK2Z5SS3pNmC3mVvZ5rgnyVZGoxSBYQlMO9MeXNNqUWgOftxy3MyiS2SdGlJjtbRShiiuXR4v+pJNw0Ul5uCnigQuvLhKSd9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MEdYoOIX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6OiZ2Z7T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MEdYoOIX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6OiZ2Z7T"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766627918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mV5CI4HfRcgYdJZ6eNoVxIq7fNmtl3uDYapyUywCf10=;
	b=MEdYoOIXOp8BH+YTfpyIrIvXZk75bisGkE3+VxDdlFC1AOYuxxaruzPA5BArAsMY/J5Spa
	KxRk35fxruFKhKt9M5yE6Aatn1j7oCzgpLaMaJMr5IhRMeZcrhVamce7T9LygODZ1bdzdn
	seylP7PXwhhZPmgwDdvUPxleuE0J5e5QMexQ7Xb2LzNlkxezUlGOGWJVyOxcgcsitGcBp+
	c3nM7h66s3TqgDtKoN+9oxrI4eRyYuR4OU3eA5rRNaBiZlwlB1SgWBRdBzfQ0psOG2CKRn
	a22z3eMw6lCUo/ehYKINwDOPo3c5RstskQMG5phIAF3FQLBBgwjWBajGcjzFOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766627918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mV5CI4HfRcgYdJZ6eNoVxIq7fNmtl3uDYapyUywCf10=;
	b=6OiZ2Z7TIkbeICJPvQzzgpQKl3wWNVDwrrVFiUlCNGiXCrSB/ppYtrDiyJLXxAHEImletI
	/MKo+3sYXuLk50DQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 12/13] rv: Add deadline monitors
In-Reply-To: <874ipfbay7.fsf@yellow.woof>
References: <20251205131621.135513-1-gmonaco@redhat.com>
 <20251205131621.135513-13-gmonaco@redhat.com> <874ipfbay7.fsf@yellow.woof>
Date: Thu, 25 Dec 2025 08:58:31 +0700
Message-ID: <87y0mr9vaw.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nam Cao <namcao@linutronix.de> writes:
> Gabriele Monaco <gmonaco@redhat.com> writes:
>> Add the deadline monitors collection to validate the deadline scheduler,
>> both for deadline tasks and servers.
>>
>> The currently implemented monitors are:
>> * throttle:
>>     validate dl entities are throttled when they use up their runtime
>> * nomiss:
>>     validate dl entities run to completion before their deadiline
>>
>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>
> There are some helper functions that I am a bit uncomfortable with
> (e.g. pi_of, is_dl_boosted, dl_is_implicit, ...) because they are
> relying on implementation details of deadline scheduler which can be
> changed. So ideally this patch should have an Ack from the scheduler people.

Think about this again, perhaps we should move all these helpers to
include/linux/sched/deadline.h instead? The scheduler people must be
aware of these functions, and maintain them. I don't want a situation
where the scheduler people make changes, and something else (which they
do not know exist) breaks.

Ideally, non-scheduler code should not look at private fields of
scheduler's structs.

Nam
