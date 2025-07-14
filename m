Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ACF1DEFDD;
	Mon, 14 Jul 2025 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752497460; cv=none; b=shSgm5GFdog7t8p5W7QVt7lPj6X/B2j07opM75SO/DdEAjw1La6xiqfKmmN+8c20fydStNCF2Ugs6Y4/Gwf5XSn4GuOHMsB5eOBgNpW3duOgPBzWD3+djRQ7IqlDC5aWqexhMR+itCbM3QyUtgKFldtV07KSu+rmPcfpt9nuBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752497460; c=relaxed/simple;
	bh=Kklq/eaOD0KAugS9lJAdNxyOy5yPCLX/ILc7zRrBCYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npL8nd+qRmZBeTGvVPIzDp8QC11CjWJRKt8dPSl6kgKR4MfaVXy7Er24omehIvKqrhIZLTeQa6ncIbadOACwZLxj5m5/I1IxAT+gD1aC3rPdz/vUTHJvLSfAQpz2PzFecqE7oCQcOOKv7uHiCPxfPzkgZeophfPefmpAX5xc7ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nOMqeveC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2+F7ANaK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nOMqeveC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2+F7ANaK"
Date: Mon, 14 Jul 2025 14:50:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752497457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UByYrp3x6mZxdvTZRCl6jvDHHYPXIGCclFcqAZKin7Q=;
	b=nOMqeveCV6IiMqHShSXUp3JTHXBaDwtAYagtWoJTL4JI08r1t++2XKqjU2qu7F9EfF5CZO
	xKmJd1OKpCqmkUwwojb1iz9dVTAYWx0zBQnO7lguyun2lNdUdS5wN3L+OVUNsALBfB51U7
	befDGcA+zLJ/cvl40sX0nJ8nt8zdS2qvZOwt6lvp+UhCYLPsL+7mMzsk2B1L+VXe4s7vLJ
	pRipKXly2a5SsiFXyRZcpg8th27L53oY7QoDEhzWa3myUmS1cACbrfyhCQWQFZLXbh8G34
	jha7aV7tj+xZKv6clyhosXbnM6ou/lFP1BKoCRgdS0u/wrGGu9pK5GTkhJWP+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752497457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UByYrp3x6mZxdvTZRCl6jvDHHYPXIGCclFcqAZKin7Q=;
	b=2+F7ANaKe1hROiTwWnGr0md+qoqnnF/AwuGzGGSDt6VZOhYD1TGZ4n2OcHOQqiElBVHAX3
	BJOQ1OJ20Pmtd5DA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] verification/rvgen: Support the 'next' operator
Message-ID: <20250714125055.kqp3dNm1@linutronix.de>
References: <cover.1752239482.git.namcao@linutronix.de>
 <9c32cec04dd18d2e956fddd84b0e0a2503daa75a.1752239482.git.namcao@linutronix.de>
 <7f4409eae10023a804d24ad2a9c67d368db152cb.camel@redhat.com>
 <20250714124208.qVXvUVqp@linutronix.de>
 <20250714124802.kjqjNWmr@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714124802.kjqjNWmr@linutronix.de>

On Mon, Jul 14, 2025 at 02:48:04PM +0200, Nam Cao wrote:
>      RULE = always (((not SCHEDULING) and (next SCHEDULING)) imply (next next SWITCH))

Btw, I think this "(not X) and (next X)" seems very useful. So we could
define a helper for this, perhaps something like "rising_edge".

Nam
