Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689D221B185;
	Fri, 17 Oct 2025 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693837; cv=none; b=EuVErt550M4pMiimBUCVWngIYosDT5QTug1YNcJllMwAIzrX5XfErrgHm7cIH/nwZ6Fd5vIpV4jmwIyvEcI4+pIlCuL7G6alDuF2mU82JsLh5kULGa6P6HG+v+WIbrA8DxYNUCygzUIOWmIjMK3D8KRsVDZJHOgx+ujEtn7GSng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693837; c=relaxed/simple;
	bh=0zxVCCLSKYEJ9MFiUmZTlkExtnbAcidKE9azgZvpVQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fb0nc0k35EkMnyixCIXi6s9c7HzoFF5Nj3kmkaijiILhsHXtglmHEMQEB9tJX6EogFJ1aPk6qCD2okGvfF1CKMXvjNV0XxrT5yDxUw1eT4Vs+gOX+JBuZhALRwT7zVM5z+9wCGqUrF9Fx5p05piZC7lNspfwHNyfhTFeomMt/2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J1sxqMSo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sgjhlAJB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J1sxqMSo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sgjhlAJB"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760693834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AMBhtsatbX/1a6Y9dAaC1Mra9IEVObiajnh+VSzVjng=;
	b=J1sxqMSoDl/C3rQLYE8oHzxqEN9Dc962p2/jIvAwWPRagbwQMZ4KZruuk24ZbL8xPtALJu
	9HfQM30AX19gsMgY7TWx7B6SulSltSrqmE2QWQeVtEPDTJPA9q27glFaIDsfzn7wcxrRNl
	IOVfz2PJXVD0GMd1RSeZDmhxi3prGi6g3T5SbQrLSsZ3+vpJkNqUhRHYBHZpbx6fJr/Xig
	wHdFFjRn2zuws/KA6VUl5UzjRTMgBwpmzqk+C0R/9wOyL+BsFIjUYI95L/rOqP/4h6jJc6
	Cap+jte7NHcu9DQIegp456AcHGp1wjCDcOnWAxw6b2kizlDzohZl9gcF2/58Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760693834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AMBhtsatbX/1a6Y9dAaC1Mra9IEVObiajnh+VSzVjng=;
	b=sgjhlAJBtFyS40nLLzMZkBVCSngFa1Iq9hDTLvn67GMuvpiWmJTSMoaUOr+xD53QIVUe9n
	IJNV/om0o7BZRKCw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Juri Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 12/20] verification/rvgen: Add support for Hybrid
 Automata
In-Reply-To: <20250919140954.104920-13-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
 <20250919140954.104920-13-gmonaco@redhat.com>
Date: Fri, 17 Oct 2025 11:37:14 +0200
Message-ID: <87ikgdx41h.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> +            if any(u in self.env_types.values() for u in ["ns", "us", "ms", "s"]):
> +                buff.append("#define HA_CLK_NS")

That any() twisted my brain. Does the following work?

    if not {"ns", "us", "ms", "s"}.isdisjoint(self.env_types.values())

> +        match unit:
> +            case "us":
> +                value *= 1000
> +            case "ms":
> +                value *= 1000000
> +            case "s":
> +                value *= 1000000000

Use 10**9 instead, so that we don't have to count the zeroes.

Nam
