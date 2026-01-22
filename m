Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F25431AA92;
	Thu, 22 Jan 2026 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093470; cv=none; b=MpnvYw9NRTtGJieGbNhghrm1VJ/oGc2KBzhAUrl27N3BTkWYo55eFeX9aHNa+8JJhw20bDlrjLZQSZLzzSL/ttnMmIyhPrQU/LF7mF5LoQ0c5xEecLp+qWBI6EQM+oEjT5ZU4bCbgHYR2ShMsZj5pLs0Awix28RbkoaOiAmfx+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093470; c=relaxed/simple;
	bh=AJGvPAamRzVw5wCx9QJXiAvDqHzhOG9BK0WA7PPxqzA=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pEwyf1fGtQPEk3QN28jw9ISEVXiCzbPmZug/S0qhJ0jltZDR0u78/a4mkIT37u9aeBALPdbk2UqLSxUMJBde9OskkK09IYcY8unJ86ZwhsFIGOcmphT6M6NWGFyjTptnSuf+jBleLPZKqu4SlN5NfciOsh5XGpnqBnjyozZek2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I/JL6Nix; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3OS+P/pc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I/JL6Nix";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3OS+P/pc"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769093461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AJGvPAamRzVw5wCx9QJXiAvDqHzhOG9BK0WA7PPxqzA=;
	b=I/JL6NixTG01eYj7bFcLoIVOGK0hk/pC3l3dtoMXgY/n5ViUvzzqKADukpBDWG/LDIgy0R
	LZTruct3yzdfOYghjaJo3KqJVlS3Mu4en6nNHQbqwAiBymFHI9PhwrDLjazQk+4Y2H85Nr
	PcGh1JH1ELwBnhVn1+IuVs5cpfvDSzqCNLoUwNkOWQTRt62k4lENJTLgtQBaIJNAr416u5
	dav1CCkH8rqNrsguCXRj+IeWJcvrR7GqKvnBevuSb/4D97nMs+GBFi5fAzRGeJtg9iY+pf
	hgKLWj+nYGeghwt7XbVRBnPM3HyDwVkHYV3/YSJ84B/R+XxGJU0q0P+lwYDvkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769093461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AJGvPAamRzVw5wCx9QJXiAvDqHzhOG9BK0WA7PPxqzA=;
	b=3OS+P/pcCcYA/FHE2pk4MkaBqfihDFBtcg3ToOvRiRDKARMidDngz3vVcBJrJxHLJ4hY25
	bjJBw+HQg4cllNAg==
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Wander
 Lairson Costa <wander@redhat.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/26] rv/rvgen: replace __contains__() with in operator
In-Reply-To: <20260119205601.105821-8-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-8-wander@redhat.com>
Date: Thu, 22 Jan 2026 15:51:00 +0100
Message-ID: <87y0lpituz.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:
> Replace the direct call to the __contains__() dunder method with the
> idiomatic in operator in the dot2c module. The previous implementation
> explicitly called the __contains__() method to check for membership in
> the final_states collection, which is not the recommended Python
> style.
>
> Python provides the in operator as the proper way to test membership,
> which internally calls the __contains__() method. Directly calling
> dunder methods bypasses Python's abstraction layer and reduces code
> readability. Using the in operator makes the code more natural and
> familiar to Python developers while maintaining identical functionality.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
