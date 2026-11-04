Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818201;
	b=iPPyE0T7NVo+wpWhWGiEYhlPzNQKhPOT43rquixP3Dc4LmkMqJI9euTEc+BcPxcBBnAt
	 API/TiZg2BKQi/3QNLjNuWM0WqISRiT/b9hFwpX+KEk/7RfDK4rfLohsqEDYsxcClX1mn
	 578HkSCvduhEPCBd/42EW9vJjdQW++2XH8neLiIgls7ptkQW3QMHwEVpUCtLI+6oRIFkQ
	 sJU12DKTY5/y0A5klJLwDAx5eBRHJmSK88RokcvcOPs/Cxsv9G8sUC9lo507vJcYh/Yzf
	 laszwBHmi6SY03+4L7DHv4avoV4LVSIQ7sS2j2AJg2EsCCvJ4bCB7OmEKq0ICcwfuaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818201;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Status:X-Rspamd-Server:
	 X-Stat-Signature:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=yb4Pcg/80NOXT5tcn4Ga43SZPGRmdLbHuqgDWaFfW5w=;
	b=Estr8L8GPXtxPyezhoiruU6KoTP7IqH8CtsOE6QQ60V3tn6nTnyrnVOfvqkGEl1BL7Ng
	 jOX3+mvdFpo0LJE15+6AsWAjdm+85qiJhag0cmWbdl5bGsfmEKbimfBNyTcVpqmz+/p5O
	 U286n1gNzFoONSyn2WXi1xzhBNHXbQ4NnBG2KgsghfXLLEm28P+c4Fz3Ea/8Nuy/3wgkp
	 EFGjDMODpr7yoPQdgs0U7wRpXuaPUnGw1Zbvv9iA2AXFcuTnz0iteprNoNLzBndU5ciaD
	 bGkOgpz8AZajIMVYGL2KCf0wjoyQN3pKb3F9qjxeONqTRKjbqb1pzedKnY+ued3rwsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=OcasAPhy;
	arc=none smtp.remote-ip=216.40.44.16
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E2F606D805;
	Wed,  4 Nov 2026 18:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63E2F606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=OcasAPhy
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id F191AC0835;
	Wed,  4 Nov 2026 18:49:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id B84C420011;
	Wed,  4 Nov 2026 18:49:49 +0000 (UTC)
Date: Wed, 4 Nov 2026 13:49:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Vincent Donnefort <vdonnefort@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Xiang Gao <gxxa03070307@gmail.com>, Donggeun Yoo
 <donggeunyoo.kernel@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lorenzo Stoakes <ljs@kernel.org>, gao xu
 <gaoxu2@honor.com>, =?UTF-8?B?5Y2w6Zev?= <yinchuang1@xiaomi.com>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External Mail]Re: [PATCH v4 1/2] tracing: add ring-buffer
 memory usage statistics in tracefs
Message-ID: <20261104134948.081bdd81@gandalf.local.home>
In-Reply-To: <b8cd97542d5541b9b2e355671c9c3bb3@xiaomi.com>
References: <arJNSjKsJ3bK40dH@google.com>
	<20260924102755.02084435309be26f664e3333@kernel.org>
	<arTlRPvmR54Fa71o@google.com>
	<20260925100908.66c46353e5a2abeb73b1e15a@kernel.org>
	<cb0090dd1ad84a5b833e9323fd2b05d5@xiaomi.com>
	<51b25b1c996d4412a0c43d94acea98df@xiaomi.com>
	<20261014091839.11488a0c@gandalf.local.home>
	<4f9c82054c46459688d9a69df58293d1@xiaomi.com>
	<20261024080423.069948c9@fedora>
	<be9ca24989634d79b037f8ec1d16ac65@xiaomi.com>
	<auHacGXSJqCe983K@google.com>
	<b8cd97542d5541b9b2e355671c9c3bb3@xiaomi.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout06
X-Stat-Signature: 5z1mju8jmyrwzkepp11xb6jwjotrh6km
X-Rspamd-Queue-Id: B84C420011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19ymDa4NNV35de9DBEWHsvTFjmRBayBoj4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=yb4Pcg/80NOXT5tcn4Ga43SZPGRmdLbHuqgDWaFfW5w=; b=OcasAPhy7rMV92HLQNi9ceAvuGykJBBSAy0BmaTN7fIBB/kRSM8aaSFkUCJzatMSx/5EmX3BvawJVVli8b4Oxb+DoLKUVwDP3B0gHNyHKMM7jwtaNRsWxIJZ4XBW77dU/JRS2/0OY73A2xEs2/SYQ+DSpgJ7YLFZ0z9KazLOqB8=
X-HE-Tag: 1793818189-375442
X-HE-Meta: U2FsdGVkX19woAOCZzOAHUv/tOrFnZ/PGDCoMI2zV/U/aOPfzojAH9mPnUdkGuLovHTEVl115zdVYpK1Fs72aKw7sUliFSvpIuiXdiYsJfTK3tN3kUANnS1H/3smimoj6pgJBwbzp9rW9KFg++D1yCTMXLWNCpYEs6Qkuxzq/HTMRH26QCS79snoOC7hSw/gc7vOtThV9uNAq3LnzrL2PwmIpe9knQwtLVjl+9NOqbhJMegkP4RaSQlT81C8dZyxL6Yo7CVKS11tEz1Y2+cptGs0kdDiQGwqaKGP0m2fqFYsjK0/Zm6JIV2zg6iWql8efyQ39dtAJfpz/PwrX/T4rr2yhqgGLLE03itqm5UmcB4iIFagXv78vQ==

On Thu, 29 Oct 2026 02:37:46 +0000
=E9=AB=98=E7=BF=94 <gaoxiang17@xiaomi.com> wrote:

>=20
> Thanks, Vincent. That helps =E2=80=94 I'll target v7.5.
>=20

Can you send a new version, addressing everyone's comments and rebase on v7=
.4-rc1.

Thanks,

-- Steve
