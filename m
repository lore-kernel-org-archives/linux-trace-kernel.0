Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9056D47ECC5;
	Fri, 15 May 2026 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778842628; cv=none; b=V8LDHE9sNr+pjB5a7SyyqgmUkS038ykJD6gABsD2jI5atkIxFNVsTEsBmz0K6FvdIDfs+43Ck62GQFJqDlxP57iT1XSPyGVDYV5Kn4lPQ5v6djX6nYE/YzUtbpRJfyRgotghWjVpOS2+4RKFrqQJgQ20KRJrwLe0kFvuCdLIGe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778842628; c=relaxed/simple;
	bh=Mi5TAENImZJ0pSzr3ZOuSmifXZID/3DJdmfpa8V9eCw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nlPLD2MxzmGxK/5YyzVZvqGUe4tfWEo4XvS0pS0xiZVCtNd56aKdra/lIZN2rz5kZ9eYOrS7Q/zYck5OO1L1OzEYnvhphagaVaOJU78y2BPHCYCMIHOzIgUWZkD/pARel3eu/FSuQSgRxRtYDzUC0i+paOYmBl7x2H8HuK2n1Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=e1SMYR9F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JK7DoHYq; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="e1SMYR9F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JK7DoHYq"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B3662EC0064;
	Fri, 15 May 2026 06:57:05 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-04.internal (MEProxy); Fri, 15 May 2026 06:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778842625;
	 x=1778929025; bh=Ae6ebQFubppeJzbU+Tqlt+T9+M0fh0sKjZKsBQrXnaE=; b=
	e1SMYR9Fu3TWmeDo4trZqnzU76UElL1pgrm1pm1OwP6CKN8lIUvoAQBsyAEYTt2z
	4hkFdHaZmvXjP+cL1C5C2cdcmv827ew+PM1hNeRLiltbnMWzyI6t0ApdyK3V0doo
	kLiJa9WhuR7oBH033Vh/ftLg6j6lsCCleOkTFG4BPHCSFIbkXqkOuFQFmmPUeogp
	yIMSjVbuv7hI3KXWi5X/EaykMoyp2GFCGBNyGdhL5kgHBZXfqftelP2DuEPXYShV
	4Fk+AWbVeuHfrhvpB05OR46aFUKTqFxg23ZN1J0fQPbGIDUuBJwG17XZ2VjZFCCo
	fhdpiOGIlhCmaCn/7NEV5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778842625; x=
	1778929025; bh=Ae6ebQFubppeJzbU+Tqlt+T9+M0fh0sKjZKsBQrXnaE=; b=J
	K7DoHYqZDOslgQGRsLGB6FF9MYPw07NFfdPjCW+9TaCMiS6LMp2GJ+TGu5I0pIKe
	KLXFH31Ri/+tCKMvlhrsycd+pbLWXrJwvlWX39gz8t9y20pFs0NFVWscu6tDWfnQ
	uLeLb8AX13ZmgmxX8FAU4PfOFHd3ER+LTc/4u9oVCmL2fjsK6KHvV+exA3Fg6cIi
	drHgjJGUBof24DZUb0EdqESWD02rzduxAwofbQa5pNS93tXHb7y2KmYBKWxmkvgn
	y+MpgOeo7/x70V2P/ElHKE+upwkNjteXs46hNF0RW4HTlRsmTmVaxge5W2AAE35V
	lll+SwkJiohfzEM8Ne2oA==
X-ME-Sender: <xms:AfwGaiqVE-2dZYvHoJlMr1V805PFGdT0-I_aoUEIhs47No-HIAsRqw>
    <xme:AfwGarcSoVNd-L13TY9VBu3Vny43FisbR81ZlQ1vOsMz6zPHDQTmMJBFIy5hrhRP_
    PTyRDvKJm9XbE32lqZXfAn3YQuk-9lR8xIHCIsTK2Sw9xQkd6RDnKU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedtvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrd
    gtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphht
    thhopehvughonhhnvghfohhrthesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghrnh
    gusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrgiisehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnh
    grthhhrghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhtrhgrtg
    gvqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:AfwGap732DEiuEQDkYs9ocw4O4pF1uIQOZiM-ra9dAftwxjsgQKK-g>
    <xmx:AfwGanUYI4M3QW8cVgl8ApnMuYL9CbDqwDNyMZjy1CFy1XAKMSoQxQ>
    <xmx:AfwGahKEzShh2vvIVrLACRfQsfjJS9UXn6XPvIsLCh4jaXo3I_A-8g>
    <xmx:AfwGaptOjdhX8SzmTtHZkfRusFUEBuCLJr2aIB9FCXyD_97NFA95eg>
    <xmx:AfwGapNSU0sdXpGaZ06s71-mNURHKeUsB01NPPPNOmzhlWrvre99InTD>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2AFBA1060065; Fri, 15 May 2026 06:57:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AW_1xDmkHYEB
Date: Fri, 15 May 2026 12:56:44 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vincent Donnefort" <vdonnefort@google.com>,
 "Steven Rostedt" <rostedt@goodmis.org>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>, "Marc Zyngier" <maz@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Message-Id: <9668c1fb-2461-4ec4-afbf-80c051aa4064@app.fastmail.com>
In-Reply-To: <agWb6DvB1MdJ12cB@google.com>
References: <20260323105646.590718-1-arnd@kernel.org>
 <20260513105939.3bbdc174@gandalf.local.home> <agWb6DvB1MdJ12cB@google.com>
Subject: Re: [PATCH] tracing: samples: avoid warning about __aeabi_unwind_cpp_pr1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, May 14, 2026, at 11:54, Vincent Donnefort wrote:
> On Wed, May 13, 2026 at 10:59:39AM -0400, Steven Rostedt wrote:
>> 
>> Vincent,
>> 
>> Is this patch needed? That is, did it fall through the cracks?
>
> Yes, I believe it is! 
>
> Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

Just today, I came across yet another one:

Unexpected symbols in kernel/trace/simple_ring_buffer.o:
                 U __s390_indirect_jump_r1
                 U __s390_indirect_jump_r10
                 U __s390_indirect_jump_r14
                 U __s390_indirect_jump_r2
                 U __s390_indirect_jump_r5
                 U __s390_indirect_jump_r7
                 U __s390_indirect_jump_r8
                 U __s390_indirect_jump_r9

I'll send a replacement patch that addresses both, since the
old one hasn't been applied yet.

      Arnd
