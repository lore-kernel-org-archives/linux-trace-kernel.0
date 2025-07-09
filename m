Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2A58F40;
	Wed,  9 Jul 2025 18:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084184; cv=none; b=A7jEISWfDmwswzdQSiM+b0gh2vdMAs8a/3fuh1Z/RfhUsbFpJBa1WMI8+KchXGmemOVAioRpBFKRkiXPKOOwPfiji9kUUhiazmyvb4zPVHRTkYrbfn303ZGRDgqUXMsboHR8wA4R0kUH2a6muVMyTjERPVAQxIJ2fhIwF5+M9ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084184; c=relaxed/simple;
	bh=zmETjLkQxPZXJE78cPJUhx1Pvi3XOdZVoPP1hS4dWTw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n13BvFjBJYMi2AlAgzs19mjYeL3vb441P0C91LpYc16rEmV5Fie3dOS9xWocsLUF88x2VTQm5gqnw6E+zpwl2KxSZkZ3aAO7FYiMjlV1lLk14bD9ZRwqEZDFZOS0w/YJNYmo35k3ttckBuBYhOzH4Xe71jt+dfAYm3IFKqdNtE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 15B94129394;
	Wed,  9 Jul 2025 18:02:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 06AE32000D;
	Wed,  9 Jul 2025 18:02:45 +0000 (UTC)
Date: Wed, 9 Jul 2025 14:02:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 00/12] RV: Linear temporal logic monitors for RT
 application
Message-ID: <20250709140245.555f5fd6@batman.local.home>
In-Reply-To: <cover.1752082806.git.namcao@linutronix.de>
References: <cover.1752082806.git.namcao@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 06AE32000D
X-Stat-Signature: 4tomrud9jwmunkyz57wfp5k71ry5wety
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/ggJjnnsruuPvYIVxNLflPkiwzfzc0XTE=
X-HE-Tag: 1752084165-40581
X-HE-Meta: U2FsdGVkX1+FoU1zagZx+55nCSK0CRRO+gJw16rt4pRYrTaqRE+5MdFJDk8bVx1GCKROKOBODMciAKoOKdnbMPBNtuWYohDXRGiFjMAzO5YrSBY8leaRpHNz49vZzwck91lLvIklDX5cJF/1KjjUrpojPk+/Bu2jSPizMhI2Lfx+pVOmDiYGSF7vBwGkiUHPDw9SSbsN4bYg6b2f0rS9+ZguPNCmTaoLzzPwlNF80ZguwzDoEuDTjUaeWauPMw8KE8VJSjaG7AwZIdqbPVrg9v6hYtRssSWiLZNIcAGVrxKgmeMzvN2XzYndvAly0iLN8pcTh2sYXlfq3XOrFaOq2jZpSnS3YCLX

On Wed,  9 Jul 2025 19:56:17 +0200
Nam Cao <namcao@linutronix.de> wrote:

> v11->v12 https://lore.kernel.org/linux-trace-kernel/cover.1751634289.git.namcao@linutronix.de
>   - drop the applied patches
>   - fixup build failure when CONFIG_PRINTK=n

Bah, I didn't see this. I was actually testing this series, but the
tests are having issues.

Anyway, I'll apply these instead and restart the tests.

Thanks,

-- Steve
