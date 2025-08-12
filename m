Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19F03D994;
	Tue, 12 Aug 2025 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026529; cv=none; b=ZMSMWRi/uotPp5jrofhQDtOnIfyrgrR0Y+WXZOkJj9WET3ssrk5eHS+0m3KNkU/F+ZNeMvh0eUTcMzWYiLDJr8fqF9HKWfQdWG5g15hptG3s1iBdGTCwFturM1oeybR90iXq9XG4AbcMroqgMjrZU+uDE3OY9liA4C00xVikrAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026529; c=relaxed/simple;
	bh=J3/WbnaWz9/+22dEjF6XblnKlT4Ye6mKeo014jzrCO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AejZRtDUHe+vBNM9EhDAOKBJwKI3fv3uqSjr0fUbk0u2S2t/UiRiUqJqMo6w1uchs0E0vPOwy9s+ZuryjmNABlPJXoRWPiZC6hkhd9Shm5IehiRZYd03aSySG8Vvt7mxqAqf5gTU6wtSKA+H9bftSHT+F5tg990qP5TeEiPUu38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id A25B01A0199;
	Tue, 12 Aug 2025 19:22:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 9D0A220014;
	Tue, 12 Aug 2025 19:22:01 +0000 (UTC)
Date: Tue, 12 Aug 2025 15:22:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Douglas Raillard <douglas.raillard@arm.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, Takaya Saeki <takayas@google.com>, Tom
 Zanussi <zanussi@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, aahringo@redhat.com
Subject: Re: [PATCH 2/7] tracing: Have syscall trace events show "0x" for
 values greater than 10
Message-ID: <20250812152247.6a5a4ed1@gandalf.local.home>
In-Reply-To: <8ec3ecea-a830-4de2-8191-e3a78b4427f0@arm.com>
References: <20250805192646.328291790@kernel.org>
	<20250805193234.915257520@kernel.org>
	<c4f1b8d4-774f-42c1-a828-42c79756503d@arm.com>
	<20250806083944.036de894@batman.local.home>
	<8ec3ecea-a830-4de2-8191-e3a78b4427f0@arm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: e1g8dufjfgr1edgaw1s9z7n3fm9wh9cg
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 9D0A220014
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+DUAyjDeHUuDNt55k7ulkWz18COHNqojI=
X-HE-Tag: 1755026521-325833
X-HE-Meta: U2FsdGVkX186S8LxTduugok1CwWbPZmVVEBHkoxR+eV1p45F6a5ZqMSZEQOt2pzGcmsZZCpe1gxz5O0I45C85HkENDw/mRAU2HFDEEHrREVmvXFcgoaaQmwluj+xh/mregDHK6JMkv6ooRGiEh/DzrQnLuQJ+9jCUsesbLncGQvSmlguwAyyCkUjvujnWcY3XW7RjGpjGriox7okly6+HhcqfpC+0cLYwyYsF54VSNCSVJW6V/hKK53LShAvORAiM3LJjQSEx6Z3fV+VOTgNiA9CnvQ2/BDHiDor/xVAtXk0xX39MIIxgikOL1uaX2hlvuKBIqMav21jdPQDfW8B0d7Vy8m9x8wRxaABkfq3BPFI8WaUS2oDMtWrBJDfZv4uMqUqHGjgKKyvwDRMHxAqDA==

On Wed, 6 Aug 2025 17:42:38 +0100
Douglas Raillard <douglas.raillard@arm.com> wrote:

> 
> AFAIK to this day, there is no tool providing a simple script/SQL interface
> to a trace.dat file beyond basic filtering like trace-cmd report. I've had this


Well, I did have this patch that I never applied:

https://lore.kernel.org/all/20200116104804.5d2f71e2@gandalf.local.home/

-- Steve

