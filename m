Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036292F7F11;
	Tue,  7 Jul 2026 07:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407890; cv=none; b=fXMtdiIUxsWs7dJd2OChm4TY/45s4c8jzYd7dg4k/dunQWWdTf/fSoPoXrRDf1SgEhemxuUHKbyOvTsnSgCkVIUhtAUgKsXG5Lw9ah2QGsGXcoH8MK0S+tdBSyIyevJp2z3jJ07XsHesebVGMRr2gz0gabnxqvw+dxTR/7jEIPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407890; c=relaxed/simple;
	bh=1a5RcHhqO+tpCaGBfG4gLuwIpQpEnwBv9y/s2KiDLIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FvAgHYC+jcpf/WnkwhA3xQE1MeK1/a3B932ZqaAiJxl6Brwb5hSD7HOhkDAIwJjGHCEgoDymjeeneQo8kUH8tF+aX5ulVQvMzfBBnbpjTo5hbwi9OFOxAQR0SYqfYWqnkZ3bO/Dz5LySZNGlFrZLx/kvoIHB6mQeEGeZ4RfQ9Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l+P711Sa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QeJg+RlL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l+P711Sa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QeJg+RlL"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783407887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1a5RcHhqO+tpCaGBfG4gLuwIpQpEnwBv9y/s2KiDLIs=;
	b=l+P711SaT4fzYca/LD5WDGSxjx1kJuTD8COLKNg+06vHgD/31ZJnDl/FC/K1Ec7buOZ/Xb
	y/HRZ+s28MU4+2F2H3tzEoW0YJtfcLDMo6Y6W/3I6pbBdMymH3xl41JUMwFqCDEFwY5afF
	yFMI86aRFc/8M0twkv2+hmsKWJYRY4OoKAaHpDvBdqzmhtz3BjLhPMXW+m8+GeadsuF4wA
	QxP9gqoqfuNGJkez0BdXOv4AV0pk5Mm1MdgTN5kZ0DYNfQEEdqguvUzu9+PWqS+8q0VWv6
	V6LmZfRGcPJ+8PeLhYnucUNZd2U5tDfoGTDy4eolVR2+jw68NOJ2hx+r2c3AsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783407887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1a5RcHhqO+tpCaGBfG4gLuwIpQpEnwBv9y/s2KiDLIs=;
	b=QeJg+RlLSzTTqHFd7Zl+j9NA6cXhSzO8uk35HzYWTqdk3Py9k45NjjQBtVmg0qQkGWu295
	mZCyepoMkwW/N5Cg==
To: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v3 12/17] rv: Add KUnit tests for some LTL monitors
In-Reply-To: <20260625121440.116317-13-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-13-gmonaco@redhat.com>
Date: Tue, 07 Jul 2026 09:04:46 +0200
Message-ID: <875x2r2sc1.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Validate the functionality of LTL monitors by injecting events in a
> controlled environment (KUnit) and expecting reactions, just like it is
> done in DA monitors.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
