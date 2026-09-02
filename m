Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6824C4A4995;
	Wed,  2 Sep 2026 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360439; cv=none; b=t6lTMF+313Vnlo8YJg0yi+rJOIgfynq2Ybxwh32xwSJkP+0FH3k9UxYpLI5JA7Sa+PyEpA4v6LyeeqPvJNdJRZd4WAPdWgciwcCFDtw3UR7LVGrIETHJTxX7AQimKMWVVNEMEam2codisl18uL7hwQEwX+5womVmglFvhU1U7e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360439; c=relaxed/simple;
	bh=bOcbTYWOSnGi5jznXtg1XYwg4lMEoIvH6Y8FiYqBbXM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrEsgvn1AuAoXOWtp0/KdWOpuHxxo7y0v5VzmJXtGipSYh93gYqHpR1XMNq6XR/dxeal/N3mNBUm1KDGmq8QsO3ZJxsNHxu0z/TKFv57xRzdLYYpHmZEkBJuABTb2GBdB0sBrkPWO+0T6rNp+YbOHSmjJEQmLrnL7nBQ3R1XXOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=rzIiNjuL; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="rzIiNjuL"
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 4337416020E;
	Wed,  2 Sep 2026 14:47:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 3A9C320025;
	Wed,  2 Sep 2026 14:47:13 +0000 (UTC)
Date: Wed, 2 Sep 2026 10:48:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Xiang Gao <gxxa03070307@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Gao Xu <gaoxu2@honor.com>,
 =?UTF-8?B?5Y2w6Zev?= <yinchuang1@xiaomi.com>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External Mail]Re: [RFC] tracing: aggregate ring-buffer memory
 statistics
Message-ID: <20260902104813.658823b7@gandalf.local.home>
In-Reply-To: <e4c4d3f20b1445869ba329e561f6d042@xiaomi.com>
References: <20260825141015.3539553-1-gaoxiang17@xiaomi.com>
	<20260827113815.0a0e37fb@gandalf.local.home>
	<15c244f5bc8f4858b8ffa2974a46d009@xiaomi.com>
	<88d476d443e74672957a5e0d1f8bf9ba@xiaomi.com>
	<20260902091555.450b521c@gandalf.local.home>
	<ca552a4c093b4498b2e308d266d5ab6f@xiaomi.com>
	<20260902103938.6cf6f61c@gandalf.local.home>
	<e4c4d3f20b1445869ba329e561f6d042@xiaomi.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: ed11yfzzffczpq8q4dwd3dfcjcc4mr11
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 3A9C320025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19StsrfhKF+weKPGtcADRxnAZedVSuCQgE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Oed39cMjAakAu0s/CMQfMdp1Ef8v0B+jU/QKmVYOIqc=; b=rzIiNjuL4WallsfpXY8FEZMOWreQr1KYTroB2iDNg+5WZzA4n7qtevHQYi19GA1Fu3Wv3DjktYgxxiYZFwwRVy0kPK1Z6y2LVtWZ0fd790YPfKV8tpgD39Tw37QWwHTp2wAbyo/8iiFD3/lUUEqcyBow3uD0UU9c8XhOlSEPXCM=
X-HE-Tag: 1788360433-46278
X-HE-Meta: U2FsdGVkX19swY5FgH3aFEpYEcyltZMIUZN8o7wq8YsmaTSU72A5c8zNjTFGuhehM8rDpohAeDjL9z5adzSpWRuJRa49UNHFzNPgiIhqu2op7UT/yhIT6by8x/vgc4JKdkp54s9hwI9b/MkzXyC/RkdUAbuECXX8b5CFWyvQlazfD9as/OlskQl5SqSeWt33Ab1ItM6JPghx0OeRtQ7Qz6kTMr+tuSPjCb7rMqonAbTaQO1ex2+KdskScwevod0m0u/Ep5aZ52jRDlM6yy1F+c6Q48dtIboP0dUxEzUmRNaEK+99sF2HxCTHmiyZoK8ui0iYSSYC/j0TBiLTjIodanKTLQKxMzgM

On Wed, 2 Sep 2026 14:46:21 +0000
=E9=AB=98=E7=BF=94 <gaoxiang17@xiaomi.com> wrote:

> Thanks, Steve.
>=20
>=20
> One more question on the per-CPU view. Should I also provide:
>=20
>   /sys/kernel/tracing/trace_stats/per_cpu/cpuN/memory_usage_kb
>=20
>=20
> with the same two-line format, reporting only the buffers belonging to
> that CPU? Or should the initial version only have the top-level
> memory_usage_kb file?
>=20
> Once this is settled, I'll send the patch for review.

You can add it as a separate patch in the series.

-- Steve
