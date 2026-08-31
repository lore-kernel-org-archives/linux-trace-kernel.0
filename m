Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548D54A43ED;
	Mon, 31 Aug 2026 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188256; cv=none; b=U0sWnuB8diZ9zK++H0L6qaIzQNh0mhD9vPesZNZmCuaOB0zbWiW3BgdfthTaBmZyLNEjp3wWOxxm89JdhwMYjHkenLkrbJVGyYTP93sOG91nJX4Qdxb0/jS1K5fp9/c7dTzc6kKO4W7/Z5+IUszbSCcYclin23ydbk529vODkmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188256; c=relaxed/simple;
	bh=hx8R/AApQKzG7E/fkYUEPAjK1cuHUksamCW4BIOX3Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wnt+m2BFUjJZWXPEaJaSRobjUUzapi2eSzCV+jWAYuRMP+z+bymDcObbL5QG+ejPiYI/j03N+2pRwhsNnhxsRdxjkwWC1cHwhnYcy6joNANJXsQDDGjxKj91hBci88MzrwEk34lzRKx/LEVteZaeSKcdirokbPsLu1vSMMB7BXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=CEBXjHXo; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="CEBXjHXo"
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 3F804C018C;
	Mon, 31 Aug 2026 14:57:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 14DDF1D;
	Mon, 31 Aug 2026 14:57:23 +0000 (UTC)
Date: Mon, 31 Aug 2026 10:58:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Rui Qi" <qirui.001@bytedance.com>
Cc: <mhiramat@kernel.org>, <mark.rutland@arm.com>, <pjw@kernel.org>,
 <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] riscv: ftrace: reject out-of-range non-direct targets
Message-ID: <20260831105820.22085739@gandalf.local.home>
In-Reply-To: <20260901020000.1-qirui.001@bytedance.com>
References: <20260707121235.759104-1-qirui.001@bytedance.com>
	<20260901020000.1-qirui.001@bytedance.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: i3pjcmzphm14rwrt1owf6ty49twegz1t
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 14DDF1D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1//eGqi8bpd7aR+4JRxanQExgdzhlCWk8w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=kimCP8YvJCUrptM2WnuQUVqNPk5kAPjReUuPtX6bnJo=; b=CEBXjHXo/VvdsMQTjfUVOvrvdTU2K9wWoKunjm5+neGQf+heP7S4QpWKvNqXJ5DC619z43JnJMeT4+2ZSC4pz2pgo5mdltlbKDtldo4R+juO5Z7HJfcVKmHpffF7T7AyoC/anhPYEbDZTmkBI/6BgNj5im8omFwbblloWVliimg=
X-HE-Tag: 1788188243-30817
X-HE-Meta: U2FsdGVkX19lQdUL0R9LZgKiHVJI6aXbwu2zVZ/wFibAXM2rhRi59Dnl1TnGlQ96Wv8srtUKsRWlob/uDFb7hygVDLaWVpyAgWSACryK37fyeTbGFDkskivDNtHwXiWByiLLiIIccRVuUuhFr5F/GWBMgdKYqKsXdEl17M1LAJ4E8qd64ogN0lg2HPP4oFPAJxVpzhIfaLIh9em+EHnxK9T4YFw2vWHXFWoDkbH9W0iF2Qjry0wl5pVjF7/cPFk8sMV/U2eS39zZ9Ryj/eGiJ0YPc7BivS9+FPKfj6YSq4aZ+vvlECRxB29glzPuCM99zhmBPx6gI8GV4Ds3DGEQjqbrxoWY1tkb

On Mon, 31 Aug 2026 11:50:45 +0800
"Rui Qi" <qirui.001@bytedance.com> wrote:

> Hi Steven,
> 
> Gentle ping on this patch. It's been over a month since submission
> and I'd appreciate your review when you have a chance.
> 
> The patch fixes ftrace_modify_call() on RISC-V to properly validate
> old_addr/addr instead of always treating sites as FTRACE_ADDR, and
> rejects out-of-range non-direct targets that can't be dispatched
> through the existing ftrace_caller path.

This patch looks very architecture specific. Is there a generic ftrace
issue you have with this? "out-of-range" issues are specific to an
architecture (x86 doesn't have this issue).

You need the RISC-V maintainers to review and accept this patch. I don't
see anything specific to generic ftrace infrastructure here, which is what
I maintain.

-- Steve

