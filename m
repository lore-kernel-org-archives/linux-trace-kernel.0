Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C72A3A1693;
	Tue,  7 Jul 2026 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783405482; cv=none; b=Eu355Cxzxs76BhkrsZ2zOcDqU3Q0jFsmOFaGrzQTuwxsBECvs2bHDPPYWxn4jPc4oEXERuk4KMFCVguGzUpyy8fl/movrYkxajkT6EE26qVWyqQ5Z4EJU3vNV1x8ehlmliU7NIbDkLdXBfGWbKPPZjrqlHVNskAgyq9FvOZ2LZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783405482; c=relaxed/simple;
	bh=Vdn+mLWmIf3XyYG3gpoC46QIet+K6Ff3AtVmykAvLys=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BGIKVraynBOEBvqJxA1kwaCbknKaf9Tbk+6Cy/zt3ASQ7pCBbDxUIULw1jHTTYAU+cRF2Bi3mlYx2A2Zu/H8FBh7TWkuFZ1X6YyUk8GNdQy0nVHm2qntbVENBnEuPkF1htNlWIQiiyHgNFhKaWqeq1vCOkMXBy/3pzxe3pKYNVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev; spf=pass smtp.mailfrom=mavick.dev; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mavick.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavick.dev
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4gvWJt5DQQz7vTc;
	Tue, 07 Jul 2026 08:19:10 +0200 (CEST)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of m@mavick.dev designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=m@mavick.dev
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 14:18:38 +0800
Message-Id: <DJS4CP5DU9UH.699SV5JGDXGN@mavick.dev>
Cc: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>
Subject: Re: [PATCH 0/4] tracing: add ref_trace_final_put tracing
From: "Eugene Mavick" <m@mavick.dev>
To: "Eugene Mavick" <m@mavick.dev>, "Will Deacon" <will@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Boqun Feng" <boqun@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, "Gary Guo" <gary@garyguo.net>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Dennis Zhou" <dennis@kernel.org>, "Tejun Heo"
 <tj@kernel.org>, "Christoph Lameter" <cl@gentwo.org>
References: <20260705-refcount-final-put-trace-v1-0-cdd0014626a9@mavick.dev>
In-Reply-To: <20260705-refcount-final-put-trace-v1-0-cdd0014626a9@mavick.dev>
X-Rspamd-Queue-Id: 4gvWJt5DQQz7vTc

I apologise for the duplicate patch series submission, I had resent the
v1 via b4 relay as it did not show up on lore.kernel.org for a
day, and I assumed the emails were lost.=20
