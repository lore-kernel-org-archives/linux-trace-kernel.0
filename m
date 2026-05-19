Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46AC40960D;
	Tue, 19 May 2026 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197083; cv=none; b=uFfmQxPEEErchGnbRIZUeMKUlwgnUOGlMqUfoZpVv8UNMYXSg0/5aLEDvpGurBKGyOwMeN5XwkmAb8/xE7+ic+awqjOB9fChqcJxHNX6KMDR6wuBvUqxmweUhYt+ZyT7VvmOkAjYDfwpBPSZz0NxVVkwOJjBGumd/bYfuWms8Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197083; c=relaxed/simple;
	bh=1a5RcHhqO+tpCaGBfG4gLuwIpQpEnwBv9y/s2KiDLIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M9EjGPS+a7JwmmHc8NEl8V2VlIvuyQg/G84HfGvSfKZ+uK6C4Eh6lKUYnE+f26MqAnx+m/sO4huizslOBxQdLFX+i7yqT7xQ1AAQA00c8773KaPHMtrBHrCYNAMPvRl1TP6xvojSoZjnr+YUouklPjtFQYyJk7Zu3Kn4cAXTxdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NIDLnTO0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vEThtcBi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NIDLnTO0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vEThtcBi"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779197081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1a5RcHhqO+tpCaGBfG4gLuwIpQpEnwBv9y/s2KiDLIs=;
	b=NIDLnTO0oXOKltzrH+PJv16q0SUvXUaMftxzyPYkp2xR6nPSVkSOKssQpGT9IAZSQ25TZe
	ESMUGSVaKPVksFZ2R67c6E/Fv3sikteYvpvJ6oIJ1+BYdK3dfOLB3vAcZ6P8PNuC81l3Ou
	jEb8xPuYZZB7XvZerHfCTuGlSrIqMt4Vtukvs42genDBESVnho3p61P5/mWN0LUDVJMwC2
	PIvRdc8ZUNV1NIVz0AJhLuS233uu48M+ajwPEUvqcsyMFTnjB9IZbNTQ1c3pjndluG+AZZ
	1Qflxf7B6j/k7Oe5vp4MInJQ+VZfGTfSpv8jQB2w4vcKxvuLvc2MgxOSv8hIYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779197081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1a5RcHhqO+tpCaGBfG4gLuwIpQpEnwBv9y/s2KiDLIs=;
	b=vEThtcBiV6aFR0ieGPciAOntz29VCdC7yqwx8xQa7bXGaDKMx/WNaU3hT1yHrEgKRIG+u2
	g0D5M4cDmp6iI9Dw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Masami Hiramatsu
 <mhiramat@kernel.org>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v2 14/14] rv: Add KUnit tests for some LTL monitors
In-Reply-To: <20260514152055.229162-15-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
 <20260514152055.229162-15-gmonaco@redhat.com>
Date: Tue, 19 May 2026 15:24:40 +0200
Message-ID: <877boz4jmv.fsf@yellow.woof>
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
