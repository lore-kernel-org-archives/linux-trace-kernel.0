Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943400;
	b=Bg4v4dPbvDpMJ3eCUH8fyXjLv7GuiUS6076a4qkmd01tyOLIFNsdC2PHqRaPEwLRohon
	 5we8/A2uT8QqleXU+uZjpyOlrFYpmKTefS5npL2go2KtJhoOD8Xgc9rInB2BWYZ+bNW1z
	 GDATVhJcXbcc0M2iVn/7d1epvrAV6aYK24YsiQ5DFYEVRPDj18aZEN3SZnjtTK2P873Wj
	 G9pj9R8AhZ2o86wpsYDKChDM4OKHaCzuODIoBYirxX7IltkmtCKxaxMUPxLAn/4MGyohM
	 tgRELEc8sKQorUOOz9y8FPwYXPRcvhU1b8bhZmUIh8MJMc140g62/vbzj89hX93KR+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943400;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=vGM1K2NSc15XGesLdg3nUcKWLyHKsmjqOTyrE6hxi4I=;
	b=zOfWh6ICdEadpLIp2lcSgUTGtvqRpILWt2YhVOJVqFebMekZfhj4cwQq17RerkGNEmcn
	 ev6wBkLFNrL9XJIAqnyxCOP7L5HJKF4ZWbjETOqXyYysL8jRTj/Ywqgbv2EwjwCwmIpI6
	 GMP8tTEhTXChQV8jjwTQachnOQt4t+hzdvKzAzgBAoig7Q8pTUE3tcFgNWP5kByCKVUXD
	 R19Q/cwedhyGvyZo+qK+V6YySdncvpVmzBeJ4UtxNcQ2WMSg4tiTyRG/z6dfhpF/MaYTb
	 CgTXl+mo3yx+JMbiKXiXY50X/gwRUFlkb85VVSUB+J/EMqvT1uy2bKEodgGBMaEqHyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=nRzY+h9c;
	arc=none smtp.remote-ip=216.40.44.14
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5A0606A32C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 19:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC5A0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=nRzY+h9c
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id E6611140500;
	Tue, 17 Nov 2026 19:23:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 2E4A960010;
	Tue, 17 Nov 2026 19:23:11 +0000 (UTC)
Date: Tue, 17 Nov 2026 14:23:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Brian Norris <briannorris@chromium.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: 'select' GENERIC_TRACER, not 'depends'
Message-ID: <20261117142310.4f440b3f@gandalf.local.home>
In-Reply-To: <20261117142203.72235895@gandalf.local.home>
References: <20261116144652.1.Iecb63200dd245f62032a3b1f60ae78cc48868094@changeid>
	<sashiko-outbox-217828@kernel.org>
	<20261117085552.0e4ef272@gandalf.local.home>
	<avybp3O2zxcLozKB@google.com>
	<20261117142203.72235895@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 2E4A960010
X-Stat-Signature: wsxrytyh6w4paidzbtfrw8seir66mrnq
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19z3gQdCBCC47MhUkeHTtj4OUv19wy6jh0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=vGM1K2NSc15XGesLdg3nUcKWLyHKsmjqOTyrE6hxi4I=; b=nRzY+h9cWfaP/hE77Mg8SUgQyDBiJaA8PI9wJhiEK+oKWErgqMJvjzDks0DsrjgyGPPEjno+2sgBsFctTf/bLdkljOFv4Ovp+sKNgM7s0sGRIvi+KhWJhczfCdS7Cn9Tz92m9wvJpw/vB4AOsNzwj5SfeDkMCt+FdU9Khjn/+ec=
X-HE-Tag: 1794943391-223010
X-HE-Meta: U2FsdGVkX1+Pla5J9s1ByycP305UMcPZkqom6/Q22ZHfPbTY2jjzJotC0DrjR/SlTJEc/Q6fI62ZaTUeT/+kLqa+i7gmPzV2FJKxY0BNThoNeWcXXmazeBCafJuwWy08AgFUPCgAog3xsP1lcLqctYfeJ2kNFJ6mZVL24b8fm7Za2tn1ExqLC4aiSoMTRuFEe35Ye6IPyBoeLkKPkX/Bt7hRmO6ZX4Ruam3KnbxNjJirUNBdqOgq6nT+pa596pUTkaAPAVgFxBWchgPc4C71oF3Pz+XytUhaQfLiKr2b5l5FGCIR7KdQ6Z2UlGGpz4CsjWknq2q6W885VzSLGYM/ga9EMIVqNotwYWEWq4oy8gkt3oRuV/OAu3jcd4TsRsrK

On Tue, 17 Nov 2026 14:22:03 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

As it doesn't need to be visible let's still have:


> config ENABLE_EVENTS
> 	bool "Enable trace events"
	depends on !GENERIC_TRACER
	select TRACING
> 	help
> 	 Select this to enable trace events through out the kernel such as
> 	 scheduling, irq, kmalloc that can record to the tracefs ring
> 	 buffer data from within the subsystems the events exist in.


-- Steve
