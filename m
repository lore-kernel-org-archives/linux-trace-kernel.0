Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98A4500955;
	Thu, 22 Jan 2026 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093914; cv=none; b=KhrCzA78AWa+KtykZ1wKyMJgH0arHAslDaeOZGfET6+Cql5apSG24lROn3VErgLofXdMqoxxFYlftlztNPb8i1PZyNfa8KihqFaFaaRB0gktIzSa3s/3vaGHfXUb9OL/XyFtmowlYj4K6HtRy/CeGDGkSXtSlQU8P7yQwRjBPT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093914; c=relaxed/simple;
	bh=Y+I2djq9M2XZO2FkIPzuZ9fM05+s3ydoe5qGOJ1pCC8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QEmIGLJa0OZSIni0wSwM1cdf+0Qtq/zY07Du+RaLJjTjqDBgLWbB63fqoKJLdG2i/yKvVGFC7265jzYhvuL17p2ZpH+h1rL181QQeeLvCmymmlTbet12nVP6kjEVttJ1WNePXtwssIonFPlrsZDImI2bUJkdJrkX2n0evAjrnzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Se6MhBJr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WBq4TtGy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Se6MhBJr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WBq4TtGy"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769093911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+I2djq9M2XZO2FkIPzuZ9fM05+s3ydoe5qGOJ1pCC8=;
	b=Se6MhBJrM7XSD79clrstgIkeYIyQIwZWMNITnUWp4QCm//4zm+9py77fnE/3ihjkpbKASt
	NAdKfpk2SucqeCmgXkeO6KFdZ6U/5L8SG+ju+Web547gC83TPuN4alEPG5+Iyi/+kL3+H8
	rKvrNL8U3oYi6qhQCQquR5uilLvIzsw4UepU27+TZMBCNVled3EpjeiosUGwKW9GNIA0Lc
	JkR4W+QSy0cOMW2bL1aj0WUvSlkbUzQGraFZkkElLA0C7KttSdzkSg8SLOVR4JuPVwpq98
	1AxUrgIgSZ2Hqi9GiDjxWE3j9P1w97/bT5Q4/efRGpON3xU4OIJ9Poj/7FgonA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769093911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+I2djq9M2XZO2FkIPzuZ9fM05+s3ydoe5qGOJ1pCC8=;
	b=WBq4TtGyYXTiT/8KxHFRAIrrADbk3mjsdrQf+1/YshPlgFVxs7OO8DF/vIPmdYKHOKXVyA
	qi0BPP/WgoifNcBg==
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Wander
 Lairson Costa <wander@redhat.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/26] rv/rvgen: fix typos in automata docstring and
 comments
In-Reply-To: <20260119205601.105821-11-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-11-wander@redhat.com>
Date: Thu, 22 Jan 2026 15:58:30 +0100
Message-ID: <87pl71itih.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:

> Fix two typos in the Automata class documentation that have been
> present since the initial implementation. The class docstring
> incorrectly stated "part it" instead of "parses it" when
> describing how the class processes DOT files. Additionally, a
> comment describing transition labels contained the misspelling
> "lables" instead of "labels".
>
> Fix a typo in the comment describing the insertion of the initial
> state into the states list: "bein og" should be "beginning of".
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
