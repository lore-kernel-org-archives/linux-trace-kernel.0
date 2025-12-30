Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527DC296BBB;
	Tue, 30 Dec 2025 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767105757; cv=none; b=o2nHCRk4aW5+oyWFDAMzQR5XI0s6h0TiJYK+NwjkrDElsczrG4E/85EI8LNKnWHD10oKcf4vBm5iSwPk+4yrzQZGVRbsXTIA1c+gjBqK6n3zdz8xxAC9MCXDbLdkRwDyk2+AWiKuPl0MoZHaX1FIoivdx5dPQzcv63+u3JFOl+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767105757; c=relaxed/simple;
	bh=ReN2Kty36LLsMd4fWAk8UYnhQEjl2p/piWqot1thHnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Na4oF6OcA+aF3sqqJkNfCwOMG92ie6Vf7fucDFwJE0EoB5S+cRI0nHEKFcb4ajOn/MbK9kyYEeM/1zXsvejp62HudKjkn5xbIg+WAwaOL097A601aeVE419O6174FOS4HwBIFqxIlXG72Ixz7VOvddBYd3JE0HkwfeEo8SHMTT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id C19821A8E3;
	Tue, 30 Dec 2025 14:42:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 7B31360010;
	Tue, 30 Dec 2025 14:42:28 +0000 (UTC)
Date: Tue, 30 Dec 2025 09:42:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Tejun
 Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Frederic
 Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] tracing: Replace use of system_wq with system_dfl_wq
Message-ID: <20251230094236.358ae2d8@gandalf.local.home>
In-Reply-To: <20251230142820.173712-1-marco.crivellari@suse.com>
References: <20251230142820.173712-1-marco.crivellari@suse.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: biwkyjhqec88oz75iygtaq7q7mj4oooy
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 7B31360010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19kClA0YKP+vlD2dFKDVP7PwRQbNXTIgb0=
X-HE-Tag: 1767105748-435366
X-HE-Meta: U2FsdGVkX18ArmwlUWKP+YSfnqwElbiUq5j9rphQgyoVXE2KYbTdsIZbExaiZ6c1epjwmoWmxOv/UGFuSDIQlEhTHXJNT5XZCS6/C730xmTC8YeKmuR3MC3c1er2hPEggFzyV5LPvkXBeKUq166Lw/ti+p80lLSEV+lZyfaxB9OpwQiuzEmDlpTNx0vrv06XIEk0akBv+0HRlfip28Wg+FponNkZqCyBgiEJy116toNandHab++TZ5+Tay4wNLqHDcJt/h4W+xpzUzeL46MVS0QRObcaMucqwF27Bc4Vh010jeUbkAKya9a2Kyvt9Lf0xNN0crGPpT0pFtqUM0Iueq2Rk/XQwAmncksS51pl33EXjpKV4Iwso5iv7RKJVzoAKT07UR7bjFb6vbvPokHTeuvho1xtFwnrCoV4TiatFyWSfNwUy+ESHT5vxt8gMKQmv5QHhZZD98LDXczEU44WYQ==

On Tue, 30 Dec 2025 15:28:20 +0100
Marco Crivellari <marco.crivellari@suse.com> wrote:

> This patch continues the effort to refactor workqueue APIs, which has begun
> with the changes introducing new workqueues and a new alloc_workqueue flag:
> 
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> The point of the refactoring is to eventually alter the default behavior of
> workqueues to become unbound by default so that their workload placement is
> optimized by the scheduler.
> 
> Before that to happen after a careful review and conversion of each individual
> case, workqueue users must be converted to the better named new workqueues with
> no intended behaviour changes:
> 
>    system_wq -> system_percpu_wq
>    system_unbound_wq -> system_dfl_wq
> 
> This specific workflow has no benefits being per-cpu, so instead of
> system_percpu_wq the new unbound workqueue has been used (system_dfl_wq).
> 
> This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
> removed in the future.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
> Changes in v2:
> - use system_dfl_wq instead of system_percpu_wq because this workload has no
>   benefits being per-cpu.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
