Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467FD34FF71;
	Thu, 22 Jan 2026 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094082; cv=none; b=ow7R3zjrM01pV3nzrR36147LRvOlDHxLpImQKAFNuRxAFzSXei4JIluuh7aUYRzUkk3oTBmfK3SkJNIB8fgvH2J9Vj1C0j0MS9OFDic0WQFeuL6GppC157/WkYgam7PRKE7vr5zoK52N43vAnscfJ+k3kTb+jT2Dydi3pkt7iHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094082; c=relaxed/simple;
	bh=J9O+s1ZYKPd6ZrqrBQq9fadQoiuFBCG0oPsHrACtiNc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ntYNv6GG5ZGZlQNkRiALocPJZLfaRWGvry7nfSNcQ6eWaFQmHLtPNBdyN9kawCiMwgftAkz3fLsZcn29CKeTVKD+MvRTOYXT1A7Y18peRlIm5bU9ZZTd5HopC5nq1atxpG+ettJLY2rmn38Z0EUdFwBtpoXnron1+WhPZn3FceA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J+g/Tfva; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XwySP3sa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J+g/Tfva";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XwySP3sa"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769094079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J9O+s1ZYKPd6ZrqrBQq9fadQoiuFBCG0oPsHrACtiNc=;
	b=J+g/TfvaNZi8aDTt4i5178MEDg2nYrF2S8dMTrjOGq99jjppSHE0YQvUe2Erpi4P9zI/oB
	Y7GV6XUr8s3APkeORQLqI8GegdveIuBF7s0Ihbju38Rm/dquDy+W4uL/8z8SiPaVRYXGKa
	29GQJnwhY247feKUR2IZDqInmlnA0bpAx+YAq/uWS8i+ghqkZVrJBRN5imTmTaE4bVPTWD
	T99j0pvW0nvJIUEGGvbYesZdRXQA9BCzKIh/PlRZMP2/LKat6L8c6b4dtUSfOJ/frsiN8u
	ky18Lh2xGhHtf70S9ZfXT5bE8kbTUkTpKAzprmiROPBucutdAUT3l0yHLLd1lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769094079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J9O+s1ZYKPd6ZrqrBQq9fadQoiuFBCG0oPsHrACtiNc=;
	b=XwySP3sasm597N/KhxT2HlVqZ6SKC59m9WaStV66tTp2kFoKOgWfHofxlLhjPR7dlKyOrP
	/1EqtoBFHduG3/DQ==
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Wander
 Lairson Costa <wander@redhat.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/26] rv/rvgen: fix DOT file validation logic error
In-Reply-To: <20260119205601.105821-14-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-14-wander@redhat.com>
Date: Thu, 22 Jan 2026 16:01:19 +0100
Message-ID: <87h5sditds.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:

> Fix incorrect boolean logic in automata DOT file format validation
> that allowed malformed files to pass undetected. The previous
> implementation used a logical AND operator where OR was required,
> causing the validation to only reject files when both the first
> token was not "digraph" AND the second token was not
> "state_automaton". This meant a file starting with "digraph" but
> having an incorrect second token would incorrectly pass validation.
>
> The corrected logic properly rejects DOT files where either the
> first token is not "digraph" or the second token is not
> "state_automaton", ensuring that only properly formatted automaton
> definition files are accepted for processing. Without this fix,
> invalid DOT files could cause downstream parsing failures or
> generate incorrect C code for runtime verification monitors.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
