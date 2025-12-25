Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A0F4C6D;
	Thu, 25 Dec 2025 01:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766627490; cv=none; b=P4xXAiSPytqenLzZEqee6zzBEGkk0+vL1jpDb4XCDNX6rY4XKnAPvp8mWgoU4RixOFF4+zUX3sWElXrUf2RKM2lb3TzJiBc4TXpUYUpQL+kcf1CECyZX4aSHQm+mvOm0XZtSagXP1JFGoRFm+5ZitTOIaLC4hd1P+fNHxzKPYRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766627490; c=relaxed/simple;
	bh=TnqNiplWwPur8Ti0jZCCoV7THZoKMpjV1jKGzE1rsbU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h0PrPTX1W3ykUJC0EhQqKU3Ee5lLb80QgMiwY5pLGe4nm0PFNW/1yw2YMOcAixdCgvUmzeBgLviY7cTXcTzy+yJwx33VutRidgYcixTy2VNPNifMwQAAyMsdFfEMBzziX8SxSsj6ibK+NOa12KX3x7N0t7CRMMq91bEj+9/SCMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pysjlxPP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RZbVvenC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pysjlxPP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RZbVvenC"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766627487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UNf/RJ458kBSSMz1o/513Y+78aUqVfAFqahZeOAzkDk=;
	b=pysjlxPPasfKxb1rTinb58WUZehnvyFUEM9GVdTsT/hLP9oryALFDBA7/u15BtapIdfSn2
	75OuO/Bq4RU2Q3vrFvo589C+2hAqPhDMX3Eu2CUFXvhPmJRdOY60Blpg1R8tZSw91zKe6D
	YZq4UaRkw+57wX9ofRffy5za1TdbQg07v6rd86N31UA79GzHKD30nvL0+OjXBAglcO1o/f
	/dpF4nLnN/Ku2oHJzeYKq4u1v1tma9h1zTx2wlPzMDqH56Xu+9InQFituHK3VPs30FXvw2
	vdCxjbNKOxHQtkvVl+/+auhxyD5B4vXjD2WdATZJO7FPEaOGcKOtR5AEin9mcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766627487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UNf/RJ458kBSSMz1o/513Y+78aUqVfAFqahZeOAzkDk=;
	b=RZbVvenCCZrWlS8dCmx4zBcq+jUKRRwVrBnKp/efME2DrrQazauyT9vyPSfwjsHw5Fq74i
	ZF+iaXTH0p7SoAAA==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 13/13] rv: Add dl_server specific monitors
In-Reply-To: <20251205131621.135513-14-gmonaco@redhat.com>
References: <20251205131621.135513-1-gmonaco@redhat.com>
 <20251205131621.135513-14-gmonaco@redhat.com>
Date: Thu, 25 Dec 2025 08:51:22 +0700
Message-ID: <871pkjba79.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Add monitors to validate the behaviour of the deadline server.
>
> The currently implemented monitors are:
> * boost
>     fair tasks run either independently or boosted
> * laxity
>     deferrable servers wait for zero-laxity and run
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Same remarks in "[PATCH v3 12/13] rv: Add deadline monitors" apply.

Reviewed-by: Nam Cao <namcao@linutronix.de>
