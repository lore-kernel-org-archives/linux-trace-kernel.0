Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB01253B73;
	Wed, 14 Oct 2026 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983923; cv=none; b=EoJC1QopbJbwjNMJ7iUPGZmYKpr2L8O4i0P2JwjZoZpUwjdlZU+r6+BEvT/hf3uOBigwiVXwn+bIoZlJu3GR38bylsBYlsYAUCKdiJSkdsdOtlJg7MiuafvBSovbqLWrT4C345ud7WUVG4OTxNNj9BOD7njTZrxoDHpewL7nK48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983923; c=relaxed/simple;
	bh=UxHIDRhGTSoqCxV+45lew0JBRv2hQYbXgPMRNAonVB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLOx1HDgBfC0g02QTjpZj1LhvOs92GB1Yh7JPWEXR6MgwOmb/2y0y5HJpWEaeNQlbiZg9ImGGFKCXsK/Jf8VpdpePKHtO8sUHdveIPR97n6B4CsjpbBh7AZU42dT8ZpB+IuYKcJ9ID5+WSgSxrbsXrV8pWhjOUZGUjdBxt9WMPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=lqptv0jR; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="lqptv0jR"
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 508171A0545;
	Wed, 14 Oct 2026 13:18:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id EB73F32;
	Wed, 14 Oct 2026 13:18:37 +0000 (UTC)
Date: Wed, 14 Oct 2026 09:18:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Vincent Donnefort
 <vdonnefort@google.com>, Xiang Gao <gxxa03070307@gmail.com>, Donggeun Yoo
 <donggeunyoo.kernel@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lorenzo Stoakes <ljs@kernel.org>, gao xu
 <gaoxu2@honor.com>, =?UTF-8?B?5Y2w6Zev?= <yinchuang1@xiaomi.com>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External Mail]Re: [PATCH v4 1/2] tracing: add ring-buffer
 memory usage statistics in tracefs
Message-ID: <20261014091839.11488a0c@gandalf.local.home>
In-Reply-To: <51b25b1c996d4412a0c43d94acea98df@xiaomi.com>
References: <20260916063322.472172-1-gaoxiang17@xiaomi.com>
	<20260921113047.1152602-1-gaoxiang17@xiaomi.com>
	<20260921113047.1152602-2-gaoxiang17@xiaomi.com>
	<arJNSjKsJ3bK40dH@google.com>
	<20260924102755.02084435309be26f664e3333@kernel.org>
	<arTlRPvmR54Fa71o@google.com>
	<20260925100908.66c46353e5a2abeb73b1e15a@kernel.org>
	<cb0090dd1ad84a5b833e9323fd2b05d5@xiaomi.com>
	<51b25b1c996d4412a0c43d94acea98df@xiaomi.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout06
X-Stat-Signature: 4mqesbzrwybkzrd3ditp5i3m5pquri6g
X-Rspamd-Queue-Id: EB73F32
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18n1tzfdVUcPJES0KjT05JvwotcyiF1foQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=UxHIDRhGTSoqCxV+45lew0JBRv2hQYbXgPMRNAonVB4=; b=lqptv0jRUa4kIU75zVip2RlJfwunNGpCS1qcgKsOqX5RQzQm2g2TTIHm6h18dk/40ZmhmEjQ+X+sKDLkwq3js7n7TXXy0dcEWvhdOwqLP0vZNndmmEZR8Y/9/bbwSN9WpXSsYLeC/7J65ETc1vIQVK1ztC4GcF+55n1kO6Z9kIA=
X-HE-Tag: 1791983917-361532
X-HE-Meta: U2FsdGVkX1+1FoA5VafthlmUpfhBlCLCODCACTCoObyU2lr68OEOGffAr5KzCzyWg8rp8nA7aY9vWtDSIEpqh33/eeNUYVuEFa3PTuxW5sC7DWCdUwSjuOJnPxC0SW2Yv2zA4LEjyBg/z/p1rf39Hilm1p0cWwN44VdJX0YrK8Bqfk3ihOfi8+uHl6vZ4GqNEzSQ210S7s4v2YWoQdxremZNEbJCsjx6a4ZXiBPTG4G4XNhHUUuF8A1DR2jpGUV2f6Qbx+y1v/2n07TjPpanzLs6tOcj+MK/NpCI3uMw5+d6r4Al0zb1GYO/0BEX3pTtIIKzMJas5rbV79M4+GI2pVj04NM6qdZE

On Wed, 14 Oct 2026 12:32:07 +0000
=E9=AB=98=E7=BF=94 <gaoxiang17@xiaomi.com> wrote:

> Hi, steven.
>=20

I haven't ignored this more than I ignored the other 600 patches in my
queue ;-)

I've been traveling since September 15th and due to conferences and
vacation I basically took off 3 weeks of kernel maintainership. Last
Saturday I started going through my backlog.

I'm focusing on fixes before I get to updates. But your patch is still in
my queue.

Thanks for your patience on this matter ;-)

-- Steve
