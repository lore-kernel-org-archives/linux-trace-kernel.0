Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CDA2288FE;
	Wed, 16 Apr 2025 03:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744775726; cv=none; b=CPhk5C3D2LS5wEJmqf8FwUN3Pet06qfaqO6knZPkinxnCrqGxK/cMT+ihjqRZJCOI1ka3qYNwQ7iDBSRgc5En0iaa2fvXL5sLAAkqFRs2SNuWC4MAGmez7Sf1/hGmsReK79aFOwmIhMUCPzNDk61B40hJHDgOLfNk+w37wP1E1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744775726; c=relaxed/simple;
	bh=2LDHgZZY4QAjoLBXWMfleK+g+ifD6TRzoMqJ5IoR2zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8KBtclkEyNthsVqPrjLhy5jQgd2X11XogTwgVrw36F7krU2ghdowVHa5iucyOxjMjsCadLX4tA/rZAQsHY6qho9OAiyVa5uoKVIXcPNkzkiOeh/zBKf9ihfgUJpYWx7WCktr0VKS3Rq8IueKopfhppdm6gttCaGSdY6kBiZYkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mlC0FuQj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RJTGDVh0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mlC0FuQj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RJTGDVh0"
Date: Wed, 16 Apr 2025 05:55:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744775721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2LDHgZZY4QAjoLBXWMfleK+g+ifD6TRzoMqJ5IoR2zE=;
	b=mlC0FuQjz3reL2hQtpYB3XTFT5YBtyKxLNfJCZcHl0NmF5pnhauqSn1TMCsyL2s80wlFJA
	lQNUq2cXi2GwpkTPWyOj74gguF538tGCglbRKWQNgPL+Ni7CJGFxrTi/4lOgGERr6Y93FM
	tSI6LFphgOEPmFMgp2nA5C0vKIU11XebPnXxqHFwL9Rh0eDVRt92mJA6TdAQYaVoD6F15B
	8Ck414u64v4JAfF1hEloEX5oyIv32jzURLWbIQcKyCSwpnDRVZVTI2QPeHvm5i8GRwc8d8
	AYgprRtpdj//qhycLpxtf6hHx1zdDb7IUceorQ3vECY3jemJur9v7mNFJ32yYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744775721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2LDHgZZY4QAjoLBXWMfleK+g+ifD6TRzoMqJ5IoR2zE=;
	b=RJTGDVh0C57MlAwj+5XDkfqAJksUasdOdY1Ev9PUwZLlF8LvTmvM1imn6CnawJfbDygbRA
	MVHba6JnHL1+9FBg==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v2 13/22] rv: Add support for LTL monitors
Message-ID: <20250416035520.2FP4eY4j@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
 <5dbd62940b252ee49777e9c4298eadd644bf6526.1744355018.git.namcao@linutronix.de>
 <63d8320abb309ef649780af44d14b9d993bab697.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63d8320abb309ef649780af44d14b9d993bab697.camel@redhat.com>

On Tue, Apr 15, 2025 at 03:22:09PM +0200, Gabriele Monaco wrote:
> You probably read a lot to write this, do you mind adding a brief
> Reference section for the curious reader? Asking for a friend ;)

I actually learned lots of it during university.

But I certainly can link some materials.

Best regards,
Nam
