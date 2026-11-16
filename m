Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794799393;
	b=H8bp7qwX+J+ZwcOXpLCEkIcaIe77mj8+PKShhTLgO2w6PDIbg8eRhjIOdnaGIN//YB5M
	 rw/BZSMP9pg3wGT9WSK00EIeeHcUOuRBj3p4+wLARiEOK8GXY7afqQhxlC6ik+Hg1MBo8
	 V69sPrlKCBVrBf6AGTixbOSg2jm9Qr6N1r+FYRrY4K1y6wflgaiWQ7HAOqnbfEVqZe889
	 sCEtha9rB08pkul65p+TBdcYhMWE0ZwVZBRyiPAekx8k0m1q0NQr8C8ARbUnTM+uUUMvl
	 Gbq/gwieTA/Y9Th9Ng8noo1O9kLC0ehbO4d9XzA/Y3nnbiL4Ur0YHvAI1Yw/06mOk0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794799393;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Flowmailer-Platform:Feedback-ID;
	bh=vuaY7FImZE75sRdiBasv0Tsa2qzXujkTJsfP+X+hpsE=;
	b=JsYjGbFGSGr+RJyDdZ7bfHpFAmRfBZRgaNTXo9mwdCpo0J1btKXVioyJBLQRtKDe6oZi
	 O8cu0R4YMkyqE3xNRpNTjE6mNtujZzcqxzO/CIemtvyf5VQcM/sk8wyay71ROp1Z7Wogv
	 +YNFLyXPX+gq4N8kuXx+U0xhljjBNgHuwHlFA+pfJ51FfLaO76mGkNhPiMUsOjQrj6iEo
	 N3QMyZw4Z9xmZM7cL0s/4mrp0h2iLowkGqflH7UuZY9Lrv865SRPsiSbJcTMTRoBmEJ1C
	 Gk57gtAFS5Vy7NAdFcm+PFmNiwxYZ7URpOJSiE0x9lkrnuSJ7AYPRjkcOYVM0BIDYVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=meng.ding@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=HQQZot2Z;
	arc=none smtp.remote-ip=185.136.64.227
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF703606A321
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 03:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF703606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=meng.ding@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=HQQZot2Z
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202611160323028bb7e7d0b6000207b1
        for <linux-trace-kernel@vger.kernel.org>;
        Mon, 16 Nov 2026 04:23:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=meng.ding@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Cc:References:In-Reply-To;
 bh=vuaY7FImZE75sRdiBasv0Tsa2qzXujkTJsfP+X+hpsE=;
 b=HQQZot2Z8h36ijQln+msDhv9gcSYj5SfMiT/N6XRhq1xugtUNdMn/fUxA9qBarw0//j8Na
 Qp5FuiVGhxMPO9cC993IMWDRG3jL5qroVt1jz0dpBcib5J1XqAsug55FaOn/UyJlwDW3+4/Z
 SnqUPMfUPAFyJz26D8x3C+E+NxXIWN8DlZk93cowvaGSNioXssPo/2gJc+UIv9QXzmXIx35U
 NMhKnIdWTs+/JSI01xzO9af0qK0O6sX7kqp73KReA2Smg8mZnL2c/2jAK8tKE3YieXUoBvbc
 ix9Kc3VFdeZvjHKk09TilgE806fp1YWk96vwKdP6iRMZZyoFc6l9hW+w==;
Date: Mon, 16 Nov 2026 11:22:46 +0800
From: Ding Meng <meng.ding@siemens.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: Paul Moses <p@1g4.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, florian.bezdeka@siemens.com,
 jan.kiszka@siemens.com, wq.wang@siemens.com, Jason Xing
 <kerneljasonxing@gmail.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] net: mark skb NAPI IDs independently of busy polling
Message-ID: <tuwyyxeexvnd4ckncfhdg3grlh2xd6d2rym7vhx2uzdspjopmk@quzaz3gdurlz>
References: <20261105071706.7043-1-meng.ding@siemens.com>
 <20261110134539.12d860ef@kernel.org>
 <4pqljild2fp6eotiicvwbwu2wfw66fzd4qamwt6utirdjxlaok@iiu2f3k7azrp>
 <Fhn2gT70aJ-2_eak73NBZYuXuKtVb64PoD8VQ9jwm-S-K0RhZilAg9iwSBJ0RlaiSrRvM1vPw1aHvGPjcktu9GmdBuvFk9244-q2IVOrFu0=@1g4.org>
 <1ab53072-b9ee-464b-b5b3-cbb578059b49@engleder-embedded.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ab53072-b9ee-464b-b5b3-cbb578059b49@engleder-embedded.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1335312:519-21489:flowmailer

On Fri, Nov 13, 2026 at 09:59:17PM +0100, Gerhard Engleder wrote:
> On 13.11.26 09:29, Paul Moses wrote:
> > 
> > > 
> > > Then, drivers that use deferred timestamp conversion (e.g. igc, engleder) must
> > > specify a busy poll dependency if they want to obtain the original net
> > > device upon consuming the skb. However, this dependency is far from
> > > obvious, and annotating it for future features of this kind will be very
> > > hard to discover.
> > 
> > The "deferred timestamp conversion" was incomplete is what I'm saying.
> > 
> > This started with 97dc7cd92ac6, 0abb62b68252 and 069b142f5819 were built upon
> > it, so maybe Gerhard should decide the path forward?
> 
> The deferred timestamp conversion is a niche feature for TSN to solve
> the working clock / global time problem in TSN networks. IMO there is
> no need to make it working as soon as igc or tsnep drivers are enabled.
> It would be ok to fall back to normal vclock behavior like all other
> drivers if CONFIG_NET_RX_BUSY_POLL=n. For me it is ok that NETCONSOLE
> is not possible for PREEMPT_RT in combination with this feature.
> 
> There are already so many things to consider to get TSN working. To
> not enable NETCONSOLE on PREEMPT_RT for deferred timestamp conversion
> would be just one of many.
> 
> @Ding Meng: Do you actually need the NETCONSOLE in this combination?
> On productive systems likely not these days due to CRA.
> 
> Gerhard
OK, understand. Thanks for your comments, Gerhard. Actuallly, we solved
this issue by disabling netconsole and enabling busy poll. This is
indeed a quite rare scenario, but when it happens, it is a bit difficult
to figure out that this was the root cause.

Ding Meng
