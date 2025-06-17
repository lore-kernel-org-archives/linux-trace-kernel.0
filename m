Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211872DE1E7;
	Tue, 17 Jun 2025 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750163146; cv=none; b=dxR/ZZ5e0JPumdbltTHg6EUOyQZt+R06kRZWzw3WWhiGdC+iS09i8vbee4XaHRpwxjrPT+TtTWjgG+uljOAI/GnVqnLUy6YYyp3rANY09XY7iBQ7Gg+4LrdhPL8UNpY8t/A3OhWjiX8NVivONJ7xQkb4VIO6Wkp7f/Jj5Qx7fs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750163146; c=relaxed/simple;
	bh=6FdY91tZOWr2iy3CJC2/wII2A6WW1nxnp4yaFqsCVw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5bahWf/VBHgrAPuhmKiBmzL3+tOL7/cMSexfqAXYmL2kZfLWmlNqqq6VQ9RzJGbfvDKR44WU3y4XFYFaPh5r89bDdt4qPKBpJQxDg2TUhJ+K1D0s9GhM1+DQbyQAwLrATnMUxEW+hEXDBh5PkgXb8+y39nbyEEcugMc35TUKZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 3F7FC120128;
	Tue, 17 Jun 2025 12:25:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id D41AA20037;
	Tue, 17 Jun 2025 12:25:39 +0000 (UTC)
Date: Tue, 17 Jun 2025 08:25:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, open list
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, Stephen
 Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Dan
 Carpenter <dan.carpenter@linaro.org>, Anders Roxell
 <anders.roxell@linaro.org>
Subject: Re: next-20250605: Test regression: qemu-x86_64-compat mode ltp
 tracing Oops int3 kernel panic
Message-ID: <20250617082544.24b54ad2@gandalf.local.home>
In-Reply-To: <CA+G9fYtuiFHYBuRpB5MVwnZqc+WVRnnYMRHUExXAyu3_jMVurQ@mail.gmail.com>
References: <CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com>
	<20250609220934.2c3ed98ba8c624fc7cb45172@kernel.org>
	<CA+G9fYsoCc3DnNGoavFiBdymVpdJiEfUSEq967GgThVQW7bTPA@mail.gmail.com>
	<20250610105337.68df01f4@gandalf.local.home>
	<CA+G9fYv+1FPMD8e1ZadA3nLcfSRDAWvPRW-A3bGrV0y1VP2zLQ@mail.gmail.com>
	<20250613172753.3479f786d40c29ec7b51df0a@kernel.org>
	<20250616163659.d372cf60ee0c476168cd448e@kernel.org>
	<20250617194159.d74b9cde9268ee8ace8e9018@kernel.org>
	<CA+G9fYtuiFHYBuRpB5MVwnZqc+WVRnnYMRHUExXAyu3_jMVurQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D41AA20037
X-Stat-Signature: 5579cswyb6cigd6h7h8b1hp1baduqrpj
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19GffxTTqAxvPY9cvicDJb5L7cNQ2/4k5A=
X-HE-Tag: 1750163139-143501
X-HE-Meta: U2FsdGVkX1+5U9sqwPvXoAl/JlJbv/2RNVfH7ghnvUR1BfXW/5fyWgALvMH6Jee8vyCM+6J36W/IUr/6u7XI3o8phpqbsvNUfuEeyBXZ5bGgG4XCGf7BOjkjqAvdGUobnO0TxO8kq67e6eDjRlf7F1Qi+fR6/G/Z0OZFwBNdNV0WiSLqlily8t1aVy3pqyJCewwXgVJ8HkJF614vlnFwRDcIxcXbyiShWNZrhLRH9ztocoQktiKe4LG7acCLvdbo4JAMpII5dcuFkVdIr5uSTn8NxWaPHcyRCUVgOnOqw7grsa4gC5XwTxF0KnLctB6xYJ9IorxCVb7Wy+BufqLSNG1aezLDi7qKZC8xthBSYflB3KjfFOBE8WDKBvx3b9KGp0fQaIvXbcGU+ciojDjpHA==

On Tue, 17 Jun 2025 17:40:25 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> > Please test below;
> >  
> 
> Do you mean only this single patch on top of the Linux next ?

Looking at Masami's analysis, yeah, I think you only need that one patch.

-- Steve
