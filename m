Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F19376A1E;
	Tue, 19 May 2026 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202441; cv=none; b=XKJxIFo266ysdpmd5cY3qvzKyT8OeZHtyeKlMhx/zy1GsW2gUukC+CWmb8AcLM3m7EJszYp2Fadngbzg+QWGllmU6GnI/AZ6GhkrzH4RPblocQnMlC8LFS0fE8M5wTZyKO9+p8e+18Pr31P/aZubZp9/yn24gb+XorTKmUpbaUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202441; c=relaxed/simple;
	bh=PjMYlYMNAVDxe6hdsZHV519eLyCsdNL6QX2KGmQlznc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HqZc/TJqdAXM0QAzQ6mC+mPDMXsa9WuOI63AQJd4RiQ6YIbcuUKV/QG/HIyn3Kj3oXCdKyImRVwffEyNyFRf3mJ3/YgqvTxGyofEvJb+D8AXJa5LdSWfIDOuGCJM8NYmhfyApvh8G4jvhQu0X3El+D1VQkb83u+Soc+aTUCGqoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QllHvQWb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2XNFcS6K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QllHvQWb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2XNFcS6K"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779202438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PjMYlYMNAVDxe6hdsZHV519eLyCsdNL6QX2KGmQlznc=;
	b=QllHvQWbucSTvZYMAG1CuxolIXw3mHPLEaNQR2SvGuZUO6CthCvnu/cgSEs9HKgphc5VxX
	7zniTXroUVWKHChrjnvlcqxFD+krI21PJt2J4BbYW+2llMe6Ou189LKiK46wCGndbGSYbU
	Zg/5nCbRW/dpnTf+qXgIulMJ2uLOsStTd9bue2uCc2Ly+d4L84PBEvMdhOEaFe03dA4fur
	QKSi75s6csZ3LP9mo5VsfO996YU1uMdHyGbJ5evI5RnjJ7lH9v/f5UgEDkC3QR+JyS7TQl
	GnH+q19qkecoQdY7fJx4oOQvIqt1KGl6CnHk39MXVS7D7Y5KscOZzJY0LBYNQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779202438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PjMYlYMNAVDxe6hdsZHV519eLyCsdNL6QX2KGmQlznc=;
	b=2XNFcS6KdnXPs0W7n+NIo8Ugthg4dV2wPjkuqfKxOgHHJmNHDxcekwlgGpGC+P1Xof3MGQ
	ZZ/rxMKUnIDwpZCQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Masami Hiramatsu
 <mhiramat@kernel.org>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v2 12/14] rv: Add KUnit stubs for current and
 smp_processor_id()
In-Reply-To: <20260514152055.229162-13-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
 <20260514152055.229162-13-gmonaco@redhat.com>
Date: Tue, 19 May 2026 16:53:57 +0200
Message-ID: <871pf74fi2.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Some monitors do not only rely on tracepoint arguments but also on the
> currently executing task and current processor.
> This makes it more challenging to mock events in KUnit.
>
> Define wrapper functions around current and smp_processor_id(), the
> functionality is stubbed only during KUnit, however the additional
> function call is necessary whenever the KUnit tests are built in.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
