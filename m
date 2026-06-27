Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FDC23A561;
	Sat, 27 Jun 2026 08:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782549385; cv=none; b=tsZ2fI3d8EVgA4dtnuykY/mr2SJ+mm+m4rlD6lWp1a5l3IB7ftWc8RHwM7vR8FXTQohxUaSiLlMFW7Wp/ZjETa+uz4ZgTcLfU7WsSe6iyAK3Ki4z3qpzTVakkNY17v2QPqQF19g6vQvvG0Is0uvc+vAw8N8Tus1KlaroSZwSqmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782549385; c=relaxed/simple;
	bh=jgCiN6tRXMSulZx3jHLTvbVwnbJHXCz4e5qQC802Gu8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hiAPt098YwvZV7spoTsjMKZ13fHAu8ZwzVOWdPAeOIBSiL+fE5fm7rT0YLDGYa7A6qOFRFayfb/05PfPAYr2hE1ccWG+gZ0/ToyTtGFVLeHkon91sJbfxQ3qYn0C7mCcaIJ8H8hxLYD0rmagNpAKUhBdRuYwKHgXWNDItdcB98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id D0C5A167BE9;
	Sat, 27 Jun 2026 08:36:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 0C76D20029;
	Sat, 27 Jun 2026 08:36:14 +0000 (UTC)
Date: Sat, 27 Jun 2026 09:36:13 +0100
From: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
CC: Martin Kaiser <martin@kaiser.cx>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_tracing=3A_eprobe=3A_read_th?=
 =?US-ASCII?Q?e_complete_FILTER=5FPTR=5FSTRING_pointer?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260627004538.4cc8b34a4a20ee14f9a38c28@kernel.org>
References: <20260615145500.2662456-1-martin@kaiser.cx> <20260616110910.e6420488b6a798d49951cde9@kernel.org> <ajJbkeK0zXb8MtcS@akranes.kaiser.cx> <20260618105227.c58c85e9cb19bce673d9a79b@kernel.org> <ajasLMUt_AMM3ztH@akranes.kaiser.cx> <20260622125815.7416792c020bd3d81c01e51b@kernel.org> <20260626055440.76c28d25@fedora> <aj5SdK9gUIVoPmmE@akranes.kaiser.cx> <20260626064223.60ffeeaa@fedora> <20260627004538.4cc8b34a4a20ee14f9a38c28@kernel.org>
Message-ID: <1194DB48-67C7-4602-8038-2A2297E36D94@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0C76D20029
X-Stat-Signature: 4jqf5k3f6579fsfdy15r4pawazfjtoa3
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+DPBTWCX9MzD6d0EVIhylocz0U+AxO2kA=
X-HE-Tag: 1782549374-461502
X-HE-Meta: U2FsdGVkX19fxdjCBuNH/XZqQMQSJn4o832F2LIGxPjpGbzpbYdORWtJuvDWB4ifefONIUqlWqd+2JuvxDH6++cRhmw7HycGt57scoC0sIaKd3Wmqffl2cw3odQ7IAdvlnYEwWh8VRDt8/j1bIaCmSkVBTQomBPVAuEgJ1yWL+vDm1Ic59unpNr950XucP3myjvF6PTscVNlpSKvEmF31o6wxXn+W6qWdKZevY8aitjRy3Hy6kMrD8ap8pnRFQsxv6Vkcs2D5vttvcEibWYH71OddR5+nIJPBx423jB00imF+piB1iT+OJqHrUaaLloUk7d+b3ZwZ0AUbDhO918/DdOlzLF4eD39LKiaK799y5S6aE2yX2Crq6LdN0/JOGjUIkm7LOJZrV1GHu23PCLdaqju6T73eDVGxPrkwFakMko=



On June 26, 2026 4:45:38 PM GMT+01:00, Masami Hiramatsu <mhiramat@kernel=
=2Eorg> wrote:
>On Fri, 26 Jun 2026 06:42:23 -0400
>Steven Rostedt <rostedt@goodmis=2Eorg> wrote:
>
>> =2E
>>=20
>> I'll queue this up=2E
>
>I've already queued this on my probes/core branch=2E
>(which will be probes/fixes)


Awesome=2E Thanks Masami!

-- Steve

