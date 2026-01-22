Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E810A30DD11;
	Thu, 22 Jan 2026 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093437; cv=none; b=pOBNCA5cVJWgPCGaHP27qM6ppB7wN0mbl/kyBCE1k/vCpP6/t3siWX6kv8gZtV6iIKq6lMMMc7Xp85aTDNCf8kS6eyauE7KVfvKClr38THQNfYuNvn9RoTzS66vjrYjCMYcKkC2mswOSMCPMy6Q3H0HF+fgn07uUpiLwcSvv1eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093437; c=relaxed/simple;
	bh=JnSjNg+GRuLdMx0lVoqyZh4e0ETTGhgm3A0FCvcPkVU=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WU1GfYoYg62jmNMKdcO+92k5KzN+wGJnzaO4vMD3q169TW5GW6ECOeCD9Xnsd3Mm54QyVWLeoIHjQDGgLwE9NFeZiMO9RAM+qN2IexlnfhjLm/nEMQI6qK3SjcGahfeE3Eij1DvlCRvQYDuwTET9DFP/YYhCoFDqY3NySLwwi08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iZyvBgOY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6ev4tS1I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iZyvBgOY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6ev4tS1I"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769093434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JnSjNg+GRuLdMx0lVoqyZh4e0ETTGhgm3A0FCvcPkVU=;
	b=iZyvBgOYSENY6+6jsD6neSMJ6OP2sLidQIrtE3wlGa0dI3pYsRKgMJnPDc6Tm5350SrJsU
	OnJ90txG+FxxfF5HXfaWzZgPjnKhJUtCfzYI9V0M+mOG44gvnnl5hhkkQBuv3mKTIv8P2/
	UwP9gohAB8+pTo86DvzWmOQya3tcIpq1ysLmvGB8BVuTDrhoX7VjMlf92T8Uz0w5mBwRVt
	ye/IipEzFrZLFnBDP7Fvi9PfdqdR43H8Wp6DTx2GDbt0V4vRh0BjmNvwNmVJrNSbUJNnnU
	abf4gNOBRlye0+ZTEp2+W8K7kq4trXboKvtk6+LztHSy7ZK4IaZgjID801LiRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769093434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JnSjNg+GRuLdMx0lVoqyZh4e0ETTGhgm3A0FCvcPkVU=;
	b=6ev4tS1I6fHvc2sicSHfLv1o4z2ajfRA8ryJg8u0ik7vBUtw0zpBXjWlJDH8rKicTHbbtI
	M1nhQsNVC2qdEGBg==
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Wander
 Lairson Costa <wander@redhat.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/26] rv/rvgen: use context managers for file operations
In-Reply-To: <20260119205601.105821-7-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-7-wander@redhat.com>
Date: Thu, 22 Jan 2026 15:50:33 +0100
Message-ID: <871pjhk8g6.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:
> Replace manual file open and close operations with context managers
> throughout the rvgen codebase. The previous implementation used
> explicit open() and close() calls, which could lead to resource leaks
> if exceptions occurred between opening and closing the file handles.
>
> This change affects three file operations: reading DOT specification
> files in the automata parser, reading template files in the generator
> base class, and writing generated monitor files. All now use the with
> statement to ensure proper resource cleanup even in error conditions.
>
> Context managers provide automatic cleanup through the with statement,
> which guarantees that file handles are closed when the with block
> exits regardless of whether an exception occurred. This follows PEP
> 343 recommendations and is the standard Python idiom for resource
> management. The change also reduces code verbosity while improving
> safety and maintainability.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
