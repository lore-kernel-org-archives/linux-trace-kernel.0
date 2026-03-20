Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85162EA481;
	Fri, 20 Mar 2026 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042526; cv=none; b=FqthsW+IRkz3WdTnKnIojCrfLtLf2+HV2RZoi2xWMaOjuKS+cMfDqgDdwtapWARdmBavH83jKA4bVAdUQJ9oNWXLFA3zmQzXG0qoQTSuUhv04UE6ThvVj0mrVJRk7vMUC67//ItFqcXaJmGjOZkW+u0/HA48k+1b70iZhHfrAQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042526; c=relaxed/simple;
	bh=7189zS5dpJfB8Los9vO7b+qB+0wrKw/q6U2uwYpZZI8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KH020OLl8C3J/qcl7GfI+GbuyTTzFHriMXqqpPDmK55JwFTaQtrLh4PmUC2oWnP6pumgORz5oN5FNQ+tOusNCOTLCgxBXII2vYAYeqpjB59poygvykP7rDsEjjN7JQS/HsQLM23iPRzj4EqHHLr3H/y2ilN9VMecFqPxPyuLwps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Nl9eK5mA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=smb87YM6; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Nl9eK5mA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="smb87YM6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8DB5D7A01E7;
	Fri, 20 Mar 2026 17:35:17 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 20 Mar 2026 17:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774042517;
	 x=1774128917; bh=2SsK19OUByypsE17X7dt/87hHDWrIntrNYCgrJUL+X4=; b=
	Nl9eK5mAVijz2vJZb0sCU97H81dYg5DEnuvKtTjSzOMbdhLYI+Wvv67ahZDgYf1D
	529izzKKE7pVl3zZaJXrUVO0ouYJ/oFYOnUZ2UN7x2VS+IOSwgFLZhY4m/W+SsLG
	mYkhEL3OnbZCRXYd4j2GaVt6NwKr7yovVCrL27xC0x7TxIDxvyqguoB5kJn1JuHo
	LycZb5BLre8u+vqmv9vfHDraBK2ONv/7LWXM6wD2NlZ8r5X/ZL0nKpu/fwRlXCxj
	FE5os2jWJGFqLLRUwd3D0LSj2ToH7UaBOmZE9xWD4dIpAeJK7WVFqRf/6liXaeSX
	HJWz2YlAkEw9eOgWIMxEYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774042517; x=
	1774128917; bh=2SsK19OUByypsE17X7dt/87hHDWrIntrNYCgrJUL+X4=; b=s
	mb87YM6fyI10a3Y7yBYcYfwwQDBNmtQ+BYbtj/J3Ld8QutjRZ2C1/UPWHegbvpTS
	cCzs+CTi3jrvEBBAvjgEIubnOXQFh99MkjQQvafxT9mL6/jVsflGw9UOAjzlfcms
	jwP6NajADbfh6fp6I3eCWnmCkB6Y1/mh+G8rHzQyezMZvDlLvU2oOg/ae5iZTIc1
	bzIW/EBzgzIJoBgFryy1+RoU9jgXudP/rennEIsiHjgvgdVwUd/Fb6n8BuBt0Hch
	m4rlxLk8Opc9B+mW97k3nf9OFihqieL3asJNSqREUemZe1e9y5xITDdQTRWJYnpL
	CyXB3lMBYy2leQs3wX7bQ==
X-ME-Sender: <xms:lb29aZ6bVFeQzttGaWekGac12x8tig8SAPy3fZmQoBDPROCn81kwAg>
    <xme:lb29aRsKDYjQ_9d4i4571ALZr2r1kpGZ2bG3apQsr4pdFjIeh93lbCdBcCSFeCqNV
    _RgShKjl1419oOSRoBBe8bcnR1UHZenXzMsY8cBVE2xOE-3FiFzOjih>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddutddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrd
    gtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphht
    thhopehvughonhhnvghfohhrthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhgrii
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhhihhrrghmrghtsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhhvmhgrrhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqthhrrggtvgdqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lb29aWY0KYp0-A02zSee3c-DQZ0MYoaWwM65kp2W8LA0GdegaJCMcA>
    <xmx:lb29aV_achL0Av7ZVkWGk7fgl46q-7oMi_78RHaqp_rR_kEfQ8Q_Ow>
    <xmx:lb29aVaNUjBD8tX32gsa-WLmuLRJWo5Lo6JeHY_ANwJmo7yGgVDaKQ>
    <xmx:lb29afdy3s0q_BS2lLQIbW4rmZHUtdvMmTuE28OthRftmWPppThr2A>
    <xmx:lb29aeIZiB01jBxYahkEcpHKo1goXiwW_C7qTVv0IRJUVuJSvpaQyXY8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F00BB700069; Fri, 20 Mar 2026 17:35:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdhqlxVOGV4g
Date: Fri, 20 Mar 2026 22:34:55 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nathan Chancellor" <nathan@kernel.org>, "Marc Zyngier" <maz@kernel.org>,
 "Vincent Donnefort" <vdonnefort@google.com>
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kvmarm@lists.linux.dev
Message-Id: <ebce4cd9-4101-4f6d-bbb7-e03991e5644c@app.fastmail.com>
In-Reply-To: 
 <20260320-cmd_check_undefined-verbose-v1-1-54fc5b061f94@kernel.org>
References: 
 <20260320-cmd_check_undefined-verbose-v1-1-54fc5b061f94@kernel.org>
Subject: Re: [PATCH] tracing: Adjust cmd_check_undefined to show unexpected undefined
 symbols
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Mar 20, 2026, at 22:29, Nathan Chancellor wrote:
> When the check_undefined command in kernel/trace/Makefile fails, there
> is no output, making it hard to understand why the build failed. Capture
> the output of the $(NM) + grep command and print it when failing to make
> it clearer what the problem is.
>
> Fixes: a717943d8ecc ("tracing: Check for undefined symbols in 
> simple_ring_buffer")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

This does seem very helpful, as I still expect this to come up regularly.

      Arnd
