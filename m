Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC382156C6F;
	Fri, 16 May 2025 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747408767; cv=none; b=dY+5kw9WIAsMHUIDOkc9fjL+snXb5YPN69GVp1PIrMTCixmWwJJwWqqmudSdHEZQL0CphxxmuzgxaqICSFMK+tAUWeFrfsU127wOMmjxw8e2mgFz45Dh4EUGIdD8FrCdO208kPaziG2S4tjKoaONborUx+Turslr53jTAo0tdpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747408767; c=relaxed/simple;
	bh=g54XZswDF8mNvdc7U3J9QcKB9wb6LK31y4toS0xOxtM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qKX1VtUo7GQbR4OaJgpLg6LLENM0BTux06BUN6NcUg+UnH+Q7Uo22bbBi+kRzfk0ZQWmXUMJUxEoQoE80XoJQo1Xi1GhDxPx4VLOs1Q2gFPfKwKwS9m51KxExCShlv1jj+5F3MeDz086qAj8iNubB9nmq6VXiAzZN00ZtSNcjHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id B2E5FBBF31;
	Fri, 16 May 2025 14:42:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id E08FA19;
	Fri, 16 May 2025 14:42:49 +0000 (UTC)
Date: Fri, 16 May 2025 10:42:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Will Deacon <will@kernel.org>, Nam Cao <namcao@linutronix.de>
CC: Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, john.ogness@linutronix.de,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 17/22] arm64: mm: Add page fault trace points
User-Agent: K-9 Mail for Android
In-Reply-To: <20250516140449.GB13612@willie-the-truck>
References: <cover.1745999587.git.namcao@linutronix.de> <554038c996662282df8a9d0482ef06f8d44fccc5.1745999587.git.namcao@linutronix.de> <20250516140449.GB13612@willie-the-truck>
Message-ID: <3E29A42D-8A6A-4342-8C60-2BEF1EDCD640@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: fwwnh447t6mutbrmj9ubf4jooxi931wy
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: E08FA19
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+36P2fhVcgnroof75qoF9SN8UIqAFV4Kc=
X-HE-Tag: 1747406569-593877
X-HE-Meta: U2FsdGVkX1/rJz6ABQ1M8TIvkNuAzUINTERmcuNlJj2x1fELWAjnH7lQfAVhELL24XkGy9kmwrwdnkjVrou5VOZjQ17wqMAclrNj3DlF6WNjtsFUccLbUPcUgDQO9ki9jxH21hIajoME2RyLrlWS+IEfzvmGx33+TyzIUSpsLo7kaRHf8ZG+70PSvSjxWcGB2rt+b6B5fqecJBnerXVJ50YNZgrMrNv1gku7mayGZw8PDblh2anVDXPkgVJPqO2zJwhLXkRPnlh5H5h4IpEdvuP48qNzyxJOdRkdsUNksXyR7SnXlnA2RR09aFa8GQV6Upv7tK7OakR2jJzyJdhoLtm+6VtuBo4n



On May 16, 2025 10:04:50 AM EDT, Will Deacon <will@kernel=2Eorg> wrote:
>
>> +	if (user_mode(regs))
>> +		trace_page_fault_user(addr, regs, esr);
>> +	else
>> +		trace_page_fault_kernel(addr, regs, esr);
>
>Why is this after kprobe_page_fault()?
>
>It's also a shame that the RV monitor can't hook into perf, as we
>already have a sw event for page faults that you could use instead of
>adding something new=2E
>

Perf events work for perf only=2E My question is why isn't this a tracepoi=
nt that perf could hook into?

Tracepoints are made to be generic, whereas perf events are not=2E

-- Steve

