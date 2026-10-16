Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A482BEFF6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 05:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129841; cv=none; b=rH+TPgWxS81q0wAAyBFeS8f8yyKqCzbvU9xVmfSDdsIQyvuQX3v55CN7mgYhvVWOQsgKW9N3/2e7qnsLUPaz8RF1YjDddFYTsIV5rZrNN8XT2tedWucoIgIaupTdKUP7QjoaC+lklSTNW9bxiP1LTkJa6Gyl0H7p1iw3vA2N99E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129841; c=relaxed/simple;
	bh=lCSsjSQimlBqs/rR2AagaYjCsJJ0mvjDKAAcujnt74Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=f5EciAshuzA6MncAnUJZ1bBnOkIzAyU+bxxweVy5Nk8kwXiVGGlGtTwQu1uqoOnNmF+XBR2CRjd7Z6SreoFI7yhP4amr9B6i/b7G9UK5jO0WTgy0UKYHSlvyckZVF9lKSMzBHV4Yg/rTP6/4/0ZFo9ukYz0omqoqTxMMQHFrnTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aq7vxiWG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aq7vxiWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D5C1F000C4;
	Fri, 16 Oct 2026 05:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792129840;
	bh=DZiwSUifQC4j+VuSfnaefD/ybb5bspGwJfJvgYQNrhQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aq7vxiWGHy5+gihBYtL+YvYxIer/b05wlsmBW49fEuZ2z42V99e5L09LNhlaW2Luc
	 rp84cQtXLDEDz/V7igVbAoOVmz9eCuby793eFc4zQ9ZPQxee37BAhWH1MpELmOfebl
	 NGSCj9BLK0FSQab+ApZNlXE45bLEzZOJ1/iM6WuBr4Vl0yZiD5Msc+GIcSXpyhBLeW
	 lPe8NBULZRXYfBAKcbvrL3yHI17k+0uhJqadRlNANdYK8SbardroI4a/Pu7ncNzohh
	 vY8wfknJWLyH3KBwbOFQXE0Hwr6jnzPAEts/N5IysRlvxMgaDo0NG0xOqa0cyQ8YdW
	 i2zFH7OuEHEOQ==
Message-ID: <sashiko-outbox-173839@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: Hold trace_types_lock when updating modules in
 persistent instances
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Carlier" <devnexen@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261016053835.204353-1-devnexen@gmail.com>
References: <20261016053835.204353-1-devnexen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 05:50:39 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tracing: lockless user-space reads race with update_last_data() ca=
using UAF/NULL-deref
--

commit b27de9515407670f957a6af5954413aab48a1320
Author: David Carlier <devnexen@gmail.com>

tracing: Hold trace_types_lock when updating modules in persistent instances

trace_module_record() walks ftrace_trace_arrays from the module notifier
without trace_types_lock. A concurrent rmdir of an instance removes it
from the list and frees it under that lock, so a module load or unload
can walk into a freed trace_array. The notifier also reads and updates
tr->scratch and tr->module_delta while update_last_data() may be
resetting them.

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index e4a490d3d08c8..d3ffbed9c44b3 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9247,6 +9247,8 @@ static void trace_module_record(struct module *mod,=
 bool add)
>  	struct trace_array *tr;
>  	unsigned long flags;
> =20
> +	guard(mutex)(&trace_types_lock);
> +

[Severity: High]
Does acquiring trace_types_lock here fully protect against concurrent
modifications to tr->module_delta?

The lock is taken here to serialize trace_module_record() and
update_last_data(), but it appears user-space read paths can invoke
update_last_data() without acquiring trace_types_lock.

For example, when a user reads from the trace pipe, tracing_read_pipe()
calls update_last_data_if_empty(iter->tr) while only holding iter->mutex:

tracing_read_pipe()
  ...
  waitagain:
    if (update_last_data_if_empty(iter->tr))
      return 0;

update_last_data_if_empty() then calls update_last_data(), which proceeds to
free module_delta:

update_last_data()
  ...
  module_delta =3D READ_ONCE(tr->module_delta);
  WRITE_ONCE(tr->module_delta, NULL);
  kfree_rcu(module_delta, rcu);

If a module load/unload runs concurrently with this unprotected read path,
make_mod_delta() could race with update_last_data() and access the freed or
NULL module_delta:

make_mod_delta()
  ...
  module_delta =3D READ_ONCE(tr->module_delta);
  for (...) {
      ...
      if (mod->state =3D=3D MODULE_STATE_GOING)
          module_delta->delta[i] =3D 0;

Could this concurrent execution result in a NULL pointer dereference or
use-after-free in make_mod_delta()?

Additionally, if multiple readers execute concurrently, could they race ins=
ide
update_last_data() and trigger a double-free of module_delta?

>  	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
>  		flags =3D tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT);
>  		/* Update any persistent trace array that has already been started */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016053835.2043=
53-1-devnexen@gmail.com?part=3D1
