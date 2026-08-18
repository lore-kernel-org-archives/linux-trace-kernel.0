Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E402283FC4;
	Tue, 18 Aug 2026 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063117; cv=none; b=SOnPKcUmeaPeUQjMOP436FKx1th7AyQtR5Yzz0il/2MP31PfDXwiGio7Znwgi7oxhgTeV+Df3NVVC4iMmYr6tPsdAcknZ89fQYiZkdjYCneF5Lb0mEGLCVAjGEmdId168TuZwQ/xpNdoEq3yjYOppDrEgQlmJk+WKY5bIFTLhPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063117; c=relaxed/simple;
	bh=E5/rGVzlBcnqQpnTv5+IlQUiwRUmnA0eNZNFu07RT0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQpGWZ0FS6wKIzsTdXBhSMhs6DITWlc4XZH6J6mgL3J91FOk7fXkfg6Cl8zTdsb2vx5wkqJ7V3OpL2RbdILjY8zQ1YK0xgQyMmHJcI3y9xKIbvDAfUGIEbeG7d+0JmswaytrrJWyVNkCik7PqudK/jnWR+5bbuBPafYghk+fcdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=pcx/LIHk; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="pcx/LIHk"
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 47FB1160279;
	Tue, 18 Aug 2026 14:25:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 1F44720028;
	Tue, 18 Aug 2026 14:25:04 +0000 (UTC)
Date: Tue, 18 Aug 2026 10:24:56 -0400
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
Message-ID: <20260818102456.03f52b8f@robin>
In-Reply-To: <11242d2e40eb4fd4b439ac66ebbe26ed@xiaomi.com>
References: <20260811114818.1449933-1-gaoxiang17@xiaomi.com>
	<20260811100830.7976bbe8@gandalf.local.home>
	<cd441eb194d54265b1bf9ab659716c45@xiaomi.com>
	<20260812114704.2f61bc5a@gandalf.local.home>
	<d5bb28119dbb4ff1ab1059bb2564ad29@xiaomi.com>
	<0e42953988164786aafe175ef0f4e745@xiaomi.com>
	<11242d2e40eb4fd4b439ac66ebbe26ed@xiaomi.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 9zprk6udzdaksuhwujqxs1tos18bd7xf
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 1F44720028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18HcnJ66CNnHw+pNMNxXyVfBT9aUSk6dI0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=E5/rGVzlBcnqQpnTv5+IlQUiwRUmnA0eNZNFu07RT0g=; b=pcx/LIHkxu0dCkt1AI/WVyNjJ8VXYVGo8ykVn0ey5hjtthg0MkTrRYIH6uDDJxQcoX8FfbLii8T3kNJApi2+JJDryyNgmzE6iLw04cI5g/aVEtAFiOampkXLAHPHxiBnPtoJTFFrEvE3MKj7FZTw9z3dppi19WMOIKdaVh7TG4s=
X-HE-Tag: 1787063104-385141
X-HE-Meta: U2FsdGVkX19kUE2e7JTYzjcyI5IvKIsVRELHE9ewQ+N343pZipCABDOGQz64cQSxwJ4o2fcR6NWOhHoFj+3b6ozab+17Hu8SayjboJSOAnWDSqwUmxkwycjgHBKUCFaRikeY10PNzAW018wJCNoXbtC5G12ud8WH86ZNmPz0WCU8O/7pkqTg1ZGo3d21/aj1z0hDx0vfnzZZo660/+kjgoaAxJrlJsXY3NNWaH10bv+fRBHuPtNrSAxKqPRiKK9xlswp41YH6jaSDj0fbITYLx2adfbbA1Pr7CVj5/L3nEknweLaIWByM38VU+B0m2h4xj6ejmIULnwi+hlvWu1piRLGLb0T0Bwa

On Tue, 18 Aug 2026 13:30:26 +0000
=E9=AB=98=E7=BF=94 <gaoxiang17@xiaomi.com> wrote:

> Hi Steve,
>=20
>=20
> Just a gentle ping. I have the RFC patch ready for
> trace_stats/total_memory_kb, with the buffers_mem and
> snapshot_buffers_mem breakdown.
>=20
>=20
> Would you prefer I post the RFC patch for review, or is there anything
> you would like to clarify about the accounting scope first?

I'm traveling this week. Can you send another RFC next week.

Thanks,

-- Steve
