Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526384302F0;
	Wed, 12 Aug 2026 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549616; cv=none; b=OgYlAcdziWcTGWe+tPg7Xhx7o8WTP/g3QMAsLGZzWjftn7kT65Egzkgp/BGGLFEfAs0QBdzTyfe+FkwJRIFYw5hGCRth2zwvE144xiECUgLZ/GqAh6KNpdIk2bzeIqvUY9eWjnHaqnKI/lhlIJFtpi9emL2O/YkXrc5k7mooGsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549616; c=relaxed/simple;
	bh=t18RAuHb52fghdO6FyOpnMWRuYBTGZoEnry749spOZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ADd+VmkcYcCPdWo+zJsl550yf9tmbK2xtKGi9Bcgup8c2QBtsDti+lC1/PHSkfviPwoGpx3QhOe0ZvNa42TXGijH5Zc4zs1Tv8JbfyN+dFu8hp3GPDX+HiXnRPOILG7xHIz2uAJDckPKt6iXQQemJgcMTzzSymv4cmBCiZEAkpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 595761A0220;
	Wed, 12 Aug 2026 15:46:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 2ED3C1C;
	Wed, 12 Aug 2026 15:46:50 +0000 (UTC)
Date: Wed, 12 Aug 2026 11:47:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Xiang Gao <gxxa03070307@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lorenzo Stoakes <ljs@kernel.org>, gao xu <gaoxu2@honor.com>,
 =?UTF-8?B?5Y2w6Zev?= <yinchuang1@xiaomi.com>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [External Mail]Re: [RFC] tracing: aggregate ring-buffer usage
 statistics
Message-ID: <20260812114704.2f61bc5a@gandalf.local.home>
In-Reply-To: <cd441eb194d54265b1bf9ab659716c45@xiaomi.com>
References: <20260811114818.1449933-1-gaoxiang17@xiaomi.com>
	<20260811100830.7976bbe8@gandalf.local.home>
	<cd441eb194d54265b1bf9ab659716c45@xiaomi.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: jj55tpuq734zrntr4mkk48tuo8hzoa9h
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 2ED3C1C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+by/rQIKubySb9lhljso6RTy3PoJgX2ew=
X-HE-Tag: 1786549610-224787
X-HE-Meta: U2FsdGVkX18gjr0dOC6PWIz5eVBeLbyJ3izL+U0m82/9r/HPau+llgEP75MBoxAEPEQTN/l3MX1VSvnWeNMGowQmOk+rObggFZl8nJwt4FPQoNCEIgeTvgDE1Fb+gHa/LihN1JW8MBdo1DSj3eCveydHIz9AAwWnvZNTt4vt2rsrX6rr3z2AT6+IZUIbYaA1WSJMiQyvLgawQ97FeJdiM6h1JqGOC+LOQpXlTtRQ5+7OoJYKbYdKNNkXyZH4phaVasIl8mtCSiGHKQJ5sLk6/DKt0FC1/qFCHhrqiscSVoJFndeCv/HgUcAfdKH0he/qHfOvLx1Dh1cwXJtaiPfWTNWoyI42XrYC

On Wed, 12 Aug 2026 13:21:29 +0000
=E9=AB=98=E7=BF=94 <gaoxiang17@xiaomi.com> wrote:

> Thanks, Steve.
>=20
> For the initial implementation, I plan to add:
>=20
>   /sys/kernel/tracing/trace_stats/total_memory_kb
>=20
> The file would use an extensible key/value format. Initially it would
> report the ring-buffer data capacity:
>=20
>   total:                   395664
>   ring_buffer:             395664
>   ring_buffer_live:        395544
>   ring_buffer_snapshot:       120

You can rename the above to:

   total:
   buffers_mem:
   snapshot_buffers_mem:

No need to use "ring" and it keeps consistent with "buffer_size_kb".

I added the "mem" part to distinguish the difference between these numbers
and the buffer_size_kb, as these numbers are about total memory whereas
the "buffer_size_kb" is about usable memory.

There's already a total for all memory listed. We don't need to have a
total for the "live" and "snapshot".

>=20
> Here, ring_buffer is the sum of ring_buffer_live and
> ring_buffer_snapshot. The values cover the global trace array and all
> tracing instances across all tracing CPUs.
>=20
> Additional accounted categories, such as event memory, could be appended
> later and included in total. Per-CPU statistics could be exposed
> separately under trace_stats/per_cpu/cpuN/ to avoid mixing aggregate and
> per-CPU values in one file.

Agreed, this file should exist in the cpuN/ directories and be only for
those instances.

>=20
> Userspace would parse fields by name and ignore unknown fields, so new
> categories can be added without changing the existing format.

Right. I would expect additional items to be added here.

>=20
> Does this initial format look reasonable?
>=20

Yes, thanks for doing this.

-- Steve
