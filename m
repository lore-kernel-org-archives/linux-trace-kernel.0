Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792843478;
	b=bBDp7piFfYq8G1W5sknhioQo1Ftrrfe1Vs4y8w+g7uoM6iPQMFJah7k5vpP20IVAzndf
	 FxO2TiwPpMz3SLt+ZYGERYqRgbgceFHFJYtemGFhUzW03vi4ZPvJsjE15jGUy90kaxELr
	 O/4a6Z58+9+J6Y1nxLl0DecJtTsYcAXudUls3JQsQup8JH6coN/2R0+FsecZ33qXet2rv
	 fkwjTqYSyMEDFdX4GTNLY8zGW7pKaMJsXLKOW9ykf2pCH6hd34nCgAELktpCK9QeCW/K6
	 yog60MPxTXIAxOKzSA+Ua4OWjZaWAY6VwyxGMgDI81o9ZRMzNAxuHA/Qq4sJ9hbCRTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792843478;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=s41lxqK2dZONTf9s8J2caLpXoFQVSKxLuJeAY5gepco=;
	b=Nafv6whCB57eB8RQCq6m/cru+H8hqluJYsdiu6xd7hhYpuRGwhdCkBX8o+lm4uTfMLNy
	 zvSKdmzMxxmVJzUZRui1EB74ng52oWMBpwO2xyzse0vTxZ6PB9JKB9fopJoCIfXpy9lCm
	 DByWIQC/OAF2xFWiI+g6/UD+CplZpA8Lk6xOiUVE05dXVf7ovVxBY2oHKJOY+9NhGK7vL
	 b0ZY9QQvKd4n152NQnaXH6/zqW/m03gf1sX8ZPTHoJBB84sUXrdOwWMIC05p5uvpCe+Uy
	 B5XpLtM1tVSswdSWzJtFN5Yf5JNaPN3tZd7kcBxRefq1SEAPffCHDtD32+yFILbF9OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ePkFu841;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16571606A31A;
	Sat, 24 Oct 2026 12:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16571606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ePkFu841
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 335A11203AA;
	Sat, 24 Oct 2026 12:04:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id C59F620025;
	Sat, 24 Oct 2026 12:04:24 +0000 (UTC)
Date: Sat, 24 Oct 2026 08:04:23 -0400
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
Message-ID: <20261024080423.069948c9@fedora>
In-Reply-To: <4f9c82054c46459688d9a69df58293d1@xiaomi.com>
References: <20260916063322.472172-1-gaoxiang17@xiaomi.com>
	<20260921113047.1152602-1-gaoxiang17@xiaomi.com>
	<20260921113047.1152602-2-gaoxiang17@xiaomi.com>
	<arJNSjKsJ3bK40dH@google.com>
	<20260924102755.02084435309be26f664e3333@kernel.org>
	<arTlRPvmR54Fa71o@google.com>
	<20260925100908.66c46353e5a2abeb73b1e15a@kernel.org>
	<cb0090dd1ad84a5b833e9323fd2b05d5@xiaomi.com>
	<51b25b1c996d4412a0c43d94acea98df@xiaomi.com>
	<20261014091839.11488a0c@gandalf.local.home>
	<4f9c82054c46459688d9a69df58293d1@xiaomi.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 3e9e9rkew5xa6odxb3htsahcf5aiw9kj
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: C59F620025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19RJLoK8S42hWrmpvOOL4THjjWNuJF+dJo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=s41lxqK2dZONTf9s8J2caLpXoFQVSKxLuJeAY5gepco=; b=ePkFu841BwSutpE3FmWMjAo417SxLco1rKcvcalTls04mUNDGHIPYK53ebmtbDa5Zw/1a1Cxm5sc2o5z6JEYuuMAC4G9TOlW3XDzL0hYCqxEcLZXUcNkWY9gAWukUbdaYJResALUGmEHx9KWWS6mneSlgdyj3qy/RVr233Yazd4=
X-HE-Tag: 1792843464-533516
X-HE-Meta: U2FsdGVkX19srFMoayqJjkoUo/t3z3fmJXTwZ11aag0ZfKi0Fx/iEBhnrAobdjf+wZUJD9D9ow8UbKVr+YTo/VFQHYqhqeho6lAogwW2451aKnpbfGljzyYZBMZvcQw0Y9/rxYUzLqTsiyAIX0GW7mzKwlbVirykU39IxFaDby9gk9PIOg0y2/qpUZYn0ZOSGyx+U0JUVhCZnPhZ7l/XdC0oOzc0SCEew4Ez0EuUC0Bwlj/orxlcd45oFPcTwr4fJZkM7nIrLfjO7VzvMSeBUoxJpFseO9uojLoTn7eLFxputGVhVAfZfxq2P09ZNTLXUbRv9tcvvjnXDW9NuVVTU9sQP6CStrvhfBMgW5YlU7+nFl4HEeeK0Q==

On Sat, 24 Oct 2026 06:59:28 +0000
=E9=AB=98=E7=BF=94 <gaoxiang17@xiaomi.com> wrote:

> Hi Steven,
>=20
>=20
> Just checking if you had a chance to look at this one. Any estimate on
> when you might be able to review it?

Sorry. You sent this out when I started my travels (Sept 15 - Oct 10th)
and when I got back I had a lot bug fixes to handle before new code,
and then the merge window opened. You're patches are not the only ones
that were postponed. Any new features that were sent after Sept 15th
are delayed to the next merge window.

-- Steve
