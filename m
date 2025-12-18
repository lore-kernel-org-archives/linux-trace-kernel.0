Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B000C2BD022;
	Thu, 18 Dec 2025 07:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766042830; cv=none; b=e3ztI1SJr6f+MzJNlmVLC0t8vxZA3/Oqz82P6/chq9/OTPatu5S2ZMbuV8jx47Eov11m8gshZP/j+sRR50iNJ2TiHC5up+cjflpxYO9aSUxPj0rSkqmSeZUzTus4wjEd7G5EFNRKXPU/aRIZGD6ucXyscuUAkDl5edemeVDuTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766042830; c=relaxed/simple;
	bh=clT0gPjopYwAtuLFyuWHjiWCNEFAAA9F2UKMovCyEGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CbaUnjcNGhqiF/sgONDzgg+pFAeDHDOiTnyzOE8WsSeXk5MPOXrwZfb+t+QxexXw1ldU3dzYMOqci341lC35PqA6X1OUCFEC9s1C/AL3aSKXPwvr17VQIzi76FJyNplZYZCsAvIr4QruoL/EiUceXQYX53kHg7c/ijD9d3Zwyw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o/I/+iuK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nu+8E0k2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o/I/+iuK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nu+8E0k2"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766042825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=clT0gPjopYwAtuLFyuWHjiWCNEFAAA9F2UKMovCyEGM=;
	b=o/I/+iuK0TPWWOvaVafIcusA+Wb06kuqop1YhiRAz1TDglbswVpg7aAjLnXPec4YjjtD+K
	P4oXx83Si7UhgAXcq9+tmbACm8DUJRMePfqBDMRMO+OSDM0V6a4v8hoPF/3AYka7t1/EF6
	OPFmQtjiqHeUtSlj1Q1oTgwijF8UcUMVrwDV2ak9F3cEkJE2fM5q4jJ0YyYYUjw5Qy5kGG
	nv/SdW74aU80itDGBMsEJshWm3ZKmNyNJTIuR/rDqOZVH3NUeVjxQfM28a+jnd5J2vZ9u/
	6gIxkQVPglbUJHKbQwdQoDaTyaBTS4KIKZlHapaHHOG2hMO3GS0EAX7h6sjZXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766042825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=clT0gPjopYwAtuLFyuWHjiWCNEFAAA9F2UKMovCyEGM=;
	b=nu+8E0k2yi2+m0ny4sx+AxDCPTtzLbh6ADMA6JnJOPwN9BQYzUbq7ihBpJGgyosOpV+rC3
	RXvx1HJPJD4o5LBg==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 10/13] rv: Add support for per-object monitors in DA/HA
In-Reply-To: <20251205131621.135513-11-gmonaco@redhat.com>
References: <20251205131621.135513-1-gmonaco@redhat.com>
 <20251205131621.135513-11-gmonaco@redhat.com>
Date: Thu, 18 Dec 2025 14:26:57 +0700
Message-ID: <87o6nwi726.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> RV deterministic and hybrid automata currently only support global,
> per-cpu and per-task monitors. It isn't possible to write a model that
> would follow some different type of object, like a deadline entity or a
> lock.
>
> Define the generic per-object monitor implementation which shares part
> of the implementation with the per-task monitors.
> The user needs to provide an id for the object (e.g. pid for tasks) and
> define the data type for the monitor_target (e.g. struct task_struct *
> for tasks). Both are supplied to the event handlers, as the id may not
> be easily available in the target.
>
> The monitor storage (e.g. the rv monitor, pointer to the target, etc.)
> is stored in a hash table indexed by id. Monitor storage objects are
> automatically allocated unless specified otherwise (e.g. if the creation
> context is unsafe for allocation).
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
