Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B3C2FB989;
	Thu,  2 Oct 2025 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759397967; cv=none; b=HT09ysTFHm0xNSahq+ZVUh8UceEmri0ylJU5ni3siqE9OGAwWk0lQk7J+2q//vtinNySZzB3Z4yDzjkhz5HV+4jjeIgKyBFFazkhJn7S21uudi7VYDWOhuvzp4KY2nbstgz9+Z4pqMLg/8YEUA3rP18ESCknOIDSXwcf6h3aMPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759397967; c=relaxed/simple;
	bh=Dg0b+TW1RebQY7VKpUXIb6Cdvio2eeKgF+X6yYybI+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Phlcn/SUewERedAbRMQ4IzWCjh8wa3wLL6vSt9nCdA5qrLUVC2CpIqqEL4hPf7Yq7xBpndwWnAYu1Wc7uaKtUL48k2PelfPGNpsNrlSnO3g/7GC3HmcEi1NtxdKJfwOx2aXDZOSRGdAKh/2QWD70RlVR0u8BHQsZ7PumPFeUEFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xd8o5u3X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+NTk9yLW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xd8o5u3X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+NTk9yLW"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759397963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dg0b+TW1RebQY7VKpUXIb6Cdvio2eeKgF+X6yYybI+Y=;
	b=Xd8o5u3XHCp+O2PSWcVjLTLqtxE9J+OLvJ50xCpsrc2LSbMMHsRIEf3EfapD31sLLwNOFK
	3C36RXBYIXrQL5xtZCfbyjz+QCaNMNmI3bDzg5pLSS1r15NRJWBvRHucAOQ2M9Q9bKb7dw
	TrMBpZeO0OXcr1AXaNPejg0S5v2oJ20OlVd9bHcR4AsqZvEZ6ZfG0N4Csg3t4oa9tA/AnY
	wmxThelfvSGfeDSI3jq8f7j5HdFwE0cwVsHasfbmKR+GmNI+9Ajqm0zgNytK3dXSV724BS
	6D6DR73cbNY3cAEkjP9m2Rlu8I7O618tYPAWRp7LygMKD6XoC/uS69oNjsOqwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759397963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dg0b+TW1RebQY7VKpUXIb6Cdvio2eeKgF+X6yYybI+Y=;
	b=+NTk9yLWlDYdUVtaecIFhLjFvyATwCVdnqDJKFFNMUkdZSdDPEC2aiPY8zFgHZk2zC6iCr
	ysn0Ve8dXCOCzLCQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Juri Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 06/20] verification/rvgen: Annotate DA functions with
 types
In-Reply-To: <20250919140954.104920-7-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
 <20250919140954.104920-7-gmonaco@redhat.com>
Date: Thu, 02 Oct 2025 11:39:22 +0200
Message-ID: <875xcxskvp.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:

> Functions in automata.py, dot2c.py and dot2k.py don't have type
> annotations and it can get complicated to remember how to use them.
>
> Add minimal type annotations.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
