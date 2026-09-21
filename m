Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4D0486400;
	Mon, 21 Sep 2026 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983054; cv=none; b=H6zqmKxQr3xwcCAlCXgI6HsvdJwrrONcyblhuRnQQe7dx0JJYIsyhFzpY93bU9RjYm2Lldf0FcOQnwHEMJqz69DArHnz/Y8aGnj7V5bNXE/2SnTCYpIsRaWmdQwh/sr9FLYzdhOBh9qHR4UOo8TiFpPHBSiyKEQUEnfL2vKHGO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983054; c=relaxed/simple;
	bh=5cDySu0QzSlCYWQxCjtJGwN078ktI6hZCOH/8vC8+cA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REHrBdANE4VuLt8x9mkaIcxiIqE4rP3oMJS36juYggiyBn4JZH/UriE1SHnBEJ1+uCc06831rKoVA/w6iRXLgMtFwC6RM8bA/CipAyECFGoUqrOtIFwQbzS61oumBD42H740TIdqWtmRHbCQrJfadN1WhRGB+mp2cvfxQP1ajjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=gFBZVg1j; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="gFBZVg1j"
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 12DFE1C2F94;
	Mon, 21 Sep 2026 09:30:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id AB04419;
	Mon, 21 Sep 2026 09:30:42 +0000 (UTC)
Date: Mon, 21 Sep 2026 05:30:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Vincent Donnefort
 <vdonnefort@google.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ring-buffer: Add a MAINTAINERS category specific for
 the tracing ring-buffer
Message-ID: <20260921053039.39a66cd9@fedora>
In-Reply-To: <20260910155058.1ac4c991@gandalf.local.home>
References: <20260908094035.0b180833@gandalf.local.home>
	<20260910155058.1ac4c991@gandalf.local.home>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: n15bsssxmnpbp4oe53fodned9jjp71wg
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: AB04419
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/osNYIMhn+z3qh247b1+8b5qq9Ga5Ow9Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=X+cV55tlyUWWSONZwVI24Vr8liKGPIV59w+otUBwSQI=; b=gFBZVg1jRyjJoTmej8FIRpF5EmW7vfIuXmVUwedGHCH7kj9fHKf13DJ88h9OVmZ4vgP3hOWeK/+fowpCSbaaaNm2dDNRYewdctEm0LeH/5v+lEwXUnvvSdw/xKY+Moq6kI1V2k9yEZvn4S6+J3jCHcB30N48dRPKzlwQ/Lze/3w=
X-HE-Tag: 1789983042-408203
X-HE-Meta: U2FsdGVkX18ORrL3unWLaVk8dtw5Mn29Nf8QDeCrk4HP0PbtB0RSwi4NR/+JORaZVeazaeavwKQvyvNKlAA1BFj/fqHuEFGZEM2XbwNWtavySFSEsEVBhuU60GuNu7X1ZJBWFkUjaw9+9dlYpo4mS+BQfVZfsGazJ+coiueGPPWny2cl4ZbwJ5d5CW55rzV8bqZNmTI8fKttl12t+WweZ3mE3tyF8ytiTkkCQy9o+EBKDtVoZ45yPWGVIb6oEr9tKoFOURo3CaxYOIiZJu7ixoUqZoPDOpkkS85kC3wQjr+uc6ArfbO3560r34iMGHA+866/OogGSxRnzIIrkLQ3zJBjP+rLKRpkxnGJgdvVfJd6b/VZeNaYQM92yAfFphh11+0QrQI1qiUiH2GcVazAMQ==

On Thu, 10 Sep 2026 15:50:58 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Masami,
> 
> Can I get an official Acked-by on this?
> 

Ping!

-- Steve
