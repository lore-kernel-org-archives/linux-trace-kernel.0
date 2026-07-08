Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B47409284;
	Wed,  8 Jul 2026 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525628; cv=none; b=i9MX+xtC8urqku3MbjN+74qmZcuji03zFLkdc2KQZg81KNNjXoA3Ui5tL+klprAEHwE/nQbFm17/yD9JLEzM2w82J0wLRNNR3BCnAcdO7tDon0i8Cpi/BHSeaeEccjKC8VrSssm7+yPr+B+g3DNOJYTOafUTDiFSv129A+JxxNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525628; c=relaxed/simple;
	bh=TQx0D02Z+PRrNgZro2fBP+7Yn+sar+Zmq7GVstm1834=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vw7gLSKWL6SEdxOB3IIthhwrF81Gre4PpFY5H2Y/qNmoyQei+bFjdjZF6rsGhwPDWdpXrccMFFjHg2cNKtbf9wGh3lQ3kPtTGPS9ZIygZJiJ6hQspMxdOCDQt8qcDzCp952Eh5ECNxHpJpt5Q1tkB3930v/UJwq7hMznEtWjM2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=inhHpViY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rvGov/ZR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="inhHpViY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rvGov/ZR"
Date: Wed, 8 Jul 2026 17:47:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783525626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+r3lVVVkp4tztQW2Phm4sEVaRiudVwETSpMO7pDfyU=;
	b=inhHpViYehpifhHwSE6qVi5Ait7dUgS0FB1/5S23S7uBw3AOKkcK12DVVBckS0Yfz+Z/xl
	OeFeHWgW3tll9EmVJr8kW8S9PQ6wLky/v+gHu3D4oBooQEja06+iEpxSdMFF6IiRTdgcfu
	10HsDNZqcvr1mcD6eccK4PqNF1pq3UfakD9HIqhWxq2h6+QIYZWpDgZFROQEc//BD3YDg0
	6Uz4120+g8GZF38hH20UnumMwSqxtU+d4WWt14HT+lucYMg/9pne5uV+Sy3SijzADnIRNn
	tToNQTOpWhCKaOLtk58etCPsLSzWUBEKF9QJORvh/y4IYcGDxC7S22+NToL1cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783525626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+r3lVVVkp4tztQW2Phm4sEVaRiudVwETSpMO7pDfyU=;
	b=rvGov/ZR+bs7Ng878vQ4wpiPKcT/+ajnXt1ofvc1WZlow+YyqmLVLQU2UN/NgekgLXsPkI
	45NAncocYciKcmBw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: wen.yang@linux.dev, Nam Cao <namcao@linutronix.de>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rv/reactors: fix lockdep "Invalid wait context" in
 rv_react()
Message-ID: <20260708174123-e5f98837-3d81-43ca-8ede-bb5f09e8ffba@linutronix.de>
References: <cover.1781541556.git.wen.yang@linux.dev>
 <bc01343ae74acf6bdf142434aeaa4e6b40aa72a9.1781541556.git.wen.yang@linux.dev>
 <20260623112942-4943fc6a-c1d5-4eed-a91f-66b3a034caa7@linutronix.de>
 <3c53f741559f834986e976b524c5ded90bbd5627.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c53f741559f834986e976b524c5ded90bbd5627.camel@redhat.com>

On Mon, Jul 06, 2026 at 04:02:08PM +0200, Gabriele Monaco wrote:
> On Tue, 2026-06-23 at 11:38 +0200, Thomas Weißschuh wrote:
> > This now allows reactors to take (raw) spinlocks. The original idea was
> > to not allow that as a reactor can be called from LD_WAIT_FREE context.
> > So I am not sure this is the right fix. Not that I have a better one
> > available right now.
> 
> As far as I understand it, LD_WAIT_FREE is fairly impossible to apply on
> preemptible code (here we see it hit by an interrupt).
> 
> Since we kind of have to allow raw spinlock to avoid this (even if we don't take
> them explicitly), why wouldn't a reactor ever be allowed to take raw spinlocks?
> 
> Technically it wouldn't be wrong to take locks from RV monitors, although most
> monitors don't do it explicitly.
> If we ever happen to take the wrong lock explicitly from a reactor triggered by
> a nasty event (e.g. sched_switch), I believe lockdep would still be complaining
> down that path, so we probably don't need to be too strict in rv_react().
> 
> Obviously we don't want to disable interrutps for LD_WAIT_FREE to hold either.
> 
> Am I missing something?

No, I was just very confused.
Let's go ahead with this.


Thomas
