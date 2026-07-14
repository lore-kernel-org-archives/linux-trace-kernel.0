Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EFA42B310;
	Tue, 14 Jul 2026 21:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066181; cv=none; b=mv7Ryc1ADVwJ2x9oRX1GjRocEykE4glo38lq4BZsBOjj227cJ0IqC7AxOYb2gRiY5PHwY/PGDBXANIsKvmcWAokEcj2XgP0IiCTuqv7kLRxjThpiXMwndn5w/PJBUNrpRJgZn1EQbOe+C0jIhXBwXAPWsNmOLZlTzckAcVQux+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066181; c=relaxed/simple;
	bh=7DdPj62ioNH/IRVopzKLFDEzS9gnNwDwF8CehRbEYzA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9yraKdioVFTPW4HYeyPfkpeACGMKhR7axcdZ7OEMKVPkp53YBbLKCMQy7+Gd07uvHw+K5sC8dWFMO1fKmSXq459wLH36oimoYIlnYCJ1YnQwkyouRnYaz3zjTjmgkcwo17FhF9sqQ1mZ2uVDvZ8bX/ozrepH3ZkjmxlbeZjIi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id CDB891A04F9;
	Tue, 14 Jul 2026 21:56:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id C1EF72002E;
	Tue, 14 Jul 2026 21:56:13 +0000 (UTC)
Date: Tue, 14 Jul 2026 17:56:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, Marc Zyngier <maz@kernel.org>, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>, Paolo Bonzini
 <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] tracing: ring-buffer: allowlist clang-generated symbols
Message-ID: <20260714175617.319a6ec7@gandalf.local.home>
In-Reply-To: <ajKgjNuHUlteSziZ@google.com>
References: <20260616164211.3733326-1-arnd@kernel.org>
	<ajKgjNuHUlteSziZ@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C1EF72002E
X-Stat-Signature: cm83ch4cm4cud5cbo654w4xyg8g3nk86
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Tgr5xFE1/yqADqrbJ00SeD0hjBPci7d0=
X-HE-Tag: 1784066173-901489
X-HE-Meta: U2FsdGVkX18/qu7TigBlqFoxO0rpb5MjFw69z3FjYMhXRKnt+qxwUHwwBI/xV8rXEELYP8eLou+liLqR4UG3rMKOTpTKu4iYK8FZwOgRYHHP1jhXU9kZBT4y3Pa3TJGS5uqo+V8GHchqh/m4qjMKjc6JzQNE1MW2XgLpWDNn/ZTElWls4AbCEk7hUvBQu4YhG1h+lPb784ikZfPgLD2ZK0IM+RD6a+ImvXiKfJp5uPXeuANoD33baSEPROg4l1bnu1IP++EZwLf/blnQkLtmd+G7kjY0fhSlkMsmV1ImnjFv1w3oNrP6pKyl9IzGKGIc/Re1PgV8s9KZfUEQn+ZoJiM9dg28t2q4

On Wed, 17 Jun 2026 14:26:36 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> On Tue, Jun 16, 2026 at 06:42:03PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > In randconfig build testing using clang-22, I came across two
> > sets of extra symbols in the ring buffer code that may get
> > inserted by the compiler:
> > 
> > Unexpected symbols in kernel/trace/simple_ring_buffer.o:
> >          U memset
> > 
> > Unexpected symbols in kernel/trace/simple_ring_buffer.o:
> >                  U llvm_gcda_emit_arcs
> >                  U llvm_gcda_emit_function
> >                  U llvm_gcda_end_file
> >                  U llvm_gcda_start_file
> >                  U llvm_gcda_summary_info
> >                  U llvm_gcov_init
> > 
> > Add all of these to the allowlist.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  kernel/trace/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > index f934ff586bd4..aa8564fb8ff4 100644
> > --- a/kernel/trace/Makefile
> > +++ b/kernel/trace/Makefile
> > @@ -146,6 +146,7 @@ KASAN_SANITIZE_undefsyms_base.o := y  
> 
> Would "GCOV_PROFILE_undefsyms_base.o := y" work?

Arnd?

-- Steve

> 
> >  
> >  UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sancov __sanitizer __tsan __ubsan __msan \
> >  		      __aeabi_unwind_cpp __s390_indirect_jump __x86_indirect_thunk simple_ring_buffer \
> > +		      memset llvm_gcda llvm_gcov \
> >  		      $(shell $(NM) -u $(obj)/undefsyms_base.o 2>/dev/null | awk '{print $$2}')
> >  
> >  quiet_cmd_check_undefined = NM      $<
> > -- 
> > 2.39.5
> >   

