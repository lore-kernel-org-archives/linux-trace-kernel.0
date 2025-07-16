Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D5D26E6F9;
	Wed, 16 Jul 2025 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653589; cv=none; b=YIpEEz92/pi77okCDU2rAM/wvvv8sjjE6+s8s3l/EpbRYIShUQa3WICTAymxLiYtZXUtBk3V2R52gmJ+Av3ba/cePrig8zyWjh3iY/WrU3j9fmlAcmCVj8wpHX2XL1J7g2l9FztBci0suyTyefqkV4HIyZYWpUQGyIjkLe8IxE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653589; c=relaxed/simple;
	bh=aOihXmTH7yncbkIe4Ees6jarKx1X0XzbuDg5CfLFqTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aANPLRpT9c5aL1t8hhxvuEDe2K3y9ZGxhk6mXEn4YUhW1ITB+t6flY5HVXO35ZrFtBOKL97lf+BxvifM9ah+PZo/SaHJklqGwKlBJHW//CoBGk6mAat1z0ku569nFEvkMEh2QHMM+wNtxc3E0ZmTsLO/RjK2rPgf5h2lbTIkyvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ALHdnlPO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vd/3AVIv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ALHdnlPO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vd/3AVIv"
Date: Wed, 16 Jul 2025 10:13:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752653586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ntuprN3NWDS6ew8P8I5jWyqGhtVITxHCRT2KIp7rB/o=;
	b=ALHdnlPO43i2wiJ6Pq2k96emYfDZJ2U07xV2u9VkFmGpwmX4ls/tfXCA9HQ5USzwzcdT0U
	lE5CGNHAecvdCk9HCKPAra0JpGsKj9wC+bwXXBv1WubNIOYRY1B2dyqNY26dcId/1kg+5m
	IOzAky4D3sAhayC7Iqc8ajr2kAzg1pqZBK3vGxxhX1YW5Vr5NxViCovD8+TIYQZ7OGxtcl
	Yy92BicnPSL4yIpVvKQQe9tZjOyK+7H8vl3m36p4Q6sxMAI7jLkpihOLW7AtvID6zM4+ln
	9WPlEwmYIbYRemYXnnMdIIp7h5/jKWhljT9epmRZBb30BGwDwnKW3xn1LjG1WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752653586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ntuprN3NWDS6ew8P8I5jWyqGhtVITxHCRT2KIp7rB/o=;
	b=Vd/3AVIvwY/b12I8DVREER2icBnms7s2uGc+RNA5kvEwxN+H94cWKeXfGmYdxq/l/j3/FU
	iOs0RVNUNp572VBA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 10/17] rv: Fix generated files going over 100 column
 limit
Message-ID: <20250716081304.K_nK3k46@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
 <20250715071434.22508-11-gmonaco@redhat.com>
 <20250715150828.BNdFfB8h@linutronix.de>
 <17efdc2b3e206730cfbef410fc89a713da133b65.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17efdc2b3e206730cfbef410fc89a713da133b65.camel@redhat.com>

On Tue, Jul 15, 2025 at 05:24:11PM +0200, Gabriele Monaco wrote:
> Right, I didn't make it obvious in the commit description since I
> thought it wasn't too important.
> Those are the monitors whose lines are going to be longer than 100
> columns later in the series.
> 
> Changing it there saves a bit of complication in the next patches,
> where I only add lines for new events instead of splitting the line
> /and/ adding the events.

Ah, that makes sense. I thought the script went wild.

> Do you think I should mention this in the commit description?

A maintainer once told me that the rule is "one thing per patch", not "half
a thing per patch".

This does make the diff easier to read in the later patch, but I think it
is not worth it. For this case, I can easily review the later patches by
regenerate the files.

So I suggest dropping these.

Best regards,
Nam
