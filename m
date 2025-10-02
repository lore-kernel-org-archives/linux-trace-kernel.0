Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AB12EC099;
	Thu,  2 Oct 2025 11:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759402989; cv=none; b=ZjOj6IZt8dDzKD/XO6Ajpa9f2XCqhP0zPXnkitgTsUZGm69n64eCH5zN1Ie+UflviEVZplXL73w2btU48VO0bHy32TRY2Xizfk16W2vhgvnns0j6xseB6a1Qd2d49yaGHjmoPrVau+rOGgLrbq2HIikjk9BPVXoWvcBQK+7CIFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759402989; c=relaxed/simple;
	bh=8NYUepfs/ARQb10GiGuRLU3X3En1i9nrdZTxw7phox0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qZJMMOiQHaTcmwpVYFyPQNEGbYNUfHvjSQt66DNKqe/0Zbzsm/+hxDdIm1Ymiu+FpoqRH2egnMgpnfKzwbwpLi+PxkiHaJzyfQ9kHYhYEAiqMhxgnmZ43kz8F7bkZqcRrVgmWABxFR38kii65DyWPjH40bys+X6DJaY4ZUJJhos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rbnzu7ka; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=neSAJyLr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rbnzu7ka";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="neSAJyLr"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759402984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8NYUepfs/ARQb10GiGuRLU3X3En1i9nrdZTxw7phox0=;
	b=rbnzu7ka3AOA5YL82MSdhuabD1IotwnsPvy5LajOFlb6Rn/Mbx8VQM1fzRzpK3SNAM5LsB
	tpmoMc4RMnNG3SElFPmCtgTgzo+4IDgEFt6QSyDKo7slXuEaRHlMh578/FzXXAANt60TqO
	WEnMEj0o1cnU/kUF2u+0mcRdghDQ7117hBSdOvpcVyrGQ0ngPBqgjW64PZrfA0rEzocmmT
	ocym/F3BOwsHb1YJ5oAzf8jAvOz31OTiLJ0qaQPZNwmRSaUNlDcw5g6A3GdKoARQ43D86h
	bCHWg2Hk7zvtwy2BtksjNmhy1bbegABQl2Q4h3asX20Bk99a/Af+JiKltVcc/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759402984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8NYUepfs/ARQb10GiGuRLU3X3En1i9nrdZTxw7phox0=;
	b=neSAJyLrx0LQ+jRiH2PdB4zI1AJETWwMhL/tDLrILA3uS+pFNZWKPqFsPxUlQxT4JHxQFa
	opsRcWxku5rPCAAQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Juri Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 11/20] verification/rvgen: Allow spaces in and events
 strings
In-Reply-To: <20250919140954.104920-12-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
 <20250919140954.104920-12-gmonaco@redhat.com>
Date: Thu, 02 Oct 2025 13:03:04 +0200
Message-ID: <87v7kxr2fr.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:

> Currently the automata parser assumes event strings don't have any
> space, this stands true for event names, but can be a wrong assumption
> if we want to store other information in the event strings (e.g.
> constraints for hybrid automata).
>
> Adapt the parser logic to allow spaces in the event strings.

I probably misunderstand something, but isn't the description
misleading? After reading this description, I expect the patch to ignore
spaces or something similar. But from my understanding, the script only
allowed a single event, and this patch allows conditions as well.

Shouldn't this be squashed to the next patch?

Nam
