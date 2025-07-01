Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7172E2638A1;
	Tue,  1 Jul 2025 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751403826; cv=none; b=omDfz15TI+3kJj65NnBBeOBgumRBruBKPy0sIY2Twoh44JQdM0Wl0G2nmxHl8Le5oS+VYmf/MLR09pSXB9PWz6/OZhQ2r0UZg9/dc7o+/3xGAONiHFDrDWHBB3gfGOmme5mCL5vB/SZAIuLjFIlkjuEc/mClifCrfJjDRD3Q55k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751403826; c=relaxed/simple;
	bh=jy8MSQgUdDYILNyNwRBueO/xU4Yp29YbIn8zxzsO5aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYUL9NfWq5JBikz5tHWrKk1s7ZrmGHDPbH8/kBGs7tntTDDLa0mPyjTgRFEHFh1GPdVm2Q8FJQSv/8IbIaHkO8E6OxAEZCqz4k8c33n9UBrfOfjxpZMctUpWYBDbmz9FacqHWz+0U+g5vU/yvz2r4VU8gPOKJtf2sf4L9Um72Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Othi/RQH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fTuI8mku; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Othi/RQH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fTuI8mku"
Date: Tue, 1 Jul 2025 23:03:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751403823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1h40M3VjawR1ifryGour9mmf6PVYa6xTSb2ajwg4Xbo=;
	b=Othi/RQHcWCD3+MaatleVqEYHCn5jQDeLzIVcWHsa9CLfvlHpOCvEuvjdwNHbCEPiZ0sct
	UtMNoM0jnRRf02yMVWWuKyXdU3DSUuZoaRTbohuF6mXXgrz4q72mX4JJDNQIN6CaEH8Fhe
	i5Ao23SLfH09dAfp7DaSqC80XYatOJlBFtL7IRKK0xy4hnRrWk43fEnYnTkSmjCD+8SbyR
	JY25Cb9Dx2Ho+6X616QNDIvJVThJhBBW/txbm7c1+K0gXkruEZjvwhHNMIwEDm8FZ9EwpU
	BNhFmU/2yKmFtHZTdchXNWrVbgOEpCTL7A1lYJ8vgNHVfFxLvQA1kuh88atb5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751403823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1h40M3VjawR1ifryGour9mmf6PVYa6xTSb2ajwg4Xbo=;
	b=fTuI8mkuneuxKcK4iHXJoxU8+0R9pmaGykkY1JKclwi2Y2oynC9iF5yYuHu72cmlSRXZK8
	7gdwGDc5kO5xmUAA==
From: Nam Cao <namcao@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v10 17/19] rv: Add rtapp_sleep monitor
Message-ID: <20250701210338.BooVbo54@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
 <d3cf55d3bf42a0f70a58c394b5cf6d603ca8a9f7.1749547399.git.namcao@linutronix.de>
 <20250630203401.1a11e58f@gandalf.local.home>
 <20250701051757.mBjQVdoo@linutronix.de>
 <20250701110218.5e742850@batman.local.home>
 <20250701110551.5c2dc2ee@batman.local.home>
 <20250701151114.OJQTlRCY@linutronix.de>
 <20250701111704.00456667@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701111704.00456667@batman.local.home>

On Tue, Jul 01, 2025 at 11:17:04AM -0400, Steven Rostedt wrote:
> On Tue, 1 Jul 2025 17:11:14 +0200
> Nam Cao <namcao@linutronix.de> wrote:
> 
> > > There's nothing in the code that even states that this was generated
> > > (if they were).  
> > 
> > Yeah this entire file is generated from the LTL specification. I will add a
> > comment.
> 
> Yeah, generated code needs a big comment at the top of the file on what
> generated it.

Sure.

> Bonus points if it shows how it was generated so that people will know
> how to regenerate it.

If it's okay, not in this series. It requires changes to the RV core
script, and I prefer not touching things which are not LTL-specific for
now, unless necessary. The DA monitors and the containers do not have it as
well.

Let me stash it into my TODO list of RV cleanups. I will add this for LTL,
deterministic automaton and container in one go.

Best regards,
Nam
