Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC7034DB57;
	Thu, 12 Mar 2026 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329880; cv=none; b=GnWM+0afUGZ4IczsCWrW/hLLJ77LlPqmiaH3K204XfhR012+5TOYZUxR+LNEyrVn3njyitDBxyYnXj7jKf16oyySevDk4A9t1KIxDQg1XpHI+uljY4YszaYz2bz5ME1f+LdsYigmi8jk77bmlszxR7eCzIlzxvZ3jff+lQ1mzaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329880; c=relaxed/simple;
	bh=3fna0GaOyuzpymRXL4PCjV70JqlqDNda0NUCMXfW130=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AvHkOl/52S/CRxRp1es50Owe39qspDxEOmIw8Qlre2UC4Kx7XbH0SBotr8P/66bZmI9yQoeu6oQ/S1ZlMmF6mY/iG/QRdJZDLzqNB+ePSGEW7qA3GWuD6W3pUp0pHyQlU5MFZ0BSzi9Z+7fH9vHIbl5pmYP5RfqzIu8F2bXSv9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kCdV4+XV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yw5mTYLy; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kCdV4+XV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yw5mTYLy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 61D3A7A0253;
	Thu, 12 Mar 2026 11:37:56 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 11:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773329876;
	 x=1773416276; bh=p3wVvuUWvB6gtk6vx0DT9c0n8H2MGMFhKi5d1tXz2e8=; b=
	kCdV4+XVU4Dg1Y0FMbl1rurmfjH5ydPu1Qlu26LP9eb3J1pY6maHiea8CafTAbaZ
	DN29lZuEXutq5mGatdRt6DCJ0cK2HkNgj/9sadznUdk6sKKwiGSmZdEtBNfMH735
	wCIfagIL727pSK22u0Pi74XJAKyOZw5u3Aeqgh8It3yhlioTVcvYJPHEIh4Qv/jK
	AyEbzxxZdIP2fMQFCW4sniySrU69czIxmRjLCpo75vvtOuAxHxqMQrhPeRiioXNo
	XnHH2SWcAvTKCjWaFU9VKLDx3V7Z4JiXWrtHORznEP/1psW4v9SmtYlG+yuEyhPf
	wJSKOvSWlOo5kq+3Q3O1rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773329876; x=
	1773416276; bh=p3wVvuUWvB6gtk6vx0DT9c0n8H2MGMFhKi5d1tXz2e8=; b=Y
	w5mTYLyE11TqtHXphkQr+dBLkPR919XCACiG4kvLItMOovEjWBOx4mqlipw6n5EK
	gOAHDmk7SGOEoBSgesAU+mDhXKNysG/d3QuN4G+3ZAUqRD0t3S9AR2j3mTuw0KCf
	TH05YQoU5iTwg7GdINGX9umpklwVbcHq4PDZ2sVLk9lE8wTkpy/FNLJk9dSVaF3b
	R1W4r7m7iayFcFw1se57L2Y95XOpZ2cTURgrUlQHmTToHc2a9jGmXhfj50UdB61Q
	PdGKPvoeMO8jN0YwWSjETYb1DwhDYKvXc047EhsglLK7fu70qOLWgYNZRY78zFyO
	3mbQh3EZFQXX7TPD6jTiQ==
X-ME-Sender: <xms:092yaXrhKrLtb0qUcNTxJhdP0pOgx9dKXuUYzKbOZcUEHLInDFB_nQ>
    <xme:092yacdw3OZJjbYskGoH_OHpzcuXhcGsoiJNRKibea7azlKVt7UE_eV812sqGzWPc
    jz-VoE1QnWAsIngAx5YWdsJrTl9G74U4QTMAC0nDloalaVRoKHPZJ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtg
    hpthhtohepmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhm
    pdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhope
    hvughonhhnvghfohhrthesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghrnhgusehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehmrgiisehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhuphht
    ohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:092yaZPd592jovhwdQkAtRWw1XybcZ49MrHaqbtuofDBEh1AJSGVeA>
    <xmx:092yaX08NIEX31yxDnWWqy5cQ54TgOcp4pDDTIwjfpNQQk2_oFm32A>
    <xmx:092yaVQqneo2oG1UWu4QF7MmMgyJNSuhev0lffEpWANpIqEQ14v39Q>
    <xmx:092yaanok7NwqXrEkZuywM4oFDEIA7saVEEx87zcyJH2I6TMofj8Kw>
    <xmx:1N2yaaYuvY0Te0_yMMGE1N1vHFgpSy8qRPiCk-0i4srYo31wphg7IabL>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CDBF8700065; Thu, 12 Mar 2026 11:37:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ajxbhlt1HaRc
Date: Thu, 12 Mar 2026 16:37:13 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Marc Zyngier" <maz@kernel.org>
Cc: "Vincent Donnefort" <vdonnefort@google.com>,
 "Arnd Bergmann" <arnd@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Oliver Upton" <oupton@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Message-Id: <ba6d88bf-639d-4fd3-82e6-21bcc02a5721@app.fastmail.com>
In-Reply-To: <86zf4d5b0w.wl-maz@kernel.org>
References: <20260312123601.625063-1-arnd@kernel.org>
 <20260312123601.625063-2-arnd@kernel.org> <abLCSk4ZZv1h6xFq@google.com>
 <d4fa3ee4-22ed-4ba3-afa3-4fe7a22b226c@app.fastmail.com>
 <86zf4d5b0w.wl-maz@kernel.org>
Subject: Re: [PATCH 2/3] tracing: add more symbols to whitelist
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Mar 12, 2026, at 16:21, Marc Zyngier wrote:
>
> I've decided to take this patch anyway, on top of Vincent's. Should a
> more generic solution arise, I can always drop both.
>

Ok, thanks!

FWIW, I came across two additional ones by now, and will keep
running more tests to see what else comes up:

--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -140,6 +140,7 @@ UNDEFINED_ALLOWLIST := memset alt_cb_patch_nops __x86 __ubsan __asan __kasan __g
 UNDEFINED_ALLOWLIST += __stack_chk_fail stackleak_track_stack __ref_stack __sanitizer
 UNDEFINED_ALLOWLIST += ftrace_likely_update __hwasan_load __hwasan_store __hwasan_tag_memory
 UNDEFINED_ALLOWLIST += warn_bogus_irq_restore warn_slowpath_fmt __stack_chk_guard
+UNDEFINED_ALLOWLIST += __kcsan __tsan
 UNDEFINED_ALLOWLIST := $(addprefix -e , $(UNDEFINED_ALLOWLIST))
 
 quiet_cmd_check_undefined = NM      $<


      Arnd
