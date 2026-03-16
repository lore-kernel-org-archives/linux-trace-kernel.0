Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDC6395D8F;
	Mon, 16 Mar 2026 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773663321; cv=none; b=in4ZWuWlZ0dQXX32c0LVZbk7Xrx3OxXehuBr3DLAl+ZENa6y+h9HJpShkMcndHQX2K+Q/cDLX2PnBBeqHNx892iEqFJ1AcCU8yhMdYscZgCfnrqyTIw5ATzkxuXSrxi3Vys2Z7agekxHVR4Mg3VW10uyjc30kk7zR+AXhY1BBBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773663321; c=relaxed/simple;
	bh=iCpj+ylBdb9gqteax0GWbhnuplFBmrqsW+wXPKRDvlY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XCenlLoFHKAkeQgJHMRhpAhyU6SfW0eE/zbmI3H7+JJA+sP/CCpQ9yyiWj66nvN6ornOPUUfSr4Xaj1BiNbT0TMCnma/y7oxQR0/BUJ64nQqTXIc7FWcG2cakNexwCBvl8SUMadgDVMn8KpnJjy98K9Y8I/0qluYOST6prabw8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ddqdPO8s; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ddqdPO8s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773663310; x=1774268110; i=markus.elfring@web.de;
	bh=mwE+BhJO+ZSCTsa2VSUDrmWOYckhJOwuX3gZsSrkVzM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ddqdPO8sxsN7PaXLkWTZviGeMOA4yfHKlDxzrsRJY6IzFKDKpUWcqOMKS1e/c3Rg
	 Oq2Mi8vBSEGNO4ah6PBwuvlvvwzJaL4X3vK4R0DjLaMmCV0Ddt1R4knoBDAe5m86B
	 jgS55nMvprduHEqxZtoVPI8v1U70amq6JmxQWCbrM+4IH4nFH3bjYFxHKAxcsrMOA
	 4q1zbos3Zv1SLikagP7uILEupDJSMWrgO/I0gpwtsKoJ7ygxWqM/bMjY+efjvYxcw
	 JLkYZvQ0TI84B7Tp7sllCCYa+/mrew6KbcoIg7dSoxDxs0Db0005MD2ar+o9c8oHE
	 tPuIpobpi4eIMtjWrA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBS71-1vtYfp0Sqd-002DOv; Mon, 16
 Mar 2026 13:15:10 +0100
Message-ID: <ecb34439-8695-4562-a9e7-9fac74323adb@web.de>
Date: Mon, 16 Mar 2026 13:15:08 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Josh Law <objecting@objecting.org>, linux-trace-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260314223425.142966-18-objecting@objecting.org>
Subject: Re: [PATCH v3 17/17] tools/bootconfig: fix fd leak in load_xbc_file()
 on fstat failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260314223425.142966-18-objecting@objecting.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tCfk/CiAk5oN0Os3JQ8of6KvRgyEpD2pXNfq6WHvpjRX7EZ91mK
 TXZRJ5DlkRCZ9LjPTkqsebyz8BRX6jelV+178cbPZGgu2V4ntYOnEleflZY6NpWDocOiR58
 SdvAIMjGX2qMiZACM4pprN9qmVJV+GeBkB4WUpl8w0B1CowQYJ+EWfA3gnxmLM/9qcduDpp
 0WrIaBcvZ9x//ikfPSyGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FTXY0x+Rty8=;IU1Wm3R8M7vjd9RDiCoykyl7vGG
 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

> If fstat() fails after open() succeeds, load_xbc_file() returns
> -errno without closing the file descriptor.  Add the missing close()
> call on the error path.

https://elixir.bootlin.com/linux/v7.0-rc3/source/tools/bootconfig/main.c#L=
139-L153

How do you think about to use a corresponding goto chain?


Would you like to  add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=
=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.0-rc4#n145

Regards,
Markus
