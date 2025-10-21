Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDFD336EF2;
	Tue, 21 Oct 2025 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048015; cv=none; b=YD87wRmIitIDemeK8ye09CzfX5HpcEGVo5tQEAYuOQ7T3wLPxEgH9cdBLJdLnx9Ezf/HxzG7YjvDdULW3+8gXc7V41b2o9aJ2yZDfMAx/Klvq2reasyBGiIz8x08mwFlqd/Tg7kfGfXBfK+TZ7xhMP8P6EI2fskOHIRDBvxlS+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048015; c=relaxed/simple;
	bh=OMtscAawaH/DK779YziJt0Q+Ppqfy1hWIJ1wXnnHGls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rXYIqFtErhC4YAT8rdVnmJ0VUoAVR5ABuQQP+PTb04R63J2xAJpS2726BZVzGB4FFHTNQ2hHublEGD3ZNSk31PbHBdtrYLzsf21cQuT8n6E53kI7H4kK7rZvmEIMzymFp4C+CM1LuuwUOyWk5RvtSHfLFvq22mnegJvXmfnjuYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nh5A5zPu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zyugXZdH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nh5A5zPu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zyugXZdH"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761048011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OMtscAawaH/DK779YziJt0Q+Ppqfy1hWIJ1wXnnHGls=;
	b=Nh5A5zPuyM3oUZchOsFb+EREReaZqGOF+kKx/L1ApjH9M5rU9hE9B7AT3uCnTb0QuiUsh+
	uhqIFFJxiJMH7l62mlMQv/TKQz3wZHV4FnQyOqmND+hNOufolWMUgK9axiNw5rjvP1DvI/
	/pUyoEpzK87Wh0S7z1PtN5CQ+aUGhV+D/71zBok3WTlsMkQEg8r0r+XPv15wV/+mZh6An7
	NGRy9cLI1SVApwCO9BGgar4puPXeTpMq2ioZ4EPmUjIfLVaE/2HfPRPqPI2pFAxvF/GBpZ
	V+11NpRGClMuGv3PGN34qDW4SblH4PmV90UqSErnLpECAOTlMfHr5jghmObWbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761048011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OMtscAawaH/DK779YziJt0Q+Ppqfy1hWIJ1wXnnHGls=;
	b=zyugXZdH5jAxguesqIcVsByeM0uuT/+bEMoGBgnEz3BUJZCw3De+lqTSZ5KFj5c7Gl/6qn
	+doVz3Y2FVKlpzAg==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Juri Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 19/20] verification/rvgen: Add support for per-obj
 monitors
In-Reply-To: <20250919140954.104920-20-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
 <20250919140954.104920-20-gmonaco@redhat.com>
Date: Tue, 21 Oct 2025 14:00:11 +0200
Message-ID: <87ms5k1n3o.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> The special per-object monitor type was just introduced in RV, this
> requires the user to define some functions and type specific to the
> object.
>
> Adapt rvgen to add stub definitions for the monitor_target type, the
> da_get_id() function and other modifications required to create
> per-object monitors.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
