Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1E72EBDF2;
	Thu, 21 Aug 2025 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764982; cv=none; b=a1GW3SUcmjRk6uF+5enryicgtsdpgaknQgV31jvcL0grmc0vQBrlnZBVu58OYSSYdpDA8qoRWsaVc9B0S7dYJOSnDY/1ix2iWCnJeZHH7WQcLb52an+j5QAUh8RHZXTefbvsXXecN2Ym/uQb64r76Py7mdvpKkAVCeTHz7ZY0tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764982; c=relaxed/simple;
	bh=qeH/44xgmh7UTvpqjs1ERFB3mJqhjDNOsc/8kYrsL5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyv1TJpO4gOCTvWmnmVVPIbb18syIn2+7B7CUJjJKy8u/wOPYhtY6tXk0nk7vG9orn3dphpfoGUn4DKVszecf6LZw38P4HoomV9etom8WpB/cXItIIBvpxZpFIjmGDa6omf7/M4nGAp8rg8kebHadv9mVDuOG9iEYBrIKnW8hBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3pes1td2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vOJYWIfP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3pes1td2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vOJYWIfP"
Date: Thu, 21 Aug 2025 10:29:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755764975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RHqXSy9Yo0/ftQFCGD/3Jerj0n86od19SEGINNpq5ko=;
	b=3pes1td2VIcTDBPtlAL85tELatk6o853Mzzv1YqHu2kRSxDkzQkEf3sKreFs0b/UfRt1UR
	GBLD6zhlUOtkO5gbSSwyabSqUpiTQ0VhUGHHlRGwkn6ok+U7vFpzdYu7oyG8sElsUfsfGi
	YL8eqj4A0WE5peTRoitvnw2VAqMmr4pt99iCzSpjDFb/esH6Aimq8W72AkKWY6HDGadRZf
	4PhVt1gDaTCzCfrqoapjRSjT4aEyhoR1t+Y5Pz1uqw/HKGFLqgv131JS7Iv1YKTqXRVzf6
	8m5hf90MH68uh3lAjJtD4vhCSVJJ5ylkwsQqhvSNtbwbGG7K6y5fR3fjJWeSTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755764975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RHqXSy9Yo0/ftQFCGD/3Jerj0n86od19SEGINNpq5ko=;
	b=vOJYWIfPO0SMwH627NkSxflYuqQPezwmIvV77lrFlme38mReaWPBgbjI0CM6pK701y9cYs
	yUAPz3D+FqCLgoDQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 05/17] verification/rvgen: Annotate DA functions with
 types
Message-ID: <20250821082934.trGZCw9D@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-6-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814150809.140739-6-gmonaco@redhat.com>

On Thu, Aug 14, 2025 at 05:07:57PM +0200, Gabriele Monaco wrote:
> Functions in automata.py, dot2c.py and dot2k.py don't have type
> annotations and it can get complicated to remember how to use them.
> 
> Add minimal type annotations.

Nice, Python is sometimes hard to read because the type is not clear.

> -    def __get_event_variables(self):
> +    def __get_event_variables(self) -> tuple[list[str], list[str]]:

This annotation is wrong. It becomes correct only after your later patch
(verification/rvgen: Add support for Hybrid Automata)

The rest looks good.

Nam
