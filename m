Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D47409607;
	Tue, 19 May 2026 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196936; cv=none; b=Nf3BFGTb4HoygdD9jMgQOP/q7SYtYdUn924tj008VaCny8e18HInnLSwvAj7YFjqDzw9X8bNRfN7eOdA2ICyecdmAm8svv7r7cAfOHVY54MTOwmMb8cB/ZI1436xCr5N+vBH6DXbTqyDDmLEqV7mzSc93/MbKQ+Cm5v7AVt4czU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196936; c=relaxed/simple;
	bh=b/Q7lFSUhC4pTHS1y7a8yosFMMNgxY1dZFLDEfBNUuk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F29bHseQfRTI+8xPq+DcznoQQ2DRkZjcEb/pbtVu/7dqOeusJtSXrW9jZDOC76wQ//Psv2g7RkMPs+Il5vP6BS5Agsv2iY2bJ8mAalC9LDPMB5dTv7/UkyktAdq0YDVc8IIraXUkPEDGWeea6sxLuet6w3LeLlRjK4ohIE6hzKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3qrRudZH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=85bDghBJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3qrRudZH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="85bDghBJ"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779196933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b/Q7lFSUhC4pTHS1y7a8yosFMMNgxY1dZFLDEfBNUuk=;
	b=3qrRudZHtDOANKSgXklPZ+LO3nYbCgq8gfcaIBtXhpTuUa5+lZkjWezRIp8B+g0eUp6Wba
	yfmbY8RZG+Damtxf1UE7A1JrC0+cT9tCCMwqi6S/px2N1DnypeUCvseHrV7mJHx8kx9t9u
	c2MRJyam3w3XQYQGEgVMjFpVIIrn3g1vXDFXSfXnOqhlhZbu20JBPlhUsyzU6t0pw88Oma
	rLFY+mo6o+q+qyqwOkCFIuq7lJ+O1Hq2077AM3SzL3ejTpaVOnXRm3I1zGuZ7Qyy79y2k1
	9Ibydin0rJ+pFLJIb2csZbgeCbQ4EIaZTNUKc5CZS82bS1OL939l0qONPeILdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779196933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b/Q7lFSUhC4pTHS1y7a8yosFMMNgxY1dZFLDEfBNUuk=;
	b=85bDghBJQRkBKZrUOnCuoqpMp0w7uc6jQ/lOLlWU04b6qKmWscNb23S5anMTqKBbVEimIr
	H/Wu5BqxzoiHiwCg==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Masami Hiramatsu
 <mhiramat@kernel.org>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v2 13/14] rv: Prevent unintentional tracepoints during
 KUnit tests
In-Reply-To: <20260514152055.229162-14-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
 <20260514152055.229162-14-gmonaco@redhat.com>
Date: Tue, 19 May 2026 15:22:12 +0200
Message-ID: <87a4tv4jqz.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Monitor initialisation also called during KUnit tests may register some
> tracepoints, this can lead to issues since we don't expect real monitor
> events running during KUnit tests.
>
> Prevent tracepoint registration if an RV KUnit test is running.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
