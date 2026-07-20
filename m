Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE63ED107;
	Mon, 20 Jul 2026 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545273; cv=none; b=fuMaf99pZyin3ymXcICF8dzBRLGBJirNUcAzBXXViNI0kiUcMqWYx0eOVlpkRtTW80CDDII4QLrsrHkgMg6k+RHCAHTdUicqb1sOXK3aSZvOH23KyuKSdq49OkR26s7o8J7y0f9CbnZSUf/GbUlwUsKlXCjX8LJjTRa1mSaU9YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545273; c=relaxed/simple;
	bh=ORuM6Jp3w+7dbnUKywAiQ36QcgU82PqIT6iMlJJyxa0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PXNpUMK0hHdYuLU659uM2wJibhfluF348T90NuAN5Y/DTkmdN2lIBLaN4VKtzID3Bt+F53yMuHgMMow/GwhhMhWMo/5Ln511ae0zCOJtNzV3GrHCtccxyo4l9CzdsVecIMgJVats+GoPC28c+Vwtm/XHxPi79cII8ceetxMwgwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MbXOgUHl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pQHxIRO+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MbXOgUHl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pQHxIRO+"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784545270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ORuM6Jp3w+7dbnUKywAiQ36QcgU82PqIT6iMlJJyxa0=;
	b=MbXOgUHl7jaepi2ZjI4Nfw75Hs/oOrNV823RUl0Qv1KsAsHZ9xQ7ti6H+EPAiMm5d3FFmK
	qCOe/aWnh2NwPvQn0y1a+o0FsVjIvN1s28ETZkwS2x+f5juRUPqp0S1SzZ/TclzVUW+RgT
	qIylzvZVuIT+s7e4ksonyhINPiMwwyqAlKWAL6AwwKdWyTDo8LIXY1Zh3sYvGxtaTuXTiG
	lvlE5WHwaXeg+AlKEnj5KDLm5+bcUk99L0HM9RodefgjH/l99oM0YWm2E2zFRpOg/77ffX
	V4QkioI1UmjDzmp7ZDFyo/onrpUl90QJlT7icqV5XKQtVJC21fikGPhYl40xOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784545270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ORuM6Jp3w+7dbnUKywAiQ36QcgU82PqIT6iMlJJyxa0=;
	b=pQHxIRO+7oWlLjJ26w8C0Rnq3B9Vco51OvsRZBoJvmsUuljw8MA32qTIlV2BZGxlJhrN7M
	7hbUT0cYKpxNSzAg==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>, Thomas Weissschuh
 <thomas.weissschuh@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, John
 Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v4 16/17] selftests/verification: Rearrange the
 wwnr_printk test
In-Reply-To: <20260717154638.220789-17-gmonaco@redhat.com>
References: <20260717154638.220789-1-gmonaco@redhat.com>
 <20260717154638.220789-17-gmonaco@redhat.com>
Date: Mon, 20 Jul 2026 13:01:09 +0200
Message-ID: <87tspudix6.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:

> The wwnr_printk test expects no reactions in some situations, after
> fixing the bash assertion, the test is failing because expecting no
> reaction after a previous step had reactions is flaky without making
> sure all buffers are flushed.
>
> Wait for reactions to be over when expected by polling dmesg for an
> interval without any rv message.
> Also simplify the load function to stop loads as soon as a reaction
> occurs, this limits the number of lines to flush and makes tests overall
> faster and more stable.
>
> Reviewed-by: Wen Yang <wen.yang@linux.dev>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
