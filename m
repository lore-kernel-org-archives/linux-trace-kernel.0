Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63F82EB5D5;
	Thu,  2 Oct 2025 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394997; cv=none; b=pcjvW3iQjqxRp8xEdYY538EkpMaeuJm0v89XKQRZmoYPGTkIS/BM2khBbJasvO48RZIBA6h7Ya6iX10RDgbPp7m0x+WeUB3S0XrrqlwKNYxOVC3kd5mhHSKc8EdvN33596x7X7dluGvbNFBh8IBjUixxeIyWkThP6H4SO+5ydmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394997; c=relaxed/simple;
	bh=YvVqoqu27K+RggK/iuLYOnR9FmUWkCQpUDGwgXV4cYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LCz/IdaTBcofSH3PaxUqeqrncg24mPWNTZFrjaPFLOkQbZDNUDjPH8gN+PcgBT39TyWxcZDV3uVe0zpgrI+AzTf6X7svD8r+IrZbe2VpQTlsjkyR4KCoeh0pzzzSVK8Hrx4SU5DJd02Y8D1LSR173QO0e1VTVkZKaazLO4fh9VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IIUsPJei; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dg4Hglty; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IIUsPJei";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dg4Hglty"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759394993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YvVqoqu27K+RggK/iuLYOnR9FmUWkCQpUDGwgXV4cYk=;
	b=IIUsPJei/aaxyqSBcGhCZZkFvkgK/AxbykaxI/gnhyLp1SYotmUsstqgLuIUIqnpiydqhY
	W6Z6+6yjk3ccHl7Nj8NElPLt/tlNpJf2pxdMeZ4rcWhGdrotFieM3AUd+eUhmBEuqxUrr3
	OL0BG8wNKW+1VyogCpNEfqj9Hjg8JCOevCAYBQMorchl+FjMgrjwVr5fF8k5OuwkUwGjNU
	oHTzcG5rXgeSPGK9glvKNGgGXXLca1PYsUUbvU7f3nq0aTmj5xRpJ2Gz4OUSy5acxZ/WAh
	pOi0zE7ggYUzO8gZrOzKvssJ09cHLNwoQY9BuqsaceCn69nGABZE5HMjJkko2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759394993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YvVqoqu27K+RggK/iuLYOnR9FmUWkCQpUDGwgXV4cYk=;
	b=dg4HgltyCxvmxbaIV7BeysHwbb65XWKGK6nX8bEzArGc/PDPmhsCp1I4+i4Jx3rTwVBPYJ
	df0aopiZIBX+nhBA==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Juri Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 02/20] rv: Cleanup da_monitor after refactor
In-Reply-To: <20250919140954.104920-3-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
 <20250919140954.104920-3-gmonaco@redhat.com>
Date: Thu, 02 Oct 2025 10:49:52 +0200
Message-ID: <87cy757knj.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Previous changes refactored the da_monitor header file to avoid using
> macros, however empty macros (e.g. DECLARE_DA_FUNCTION) were left to
> ease review with diff tools.
> Most macros also get the argument type which doesn't really have a
> purpose since states have their own enum and the storage in struct
> da_monitor is fixed to unsigned int.
>
> Remove empty and no longer required macros and substitute the type
> parameter with the appropriate enum.
> Additionally break long line and adjust the format overall.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
