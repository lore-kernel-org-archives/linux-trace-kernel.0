Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71671E833C;
	Wed, 16 Apr 2025 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812950; cv=none; b=qv6QxgQNmNORcdKatYDFjhgbxogHL7EaDnrh6vFKxJlKHgGCxryDoBxqkHjkoNFJ0Gdughpd/bbeMhK7LL68FWFzcOAaLRBDhMxzihOgQN6rmhKTYdK8Pjgm8kf0h5SzYLnAFJINFD3Cs6cM19MgQLeQanJ4FKPStnyFZ81PDdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812950; c=relaxed/simple;
	bh=XWSWD3Hh/tntoNYRf07aCRbUj7b9Xm1lzCqByLbkouw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmDf8C9Lv3eWqhgZbfvvY7mI48r1/bRqmlvA8I0dRB9dPTSqx7eN0MuazO9F6i+zrD/Cgi+OQn0pmoCdGawCeZiG7lLecr2/m2LjPCQU5rypE1Z+orZDHa9scqNeWVzjQMhPfVQSXI94MU6KZTS50oYJ7O0GTgZAaAAqoWgxwMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eNH1/i2u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aetIJ4Wx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eNH1/i2u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aetIJ4Wx"
Date: Wed, 16 Apr 2025 16:15:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744812946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PjwyR6RoBQ47hcc66CotDLU1CEMLdhjxtSJjr7YOz7Q=;
	b=eNH1/i2uUmKccXEvdgXn8RdBTNoI9WiKDgwHtNEayY/1uiaYj8QpB7OzYew2oFwB17GPSK
	gcOgVrGPoBAyDABJA0dmrnV4YuKe97H/IPjy5+e2KjUZCWt1ecC0DGl8EBXOPig7mf8Oqv
	YMOLNuZ04ySr8Bw/Rag1faEd5ADdx/i3dEwaFfbxHb8rKbCAc9PhcJo/0SO9KyDClKzoDH
	LDV63rhQ4WPegGsNKTnKqamJoh+FoCNWVGvzEmtmbyVhPfMnPwL0cQoO7pdIiLG/oE+Po+
	2v+Wq2GX5MGBqE5f4IznOMw3hLjogQuiaclnWuVS5iUF/xQZjcfYjSwWd36YqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744812946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PjwyR6RoBQ47hcc66CotDLU1CEMLdhjxtSJjr7YOz7Q=;
	b=aetIJ4WxxOd5GV3Z+10Bb0jIAj7ZcmkRnN2065nq11vMTF5B6wSwnlOYfWwCix3yVjW8Ge
	Qp/PHEBdyIvBZ4Dw==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v3 13/22] rv: Add support for LTL monitors
Message-ID: <20250416141537.4BSynZv8@linutronix.de>
References: <cover.1744785335.git.namcao@linutronix.de>
 <19f424c910bfa0f4854117e3f8771aeb6e98a9d2.1744785335.git.namcao@linutronix.de>
 <4edad1940b2d05f1997895d4bbc11f02a921e8e5.camel@redhat.com>
 <20250416115658.AkFAts-B@linutronix.de>
 <48d405e1271ac4a2781df7ddcad443b93365c6ef.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48d405e1271ac4a2781df7ddcad443b93365c6ef.camel@redhat.com>

On Wed, Apr 16, 2025 at 04:13:18PM +0200, Gabriele Monaco wrote:
> By the way, no matter what you choose, just make sure the function
> cannot get stuck in an infinite loop (at most it can fail and tell the
> user to find better names).
> 
> Just tried the current parser with a simple monitor with states SLEEP,
> SLEEPABLE and SLEEPING, and I couldn't get through.

Right. Thanks for the tip!

Nam
