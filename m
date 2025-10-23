Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84FB2FC877;
	Thu, 23 Oct 2025 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761222988; cv=none; b=J4FUtc17JPVS6bFx3H0zJZEzd/Uhi8oj2Fvcu/0k1dDwtkDvhGL/0vaYx4ATuLRP90H4RJg41VYa/cfI5UjOcCWqDWilTTR20Fi0PMy9aU/NOcP/+9VXLHXIwY8qeNdtVYQaXyAVqLYdCL3KmU16TWdP5AnlSeIkDm7HbxOl8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761222988; c=relaxed/simple;
	bh=wL029px23LcuF+PEqQGGzhIBQn26jFMyBzToOXLt8FA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bqhgISCxbcOLvKAcnP0v+LSrkQuhNpCjhVVCJcFAh9Zf8HMTFW3vp83QChJWzK4XH8fmrm6fPVtr6S2tDo0GhKveT+iFPgHTJbH9rvayMwwlbjZvW30n7ZmWvCe9UiDw6s4Sn+lsy6NW5q9JWrttz0RhCCPuyRWbGH+nrK8URU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sgOgoerk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tDSs+czi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sgOgoerk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tDSs+czi"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761222978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wL029px23LcuF+PEqQGGzhIBQn26jFMyBzToOXLt8FA=;
	b=sgOgoerkAGq5R+LbHrQRj1cVTV11nouvIpAi0UsSn5UA1xOxsqvOOqFCaKaRQ+w9WVMJkL
	HLWVCwRcis/QxRsmnyJe+pP30tfSU2C7KdWw8++tyUBexuDP3AF3jx+8jUmnxk0V42vzY9
	00fsFR5ymiFSe4CYzpq+zFLCeDX4eHXXeXzmzESyVmYkYf5c5REYBk+SylzhQ0TOWAi2KT
	MsORFCAtDNreG3x9jyP31LNnOJsnm38kchscjaRF7XZvHJBmq/5Kb40Q9+20xAzCeHpMrZ
	sIW4WnX64xIZI9uzK9D5cy4+AmdpKSqdQg4oMMKhCcHczWTAJjvP184p9n4X0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761222978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wL029px23LcuF+PEqQGGzhIBQn26jFMyBzToOXLt8FA=;
	b=tDSs+cziUpZFjzOr4kJ4WbYEWreMtePZyKgNT+nh3Dn4OGcHo9o5Q8gpNlybXK9Q0JMlDf
	dFYERXSGLTwETRDw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 18/20] rv: Add support for per-object monitors in DA/HA
In-Reply-To: <866f10440f9edde8acd34e5a5d2965719ae5d723.camel@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
 <20250919140954.104920-19-gmonaco@redhat.com> <87plag1nb6.fsf@yellow.woof>
 <866f10440f9edde8acd34e5a5d2965719ae5d723.camel@redhat.com>
Date: Thu, 23 Oct 2025 14:36:18 +0200
Message-ID: <87bjlxokvx.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Ignoring the vagueness of the name, the two implementations of this hook are to
> call an allocation (yes, always conditionally) or just assign the target to a
> pre-allocated storage.
> Your suggestion of da_monitor_prepare_storage might fit both descriptions.

Now that I have grasped (or at least I think so) the patches, it is not
that important to me anymore. But still, having function names which
precisely describe what they do would help new people understand the code.

Nam
