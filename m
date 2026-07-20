Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AFF38AC8E;
	Mon, 20 Jul 2026 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784533758; cv=none; b=vCFzGG6lJ2ZDkEIttzZdBhXvVpgGqDhYHblps7JWxzrnc44LCbhtFdLZJ1JCCGjOqwwNyBsfQ6t9N1X/lBM1BwSTehdog0G8FTL7Mt4s2PBvn6GZtocKvFRQTlXPApSpmPSkYv2XP1mQ2UzgdHIJrCACTeAg8nJDJFz5sl7gaSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784533758; c=relaxed/simple;
	bh=6IPCxbW6914A1izbaweGaifn1mJ6OMpf71FISxWiOZI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e8W4xWjSsrxh+dEDbKxTnS+XXtJLd6Sk5Y/s085lL0zuu/sZJIKYjnQ/KeAki7stoLdQVu6GZFDqbTXn5zu24Itc1aKiINCSmPxkFpgKxcA7KvlOSTE7gBAf1A2cOSaFLKz1L8wXjwroIsm/bnubifMkOIsBsDDzvyClRUd4yJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VIFuaZ72; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BRi7SFWC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VIFuaZ72";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BRi7SFWC"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784533755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6IPCxbW6914A1izbaweGaifn1mJ6OMpf71FISxWiOZI=;
	b=VIFuaZ722bzhjGxieiVAioBZ0OjDxBfo5ibXB34vkcLo96HMk1DlHy74OnCxAnGg9cnVGn
	bXDsy6gtmLUHrnNiyPueSpgqPL0bdzN2fWTpdfjANgoBnAc/bLfvciiqDeJXcFo9wU8NUV
	Fd+Ify0l1rOTfkg4fEJuE+iXb8JtrRG9rgpeLrlkplas8xGSQnStpDMK1eBzdf9NfOS229
	7MsJT2+QKQxbPKWyO/Qr2mF0cF3l5flX2RaULR82d/tDoz1UT340WKKukGv3jdIh9li5lQ
	CrF3yuekRpK/8+RY7yCzqLK0AoZVLo8cD+qZRuiwBE3fb9l/C70vHA/s4cmO3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784533755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6IPCxbW6914A1izbaweGaifn1mJ6OMpf71FISxWiOZI=;
	b=BRi7SFWCl1/1BXtYQcM9L6Ixxkmj8biYOUHxOP+znObQhkcgzrYYJ+Q3qNtCGeqnno6c7f
	M98RX3abyaCZvZAg==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v4 05/17] verification/rvgen: Improve consistency in
 template files
In-Reply-To: <20260717154638.220789-6-gmonaco@redhat.com>
References: <20260717154638.220789-1-gmonaco@redhat.com>
 <20260717154638.220789-6-gmonaco@redhat.com>
Date: Mon, 20 Jul 2026 09:49:14 +0200
Message-ID: <87zezmdrt1.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Template files for rvgen had minor inconsistencies in their
> placeholders for default author and default tracepoint examples. The
> user needs to modify those anyway but keeping consistency may help in
> bulk editing or checking.
>
> Change default author from "dot2k: auto-generated" (for DA/containers)
> or /* TODO */ (for LTL) to the general "rvgen: auto-generated".
>
> Align the sample tracepoint handler name in LTL template to
> handle_example_event, consistently with the rest of the file.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
