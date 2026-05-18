Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F337D104;
	Mon, 18 May 2026 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092480; cv=none; b=J3JKmOG7FPt225uSP+oKiVUxA7+L+fDhl4sKpHJv90gRZJIQraEtuFhf5XwOwyZqT6ktgA7+n90EMK1DCtZV7YxGDygiTrQcCEdcEGisN+h/ap9zr5IiUEsMiy/YCwRpGgd9vz5SKaoyx50WhDCPDrA9bJ9DpwWnyx9lXRrXEKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092480; c=relaxed/simple;
	bh=2wqs66teQEi1P1l8h/afvlswt+m64zgyUtlQYadrR9U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n95M2tXE2UFpCGngEVm2h7m+YDHXe3OGj0RGJXVnnGGHpJV/etEGCkox15py/lGvHQkcIk+qu5hYJlmXf4W5IFyWneGjhmJEcNwuYvihMpswcxFTSMZA5Aw0b56VUAhik+XzMWD+Bmbpf9Zk80vQQm80CTyA4IBieyoZGTX7sQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Erg8SZfv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DKObvj0v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Erg8SZfv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DKObvj0v"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779092477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2wqs66teQEi1P1l8h/afvlswt+m64zgyUtlQYadrR9U=;
	b=Erg8SZfvyq5mLotbpJxjE6ln2zEbEaLBXQ9OhShUUfyK2d4uaXWLJiyq2XfUhprkO67L1m
	9rvu9Xy2SuDIye87ohUqqSnOz6qSPY8lJ13g4qNB2FyGnVayHnNpSJKuBHLn8W8Tu4FEW+
	AE8Dy01fDbMQpnB4+9WvVPp6LNp3cPQ48DCNJysVZJ5yfWrn39UBsY/6YiB1d4NR4TuL0n
	YN82LOFMNixro3F0/lgUrd88BuBA4goo0MnPxAIi5V75/TDH2tv4VOXa+Axo3rbOMGUYbv
	H7GnwUReVeuoP+bX/ZihDNwNRyp9NmxpxpX2xjpjyVnVRF8/vMuR5xgdkbY2WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779092477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2wqs66teQEi1P1l8h/afvlswt+m64zgyUtlQYadrR9U=;
	b=DKObvj0v9M3D196T3OkHFmMW2xNpTCRCBecDsuGId75sYl3cTnZfIyN+MiP6uMIqK/lUR5
	CA/nlRFqiDCByLCA==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v2 02/14] tools/rv: Fix substring match when listing
 container monitors
In-Reply-To: <20260514152055.229162-3-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
 <20260514152055.229162-3-gmonaco@redhat.com>
Date: Mon, 18 May 2026 10:21:17 +0200
Message-ID: <877bp186wy.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> When listing monitors within a specific container (rv list <container>),
> the tool incorrectly matched monitors if the requested container name
> was only a prefix of the actual container (e.g., 'rv list sche' would
> incorrectly list monitors from 'sched:').
>
> Fix this by ensuring the container name is an exact match and is
> immediately followed by the ':' separator.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
